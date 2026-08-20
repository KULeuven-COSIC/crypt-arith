# core/backend_delay_model.py
"""
The unified ns cost model: given a block and its pipeline depth, return the
fastest it can run in ns. Also carries mode3 (NS_BUDGET) -- the IR-level
orchestration that turns this cost model into a per-module pipeline-stage
assignment; see the "mode3 orchestration" section at the bottom of this
file for that half.

Three dispatch paths:
  DspTile  -> dsp_model.best_*(budget)'s critical_ns
  BitHeap  -> ENTRY + max(intra-segment sum(logic) + intra-segment
             adjacent-unit ROUTE_INTER) + EXIT, segmented per reg_flag_list_gen
  LutMult  -> same as above, plus one extra PP-generation stage in the weight table

Convention: always returns raw datapath ns, excluding clock uncertainty.
      dsp_model.fmax_mhz adds its own 0.150; adding it again here would put
      DSP and bitheap numbers on different scales.
"""
from __future__ import annotations

import warnings
from dataclasses import dataclass, replace
from enum import Enum
from functools import lru_cache

import dsp_multiplier.backend.ir as IR
from dsp_multiplier.backend.schedule import module_latency
from dsp_multiplier.backend.timing.dsp_lib import D as _DSP_D

# ---- Vivado calibration constants (xcv80 -2MHP) ----
#
# Calibrated against measured post-implementation timing, not derived
# analytically. Two things the model previously missed:
#   1. The terminal adder is already segmented (not one long carry chain
#      to the end), so its per-8-bit slope (TERM_PER_CARRY8) is shallower
#      than a naive ripple/lookahead estimate.
#   2. Routing between compression stages (PPGEN->GPC->...->terminal) is
#      a real, significant cost -- ROUTE_INTER accounts for it; earlier
#      versions of this model omitted it entirely and underestimated
#      critical path accordingly.
LOGIC_PPGEN     = 0.13    # measured 0.127, one stage of Booth re-encoding (was 0.15)
LOGIC_GPC       = 0.42    # measured 0.353~0.482 (logic + same-layer internal routing combined), was 0.50
ROUTE_INTER     = 0.36    # new: the routing hop between adjacent units within a segment, entirely absent from the original model
ENTRY           = 0.62    # new: FF clk->Q + the first routing hop, replaces the original ambiguous ROUTE_PER_STAGE
EXIT            = 0.05    # new: the last routing hop up to the next stage's FF setup time
TERM_FIXED      = 0.92    # re-calibrated from measurement (was 0.85, now includes the chain1->chain2 routing hop)
TERM_FIXED_2OP  = 0.55    # 2-operand (sub_signed), no new measurement, kept as-is
TERM_PER_CARRY8 = 0.038   # matches sub_signed (0.041) and the 2-op path (0.037)
TERM_PER_CARRY8_2OP = 0.037   # no data for the 2-operand path, reuses the old slope

DSP_MIN_LATENCY = 1       # combinational-only isn't allowed

# The max number of DSP58s that may be cascaded back-to-back without a
# register within one DSPChain group (direct PCIN/PCOUT connection). This
# is a hard constraint, not a soft preference: beyond this depth,
# synthesis's timing-driven optimization can grind to a near-standstill on
# the long combinational path, and placement has to find that many
# consecutive DSP columns -- both for a marginal payoff of one or two
# fewer pipeline cycles. Limited gain, disproportionate cost -- worth
# treating as a hard cap rather than folding into the ns score for
# comparison.
MAX_CASCADE_DEPTH = 11


