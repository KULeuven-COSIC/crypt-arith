# core/frontend_exact_cost.py
"""Exact LUT-cost estimation for a candidate board covering: turns the
DSP-tile-covered area's leftover into a minimal set of rectangles, then
prices those rectangles plus the DSP placements into an exact LUT count.
"""
from __future__ import annotations
from dsp_multiplier.frontend.datamodel import CellMask, Rect
from dsp_multiplier.frontend.mask_ops import (
    mask_is_empty,
    make_full_mask,
    place_mask_on_board,
    mask_subtract,
    mask_complement_within_board,
)
from dsp_multiplier.common.lut_cost import estimate_bmult_luts, estimate_cmp_luts

# =============================================================================
# Rectangle decomposition of the LUT-covered leftover area
# =============================================================================

def _largest_rectangle_in_residual(residual: CellMask) -> Rect:
    """Find the largest-area rectangle within the residual's all-1 region
    (1 = still uncovered, 0 = already covered by a DSP tile), via the
    standard "largest rectangle in histogram" trick applied row by row.
    O(a_extent * b_extent) time, O(b_extent) space."""
    rows = residual.rows
    a_extent = residual.a_extent
    b_extent = residual.b_extent

    # heights[b]: with the current A row as the base, how many
    # consecutive 1s column b has running upward.
    heights = [0] * b_extent

    best_area = 0
    best_rect: Rect | None = None
    best_key = None

    for a, row in enumerate(rows):
        # ---------------------------------------------------------
        # 1. Update the histogram from the current residual row
        # ---------------------------------------------------------
        for b in range(b_extent):
            if row & (1 << b):
                heights[b] += 1
            else:
                heights[b] = 0

        # ---------------------------------------------------------
        # 2. Find the largest rectangle in the current histogram
        #
        # The stack holds:
        #     (earliest column this height could start from, height)
        #
        # Heights are kept strictly increasing.
        # ---------------------------------------------------------
        stack: list[tuple[int, int]] = []

        # A height-0 sentinel at position b_extent, to flush the stack.
        for b in range(b_extent + 1):
            current_height = (
                heights[b]
                if b < b_extent
                else 0
            )

            # If the current height ends up pushed, the earliest column
            # it could start from.
            start_b = b

            # The current bar is shorter than the top of the stack:
            # the top of the stack can't extend further to the right.
            while (
                stack
                and stack[-1][1] > current_height
            ):
                left_b, height = stack.pop()

                width = b - left_b
                area = height * width

                a0 = a - height + 1
                b0 = left_b

                candidate = Rect(
                    a0=a0,
                    b0=b0,
                    a_width=height,
                    b_width=width,
                )

                # Explicit tie-break, to keep the result deterministic.
                #
                # When area is equal, prefer:
                # 1. smaller a0
                # 2. smaller b0
                # 3. smaller height
                # 4. smaller width
                candidate_key = (
                    a0,
                    b0,
                    height,
                    width,
                )

                if (
                    area > best_area
                    or (
                        area == best_area
                        and (
                            best_key is None
                            or candidate_key < best_key
                        )
                    )
                ):
                    best_area = area
                    best_rect = candidate
                    best_key = candidate_key

                # The popped rectangle starts at left_b; a shorter bar
                # here can inherit that same starting point.
                start_b = left_b

            # current_height == 0 doesn't need to be pushed.
            if current_height == 0:
                continue

            # Don't push a duplicate of the same height.
            #
            # If the top of the stack already has this height, that
            # entry has the earlier start_b.
            if (
                not stack
                or stack[-1][1] < current_height
            ):
                stack.append(
                    (start_b, current_height)
                )

    if best_rect is None:
        raise RuntimeError(
            "No set cell found in residual"
        )

    return best_rect

def _remove_rect(residual: CellMask, rect: Rect) -> CellMask:
    """Carve `rect` (board coordinates) out of the residual mask."""
    local = make_full_mask(rect.a_width, rect.b_width)
    on_board = place_mask_on_board(
        local, a0=rect.a0, b0=rect.b0,
        board_a_width=residual.a_extent,
        board_b_width=residual.b_extent,
    )
    return mask_subtract(residual, on_board)   # rect is guaranteed a subset of residual, so this is valid

def greedy_rectangle_partition(residual: CellMask) -> tuple[Rect, ...]:
    """Greedily cut the largest remaining rectangle out of `residual`,
    repeating until nothing's left. Not optimal (fewest rectangles isn't
    guaranteed), but simple and fast."""
    remaining = residual
    rects: list[Rect] = []
    while not mask_is_empty(remaining):
        best = _largest_rectangle_in_residual(remaining)
        rects.append(best)
        remaining = _remove_rect(remaining, best)
    return tuple(rects)

# =============================================================================
# Exact cost model built on top of the rectangle decomposition
# =============================================================================

def make_edge_checker(board_a_width, board_b_width):
    """Build the `rect_signedness` callback exact_cost() expects: given a
    residual rectangle, whether its A/B side touches the board's MSB edge
    (and so needs a signed rather than unsigned LUT multiplier)."""
    def edge_is_signed(rect):
        a_touches = (rect.a0 + rect.a_width == board_a_width)
        b_touches = (rect.b0 + rect.b_width == board_b_width)
        return a_touches , b_touches      # touching the MSB edge on either side -> signed bmult
    return edge_is_signed

def deposit_word_extend(heights, *, lsb: int, width: int, signed: bool) -> None:
    """Route A: sign extension. Modifies `heights` in place.
    Behaves exactly like the original rect_output_contribution /
    dsp_output_contribution."""
    heap_width = len(heights)
    msb_excl = lsb + width

    for col in range(lsb, min(msb_excl, heap_width)):
        heights[col] += 1

    if signed:
        for col in range(msb_excl, heap_width):
            heights[col] += 1


