# solver/solve.py
"""The top-level solver: recursively search Karatsuba-2/3 splits (plus
direct tiling at each level, via dsp_multiplier.frontend.solver.tiling_search) to find the
cheapest way to build an a_width x b_width multiplier within a DSP budget.
solve_grid_top additionally handles rectangular boards by cutting them
into same-size squares first (see the "Rectangles" section below).
"""
from __future__ import annotations

from dsp_multiplier.frontend.datamodel import Signedness
from dsp_multiplier.frontend.solver.tiling_search import source_for, tilings_phased, area_estimate
from dsp_multiplier.frontend.solver.tuning import BEAM, GREEDY_PREFILTER, TILING_MAX_NODES, SPLIT_FLOOR

from itertools import product
from dsp_multiplier.frontend.solution_tree import Karatsuba2Node, Karatsuba3Node, GridNode, dsp_count
from dsp_multiplier.frontend.cost import cost_of, karatsuba_merge, karatsuba3_merge

_solve_cache: dict[tuple, tuple] = {}


def board_can_hold_dsp(a_width, b_width, a_sign, b_sign) -> bool:
    """Whether this board is at least SPLIT_FLOOR cells, i.e. big enough
    that placing a DSP tile is even geometrically possible."""
    return source_for(a_width, b_width, a_sign, b_sign).can_hold_dsp(SPLIT_FLOOR)

# ---- split: symmetric (odd len_lo<len_hi) ----
def split_point(w: int) -> int:
    """Karatsuba-2's shift amount: the low segment's width."""
    return (w + 1) // 2

def _mid_width(lo: int, hi: int, parent_signed: bool) -> int:
    """The signed width dX = X_hi - X_lo (or the reverse) needs, per that
    dimension's parent sign."""
    if parent_signed:
        return max(hi, lo + 1) + 1     # the high segment carries a sign bit, the negative side needs one extra tier
    return max(hi, lo) + 1             # both segments are unsigned magnitudes

def make_children(a_width, b_width, a_sign, b_sign):
    """The three Karatsuba-2 sub-problems' (a_width, b_width, a_sign,
    b_sign) specs: low, mid (the cross term, |A1-A0|*|B0-B1|), high.
    Returns (ka, kb, low, mid, high)."""
    ka = split_point(a_width)
    kb = split_point(b_width)
    a_lo, a_hi = a_width - ka, ka
    b_lo, b_hi = b_width - kb, kb

    assert a_lo == b_lo, (
        f"Karatsuba requires a_lo == b_lo, got a_lo={a_lo}, b_lo={b_lo} "
        f"(a_width={a_width}, b_width={b_width})"
    )

    S, Uu = Signedness.SIGNED, Signedness.UNSIGNED
    low  = (a_lo, b_lo, Uu, Uu)
    high = (a_hi, b_hi, a_sign, b_sign)      # the high segment inherits the parent's sign
    # dA/dB (the differences) are always signed. When the parent is square
    # (a_width==b_width), a_lo==b_lo and a_hi==b_hi; if a_sign != b_sign,
    # computing each dimension's width separately would make mid off by
    # one bit and non-square. So this uses OR: if either dimension is
    # signed, both use the signed formula (which is always >= the
    # unsigned formula, never smaller), padding the unsigned dimension out
    # to match the signed one's width, in exchange for mid staying square
    # -- which lets it recurse straight into the existing square K2/K3
    # logic (rectangular Karatsuba isn't implemented yet).
    is_mid_signed = (a_sign is S) or (b_sign is S)
    mid  = (
        _mid_width(a_lo, a_hi, is_mid_signed),
        _mid_width(b_lo, b_hi, is_mid_signed),
        S, S,
    )
    return a_lo, b_lo, low, mid, high

