# Refactor backlog

Known duplications and rough edges, recorded deliberately rather than fixed in
passing. Each entry says *what*, *why it was deferred*, and *what gates the fix*.

The recurring reason for deferral: the butterfly and NTT paths are validated on
hardware, and the multiplier modeling work (see `docs/USAGE.md` and
`versal_arith/docs/USAGE.md`) was scoped **additive-only** so it could not
destabilize them. These items become safe to do once the new models are proven.

---

## 1. Heap-builder bodies still live in `rtl_gen/butterfly.py`

`versal_arith/rtl_gen/heap_terms.py` currently *imports* three private functions
from `rtl_gen/butterfly.py` and re-exports them under public names:

| private, in `butterfly.py` | public, via `heap_terms` |
|---|---|
| `_emit_term_bits` (`butterfly.py:35`) | `emitTermBits` |
| `_build_heap_descriptors` (`butterfly.py:136`) | `buildHeapDescriptors` |
| `_bit_assign` (`butterfly.py:310`) | `bitAssign` |

Reaching across modules for private names is a smell. It was chosen over copying
~180 lines so there is exactly one implementation of the Baugh-Wooley bit
placement.

**Fix:** move the three bodies into `heap_terms.py`; have `butterfly.py` import
them back. Because every new module already imports only from `heap_terms`, the
change touches `butterfly.py` and nothing else.

**Gate:** regenerate one butterfly and one n=128 NTT; the emitted `.sv` must diff
byte-identical against a pre-change run.

---

## 2. `GoldilocksSlice64.propagateValue` duplicates three things

`NTT_modeling/ButterflyScheme.py:250` independently re-implements:

- the slicing logic that `_shiftAndSliceTerms` already does for the bound path;
- the twiddle lift, duplicating `_liftTwiddle` (`ButterflyScheme.py:88`);
- the `limbs64` table, as a local copy of the class-level `_LIMBS64`
  (`ButterflyScheme.py:80`).

~120 lines that must stay in lockstep with the bound path by hand. The bound path
and the RTL spec cannot drift, because both derive from `_buildSliceTerms`
(`ButterflyScheme.py:157`) — but the value path can.

**Fix:** rewrite it on `NTT_modeling.terms.sumTermsValue`, so the value path
consumes the same `SliceTerm` list the bound path and spec do:

```python
def propagateValue(self):
    super().propagateValue()
    aTerms, bTerms, _ = self._buildSliceTerms()
    env = {'aIn': self.aInValues, 'bIn': self.bInValues}
    return sumTermsValue(aTerms, env, n), sumTermsValue(bTerms, env, n)
```

**Prerequisite:** `_buildSliceTerms` needs `IntType` inputs, but `propagateValue`
currently holds `list[int]` in the *same* `aIn`/`bIn` attributes. Split them into
`aIn`/`aInValues` as `OperatorScheme` does, with `Butterfly.compute()`
(`NTT_modeling/Butterfly.py:96-113`) writing both. `aInBitWidth`/`bInBitWidth`
then become redundant and can go.

**Subtlety to verify, not assume:** `term.isSigned` would replace
`propagateValue`'s current `isBoundary = (sliceEnd == end)`. These should agree in
every reachable case, but that is exactly the kind of claim that needs a
byte-identical testvector diff rather than a code review.

**Gate:** `verifyNtt` / `verifyIntt` at n=128, plus byte-identical testvectors from
a full `emitRtl` run.

---

## 3. Layer counting is copy-pasted four times

The same ~14 lines — `compressAll` → `formGPCChain` → `merge_last_stage`, then
`n_layers -= 1` on a successful merge and `+= 1` for the terminal adder — appear at:

- `versal_arith/rtl_gen/const_mult.py:258`
- `versal_arith/rtl_gen/booth_mult.py:306` (uses `+= 2`: an extra layer for
  partial-product generation)
