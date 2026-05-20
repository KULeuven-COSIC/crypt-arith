# NTT Modeling — Theory and Implementation Notes

This document covers the mathematical and architectural foundations of the library: the Goldilocks field, NAF / modulus lifting, IntType bound propagation, the cyclic and negacyclic NTT algorithms, the CT / GS topology choices, and the hardware-level reductions used by the GoldilocksSlice64 scheme. The centerpiece is **Section 7 — Negacyclic twiddle derivation**, which fully derives why the per-butterfly NWC twiddle in CT topology is `ψ^((2j+1)·stepExp)`.

For practical "how do I use this" material, see `USAGE.md`.

---

## 1. The Goldilocks prime and modular arithmetic

The library targets the prime

```
q = 2^64 - 2^32 + 1
```

This is the "Goldilocks prime" — chosen because the following identities make modular reduction implementable with a few shifts and additions, no general multipliers:

```
2^64  ≡ 2^32 - 1   (mod q)
2^96  ≡ -1         (mod q)
2^128 ≡ -2^32      (mod q)
2^160 ≡ -2^32 + 1  (mod q)
2^192 ≡ 1          (mod q)
```

These four identities partition any integer into 192-bit blocks, with each block reducing to a signed sum of two 64-bit limbs (one shifted by 0, one by 32). The `GoldilocksSlice64.propagateBound` method encodes this as the `limbs64` table:

```python
limbs64 = (
    ((0,   63),  ((0, +1),)),                  # bits  [0:63]   * 2^0   = 1
    ((64,  95),  ((0, -1), (32, +1))),         # bits  [64:95]  * 2^64  = -1 + 2^32
    ((96,  159), ((0, -1),)),                  # bits  [96:159] * 2^96  = -1
    ((160, 191), ((0, +1), (32, -1))),         # bits  [160:191]* 2^160 = 1 - 2^32
)
```

Also useful: `q - 1 = 2^32 · (2^32 - 1)`, so the multiplicative group of `F_q` has 2-power roots of unity up to order `2^32` — enough for any reasonable NTT size, including the negacyclic case which needs `ψ` of order `2N`.

---

## 2. NAF (non-adjacent form) and modulus lifting

A constant multiplier `c · x` in hardware is far cheaper if `c` is expressible as a small number of signed shifts: `c · x = ±x<<a₁ ±x<<a₂ ±…`. The non-adjacent form (NAF) gives the shortest such representation in the absence of any other constraint:

```python
nafTerms(c) -> [(sign, exponent), ...]    # each sign in {-1, +1}, exponents distinct
```

For an arbitrary 64-bit constant, NAF averages ~21 terms — too many. But for twiddles, we have *modulus freedom*: we only need a value congruent to `c` mod q. So we search for a "lifted" `y ≡ c (mod q)` whose NAF has fewer terms.

`utils.nafTermsModulusLift` does this lift in two phases:

1. **Target-first search** (`nafTermsModulusLiftTargetFirstSearch`): enumerate all sums of `k = 1, 2, …, maxNumberOfTerms` signed powers of 2 with exponents up to `maxPower`. Return the first one congruent to `c (mod q)`. Exhaustive but bounded.

2. **Beam search fallback** (`nafTermsModulusLiftBeamSearch`): if target-first fails, walk a beam of `(c + k·q · 2^j)` candidates, scoring by NAF term count.

For Goldilocks twiddles called with `maxNumberOfTerms=3, maxPower=95, maxMultipleOfModulus=2^32`, the target-first phase typically succeeds — so each twiddle becomes ≤3 shift-add ops, matching a hardware multiplier-add unit's capacity.

---

## 3. IntType — interval bounds with trailing-zero tracking

`IntType(minValue, maxValue, zeroLsbs)` is the workhorse abstraction. It represents:

- An integer interval `[minValue, maxValue]` (signed if `minValue < 0`).
- A count `zeroLsbs` of guaranteed-zero least-significant bits.