def can_split(a_width, b_width, a_sign, b_sign) -> bool:
    """After splitting, if the largest child (mid, signed x signed) can't
    hold a DSP, there's no point doing Karatsuba."""
    # hard gate 0: rectangles (a_width != b_width) don't do K2 yet -- make_children's
    # a_lo==b_lo identity only holds for a square board; rectangles go
    # straight to tiling+bmult. Must come first, or the assert inside
    # make_children below would crash outright.
    if a_width != b_width:
        return False
    # hard gate 1: if the parent itself can't hold a DSP, no point splitting further
    if not board_can_hold_dsp(a_width, b_width, a_sign, b_sign):
        return False

    ka, kb, low, mid, high = make_children(a_width, b_width, a_sign, b_sign)
    a_mid, b_mid, mid_as, mid_bs = mid

    # hard gate 2: mid didn't strictly shrink -> recursion wouldn't converge.
    # A signed board with w=3/4 has mid the same width as itself, and
    # balanced_split(1) would pass the entire budget straight to mid
    # unchanged, recursing forever. low/high are always < the parent, so
    # only mid needs checking.
    if a_mid >= a_width or b_mid >= b_width:
        return False

    return board_can_hold_dsp(a_mid, b_mid, mid_as, mid_bs)

# ---- budget allocation: only try the "as even as possible" split ----
# ---- budget allocation: split evenly into three, ignoring capacity ----
def balanced_split(budget):
    """Split `budget` into three shares as equal as possible, returning
    (d_lo, d_mid, d_hi). Remainder priority: mid > lo > hi.

    Doesn't check each child's capacity -- each child's solve() clamps to
    its own capacity at the top, and simply discards whatever part doesn't fit."""
    base, rem = divmod(budget, 3)
    d_mid = base + (1 if rem >= 1 else 0)
    d_lo  = base + (1 if rem >= 2 else 0)
    d_hi  = base
    return d_lo, d_mid, d_hi

# ==================== 3-way Karatsuba ====================

def split3_point(w: int) -> int:
    """Shift amount k: the two low segments each get k bits, the top
    segment takes whatever's left, w-2k (remainder goes to the top
    segment, consistent with K2's "narrow low, wide high" style)."""
    return w // 3


def make_children3(a_width, b_width, a_sign, b_sign):
    """Returns (ka, kb, subs), where subs is the 6 sub-problems, in the
    fixed order (d0, d1, d2, m01, m02, m12). Each entry = (a_w, b_w, a_sign, b_sign).

    The direction of the differences is A high-minus-low / B low-minus-high,
    but |A1-A0| and |B0-B1| need exactly the same signed width, so the
    width still uses the existing _mid_width."""
    ka, kb = split3_point(a_width), split3_point(b_width)
    a_top, b_top = a_width - 2 * ka, b_width - 2 * kb

    S, U = Signedness.SIGNED, Signedness.UNSIGNED
    d0 = (ka, kb, U, U)                    # A0*B0, the low segment is always unsigned
    d1 = (ka, kb, U, U)                    # A1*B1, same shape as d0 -> cache reuse
    d2 = (a_top, b_top, a_sign, b_sign)    # only the top segment inherits the parent's sign

    # all three differences are signed
    w_a01 = _mid_width(ka, ka, False)             # A1-A0: both segments are unsigned magnitudes
    w_b01 = _mid_width(kb, kb, False)             # B0-B1: same width
    # m02/m12 follow the same reasoning as K2's mid: when the parent is
    # square, ka==kb and a_top==b_top; if a_sign != b_sign, computing the
    # widths separately would make m02/m12 off by one bit and
    # non-square. Same OR-padding trick to keep them square (see the
    # comment in make_children for why).
    is_m2x_signed = (a_sign is S) or (b_sign is S)
    w_a2x = _mid_width(ka, a_top, is_m2x_signed)  # A2-A0 and A2-A1 are the same width
    w_b2x = _mid_width(kb, b_top, is_m2x_signed)  # B0-B2 and B1-B2 are the same width

    m01 = (w_a01, w_b01, S, S)
    m02 = (w_a2x, w_b2x, S, S)
    m12 = (w_a2x, w_b2x, S, S)             # exactly the same shape as m02 -> memoization reuses it automatically
    return ka, kb, (d0, d1, d2, m01, m02, m12)


