# NTT Model + RTL Generator — Project Brief (for Slide Preparation)

This document is a self-contained, slide-ready summary of the project living at
`/Users/zetaomiao/PythonProjects`. It is dense by design: it's meant to be
read once by a slide-making LLM (or a presenter) without needing to crawl the
codebase. Every concrete claim, number, file path, and citation comes from the
authoritative sources `CLAUDE.md`, `docs/THEORY.md` (NTT modeling),
`versal_arith/docs/THEORY.md`, the two `USAGE.md` files, and `scripts/README.md`,
plus the live synthesis/simulation results captured in this session.

---

## 1. One-paragraph elevator pitch

The project is an **end-to-end algorithm-to-RTL pipeline for Goldilocks-prime
Number-Theoretic Transform (NTT) hardware on AMD Versal FPGAs**. It has two
co-designed subprojects: a Python modelling library (`NTT_modeling/`) that
sizes the per-stage datapath via interval-bound propagation through a fully
pipelined butterfly grid, and an RTL generator (`versal_arith/`) that emits
synthesizable SystemVerilog using a Versal-specific compressor-tree heuristic
plus the paper's new GPC `(9 : 4, 1)`, the proposed two-layer quaternary
terminal adder, and a dual-5-LUT Booth mapping that delivers ~n²/4 LUT
multiplication on Versal. Five glue scripts handle remote V80 simulation and
out-of-context synthesis, so a single command can take an n=128 NTT design
all the way from "I want this bound" to "here's its post-opt LUT count and
WNS against a 5 ns clock."

## 2. Reference paper

> **Z. Miao, X. Pottier, J. Bertels, W. Legiest, I. Verbauwhede.**
> *Area-Efficient LUT-Based Multipliers for AMD Versal FPGAs.*
> IACR ePrint **2026/344**. <https://eprint.iacr.org/2026/344>

The paper covers the compressor-tree synthesis, the new `(9 : 4, 1)` GPC, the
two-layer quaternary terminal adder, and the dual-5-LUT Booth partial-product
mapping. The Goldilocks-slice butterfly, the constant multiplier (`cmult`), the
constant-multiplier bank (`cmultbank`), and the full NTT/INTT pipeline
generators are **user extensions on top of the paper**; their math is
documented in the project's own `docs/THEORY.md` and `versal_arith/docs/THEORY.md`.

Key headline results from the paper:
- **~n²/4 LUTs** for an n-bit signed multiplication using the dual-5-LUT
  Booth mapping (paper Fig. 12 / Table III), vs. ~n²/2 on UltraScale.
- **8–20% area-delay-product improvement** on standard bit-heap shapes
  (`(128)`, `(256)`, `(512)`, `(128,128)`, `(256,256)`, `(512,512)`,
  `Mul16`) over Hoßfeld et al.'s efficiency-first / strength-first
  Versal compressor heuristics (paper Fig. 11).
- **>40% LUT reduction** vs. AMD LogiCORE multipliers (speed-optimised) at
  comparable critical-path delay across operand widths 6..32 (paper Fig. 12).
- **>25% LUT reduction** at 16-bit vs. Hoßfeld's gate-absorption multiplier
  (175 vs. 245 LUTs — paper Table VII); the proposed 18-bit multiplier (217
  LUTs) even beats their 16-bit one.

## 3. Repository structure

```
/Users/zetaomiao/PythonProjects/
├── NTT_modeling/                       Python package — bound-propagation modelling library
│   ├── IntType.py                      Interval bound class (min, max, zeroLsbs)
│   ├── Port.py                         Carries IntType bound + list[int] testVector
│   ├── ButterflyScheme.py              ABC + GoldilocksSlice64 concrete scheme
│   ├── Butterfly.py                    Per-butterfly composition (bound + value paths)
│   ├── NTT.py                          FullyPipelinedNTT / FullyPipelinedINTT classes,
│   │                                   verifyNtt / verifyIntt, twiddle calc, xlsx I/O
│   └── utils.py                        nafTerms, nafTermsModulusLift, bitReverse, etc.
│
├── versal_arith/                       RTL generator (Versal FPGA target)
│   ├── cli.py                          CLI: -operator cmp / bmult / cmult / cmultbank / clean
│   ├── bitheap.py                      Multi-operand bit-heap data structure
│   ├── counter.py / heuristic.py       GPC catalogue + scheduling heuristic
│   ├── lut_init.py                     Truth-table → LUT INIT constants
│   ├── rtl/                            GPC primitive .sv files (c3_2, c6_3, c9_41, c15_3, c39_231,
│   │                                   c223_4, c413_341, c517_451, LFSR.sv)
│   ├── rtl_gen/                        Per-operator emit code: butterfly.py, ntt.py, chain.py,
│   │                                   lookahead.py, terminal_add.py, ...
│   ├── butterfly_spec.py               ButterflyOperatorSpec dataclass — data contract
│   ├── ntt_spec.py                     NTTOperatorSpec dataclass     — data contract
│   └── docs/{THEORY.md, USAGE.md}      Authoritative documentation
│
├── scripts/                            Five bridge scripts; full args in scripts/README.md
│   ├── build_butterfly.py              Generate one butterfly (RTL + xdc + tb)
│   ├── build_ntt.py                    Generate full NTT/INTT pipeline (with --debug-butterfly mode)
│   ├── build_bank.py                   Generate parallel constant-multiplier bank
│   ├── run_remote_sim.py               Stage to V80 server, run xsim batch, poll, pull verdict
│   └── run_remote_synth.py             Stage to V80, run synth_design + opt_design OOC, pull reports
│
├── work/<scenario>/<top>/              Per-scenario working directory (gitignored), contains
│   ├── RTL_generated/                  *.sv (DUT) + *_tb.sv (self-checking testbench)
│   ├── xdc_generated/                  *.xdc placement constraints (LUTNM)
│   ├── testvectors/                    *.txt random inputs + reference outputs
│   ├── sim_remote/                     V80 sim verdict + log (after run_remote_sim.py)
│   ├── synth_remote/                   V80 synth reports (after run_remote_synth.py)
│   └── manifest.json                   Per-run RTL gen metadata
│
├── docs/{THEORY.md, USAGE.md}          NTT modelling library documentation
├── scripts/README.md                   Bridge-scripts reference (1057 lines)
├── CLAUDE.md                           Per-repo instructions for Claude Code
├── runButterfly.py                     Top-level entry: sweeps NTT/INTT × CT/GS for n=128
├── runNTT128_GS_after_pretwist.py      User harness: cyclic GS NTT128 driven by pre-twist bank
├── runNTT128_GS_s130.py                User harness: cyclic GS NTT128, uniform s130 inputs
├── runINTT128_CT_s132.py               User harness: cyclic CT INTT128, uniform s132 inputs
├── twiddles.xlsx                       Frozen NAF-form twiddles for n=128
└── NTT_bounds.xlsx                     Per-stage bound snapshots saved by saveBoundsToXlsx
```

