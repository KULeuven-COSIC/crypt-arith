"""LUT-count-only analysis for Versal compressor trees and Booth multipliers.

This module deliberately does not import any RTL generator and does not write files.
It reuses the existing BitHeap/heuristic scheduler, then mirrors the terminal-adder
placement decisions to count physical Versal LUTs.
"""
from __future__ import annotations

from dataclasses import dataclass
from functools import lru_cache
from math import ceil
from typing import Iterable, Sequence

from bitheap import BitHeap
from heuristic import compressAll, formGPCChain, merge_last_stage


@dataclass(frozen=True)
class LUTBreakdown:
    """A LUT count broken down by stage: partial-product generation,
    compression (GPC counters), and the terminal adder."""

    partial_products: int
    compression: int
    terminal_adder: int
    compression_layers: int
    merged_last_stage: bool
    terminal_inputs: tuple[int, ...]

    @property
    def total(self) -> int:
        return self.partial_products + self.compression + self.terminal_adder


@dataclass(frozen=True)
class _CompressionAnalysis:
    """Internal result of running one bit heap through the compressor +
    terminal-adder placement analysis."""

    compression_luts: int
    terminal_luts: int
    compression_layers: int
    merged_last_stage: bool
    terminal_inputs: tuple[int, ...]


def _validate_heights(bitheap_list: Sequence[int]) -> tuple[int, ...]:
    """Coerce to a tuple of ints and reject an empty or all-zero heap."""
    heights = tuple(int(v) for v in bitheap_list)
    if not heights:
        raise ValueError("bitheap_list must contain at least one column")
    if any(v < 0 for v in heights):
        raise ValueError("bitheap column heights must be non-negative")
    if not any(heights):
        raise ValueError("an all-zero bit heap has no arithmetic result")
    return heights


def _normalise_bmult_widths(width_a: int, width_b: int) -> tuple[int, int]:
    """Mirror Bmult_RTL_gen's OPA/OPB width selection exactly."""
    if width_a <= 0 or width_b <= 0:
        raise ValueError("operand widths must be positive")

    if width_a % 2 == 0:
        opa_width = width_a
        a_extend_flag = False
    else:
        opa_width = width_a + 1
        a_extend_flag = True

    if width_b % 2 == 0:
        opb_width = width_b
        b_extend_flag = False
    else:
        opb_width = width_b + 1
        b_extend_flag = True

    if opb_width < opa_width:
        opb_width = opa_width
        b_extend_flag = a_extend_flag  # kept to mirror the generator's branch
        opa_width = width_b
    else:
        opa_width = width_a

    _ = b_extend_flag
    return opa_width, opb_width


def build_bmult_bitheap(width_a: int, width_b: int) -> tuple[int, int, list[int]]:
    """Return (internal OPA width, internal OPB width, Booth bit-heap heights)."""
    opa_width, opb_width = _normalise_bmult_widths(width_a, width_b)
    bitheap_list = [0] * (opa_width + opb_width)
    num_rows = opb_width // 2

    for row in range(num_rows):
        for offset in range(opa_width + 2):
            bitheap_list[2 * row + offset] += 1
        bitheap_list[2 * row] += 1
    bitheap_list[opa_width] += 1

    return opa_width, opb_width, bitheap_list


def partial_product_lut_count(width_a: int, width_b: int) -> int:
    """Count physical Versal LUTs used by Booth partial-product generation.

    Two adjacent LUT5 primitives constrained into one dual-5-LUT site count as one
    physical LUT.  The generated structure uses one physical LUT per adjacent
    partial-product pair, plus one boundary LUT per Booth row.
    """
    opa_width, opb_width = _normalise_bmult_widths(width_a, width_b)
    booth_rows = opb_width // 2
    physical_luts_per_row = opa_width // 2 + 1
    return booth_rows * physical_luts_per_row

def is_two_operand_only(terminal_inputs: list[int]) -> bool:
    """Whether every column has at most 2 bits, i.e. the terminal adder is
    a plain 2-operand add with no 3+-operand columns to compress first."""
    return max(terminal_inputs, default=0) <= 2

