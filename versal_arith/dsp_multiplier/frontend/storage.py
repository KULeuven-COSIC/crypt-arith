# core/tree_storage.py
"""
Store a SolutionNode (solution tree) and a LutReportNode (LUT report tree)
as JSON, and read them back.

Design goals:
  1. Self-contained: the stored JSON can be read back into a complete
     object without needing TileLibrary / a catalog / the solver.
     (The ResolvedPlacement details the implementation stage needs --
     coverage, output_terms, resources, orientation -- are all persisted
     as-is.)
  2. Exact round-trip: load(dump(x)) == x (every frozen dataclass compares
     equal by value).
  3. Alignment: the two trees are structurally isomorphic. A bundle stores
     both together, and reading one back force-validates that they still
     line up. You can also store just the SolutionNode and re-derive the
     report on read via build_lut_report -- that way it can never drift.

Usage overview:
    from dsp_multiplier.frontend.storage import save_bundle, load_bundle

    save_bundle("sol_64x64.json", node)            # report is derived from node automatically
    node2, report2 = load_bundle("sol_64x64.json") # read back, alignment-checked

    # or store them separately:
    save_solution("sol.json", node)
    node2 = load_solution("sol.json")
"""
from __future__ import annotations

import json
from typing import Any

from dsp_multiplier.frontend.datamodel import (
    Signedness,
    SignMode,
    Orientation,
    ResourceUsage,
    PlacementKey,
    ResolvedPlacement,
    WeightedWord,
    BitSlice,
    CellMask,
    Rect,
    TileImplId,
    TileSpecId,
)
from dsp_multiplier.frontend.solution_tree import (
    TilingNode,
    Karatsuba2Node,
    Karatsuba3Node,
    GridNode,
    SolutionNode,
    children_of,
)
from dsp_multiplier.frontend.reports import (
    TilingLutReport,
    KaratsubaLutReport,
    GridLutReport,
    LutReportNode,
    build_lut_report,
)

SCHEMA_VERSION = 2      # v1 -> v2: placements gained pad_a/pad_b, the report
                        # tree switched to a children list.
                        # Old v1 JSON files can no longer be read back --
                        # just re-run solve and save a new one.

# Child names. Order must match SolutionTree.children_of's return order
# *exactly*, or low/high get swapped on the way back.
_K2_CHILD_NAMES = ("low", "mid", "high")
_K3_CHILD_NAMES = ("d0", "d1", "d2", "m01", "m02", "m12")

# The report tree uses kind "K2"/"K3"; the JSON uses the same words as the
# solution tree, so translate back and forth.
_KIND_TO_JSON = {"K2": "karatsuba2", "K3": "karatsuba3"}
_JSON_TO_KIND = {"karatsuba2": "K2", "karatsuba3": "K3"}

# ===========================================================================
# 1. Encode/decode leaf-level value objects (enums / small dataclasses)
# ===========================================================================
def _sgn_to(s: Signedness) -> str:
    return s.value                       # "signed" / "unsigned"


def _sgn_from(v: str) -> Signedness:
    return Signedness(v)


def _orient_to(o: Orientation) -> str:
    return o.value                       # "ab" / "transposed"


def _orient_from(v: str) -> Orientation:
    return Orientation(v)


def _signmode_to(m: SignMode) -> dict:
    return {"a": _sgn_to(m.a), "b": _sgn_to(m.b)}


def _signmode_from(d: dict) -> SignMode:
    return SignMode(a=_sgn_from(d["a"]), b=_sgn_from(d["b"]))


def _cellmask_to(m: CellMask) -> dict:
    return {
        "a_extent": m.a_extent,
        "b_extent": m.b_extent,
        "rows": list(m.rows),            # list of ints, JSON-safe
    }


def _cellmask_from(d: dict) -> CellMask:
    return CellMask(
        a_extent=d["a_extent"],
        b_extent=d["b_extent"],
        rows=tuple(int(x) for x in d["rows"]),
    )


def _rect_to(r: Rect) -> dict:
    return {"a0": r.a0, "b0": r.b0, "a_width": r.a_width, "b_width": r.b_width}