- `versal_arith/rtl_gen/butterfly.py:248`
- `versal_arith/rtl_gen/heap_terms.py::countCompressionLayers` — added by the
  multiplier work, making it four

**Fix:** point the other three at `countCompressionLayers`, whose `terminalLayers`
parameter already covers the bmult variant.

**Gate:** same byte-identical regeneration as item 1.

---

## 4. `emitRtl` boilerplate is duplicated, and the ABC is incomplete

`GoldilocksSlice64.emitRtl` (`ButterflyScheme.py:376`) and
`FullyPipelinedNTT.emitRtl` (`NTT.py:671`) are ~90% the same sequence: mkdir →
`getOperatorInterface` → obtain goldens → lazy backend import → `os.chdir` in
try/finally → call the generator → sanity check → return meta.

Separately, `ButterflyScheme` declares `propagateBound` / `propagateValue` /
`areaCost` abstract but **not** `getOperatorInterface` or `emitRtl`, which exist
only on the concrete subclass. `areaCost` on `GoldilocksSlice64`
(`ButterflyScheme.py:372`) is a bare `pass` that exists solely to make the class
instantiable.

**Fix:** reparent `ButterflyScheme` onto `NTT_modeling.OperatorScheme`, which
declares all five and carries the shared helpers (`runInDir`, `resolveBackend`,
`sampleBound`, `readHexBatch`). Give `GoldilocksSlice64` a real `areaCost` using
the same GPC-cost machinery the multiplier models use.

**Gate:** as item 1.

---

## 5. Retire the legacy scalar cmult path

Once nothing depends on it:

- delete `_output_int_type` (`const_mult.py:75`) and `_output_width`
  (`const_mult.py:60`) — superseded by `IntType` arithmetic in the model;
- delete `loadBoundsJson`'s schema-1 branch (`NTT_modeling/IntType.py:178`),
  including the one-bit widening workaround;
- decide whether `cli.py -operator cmult/cmultbank` keeps the scalar entry points
  or moves onto the spec path.

**Why the widening exists:** the generator sizes ports from `width_a` alone. A
25 288-combination sweep found it is **never narrower** than `IntType`, and wider
in 783 cases — all of them signed input with a positive power-of-two constant,
where `_output_width`'s `max_abs.bit_length() + 1` and `IntType.bitWidth`'s
`max((-min-1).bit_length(), max.bit_length()) + 1` differ by one. Safe, but
permanently one bit fat on those ports.

**Blocker:** `cli.py` and the checked-in ARITH 2026 evaluation examples both use
the scalar path. Do not remove it while those must reproduce byte-for-byte.

---

## 6. `reg_flag_list_gen(0, n)` raises `ZeroDivisionError`

`versal_arith/rtl_gen/compressor.py:10` divides by `pipeline_stages`, so passing
`0` crashes — even though `cli.py:85-86` advertises "0 = pure combinational".
Related: requesting more stages than there are layers silently clamps to
`min(pipeline_stages, num_layers)`, which is reasonable but undocumented.

**Fix:** a two-line guard raising `ValueError`, plus a docstring line about the
clamp. The multiplier models validate `pipelineStages >= 1` on their own side
meanwhile.

---

## 7. Two independent NAF modulus-lift implementations

- `NTT_modeling/utils.py:97` `nafTermsModulusLift` — exact target-first search
  with a beam-search fallback.
- `versal_arith/power_writer.py:61` `reduce_mod_q_min_powers_lift` — beam search
  only.

**Deliberately kept separate.** They sit on opposite sides of the subproject
boundary: `power_writer` belongs to the standalone `versal_arith` CLI, and having
it import `NTT_modeling` would invert the documented dependency direction (see
`CLAUDE.md`, "Cross-project conventions"). The modeling layer always uses the
`NTT_modeling` one and bakes the resulting NAF into the spec, so a spec-driven
generator never lifts at all.

**Action:** not a merge — just a cross-reference in both docstrings so the next
reader knows the other exists and why.