def can_split3(a_width, b_width, a_sign, b_sign) -> bool:
    """Whether 3-way is possible: all three segments must be non-empty,
    the shift amounts on both dimensions must line up, and the largest
    child (m02, signed x signed) must be able to hold a DSP."""
    # hard gate 0: rectangles don't do K3 yet, same reasoning as can_split.
    if a_width != b_width:
        return False
    if a_width < 3 or b_width < 3:
        return False
    if not board_can_hold_dsp(a_width, b_width, a_sign, b_sign):
        return False
    ka, kb, subs = make_children3(a_width, b_width, a_sign, b_sign)
    if ka != kb:                      # karatsuba3_merge requires k_a == k_b
        return False
    if a_width - 2 * ka < 1 or b_width - 2 * kb < 1:
        return False
    a_m02, b_m02 = subs[4][0], subs[4][1]
    if a_m02 >= a_width or b_m02 >= b_width:
        return False              # m02 didn't shrink -> recursion wouldn't converge (a signed 3x3 would self-loop)
    return board_can_hold_dsp(*subs[4])       # subs[4] = m02


def balanced_split6(budget):
    """Split `budget` into three shares as equal as possible... actually
    six (see below), returning a length-6 list. Remainder priority order
    given below.

    Doesn't check each child's capacity -- a child's tilings_phased is
    "<="-semantics, so a budget it can't fully use just returns an
    under-used solution, never an empty one."""
    base, rem = divmod(budget, 6)
    d = [base] * 6
    priority = (4, 5, 2, 1, 0, 3)     # m02, m12, d2, d1, d0, m01
    for i in range(rem):
        d[priority[i]] += 1
    return d

def _keep_best(scored):
    scored.sort(key=lambda cn: cn[0].lut_total)
    return tuple(scored[:BEAM])

def solve(a_width, b_width, a_sign, b_sign, budget):
    """Recursively search every decomposition (direct tiling, Karatsuba-2,
    Karatsuba-3) of a square a_width x b_width board within `budget` DSPs,
    memoized by (a_width, b_width, a_sign, b_sign, budget).

    Returns tuple[(cost, node), ...], ascending by cost, truncated to
    BEAM entries. Every node satisfies dsp_count(node) <= budget."""
    key = (a_width, b_width, a_sign, b_sign, budget)
    if key in _solve_cache:
        return _solve_cache[key]

    scored = []

    # -- branch 1: tiling, DSP count exactly == budget (budget==0 is a pure-LUT leaf) --
    tilings = tilings_phased(a_width, b_width, a_sign, b_sign, budget,
                             max_solutions=GREEDY_PREFILTER,
                             max_nodes=TILING_MAX_NODES,
                             score=area_estimate)
    # phase B: run exact costing only on these
    for node in tilings:
        scored.append((cost_of(node), node))

    # -- branch 2: Karatsuba-2, only tried if there's budget left and a split is possible --
    if budget >= 1 and can_split(a_width, b_width, a_sign, b_sign):
        ka, kb, lo_p, mid_p, hi_p = make_children(
            a_width, b_width, a_sign, b_sign
        )
        # only try the "as even as possible" split (the old version enumerated every partitions_into_3 option)
        d_lo, d_mid, d_hi = balanced_split(
            budget
        )
        lo_sols  = solve(*lo_p,  d_lo)
        mid_sols = solve(*mid_p, d_mid)
        hi_sols  = solve(*hi_p,  d_hi)

        # each child is already top-BEAM, so the combined size is <= BEAM^3 (just 1 when BEAM=1)
        for lo_cr, lo in lo_sols:
            for mi_cr, mi in mid_sols:
                for hi_cr, hi in hi_sols:
                    node = Karatsuba2Node(
                        a_width=a_width, b_width=b_width,
                        a_signedness=a_sign, b_signedness=b_sign,
                        k_a=ka, k_b=kb, low=lo, mid=mi, high=hi,
                    )
                    scored.append(
                        (karatsuba_merge(node, lo_cr, mi_cr, hi_cr), node)
                    )

    # -- branch 3: Karatsuba-3 (6 sub-products, 12 product words all summed) --
    if budget >= 1 and can_split3(a_width, b_width, a_sign, b_sign):
        ka3, kb3, subs = make_children3(a_width, b_width, a_sign, b_sign)
        budgets = balanced_split6(budget)
        # each of the 6 children recurses on its own; each returns a top-BEAM list of (cost, node)
        kid_sols = [solve(*p, bgt) for p, bgt in zip(subs, budgets)]
        # take the cartesian product; if any list is empty, there are zero combinations
        for combo in product(*kid_sols):
            crs   = [cr for cr, _ in combo]
            nodes = [nd for _, nd in combo]
            node = Karatsuba3Node(
                a_width=a_width, b_width=b_width,
                a_signedness=a_sign, b_signedness=b_sign,
                k_a=ka3, k_b=kb3,
                d0=nodes[0], d1=nodes[1], d2=nodes[2],
                m01=nodes[3], m02=nodes[4], m12=nodes[5],
            )
            scored.append((karatsuba3_merge(node, *crs), node))

    answer = _keep_best(scored)
    _solve_cache[key] = answer
    return answer