def two_operand_terminal_lut_count(terminal_inputs: list[int]) -> int:
    """Terminal-adder LUT count for the is_two_operand_only case: one LUT
    per column from the first 2-bit column through the last active one."""
    first_two = next(
        (
            col
            for col, height in enumerate(terminal_inputs)
            if height >= 2
        ),
        None,
    )

    if first_two is None:
        # Every column contains at most one bit:
        # all outputs can be directly wired.
        return 0

    last_active = max(
        col
        for col, height in enumerate(terminal_inputs)
        if height > 0
    )

    return last_active - first_two + 1

def _terminal_adder_lut_count_from_terminal_inputs(terminal_inputs: Sequence[int]) -> int:
    """Mirror terminalAdd_gen's c3_2/c15_3 placement without generating RTL."""
    h = [int(v) for v in terminal_inputs]
    if not h or not any(v >= 2 for v in h):
        return 0
    if any(v < 0 for v in h):
        raise ValueError("terminal input heights must be non-negative")

    if is_two_operand_only(terminal_inputs):
        return two_operand_terminal_lut_count(terminal_inputs)

    num_columns = len(h)
    terminal_add_start = 0
    tail_end = 0
    head_start = num_columns - 1
    terminal_add_end = num_columns - 1

    tail_flag = False
    found_start = False
    for col in range(num_columns):
        if h[col] == 2:
            terminal_add_start = col
            tail_flag = True
            found_start = True
            break
        if h[col] == 3:
            terminal_add_start = col
            # terminalAdd_gen assumes col+1 exists for legal terminal shapes.
            next_h = h[col + 1] if col + 1 < num_columns else 0
            if next_h <= 2:
                tail_flag = True
            found_start = True
            break
        if h[col] >= 4:
            terminal_add_start = col
            found_start = True
            break
    if not found_start:
        return 0

    if tail_flag:
        for col in range(terminal_add_start + 1, num_columns):
            if h[col] >= 3:
                tail_end = col - 1
                break

    head_flag = False
    for col in range(num_columns - 1, terminal_add_start - 1, -1):
        if h[col] == 0 and head_flag is False:
            terminal_add_end = col - 1
            head_start = col - 1
        if h[col] == 1:
            head_flag = True
            head_start = col
        if h[col] >= 2:
            break

    chain1_end_col = head_start - 1 if head_flag else terminal_add_end
    two_op_start = chain1_end_col + 1
    for col in range(chain1_end_col, terminal_add_start - 1, -1):
        if h[col] > 2:
            break
        two_op_start = col
    two_op_cols = list(range(two_op_start, chain1_end_col + 1))

    if two_op_cols:
        end_col_15_3 = two_op_start - 1
    elif head_flag:
        end_col_15_3 = head_start
    else:
        end_col_15_3 = terminal_add_end

    tail_cascade_flag = (
        tail_flag and end_col_15_3 % 2 == tail_end % 2
    )

    # ----------------------------- terminal chain 1 -------------------------
    chain1_luts = 0

    # One c3_2 = one LUT per tail column when the tail belongs to chain 1.
    if tail_cascade_flag:
        chain1_luts += max(0, tail_end - terminal_add_start + 1)

    if tail_cascade_flag:
        body_start = tail_end + 1
    elif tail_flag and not tail_cascade_flag:
        body_start = tail_end + 2
    else:
        body_start = terminal_add_start

    if two_op_cols:
        body_end = two_op_cols[0] - 1
    elif head_flag:
        body_end = head_start
    else:
        body_end = terminal_add_end

    if body_start % 2 == body_end % 2:
        body_start += 1

    col_after_chain1 = body_start
    while col_after_chain1 < body_end:
        # One c15_3 uses two physical LUTs.
        chain1_luts += 2
        col_after_chain1 += 2

    if two_op_cols:
        # One c3_2 = one LUT for every two-operand suffix column.
        chain1_luts += len(two_op_cols)
        col_after_chain1 = two_op_cols[-1]

    # ----------------------------- terminal chain 2 -------------------------
    if tail_flag and not tail_cascade_flag:
        chain2_len = terminal_add_end - terminal_add_start + 1
        chain1_start = tail_end + 2
    elif tail_flag and tail_cascade_flag:
        chain2_len = terminal_add_end - (tail_end + 2) + 1
        chain1_start = terminal_add_start
    else:
        if body_start == terminal_add_start:
            chain2_len = terminal_add_end - (terminal_add_start + 1) + 1
            chain1_start = body_start
        else:
            chain2_len = terminal_add_end - terminal_add_start + 1
            chain1_start = body_start

    if two_op_cols and col_after_chain1 == terminal_add_end:
        chain2_len += 1
    if not two_op_cols and col_after_chain1 > terminal_add_end:
        chain2_len += 1

    # terminalAdd_gen sizes chain 2 so that its final LUT-position counter is
    # exactly chain2_len.  A c3_2 advances one position and c15_3 advances two,
    # therefore chain2_len is exactly the number of physical LUTs in chain 2.
    _ = chain1_start
    chain2_luts = max(0, chain2_len)

    return chain1_luts + chain2_luts