def _rect_from(d: dict) -> Rect:
    return Rect(a0=d["a0"], b0=d["b0"], a_width=d["a_width"], b_width=d["b_width"])


def _bitslice_to(s: BitSlice) -> dict:
    return {"lo": s.lo, "width": s.width}


def _bitslice_from(d: dict) -> BitSlice:
    return BitSlice(lo=d["lo"], width=d["width"])


def _resources_to(r: ResourceUsage) -> dict:
    return {"dsp": r.dsp, "intrinsic_lut": r.intrinsic_lut, "ff": r.ff}


def _resources_from(d: dict) -> ResourceUsage:
    return ResourceUsage(
        dsp=d["dsp"],
        intrinsic_lut=d["intrinsic_lut"],
        ff=d["ff"],
    )


def _weightedword_to(w: WeightedWord) -> dict:
    return {
        "name": w.name,
        "width": w.width,
        "lsb_weight": w.lsb_weight,
        "signedness": _sgn_to(w.signedness),
        "coefficient": w.coefficient,
    }


def _weightedword_from(d: dict) -> WeightedWord:
    return WeightedWord(
        name=d["name"],
        width=d["width"],
        lsb_weight=d["lsb_weight"],
        signedness=_sgn_from(d["signedness"]),
        coefficient=d["coefficient"],
    )


# ===========================================================================
# 2. Placement layer
# ===========================================================================
def _placementkey_to(k: PlacementKey) -> dict:
    return {
        "impl_id": str(k.impl_id),
        "a0": k.a0,
        "b0": k.b0,
        "orientation": _orient_to(k.orientation),
    }


def _placementkey_from(d: dict) -> PlacementKey:
    return PlacementKey(
        impl_id=TileImplId(d["impl_id"]),
        a0=d["a0"],
        b0=d["b0"],
        orientation=_orient_from(d["orientation"]),
    )


def _placement_to(p: ResolvedPlacement) -> dict:
    return {
        "key": _placementkey_to(p.key),
        "spec_id": str(p.spec_id),
        "bounding_rect": _rect_to(p.bounding_rect),
        "coverage": _cellmask_to(p.coverage),
        "a_slice": _bitslice_to(p.a_slice),
        "b_slice": _bitslice_to(p.b_slice),
        "required_sign_mode": _signmode_to(p.required_sign_mode),
        "resources": _resources_to(p.resources),
        "output_terms": [_weightedword_to(w) for w in p.output_terms],
        # -- Off-board padding: tile logical width minus how much of it is actually on-board --
        "pad_a": p.pad_a,
        "pad_b": p.pad_b,
    }


def _placement_from(d: dict) -> ResolvedPlacement:
    return ResolvedPlacement(
        key=_placementkey_from(d["key"]),
        spec_id=TileSpecId(d["spec_id"]),
        bounding_rect=_rect_from(d["bounding_rect"]),
        coverage=_cellmask_from(d["coverage"]),
        a_slice=_bitslice_from(d["a_slice"]),
        b_slice=_bitslice_from(d["b_slice"]),
        required_sign_mode=_signmode_from(d["required_sign_mode"]),
        resources=_resources_from(d["resources"]),
        output_terms=tuple(_weightedword_from(w) for w in d["output_terms"]),
        # .get rather than d["pad_a"]: older files without this key default to 0, no KeyError
        pad_a=d.get("pad_a", 0),
        pad_b=d.get("pad_b", 0),
    )