There is **no unit-test framework**. Verification is `verifyNtt`/`verifyIntt`
on the modelling side, the per-run `*_tb.sv` self-checking testbenches on the
RTL side (locally via Vivado, batched via `run_remote_sim.py` on the V80
server), and a local sanity check inside the harness's `emitRtl` step that
confirms the testvector hex round-trips through `propagateValue` mod 2^N.

## 4. Subproject 1 — `NTT_modeling`: modelling library

### Purpose

Sizes the FPGA/ASIC datapath of a fully pipelined NTT/INTT. **It is not a
numeric NTT** in the usual sense — it propagates `IntType(min, max, zeroLsbs)`
intervals through a butterfly graph so per-stage bit widths are known
*before* RTL is emitted, plus a parallel `list[int]` value-batch path used
to cross-check the arithmetic.

### Bottom-up component map

1. **`IntType(minValue, maxValue, zeroLsbs)`** — interval class. Operators
   `+ - * << >>` propagate worst-case bounds, *not* actual values.
   `bitWidth` is derived: unsigned ⇒ `maxValue.bit_length()`, signed ⇒
   `max(neg_width, pos_width) + 1`.
   - `slice(start, end)` has a critical signed-vs-unsigned split: a slice
     strictly narrower than the shifted bit-width is **unsigned**; a slice
     covering the entire shifted value preserves signedness. This split is
     essential to the Goldilocks limb folding (see §10).

2. **`Port`** — `SimpleInputPort` / `SimpleOutputPort` carry **both** an
   `IntType` `bound` *and* a `list[int]` `testVector`. Inputs connect to
   exactly one output; outputs fan out. `push()` propagates both fields in
   lockstep.

3. **`ButterflyScheme`** — abstract base class with two parallel paths
   kept rigorously separate by `isinstance` checks:
   - `propagateBound` returns `tuple[IntType, IntType]`
   - `propagateValue` returns `tuple[list[int], list[int]]`

   The only concrete subclass shipped is **`GoldilocksSlice64`** (see §10).