# ---------------------------------------------------------------------------
# Route C: sign extension removal (in-place version) -- feed one product
# word in + record one constant
# ---------------------------------------------------------------------------
def deposit_word_removal(
    heights,
    correction_exponents,
    *,
    lsb: int,
    width: int,
    signed: bool,
) -> None:
    """Feed one product word into the heap (route C). Modifies `heights`
    and `correction_exponents` in place.

    All `width` bits are placed at positive weight in [lsb, lsb+width),
    exactly like the unsigned case. The only difference: when signed, the
    top slot holds the inverted sign bit r-bar (heights only counts, so
    that distinction isn't visible here), plus one extra correction
    constant of -2**(lsb+width-1) gets recorded.

    In other words: signed no longer stuffs any extra bits into the heap
    at all -- the whole cost is pushed onto the single constant row folded
    in at the end.
    """
    heap_width = len(heights)

    for bit in range(width):
        col = lsb + bit
        if col >= heap_width:
            break
        heights[col] += 1

    if signed:
        sign_col = lsb + width - 1
        if sign_col < heap_width:          # no correction needed if the whole product got truncated away
            correction_exponents.append(sign_col)


def fold_corrections(heights, correction_exponents) -> None:
    """Fold every -2**e into one heap_width-bit two's-complement constant,
    then merge it into the heap. Modifies `heights` in place. Returns
    immediately when there are no corrections.

    Taking mod 2**heap_width is valid because the heap is only this wide
    to begin with -- any higher carry is naturally discarded."""
    if not correction_exponents:
        return

    heap_width = len(heights)
    mask = (1 << heap_width) - 1
    correction = (-sum(1 << e for e in correction_exponents)) & mask

    for col in range(heap_width):
        if (correction >> col) & 1:
            heights[col] += 1


# -- Shortcut: when the extend heap is this many times fatter than the
# removal heap, just call it the loser without computing further --
# Rationale: column-by-column, heights_removal <= heights_extend (folding
# adds at most 1 per column), and cmp cost rises monotonically with heap
# height. Once there are enough signed words, extend is guaranteed to
# lose, so there's no need to actually price out that taller, pricier heap.
_REMOVAL_SHORTCUT_RATIO = 1.2
def compare_sign_routes(words, heap_width):
    """words = [(lsb, width, signed), ...], every product word going into
    the same final heap.

    Feeds one heap per route, runs cmp on each once, returns (cheaper cmp
    LUT count, route name). route name in {"extend", "removal"}. Ties
    keep "extend" (matches the old result)."""
    heights_extend = [0] * heap_width
    heights_removal = [0] * heap_width
    corrections = []

    for lsb, width, signed in words:
        deposit_word_extend(heights_extend,
                            lsb=lsb, width=width, signed=signed)
        deposit_word_removal(heights_removal, corrections,
                             lsb=lsb, width=width, signed=signed)

    fold_corrections(heights_removal, corrections)

    # compute the cheap one first: the removal heap is never column-wise taller than extend
    cost_removal = estimate_cmp_luts(heights_removal).total

    # shortcut: extend is clearly fatter -> skip pricing it, removal wins outright
    if sum(heights_extend) > _REMOVAL_SHORTCUT_RATIO * sum(heights_removal):
        return cost_removal, "removal"

    cost_extend = estimate_cmp_luts(heights_extend).total

    if cost_removal < cost_extend:
        return cost_removal, "removal"
    return cost_extend, "extend"

# ---------------------------------------------------------------------------
# Exact cost for one complete candidate covering
# ---------------------------------------------------------------------------
def exact_cost(
    covered,
    dsp_placements,
    *,
    board_a_width,
    board_b_width,
    rect_signedness,
):
    """Returns (lut_total, sign_mode).

    sign_mode says which sign-handling route this board's final heap used:
      "extend"  = route A, sign bit propagated all the way to the top of the heap
      "removal" = route C, sign bit inverted in place + one constant row at the end
    The two routes are mathematically equivalent, only their cmp cost
    differs, so both get computed here and the cheaper one is taken."""
    heap_width = board_a_width + board_b_width

    # ---- first pass: collect every product word, and tally intrinsic/bmult LUTs along the way ----
    words = []            # [(lsb, width, signed), ...]
    lut_before_cmp = 0    # this part is identical on both routes, doesn't factor into the comparison

    for p in dsp_placements:
        if p.resources.intrinsic_lut is None:
            raise ValueError("DSP placement has uncharacterised intrinsic_lut")
        lut_before_cmp += p.resources.intrinsic_lut

        for term in p.output_terms:
            words.append((
                term.lsb_weight,
                term.width,
                term.signedness.name == "SIGNED",
            ))

    residual = mask_complement_within_board(covered)
    rects = greedy_rectangle_partition(residual)

    for r in rects:
        a_signed, b_signed = rect_signedness(r)

        report = estimate_bmult_luts(
            r.a_width,
            r.b_width,
            a_signed=a_signed,
            b_signed=b_signed,
        )
        lut_before_cmp += report.total

        words.append((
            r.a0 + r.b0,                    # the product's lowest bit weight
            r.a_width + r.b_width,          # full product width (scheme A)
            a_signed or b_signed,           # signed on either side -> product is signed
        ))

    # ---- second pass: feed this same batch of words into a heap per route, keep the cheaper one ----
    cmp_total, sign_mode = compare_sign_routes(words, heap_width)

    return float(lut_before_cmp + cmp_total), sign_mode
