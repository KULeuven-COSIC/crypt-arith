# core/frontend_cost.py
"""Cost model: recursively price a solution tree's LUT usage, bottom-up.
Each node type (TilingNode leaf, Karatsuba-2/3, Grid) has its own "merge"
function that combines its children's already-computed CostResults with
that node's own merge overhead (the compressor tree summing the children's
product words, plus any preadder for a difference term).
"""
from __future__ import annotations
from dataclasses import dataclass

from dsp_multiplier.frontend.datamodel import Signedness
from dsp_multiplier.frontend.solution_tree import (TilingNode, Karatsuba2Node, Karatsuba3Node,
                          GridNode, SolutionNode, children_of, dsp_count)
from dsp_multiplier.frontend.exact_cost import exact_cost, compare_sign_routes

@dataclass(frozen=True)
class CostResult:
    lut_total: float          # this subtree's total LUT count
    product_width: int        # the output product word's width (local, lsb starts at 0)
    product_signed: bool      # whether the output product word is signed
    sign_mode: str = "extend" # which sign-handling route this node's heap chose

def _node_output_signed(node: SolutionNode) -> bool:
    """Whether this node's output product is signed (true if either input is)."""
    return (node.a_signedness is Signedness.SIGNED
            or node.b_signedness is Signedness.SIGNED)

def _make_signedness_checker_for_node(node: TilingNode):
    """Build the `rect_signedness` callback exact_cost() needs for one
    TilingNode: a residual rectangle is signed on a side only if that
    side's operand is signed AND the rectangle touches the board's MSB edge."""
    node_a_signed = (
        node.a_signedness is Signedness.SIGNED
    )
    node_b_signed = (
        node.b_signedness is Signedness.SIGNED
    )

    def rect_signedness(rect):
        rect_a_signed = (
            node_a_signed
            and rect.a0 + rect.a_width == node.a_width
        )

        rect_b_signed = (
            node_b_signed
            and rect.b0 + rect.b_width == node.b_width
        )

        return rect_a_signed, rect_b_signed

    return rect_signedness


def _tiling_cost(node: TilingNode) -> CostResult:
    """Exact LUT cost of a leaf: DSP placements' intrinsic LUTs plus the
    leftover area's compressor-tree cost."""
    lut, sign_mode = exact_cost(
        node.covered,
        node.placements,
        board_a_width=node.a_width,
        board_b_width=node.b_width,
        rect_signedness=_make_signedness_checker_for_node(node),
    )
    return CostResult(
        lut_total=lut,
        product_width=node.a_width + node.b_width,
        product_signed=_node_output_signed(node),
        sign_mode=sign_mode,
    )

def _preadder_lut(mid_node: SolutionNode) -> float:
    """Rough estimate of the subtractor cost forming a Karatsuba
    difference term (dA, dB): about 1 LUT per bit of each."""
    return float(mid_node.a_width + mid_node.b_width)


def karatsuba_merge(node: Karatsuba2Node, lo: CostResult,
                    mi: CostResult, hi: CostResult) -> CostResult:
    """Given the three children's CostResults, compute only the merge
    overhead. Doesn't recurse.

    A child's sign_mode and the parent's are independent decisions: however
    a child computed its internal heap, what it hands back is a single
    product_width-bit two's-complement word, and the parent doesn't care
    about the process."""
    assert node.k_a == node.k_b, "this merge requires k_a == k_b"
    k = node.k_a
    heap_width = node.a_width + node.b_width

    # the 5 product words to feed into the parent's heap: (lsb, width, signed)
    words = [
        (0,     lo.product_width, lo.product_signed),
        (k,     lo.product_width, lo.product_signed),
        (k,     hi.product_width, hi.product_signed),
        (2 * k, hi.product_width, hi.product_signed),
        (k,     mi.product_width, mi.product_signed),
    ]

    cmp_total, sign_mode = compare_sign_routes(words, heap_width)

    total = (lo.lut_total + mi.lut_total + hi.lut_total
             + cmp_total + _preadder_lut(node.mid))
    return CostResult(float(total), heap_width,
                      _node_output_signed(node), sign_mode)