4. **`Butterfly`** — composition. `compute()` runs the bound path first
   (so the scheme's `aInBitWidth`/`bInBitWidth` are populated from the
   incoming bound's `.bitWidth` before `propagateValue` slices), then the
   value path. Without this ordering the value-path slicing falls back
   to per-batch `vectorBitWidth` and produces unreduced sums that diverge
   from the bound by multiples of `q` — see `docs/THEORY.md` §8c.

5. **`FullyPipelinedNTT`** / **`FullyPipelinedINTT`** — wire a `log2(n) × n/2`
   butterfly grid via the `butterflyToMems` / `memToButterfly` in-place memory
   bijections. INTT is a thin subclass of NTT (same wiring, inverse twiddles,
   **1/n scaling intentionally omitted**).

### CT vs. GS topology

Both topologies use the same `log2(n) × n/2` butterfly count; the difference is
which side of the pipeline carries the bit-reversed permutation:

|                   | CT (Decimation-in-Time)                       | GS (Decimation-in-Frequency)                    |
|-------------------|-----------------------------------------------|-------------------------------------------------|
| Input memory      | bit-reversed `x[bit_rev(m, L)]` at slot `m`   | natural `x[m]`                                  |
| Output memory     | natural `Y[m]` at slot `m`                    | bit-reversed `Y[bit_rev(m, L)]`                 |
| Stride at stage s | `2^s` (doubles)                               | `2^(L-s-1)` (halves)                            |
| Butterfly eqn     | `aOut = aIn + tw·bIn`, `bOut = aIn - tw·bIn`  | `aOut = aIn + bIn`, `bOut = (aIn - bIn)·tw`     |
| First-stage twist | trivial twiddles (= 1)                        | non-trivial twiddles                            |
| Last-stage twist  | non-trivial twiddles                          | trivial twiddles (= 1)                          |

`getInputsNatural` / `getOutputsNatural` auto-permute, so users always see
**natural-order** indices regardless of the chosen topology.

### NWC (negacyclic) pairing — enforced rule

Forward NWC requires `butterflyType == 'CT'`; inverse NWC requires
`butterflyType == 'GS'`. The opposite combinations raise `ValueError`. **The GS
butterfly equation cannot absorb a forward pre-twist cleanly**: in GS the
twiddle multiplies `(aIn − bIn)`, but the forward NWC pre-twist factor `ψ^i`
must multiply `aIn` and `bIn` *separately* before subtraction — irreconcilable.
See `docs/THEORY.md` §7f for the full algebra.

### Twiddles

- `calculateNttTwiddles(modulus, n, butterflyType, negacyclic, useModulusLiftingNaf, maxNumberOfTerms)`
  builds the `log2(n) × n/2` twiddle grid using Sage's `GF(q)`. With
  `useModulusLiftingNaf=True`, each twiddle is materialized as a NAF list
  ready for `GoldilocksSlice64` (≤ `maxNumberOfTerms` signed-power-of-2 terms;
  `maxNumberOfTerms=3` matches the per-butterfly hardware capacity).
- The cyclic case uses `ω = F.zeta(n)` with linear exponent progression `j · stepExp`.
- The negacyclic case uses `ψ = F.zeta(2n)` with odd progression `(2j+1) · stepExp`,
  only valid in CT direction.
- `loadTwiddlesFromXlsx` / `saveTwiddlesToXlsx` round-trip cells **byte-for-byte**
  (cells are NAF expression strings like `"-2^91 + 2^43"` or plain ints).

### Verification

- `referenceNtt` / `referenceIntt` are O(n²) Sage ground truth (no FFT).
- `verifyNtt(instance, batchSize, seed, inputBound)` and its INTT counterpart
  are end-to-end harnesses: random vectors → load both bound and value via
  `getInputsNatural` → `compute()` → check
  - `output mod q == reference[m]` for every `m` and every batch element, AND
  - every actual value lies inside its predicted bound interval.
  `inputBound` accepts three forms: `None` (default `IntType.signed(66)`
  broadcast), a single `IntType` (broadcast to every natural index), or a
  `list[IntType]` of length n (per-natural-index).

### XLSX I/O

- `saveTwiddlesToXlsx`: row 1 is `Layer 1..L` plus a trailing `<TYPE>
  BUTTERFLIES!!!` label (e.g. `GS BUTTERFLIES!!!`). Rows 2..n/2+1 hold
  per-butterfly twiddles. NAF expression strings for round-trip stability.
- `saveBoundsToXlsx`: per-port bounds to `NTT_bounds.xlsx`. Sheet name
  defaults to `instance.name`, so multiple instances share one workbook.

## 5. Subproject 2 — `versal_arith`: RTL generator

### Purpose

Automated SystemVerilog + XDC + testbench generation targeting AMD Versal
FPGAs. The default part (set in `scripts/run_remote_synth.py`) is the AMD
Alveo V80 board's `xcv80-lsva4737-2MHP-e-S`. The generator implements the
paper's compressor / Booth architecture; `cmult` and `cmultbank` are user
extensions.

### CLI operators (`cli.py`)

| Operator | Purpose |
|---|---|
| `cmp` | Compressor tree from a column-height descriptor |
| `bmult` | Signed radix-4 Booth tree multiplier (≥ 6×6) |
| `cmult` | `A × constant`, no DSP, NAF-decomposed |
| `cmultbank` | Parallel bank of `cmult`s with uniform pipeline latency |
| `clean` | Wipe output dir |

Two more generators have **no CLI hook** — they consume Python dataclasses
from `NTT_modeling`:
- **`Butterfly_RTL_gen`** in `rtl_gen/butterfly.py`: takes a
  `ButterflyOperatorSpec` plus four explicit `aIn`/`bIn`/`aOut`/`bOut`
  data arrays. Emits wrapper SV + two compressors + self-checking
  testbench + hex testvectors for one Goldilocks NTT butterfly.
  Driven via `GoldilocksSlice64.emitRtl(name, run_dir, ...)` or
  `scripts/build_butterfly.py`.
- **`NTT_RTL_gen`** in `rtl_gen/ntt.py`: takes an `NTTOperatorSpec` plus
  `pipeline_stages_per_layer: list[int]` plus precomputed natural-order
  goldens. Calls `Butterfly_RTL_gen` per butterfly with `gen_testbench=False`,
  emits a top wrapper SV that wires them per the in-place memory layout.
  **Wrapper / TB use per-index named ports** `x_in_<i>` / `y_out_<i>` — no
  2D-array slot, no max-width padding; each port is exactly its bound's
  width. Within-layer balancing shift registers auto-inserted when
  butterflies in the same layer report different actual latencies.
  Driven via `FullyPipelinedNTT.emitRtl(topName, run_dir, ...)` or
  `scripts/build_ntt.py`.

### Output layout per run

```
<output_dir>/<run_name>/
  RTL_generated/        *.sv (DUT) + *_tb.sv (self-checking testbench)
  xdc_generated/        *.xdc placement constraints (LUTNM grouping)
  testvectors/          random inputs + reference outputs (hex, for $readmemh)
  bitheap_visualization/ PNG per compression stage (if -visualization True)
```

When bringing a generated run into Vivado, also add **every `*.sv` from
`versal_arith/rtl/`** as a design source — those are the GPC primitive
modules (`c3_2`, `c6_3`, `c15_3`, `c223_4`, `c9_41`, `c39_231`, `c413_341`,
`c517_451`, `LFSR`) that the generated RTL instantiates by name.

## 6. Bridge scripts in `scripts/`

| Script | Role |
|---|---|
| `build_butterfly.py` | Generate one Goldilocks NTT butterfly's RTL from explicit `--aIn-bound` / `--bIn-bound` / `--twiddle` / topology args. Local sanity check, optional `--remote-sim` / `--remote-synth`. |
| `build_ntt.py` | Generate a full NTT/INTT pipeline (`FullyPipelinedNTT.emitRtl`). `--pipeline-stages` accepts a single int or a comma list of length log2(n). `--debug-butterfly L P` switches to per-butterfly debug mode (extracts that butterfly's bounds and twiddle from the populated NTT and calls `Butterfly_RTL_gen`). |
| `build_bank.py` | Generate a bank of N parallel constant multipliers from a `twiddles.xlsx` sheet/column or an integer-per-line file. |
| `run_remote_sim.py` | Stage a generated run onto the V80 server, **launch `sim.sh` detached** (`setsid nohup bash -c '... > log; echo $? > marker' &`), poll the exit marker, rsync the small log back. Verdict grep is `SUCCESS!` / `PASS All` (PASS), `FAILED:` / `WRONG` (FAIL). |
| `run_remote_synth.py` | Same detach + poll + small-rsync pattern for OOC synth. Per-run tcl applies `tcl/const.tcl` (5 ns clock), runs `synth_design -mode out_of_context -global_retiming off`, then `opt_design`, then writes `utilization.rpt` (post-opt, the realistic count) plus a pre-opt baseline `utilization_synth.rpt`, plus `timing_summary.rpt` and `timing_top10.rpt`. |

The detached-launch + poll-marker pattern was driven by two failure modes
seen on long NTT128 runs:
(a) a stuck SSH stdout pipe leaving the local subprocess hanging after xsim
already finished, and (b) jump-host idle timeouts severing a long-lived SSH
connection mid-sim.

## 7. End-to-end workflow

A full run (e.g. cyclic GS NTT128 with uniform s130 inputs) goes:

1. **Compute twiddles** in Sage.
2. **Build a `FullyPipelinedNTT` instance**, attach `GoldilocksSlice64`
   schemes to every butterfly via `setScheme`, set per-natural input
   bounds via `getInputsNatural([bound] * n)`, run `compute()`.
3. **Optional**: run `verifyNtt` against Sage `referenceNtt` for
   correctness + bound containment over many random batches.
4. **Drive value batches** via `getInputsNatural([batches])`, recompute,
   so every relevant port carries a `testVector`.
5. **Emit RTL** via `inst.emitRtl(topName, run_dir, pipeline_stages_per_layer,
   gen_testbench=True)`. Internally calls `getOperatorInterface(name=topName)`
   to build the `NTTOperatorSpec`, extracts goldens via
   `_extractGoldensNatural`, dispatches to `NTT_RTL_gen`, and runs a local
   sanity check (decode first 8 lines of `x_in.txt` / `y_out.txt`, drive
   them through `propagateValue` end-to-end via the same NTT instance,
   confirm each natural-output slot matches mod `2^slot_width`).
6. **Remote sim**: `run_remote_sim.py --run-dir <dir> --top <name>` →
   stages `RTL_generated/*.sv` (excluding TBs) into V80 `src/rtl/`, the TB
   into `src/rtl_tb/`, the testvectors into `src/testvectors/`, kicks off
   detached `sim.sh`, polls every 30 s, pulls back ~MB-scale log + verdict
   line.
7. **Remote synth**: `run_remote_synth.py --run-dir <dir> --top <name>` →
   stages RTL again (sim and synth share `src/rtl/`, so they must run
   sequentially), pushes a per-run tcl that reads `tcl/const.tcl`
   (`create_clock -period 5 -name clk_main [get_ports clk]`),
   runs `synth_design -mode out_of_context -global_retiming off`, writes
   `_synth.dcp`, runs `opt_design`, writes `_opt.dcp`, then rsyncs
   `utilization_synth.rpt` (pre-opt baseline), `utilization.rpt` (post-opt
   realistic), `timing_summary.rpt`, `timing_top10.rpt` back. Optionally
   `--pull-dcp` retrieves the multi-MB checkpoints.

A **full NTT128 emit + 1000-testvector V80 sim + V80 OOC synth** completes
in roughly **35–55 minutes** end-to-end.

## 8. The Goldilocks slice (`GoldilocksSlice64`) — heart of every NTT butterfly

### The prime

The Goldilocks prime
```
q = 2^64 - 2^32 + 1   (≈ 1.8447 × 10^19, fits in 64 bits)
```
is chosen because of these mod-q identities:
```
2^64  ≡ 2^32 - 1   (mod q)
2^96  ≡ -1         (mod q)
2^128 ≡ -2^32      (mod q)
2^160 ≡ -2^32 + 1  (mod q)
2^192 ≡ 1          (mod q)
```
They partition any integer into 192-bit blocks where each block reduces to a
signed sum of two 64-bit limbs (one shifted by 0, one by 32). The
multiplicative group of `F_q` has 2-power roots of unity up to order `2^32`,
enough for any reasonable NTT size including negacyclic.

### The slice algorithm

`GoldilocksSlice64.propagateBound` (and, in lockstep,
`getOperatorInterface`) consume:
- a CT-or-GS butterfly equation (selected by `self.butterflyType`),
- an `aIn` / `bIn` `IntType` with arbitrary signed/unsigned bounds,
- a NAF-lifted twiddle of ≤3 signed-power-of-2 terms (>3 is a hard error).

It produces an unreduced 192-bit accumulator initialized to `−q` (lazy
reduction), folds every input via the Goldilocks identities above (using
`IntType.slice(start, end)` to extract limbs respecting signed/unsigned
boundaries — see §3a in the modelling theory doc), and outputs a tightly
bounded value typically in `[-q, +q)` ≈ s66.

### Why the same operator handles wildly different input shapes

The same butterfly produces the same output range
(s66, `[-2^64, +2^64]`) whether the inputs are:
- per-natural mixed widths s24..s121 (post-pre-twist NTT, see §11), OR
- uniform s130 signed (pure NTT_s130 case), OR
- uniform s132 signed (pure INTT_s132 case).

The lazy-reduction folding caps the output at Goldilocks magnitude regardless
of input width — input width affects internal bit-heap shapes (and thus LUT
count), not output width.

In CT direction, where the **last** stage carries the non-trivial twiddles,
some final-stage outputs widen slightly (s67 / s68 for ~98 of 128 slots in
INTT128), reflecting differential lifted-NAF magnitudes.

## 9. NAF + modulus lifting

A constant multiplier `c · x` is far cheaper if `c` is a small number of
signed shifts: `c · x = ±x<<a₁ ±x<<a₂ ±…`. The non-adjacent form (NAF) gives
the shortest such representation in the unconstrained case; for an arbitrary
64-bit constant, NAF averages **~21 terms** — too many.

For NTT twiddles we have *modulus freedom* — we only need a value congruent
to `c (mod q)`. So `nafTermsModulusLift` searches for a "lifted" `y ≡ c
(mod q)` whose NAF has fewer terms:

1. **Target-first exhaustive search**: enumerate sums of `k = 1, 2, …, maxNumberOfTerms`
   signed powers of 2 with exponents up to `maxPower`. Return the first one
   congruent to `c (mod q)`.
2. **Beam-search fallback** (default beam = 200): walk a beam of
   `(c + k·q · 2^j)` candidates, scoring by NAF term count.

For Goldilocks twiddles called with `maxNumberOfTerms=3, maxPower=95,
maxMultipleOfModulus=2^32`, **target-first typically succeeds**, so each
twiddle becomes ≤3 shift-add ops — exactly matching the per-butterfly
hardware capacity. A 21-term constant routinely drops to **2–4 terms**.

The procedure is **deterministic**: re-running on the same `(c, q)`
parameters produces the same lifted integer, not just one congruent mod q.
This is what lets `loadTwiddlesFromXlsx` / `saveTwiddlesToXlsx` round-trip
bit-perfectly.

A concrete example (cyclic-CT INTT, layer 1 butterfly 1):
- Sage-returned unreduced raw integer: ~10³⁰⁸ (2048 bits — Sage doesn't
  reduce in this code path)
- Reduced mod q: `18446462594437873665` (64 bits)
- Simple NAF of the reduced 64-bit value: **4 terms**
- **Modulus-lifted NAF: `[(-1, 48)]` → just `−2⁴⁸`, 1 term**

## 10. The Versal-specific RTL generator innovations

These are paper contributions, not user extensions.

### 10.1 Versal CLB vs. UltraScale (paper §II.A)

Two re-architectures compared with UltraScale:

**LUT.** UltraScale dual-5-LUT mode forces all five inputs `A1..A5` to be
shared between the two halves. **Versal LUTs add two configurable cascade
muxes** that let `A5`, `A6`, or `CASC` drive the fifth input
**independently** for each half — so the two 5-LUTs can have different
fifth inputs, with the second 5-LUT's output emerging on a new `O5_2` pin
(instead of `O6` on UltraScale). A new `PROP` output exists exclusively for
the LOOKAHEAD8 carry path. A dedicated **LUT-cascade wire** runs from the
`O6` of the lower LUT in a pair into the `CASC` input of the upper LUT, so
some sum/carry forwarding doesn't need general-purpose routing.

**Carry.** UltraScale's `CARRY8` is replaced by **`LOOKAHEAD8`**. Inside
each two-bit section, the propagate XOR/MUX cells that lived alongside the
LUT are removed; instead, propagate signals come from a dedicated 4-input
sub-LUT and exit on `PROP`. Carry multiplexing happens inside LOOKAHEAD8
under the control of attributes `LOOKB`, `LOOKD`, `LOOKF`, `LOOKH` (one
per two-bit section). When all `LOOKx = FALSE`, only the `CYB → COUTB`
arc is timing-defined — meaning GPCs that are not LOOKAHEAD8-compatible
can't simply "fall through" the chain; they must use general-purpose
routing for their cascade, which is slower.

These two changes drive nearly every architectural decision in the
generator.

### 10.2 The GPC catalogue (paper Table IV)

Eight Generalized Parallel Counters used by the generator. Notation:
`(p_{m-1}, …, p_0 : q_{n-1}, …, q_0)` where `p_i` = input bits of weight
`2^i` and `q_j` = output bits of weight `2^j`.

| GPC | LUTs | E | S | LOOKAHEAD8-compat. | Row-counter eligible |
|-----|:----:|:----:|:----:|:----:|:----:|
| `(5, 17 : 4, 5, 1)` | 8 | 1.5  | 2.2   | ✗ | ✗ |
| `(4, 13 : 3, 4, 1)` | 6 | 1.5  | 2.125 | ✗ | ✗ |
| `(3, 9 : 2, 3, 1)`  | 4 | 1.5  | 2.0   | ✗ (dual-rail exception) | ✓ |
| **`(9 : 4, 1)`**    | 3 | 1.33 | 1.8   | ✗ | ✓ |
| `(6 : 3]`           | 3 | 1.0  | 2.0   | ✗ | ✓ |
| `(2, 2, 3 : 4]`     | 2 | 1.5  | 1.75  | ✗ | ✓ |
| `(3 : 2]`           | 1 | 1.0  | 1.5   | ✓ | ✓ |
| `(1, 5 : 3]`        | 2 | 1.5  | 2.0   | ✓ | ✓ |

`E` = `(Σ p − Σ q) / #LUTs` (efficiency, implementation-dependent).
`S` = `Σ p / Σ q` (strength, implementation-independent).

**`(9 : 4, 1)` is proposed by this paper** (paper §IV.B): replaces the
earlier `(10 : 4, 2)` because of higher strength, and the depth-`n=4`
column counter `(2n+1 : n, 1)` because of higher efficiency. Column
counters are dropped entirely — the paper argues they need to be
depth-limited to satisfy timing on Versal, and within those depth limits
the row-counter constructions dominate them.

### 10.3 Compression heuristic (paper §IV.E)

Existing Versal compressor heuristics (Hoßfeld et al., ACM TRETS 2024)
prioritise either GPC efficiency or strength in isolation. The paper's
heuristic instead **takes both area and delay into account**: a GPC is
scheduled at column `c` only when both
- **applicable** (input columns have enough free bits + LOOKAHEAD8
  cascade rules satisfied), AND
- **necessary** (placing this GPC reaches the lowest LUT cost for reducing
  column `c` and a limited span of subsequent columns to height ≤ 4).

Necessity conditions per GPC are spelled out in paper Table V (function of
local column heights `H_c`, `H_{c+1}`, `H_{c+2}`). The heuristic walks the
table in priority order, placing the first counter that is both applicable
and necessary. After all stages are placed, an optional **stage-merging
pass** can collapse the last GPC-compression stage into the previous one
by allowing limited under-utilisation of `(3 : 2]` and `(1, 5 : 3]`
counters — trims one sequential stage with no LUT-cost increase.

Compression target: **height ≤ 4** (not classic Dadda height ≤ 2),
because the proposed two-layer terminal quaternary adder (next subsection)
finishes faster than a binary CPA at that depth on Versal fabric.

Result: paper Fig. 11 reports an **8–20% area-delay-product improvement**
over Hoßfeld et al.'s heuristics, evaluated on `(128)`, `(256)`, `(512)`,
`(128,128)`, `(256,256)`, `(512,512)`, and `Mul16` bit heaps.

### 10.4 The proposed two-layer quaternary terminal adder (paper §IV.D)

Hoßfeld et al.'s quaternary terminal adder absorbs carry-save logic into
ripple-carry LUTs (paper Fig. 9). It saves one LUT per bit vs. two-operand
trees, but breaks down on bit heaps with single-bit columns at the MSB:
direct application prevents LUT merging there, and stitching with a
two-operand adder forces general-purpose routing.

The paper's alternative (paper Fig. 10) is **two layers of row counters**:
- **Primary GPC: `(1, 5 : 3]`.** Each instance consumes 4 bits of column
  `c` plus 1 bit of column `c+1` and produces 3 output bits across columns
  `c, c+1, c+2`. Cascading these in a row counter handles the typical
  "height = 3 or 4" body of the bit heap directly.
- **Stitching GPC: `(3 : 2]`.** Where the bit heap thins out (single-bit
  columns toward the MSB), `(3 : 2]` propagates the carry one column at a
  time at 1 LUT per bit, with no extra routing.

Conceptually `terminalAdd_gen` partitions the input column-height list
into four contiguous regions (tail / body / two-operand / head), assigns
the right GPC pattern to each, and stitches everything inside the same
LOOKAHEAD8 fabric.

### 10.5 Booth radix-4 + dual-5-LUT mapping (paper §IV.A)

For **variable × variable** multiplication (≥ 6×6), the generator emits a
signed radix-4 modified-Booth multiplier. The recoding turns `B` into
`⌈width_b / 2⌉` digits in `{−2, −1, 0, +1, +2}`, halving the partial-product
count vs. radix-2.

**The Versal dual-5-LUT trick** is the paper's headline innovation. Each
partial-product bit `P'_{i,j}` is a Boolean function of five inputs:
`(b_{2i+1}, b_{2i}, b_{2i-1})` from `B` and `(a_j, a_{j-1})` (with
`a_{-1} = 0`) from `A`. On UltraScale this is **one LUT per PP bit** because
dual-5-LUT mode there shares all five inputs, so an n-bit multiplier needs
~n²/2 LUTs.

**Adjacent partial-product bits `(P'_{i,j+1}, P'_{i,j})` share four inputs**
— the three `B` bits plus `a_j`. Versal's dual-5-LUT mode allows
**independent fifth inputs**, so a single Versal LUT generates **two
adjacent PP bits** by routing `a_{j-1}` into `O5_1` and `a_{j+1}` into
`O5_2`. Total cost: **~n²/4 LUTs**.

Sign extension via Baugh-Wooley (paper Fig. 5) then folds the row of
replicated sign bits into a single inverted sign bit + constant `1'b1`s,
keeping the bit heap narrow.

Result: paper Fig. 12 reports up to **40% LUT reduction** vs. AMD LogiCORE
(speed-optimised) at comparable critical-path delay; paper Table VII shows
the proposed 16-bit multiplier at 175 LUTs vs. Hoßfeld et al.'s 245 LUTs
(>25% reduction); the proposed 18-bit multiplier (217 LUTs) even beats
Hoßfeld's 16-bit multiplier.

### 10.6 `cmult` (constant multiplier) — user extension (not in paper)

`cmult` generates `A × C` for constant `C` using only shifts, adds, and
(when needed) the GPC compressor pipeline above. **No DSP blocks
inferred**. Strategy dispatch is by **maximum bit-heap column height**, not
NAF term count:

| Max height | Strategy | Why |
|---|---|---|
| 1 | Pure wiring (shifts + inverters) | Only one bit per column |
| 2 | Verilog `+`/`-` (CPA) | Maps onto LOOKAHEAD8 carry chain directly |
| ≥ 3 | Full bit-heap compressor tree | Reuses §10.3 heuristic |

The `-modulus q` flag enables modulus lifting (§9), typically dropping a
21-term Goldilocks twiddle to 2–4 terms. Signed inputs and negative
constants add Baugh-Wooley correction bits that can push a "2-term" NAF
constant up into the compressor strategy.

### 10.7 `cmultbank` — parallel bank of cmults — user extension

A bank of N parallel constant multipliers driven by a shared input bus.
Shorter-latency compressors get auto-inserted balancing flip-flops so every
output port has identical pipeline latency. Used for the NTT pre-twist /
post-twist banks. Emits a sidecar `output_bounds.json` so a downstream
NTT/INTT can be driven at exactly the bank's per-output widths.

## 11. Live design results from the most recent session

Three NTT/INTT pipelines plus two cmultbank instances designed, simulated,
and synthesised on the V80 server during this session — all NTT/INTT share
`n = 128`, `q = 2^64 − 2^32 + 1`, 1 pipeline-stage-per-layer (so total
latency = 7), 1000 random testvectors, synthesised against a 5 ns clock.

| | **NTT_pretwist** | **NTT_s130** | **INTT_s132** |
|---|---|---|---|
| Direction | forward GS cyclic | forward GS cyclic | inverse CT cyclic |
| Inputs | per-natural mixed widths s24..s121 (from a 128-wide u32×s24 cmultbank acting as the negacyclic pre-twist) | uniform **s130** signed | uniform **s132** signed |
| Outputs | uniform **s66** signed, all 128 in `[-2⁶⁴, +2⁶⁴]` | uniform **s66** signed | mixed: **s66×30, s67×90, s68×8**, all signed |
| Sim verdict | **1000/1000 PASS** | **1000/1000 PASS** | **1000/1000 PASS** |
| Sage `verifyNtt`/`verifyIntt` | mod-q 1024/1024, bound 7168/7168 | mod-q 1024/1024, bound 7168/7168 | mod-q 1024/1024, bound 7168/7168 |
| LUTs (post-opt) | **142,088** | **150,794** | **152,742** |
| Registers | 59,256 | 59,296 | 59,662 |
| LOOKAHEAD8 | 20,081 | 21,308 | 21,760 |
| **WNS @ 5 ns** | **+1.816 ns** | **+1.822 ns** | **+1.111 ns** |

**The two cmultbank instances** (each n=128 parallel cmults, 1 pipeline stage):

| | **pre_twist bank** | **post_twist bank** |
|---|---|---|
| Input width | u24 (24-bit unsigned) | s68 (68-bit signed) |
| Constants | 128 from `twiddles.xlsx::PRE_TWIST` (lifted-NAF) | 128 from `twiddles.xlsx::POST_TWIST` (lifted-NAF) |
| Sim verdict | 128 000 / 128 000 PASS | **128 000 / 128 000 PASS** |
| LUTs (post-opt) | 22 291 | **62 965** |
| Registers | 8 956 | 15 496 |
| LOOKAHEAD8 | 2 838 | 9 387 |
| WNS @ 5 ns | (not reported, single pipeline stage = no FF-to-FF paths) | (same) |

Post-twist is ~3× larger because of the wider, signed input.

V80 part: `xcv80-lsva4737-2MHP-e-S` (an Alveo V80 board). All synth runs
used `-mode out_of_context -global_retiming off` followed by `opt_design`
(otherwise the pre-opt count is misleadingly high — e.g. 196,225 → 150,794
for `NTT_s130` after `opt_design` merges 43k LUT1 inverters into adjacent
LUTs).

Empirical bound check on `NTT_s130`: 1000 random s130 input batches × 128
outputs = 128,000 output samples; **all 128,000 fit exactly in s66
[`−2⁶⁴`, `+2⁶⁴`]** with empirical extremes hitting ~99.97% of the predicted
range (`min ≈ −1.839 × 10¹⁹`, `max ≈ +1.839 × 10¹⁹`), confirming the bound
is tight, not loose.

Why the timing differs across the three:
- The two **GS forward NTT** designs (`NTT_pretwist`, `NTT_s130`) have the
  same critical-path topology — last layer's twiddles are all `1`, so
  the final stage is a plain CSA + reduction with no constant-mult tree.
  Both finish at WNS ≈ +1.82 ns.
- The **CT inverse INTT** has its non-trivial twiddles in the **last**
  stage, so the critical path runs through a Goldilocks-slice multiplier
  in the final layer — WNS shrinks to +1.11 ns.

Why `NTT_s130` and `INTT_s132` cost ~6–7% more LUTs than `NTT_pretwist`:
the wider, uniform input bound forces the per-stage carry chains to be
longer in the early layers before the GS reductions narrow everything back
to s66 by the output. The pre-twist bank's per-natural mixed widths give
many narrow inputs that cost less to compress.

### Two important supporting fixes from this session

**(a) Butterfly module namespacing** (in `NTT_modeling/NTT.py:514`).
When generating multiple NTT instances for the **same Vivado project**,
butterfly module names must be uniquely namespaced or modules collide. The
modelling library now generates butterfly module names as
`<ntt_top_name>_btf_L<s>_p<p>` (e.g. `NTT_s130_btf_L1_p57`). The
abbreviation `btf` (vs full `Butterfly`) keeps the resulting identifiers
short — Vivado xelab was observed producing **spurious multi-driver
errors** when the namespacing prefix pushed total module + instance names
past ~50 characters in a 449-butterfly elaboration. Single-module
compiles never trip this pathology. Standalone `build_butterfly.py`
keeps its own non-colliding `Butterfly_n<N>_<TYPE>_*` shape.

**(b) Off-by-one fix in `cmult` signed-input bit-heap** (in
`versal_arith/power_writer.py:149-156`). Found while bringing up the
post-twist bank (s68 input × 128 NAF-lifted constants). The
`build_const_mult_bitheap` function computed an internal `max_bits` that
was one column shorter than `Cmult_RTL_gen._output_width()`'s
IntType-derived port width — both values agree for unsigned and
multi-term signed cases, but disagree for **signed-input × single
positive power-of-2** constants when the product range hits a power-of-2
boundary exactly (e.g. `s68 · +2^29 ⇒ [−2^96, 2^96 − 2^29]`). The
shorter `max_bits` left the wrapper's top column empty, skipping the
Baugh-Wooley `1'b1` sign-extension correction at column `power +
input_width`. Result: 14 of 128 post-twist bank slots silently miscomputed
the high bit (1000 / 1000 wrong checks each → 14 000 / 128 000 fails).
Fix: replace `max(neg_w, pos_w)` with
`max(abs(prod_min), abs(prod_max)).bit_length()`. After the fix, the
post-twist bank passes 128 000 / 128 000 sim checks. The fault was
asymmetric — negative single-power-of-2 constants already had `pos_w`
take the larger value, so they were correctly handled all along.

## 12. Architecture decisions worth highlighting

- **Bound and value paths separated by type.** `propagateBound` works on
  `IntType`, `propagateValue` on `list[int]`. The ABC enforces this with
  `isinstance` pre-checks. The two paths run through the **same**
  `_buildSliceTerms` helper so the IntType bound math and the RTL spec
  cannot drift apart.
- **Per-port bit widths are independent on a single butterfly.** The spec
  carries `aInBitWidth` / `bInBitWidth` separately, the wrapper RTL
  declares `aIn[…]` / `bIn[…]` independently, and `build_butterfly.py`
  requires both `--aIn-bound` and `--bIn-bound` (no shared default).
  Asymmetric widths (e.g. `s66 / u32`) are validated end-to-end on Vivado.
- **Per-natural input + output widths on the full NTT.** Every natural
  index has its own width and signedness — no uniformity assumed or
  enforced. The wrapper / TB use **per-index named ports** `x_in_<i>` /
  `y_out_<i>`, each at exactly its bound's width — no 2D-array slot, no
  max-width padding.
- **Twiddle xlsx round-trip is byte-stable.** `loadTwiddlesFromXlsx` /
  `saveTwiddlesToXlsx` round-trip cells exactly. `iNTT_TWIDDLES` (sheet
  for the cyclic CT INTT n=128 case) was confirmed
  byte-for-byte identical to a freshly computed
  `calculateInttTwiddles(useModulusLiftingNaf=True, maxNumberOfTerms=3)` —
  448 / 448 cells matched in **exact integer value**, not just `mod q`
  congruence. The lifted form picks the deterministic
  representative integer that the xlsx was originally generated with.
- **NWC pairing rule is enforced.** `ValueError` raised on
  `negacyclic=True, butterflyType='GS'` for forward, and on
  `negacyclic=True, butterflyType='CT'` for inverse — the GS butterfly
  cannot absorb a forward pre-twist cleanly.
- **`limbs64` table is Goldilocks-specific.** If you add a scheme for
  another prime, build its own table — don't generalise this one.

## 13. Suggested slide outline

A presentation aiming at 12–15 slides could go:

1. **Title** — Project name + one-line elevator pitch.
2. **Why Goldilocks NTT on Versal?** — application context (lattice crypto,
   FHE, ZK proofs); reduction-by-shift property; v80 target.
3. **Architecture overview** — single diagram: `NTT_modeling` (bound prop)
   → `versal_arith` (RTL gen) → V80 (sim + synth). Show the three
   `docs/THEORY.md` + `versal_arith/docs/THEORY.md` + `scripts/README.md`
   as the authoritative sources.
4. **The Goldilocks slice (§8)** — the `limbs64` table; why a 192-bit
   accumulator initialised to `−q` lazily reduces every input.
5. **NAF + modulus lifting (§9)** — example: `c (mod q)` ~10³⁰⁸ raw,
   64-bit reduced, simple-NAF 4 terms, lifted-NAF **1 term `−2⁴⁸`**.
6. **Versal LUT vs UltraScale (§10.1)** — paper Fig. 1 + Fig. 2; the new
   `O5_2`, `PROP`, LUT-cascade wire, LOOKAHEAD8.
7. **GPC catalogue (§10.2)** — paper Table IV; highlight the new
   `(9 : 4, 1)`.
8. **Compression heuristic (§10.3)** — area + delay co-optimisation;
   stage-merging pass; **8–20% ADP improvement** over Hoßfeld et al.
9. **Two-layer quaternary terminal adder (§10.4)** — paper Fig. 10;
   `(1, 5 : 3]` body + `(3 : 2]` stitching.
10. **Booth dual-5-LUT mapping (§10.5)** — paper Table III; ~n²/4 LUTs;
    **>40% reduction vs LogiCORE**, **>25% vs Hoßfeld**.
11. **From algorithm to RTL** — workflow diagram (§7); the
    `getOperatorInterface` data contract; per-index named ports.
12. **Live results (§11)** — table of NTT_pretwist / NTT_s130 / INTT_s132;
    1000-testvector PASS; LUTs / WNS.
13. **Empirical bound tightness** — 128,000 NTT_s130 output samples all
    fit in s66, ~99.97% of predicted range exercised.
14. **Limitations / future work** — `cmult` / `cmultbank` are user
    extensions; full P&R flow not yet wrapped (only OOC synth);
    `xcv80-lsva4737-2MHP-e-S`-specific, would need part-table edits to
    retarget.
15. **References** — IACR 2026/344; Hoßfeld et al. ACM TRETS 17(2), 2024;
    AMD UG974 / AM005.

## 14. Pointer index for the slide-maker

If specific sections, equations, or figures are needed:

| Topic | Authoritative source |
|---|---|
| Goldilocks slice algorithm | `docs/THEORY.md` §3a, §10 |
| NWC pairing derivation (CT vs GS forward/inverse) | `docs/THEORY.md` §7 (centerpiece, ~150 lines) |
| Versal LUT and LOOKAHEAD8 details | `versal_arith/docs/THEORY.md` §1 |
| GPC catalogue + new `(9 : 4, 1)` | `versal_arith/docs/THEORY.md` §3, §3.2, §3.3 |
| Compression heuristic + stage merging | `versal_arith/docs/THEORY.md` §4 |
| Two-layer quaternary terminal adder | `versal_arith/docs/THEORY.md` §5 |
| Booth dual-5-LUT mapping | `versal_arith/docs/THEORY.md` §6 |
| NAF + modulus lifting | `versal_arith/docs/THEORY.md` §7 (cmult extension); `docs/THEORY.md` §2 (NTT side) |
| `cmult` / `cmultbank` strategy dispatch | `versal_arith/docs/THEORY.md` §7 (Strategy dispatch) |
| Pipelining / register insertion | `versal_arith/docs/THEORY.md` §8 |
| Bridge-script CLI flags + return codes | `scripts/README.md` |
| Live results from this session | this file §11 |

End of brief.
