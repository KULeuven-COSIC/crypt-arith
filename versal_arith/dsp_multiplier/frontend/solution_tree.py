# core/frontend_solution_tree.py
"""The solution tree: the solver's search result for one multiplier
problem, as a tree of decomposition nodes. A leaf is a TilingNode (DSP
tiles + leftover LUT area); the other node types recursively split a
larger problem into smaller ones (Karatsuba-2, Karatsuba-3, or a grid of
same-size squares for a rectangular board).
"""
from __future__ import annotations
from dataclasses import dataclass

from typing import Union

from dsp_multiplier.frontend.datamodel import Signedness, ResolvedPlacement, CellMask

@dataclass(frozen=True)
class TilingNode:
    """A leaf: one sub-board tiled directly with DSP placements, plus
    whatever's left over for LUTs."""

    # -- what sub-board problem this is (also part of the memoization key) --
    a_width: int
    b_width: int
    a_signedness: Signedness
    b_signedness: Signedness

    # -- which DSP tiles are placed --
    placements: tuple[ResolvedPlacement, ...]   # empty tuple = pure-LUT leaf
    covered: CellMask                            # cells these tiles cover

    def __post_init__(self):
        from dsp_multiplier.frontend.mask_ops import make_empty_mask, mask_union, mask_intersects
        acc = make_empty_mask(self.a_width, self.b_width)
        for p in self.placements:
            if mask_intersects(acc, p.coverage):
                raise ValueError("placements overlap inside a TilingNode")
            acc = mask_union(acc, p.coverage)
        if acc.rows != self.covered.rows:
            raise ValueError("covered does not match union of placements")


@dataclass(frozen=True)
class Karatsuba2Node:
    """2-way Karatsuba split: A/B each cut into a low/high half, three
    sub-products (low, mid = the cross term, high) combined by shifting
    and summing."""

    a_width: int
    b_width: int
    a_signedness: Signedness
    b_signedness: Signedness
    k_a: int
    k_b: int
    low:  "SolutionNode"
    mid:  "SolutionNode"
    high: "SolutionNode"


@dataclass(frozen=True)
class Karatsuba3Node:
    """3-way Karatsuba: A/B each split into three segments, 6 sub-products,
    12 product words all summed.

    Convention: shift amount = k_a, segment widths = (k_a, k_a, a_width - 2*k_a),
    only the top segments A2/B2 carry the parent's sign.
    Direction of the differences: high-minus-low on the A side, low-minus-high
    on the B side --
        m01 = (A1-A0)(B0-B1)
        m02 = (A2-A0)(B0-B2)
        m12 = (A2-A1)(B1-B2)
    so the heap sees +M rather than -M and never needs negation."""
    a_width: int
    b_width: int
    a_signedness: Signedness
    b_signedness: Signedness
    k_a: int
    k_b: int
    d0:  "SolutionNode"   # A0*B0
    d1:  "SolutionNode"   # A1*B1
    d2:  "SolutionNode"   # A2*B2
    m01: "SolutionNode"   # (A1-A0)(B0-B1)
    m02: "SolutionNode"   # (A2-A0)(B0-B2)
    m12: "SolutionNode"   # (A2-A1)(B1-B2)