def _karatsuba_cost(node: Karatsuba2Node) -> CostResult:
    """Recursively cost a Karatsuba-2 node: cost its three children, then merge."""
    return karatsuba_merge(node, cost_of(node.low),
                           cost_of(node.mid), cost_of(node.high))

def karatsuba3_merge(node: Karatsuba3Node,
                     d0: CostResult, d1: CostResult, d2: CostResult,
                     m01: CostResult, m02: CostResult,
                     m12: CostResult) -> CostResult:
    """Given the 6 children's CostResults, compute only the merge overhead.
    Doesn't recurse.

    Because the differences were taken in the (A_hi - A_lo)(B_lo - B_hi)
    direction, all three M terms are additions, so all 12 words here go
    straight into the heap -- no negation or compensating constant needed."""
    assert node.k_a == node.k_b, "this merge requires k_a == k_b"
    k = node.k_a
    heap_width = node.a_width + node.b_width

    # 12 product words: (lsb, width, signed), low to high
    words = [
        # 2^0  : D0
        (0,     d0.product_width,  d0.product_signed),
        # 2^k  : D0 + D1 + M01
        (k,     d0.product_width,  d0.product_signed),
        (k,     d1.product_width,  d1.product_signed),
        (k,     m01.product_width, m01.product_signed),
        # 2^2k : D0 + D1 + D2 + M02
        (2 * k, d0.product_width,  d0.product_signed),
        (2 * k, d1.product_width,  d1.product_signed),
        (2 * k, d2.product_width,  d2.product_signed),
        (2 * k, m02.product_width, m02.product_signed),
        # 2^3k : D1 + D2 + M12
        (3 * k, d1.product_width,  d1.product_signed),
        (3 * k, d2.product_width,  d2.product_signed),
        (3 * k, m12.product_width, m12.product_signed),
        # 2^4k : D2
        (4 * k, d2.product_width,  d2.product_signed),
    ]

    cmp_total, sign_mode = compare_sign_routes(words, heap_width)

    kids = (d0, d1, d2, m01, m02, m12)
    pre = (_preadder_lut(node.m01) + _preadder_lut(node.m02)
           + _preadder_lut(node.m12))          # 3 pairs of differences, each dA+dB
    total = sum(c.lut_total for c in kids) + cmp_total + pre
    return CostResult(float(total), heap_width,
                      _node_output_signed(node), sign_mode)


def _karatsuba3_cost(node: Karatsuba3Node) -> CostResult:
    """Recursively cost a Karatsuba-3 node: cost its six children, then merge."""
    return karatsuba3_merge(
        node, cost_of(node.d0), cost_of(node.d1), cost_of(node.d2),
        cost_of(node.m01), cost_of(node.m02), cost_of(node.m12))


def grid_merge(node: GridNode, child_crs: tuple[CostResult, ...],
              remainder_cr: "CostResult | None") -> CostResult:
    """Given the CostResults for N squares (+ possibly 1 remainder),
    compute only this layer's merge overhead -- even when the remainder is
    itself a GridNode, it's treated as one already-resolved opaque word.
    Unlike karatsuba_merge/karatsuba3_merge: there's no subtraction/
    preadder here, it's purely N(+1) product words summed at offsets of
    i*tile_width, so _preadder_lut is never called.

    This is the "seal one heap per layer" cost model. grid_chain_cost
    below supersedes it (fewer heap round-trips, more accurate) -- this is
    kept only as a reference point to compare against; cost_of/
    sign_mode_map both go through grid_chain_cost, not this."""
    heap_width = node.a_width + node.b_width
    k = node.tile_width

    words = [
        (i * k, cr.product_width, cr.product_signed)
        for i, cr in enumerate(child_crs)
    ]
    if remainder_cr is not None:
        words.append(
            (len(child_crs) * k, remainder_cr.product_width,
             remainder_cr.product_signed)
        )

    cmp_total, sign_mode = compare_sign_routes(words, heap_width)

    total = sum(cr.lut_total for cr in child_crs) + cmp_total
    if remainder_cr is not None:
        total += remainder_cr.lut_total

    return CostResult(float(total), heap_width,
                      _node_output_signed(node), sign_mode)