Arithmetic is bound propagation, NOT concrete values:

| Operator | Semantics |
|----------|-----------|
| `a + b`  | `[a.min + b.min, a.max + b.max]`, `zeroLsbs = min(a.zeroLsbs, b.zeroLsbs)` |
| `a - b`  | `[a.min - b.max, a.max - b.min]` |
| `a * b`  | Worst-case product over four corners; `zeroLsbs` adds. |
| `a << k` | Both bounds shift left; `zeroLsbs += k`. |
| `a >> k` | Bounds floor-divide by `2^k`; `zeroLsbs = max(0, zeroLsbs - k)`. |

`bitWidth` is derived: for unsigned, `maxValue.bit_length()`; for signed, `max(negWidth, posWidth) + 1` where the +1 is the sign bit.

### 3a. The `slice(start, end)` semantics — critical for the Goldilocks reduction

```python
def slice(self, start, end):
    width = end - start + 1
    shifted = self >> start
    if width <= shifted.zeroLsbs:
        return IntType(0, 0, 0)
    elif width < shifted.bitWidth:
        return IntType.unsigned(width - shifted.zeroLsbs) << shifted.zeroLsbs
    else:
        return shifted
```

Three branches:
- **Width below trailing-zero count**: slice is exactly zero.
- **Width below remaining bit-width**: slice is treated as **unsigned** of that width.
- **Width covers the entire shifted value**: return the shifted bound as-is, which **may be signed**.

The third branch is the key for negative inputs. For example, if `aIn = IntType(-2^65, 2^65 - 1, 0)` (s66, bitWidth = 66), then:

- `slice(0, 63)`: width 64 < 66 → unsigned `[0, 2^64 - 1]`.
- `slice(64, 65)`: width 2 → returns `aIn >> 64` = signed `[-2, 1]`.

The algorithm relies on this signed-vs-unsigned split. The lower limb is always unsigned bit content; the boundary limb is signed and represents the value's "sign extension". When a negative value's lower-limb unsigned bits and signed-upper-limb decompose, the Goldilocks identity `2^64 ≡ 2^32 - 1 (mod q)` reassembles them into a value congruent mod q.

The vector-batch version (`utils.vectorSlice(a, start, end, signed=False)`) mirrors this: `signed=False` does `(x >> start) & mask`, `signed=True` returns `x >> start` unmasked. The pipeline picks `signed=True` for the boundary limb.

---

## 4. NTT and INTT — the math we're modeling

### Cyclic NTT

Given coefficients `x[0..n-1]` of a polynomial in `Z_q[X] / (X^n - 1)`:

```
Y[k] = Σ_i x[i] · ω^(ik)   (mod q)        for k = 0, …, n-1
```

where `ω` is a primitive n-th root of unity in `F_q`. The inverse:

```
x[i] = (1/n) · Σ_k Y[k] · ω^(-ik)   (mod q)
```

### Negacyclic NTT (NWC, "Negative Wrapped Convolution")

Given coefficients of `Z_q[X] / (X^n + 1)`:

```
Ŷ[k] = Σ_i x[i] · ψ^(i(2k+1))   (mod q)        for k = 0, …, n-1
```

where `ψ` is a primitive 2n-th root and `ψ² = ω`, `ψ^n = -1`. The evaluation points `{ψ^(2k+1)}` are the n primitive 2n-th roots of unity that are *not* n-th roots — exactly the n roots of `X^n + 1`.

### The pre-twist identity (key to merged NWC)

Splitting the exponent `i(2k+1) = i + 2ik`:

```
Ŷ[k] = Σ_i (ψ^i · x[i]) · ω^(ik)
     = cyclic_NTT(ỹ)[k]      where ỹ[i] := ψ^i · x[i]
```

So: **NWC of x = cyclic NTT of ψ^i-pre-twisted x**. This identity is the foundation of every "merged NWC" algorithm — including ours. See Section 7.

---

## 5. Pipeline topology — CT and GS