# ===========================================================================
# 3. SolutionNode (solution tree)
# ===========================================================================
def solution_to_dict(node: SolutionNode) -> dict:
    """Recursively encode a solution (sub)tree to a JSON-safe dict."""
    if isinstance(node, TilingNode):
        return {
            "kind": "tiling",
            "a_width": node.a_width,
            "b_width": node.b_width,
            "a_signedness": _sgn_to(node.a_signedness),
            "b_signedness": _sgn_to(node.b_signedness),
            "placements": [_placement_to(p) for p in node.placements],
            "covered": _cellmask_to(node.covered),
        }
    if isinstance(node, (Karatsuba2Node, Karatsuba3Node)):
        is_k3 = isinstance(node, Karatsuba3Node)
        out = {
            "kind": "karatsuba3" if is_k3 else "karatsuba2",
            "a_width": node.a_width,
            "b_width": node.b_width,
            "a_signedness": _sgn_to(node.a_signedness),
            "b_signedness": _sgn_to(node.b_signedness),
            "k_a": node.k_a,
            "k_b": node.k_b,
        }
        # zip pairs names with children: 3 for K2, 6 for K3. The children
        # are stored directly as keys of `out`, same as the original
        # "low"/"mid"/"high" style.
        names = _K3_CHILD_NAMES if is_k3 else _K2_CHILD_NAMES
        for name, child in zip(names, children_of(node)):
            out[name] = solution_to_dict(child)
        return out
    if isinstance(node, GridNode):
        return {
            "kind": "grid",
            "a_width": node.a_width,
            "b_width": node.b_width,
            "a_signedness": _sgn_to(node.a_signedness),
            "b_signedness": _sgn_to(node.b_signedness),
            "tile_width": node.tile_width,
            "a_is_chunked": node.a_is_chunked,
            "children": [solution_to_dict(c) for c in node.children],
            "remainder": (solution_to_dict(node.remainder)
                         if node.remainder is not None else None),
        }
    raise TypeError(f"Unknown SolutionNode type: {type(node).__name__}")


def solution_from_dict(d: dict) -> SolutionNode:
    """Inverse of solution_to_dict."""
    kind = d["kind"]
    if kind == "tiling":
        # Note: TilingNode.__post_init__ validates covered == union(placements).
        # Both were persisted as-is, so this passes.
        return TilingNode(
            a_width=d["a_width"],
            b_width=d["b_width"],
            a_signedness=_sgn_from(d["a_signedness"]),
            b_signedness=_sgn_from(d["b_signedness"]),
            placements=tuple(_placement_from(p) for p in d["placements"]),
            covered=_cellmask_from(d["covered"]),
        )
    if kind == "karatsuba2":
        return Karatsuba2Node(
            a_width=d["a_width"],
            b_width=d["b_width"],
            a_signedness=_sgn_from(d["a_signedness"]),
            b_signedness=_sgn_from(d["b_signedness"]),
            k_a=d["k_a"],
            k_b=d["k_b"],
            low=solution_from_dict(d["low"]),
            mid=solution_from_dict(d["mid"]),
            high=solution_from_dict(d["high"]),
        )
    if kind == "karatsuba3":
        return Karatsuba3Node(
            a_width=d["a_width"],
            b_width=d["b_width"],
            a_signedness=_sgn_from(d["a_signedness"]),
            b_signedness=_sgn_from(d["b_signedness"]),
            k_a=d["k_a"],
            k_b=d["k_b"],
            d0=solution_from_dict(d["d0"]),
            d1=solution_from_dict(d["d1"]),
            d2=solution_from_dict(d["d2"]),
            m01=solution_from_dict(d["m01"]),
            m02=solution_from_dict(d["m02"]),
            m12=solution_from_dict(d["m12"]),
        )
    if kind == "grid":
        return GridNode(
            a_width=d["a_width"],
            b_width=d["b_width"],
            a_signedness=_sgn_from(d["a_signedness"]),
            b_signedness=_sgn_from(d["b_signedness"]),
            tile_width=d["tile_width"],
            a_is_chunked=d["a_is_chunked"],
            children=tuple(solution_from_dict(c) for c in d["children"]),
            remainder=(solution_from_dict(d["remainder"])
                      if d["remainder"] is not None else None),
        )
    raise ValueError(f"Unknown solution node kind: {kind!r}")


