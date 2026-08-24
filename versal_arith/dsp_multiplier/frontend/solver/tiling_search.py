# solver/tiling_search_phase.py
"""Direct-tiling search for one sub-board: place DSP tiles to cover as
much of the board as the budget allows, leaving the rest for LUTs.

Three phases, tried in order at each step: place a large canonical tile at
the best open corner; once density gets high enough, switch to greedily
filling DSP58/chain tiles instead; whatever's left over goes to LUTs.
"""
from __future__ import annotations

from collections import defaultdict

from dsp_multiplier.frontend.seed_tiles import (
    build_static_seed_library,
    STATIC_TILE_DEFINITIONS,
    CHAIN_TILE_DEFINITIONS,
)
from dsp_multiplier.frontend.solver.placement_catalog import build_tile_shapes, LazyPlacementSource
from dsp_multiplier.frontend.mask_ops import (
    make_empty_mask, mask_intersects, mask_union,
    mask_complement_within_board,
)
from dsp_multiplier.frontend.solution_tree import TilingNode
from dsp_multiplier.frontend.solver.tuning import (
    T_COARSE, DENSITY_M1, LARGE_MIN_DSP, LARGE_FLOOR, FILL_FLOOR,
)

# -- the large-tile phase's placement source (no chains in this library) --
_LIBRARY = build_static_seed_library(include_chains=False)
_SHAPES = build_tile_shapes(_LIBRARY)

_source_cache: dict[tuple, LazyPlacementSource] = {}


def source_for(a_width, b_width, a_sign, b_sign) -> LazyPlacementSource:
    """The (cached) large-tile placement source for one board shape/sign."""
    key = (a_width, b_width, a_sign, b_sign)
    src = _source_cache.get(key)
    if src is None:
        src = LazyPlacementSource(a_width, b_width, a_sign, b_sign, _SHAPES)
        _source_cache[key] = src
    return src


def find_corner_cells(covered, a_width, b_width):
    """Every "corner" cell of the free area: a free cell adjacent (in one
    of the 4 diagonal directions) to the board edge or an already-covered
    cell. These are the only positions a new tile ever needs to be
    anchored at. Returns [(a, b, (da, db)), ...]."""
    full = (1 << b_width) - 1
    free_mask = mask_complement_within_board(covered)   # the free area (inverted within the board)
    corners = []
    for a in range(a_width):
        free = free_mask.rows[a]
        if not free:
            continue
        row = covered.rows[a]
        # the "blocked" mask in each of the four directions (off-board treated as all-1)
        a_lo = covered.rows[a - 1] if a > 0 else full
        a_hi = covered.rows[a + 1] if a < a_width - 1 else full
        b_lo = ((row << 1) | 1) & full                # bit b means "cell b-1 is blocked"
        b_hi = (row >> 1) | (1 << (b_width - 1))      # bit b means "cell b+1 is blocked"

        for da, a_mask in ((-1, a_lo), (+1, a_hi)):
            for db, b_mask in ((-1, b_lo), (+1, b_hi)):
                m = free & a_mask & b_mask            # every corner of this type in this row
                while m:
                    b = (m & -m).bit_length() - 1     # take the lowest set bit's index
                    corners.append((a, b, (da, db)))
                    m &= m - 1                        # clear the lowest set bit
    return corners


def _trim_results(results, max_solutions, per_level=3, score=None):
    """results: list[(dsp_used, node)] -> pick which candidates get sent on for exact costing.
    Takes `per_level` from each level first to keep diversity, then fills
    any remaining slots preferring deeper solutions; if `score` is given
    (lower is better), sorts within each level by quality, otherwise keeps
    discovery order."""
    buckets = defaultdict(list)
    for d, node in results:
        buckets[d].append(node)
    levels = sorted(buckets, reverse=True)          # DSP usage, highest to lowest

    if score is not None:
        for d in levels:
            buckets[d].sort(key=score)              # sorted by estimate within each level, so the first few are the best few

    out = []
    taken = {}
    for d in levels:                                # round 1: spread the wealth evenly
        chunk = buckets[d][:per_level]
        out.extend(chunk)
        taken[d] = len(chunk)
    for d in levels:                                # round 2: top off any unused slots
        while len(out) < max_solutions and taken[d] < len(buckets[d]):
            out.append(buckets[d][taken[d]])
            taken[d] += 1
    return tuple(out[:max_solutions])