def solve_top(a_width, b_width, a_sign, b_sign, budget):
    """Entry point for a square board: the global-optimum (lut_total, node),
    or None if there's no feasible solution within budget."""
    _solve_cache.clear()      # clear the cache before every fresh search, to avoid cross-run contamination
    sols = solve(a_width, b_width, a_sign, b_sign, budget)
    if not sols:
        return None
    best_cr, best_node = sols[0]
    return (best_cr.lut_total, best_node)


# ==================== Rectangles: square tiling (GridNode) ====================
# For a board with a_width != b_width, rectangular K2/Toom2.5 aren't
# implemented yet -- instead cut it into several
# tile_width x tile_width squares (handed off to the existing square
# solve() recursively), with whatever doesn't fill an entire square left
# over and handed to tiling+bmult directly (also via solve(), just
# degenerating into pure tiling -- see hard gate 0 in can_split/can_split3).

_grid_cache: dict[tuple, tuple] = {}   # a separate cache, can't share with
                                        # _solve_cache: the same
                                        # (a,b,as,bs,budget) means two
                                        # completely different
                                        # algorithms/results for solve()
                                        # vs solve_grid().


def can_grid_split(a_width, b_width) -> bool:
    """Whether a rectangle is "big enough to be worth" cutting into
    squares. Uses SPLIT_FLOOR (=23*23) as the area floor: if the short
    side squared can't even fit one DSP, cutting squares only adds merge
    overhead -- better to hand the whole thing straight to solve()
    (degenerating into tiling+bmult)."""
    if a_width == b_width:
        return False
    tile_width = min(a_width, b_width)
    return tile_width * tile_width >= SPLIT_FLOOR


def _grid_square_spec(tile_width, a_is_chunked, a_sign, b_sign, is_msb):
    """Compute a tile_width x tile_width square's (a_width,b_width,a_sign,b_sign).
    The dimension that was split: only the square touching the MSB
    (is_msb=True) inherits the parent's real sign, the rest are forced
    unsigned; the dimension that wasn't split: the whole span is
    untouched, and inherits the parent's sign as-is."""
    U = Signedness.UNSIGNED
    if a_is_chunked:
        return tile_width, tile_width, (a_sign if is_msb else U), b_sign
    return tile_width, tile_width, a_sign, (b_sign if is_msb else U)