# ===========================================================================
# 4. LutReportNode (report tree)
# ===========================================================================
def report_to_dict(node: LutReportNode) -> dict:
    """Recursively encode a report (sub)tree to a JSON-safe dict."""
    if isinstance(node, TilingLutReport):
        return {
            "kind": "tiling",
            "a_width": node.a_width,
            "b_width": node.b_width,
            "a_signed": node.a_signed,
            "b_signed": node.b_signed,
            "rects": [_rect_to(r) for r in node.rects],
            # tuples become lists in JSON; converted back to tuples on read
            "overhangs": [[pa, pb] for pa, pb in node.overhangs],
        }
    if isinstance(node, KaratsubaLutReport):
        return {
            "kind": _KIND_TO_JSON[node.kind],     # "K2" -> "karatsuba2"
            "a_width": node.a_width,
            "b_width": node.b_width,
            "k_a": node.k_a,
            "k_b": node.k_b,
            # children is a plain list, length 3 for K2 and 6 for K3, no need to special-case
            "children": [report_to_dict(c) for c in node.children],
        }
    if isinstance(node, GridLutReport):
        return {
            "kind": "grid",
            "a_width": node.a_width,
            "b_width": node.b_width,
            "tile_width": node.tile_width,
            "a_is_chunked": node.a_is_chunked,
            "has_remainder": node.has_remainder,
            "children": [report_to_dict(c) for c in node.children],
        }
    raise TypeError(f"Unknown LutReportNode type: {type(node).__name__}")


def report_from_dict(d: dict) -> LutReportNode:
    """Inverse of report_to_dict."""
    kind = d["kind"]
    if kind == "tiling":
        return TilingLutReport(
            a_width=d["a_width"],
            b_width=d["b_width"],
            a_signed=d["a_signed"],
            b_signed=d["b_signed"],
            rects=tuple(_rect_from(r) for r in d["rects"]),
            # JSON stores [[1,0],[0,2]]; convert to ((1,0),(0,2)) to match in-memory shape
            overhangs=tuple((int(x[0]), int(x[1]))
                            for x in d.get("overhangs", ())),
        )
    if kind in _JSON_TO_KIND:                 # karatsuba2 or karatsuba3
        return KaratsubaLutReport(
            kind=_JSON_TO_KIND[kind],         # "karatsuba3" -> "K3"
            a_width=d["a_width"],
            b_width=d["b_width"],
            k_a=d["k_a"],
            k_b=d["k_b"],
            children=tuple(report_from_dict(c) for c in d["children"]),
        )
    if kind == "grid":
        return GridLutReport(
            a_width=d["a_width"],
            b_width=d["b_width"],
            tile_width=d["tile_width"],
            a_is_chunked=d["a_is_chunked"],
            has_remainder=d["has_remainder"],
            children=tuple(report_from_dict(c) for c in d["children"]),
        )
    raise ValueError(f"Unknown report node kind: {kind!r}")


# ===========================================================================
# 5. Alignment check: the two trees must be structurally isomorphic
# ===========================================================================
class AlignmentError(ValueError):
    """Raised when a SolutionNode and a LutReportNode don't line up structurally."""


