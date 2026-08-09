# NTT Modeling — Usage Guide

A hardware-modeling library for the Number Theoretic Transform (NTT) targeting the Goldilocks prime `q = 2^64 - 2^32 + 1`. It propagates bit-width / range bounds through butterfly networks so the resulting datapath can be sized for FPGA/ASIC, and supports value-batch simulation alongside bound analysis for end-to-end cross-verification against a software reference NTT.

This document is the **practical guide**: install, quick-start, common workflows, and an API summary. For the math and topology derivations (especially negacyclic twiddles), see `THEORY.md`.

---

## 1. Setup

The library uses Sage for finite-field arithmetic and openpyxl for spreadsheet I/O.

```bash
conda create -n ntt-sage -c conda-forge sage python=3.11
conda activate ntt-sage
pip install openpyxl
```

All scripts must be run from the parent directory of `operator_modeling/` (the package uses relative imports). Typical project root layout:

```
PythonProjects/
├── operator_modeling/         # the library package
├── docs/                 # this document and THEORY.md
├── runButterfly.py       # example entry-point script
├── twiddles.xlsx         # NAF-lifted twiddles (input)
└── NTT_bounds.xlsx       # generated per-stage bound table (output)
```

---

## 2. Quick start: bound analysis on n=128

```python
from math import log2
from operator_modeling.ntt.NTT import FullyPipelinedNTT, calculateNttTwiddles
from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64
from operator_modeling.core.IntType import IntType

q = 2**64 - 2**32 + 1
n = 128
L = int(log2(n))

# 1. Build NAF-lifted twiddles for a cyclic GS NTT
twiddles = calculateNttTwiddles(
    modulus=q, n=n, butterflyType='GS',
    useModulusLiftingNaf=True, maxNumberOfTerms=3,
)

# 2. Construct the pipeline (wires log2(n) x n/2 butterflies)
ntt = FullyPipelinedNTT(name='ntt128_GS', n=n, q=q,
                        butterflyType='GS', twiddles=twiddles)

# 3. Attach a GoldilocksSlice64 scheme to every butterfly
schemes = [[GoldilocksSlice64(name=f'{ntt.name}_L{s}_p{p}', butterflyType='GS')
            for p in range(n // 2)] for s in range(L)]
ntt.setScheme(schemes)

# 4. Drive stage-0 inputs with signed-66 IntType bounds
ntt.getInputs([IntType.signed(66) for _ in range(n)])

# 5. Propagate
ntt.compute()

# 6. Inspect
ntt.showBounds()                # per-stage max bitWidth + sample
ntt.saveBoundsToXlsx()          # full per-butterfly per-stage table -> NTT_bounds.xlsx
```

Expected output:

```
=== Bounds for ntt128_GS (n=128, GS) ===
Layer 0: max bitWidth = 67, e.g. [-2^65.63, 2^65.63] (s67), zeroLsbs=0
Layer 1: max bitWidth = 66, e.g. [-2^64.00, 2^64.00] (s66), zeroLsbs=0
Layer 2: max bitWidth = 66, ...
...
```

---

## 3. Core types at a glance

| Type | Module | Purpose |
|------|--------|---------|
| `IntType` | `operator_modeling/IntType.py` | Signed-or-unsigned interval `(minValue, maxValue, zeroLsbs)`. Arithmetic ops propagate bounds, not values. |
| `Port` (`SimpleInputPort` / `SimpleOutputPort`) | `Port.py` | Directed graph node carrying both an `IntType` bound and a `list[int]` test-vector batch. |
| `ButterflyScheme` (abstract) | `ButterflyScheme.py` | Knows how to fold a butterfly's bound and value through hardware-specific math. |
| `GoldilocksSlice64` | `ButterflyScheme.py` | Concrete scheme: 64-bit limb decomposition + Goldilocks identities for mod-q reduction. |
| `Butterfly` | `Butterfly.py` | Two input ports + two output ports + a scheme + a twiddle. |
| `FullyPipelinedNTT` | `NTT.py` | Wired `log2(n) × n/2` butterfly grid. |
| `FullyPipelinedINTT` | `NTT.py` | Subclass of NTT — same wiring/compute, just inverse twiddles. |

---

## 4. Workflows