@lru_cache(maxsize=256)
def _analyse_bitheap_cached(heights: tuple[int, ...]) -> _CompressionAnalysis:
    """Run one bit heap through the compressor scheduler and the terminal-
    adder placement mirror, and cache the result by column-height shape."""
    sum_max = sum(height * (1 << col) for col, height in enumerate(heights))
    width_bh = sum_max.bit_length()

    bitheap = BitHeap(width_bh, 0)
    for col, height in enumerate(heights):
        bitheap.add_bits(col, height)

    last_compression_layer_bitheap, raw_counter_list = compressAll(
        bitheap, 0, width_bh - 1, False, False
    )
    counter_list = formGPCChain(raw_counter_list)

    compression_luts = sum(
        counter.LUT_cost
        for layer in counter_list
        for chain in layer
        for counter in chain
    )

    merged_last_stage = False
    if len(counter_list) >= 2:
        merged_last_stage, _ = merge_last_stage(
            last_compression_layer_counter_list=counter_list[-1],
            last_compression_layer_bitheap=last_compression_layer_bitheap,
        )

    terminal_inputs = tuple(
        bitheap.heap[col].number_of_free_bits for col in range(width_bh)
    )
    terminal_luts = _terminal_adder_lut_count_from_terminal_inputs(terminal_inputs)

    return _CompressionAnalysis(
        compression_luts=compression_luts,
        terminal_luts=terminal_luts,
        compression_layers=len(counter_list),
        merged_last_stage=merged_last_stage,
        terminal_inputs=terminal_inputs,
    )


def _analyse_bitheap(bitheap_list: Sequence[int]) -> _CompressionAnalysis:
    """Validate `bitheap_list`, then analyse it (cached)."""
    return _analyse_bitheap_cached(_validate_heights(bitheap_list))


def estimate_cmp_luts(bitheap_list: Sequence[int]) -> LUTBreakdown:
    """LUT count for compressing and terminal-adding an already-built bit
    heap (column heights given directly, no partial-product generation)."""
    analysis = _analyse_bitheap(bitheap_list)
    return LUTBreakdown(
        partial_products=0,
        compression=analysis.compression_luts,
        terminal_adder=analysis.terminal_luts,
        compression_layers=analysis.compression_layers,
        merged_last_stage=analysis.merged_last_stage,
        terminal_inputs=analysis.terminal_inputs,
    )

# (smaller width, larger width, smaller-is-signed, larger-is-signed) ->
# Vivado-measured LUT count. Fill in from report_utilization results; the
# more entries, the more accurate. e.g. if a measured 4x4 signed x signed
# multiplier used 11 LUTs, write:
#     (4, 4, True, True): 11,
_SMALL_MULT_LUT_TABLE: dict[tuple[int, int, bool, bool], int] = {
}