def _grid_remainder_spec(a_width, b_width, tile_width, a_is_chunked,
                         a_sign, b_sign, n_full):
    """The remainder always touches the MSB: both dimensions' signs pass
    through from the parent unchanged."""
    if a_is_chunked:
        rem_width = a_width - n_full * tile_width
        return rem_width, tile_width, a_sign, b_sign
    rem_width = b_width - n_full * tile_width
    return tile_width, rem_width, a_sign, b_sign


# ---- pass 1: pure geometric expansion, never calls solve() ----
# `plan` is a lightweight tuple tree, in two shapes:
#   ("leaf", a, b, a_sign, b_sign)                       -- too small, hand straight to solve()
#   ("grid", a_width, b_width, a_sign, b_sign,
#            tile_width, a_is_chunked, squares, remainder_plan)
# `squares` is this level's N squares' (a,b,a_sign,b_sign) specs;
# `remainder_plan` is either None (divides evenly) or another leaf/grid (recursion).
def _plan_grid(a_width, b_width, a_sign, b_sign):
    if not can_grid_split(a_width, b_width):
        return ("leaf", a_width, b_width, a_sign, b_sign)

    a_is_chunked = a_width > b_width
    tile_width = min(a_width, b_width)
    long_width = max(a_width, b_width)
    n_full = long_width // tile_width
    rem_width = long_width - n_full * tile_width

    squares = [
        _grid_square_spec(
            tile_width, a_is_chunked, a_sign, b_sign,
            is_msb=(rem_width == 0 and i == n_full - 1),   # when it divides evenly, the last square stands in for the remainder
        )
        for i in range(n_full)
    ]

    remainder_plan = None
    if rem_width > 0:
        ra, rb, ras, rbs = _grid_remainder_spec(
            a_width, b_width, tile_width, a_is_chunked, a_sign, b_sign, n_full
        )
        remainder_plan = _plan_grid(ra, rb, ras, rbs)

    return ("grid", a_width, b_width, a_sign, b_sign,
            tile_width, a_is_chunked, squares, remainder_plan)


def _flatten_squares(plan):
    """Collect every square spec in the whole plan tree, in geometric
    (depth-first) order. The leaf at the end of a remainder chain (too
    small to cut further) doesn't count as a square and isn't included in
    this list -- it doesn't participate in "allocate budget by area", it
    just eats whatever's left over after the squares."""
    if plan[0] == "leaf":
        return []
    _, _a, _b, _as, _bs, _tw, _chunked, squares, remainder_plan = plan
    out = list(squares)
    if remainder_plan is not None:
        out += _flatten_squares(remainder_plan)
    return out


# ---- pass 2: allocate an integer budget globally, by area ----
def _plan_dsp_targets(specs, budget):
    """specs: the list of squares from _flatten_squares (order = geometric order).
    Returns an equal-length list of integer budgets:
      1) allocate proportional to area, rounded down, each square gets at
         least 1 (a small square has no Karatsuba fallback, so it's
         better to over-allocate than let it get 0);
      2) after the floor of 1 each, distribute any remainder to the
         smallest squares first;
      3) if the budget isn't even enough for "1 per square", claw back
         starting from the largest square (a large square can make up for
         it internally via K2/K3; a small square's floor of 1 is the last
         thing touched)."""
    n = len(specs)
    if n == 0:
        return []

    areas = [a * b for a, b, _, _ in specs]
    total_area = sum(areas)
    targets = [max(1, int(budget * ar / total_area)) for ar in areas]

    order = sorted(range(n), key=lambda i: areas[i])   # smallest area first

    diff = budget - sum(targets)
    if diff > 0:
        for i in order:                # top off the remainder, smallest first
            if diff <= 0:
                break
            targets[i] += 1
            diff -= 1
    elif diff < 0:
        need = -diff
        for i in reversed(order):      # claw back the shortfall, largest first
            if need <= 0:
                break
            take = min(need, targets[i])
            targets[i] -= take
            need -= take

    return targets