### 4a. Bound analysis only

The "Quick start" above. Useful for sizing registers in an FPGA/ASIC datapath.

### 4b. Value-batch simulation (alongside bound)

Test vectors flow through the same butterfly graph as bounds, producing the exact integer the hardware would compute. Load both via two `getInputs` calls:

```python
import random
random.seed(42)

batchSize = 4
testVectors = [[random.randint(0, q - 1) for _ in range(batchSize)] for _ in range(n)]

ntt.getInputs([IntType.signed(66) for _ in range(n)])   # bounds
ntt.getInputs(testVectors)                                # values
ntt.compute()                                             # both paths run

# Read final values directly from output ports' testVector field
final = []
for m in range(n):
    p, port = memToButterfly(m, n // 2 if ntt.butterflyType == 'CT' else 1)
    bfly = ntt.butterflies[-1][p]
    op = bfly.outputPortA if port == 'A' else bfly.outputPortB
    final.append([v % q for v in op.testVector])
```

When both modes are loaded, `Butterfly.compute()` runs `propagateBound()` first (so the scheme's `aInBitWidth` / `bInBitWidth` is set from the bound's `bitWidth`), then `propagateValue()` uses the same hardware-register slicing — so the unreduced values fall inside the predicted bound interval.

### 4c. Cross-verification against a software reference

The `verifyNtt` / `verifyIntt` helpers do all the plumbing (random vector generation, bound + value loading, mod-q comparison against `referenceNtt`, bound-containment check):

```python
from operator_modeling.ntt.NTT import verifyNtt, verifyIntt

ok = verifyNtt(ntt, seed=42, batchSize=8)        # True / False
# Prints: verifyNtt ntt128_GS: mod-q 64/64, bound containment 1792/1792
```

Optional kwargs: `primitiveRoot` (defaults to `F.zeta(n)` matching `calculateNttTwiddles`), `inputBound` (default `IntType.signed(66)`), `valueRange` (default `(-(2**65), 2**65 - 1)`), `verbose` (default True).

### 4d. Forward + inverse round-trip

```python
from operator_modeling.ntt.NTT import FullyPipelinedINTT, calculateInttTwiddles

# Forward: cyclic GS
twFwd = calculateNttTwiddles(modulus=q, n=n, butterflyType='GS',
                              useModulusLiftingNaf=True, maxNumberOfTerms=3)
ntt = FullyPipelinedNTT(name='fwd', n=n, q=q, butterflyType='GS', twiddles=twFwd)

# Inverse: cyclic CT (bit-rev input matches GS bit-rev output)
twInv = calculateInttTwiddles(modulus=q, n=n, butterflyType='CT',
                               useModulusLiftingNaf=True, maxNumberOfTerms=3)
intt = FullyPipelinedINTT(name='inv', n=n, q=q, butterflyType='CT', twiddles=twInv)
```

The pipeline INTT intentionally **omits the 1/n scaling**, so `intt.compute()` recovers `n · x mod q`. Compare against `referenceIntt(y, q, divideByN=False)` for verification.

### 4e. Negacyclic NTT (NWC)

Negacyclic uses the same pipeline, with `negacyclic=True` flowed through both the twiddle calculation and the pipeline construction. **Standard pairing only**: forward NWC requires CT, inverse NWC requires GS:

```python
twFwd = calculateNttTwiddles(modulus=q, n=n, butterflyType='CT',
                              negacyclic=True,
                              useModulusLiftingNaf=True, maxNumberOfTerms=3)
nttN = FullyPipelinedNTT(name='nttN', n=n, q=q, butterflyType='CT',
                         twiddles=twFwd, negacyclic=True)

twInv = calculateInttTwiddles(modulus=q, n=n, butterflyType='GS',
                               negacyclic=True,
                               useModulusLiftingNaf=True, maxNumberOfTerms=3)
inttN = FullyPipelinedINTT(name='inttN', n=n, q=q, butterflyType='GS',
                           twiddles=twInv, negacyclic=True)
```

`calculateNttTwiddles(negacyclic=True, butterflyType='GS')` raises `ValueError` — see `THEORY.md` section 7 for why the GS butterfly equation cannot absorb a forward pre-twist cleanly.

### 4f. Loading twiddles from xlsx