def _small_mult_lut_fallback(
    w_small: int,
    w_large: int,
    *,
    small_signed: bool = True,
) -> int:
    """A conservative upper bound for when there's no measured data
    (leans toward overestimating, never underestimates).

    Basis: a classic array multiplier needs roughly w_small * w_large full
    adders, one LUT each. Vivado's actual result is usually only 60%-85%
    of this number, so this is a safe upper bound.
    """
    return ceil(w_small * w_large)

def estimate_small_multiplier(
    width_a: int,
    width_b: int,
    *,
    a_signed: bool = True,
    b_signed: bool = True,
) -> LUTBreakdown:
    """Estimate the LUTs for Vivado's behavioral multiplier, when min(width) <= 5.

    Takes EXTERNAL widths -- behavioral inference natively supports
    unsigned, so the caller must NOT run this through bmult_inner_widths first.
    """
    if width_a <= 0 or width_b <= 0:
        raise ValueError("operand widths must be positive")

    # sign must be sorted together with width, or they'll be mismatched after the swap
    (w_small, s_small), (w_large, s_large) = sorted(
        ((width_a, a_signed), (width_b, b_signed))
    )

    luts = _SMALL_MULT_LUT_TABLE.get((w_small, w_large, s_small, s_large))
    if luts is None:
        luts = _small_mult_lut_fallback(w_small, w_large, small_signed=s_small)

    return LUTBreakdown(
        partial_products=luts,
        compression=0,
        terminal_adder=0,
        compression_layers=0,
        merged_last_stage=False,
        terminal_inputs=(),
    )

def _estimate_general_bmult_luts(
    width_a: int,
    width_b: int,
) -> LUTBreakdown:
    """The general Booth bit-heap estimator, for widths above the small-
    multiplier threshold (see estimate_bmult_luts)."""
    _, _, bitheap_list = build_bmult_bitheap(
        width_a,
        width_b,
    )
    analysis = _analyse_bitheap(bitheap_list)

    return LUTBreakdown(
        partial_products=partial_product_lut_count(
            width_a,
            width_b,
        ),
        compression=analysis.compression_luts,
        terminal_adder=analysis.terminal_luts,
        compression_layers=analysis.compression_layers,
        merged_last_stage=analysis.merged_last_stage,
        terminal_inputs=analysis.terminal_inputs,
    )

def bmult_inner_widths(
    width_a: int,
    width_b: int,
    *,
    a_signed: bool = True,
    b_signed: bool = True,
) -> tuple[int, int]:
    """Convert the external operand widths into the internal signed x signed core's widths.

    An unsigned input needs a 0 padded onto the high bit to become signed, so its width grows by 1.
    """
    if width_a <= 0 or width_b <= 0:
        raise ValueError("operand widths must be positive")

    if a_signed:
        inner_a = width_a
    else:
        inner_a = width_a + 1

    if b_signed:
        inner_b = width_b
    else:
        inner_b = width_b + 1

    return inner_a, inner_b


def estimate_bmult_luts(
    width_a: int,
    width_b: int,
    *,
    a_signed: bool = True,
    b_signed: bool = True,
) -> LUTBreakdown:
    """Estimate the LUTs for one multiplication rectangle. Two implementation
    routes, chosen by EXTERNAL width:

    min(width) <= 5 -> Vivado's behavioral small multiplier. Natively
                      supports unsigned, no sign-bit padding needed, so it
                      must NOT be run through bmult_inner_widths first.
    otherwise       -> the Booth bmult core. Only does signed x signed;
                      unsigned needs 1 sign bit padded on -- only here does
                      the inner width get used.
    """
    if width_a <= 0 or width_b <= 0:
        raise ValueError("operand widths must be positive")

    if min(width_a, width_b) <= 5:
        return estimate_small_multiplier(
            width_a, width_b, a_signed=a_signed, b_signed=b_signed
        )

    inner_a_width, inner_b_width = bmult_inner_widths(
        width_a, width_b, a_signed=a_signed, b_signed=b_signed
    )
    return _estimate_general_bmult_luts(inner_a_width, inner_b_width)