@dataclass(frozen=True)
class GridNode:
    """"Square tiling" decomposition of a rectangle (a_width != b_width):
    treat the short side as the square edge length tile_width, cut as many
    tile_width x tile_width squares (children) as fit along the long side,
    and put whatever doesn't divide evenly into one more piece (remainder,
    which may be a TilingNode leaf or another level of GridNode recursion).
    Unlike K2/K3 there's no subtraction/preadder here -- it's purely
    position-weighted addition.

    Convention (rectangular K2/Toom-2.5 not supported yet, so a
    non-square board always goes through this instead):
      - a_is_chunked=True  -> the long side is A, and each child spans the
        full b_width (tile_width == b_width). a_is_chunked=False is the
        mirror image.
      - remainder always sits at the high (MSB) end of the long side:
        children[0..N-1] run low-to-high, remainder (if present) comes
        last. That way the two special cases -- "irregular shape" and
        "sign needs the parent's real sign" -- land on the same piece:
        the squares in `children` are always regular tile_width x
        tile_width blocks, and the axis that got split is always
        unsigned on those; the axis that was never split (untouched,
        naturally holding the true MSB) inherits the parent's sign
        unchanged.
    """
    a_width: int
    b_width: int
    a_signedness: Signedness
    b_signedness: Signedness

    tile_width: int                 # edge length of each square = the short side's width
    a_is_chunked: bool               # True: long side is A; False: long side is B

    children: tuple["SolutionNode", ...]   # N squares of tile_width x tile_width
    remainder: "SolutionNode | None"        # leftover that didn't divide evenly; None if it divided exactly

    def __post_init__(self):
        long_width  = self.a_width if self.a_is_chunked else self.b_width
        short_width = self.b_width if self.a_is_chunked else self.a_width
        if short_width != self.tile_width:
            raise ValueError(
                f"GridNode: short side {short_width} should equal tile_width "
                f"{self.tile_width}"
            )
        for c in self.children:
            if c.a_width != self.tile_width or c.b_width != self.tile_width:
                raise ValueError(
                    f"GridNode: square children should be {self.tile_width}x"
                    f"{self.tile_width}, got {c.a_width}x{c.b_width}"
                )
        rem_width = long_width - self.tile_width * len(self.children)
        if rem_width < 0:
            raise ValueError("GridNode: more children than fit along the long side")
        if rem_width == 0:
            if self.remainder is not None:
                raise ValueError("GridNode: long side divides evenly, remainder should be None")
        else:
            if self.remainder is None:
                raise ValueError("GridNode: long side doesn't divide evenly, remainder cannot be None")
            rem_long  = (self.remainder.a_width if self.a_is_chunked
                        else self.remainder.b_width)
            rem_short = (self.remainder.b_width if self.a_is_chunked
                        else self.remainder.a_width)
            if rem_long != rem_width or rem_short != self.tile_width:
                raise ValueError(
                    f"GridNode: remainder shape should be "
                    f"{'a' if self.a_is_chunked else 'b'}-axis {rem_width}, "
                    f"got a={self.remainder.a_width} b={self.remainder.b_width}"
                )


# All four node classes are defined now, so the union alias can follow.
SolutionNode = Union[TilingNode, Karatsuba2Node, Karatsuba3Node, GridNode]

def children_of(node: SolutionNode) -> tuple:
    """Uniformly fetch a node's children: 0 for a leaf, 3 for K2, 6 for K3,
    N(+1) for Grid. Adding e.g. Toom later only needs a change here --
    every recursive caller stays untouched."""
    if isinstance(node, TilingNode):
        return ()
    if isinstance(node, Karatsuba3Node):
        return (node.d0, node.d1, node.d2, node.m01, node.m02, node.m12)
    if isinstance(node, GridNode):
        tail = (node.remainder,) if node.remainder is not None else ()
        return node.children + tail
    return (node.low, node.mid, node.high)


def dsp_count(node: SolutionNode) -> int:
    """Total DSPs used across the whole (sub)tree."""
    if isinstance(node, TilingNode):
        return sum(p.resources.dsp for p in node.placements)
    return sum(dsp_count(c) for c in children_of(node))


def _render_board(node) -> str:
    """Render a TilingNode leaf as an ASCII board.
    Row = A bit (a, top-to-bottom 0..a_width-1), column = B bit (b, left-to-right).
    DSP tile -> uppercase letter A B C...; LUT tile -> lowercase letter a b c...; empty -> '.'."""
    # Local import to avoid a top-level circular import.
    from dsp_multiplier.frontend.mask_ops import mask_complement_within_board
    from dsp_multiplier.frontend.exact_cost import greedy_rectangle_partition

    a_w, b_w = node.a_width, node.b_width

    # Initialize the board: a_w rows, b_w columns, all '.'
    grid = [["."] * b_w for _ in range(a_w)]

    # 1) Draw the DSP tiles: one uppercase letter per placement.
    for idx, p in enumerate(node.placements):
        mark = chr(ord("A") + idx % 26)
        for a, row in enumerate(p.coverage.rows):
            for b in range(b_w):
                if row & (1 << b):
                    grid[a][b] = mark

    # 2) Draw the LUT tiles: greedily rectangle-partition the leftover area,
    #    one lowercase letter per rectangle.
    residual = mask_complement_within_board(node.covered)
    rects = greedy_rectangle_partition(residual)
    for idx, r in enumerate(rects):
        mark = chr(ord("a") + idx % 26)
        for a in range(r.a0, r.a0 + r.a_width):
            for b in range(r.b0, r.b0 + r.b_width):
                grid[a][b] = mark

    # 3) Join into a string (each row's columns left-to-right are b=0,1,2,...).
    lines = ["".join(row) for row in grid]
    legend = (f"    DSP={len(node.placements)}(A..)  "
              f"LUT={len(rects)}(a..)  ['.'=uncovered]")
    return legend + "\n" + "\n".join("    " + line for line in lines)