# T_COARSE/DENSITY_M1/LARGE_MIN_DSP/LARGE_FLOOR/FILL_FLOOR are tuning knobs,
# gathered in solver/tuning.py. What's left here are geometric facts tied
# to this specific tile library, not independently tunable.
K2_CELLS = 47 * 44     # 2068: denominator of the fine-phase test = the minimum unit at the large-tile stage
_LARGE_MAX_EXT = max(   # = 70, K3's long side (including transposed, works for both dimensions)
    max(d.a_width, d.b_width)
    for d in STATIC_TILE_DEFINITIONS if d.dsp_count >= 2
)

# -- library dedicated to the chain-filling phase: DSP58 + every chain, no K2/Toom/K3 --
_FILL_DEFS = tuple(
    d for d in STATIC_TILE_DEFINITIONS if d.family == "versal.dsp58"
) + CHAIN_TILE_DEFINITIONS
_FILL_LIBRARY = build_static_seed_library(definitions=_FILL_DEFS)
_FILL_SHAPES = build_tile_shapes(_FILL_LIBRARY)

_fill_cache: dict[tuple, LazyPlacementSource] = {}

def fill_source_for(a_width, b_width, a_sign, b_sign) -> LazyPlacementSource:
    """Like source_for, but for the chain-filling phase's library."""
    key = (a_width, b_width, a_sign, b_sign)
    src = _fill_cache.get(key)
    if src is None:
        src = LazyPlacementSource(a_width, b_width, a_sign, b_sign,
                                  _FILL_SHAPES)
        _fill_cache[key] = src
    return src


def _cells(p) -> int:
    # every tile's coverage in this library is a solid rectangle, so this is just a product
    return p.bounding_rect.a_width * p.bounding_rect.b_width


def _fill_better(p, q) -> bool:
    """greedy2's comparison: is p strictly better than q.
    1) higher on-board coverage ratio wins (equivalently, lower waste ratio wins)
    2) tied -> more DSPs wins
    3) still tied -> larger coverage wins"""
    lhs = _cells(p) * q.full_cells
    rhs = _cells(q) * p.full_cells
    if lhs != rhs:
        return lhs > rhs
    return (p.resources.dsp, _cells(p)) > (q.resources.dsp, _cells(q))


def area_estimate(node) -> int:
    """A bare-minimum estimate: intrinsic LUTs + leftover cell count. By
    convention 1 cell ~= 1 LUT.
    Assumes: every coverage is a solid, non-overlapping rectangle
    (TilingNode already guarantees this)."""
    covered = 0
    intrinsic = 0
    for p in node.placements:
        r = p.bounding_rect
        covered += r.a_width * r.b_width
        intrinsic += p.resources.intrinsic_lut or 0
    return intrinsic + (node.a_width * node.b_width - covered)


def _scan_large(source, covered, a_width, b_width, need, *, allow_overhang):
    """Every top-left (|__-shaped) corner, ascending by (a+b); take the
    first corner that has a legal large tile.
    Legal = geometrically fits AND doesn't overlap AND 2<=dsp<=need. None
    anywhere on the board -> (None, ())."""
    corners = [c for c in find_corner_cells(covered, a_width, b_width)
               if c[2] == (-1, -1)]
    corners.sort(key=lambda c: (c[0] + c[1], c[1], c[0]))
    for a, b, _ in corners:
        cands = []
        for p in source.placements_at_corner(
                a, b, -1, -1,
                allow_overhang=allow_overhang,
                floor=LARGE_FLOOR if allow_overhang else 0):
            if p.resources.dsp <= 1 or p.resources.dsp > need:
                continue
            if mask_intersects(covered, p.coverage):
                continue
            cands.append(p)
        if cands:
            cands.sort(key=lambda p: (-p.resources.dsp, -_cells(p)))
            return (a, b), tuple(cands)
    return None, ()


def _canonical_large(source, covered, a_width, b_width, need):
    """First pass only looks at on-board large tiles -- behaves exactly
    like before this change. Only runs the second, overhang-allowed pass
    once nothing on-board is left anywhere."""
    anchor, cands = _scan_large(source, covered, a_width, b_width, need,
                                allow_overhang=False)
    if cands:
        return anchor, cands
    return _scan_large(source, covered, a_width, b_width, need,
                       allow_overhang=True)