# ---- pass 3: actually solve in geometric order, using pass 2's targets
#      as the starting point, with whatever's unspent rolling forward to
#      the next one (`carry` accumulates globally, not reset per level) ----
def _solve_plan(plan, target_iter, carry):
    """Returns (node, carry_after). node=None means this branch's solve failed."""
    if plan[0] == "leaf":
        _, a, b, as_, bs_ = plan
        sols = solve(a, b, as_, bs_, carry)
        if not sols:
            return None, carry
        _, node = sols[0]
        return node, carry - dsp_count(node)

    (_, a_width, b_width, a_sign, b_sign,
     tile_width, a_is_chunked, squares, remainder_plan) = plan

    child_nodes = []
    for a_i, b_i, as_i, bs_i in squares:
        available = carry + next(target_iter)
        sols_i = solve(a_i, b_i, as_i, bs_i, available)
        if not sols_i:
            return None, carry
        _, node_i = sols_i[0]
        child_nodes.append(node_i)
        carry = available - dsp_count(node_i)

    remainder_node = None
    if remainder_plan is not None:
        remainder_node, carry = _solve_plan(remainder_plan, target_iter, carry)
        if remainder_node is None:
            return None, carry

    node = GridNode(
        a_width=a_width, b_width=b_width,
        a_signedness=a_sign, b_signedness=b_sign,
        tile_width=tile_width, a_is_chunked=a_is_chunked,
        children=tuple(child_nodes), remainder=remainder_node,
    )
    return node, carry


def solve_grid(a_width, b_width, a_sign, b_sign, budget):
    """Rectangle entry point: returns tuple[(cost, node), ...] (the same
    return shape as solve()); never uses a beam here -- allocating budget
    is a deterministic greedy process, not an enumeration of splits, in
    the same style as balanced_split only trying the "as even as
    possible" split.

    Runs three passes: (1) _plan_grid, pure geometric expansion, never
    touches solve; (2) _plan_dsp_targets, an integer target computed
    globally by area; (3) _solve_plan, actually solving in geometric
    order, rolling whatever's "unspent" past the target forward to the
    next one in the same order.

    A rectangle that isn't "square-tile-scale", or a plain square, gets a
    plan that's just a leaf -- specs and the target list in step 2 are
    both empty, and step 3's first (and only) step consumes the whole
    budget directly -- equivalent to the old "not worth splitting, hand
    to solve()" path, with no separate check needed for it."""
    key = (a_width, b_width, a_sign, b_sign, budget)
    if key in _grid_cache:
        return _grid_cache[key]

    plan = _plan_grid(a_width, b_width, a_sign, b_sign)
    specs = _flatten_squares(plan)
    targets = _plan_dsp_targets(specs, budget)
    # when plan is a leaf, specs/targets are both empty, so carry starts
    # from budget (there's no pool of squares to claim it first); when
    # plan is a grid, every square's own target has already spent the
    # whole budget, so carry just needs to start accumulating "unspent" from 0.
    init_carry = budget if plan[0] == "leaf" else 0
    node, _carry = _solve_plan(plan, iter(targets), init_carry)
    if node is None:
        _grid_cache[key] = ()
        return ()

    answer = ((cost_of(node), node),)
    _grid_cache[key] = answer
    return answer


def solve_grid_top(a_width, b_width, a_sign, b_sign, budget):
    """The general entry point: like solve_top, but also handles
    rectangular boards (a_width != b_width) via solve_grid. Falls straight
    back to solve_top's behavior when the board is square."""
    _solve_cache.clear()
    _grid_cache.clear()
    sols = solve_grid(a_width, b_width, a_sign, b_sign, budget)
    if not sols:
        return None
    best_cr, best_node = sols[0]
    return (best_cr.lut_total, best_node)