def describe(node: SolutionNode, indent: int = 0, visualize: bool = False) -> str:
    """Render the tree as indented text, one line per node plus its DSP
    count; pass visualize=True to also draw each leaf as an ASCII board."""
    pad = "  " * indent
    if isinstance(node, TilingNode):
        s = (f"{pad}Tiling {node.a_width}x{node.b_width} "
             f"[{node.a_signedness.value[0]}{node.b_signedness.value[0]}] "
             f"tiles={len(node.placements)} dsp={dsp_count(node)}\n")
        if visualize:
            s += _render_board(node) + "\n"
        return s

    if isinstance(node, Karatsuba3Node):
        s = (f"{pad}K3 {node.a_width}x{node.b_width} "
             f"split=({node.k_a},{node.k_b}) dsp={dsp_count(node)}\n")
        for c in children_of(node):
            s += describe(c, indent + 1, visualize)
        return s

    if isinstance(node, GridNode):
        axis = "a" if node.a_is_chunked else "b"
        s = (f"{pad}Grid {node.a_width}x{node.b_width} "
             f"tile={node.tile_width} axis={axis} "
             f"squares={len(node.children)} "
             f"remainder={'yes' if node.remainder is not None else 'no'} "
             f"dsp={dsp_count(node)}\n")
        for c in children_of(node):
            s += describe(c, indent + 1, visualize)
        return s

    s = (f"{pad}K2 {node.a_width}x{node.b_width} "
         f"split=({node.k_a},{node.k_b}) dsp={dsp_count(node)}\n")
    # Keep threading `visualize` through, or the leaves below won't render.
    s += describe(node.low,  indent + 1, visualize)
    s += describe(node.mid,  indent + 1, visualize)
    s += describe(node.high, indent + 1, visualize)
    return s


def _tile_kind(p) -> str:
    """Classify a placement: geometry first (a chain's narrow side is only
    ever 26/27, big tiles start at 44), then split further by dsp count.
    More reliable than dsp count alone -- Chain3/K2 etc. can collide on dsp
    count."""
    r = p.bounding_rect
    d = p.resources.dsp
    narrow = min(r.a_width, r.b_width)      # a chain's narrow side is always 26 or 27
    if narrow <= 27:
        return "DSP58" if d == 1 else f"Chain{d}"
    return {3: "K2", 4: "Toom2.5", 6: "K3"}.get(d, f"?dsp{d}")


def placement_listing(node: TilingNode) -> str:
    """Print one line per block: kind, position, size; sorted by
    (kind, b0, a0) so blocks in the same row end up adjacent. Ends with the
    list of leftover LUT rectangles."""
    from dsp_multiplier.frontend.mask_ops import mask_complement_within_board
    from dsp_multiplier.frontend.exact_cost import greedy_rectangle_partition

    def key(p):
        r = p.bounding_rect
        return (_tile_kind(p), r.b0, r.a0)

    lines = []
    for p in sorted(node.placements, key=key):
        r = p.bounding_rect
        lines.append(
            f"  {_tile_kind(p):8s} @ a[{r.a0}:{r.a0 + r.a_width}] "
            f"b[{r.b0}:{r.b0 + r.b_width}]  "
            f"({r.a_width}x{r.b_width}, dsp={p.resources.dsp})"
        )

    residual = mask_complement_within_board(node.covered)
    rects = greedy_rectangle_partition(residual)
    for r in rects:
        lines.append(
            f"  {'LUT':8s} @ a[{r.a0}:{r.a0 + r.a_width}] "
            f"b[{r.b0}:{r.b0 + r.b_width}]  ({r.a_width}x{r.b_width})"
        )
    head = (f"  -- {len(node.placements)} DSP placement(s),"
            f" {len(rects)} LUT rectangle(s) --")
    return head + "\n" + "\n".join(lines)
