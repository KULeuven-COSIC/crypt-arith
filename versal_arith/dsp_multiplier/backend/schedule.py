# core/backend_schedule.py
"""
IR timing analysis: work out which cycle each signal is ready on.

Convention:
  - A top-level Input is ready at cycle 0.
    - Slice is combinational, adds no delay -- ready = max of its input.
  - Sub / DspTile / LutMult / BitHeap have latency -- ready = max of inputs + own latency.
  - Delay (only appears later) -- ready = source + cycles.

This module is read-only: it never modifies an IRModule, only returns a
{signal name: ready} dict.
"""
from __future__ import annotations

import dsp_multiplier.backend.ir as IR

class _DelayNamer:
    """Hands out dly0, dly1, ... Name clashes are a hard error, never
    silently renamed."""

    def __init__(self, module: IR.IRModule, prefix: str = "dly"):
        self._taken = {s.name for s in module.signals()}
        self._prefix = prefix
        self._n = 0

    def fresh(self) -> str:
        name = f"{self._prefix}{self._n}"
        self._n += 1
        if name in self._taken:
            raise ValueError(
                f"Cannot allocate signal name {name!r} for an alignment FF: "
                "that name is already taken. Usually means align_latency was "
                "called twice on the same IRModule."
            )
        self._taken.add(name)
        return name

def compute_ready(module: IR.IRModule) -> dict[str, int]:
    """Returns {signal name: ready cycle}. module.ops is already in
    topological order, so one pass suffices."""
    ready: dict[str, int] = {}

    def r(sig: IR.Signal) -> int:
        # Topological order guarantees a signal has already been computed
        # by the time it's used.
        if sig.name not in ready:
            raise ValueError(f"signal {sig.name!r} used before defined")
        return ready[sig.name]

    for op in module.ops:
        if isinstance(op, IR.Input):
            ready[op.result.name] = 0

        elif isinstance(op, IR.Slice):
            ready[op.result.name] = r(op.source)

        elif isinstance(op, IR.Sub):
            # Tripwire: under the current Walker, minuend/subtrahend are
            # always the same cycle (both slices of the same input pair).
            if r(op.minuend) != r(op.subtrahend):
                raise AssertionError(
                    f"{op.result.name}: Sub's two operands are on different "
                    f"cycles ({op.minuend.name}@{r(op.minuend)} vs "
                    f"{op.subtrahend.name}@{r(op.subtrahend)}). "
                    "The current Walker should never produce this; if it's "
                    "genuinely needed, add alignment FFs here."
                )
            ready[op.result.name] = r(op.minuend) + op.latency

        elif isinstance(op, (IR.DspTile, IR.LutMult)):
            # Tripwire: under the current Walker, both operands are always
            # the same cycle -- a mismatch means the structure changed.
            if r(op.a) != r(op.b):
                raise AssertionError(
                    f"{op.result.name}: operands are on different cycles "
                    f"({op.a.name}@{r(op.a)} vs {op.b.name}@{r(op.b)}). "
                    "The current Walker should never produce this; if it's "
                    "genuinely needed, add alignment FFs here."
                )
            ready[op.result.name] = r(op.a) + op.latency

        elif isinstance(op, IR.BitHeap):
            ready[op.result.name] = max(r(t.signal) for t in op.terms) + op.latency
        elif isinstance(op, IR.Delay):
            ready[op.result.name] = r(op.source) + op.cycles
        else:
            raise TypeError(f"compute_ready: unknown op {type(op).__name__}")

    return ready


def module_latency(module: IR.IRModule) -> int:
    """The module's total latency = the output signal's ready cycle."""
    return compute_ready(module)[module.output.name]




def align_latency(module: IR.IRModule) -> IR.IRModule:
    """Return a new IRModule where each BitHeap's terms have been padded up
       to the heap's latest-ready term. The original module is untouched
       (it's frozen anyway). The same signal padded by the same amount
       reuses one delay chain."""
    ready = compute_ready(module)          # also triggers the same-cycle-operand tripwire asserts
    namer = _DelayNamer(module)

    # existing signal name -> Signal object, so we can look the type back up by name
    sig_by_name: dict[str, IR.Signal] = {s.name: s for s in module.signals()}

    # cache: (source signal name, pad amount) -> the delayed new Signal, to guarantee reuse
    delay_cache: dict[tuple[str, int], IR.Signal] = {}
    new_ops: list[IR.IRNode] = []

    def delayed(sig: IR.Signal, pad: int) -> IR.Signal:
        """The signal for `sig` delayed by `pad` cycles; pad==0 returns it unchanged."""
        if pad == 0:
            return sig
        key = (sig.name, pad)
        if key in delay_cache:
            return delay_cache[key]
        out = IR.Signal(namer.fresh(), sig.width, sig.signed)
        new_ops.append(IR.Delay(result=out, source=sig, cycles=pad))
        delay_cache[key] = out
        return out

    for op in module.ops:
        if not isinstance(op, IR.BitHeap):
            new_ops.append(op)             # keep every other op as-is
            continue

        # this heap's target cycle = the latest ready among its terms
        target = max(ready[t.signal.name] for t in op.terms)

        new_terms: list[IR.WeightedTerm] = []
        for t in op.terms:
            pad = target - ready[t.signal.name]
            src = sig_by_name[t.signal.name]
            aligned = delayed(src, pad)    # may append a new Delay op
            new_terms.append(IR.WeightedTerm(
                signal=aligned, weight=t.weight, negate=t.negate,
            ))

        # build a new BitHeap with the terms replaced and everything else unchanged
        new_ops.append(IR.BitHeap(
            result=op.result,
            terms=tuple(new_terms),
            latency=op.latency,
            sign_mode=op.sign_mode,      # don't drop this -- omitting it silently falls back to "extend"
        ))

    aligned_module = IR.IRModule(
        name=module.name,
        inputs=module.inputs,
        ops=tuple(new_ops),
        output=module.output,
    )
    IR.verify(aligned_module)              # structural self-check: topological, no name clashes, no dangling refs
    return aligned_module