If you have a precomputed twiddle file (e.g. from an external tool), load it instead of regenerating:

```python
from operator_modeling.ntt.NTT import loadTwiddlesFromXlsx, saveTwiddlesToXlsx

twiddles = loadTwiddlesFromXlsx('twiddles.xlsx', sheetName='NTT_TWIDDLES')
# Round-trip clean:
saveTwiddlesToXlsx(twiddles, '/tmp/round.xlsx', butterflyType='GS')
```

The xlsx format: row 1 has `Layer 1 ... Layer L` headers + a `<TYPE> BUTTERFLIES!!!` label cell; rows 2..n/2+1 hold per-butterfly twiddles in physical top-to-bottom order, columns are stages. Each cell is either an integer or a NAF expression like `-2^91 + 2^43`.

### 4g. Generating SystemVerilog for a single butterfly

Once a `GoldilocksSlice64` is populated with input bounds and a twiddle, call
`scheme.emitRtl(name, run_dir, ...)` directly. The method internally extracts
the spec (via `getOperatorInterface`), samples random `aIn` / `bIn` inputs in
the spec's bound range, runs `propagateValue` for the unreduced goldens,
dispatches to `Butterfly_RTL_gen` with cwd inside `run_dir`, and runs a local
twos-complement-encoding sanity check on the first 8 testvector lines.

```python
from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64
from operator_modeling.core.IntType import IntType

scheme = GoldilocksSlice64(name='probe', butterflyType='GS')
scheme.aIn = IntType.signed(66)             # may differ between aIn and bIn
scheme.bIn = IntType.signed(66)
scheme.twiddle = [(1, 6)]                   # int or NAF list

meta = scheme.emitRtl(
    name='Butterfly_n128_GS_L2_p5',
    run_dir='./work/foo/butterfly_L2_p5',
    pipeline_stages=1,
    test_size=1000,
    seed=42,
)
# -> work/foo/butterfly_L2_p5/RTL_generated/{Butterfly_n128_GS_L2_p5.sv,
#    _aOut_cmp.sv, _bOut_cmp.sv, _tb.sv}
# -> work/foo/butterfly_L2_p5/xdc_generated/...
# -> work/foo/butterfly_L2_p5/testvectors/{aIn,bIn,aOut,bOut}.txt
```

If you need just the spec without emitting RTL, `getOperatorInterface(name)`
still returns the `ButterflyOperatorSpec` directly — useful for bound /
bit-heap inspection. The dataclass is defined in
`versal_arith/butterfly_spec.py`. Both `propagateBound` (the IntType bound
math) and `getOperatorInterface` (the RTL spec) flow through a single
`_buildSliceTerms` helper, so they cannot drift apart.

For the end-to-end CLI driver — twiddle resolution
(`--twiddles-xlsx`, `--twiddle-naf`, `--compute-twiddles`), per-input bounds
(`--aIn-bound`, `--bIn-bound`), remote V80 simulation (`--remote-sim`) — see
[`../scripts/README.md §1`](../scripts/README.md). The CLI is now a thin
wrapper around `scheme.emitRtl`.

### 4h. Generating SystemVerilog for the entire NTT/INTT pipeline

`FullyPipelinedNTT` (and `FullyPipelinedINTT`) exposes
`inst.emitRtl(topName, run_dir, ...)` for one-call RTL emission from a
populated instance. Precondition: `setScheme()`, `getInputsNatural([bounds])`
+ `compute()`, and (for `gen_testbench=True`) `getInputsNatural([batches])` +
a second `compute()` so every input/output port carries a `testVector`. The
method extracts the spec, pulls goldens directly from the populated ports
via `_extractGoldensNatural`, dispatches to `NTT_RTL_gen` with cwd inside
`run_dir`, and runs a local per-slot sanity check.