Both topologies wire `log2(n) × n/2` butterflies into an in-place dataflow graph. The difference is which side of the pipeline carries the bit-reversed permutation.

| | CT (Decimation-in-Time) | GS (Decimation-in-Frequency) |
|---|---|---|
| Input order | bit-reversed `x[bit_rev(m, L)]` at memory slot `m` | natural `x[m]` |
| Output order | natural `Y[m]` at memory slot `m` | bit-reversed `Y[bit_rev(m, L)]` |
| Stride at stage `s` | `2^s` (doubles) | `2^(L-s-1)` (halves) |
| Group size at stage `s` | `2^(s+1)` (grows) | `2^(L-s)` (shrinks) |
| Butterfly equation | `aOut = aIn + tw·bIn`, `bOut = aIn - tw·bIn` | `aOut = aIn + bIn`, `bOut = (aIn - bIn)·tw` |

The two are SFG transposes of each other. For cyclic NTT, both produce the same mathematical result with different intermediate orderings.

### 5a. Wiring helpers

`NTT.py` exports two pure-function helpers that implement the in-place memory pattern:

```python
butterflyToMems(p, stride) -> (mA, mB)
    # Forward: physical butterfly p reads/writes memory positions (mA, mA + stride)

memToButterfly(m, stride) -> (p, port)
    # Inverse: which (butterfly, port) at this stage produced/consumed memory slot m
```

The bit-level identities:

- `butterflyToMems(p, stride)`: insert a 0-bit at position `log2(stride)` of `p`'s binary form to get `mA`; flip that bit to 1 to get `mB`.
- `memToButterfly(m, stride)`: read off the bit at position `log2(stride)` (= port A or B), then delete it from `m` to get `p`.

These bijections drive both the constructor's wiring loop and `getInputsNatural` / `getOutputsNatural`'s permutation logic.

### 5b. Hand-verified at n=8

For n=8, the wiring at each stage:

```
                CT (stride doubles)         GS (stride halves)
Stage 0:        (0,1)(2,3)(4,5)(6,7)        (0,4)(1,5)(2,6)(3,7)
Stage 1:        (0,2)(1,3)(4,6)(5,7)        (0,2)(1,3)(4,6)(5,7)
Stage 2:        (0,4)(1,5)(2,6)(3,7)        (0,1)(2,3)(4,5)(6,7)
```

(CT and GS are reversed at the bookend stages, agree in the middle.)

---

## 6. Cyclic twiddle derivation

For cyclic CT at stage `s` (0-indexed), butterfly at intra-group position `j` (where `j = p mod 2^s`) uses:

```
tw_cyclic_CT(s, j) = ω^(j · n / 2^(s+1)) = ω^(j · stepExp)
```

where `stepExp = n // groupSize = n / 2^(s+1)`. In ψ-exponent form: `ψ^(2j · stepExp)`.

The path from input `x[i]` to output `Y[k]` accumulates a product of twiddles at the stages where `x[i]` enters via `bIn`. For CT with bit-reversed input, summing those products over all paths gives `ω^(ik)` — the textbook NTT relation.

For GS, by SFG transposition: `tw_cyclic_GS(s, j) = ω^(j · n / 2^(L-s)) = ω^(j · stepExp_GS)` with `stepExp_GS = 2^s`.

---

## 7. Negacyclic twiddle derivation (the centerpiece)

This is where we earned the most insight during implementation. We'll derive the merged-NWC twiddle for CT topology from scratch via path-product analysis.

### 7a. The goal

We want a `ψ`-twiddle assignment for the **same SFG topology** as cyclic CT (no wiring change) such that the pipeline computes `Ŷ[k]` directly, with no separate pre-twist row.

By the pre-twist identity (Section 4):
```
Ŷ[k] = Σ_i x[i] · ψ^(i(2k+1)) = Σ_i x[i] · ω^(ik) · ψ^i
```

