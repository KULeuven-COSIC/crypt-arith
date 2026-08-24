# core/reports.py
"""LUT reports for DSP-multiplier frontend solutions."""
from __future__ import annotations
from dataclasses import dataclass
from typing import Union

from dsp_multiplier.frontend.datamodel import Rect, Signedness
from dsp_multiplier.frontend.solution_tree import (TilingNode, Karatsuba3Node, GridNode,
                          SolutionNode, children_of)
from dsp_multiplier.frontend.mask_ops import mask_complement_within_board

# =============================================================================
# LUT report
# =============================================================================


@dataclass(frozen=True)
class TilingLutReport:
    """Corresponds to one TilingNode leaf: the LUT rectangles cut from its
    own residual area."""
    a_width: int
    b_width: int
    a_signed: bool
    b_signed: bool
    rects: tuple[Rect, ...]        # LUT rectangles, in this sub-board's local coordinates
    # Record of off-board tiles: each entry is a (pad_a, pad_b). Defaults
    # to () so older code can still construct one without passing this.
    overhangs: tuple[tuple[int, int], ...] = ()

    @property
    def tile_count(self) -> int:
        return len(self.rects)

    @property
    def overhang_count(self) -> int:
        return len(self.overhangs)


@dataclass(frozen=True)
class KaratsubaLutReport:
    """Corresponds to a Karatsuba2Node or Karatsuba3Node: has no LUT tile
    of its own, just hangs its children's reports below it, keeping the
    same shape as the solution tree. K2 has 3 children, K3 has 6, so a
    single `children` tuple is used rather than hardcoding low/mid/high."""
    kind: str                       # "K2" or "K3"
    a_width: int
    b_width: int
    k_a: int
    k_b: int
    children: tuple["LutReportNode", ...]

    @property
    def child_names(self) -> tuple[str, ...]:
        """Child names, in the exact same order children_of returns them;
        only used to make printing readable."""
        if self.kind == "K3":
            return ("d0", "d1", "d2", "m01", "m02", "m12")
        return ("low", "mid", "high")


@dataclass(frozen=True)
class GridLutReport:
    """Corresponds to a GridNode: has no LUT tile of its own, hangs the
    reports for its N squares (+ possible remainder) below it. Field shape
    is deliberately aligned with KaratsubaLutReport (a_width/b_width/
    child_names/children), so a generic tree-printer can print either
    kind of node without special-casing."""
    a_width: int
    b_width: int
    tile_width: int
    a_is_chunked: bool
    children: tuple["LutReportNode", ...]   # square reports + (possible) remainder report
    has_remainder: bool

    @property
    def child_names(self) -> tuple[str, ...]:
        n_square = len(self.children) - (1 if self.has_remainder else 0)
        names = [f"sq{i}" for i in range(n_square)]
        if self.has_remainder:
            names.append("remainder")
        return tuple(names)


# A report-tree node: leaf report / Karatsuba report / Grid report
LutReportNode = Union[TilingLutReport, KaratsubaLutReport, GridLutReport]


def build_lut_report(node: SolutionNode) -> LutReportNode:
    """Convert a SolutionNode solution tree into a report tree with the
    exact same shape.
    TilingNode -> TilingLutReport (carries LUT rectangles)
    K2/K3 Node -> KaratsubaLutReport (hangs 3 or 6 child reports)
    GridNode   -> GridLutReport (hangs N square reports + possibly 1 remainder report)
    Only called once, on the final chosen solution."""
    if isinstance(node, TilingNode):
        residual = mask_complement_within_board(node.covered)
        from dsp_multiplier.frontend.exact_cost import greedy_rectangle_partition
        rects = greedy_rectangle_partition(residual)   # may be empty
        return TilingLutReport(
            a_width=node.a_width,
            b_width=node.b_width,
            a_signed=node.a_signedness is Signedness.SIGNED,
            b_signed=node.b_signedness is Signedness.SIGNED,
            rects=rects,
            # only record tiles that genuinely went off-board; pad_a/pad_b are both 0 otherwise
            overhangs=tuple((p.pad_a, p.pad_b) for p in node.placements
                            if p.pad_a or p.pad_b),
        )

    if isinstance(node, GridNode):
        return GridLutReport(
            a_width=node.a_width,
            b_width=node.b_width,
            tile_width=node.tile_width,
            a_is_chunked=node.a_is_chunked,
            children=tuple(build_lut_report(c) for c in children_of(node)),
            has_remainder=node.remainder is not None,
        )

    # K2 / K3: child count is left up to children_of, no need to special-case here
    return KaratsubaLutReport(
        kind="K3" if isinstance(node, Karatsuba3Node) else "K2",
        a_width=node.a_width,
        b_width=node.b_width,
        k_a=node.k_a,
        k_b=node.k_b,
        children=tuple(build_lut_report(c) for c in children_of(node)),
    )

def total_lut_rects(report: LutReportNode) -> int:
    """Total count of LUT rectangles across the whole report tree."""
    if isinstance(report, TilingLutReport):
        return len(report.rects)
    return sum(total_lut_rects(c) for c in report.children)


def total_lut_cells(report: LutReportNode) -> int:
    """Sum of cell counts over every LUT rectangle (by convention 1 cell
    ~= 1 LUT, same scale as area_estimate)."""
    if isinstance(report, TilingLutReport):
        return sum(r.a_width * r.b_width for r in report.rects)
    return sum(total_lut_cells(c) for c in report.children)