```python
import random
from operator_modeling.ntt.NTT import FullyPipelinedNTT, calculateNttTwiddles
from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64
from operator_modeling.core.IntType import IntType

q, n = 2**64 - 2**32 + 1, 128
twiddles = calculateNttTwiddles(modulus=q, n=n, butterflyType='GS',
                                useModulusLiftingNaf=True, maxNumberOfTerms=3)
inst = FullyPipelinedNTT(name='ntt128_GS', n=n, q=q,
                         butterflyType='GS', twiddles=twiddles)
inst.setScheme([[GoldilocksSlice64(name=f'L{s}p{p}', butterflyType='GS')
                 for p in range(n // 2)] for s in range(7)])

# Per-natural-input bounds — uniform here, but free to vary per-index.
bounds = [IntType.signed(96)] * n
inst.getInputsNatural(bounds)
inst.compute()

# Sample testvectors, drive values + bounds, propagate.
random.seed(0)
batches = [[random.randint(b.minValue, b.maxValue) for _ in range(1000)]
           for b in bounds]
inst.getInputsNatural(bounds)
inst.getInputsNatural(batches)
inst.compute()

manifest = inst.emitRtl(
    topName='NTT_n128_GS',
    run_dir='./work/foo/NTT_n128_GS',
    pipeline_stages_per_layer=1,
)
# -> work/foo/NTT_n128_GS/RTL_generated/{NTT_n128_GS.sv, _tb.sv,
#    NTT_n128_GS_btf_L<s>_p<p>.sv, _aOut_cmp.sv, _bOut_cmp.sv}
# -> work/foo/NTT_n128_GS/xdc_generated/...
# -> work/foo/NTT_n128_GS/testvectors/{x_in,y_out}.txt   (per-slot packed hex)
# -> work/foo/NTT_n128_GS/manifest.json
```

If you need just the spec without emitting RTL, `inst.getOperatorInterface(name)`
returns the `NTTOperatorSpec` directly. The dataclass is defined in
`versal_arith/ntt_spec.py`:

| Field | Shape | Meaning |
|---|---|---|
| `inputBitWidthsNatural` / `inputIsSignedNatural` | length n | per-natural x[i]'s width / signedness; reads each stage-0 butterfly port's bound, **no uniformity assumed** |
| `outputBitWidthsNatural` / `outputIsSignedNatural` | length n | per-natural y[i]'s width / signedness from the final-stage butterfly port's bound |
| `inputWiring` | n/2 tuples `(natA, natB)` | x[natA] feeds `butterflies[0][p].aIn`; x[natB] feeds bIn |
| `outputWiring` | n/2 tuples `(natA, natB)` | `butterflies[L-1][p].aOut` → y[natA]; bOut → y[natB] |
| `interStageWiring` | (L-1) × n/2 tuples of two `InterStageWire` | for layer s≥1, butterfly p, where each input comes from in layer s-1 |
| `butterflySpecs` | log2(n) × n/2 of `ButterflyOperatorSpec` | per-butterfly bit-widths, twiddle NAF, bit-heap provenance |

The wrapper SV declares **per-index named ports** `x_in_<i>` / `y_out_<i>`,
each at exactly its bound's width — no max-width slot, no zero-padding, no
per-slot truncation in the TB. Per-layer pipeline stages are layer-uniform;
within-layer balancing shift registers auto-inserted only when butterflies
in the same layer report different actual latencies.

The CLI driver — twiddle resolution, the per-layer pipeline-stages syntax,
and a per-butterfly debug mode — is at
[`../scripts/README.md §2`](../scripts/README.md). The CLI is now a thin
wrapper around `inst.emitRtl`.

---

## 5. Output recording (bounds.xlsx)

`FullyPipelinedNTT.saveBoundsToXlsx(path='NTT_bounds.xlsx', sheetName=None)` writes per-port output bounds to xlsx. Defaults:

- `path`: `NTT_bounds.xlsx` in the current directory.
- `sheetName`: `self.name` — so multiple NTT instances can share one workbook without colliding.

Layout: row 1 has `Layer 1 ... Layer L` + a `<TYPE> BOUNDS` label; rows 2..n+1 hold per-port output bounds (port A on even row, port B on odd). Each cell is the `IntType.__str__` representation, e.g. `[-2^65.00, 2^65.00] (s66), zeroLsbs=0`.

---

## 6. API summary

### `operator_modeling.ntt.NTT`