def assert_aligned(sol: SolutionNode, report: LutReportNode,
                   path: str = "root") -> None:
    """Recursively check that the solution tree and the report tree are
       isomorphic. Only checks the structural skeleton:
       - both tiling, or both K2, or both K3
       - a_width / b_width match
       - for karatsuba nodes, k_a / k_b match, child counts match, and each
         child pair aligns recursively"""
    sol_is_tiling = isinstance(sol, TilingNode)
    rep_is_tiling = isinstance(report, TilingLutReport)
    if sol_is_tiling != rep_is_tiling:
        raise AlignmentError(
            f"[{path}] node kind mismatch: "
            f"sol={type(sol).__name__} report={type(report).__name__}"
        )

    if sol.a_width != report.a_width or sol.b_width != report.b_width:
        raise AlignmentError(
            f"[{path}] shape mismatch: "
            f"sol={sol.a_width}x{sol.b_width} "
            f"report={report.a_width}x{report.b_width}"
        )

    if sol_is_tiling:
        return

    sol_is_grid = isinstance(sol, GridNode)
    rep_is_grid = isinstance(report, GridLutReport)
    if sol_is_grid != rep_is_grid:
        raise AlignmentError(
            f"[{path}] node kind mismatch: "
            f"sol={type(sol).__name__} report={type(report).__name__}"
        )

    if sol_is_grid:
        if (sol.tile_width, sol.a_is_chunked) != (report.tile_width, report.a_is_chunked):
            raise AlignmentError(
                f"[{path}] grid split mismatch: "
                f"sol=(tile={sol.tile_width},a_chunked={sol.a_is_chunked}) "
                f"report=(tile={report.tile_width},a_chunked={report.a_is_chunked})"
            )
        if (sol.remainder is not None) != report.has_remainder:
            raise AlignmentError(
                f"[{path}] grid remainder mismatch: "
                f"sol_has_remainder={sol.remainder is not None} "
                f"report_has_remainder={report.has_remainder}"
            )
    else:
        # Both karatsuba -- first confirm K2/K3 weren't mixed up.
        sol_kind = "K3" if isinstance(sol, Karatsuba3Node) else "K2"
        if sol_kind != report.kind:
            raise AlignmentError(
                f"[{path}] karatsuba kind mismatch: "
                f"sol={sol_kind} report={report.kind}"
            )

        if (sol.k_a, sol.k_b) != (report.k_a, report.k_b):
            raise AlignmentError(
                f"[{path}] split mismatch: "
                f"sol=({sol.k_a},{sol.k_b}) report=({report.k_a},{report.k_b})"
            )

    sol_kids = children_of(sol)
    rep_kids = report.children
    if len(sol_kids) != len(rep_kids):
        raise AlignmentError(
            f"[{path}] child count mismatch: "
            f"sol={len(sol_kids)} report={len(rep_kids)}"
        )
    # child_names is ("low","mid","high") or ("d0",...,"m12"); appended to
    # `path` so a failure immediately shows which child it was.
    for name, sk, rk in zip(report.child_names, sol_kids, rep_kids):
        assert_aligned(sk, rk, f"{path}.{name}")


# ===========================================================================
# 6. Bundle: pack both trees together (the recommended entry point)
# ===========================================================================
def bundle_to_dict(node: SolutionNode, report: LutReportNode | None = None) -> dict:
    """When `report` is None, derive it on the spot via build_lut_report --
    guaranteed to be aligned by construction."""
    if report is None:
        report = build_lut_report(node)
    else:
        assert_aligned(node, report)     # check alignment before storing, so a mismatch fails early
    return {
        "schema_version": SCHEMA_VERSION,
        "solution": solution_to_dict(node),
        "report": report_to_dict(report),
    }


def bundle_from_dict(d: dict) -> tuple[SolutionNode, LutReportNode]:
    _check_schema(d)
    node = solution_from_dict(d["solution"])
    report = report_from_dict(d["report"])
    assert_aligned(node, report)         # force-check on read, in case a file was hand-edited wrong
    return node, report


def _check_schema(d: dict) -> None:
    v = d.get("schema_version")
    if v != SCHEMA_VERSION:
        raise ValueError(
            f"Unsupported schema_version {v!r}; this reader expects {SCHEMA_VERSION}"
        )


# ===========================================================================
# 7. Disk I/O convenience functions
# ===========================================================================
def _dump_json(obj: Any, path: str) -> None:
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)


def _load_json(path: str) -> Any:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def save_bundle(path: str, node: SolutionNode,
                report: LutReportNode | None = None) -> None:
    """Store (solution tree + report tree). `report` is derived automatically
    when omitted. This is the recommended entry point."""
    _dump_json(bundle_to_dict(node, report), path)


def load_bundle(path: str) -> tuple[SolutionNode, LutReportNode]:
    """Read back (solution tree, report tree), alignment-checked."""
    return bundle_from_dict(_load_json(path))


def save_solution(path: str, node: SolutionNode) -> None:
    """Store just the solution tree (no report)."""
    _dump_json(
        {"schema_version": SCHEMA_VERSION, "solution": solution_to_dict(node)},
        path,
    )


def load_solution(path: str) -> SolutionNode:
    """Read back a solution tree saved by save_solution (no report)."""
    d = _load_json(path)
    _check_schema(d)
    return solution_from_dict(d["solution"])