def _grid_cost_layered(node: GridNode) -> CostResult:
    """The old model: each layer of GridNode runs grid_merge on its own,
    with a nested remainder first recursed into as an independent subtree
    to get its own cost, then fed in as one opaque word to the layer
    above. Kept only for comparison against grid_chain_cost, below."""
    child_crs = tuple(_grid_cost_layered(c) if isinstance(c, GridNode)
                      else cost_of(c) for c in node.children)
    remainder = node.remainder
    remainder_cr = (
        (_grid_cost_layered(remainder) if isinstance(remainder, GridNode)
         else cost_of(remainder))
        if remainder is not None else None
    )
    return grid_merge(node, child_crs, remainder_cr)


def _flatten_grid_chain(node: GridNode, leaf_cost):
    """Flatten the whole (possibly many levels deep) Grid chain headed by
    `node`: only recurse-flatten weights between GridNodes (accumulating
    i*tile_width layer by layer); as soon as a non-Grid subtree
    (Tiling/K2/K3) is hit, treat it as an opaque word and stop there --
    call leaf_cost(child) to get its own layered cost, without flattening
    further into it (this only applies to Grid, it never crosses into a
    K2/K3 subtree).

    leaf_cost is a callback rather than hardcoding cost_of: sign_mode_map
    needs to register each leaf/opaque subtree's own sign_mode as a side
    effect while computing its cost, so it passes its own walk() as
    leaf_cost; grid_chain_cost only wants the result, so it passes cost_of
    directly.

    Returns (words, lut_total): words=[(weight, width, signed), ...] for
    compare_sign_routes; lut_total is the sum of every opaque leaf's LUTs
    (not yet including this chain's own cmp)."""
    words: list[tuple[int, int, bool]] = []
    lut_total = 0.0

    def place(child, offset):
        nonlocal lut_total
        if isinstance(child, GridNode):
            walk_layer(child, offset)
        else:
            cr = leaf_cost(child)
            words.append((offset, cr.product_width, cr.product_signed))
            lut_total += cr.lut_total

    def walk_layer(n: GridNode, base: int):
        for i, c in enumerate(n.children):
            place(c, base + i * n.tile_width)
        if n.remainder is not None:
            place(n.remainder, base + len(n.children) * n.tile_width)

    walk_layer(node, 0)
    return words, lut_total


def _grid_chain_walk(node: GridNode, leaf_cost) -> CostResult:
    words, lut_total = _flatten_grid_chain(node, leaf_cost)
    heap_width = node.a_width + node.b_width
    cmp_total, sign_mode = compare_sign_routes(words, heap_width)
    return CostResult(float(lut_total + cmp_total), heap_width,
                      _node_output_signed(node), sign_mode)


def grid_chain_cost(node: GridNode) -> CostResult:
    """The cost of the whole nested Grid chain headed by `node`, computed
    by flattening it into one final heap -- matching what the walker
    (core/walker.py) actually generates now (sealed only once). More
    accurate than layer-by-layer grid_merge/_grid_cost_layered: what's
    saved is the cmp LUT cost of the N-1 round trips of "compress ->
    resolve into a word -> feed into the next layer's heap" themselves,
    not a simple linear sum, so the two numbers can only be compared after
    computing the whole chain each way, never subtracted layer by layer.
    """
    return _grid_chain_walk(node, cost_of)


def cost_of(node: SolutionNode) -> CostResult:
    """The main entry point: recursively price any solution (sub)tree,
    dispatching to the right cost function for its node type."""
    if isinstance(node, TilingNode):
        return _tiling_cost(node)
    if isinstance(node, Karatsuba3Node):
        return _karatsuba3_cost(node)
    if isinstance(node, GridNode):
        return grid_chain_cost(node)
    return _karatsuba_cost(node)