| Function/method | Purpose |
|-----------------|---------|
| `calculateNttTwiddles(modulus, n, butterflyType, primitiveRoot=None, negacyclic=False, useModulusLiftingNaf=False, ...)` | Build forward NTT twiddles. Returns `list[list[int \| list[tuple[int, int]]]]` of shape `log2(n) × n/2`. |
| `calculateInttTwiddles(...)` | Same shape; uses `ω^(-1)` (cyclic) or `ψ^(-1)` (negacyclic) as the base. 1/n scaling omitted. |
| `referenceNtt(x, modulus, primitiveRoot=None, negacyclic=False)` | O(n²) reference NTT in natural order. For verification. |
| `referenceIntt(y, modulus, primitiveRoot=None, negacyclic=False, divideByN=True)` | O(n²) reference INTT. Set `divideByN=False` to match `FullyPipelinedINTT` (which omits 1/n). |
| `loadTwiddlesFromXlsx(path, sheetName='NTT_TWIDDLES')` | Read precomputed twiddles from spreadsheet. |
| `saveTwiddlesToXlsx(twiddles, path, butterflyType, sheetName='NTT_TWIDDLES')` | Write twiddles to spreadsheet. |
| `verifyNtt(instance, primitiveRoot=None, batchSize=4, seed=None, ...)` | End-to-end forward NTT verification (mod-q + bound containment). |
| `verifyIntt(instance, ...)` | Same for inverse. |
| **Class** `FullyPipelinedNTT(name, n, q, butterflyType, twiddles, negacyclic=False)` | The pipelined NTT. Constructor wires the butterfly grid. |
| `.setScheme(schemes)` | Attach `log2(n) × n/2` grid of `ButterflyScheme` instances. |
| `.getInputs(inputs)` | Drive stage-0 inputs in **memory order**; accepts `list[IntType]` or `list[list[int]]`. |
| `.getInputsNatural(x)` | Drive stage-0 inputs in **natural order** `x[0] … x[n-1]`; auto-permutes. |
| `.compute()` | Walk pipeline stage-by-stage, calling each butterfly's `compute()`. |
| `.getOutputs()` | Return outputs in memory order. |
| `.getOutputsNatural()` | Return outputs in natural order. |
| `.showBounds()` | Print per-stage summary. |
| `.saveBoundsToXlsx(path='NTT_bounds.xlsx', sheetName=None)` | Persist per-port bound table. |
| `.getOperatorInterface(name)` | Return an `NTTOperatorSpec` (defined in `versal_arith/ntt_spec.py`) bundling per-butterfly specs + per-natural input/output widths + precomputed wiring tables. Consumed by `NTT_RTL_gen`. See §4h. Precondition: every stage-0 butterfly input port has a bound (`compute()` ran with bounds loaded). |
| `.emitRtl(topName, run_dir, pipeline_stages_per_layer=1, gen_testbench=True, visualization=False)` | One-call RTL emission from a populated instance. Internally extracts the spec and (when `gen_testbench=True`) the natural-order goldens from each populated port's `testVector`, then dispatches to `NTT_RTL_gen` with cwd inside `run_dir`. Runs a local sanity check. See §4h. |
| **Class** `FullyPipelinedINTT(...)` | Subclass of `FullyPipelinedNTT`. Inherits everything; intended for inverse-twiddle inputs. The 1/n scaling is dropped. |

### `operator_modeling.ntt.ButterflyScheme`

| Item | Purpose |
|------|---------|
| `ButterflyScheme` (abstract) | Base class. Defines `propagateBound`, `propagateValue`, `areaCost`. |
| `GoldilocksSlice64(name, butterflyType, aIn, bIn, twiddle, verbose=False)` | Concrete scheme for `q = 2^64 - 2^32 + 1`. `verbose=True` prints per-butterfly NAF info. |
| `GoldilocksSlice64.getOperatorInterface(name)` | Return a `ButterflyOperatorSpec` (defined in `versal_arith/butterfly_spec.py`) carrying per-input/output bit-widths + signedness, the lifted-NAF twiddle, and the bit-level provenance of every aOut / bOut summand. Consumed by `Butterfly_RTL_gen`. See §4g. |
| `GoldilocksSlice64.emitRtl(name, run_dir, pipeline_stages=1, gen_testbench=True, test_size=1000, seed=None, visualization=False)` | One-call RTL emission. Internally calls `getOperatorInterface`, samples random `aIn` / `bIn` in the spec's bound range, runs `propagateValue` for goldens, dispatches to `Butterfly_RTL_gen` with cwd inside `run_dir`, runs a local sanity check. See §4g. |