The cyclic CT pipeline with input `bit_rev(x)` computes `Σ_i x[i] · ω^(ik)`. To turn this into `Ŷ[k]`, the path coefficient from input `x[i]` to output `Y[k]` must gain an extra factor `ψ^i`.

### 7b. Where the extra `ψ^i` factor is collected

`x[i]` enters the SFG at memory position `m = bit_rev(i, L)`. At stage `s`, butterflies pair memory positions that differ in bit `s`. The lower index is the `aIn` (no twiddle multiplication on either branch contribution from aIn going to aOut); the upper index is the `bIn` (multiplied by the twiddle when contributing to either output).

For input `x[i]`:
- Bit `s` of `m = bit_rev(i, L)` = bit `(L-1-s)` of `i`.
- So `x[i]` is the `bIn` of its stage-`s` butterfly **iff bit `(L-1-s)` of `i` is 1**.

Writing `i` in binary as `i = Σ_b i_b · 2^b`:
```
ψ^i = ψ^(Σ_b i_b · 2^b) = Π_b (ψ^(2^b))^(i_b)
```

Each bit `b` of `i` contributes `ψ^(2^b)` iff that bit is 1 — and we encounter that bit at stage `s = L-1-b`.

**Conclusion**: the extra `ψ`-factor injected at stage `s` on the `bIn` branch must be `ψ^(2^(L-1-s))`. This is the same for all butterflies at the stage (depends only on `s`). Multiplying the cyclic twiddle by this factor gives the NWC twiddle.

### 7c. Computing the per-butterfly NWC twiddle

Cyclic CT twiddle in ψ-exponent at stage `s`, intra-group position `j`:
```
2j · stepExp        where stepExp = n / 2^(s+1) = 2^(L-1-s)
```

NWC modification:
```
NWC twiddle exponent = 2j · stepExp + 2^(L-1-s) = 2j · stepExp + stepExp = (2j + 1) · stepExp
```

So the merged-NWC per-butterfly twiddle in CT topology is:

```
tw_NWC_CT(s, j) = ψ^((2j + 1) · stepExp)
```

where `j = 0, 1, …, stride - 1` is the intra-group position (= physical butterfly position within the group).

This is what `calculateNttTwiddles` implements:

```python
if negacyclic:
    baseExps = [(2 * j + 1) * stepExp for j in range(stride)]
```

### 7d. Verification at n=8

For n=8 (`L = 3`, `stepExp = 2^(L-1-s)`):

| Stage `s` | `stepExp` | `(2j+1)·stepExp` for `j=0..stride-1` |
|-----------|-----------|--------------------------------------|
| 0 | 4 | `[4]` (stride=1) |
| 1 | 2 | `[2, 6]` (stride=2) |
| 2 | 1 | `[1, 3, 5, 7]` (stride=4) |

Hand-trace for `x = [0, 1, 0, 0, 0, 0, 0, 0]` (only `x[1] = 1`):

- Bit-rev memory: `[0, 0, 0, 0, 1, 0, 0, 0]` (since `bit_rev(1, 3) = 4`).
- Stage 0 (twiddles `[ψ^4, ψ^4, ψ^4, ψ^4]`, stride 1): only butterfly 2 has nonzero input. Outputs `(1, 1)` to mem positions 4, 5.
- Stage 1 (twiddles `[ψ^2, ψ^6, ψ^2, ψ^6]`, stride 2): butterflies 2 and 3 have nonzero inputs. Outputs `(1, 1)` to all of mem 4-7.
- Stage 2 (twiddles `[ψ^1, ψ^3, ψ^5, ψ^7]`, stride 4): each butterfly p reads `(0, 1)` and outputs `(ψ^(2p+1), -ψ^(2p+1)) = (ψ^(2p+1), ψ^(2p+1+8))`.

Final memory: `[ψ^1, ψ^3, ψ^5, ψ^7, ψ^9, ψ^11, ψ^13, ψ^15]`.