# ---------------------------------------------------------------------------
# Tree printout with cost: one bottom-up pass, each node computed exactly once
# ---------------------------------------------------------------------------
def _emit_with_cost(node, indent, out, stats, *, absorbed=False) -> CostResult:
    """absorbed=True only makes sense for a GridNode: it means this Grid
    node is a continuation of some ancestor Grid node's flattened chain,
    and its own cmp was already computed as part of that flattening --
    here it's only printed to keep the solution tree's shape visible, and
    isn't counted again into `stats` (see the note atop grid_chain_cost --
    nested Grid layers no longer each seal their own heap)."""
    pad = "  " * indent

    if isinstance(node, TilingNode):
        cr = _tiling_cost(node)
        stats["leaf"] += cr.lut_total
        head = (f"{pad}Tiling {node.a_width}x{node.b_width} "
                f"[{node.a_signedness.value[0]}{node.b_signedness.value[0]}] "
                f"tiles={len(node.placements)} dsp={dsp_count(node)}")
        out.append(f"{head:<50s} LUT={cr.lut_total:>8.0f}  [{cr.sign_mode}]")
        return cr

    if isinstance(node, Karatsuba3Node):
        slot = len(out)
        out.append(None)
        kids = [_emit_with_cost(c, indent + 1, out, stats)
                for c in children_of(node)]
        cr = karatsuba3_merge(node, *kids)
        own = cr.lut_total - sum(c.lut_total for c in kids)
        pre = (_preadder_lut(node.m01) + _preadder_lut(node.m02)
               + _preadder_lut(node.m12))
        stats["merge"] += own
        head = (f"{pad}K3 {node.a_width}x{node.b_width} "
                f"split=({node.k_a},{node.k_b}) dsp={dsp_count(node)}")
        out[slot] = (f"{head:<50s} LUT={cr.lut_total:>8.0f}  [{cr.sign_mode}]"
                     f"  own={own:.0f} (cmp {own - pre:.0f} + pre {pre:.0f})")
        return cr

    if isinstance(node, GridNode):
        slot = len(out)
        out.append(None)
        kid_crs = [_emit_with_cost(c, indent + 1, out, stats,
                                   absorbed=isinstance(c, GridNode))
                  for c in node.children]
        rem_cr = None
        if node.remainder is not None:
            rem_cr = _emit_with_cost(node.remainder, indent + 1, out, stats,
                                     absorbed=isinstance(node.remainder, GridNode))
        all_crs = kid_crs + ([rem_cr] if rem_cr is not None else [])

        axis = "a" if node.a_is_chunked else "b"
        head = (f"{pad}Grid {node.a_width}x{node.b_width} "
                f"tile={node.tile_width} axis={axis} dsp={dsp_count(node)}")

        if absorbed:
            # cmp was already computed as part of the ancestor's flatten
            # pass: the LUT figure here is only "this sub-chain's leaf
            # total" for the level above to roll up, it doesn't run
            # compare_sign_routes separately and isn't added to
            # stats["merge"], to avoid double-counting.
            cr = CostResult(sum(c.lut_total for c in all_crs),
                            node.a_width + node.b_width,
                            _node_output_signed(node), "n/a")
            out[slot] = (f"{head:<50s} LUT={cr.lut_total:>8.0f}  [merged]"
                         f"  own=0 (folded into the flatten above, see grid_chain_cost)")
        else:
            words, lut_total = _flatten_grid_chain(node, cost_of)
            heap_width = node.a_width + node.b_width
            cmp_total, sign_mode = compare_sign_routes(words, heap_width)
            cr = CostResult(float(lut_total + cmp_total), heap_width,
                            _node_output_signed(node), sign_mode)
            stats["merge"] += cmp_total
            out[slot] = (f"{head:<50s} LUT={cr.lut_total:>8.0f}  [{cr.sign_mode}]"
                         f"  own={cmp_total:.0f} "
                         f"(whole Grid chain flattened into one heap, pure cmp)")
        return cr

    # a parent's cost depends on its children -> reserve a slot, backfill once they're done
    slot = len(out)
    out.append(None)

    lo = _emit_with_cost(node.low,  indent + 1, out, stats)
    mi = _emit_with_cost(node.mid,  indent + 1, out, stats)
    hi = _emit_with_cost(node.high, indent + 1, out, stats)

    cr = karatsuba_merge(node, lo, mi, hi)
    own = cr.lut_total - (lo.lut_total + mi.lut_total + hi.lut_total)
    pre = _preadder_lut(node.mid)
    stats["merge"] += own

    head = (f"{pad}K2 {node.a_width}x{node.b_width} "
            f"split=({node.k_a},{node.k_b}) dsp={dsp_count(node)}")
    out[slot] = (f"{head:<50s} LUT={cr.lut_total:>8.0f}  [{cr.sign_mode}]"
                 f"  own={own:.0f} (cmp {own - pre:.0f} + pre {pre:.0f})")
    return cr