### `operator_modeling.ntt.Butterfly`

| Item | Purpose |
|------|---------|
| `Butterfly(name, butterflyType='CT', scheme=None, twiddle=None)` | Single butterfly with 2 input + 2 output ports. `twiddle` accepts `int`, NAF-list `list[tuple[int, int]]`, or a `Port`. |
| `.initializeInputs(inputA, inputB)` | Drive input ports — `IntType` for bound, `list[int]` for value batch. |
| `.connectInTo(connectATo, connectBTo)` | Wire input ports to specific upstream outputs. |
| `.compute()` | Auto-dispatches: runs `propagateBound` and/or `propagateValue` based on which input fields are populated. |

### `operator_modeling.core.IntType`

| Item | Purpose |
|------|---------|
| `IntType(minValue, maxValue, zeroLsbs=0)` | Bound interval. |
| `.signed(bitWidth)` / `.unsigned(bitWidth)` | Constructors for full-range bounds. |
| `.fromConst(value)` | Single-point bound. |
| `+`, `-`, `*`, `<<`, `>>` | Bound-propagating operators. |
| `.slice(start, end)` | Bit-range slice — see `THEORY.md` section 3 for semantics. |
| `.bitWidth`, `.isSigned`, `.isZero` | Properties. |

### `operator_modeling.core.utils`

| Function | Purpose |
|----------|---------|
| `nafTerms(x)` | Non-adjacent form: returns `[(sign, exponent), ...]` for `x`. |
| `nafTermsCount(x)`, `nafTermsMaxPower(x)` | Cardinality / max exponent. |
| `nafTermsModulusLift(x, modulus, maxPower, maxMultipleOfModulus, maxSearchDepth, beamWidth, maxNumberOfTerms)` | Find `y ≡ x (mod modulus)` whose NAF has the fewest terms. Used to express twiddles as ≤3 shift-add ops. |
| `bitReverse(x, bits)` | Bit-reversal. |
| `vectorAdd / Sub / Mul / Lshift / Rshift / Slice / Const / BitWidth` | Element-wise ops on `list[int]` mirroring `IntType` operators; used by `propagateValue`. |
| `formatNafExpr(naf)` / `parseNafExpr(s)` | NAF list ↔ string `"-2^91 + 2^43"`. |

### `operator_modeling.core.Port`

| Item | Purpose |
|------|---------|
| `SimpleInputPort(name, bound=None, testVector=None)` | Input port. |
| `SimpleOutputPort(name, bound=None, testVector=None)` | Output port. `.push()` propagates both `bound` and `testVector` to connected input ports. |
| `.connect()`, `.disconnectPort()`, `.disconnectAllPorts()` | Topology management. |

---

## 7. Common gotchas

**Sage import error.** Run from a sage env (or one with sage installed); plain Python won't have `from sage.all import GF`.

**`from operator_modeling...` import error.** Run from the *parent* directory of `operator_modeling/`, not from inside it. The package uses relative imports.

**Per-butterfly debug noise.** `GoldilocksSlice64` prints per-butterfly NAF info if `verbose=True`. Default is `False`; pass `verbose=True` only when debugging a single butterfly.

**`getOutputs()` returns bound when both modes are loaded.** Auto-dispatch prefers `bound` over `testVector` on each port. To read test-vector outputs explicitly when bounds are also set, walk `bfly.outputPortA.testVector` directly (or `getOutputsNatural()` with same caveat).

**Negacyclic GS forward / CT inverse rejected.** This is by design — the standard NWC pairing is forward = CT, inverse = GS. See `THEORY.md` for the math.

**Memory order vs natural order.** `getInputs` / `getOutputs` use memory order (matches what hardware sees). `getInputsNatural` / `getOutputsNatural` use natural order (`x[0] … x[n-1]`). Choose based on whether you're modeling the wire-level data or describing math.

**Bound vs value alignment.** When using value-batch mode, also load bounds — otherwise `propagateValue`'s slicing falls back to per-batch `vectorBitWidth` and unreduced values may differ from the bound's prediction by multiples of q.