def terminal_ns(width: int, two_operand: bool = False) -> float:
    """The final adder's logic+routing delay. The 392-bit (sum33) measured
       3.487 matches ENTRY+GPC+ROUTE_INTER+terminal_ns(392)+EXIT=3.49, an
       error of 0.003. The 2-operand path (two_operand=True) has no new
       measurement data; the slope is reused from the old calibration."""
    if two_operand:
        return TERM_FIXED_2OP + TERM_PER_CARRY8_2OP * -(-width // 8)
    return TERM_FIXED + TERM_PER_CARRY8 * -(-width // 8)


# ---------------------------------------------------------------- weight tables
@lru_cache(maxsize=None)
def _compression_layers(heights: tuple[int, ...]) -> int:
    """Number of compression layers (merge_last_stage already subtracted
       out). The same number computed by RTLInterface._cmp_reg_flags and
       that section of booth_mult.Bmult_RTL_gen."""
    from dsp_multiplier.common.lut_cost import _analyse_bitheap
    a = _analyse_bitheap(list(heights))
    return a.compression_layers - (1 if a.merged_last_stage else 0)


@lru_cache(maxsize=None)
def _term_is_2op(heights: tuple[int, ...]) -> bool:
    """Whether this heap's terminal adder only ever has 2 operands (a
    plain 2-input adder, cheaper than the general case)."""
    from dsp_multiplier.common.lut_cost import _analyse_bitheap
    return max(_analyse_bitheap(list(heights)).terminal_inputs) <= 2


def _bitheap_heights(op: IR.BitHeap) -> tuple[int, ...]:
    """Column heights. Must follow the exact same path as
       RTLInterface._bitheap_columns."""
    cols = IR.lower_bitheap(op.terms, op.result.width, op.sign_mode)
    return tuple(len(bits) for bits in cols)


def _weights(op) -> tuple[float, ...] | None:
    """This block's per-unit weight table (ns). None = not stretchable."""
    if isinstance(op, IR.BitHeap):
        h = _bitheap_heights(op)
        if max(h, default=0) <= 2:
            return None                       # flat addition, the wrapper just issues an adder directly
        w = sum(1 << c for c, n in enumerate(h) for _ in range(n)).bit_length()
        return (*(LOGIC_GPC,) * _compression_layers(h),
                terminal_ns(w, _term_is_2op(h)))

    if isinstance(op, IR.LutMult):
        from rtl_gen.dsp_multiplier.interface import _inner_widths, _is_small_mult
        if _is_small_mult(op):
            return None                       # SmallMult, behavioral-level
        from dsp_multiplier.common.lut_cost import build_bmult_bitheap
        pa, pb = _inner_widths(op)
        _, _, hl = build_bmult_bitheap(pa, pb)
        h = tuple(hl)
        return (LOGIC_PPGEN,
                *(LOGIC_GPC,) * _compression_layers(h),
                terminal_ns(pa + pb, _term_is_2op(h)))

    return None


def _segment_cost(weights: tuple[float, ...], L: int) -> float:
    """Split into L segments using reg_flag_list_gen's grouping rule, and
       return the slowest segment.
       base = n//L, the remainder is distributed to the first few segments
       -- this must match the generator exactly.

       Cramming `size` units into one segment (size>1, i.e. not split by a
       pipeline stage, running merged within one cycle) puts size-1 hops of
       ROUTE_INTER routing between them -- this is the piece the original
       model never accounted for at all (on lut22's 3.976ns path, the
       three routing hops PPGEN->GPC0->GPC1->terminal made up 29%). L<=0
       (pure combinational, no split) is structurally "everything crammed
       into one segment", the same case as L=1, handled uniformly."""
    n = len(weights)
    L = max(1, min(L, n))
    base, rem = divmod(n, L)
    worst, i = 0.0, 0
    for s in range(L):
        size = base + (1 if s < rem else 0)
        seg = weights[i:i + size]
        worst = max(worst, sum(seg) + ROUTE_INTER * max(0, len(seg) - 1))
        i += size
    return ENTRY + EXIT + worst

# ---------------------------------------------------------------- DSP dispatch
_DSP_FAMILY = {
    "SingleDSP":   "single",
    "DSPChain":    "chain",
    "Karatsuba2x2": "k2",
    "Karatsuba3x3": "k3",
    "ToomCook25":  "t25",
}


def dsp_family(params: tuple[tuple[str, object], ...], label: str = "") -> tuple[str, int]:
    """(family, chain_blocks). The name comes from SeedTiles' rtl_module_name.
       Takes op.params itself rather than the whole op -- RTLInterface
       often only has BlockRequest.params (the op has already been
       unpacked and flattened by then); `label` is only used to identify
       which op/block an error is about (e.g. op.impl_id or
       BlockRequest.instance_name)."""
    p = dict(params)
    name = str(p.get("rtl_module_name", ""))
    fam = _DSP_FAMILY.get(name)
    if fam is None:
        raise ValueError(
            f"{label or '(unlabeled)'}: unknown rtl_module_name={name!r}, "
            f"known values are {sorted(_DSP_FAMILY)}"
        )
    return fam, int(p.get("chain_blocks", 1))


def _dsp_family(op: IR.DspTile) -> tuple[str, int]:
    """dsp_family(), reading params straight off a DspTile op."""
    return dsp_family(op.params, op.impl_id)


@lru_cache(maxsize=None)
def _dsp_best(fam: str, blocks: int, budget: int):
    """Calls into dsp_model. Memoized: there are few (family, blocks, budget) combos."""
    from dsp_multiplier.backend.timing import dsp_model as M
    if fam == "single":
        return M.best_single(budget)
    if fam == "chain":
        return M.best_chain(budget, blocks)
    if fam == "k2":
        return M.best_k2(budget)
    if fam == "k3":
        return M.best_k3(budget)
    if fam == "t25":
        return M.best_t25(budget)
    raise ValueError(fam)


DSP_BUDGET_SCAN_CAP = 48   # max cycle budget to scan when computing achievable_latencies, with headroom to spare


def _cascade_depth(cfg: dict) -> int:
    """The longest register-free cascade depth within one DSPChain group.
       Only the chain family's config has "sizes" (DSP count per group);
       single/k2/k3/t25's algorithmic structure never has "arbitrary-length
       back-to-back cascading" to begin with, so they're not subject to
       MAX_CASCADE_DEPTH and this returns 0 (always compliant)."""
    sizes = cfg.get("sizes")
    return max(sizes) if sizes else 0


def _cascade_depth_ok(cfg: dict) -> bool:
    """Whether this config's longest register-free cascade is within MAX_CASCADE_DEPTH."""
    return _cascade_depth(cfg) <= MAX_CASCADE_DEPTH


@lru_cache(maxsize=None)
def achievable_latencies(fam: str, blocks: int) -> tuple[int, ...]:
    """The set of latencies this (family, blocks) can genuinely be built
    at, ascending.

    dsp_model.best_*(budget) is "optimal within budget" -- extra budget
    that buys no improvement just gets absorbed. best_chain(budget=10,
    blocks=11) might actually only use 8 cycles (registers at cycle 9/10
    wouldn't shorten the critical path, so the search simply doesn't
    choose them). In that case latency=9 and 10 aren't two independently
    buildable versions at all -- they're the same thing as latency=8, so
    treating every integer in [lo, hi] as valid isn't safe: it would make
    the RTL generator be asked to build a latency that doesn't actually exist.

    One more hard constraint layered on here: MAX_CASCADE_DEPTH.
    best_chain(budget) picks the ns-optimal option within budget, which can
    save a cycle by stacking a long register-free cascade -- a
    configuration whose datapath delay the ns model can price fine, but
    whose synthesis/placement cost (timing-driven optimization can nearly
    stall, and placement has to find that many consecutive DSP columns) it
    has no visibility into at all. So budgets whose optimal configuration
    would exceed the cascade limit are removed from "achievable" here,
    rather than left for mode3 to pick by ns score alone. This cut is
    conservative: it disqualifies the whole budget even though some other,
    non-optimal configuration at that same budget might have stayed
    compliant -- dsp_model doesn't expose a "suboptimal but compliant"
    candidate to pick instead, so this just blocks the worst cases first."""
    out = []
    for b in range(0, DSP_BUDGET_SCAN_CAP):
        r = _dsp_best(fam, blocks, b)
        if (r is not None and r["latency"] == b and r["latency"] >= DSP_MIN_LATENCY
                and _cascade_depth_ok(r["config"])):
            out.append(b)
    if not out:
        raise ValueError(
            f"{fam}(blocks={blocks}): no feasible configuration found within "
            f"{DSP_BUDGET_SCAN_CAP} cycles (under MAX_CASCADE_DEPTH={MAX_CASCADE_DEPTH})"
        )
    return tuple(out)


@lru_cache(maxsize=None)
def _dsp_lmin(fam: str, blocks: int) -> int:
    """The physically-minimum feasible latency, not subject to
       MAX_CASCADE_DEPTH. Dedicated to dsp_result_by_family's permissive
       clamp -- can't be swapped for achievable_latencies(...)[0]'s
       filtered floor: dsp_result_by_family also has to serve
       exact_dsp_config's check of externally-pinned latencies (mode0),
       which can perfectly well be below the "compliant floor" while still
       being physically buildable (e.g. one that trips the cascade-depth
       limit) -- if this used the filtered floor to clamp via max(), the
       budget would get silently bumped to a higher tier, and
       exact_dsp_config would report "can't be built" instead of what we
       actually want: "can be built, but the cascade is too deep, warning".
       Not hardcoded -- can change whenever the dsp_lib constants do."""
    for b in range(0, DSP_BUDGET_SCAN_CAP):
        r = _dsp_best(fam, blocks, b)
        if r is not None and r["latency"] == b and r["latency"] >= DSP_MIN_LATENCY:
            return b
    raise ValueError(f"{fam}(blocks={blocks}): no feasible configuration found within {DSP_BUDGET_SCAN_CAP} cycles")


# ---------------------------------------------------------------- public interface
def stretchable(op) -> bool:
    """Whether this op's latency can be adjusted at all."""
    if isinstance(op, IR.DspTile):
        return True
    return _weights(op) is not None


def latency_range(op) -> tuple[int, int]:
    """(L_min, L_max). Adding cycles beyond L_max doesn't help. Both ends
       are guaranteed to be values that genuinely exist in
       achievable_latencies (see its docstring)."""
    if isinstance(op, IR.DspTile):
        fam, blocks = _dsp_family(op)
        achievable = achievable_latencies(fam, blocks)
        lo = achievable[0]
        hi = lo
        best = _dsp_best(fam, blocks, lo)["critical_ns"]
        for b in achievable[1:]:             # stop once the curve flattens out
            r = _dsp_best(fam, blocks, b)
            if r is None or r["critical_ns"] >= best - 1e-9:
                break
            best, hi = r["critical_ns"], b
        return lo, hi
    w = _weights(op)
    if w is None:
        return op.latency, op.latency
    return 1, len(w)


def _op_latencies(op) -> tuple[int, ...]:
    """Every latency value this block can genuinely take on independently,
       ascending, for candidates/assign/_min_delay to enumerate over.
       BitHeap/LutMult: every integer in [1, len(weights)] counts
       (_segment_cost can split at any L directly, there's no "budget buys
       nothing" gap). DspTile: only the values in achievable_latencies that
       fall within latency_range -- the budget gaps dsp_model absorbs in
       between can't be enumerated as independent points, or they'd
       disagree with dsp_result's real latency."""
    if isinstance(op, IR.DspTile):
        fam, blocks = _dsp_family(op)
        lo, hi = latency_range(op)
        return tuple(L for L in achievable_latencies(fam, blocks) if lo <= L <= hi)
    w = _weights(op)
    if w is None:
        return (op.latency,)
    return tuple(range(1, len(w) + 1))


def dsp_result_by_family(fam: str, blocks: int, latency: int, *,
                         label: str = "") -> dict:
    """Same as dsp_result, but takes (family, blocks) directly instead of a
       DspTile op -- RTLInterface only has a BlockRequest, not the original
       op. `latency` is treated as a budget: extra that buys nothing gets
       absorbed by dsp_model itself (result["latency"] may come back lower
       than the latency passed in); this isn't checked here -- it's the
       permissive version, meant for latency_range's curve scan. Use
       exact_dsp_config when "must equal exactly" is required."""
    r = _dsp_best(fam, blocks, max(latency, _dsp_lmin(fam, blocks)))
    if r is None:
        raise ValueError(f"{label or fam}: latency={latency} has no feasible configuration")
    return r


def exact_dsp_config(fam: str, blocks: int, latency: int, *, label: str = "") -> dict:
    """Requires `latency` to be a number that's genuinely buildable, not
    just "budget was generous enough".

    The optimal configuration dsp_model gives for a (family, blocks) is
    "optimal within budget" -- extra budget that buys no improvement gets
    absorbed. E.g. for DSPChain blocks=11, budget=9/10/11 all compute an
    optimal configuration that actually only needs 8 cycles. If latency=9
    were handed straight to the RTL generator in that case, the generator
    would honestly build a circuit that only needs 8 cycles, which
    wouldn't match the 9 cycles recorded in IR/Schedule -- the whole
    schedule would be wrong. So this must explicitly reject rather than
    silently absorb the extra budget.

    Under mode0, a DSP tile's cycle count is pinned externally (by
    SeedTiles/TileLatencyConfig) and never passes through the
    achievable_latencies filter, so this check mainly exists to guard
    those; mode3's assign() already only picks from achievable_latencies,
    so in theory this should never trigger there.

    Cascade depth (MAX_CASCADE_DEPTH) only warns, doesn't reject -- unlike
    "can't be built at all", an over-deep cascade is "buildable, but
    synthesis/placement will have a rough time" (see MAX_CASCADE_DEPTH's
    definition above). achievable_latencies has already filtered this
    class of configuration out for mode3, but mode0's latency comes pinned
    straight from SeedTiles, never passing through achievable_latencies,
    so it can still hit the same pothole -- hence the warning here, rather
    than letting it be discovered only at synthesis time."""
    r = dsp_result_by_family(fam, blocks, latency, label=label)
    if r["latency"] != latency:
        raise ValueError(
            f"{label or fam}: latency={latency} cannot be built -- the optimal "
            f"configuration dsp_model gives for (family={fam!r}, blocks={blocks}) "
            f"within this budget actually only needs {r['latency']} cycles "
            f"(the extra budget buys no improvement and was absorbed). "
            f"Use latency={r['latency']} instead, or check "
            f"achievable_latencies({fam!r}, {blocks}) for which "
            f"cycle counts are genuinely buildable: {achievable_latencies(fam, blocks)}"
        )
    depth = _cascade_depth(r["config"])
    if depth > MAX_CASCADE_DEPTH:
        warnings.warn(
            f"{label or fam}: (family={fam!r}, blocks={blocks}) at latency="
            f"{latency} has a longest register-free cascade depth of {depth}, "
            f"exceeding MAX_CASCADE_DEPTH={MAX_CASCADE_DEPTH}. This latency is "
            f"pinned externally (didn't go through the achievable_latencies "
            f"filter); synthesis/placement will likely be slow. It's not "
            f"unbuildable, just likely to be painful to get through; consider "
            f"using a higher tier from achievable_latencies({fam!r}, {blocks}) instead.",
            stacklevel=2,
        )
    return r


def dsp_result(op, latency: int) -> dict:
    """DspTile-specific: dsp_model's full result dict
       (config/critical_ns/fmax_mhz/...), not the single number delay_ns
       distills it down to. Once mode3 has picked a latency, actually
       regenerating this block's .sv via the RTL generators
       (gen_dsp_chain / gen_karatsuba2 / gen_karatsuba3 / gen_toomcook25)
       takes its cfg from this function's result["config"] -- those
       generators don't accept a plain latency integer, only this config.
       Permissive, doesn't check for an exact match; use exact_dsp_config
       when the caller needs a strict match."""
    if not isinstance(op, IR.DspTile):
        raise TypeError(f"dsp_result: {op!r} is not a DspTile")
    fam, blocks = _dsp_family(op)
    return dsp_result_by_family(fam, blocks, latency, label=op.impl_id)


def delay_ns(op, latency: int) -> float:
    """The fastest this block can run (raw datapath ns) at `latency` pipeline stages."""
    if isinstance(op, IR.DspTile):
        return dsp_result(op, latency)["critical_ns"]
    w = _weights(op)
    if w is None:
        return ENTRY + EXIT             # not stretchable; a placeholder value that never enters the search
    return _segment_cost(w, latency)


# ---------------------------------------------------------------- mode3: three-tier pruning to find the Pareto frontier
#
# mode2 (the old BUDGET mode, retired) used the units/depth abstract proxy: each
# block's "segment count" was approximated as ceil(units/D), and D was
# found by binary-searching total latency. This file replaces that with
# the real ns model (delay_ns / latency_range / stretchable), computing
# every Pareto-optimal point on the "per-stage budget D -> total latency T"
# curve directly, with no per-T binary search.
#
# Three cuts; the proof is in the design discussion, this is just the
# implementation:
#   pruning tier 0 (active-block filter): blocks with delay(L_min) <=
#                       D_floor stay pinned at L_min for any D >= D_floor,
#                       so they neither need to be a candidate nor take
#                       part in computing the "actual worst-case value".
#   pruning tier 1 (candidate lower bound): candidates D < D_floor are
#                       strictly dominated by the floor (assigning at that
#                       D always achieves an actual worst-case value equal
#                       to D_floor), so they're dropped outright.
#   pruning tier 2 (jump): once assign(D) computes the actual worst-case
#                       value W, every candidate in [W, D) gives exactly
#                       the same assignment (bounded both ways: the subset
#                       relationship guarantees >=, W's definition
#                       guarantees <=), so the next meaningful candidate is
#                       "the largest candidate strictly less than W".


def _min_delay(op) -> float:
    """The minimum of delay(L) over the entire feasible latency range
    (doesn't assume which L achieves it)."""
    return min(delay_ns(op, L) for L in _op_latencies(op))


def d_floor(ops) -> float:
    """D_floor = the overall worst-case once every block is stretched to
    its own fastest version."""
    stretch = [op for op in ops if stretchable(op)]
    if not stretch:
        return 0.0
    return max(_min_delay(op) for op in stretch)


def fmax_hint(critical_ns: float) -> float:
    """A rough MHz figure for floor_report's printout only, excluding
       clock uncertainty (the real Fmax is up to the caller to compute
       with their own CLK_UNCERTAINTY, see NsParetoPoint.fmax_mhz below).
       critical_ns<=0 is treated as combinational."""
    return 1000.0 / critical_ns if critical_ns > 0 else float("inf")


def floor_report(ops) -> str:
    """A byproduct of the three-tier pruning: which block is pinning the
       floor, and how many blocks are still worth looking at. This one line
       of diagnostic info is worth more than the curve itself -- it tells
       you directly "change this if you want it faster" and "changing
       anything else is wasted effort"."""
    stretch = [op for op in ops if stretchable(op)]
    if not stretch:
        return "No stretchable blocks -- every stage count in this pipeline is externally given."

    floor = d_floor(stretch)
    active = active_blocks(stretch, floor)
    culprits = [op for op in stretch if abs(_min_delay(op) - floor) < 1e-9]
    names = ", ".join(op.result.name for op in culprits[:5])
    if len(culprits) > 5:
        names += f" and {len(culprits)} others"

    idle = len(stretch) - len(active)
    lines = [
        f"Floor D_floor = {floor:.3f} ns ({fmax_hint(floor):.0f} MHz, excluding clock margin), "
        f"pinned by {names}",
        f"Active blocks {len(active)}/{len(stretch)}"
        + (f" -- the other {idle} block(s) are already below the floor at their own L_min, nothing to move"
           if idle else " -- every block still has room to stretch"),
    ]
    if active:
        lines.append("The only leverage to break through this floor is: " +
                     ", ".join(op.result.name for op in active) +
                     "; adjusting anything else won't help.")
    return "\n".join(lines)


def active_blocks(ops, floor: float | None = None) -> list:
    """Pruning tier 0. Blocks whose delay(L_min) is already <= the floor
       never need to move for any D>=D_floor, so they're removed from both
       the candidate set and the "actual worst-case value" computation."""
    if floor is None:
        floor = d_floor(ops)
    out = []
    for op in ops:
        if not stretchable(op):
            continue
        lo, _ = latency_range(op)
        if delay_ns(op, lo) > floor + 1e-9:
            out.append(op)
    return out


def candidates(ops, floor: float | None = None) -> list[float]:
    """Pruning tier 1. Only collects delay(L) values contributed by active
    blocks that are >= D_floor, descending."""
    if floor is None:
        floor = d_floor(ops)
    vals = set()
    for op in active_blocks(ops, floor):
        for L in _op_latencies(op):
            v = delay_ns(op, L)
            if v >= floor - 1e-9:
                vals.add(round(v, 9))
    return sorted(vals, reverse=True)


def assign(ops, D: float) -> dict[str, int]:
    """Given a per-stage budget D: each stretchable block takes the
       smallest latency satisfying delay(L) <= D (fewer segments is
       better); if the block can't get under D no matter what, it falls
       back to the best it can offer (L_max). Non-stretchable blocks don't
       appear in the returned table -- the caller keeps their original latency."""
    table: dict[str, int] = {}
    for op in ops:
        if not stretchable(op):
            continue
        levels = _op_latencies(op)
        chosen = levels[-1]
        for L in levels:
            if delay_ns(op, L) <= D + 1e-9:
                chosen = L
                break
        table[op.result.name] = chosen
    return table


def worst_ns(active: list, table: dict[str, int]) -> float:
    """After assign, the worst-case delay actually achieved among the
    active blocks (W in the algorithm)."""
    if not active:
        return 0.0
    return max(delay_ns(op, table[op.result.name]) for op in active)


def pareto_frontier(ops, measure_latency):
    """
    The three-tier pruning main loop.

    measure_latency: dict[str,int] (result name -> latency) -> int (total
    latency in cycles). This step has to feed the table back into an
    IRModule to redo BitHeap alignment and run Schedule.module_latency --
    it operates on the IR, not a single op, so it's supplied by the caller
    (ns_pareto_frontier, below).

    Returns [(D, W, T, table), ...] in descending W order:
      D     -- the per-stage budget candidate that triggered this point
      W     -- the actual worst single-stage delay (ns) assign(D) achieves
      T     -- the corresponding total latency (cycles)
      table -- the {result name: latency} assign(D) produced
    The first entry wants the shortest total latency; the last sits
    against the floor, wanting the highest Fmax.

    The three-tier pruning only guarantees W strictly decreases round over
    round (each round asks for a new, genuinely-achievable worst-case
    delay) -- it does not guarantee T rises strictly in step. The same T
    can perfectly well show up in two different rounds, and only the round
    with the better W is worth keeping: if a later round (W2,T2) has
    W2<=W1 and T2<=T1, the earlier round (W1,T1) is strictly worse and
    nobody would choose it. The step below doesn't run any more
    evaluations, it just drops these dominated points so the returned
    curve is a genuine Pareto frontier.
    """
    floor = d_floor(ops)
    active = active_blocks(ops, floor)
    cands = candidates(ops, floor)

    if not cands:                       # no active blocks: the whole design is already at the floor, nothing left to move
        table = assign(ops, floor)
        return [(floor, floor, measure_latency(table), table)]

    curve = []
    D = cands[0]
    while True:
        table = assign(ops, D)
        W = worst_ns(active, table)
        T = measure_latency(table)
        curve.append((D, W, T, table))
        if W <= floor + 1e-9:
            break
        nxt = [c for c in cands if c < W - 1e-9]
        if not nxt:
            break
        D = nxt[0]
    return _drop_dominated(curve)


def _drop_dominated(curve):
    """`curve` is already sorted by descending W. Scan from best W (the
       tail) to worst W (the head), keeping only points whose T is
       strictly below the smallest T seen so far -- anything beaten by a
       point that's equally fast or faster and also cheaper in cycles gets
       dropped."""
    kept = []
    best_T = float("inf")
    for point in reversed(curve):
        T = point[2]
        if T < best_T:
            kept.append(point)
            best_T = T
    kept.reverse()
    return kept


# ============================================================================
# mode3 orchestration: turn the cost model above into a per-module
# pipeline-stage assignment
#
# Everything above this line is the pure ns cost model, agnostic of IR.
# What follows is the thin IR-aware shell around it: turning
# pareto_frontier's raw (D, W, T, table) tuples into IRModule-carrying
# NsParetoPoint objects, and providing the public entry points
# (ns_pareto_frontier / select_ns_point / ns_budget_latency) the rest of
# the pipeline calls.
#
# Call order (don't reverse it):
#     build_ir -> ns_budget_latency -> align_latency -> emit_systemverilog
#
# mode0 (FIXED) = never calls this section at all; latency comes entirely
#               from SeedTiles/config, passed through unchanged. Kept
#               purely for debugging: use it to bypass mode3's Pareto
#               search and see what the "pinned" configuration looks like.
#
# mode3 (NS_BUDGET) = the default mode. Uses the real ns model above, no
#               guessing, no searching: pareto_frontier's three-tier
#               pruning finds every Pareto-optimal point on the "per-stage
#               budget D -> total latency T" curve in one pass. Point
#               selection defaults to the minimum worst_ns (highest Fmax,
#               i.e. shortest critical path); to cap total cycles instead,
#               pass total_latency_budget to select_ns_point /
#               ns_budget_latency, which then picks the minimum-worst_ns
#               point within budget.
#
# (mode1 STRETCH / mode2 BUDGET, the units/depth abstract-proxy modes, have
# been retired -- fully superseded by mode3's real ns model plus a strict
# Pareto frontier; see git history for the old implementation.)
# ============================================================================

NOT_STRETCHABLE = "not_stretchable"
INF = float("inf")
_CLK_UNCERTAINTY = _DSP_D["CLK_UNCERTAINTY"]   # this module deliberately excludes it above; added back here when reporting Fmax


class LatencyMode(Enum):
    FIXED     = "fixed"       # mode0: latency comes entirely from config, untouched (debugging)
    NS_BUDGET = "ns_budget"   # mode3: this module's real ns model (default)


@dataclass(frozen=True)
class NsStretchRecord:
    """mode3's version of StretchRecord: units are real ns, not abstract depth."""
    signal: str
    kind: str              # "bitheap" / "lut_mult" / "dsp_tile"
    old_latency: int
    new_latency: int
    old_ns: float
    new_ns: float

    @property
    def extra(self) -> int:
        return self.new_latency - self.old_latency


@dataclass(frozen=True)
class NsParetoPoint:
    """One point on the Pareto frontier: the (worst-case ns, total latency)
    actually achieved at some per-stage budget D."""
    budget_ns: float             # the candidate budget D that triggered this point (one of candidates()'s values)
    worst_ns: float              # the worst per-stage delay assign(D) actually achieves (W in the algorithm)
    fmax_mhz: float              # 1000/(worst_ns + CLK_UNCERTAINTY)
    latency: int                 # the corresponding total latency (cycles)
    module: IR.IRModule          # a new module with every block's latency set per this point
    records: tuple[NsStretchRecord, ...]

    @property
    def moved(self) -> tuple[NsStretchRecord, ...]:
        """Blocks whose latency changed -- unlike mode2, mode3 doesn't only
           ever add cycles: a block's latency in the globally-optimal
           combination can end up lower than what the module came in with
           (see ns_pareto_frontier's docstring). extra>0 means extra cycles
           were spent to buy Fmax; extra<0 means the original configuration
           was already spending cycles for nothing. Both count as "moved"."""
        return tuple(r for r in self.records if r.extra != 0)


def _kind_of(op) -> str:
    """Classify an op for NsStretchRecord.kind."""
    if isinstance(op, IR.BitHeap):
        return "bitheap"
    if isinstance(op, IR.LutMult):
        return "lut_mult"
    if isinstance(op, IR.DspTile):
        return "dsp_tile"
    return NOT_STRETCHABLE


def _assign_ns_table(module, table: dict[str, int]) -> IR.IRModule:
    """Apply the {result name: latency} table produced by assign() back onto
       an IRModule. Ops the table doesn't mention are kept as-is --
       non-stretchable blocks never make it into the table anyway."""
    new_ops = [
        op if (L := table.get(op.result.name)) is None or L == op.latency
        else replace(op, latency=L)
        for op in module.ops
    ]
    return IR.IRModule(name=module.name, inputs=module.inputs,
                       ops=tuple(new_ops), output=module.output)


def ns_floor_report(module) -> str:
    """A thin shell hooking floor_report -- the three-tier pruning's
       diagnostic byproduct -- up to a module: call this when you just want
       to see where the floor is and what's pinning it, without running the
       whole Pareto frontier first."""
    ops = [op for op in module.ops
           if isinstance(op, (IR.BitHeap, IR.LutMult, IR.DspTile))]
    return floor_report(ops)


def ns_pareto_frontier(module) -> list[NsParetoPoint]:
    """mode3. Runs pareto_frontier's three-tier pruning, finding every
       Pareto-optimal point on the "per-stage budget D -> total latency T"
       curve in one pass -- no need to binary-search T one value at a time.

       Returned in descending worst_ns order: the first point has the
       shortest total latency, the last point sits right against this
       module's hard d_floor, with the highest Fmax.

       Note that assign() re-searches from latency_range(op)'s global lower
       bound and ignores whatever latency the module came in configured
       with -- if a block was already over-configured (e.g. SeedTiles'
       default DSP cycle count is more conservative than delay_ns actually
       needs), it gets pulled back down to the true minimum, and extra can
       be negative (see NsStretchRecord.extra / NsParetoPoint.moved).
       That's not a bug: the algorithm's definition of the floor is
       "re-find the fastest version of every block from delay(L)", not
       "only ever add on top of the existing configuration"."""
    if any(isinstance(op, IR.Delay) for op in module.ops):
        raise ValueError(
            "ns_pareto_frontier must be called before align_latency: "
            "the module already has Delay ops, so the order is backwards."
        )

    ops = [op for op in module.ops
           if isinstance(op, (IR.BitHeap, IR.LutMult, IR.DspTile))]
    old_latency = {op.result.name: op.latency for op in ops}

    def measure(table):
        return module_latency(_assign_ns_table(module, table))

    curve = pareto_frontier(ops, measure)

    points = []
    for D, W, T, table in curve:
        new_module = _assign_ns_table(module, table)
        IR.verify(new_module)
        records = tuple(
            NsStretchRecord(
                signal=op.result.name, kind=_kind_of(op),
                old_latency=old_latency[op.result.name],
                new_latency=table[op.result.name],
                old_ns=delay_ns(op, old_latency[op.result.name]),
                new_ns=delay_ns(op, table[op.result.name]),
            )
            for op in ops if op.result.name in table
        )
        points.append(NsParetoPoint(
            budget_ns=D, worst_ns=W,
            fmax_mhz=1000.0 / (W + _CLK_UNCERTAINTY) if W > 0 else INF,
            latency=T, module=new_module, records=records,
        ))
    return points


def select_ns_point(points: list[NsParetoPoint],
                    total_latency_budget: int | None = None) -> NsParetoPoint:
    """Pick one point off an already-computed frontier (ns_pareto_frontier's
       return value). Split out on its own so a caller can print/inspect
       the whole frontier first and decide afterward, without recomputing it.

       total_latency_budget=None (default) = no cycle cap, just take the
       minimum-worst_ns point outright (highest Fmax, i.e. shortest
       critical path). With a budget given, restrict to points with
       latency <= budget and still pick the minimum-worst_ns one among
       those -- the highest Fmax the budget can buy."""
    if not points:
        raise ValueError("No active blocks -- the cost model considers the whole pipeline non-stretchable")
    if total_latency_budget is None:
        return min(points, key=lambda p: p.worst_ns)
    feasible = [p for p in points if p.latency <= total_latency_budget]
    if not feasible:
        raise ValueError(
            f"Budget T={total_latency_budget} doesn't even reach the frontier's shortest-latency point; "
            f"need at least {min(p.latency for p in points)} cycles"
        )
    return min(feasible, key=lambda p: p.worst_ns)


def ns_budget_latency(module, total_latency_budget: int | None = None) -> NsParetoPoint:
    """mode3's budget shell: computes the frontier + select_ns_point in one
       call, for callers who don't care about the whole curve and just want
       one point."""
    return select_ns_point(ns_pareto_frontier(module), total_latency_budget)


def print_ns_pareto_report(points: list[NsParetoPoint]) -> None:
    """One line per frontier point: D_floor is the worst_ns the last line sits against."""
    floor = points[-1].worst_ns if points else 0.0
    print(f"D_floor = {floor:.3f} ns   ({len(points)} Pareto-optimal point(s) -- "
          f"the three-tier pruning only evaluates a little more than this many times: "
          f"each budget round asks for a new, genuinely-achievable worst-case delay, "
          f"and this just drops the ones that turned out equally fast but pricier in cycles)")
    print(f"\n{'worst_ns':>9} {'fmax_mhz':>9} {'latency':>8}  blocks moved (may be spending extra cycles for Fmax, or discovering the original config was over-provisioned)")
    for p in points:
        mark = " <-floor" if abs(p.worst_ns - floor) < 1e-9 else ""
        moved = ",".join(f"{r.signal}:{r.old_latency}->{r.new_latency}"
                         for r in p.moved) or "none"
        print(f"{p.worst_ns:9.3f} {p.fmax_mhz:9.1f} {p.latency:8d}{mark}  {moved}")