def describe_with_cost(node: SolutionNode, indent: int = 0):
    """Print the solution tree, LUT count on every line. Returns (text,
    the root's CostResult).

    LUT=  the whole subtree's running total (a K2 node already includes its three children)
    own=  this K2 node's own overhead = merge heap's cmp + mid's subtractor
    [..]  which sign-handling route this node's final heap chose (extend / removal)"""
    out, stats = [], {"leaf": 0.0, "merge": 0.0}
    cr = _emit_with_cost(node, indent, out, stats)
    out.append("  " * indent
               + f"-- leaf total {stats['leaf']:.0f}"
                 f" + merge layers {stats['merge']:.0f}"
                 f" = {cr.lut_total:.0f} LUT --")
    return "\n".join(out), cr

# ---------------------------------------------------------------------------
# For implementation use: recompute each node's sign_mode
# ---------------------------------------------------------------------------
def sign_mode_map(node: SolutionNode) -> dict[int, str]:
    """Runs the cost computation bottom-up once, just to collect which
    sign-handling route each node chose. Returns {id(node): "extend"/"removal"}.

    Why this can be recomputed after the fact: sign_mode is a pure
    function of the node -- compare_sign_routes only looks at that node's
    own batch of product words, independent of the search process or any
    sibling node. So what gets computed here is guaranteed to match
    whatever solve() chose at the time, and doesn't need to be stored in
    the bundle.

    Uses id() rather than the node itself as the key: a TilingNode is
    hashable, but hashing it means hashing every placement and coverage
    mask, too slow; also solve's memoization makes d0/d1 share the same
    object, and id() naturally deduplicates that for free.

    The GridNode branch uses the same flattening logic as grid_chain_cost
    (_flatten_grid_chain): sign_mode is only registered on the outermost
    GridNode of a chain -- nested Grid layers inside the chain no longer
    each seal their own heap (see Walker._implement_grid), so they have no
    independent sign_mode to register, and Walker never looks one up for
    them; non-Grid leaves/opaque subtrees within the chain still register
    their own, since their own heaps still exist."""
    modes: dict[int, str] = {}
    cache: dict[int, CostResult] = {}

    def walk(n) -> CostResult:
        hit = cache.get(id(n))
        if hit is not None:
            return hit                      # each object computed only once

        if isinstance(n, TilingNode):
            cr = _tiling_cost(n)
        elif isinstance(n, GridNode):
            cr = _grid_chain_walk(n, walk)
        else:
            # children_of's order strictly matches the two merge functions'
            # parameter order: K2 -> (low, mid, high), K3 -> (d0, d1, d2, m01, m02, m12)
            kids = [walk(c) for c in children_of(n)]
            merge = (karatsuba3_merge if isinstance(n, Karatsuba3Node)
                     else karatsuba_merge)
            cr = merge(n, *kids)

        cache[id(n)] = cr
        modes[id(n)] = cr.sign_mode
        return cr

    walk(node)
    return modes