def _continuation(source, covered, a_width, nxt_a, b0, dsp_k, bext, need):
    """Continuing a row lock: same dsp, same row height (bext), take the
    widest one along a (automatically switches to the +1-wider signed
    variant once it hits the sign edge). Returns None once the row is done."""
    if dsp_k > need or nxt_a >= a_width:
        return None
    best = None
    for p in source.placements_at_corner(nxt_a, b0, -1, -1):
        if p.resources.dsp != dsp_k:
            continue
        if p.bounding_rect.b_width != bext:
            continue
        if mask_intersects(covered, p.coverage):
            continue
        if best is None or p.bounding_rect.a_width > best.bounding_rect.a_width:
            best = p
    return best


def _greedy_chain_fill(fill_src, covered, a_width, b_width,
                       dsp_used, budget, selected):
    """Phase 2: first greedily fill on-board positions until exhausted
    (greedy1), then allow continuing to fill off-board (greedy2). Stops
    once nothing more fits."""
    selected = list(selected)

    for allow_overhang in (False, True):          # greedy1 -> greedy2
        while dsp_used < budget:
            best_p = _best_fill_once(
                fill_src, covered, a_width, b_width,
                budget - dsp_used, allow_overhang=allow_overhang)
            if best_p is None:
                break                              # nothing more fits in this phase, move to the next
            selected.append(best_p)
            covered = mask_union(covered, best_p.coverage)
            dsp_used += best_p.resources.dsp

    return covered, dsp_used, selected


def _best_fill_once(fill_src, covered, a_width, b_width, need,
                    *, allow_overhang: bool):
    """Scan every top-left corner across the board, return one best
    position; None if nothing fits at all.
    allow_overhang=False -> greedy1: on-board positions only, key = (dsp, cells), take the max
    allow_overhang=True  -> greedy2: off-board allowed; FILL_FLOOR has
                                    already filtered out the not-worth-it
                                    ones at the source level, so pick the
                                    best by on-board coverage ratio here"""
    best_p, best_key = None, None
    for a, b, dirs in find_corner_cells(covered, a_width, b_width):
        if dirs != (-1, -1):
            continue
        for p in fill_src.placements_at_corner(
                a, b, -1, -1,
                allow_overhang=allow_overhang,
                floor=FILL_FLOOR if allow_overhang else 0):
            if p.resources.dsp > need:
                continue
            if mask_intersects(covered, p.coverage):
                continue

            if allow_overhang:
                if best_p is None or _fill_better(p, best_p):
                    best_p = p
            else:
                k = (p.resources.dsp, _cells(p))
                if best_key is None or k > best_key:
                    best_key, best_p = k, p
    return best_p

def _overhang_gain(p) -> int:
    """How many LUTs placing this tile saves -- only accounts for the tile
    itself, not what comes after. A covered cell would otherwise cost
    about 1 LUT each; the tile pays its own intrinsic cost instead. This
    is exactly area_estimate's single-step decrease."""
    return _cells(p) - (p.resources.intrinsic_lut or 0)



def _overhang_candidates(source, a_width, b_width, budget, total_cells):
    """The overhang phase: only runs once, at the very start of the whole
    board, completely independent of mode1/mode2.

    An empty board has exactly one top-left corner, (0,0), so "overhang"
    here means a tile bigger than the whole board -- exactly the edge-
    padding scenario. Returns every legal off-board candidate at (0,0),
    descending by gain. () if none."""
    if budget < LARGE_MIN_DSP:
        return ()
    if a_width >= _LARGE_MAX_EXT and b_width >= _LARGE_MAX_EXT:
        return ()          # the board is bigger than the largest tile, (0,0) can't possibly overhang, skip building the mask
    if total_cells < LARGE_FLOOR * LARGE_MIN_DSP:
        return ()          # the board is too small, no large tile could clear the floor

    cands = []
    for p in source.placements_at_corner(0, 0, -1, -1,
                                         allow_overhang=True,
                                         floor=LARGE_FLOOR):
        if p.resources.dsp <= 1 or p.resources.dsp > budget:
            continue
        if not (p.pad_a or p.pad_b):
            continue       # not actually off-board, that's mode2's _canonical_large's territory
        cands.append(p)
    cands.sort(key=lambda p: (-_overhang_gain(p), p.resources.dsp))
    return tuple(cands)