Reference: `Ŷ[k] = ψ^(1·(2k+1)) = ψ^(2k+1)` for `k = 0, …, 7` = `[ψ^1, ψ^3, ψ^5, ψ^7, ψ^9, ψ^11, ψ^13, ψ^15]`.

**Exact match — no permutation needed at output.**

### 7e. Equivalence with the Kyber-style closed form

A common Longa-Naehrig-style closed form (e.g. as used in Kyber's reference code) is:

```
T_{s,g} = ψ^(2^(n-s) · (2 · br_{s-1}(g) + 1))         (1-indexed s, g = 0…2^(s-1)-1)
```

where the table is stored bit-reversed and the kernel walks it sequentially. In our 0-indexed `s` and physical butterfly position `j`, this is **the same SET of twiddles**:

| j | Physical butterfly | `(2j+1)·stepExp` (our code) | `(2·br(g)+1)·2^(n-s)` (Kyber form, indexed by g) |
|---|--------------------|----------------------------|---------------------------------------------------|
| 0 | 0 | 1 | `g=0`: 1 |
| 1 | 1 | 3 | `g=2`: 3 |
| 2 | 2 | 5 | `g=1`: 5 |
| 3 | 3 | 7 | `g=3`: 7 |

(For n=8 stage 2.) The Kyber form's `g` is the bit-reversed butterfly position — the kernel's "bit-reversed table + sequential read" indirection lands the right value at each butterfly, equivalent to our direct natural-order assignment.

### 7f. Why GS forward and CT inverse don't admit clean absorption

The CT butterfly equation puts the twiddle on `bIn` only:
```
aOut = aIn + ψ^k · bIn
bOut = aIn - ψ^k · bIn
```

Pre-twist factors `ψ^α` on `aIn` and `ψ^β` on `bIn` can be rewritten:
```
aOut' = ψ^α · (aIn + ψ^(β-α) · ψ^k · bIn)
bOut' = ψ^α · (aIn - ψ^(β-α) · ψ^k · bIn)
```

The common `ψ^α` factor propagates forward as a "residual" on both outputs, and the new effective twiddle is `ψ^(β-α+k)`. Clean.

The GS butterfly equation puts the twiddle on bOut after subtraction:
```
aOut = aIn + bIn
bOut = (aIn - bIn) · ψ^k
```

With pre-twist `ψ^α · aIn` and `ψ^β · bIn`:
```
aOut' = ψ^α · aIn + ψ^β · bIn
bOut' = (ψ^α · aIn - ψ^β · bIn) · ψ^k
```

`aOut'` is a sum of two terms with **different** ψ-factors, so we **cannot factor out a common `ψ`-residual** — the absorption fails on the addition side. The forward NWC therefore requires CT topology.

By symmetry (SFG transpose + base inversion), inverse NWC requires GS topology — the post-twist factor in the inverse can absorb cleanly into GS but not CT.

The library enforces this:
- `calculateNttTwiddles(negacyclic=True, butterflyType='GS')` raises `ValueError`.
- `calculateInttTwiddles(negacyclic=True, butterflyType='CT')` raises `ValueError`.
- `verifyNtt` / `verifyIntt` re-check the same constraint on the instance.

---

## 8. The GoldilocksSlice64 scheme — limb math

`propagateBound` (and its mirror `propagateValue`) implements one butterfly as a sum of signed slices over Goldilocks 192-bit blocks. The structure is identical for the bound and value paths; only the data type (IntType vs `list[int]`) differs.

### 8a. The slicing-and-folding pipeline

For a CT butterfly (`aOut = aIn + bIn · twiddle`):

```
1. NAF-lift the twiddle (or use the pre-lifted NAF list) — at most 3 (sign, exponent) terms.
2. Initialize aOut accumulator with -q.
3. Add aIn's Goldilocks-folded contribution (sign +1) to aOut.
4. Add aIn's Goldilocks-folded contribution (sign +1) to bOut.
5. For each NAF term (sign, shift) of the twiddle:
   - Compute (bIn << shift) sliced into Goldilocks limbs.
   - For each (limbStart, limbEnd) and its (subShift, subSign) factors, contribute the
     scaled limb to aOut with outerSign = sign, and to bOut with outerSign = -sign.
6. Sum the signed-slice list to get aOut and bOut.
```

The `-q` initial term (`aOutSlices = [(IntType(self.q, self.q, 0), -1)]`) is a "lazy reduction" subtraction. It keeps `aOut` in roughly `[-q, q-1]` instead of `[0, 2q-1]` — useful when the output bound minValue would otherwise grow on each stage.

### 8b. Why slicing a signed value works

The `limbs64` table only declares the *factor* by which each limb gets multiplied. Whether the limb itself is unsigned or signed depends on `IntType.slice` (Section 3a):
- Lower limbs of an s66 input: width 64 < 66 → unsigned `[0, 2^64-1]`.
- Boundary limb (e.g. `slice(64, 65)`): width 2 = bitWidth 2 → signed `[-2, 1]`.

For an actual negative value like `aIn = -100`:
- Lower limb: `(-100) & (2^64 - 1) = 2^64 - 100` (large unsigned).
- Upper limb: `(-100) >> 64 = -1` (signed Python int).
- Folded: `(2^64 - 100) · 1 + (-1) · (2^32 - 1) = 2^64 - 2^32 - 99 = q - 100 ≡ -100 (mod q)`. ✓

The `vectorSlice(..., signed=signed)` helper uses `signed=True` for the boundary limb so that the value-batch path replicates this signed reconstruction.

### 8c. Why the bound's bitWidth must drive value-path slicing

A subtle bug we hit early: `propagateValue` originally computed slicing boundaries from `vectorBitWidth(actual values)` (per-batch worst-case magnitude). For a batch whose actual values fit in 63 bits while the input bound is s66 (66 bits), the bound algorithm slices into 2 limbs but the value algorithm slices into 1 — producing unreduced sums that differ by multiples of q.

Fix: the scheme stores `aInBitWidth` / `bInBitWidth` fields that `Butterfly.compute()` populates from `inputPort.bound.bitWidth`. `propagateValue` uses these for slicing, ensuring it follows the same hardware-register width that `propagateBound` used. Result: actual values now fall inside the predicted bound interval, every time.

This is why the verifier loads both bounds and values together — when only values are loaded, `aInBitWidth` falls back to `vectorBitWidth(values)` and the unreduced result may not match the bound's prediction (though it remains correct mod q).

### 8d. Hardware constraint: ≤3 NAF terms

`GoldilocksSlice64` has a hardcoded `maxNumberOfTerms=3` in its internal `nafTermsModulusLift` call, and a runtime guard that rejects pre-lifted NAF lists with > 3 terms. This corresponds to a hardware constraint: a slice64 multiplier has 3 shift-add lanes. Any twiddle that can't be expressed in ≤3 terms either:
- Doesn't physically fit in the hardware (the bound model would over-promise area), OR
- Needs a different scheme with more lanes.

In practice, target-first search at `maxPower=95, maxMultipleOfModulus=2^32, maxNumberOfTerms=3` finds a ≤3-term lift for every twiddle in any reasonable NTT size for Goldilocks. Beam search is the fallback if exhaustive enumeration in the bounded range can't find one.

---

## 9. Pipeline dataflow (Butterfly.compute and Port.push)

The compute orchestration is small and worth understanding:

```python
# Butterfly.compute()
boundReady = aBound is not None and bBound is not None
valueReady = aVec   is not None and bVec   is not None

if boundReady:
    self.scheme.aIn = aBound; self.scheme.bIn = bBound
    aOutBound, bOutBound = self.scheme.propagateBound()
    self.outputPortA.bound = aOutBound; self.outputPortB.bound = bOutBound

if valueReady:
    self.scheme.aIn = aVec; self.scheme.bIn = bVec
    self.scheme.aInBitWidth = aBound.bitWidth if aBound is not None else None
    self.scheme.bInBitWidth = bBound.bitWidth if bBound is not None else None
    aOutVec, bOutVec = self.scheme.propagateValue()
    self.outputPortA.testVector = aOutVec; self.outputPortB.testVector = bOutVec

if self.outputPortA.isConnected: self.outputPortA.push()
if self.outputPortB.isConnected: self.outputPortB.push()
```

Both branches can run in the same call (when both modes are loaded). `Port.push()` propagates **both** `bound` and `testVector` to downstream input ports atomically — so the two pipelines stay in lock-step through the layers.

`FullyPipelinedNTT.compute()` is just two nested loops:

```python
for layer in self.butterflies:
    for bfly in layer:
        bfly.compute()
```

Within a layer, butterflies are independent; between layers, the dataflow is implicit through the wired ports.

---

## 10. Verification: pipeline vs reference

`referenceNtt` and `referenceIntt` (in `NTT.py`) are O(n²) Sage-based implementations that compute `Ŷ[k]` (or its inverse) directly from the definition. They produce **natural-order** output.

`verifyNtt(instance, …)` / `verifyIntt(instance, …)` are end-to-end harnesses:

1. Generate a batch of random natural-order test vectors.
2. Load both `inputBound` and the test vectors via `getInputsNatural` (this auto-permutes for CT).
3. Call `compute()` (runs both bound and value paths).
4. Read final outputs in natural order via `getOutputsNatural` (auto-permutes for GS).
5. For each batch element, compute the reference NTT/INTT and compare element-wise mod q.
6. Walk every output port of every stage; check every actual test value lies inside that port's predicted bound interval.

The function returns `True` iff both checks pass for every batch element / position. Verbose mode prints the first 5 mismatches plus a summary line.

This catches:
- Twiddle-derivation bugs (mod-q mismatches).
- Wiring bugs (most outputs become wrong).
- Bound-tightness bugs (value-vs-bound containment fails).

The negacyclic CT NTT formula derived in Section 7 was validated this way: introducing the corrected `(2j+1)·stepExp` formula made `verifyNtt` pass 32/32 for n=8 NWC; the previous `bit_rev(stride+j)` formula failed.

---

## 11. Hardware implications

Bound analysis maps directly to FPGA/ASIC datapath sizing:

- **Register width per pipeline stage** = `max bitWidth across that stage's output ports`. `showBounds()` prints this directly.
- **Adder/subtractor count per butterfly** = number of NAF terms in the twiddle (1 base + up to 3 shifted-and-signed contributions per limb). The `maxNumberOfTerms=3` hardware constraint caps this.
- **Multiplier-free design**: the Goldilocks scheme replaces all twiddle multiplications with shift-add chains. A k-NAF-term twiddle takes k 64-bit shifters and k-1 adders.
- **Lazy reduction**: the `-q` initial term means each butterfly leaves its output in roughly `[-q, q-1]` rather than fully reduced to `[0, q-1]`. The final stage (or a separate reduction unit) brings it back if the consumer requires it.
- **Pipeline depth**: `log2(n)` butterfly stages plus internal slice/fold pipelining (typically 2-4 cycles per stage for the slice64 scheme).

The XLSX bound table generated by `saveBoundsToXlsx` is the document you'd hand to a hardware designer to size each register and each carry chain in the datapath.

---

## 12. References and conventions

- **Goldilocks prime**: introduced in the context of zk-STARK-friendly fields; widely used in lattice cryptography accelerators.
- **NWC merged form**: Longa & Naehrig, "Speeding up the Number Theoretic Transform for Faster Ideal Lattice-Based Cryptography" (2016). The Kyber and Dilithium reference implementations use this approach.
- **NAF / modulus-lifted NAF for constant multipliers**: standard technique in low-power signal processing; the modulus-lifting twist is what makes it work for NTT twiddles specifically.
- **Bit-reversed input/output convention**: this library uses the textbook DSP convention — CT takes bit-reversed input and produces natural output; GS is the mirror.