def tilings_phased(
    a_width, b_width, a_sign, b_sign, budget,
    *, max_solutions: int = 200, max_nodes: int = 200_000,
    allow_under_budget: bool = True,     # kept for signature compatibility; this algorithm is always "<=" in semantics
    density_switch: float = DENSITY_M1,
    score=None,
):
    """Search direct tilings of one a_width x b_width sub-board within
    `budget` DSPs, using the three-phase strategy described in this
    module's docstring. Returns up to `max_solutions` TilingNodes (trimmed
    by _trim_results), stopping early past `max_nodes` DFS steps."""
    source = source_for(a_width, b_width, a_sign, b_sign)
    fill_src = fill_source_for(a_width, b_width, a_sign, b_sign)
    total_cells = a_width * b_width
    min_cpd = source.min_cells_per_dsp

    results, nodes = [], [0]
    seen_sol: set[frozenset] = set()
    hard_cap = max(200_000, max_solutions * 4)   # cap on accumulated solutions, left for trim to pick from

    def out_of_fuel():
        flag = nodes[0] >= max_nodes or len(results) >= hard_cap
        if flag:
            print(f"tilings_phased: search budget exhausted "
                  f"(nodes={nodes[0]}, results={len(results)}); "
                  f"returning the best found so far")
        return flag

    def record(dsp_used, selected, covered):
        fp = frozenset(p.key for p in selected)
        if fp in seen_sol:
            return
        seen_sol.add(fp)
        results.append((dsp_used, TilingNode(
            a_width=a_width, b_width=b_width,
            a_signedness=a_sign, b_signedness=b_sign,
            placements=tuple(selected), covered=covered)))

    def finish(covered, dsp_used, selected):
        covered, dsp_used, selected = _greedy_chain_fill(
            fill_src, covered, a_width, b_width, dsp_used, budget, selected)
        record(dsp_used, selected, covered)

    def dfs(covered, covered_cells, dsp_used, selected, lock):
        if out_of_fuel():
            return
        nodes[0] += 1
        need = budget - dsp_used
        free = total_cells - covered_cells

        if need == 0 or free == 0:
            finish(covered, dsp_used, selected)
            return

        # mode 1: density past the threshold -> fill one chain, then re-evaluate (no branching)
        if need * min_cpd > density_switch * free:
            p1 = _best_fill_once(fill_src, covered, a_width, b_width, need,
                                 allow_overhang=False)
            if p1 is None:
                p1 = _best_fill_once(fill_src, covered, a_width, b_width, need,
                                     allow_overhang=True)
            if p1 is None:
                finish(covered, dsp_used, selected)
                return
            selected.append(p1)
            dfs(mask_union(covered, p1.coverage),
                covered_cells + _cells(p1),
                dsp_used + p1.resources.dsp, selected, None)
            selected.pop()
            return

        # row lock: the coarse-phase row isn't finished -> the continuation is the only child
        if lock is not None:
            nxt_a, b0, dsp_k, bext = lock
            p2 = _continuation(source, covered, a_width,
                               nxt_a, b0, dsp_k, bext, need)
            if p2 is not None:
                selected.append(p2)
                dfs(mask_union(covered, p2.coverage),
                    covered_cells + _cells(p2),
                    dsp_used + dsp_k, selected,
                    (nxt_a + p2.bounding_rect.a_width, b0, dsp_k, bext))
                selected.pop()
                return
            # row finished: unlock, fall back to the normal branch

        anchor, cands = _canonical_large(source, covered,
                                         a_width, b_width, need)
        if not cands:
            finish(covered, dsp_used, selected)   # the large-tile phase is done
            return

        coarse = free >= T_COARSE * K2_CELLS
        for p in cands:
            if out_of_fuel():
                return
            a0, b0 = anchor
            new_lock = ((a0 + p.bounding_rect.a_width, b0,
                         p.resources.dsp, p.bounding_rect.b_width)
                        if coarse else None)
            selected.append(p)
            dfs(mask_union(covered, p.coverage),
                covered_cells + _cells(p),
                dsp_used + p.resources.dsp, selected, new_lock)
            selected.pop()


    empty = make_empty_mask(a_width, b_width)
    # the overhang phase: runs once at the start, opening one root branch
    # per candidate. Placed BEFORE the normal branch -- so if out_of_fuel
    # trips early, these solutions are the ones that get preserved first.
    for p in _overhang_candidates(source, a_width, b_width,
                                  budget, total_cells):
        finish(p.coverage, p.resources.dsp, [p])

    dfs(empty, 0, 0, [], None)     # the original, non-overhang branch
    return _trim_results(results, max_solutions, score=score)
