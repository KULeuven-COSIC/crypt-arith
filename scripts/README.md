# scripts/

End-to-end workflow scripts that bridge the two subprojects in this repo:

- **`NTT_modeling/`** — the Python modeling library (bound propagation + value
  simulation for Goldilocks-NTT butterflies).
- **`versal_arith/`** — the SystemVerilog RTL generator (compressor trees,
  Booth multipliers, constant multipliers, butterfly modules) targeting AMD
  Versal LUT + LOOKAHEAD8 primitives.

Each script in this directory is a glue layer that wires those two subprojects
together — extracting hardware-relevant data from `NTT_modeling`, feeding it
into `versal_arith`, and (optionally) shipping the generated RTL to a remote
V80 server for Vivado simulation.

The five scripts:

| Script | Purpose | Output |
|---|---|---|
| `build_butterfly.py` | Generate the SV for **one** Goldilocks butterfly module | wrapper + 2 compressors + testbench + hex testvectors + spec.json |
| `build_ntt.py` | Generate the SV for **a full NTT/INTT pipeline** (or one butterfly within it, in `--debug-butterfly` mode) | top wrapper + per-butterfly DUTs + per-butterfly compressors + top testbench + packed-hex testvectors + manifest.json |
| `build_bank.py` | Generate the SV for a **bank of constant multipliers** (e.g. NTT pre-twist / post-twist) | one SV per constant + top-level wrapper + testbench + per-port `output_bounds.json` |
| `run_remote_sim.py` | Stage any generated run onto the V80 server and run Vivado batch sim | sim_stdout.log + small elab.log + PASS / FAIL verdict |
| `run_remote_synth.py` | Stage any generated run onto the V80 server and run Vivado batch out-of-context synthesis | utilization.rpt + timing_summary.rpt + timing_top10.rpt + LUT/FF/WNS/TNS summary line |

Run all five from the **project root** (`/Users/zetaomiao/PythonProjects`),
inside the `ntt-sage` conda env (Sage is required for twiddle computation, and
openpyxl is required for xlsx-based workflows).

```bash
conda activate ntt-sage
python scripts/build_butterfly.py ...
```

---

## 1. `build_butterfly.py` — single butterfly RTL

Generates a self-contained run directory for **one** Goldilocks-NTT butterfly
identified by its (layer, position) in the pipeline grid. Walks the data
flow:

```
                 (one of three twiddle sources)
                              |
                              v
   GoldilocksSlice64 (NTT_modeling)
        .aIn = IntType.<signed/unsigned>(W)
        .bIn = IntType.<signed/unsigned>(W')
        .twiddle = NAF list
                              |
                              v
        scheme.emitRtl(name, run_dir, pipeline_stages, test_size, seed, ...)
                              |
                              v
                work/<scenario>/butterfly_L<L>_p<P>/
                  RTL_generated/  xdc_generated/
                  testvectors/    bitheap_visualization/
                  spec.json
```

The script is a thin orchestrator: parse args, resolve the twiddle, populate
the `GoldilocksSlice64`, then call `scheme.emitRtl(...)`. The method on the
populated scheme handles spec extraction (`getOperatorInterface`), random
testvector sampling, `propagateValue` golden computation, the
`os.chdir(run_dir)` dance, the `Butterfly_RTL_gen` dispatch, and the local
twos-complement-encoding sanity check.

### 1a. Generated layout

For `--scenario foo`, layer 2, position 5:

```
work/foo/butterfly_L2_p5/
├── RTL_generated/
│   ├── Butterfly_n128_GS_L2_p5.sv             ← wrapper module (top of the butterfly)
│   ├── Butterfly_n128_GS_L2_p5_aOut_cmp.sv    ← aOut bit-heap compressor
│   ├── Butterfly_n128_GS_L2_p5_bOut_cmp.sv    ← bOut bit-heap compressor
│   └── Butterfly_n128_GS_L2_p5_tb.sv          ← self-checking testbench
├── xdc_generated/
│   ├── Butterfly_n128_GS_L2_p5_aOut_cmp.xdc   ← LUTNM placement constraints (aOut)
│   └── Butterfly_n128_GS_L2_p5_bOut_cmp.xdc   ← LUTNM placement constraints (bOut)
├── testvectors/
│   ├── aIn.txt, bIn.txt                       ← random inputs (hex, 2's complement)
│   └── aOut.txt, bOut.txt                     ← golden outputs from propagateValue
├── bitheap_visualization/                     ← (only when --visualization)
│   ├── aOut_original_bitheap.png
│   ├── aOut_after_layer_*.png
│   ├── bOut_original_bitheap.png
│   └── bOut_after_layer_*.png
├── Butterfly_n128_GS_L2_p5_aOut_bitheap.txt   ← column heights (intermediate)
├── Butterfly_n128_GS_L2_p5_bOut_bitheap.txt
└── spec.json                                   ← full ButterflyOperatorSpec
```

The wrapper module instantiates the two compressors and routes the same `aIn`
and `bIn` registers into both via fan-out. The testbench drives random vectors
one per cycle and compares the outputs against `aOut.txt` / `bOut.txt` after
the pipeline-flush latency.

To bring this into Vivado, add **all four `*.sv` files** plus everything under
`versal_arith/rtl/` (the GPC primitive modules: `c3_2.sv`, `c6_3.sv`,
`c15_3.sv`, `c223_4.sv`, `c9_41.sv`, `c39_231.sv`, `c413_341.sv`,
`c517_451.sv`) as design sources, and the `*.xdc` files as implementation
constraints.

### 1b. Argument reference

#### Identity

| Flag | Type | Required | Description |
|---|---|:---:|---|
| `--scenario` | str | **yes** | Subfolder name under `--work-dir`. Multiple butterflies for one design typically share a scenario. |
| `--n` | int | **yes** | NTT size. Must be a power of 2. |
| `--butterfly-type` | choice | **yes** | One of `CT` or `GS`. Picks the butterfly equation: CT puts the multiply on input-B (`aOut = aIn + tw·bIn`); GS puts it on the difference (`bOut = (aIn - bIn)·tw`). |
| `--layer` | int | **yes** | 0-indexed pipeline stage. For n=128 there are L=log2(128)=7 layers, indexed 0..6. |
| `--position` | int | **yes** | 0-indexed butterfly position within the layer. Range is 0..n/2-1. |

#### Twiddle source — pick exactly one

The three twiddle sources are mutually exclusive. If you don't pass
`--twiddle-naf` or `--compute-twiddles`, the script falls through to the xlsx
path (with the defaults below).

##### A. xlsx (default)

| Flag | Default | Description |
|---|---|---|
| `--twiddles-xlsx` | `twiddles.xlsx` | Path to the workbook produced by `NTT_modeling.NTT.saveTwiddlesToXlsx`. |
| `--twiddles-sheet` | `NTT_TWIDDLES` | Sheet name. Convention: `NTT_TWIDDLES` for forward, `iNTT_TWIDDLES` for inverse, custom for everything else. |

The xlsx must follow the layout that `loadTwiddlesFromXlsx` parses:

| | A | B | C | … | (Layer L) | (label) |
|---|---|---|---|---|---|---|
| Row 1 | `Layer 1` | `Layer 2` | `Layer 3` | … | `Layer L` | e.g. `GS BUTTERFLIES!!!` |
| Row 2 (p=0) | `1` | `1` | `1` | … | `1` | (empty) |
| Row 3 (p=1) | `-2^91 + 2^43` | `2^39` | `2^78` | … | `1` | (empty) |
| Row 4 (p=2) | `2^39` | `2^78` | `-2^60` | … | `1` | (empty) |
| … | … | … | … | … | … | (empty) |
| Row n/2+1 (p=n/2−1) | … | … | … | … | … | (empty) |

Rules:

- Row 1 must hold `Layer 1`, `Layer 2`, …, `Layer L` cells. The L count is
  inferred. Anything past `Layer L` (label cells) is ignored.
- Rows 2..(n/2 + 1) are butterfly data, in physical top-to-bottom order. The
  parser reads until it hits the first `None` in column A.
- Each cell is **either** a plain integer (decomposed to NAF via `nafTerms`)
  **or** a NAF expression string. Empty cells inside the grid are not
  permitted.
- NAF expression syntax: `-2^91 + 2^43`, `2^39`, `-2^60`, plain `1`. Leading
  `+` is optional; whitespace is ignored; base must be `2`; exponents are
  non-negative integers.

The script accesses `twiddles[args.layer][args.position]` after loading.
Indexing is 0-based, so `--layer 0 --position 1` reads "Layer 1" cell at
row 3 column A.

##### B. NAF expression

| Flag | Description |
|---|---|
| `--twiddle-naf '+2^43 - 2^91'` | Direct NAF expression for one twiddle. Same syntax as xlsx cells. Skips xlsx loading entirely; useful for hand-picked twiddles or one-off bug reproduction. |

The script enforces ≤ 3 NAF terms (the `GoldilocksSlice64` hardware constraint).
Larger inputs error out cleanly.

##### C. Sage compute

| Flag | Description |
|---|---|
| `--compute-twiddles` | Compute the entire NTT twiddle grid via `calculateNttTwiddles` (or `calculateInttTwiddles` if `--inverse`). Always uses NAF modulus lifting with `maxNumberOfTerms=3`. |
| `--primitive-root <int>` | Required when `--compute-twiddles` is set. The base root of unity in F_q. For n=128 with the project's standard primitive 128-th root: **17870292113338400769**. |
| `--inverse` | Use `calculateInttTwiddles` instead of `calculateNttTwiddles` (i.e. produce ψ⁻¹ / ω⁻¹ -based twiddles for the inverse NTT). Only valid alongside `--compute-twiddles`. |

The script then indexes `twiddles[args.layer][args.position]` of the computed
grid — same indexing as the xlsx path.

#### Bounds and RTL parameters

| Flag | Type | Default | Description |
|---|---|---|---|
| `--aIn-bound` | str | **required** | aIn IntType bound, e.g. `s66` (signed 66-bit) or `u32` (unsigned 32-bit). The `s/u` prefix picks the IntType constructor; the integer is the bit-width. |
| `--bIn-bound` | str | **required** | bIn IntType bound. **Independent of `--aIn-bound`** — the two ports routinely have different widths in a real pipeline (e.g. layer 0 takes s66 / u96; downstream layers shrink). |
| `--pipeline-stages` | int | `1` | Compressor pipeline depth. Distributed across compression layers via `reg_flag_list_gen`. Set to `0` for purely combinational. |
| `--test-size` | int | `1000` | Random testvectors to emit and check. The testbench compares all of them. |
| `--seed` | int | (none) | Random seed for testvector generation. If unset, runs are nondeterministic. |
| `--visualization` | flag | off | Emit per-output bit-heap PNGs (matplotlib required). PNGs are auto-prefixed `aOut_*.png` / `bOut_*.png` to avoid collisions. Ignored when `--backend sim` (no bit-heap to draw). |
| `--no-testbench` | flag | off | Skip testbench + testvector generation. RTL only. Useful when you'll wire the wrapper into a larger DUT. |
| `--backend` | choice | `hw` | RTL flavor: `hw` (default; Versal compressor-tree from `versal_arith.rtl_gen`) or `sim` (behavioral `+/-` from `versal_arith.sim_rtl_gen`). Sim runs land in a parallel `<run>_sim/` directory with byte-identical testvectors but a much simpler SV body — used for fast functional simulation when synthesis-quality RTL is not needed. See `versal_arith/docs/USAGE.md §9`. |

When `--no-testbench` is **not** set, `golden_fn` is auto-built inside the
script from `propagateValue` with the spec's `aInBitWidth` / `bInBitWidth`
applied — so the goldens use the same hardware-register slicing as the RTL
accumulator (preserving the byte-identical mod-2^N truncation property).

#### Output location

| Flag | Default | Description |
|---|---|---|
| `--work-dir` | `work/` (relative to project root) | Root of the per-scenario tree. |

Run dir is `<work_dir>/<scenario>/butterfly_L<layer>_p<position>/` for the
default `--backend hw`, and `<work_dir>/<scenario>/butterfly_L<layer>_p<position>_sim/`
for `--backend sim`. The two run dirs can coexist for the same scenario.

#### Remote simulation

| Flag | Default | Description |
|---|---|---|
| `--remote-sim` | off | After local generation, chain to `run_remote_sim.py` to stage and simulate on the V80. |
| `--remote-server` | `$V80_SERVER` or `v80-server` | SSH alias of the V80 server (configure in `~/.ssh/config`; set `V80_SERVER` env var to skip the flag). |
| `--remote-root` | `$V80_REMOTE_ROOT` or `~/AMD_V80_dev` | Vivado project root on the server (set `V80_REMOTE_ROOT` env var to skip the flag). |

When `--remote-sim` is set the simulation log + Vivado build dir land in
`<run_dir>/sim_remote/`. The script's exit status reflects the verdict
(`0`=PASS, `1`=FAIL, `2`=tooling failure).

### 1c. Examples

```bash
# 1. Simplest — one GS butterfly with a 1-NAF twiddle, computed via Sage.
python scripts/build_butterfly.py \
    --scenario quick \
    --n 128 --butterfly-type GS \
    --layer 2 --position 5 \
    --compute-twiddles --primitive-root 17870292113338400769 \
    --aIn-bound s66 --bIn-bound s66 \
    --pipeline-stages 1 --test-size 1000 --seed 42
```

```bash
# 2. Asymmetric input widths (signed 66-bit aIn × unsigned 32-bit bIn) — the
# common shape for stages where one input has been bound-shrunk and the other
# is from a constant table. Auto-runs the V80 batch sim and reports the
# verdict.
python scripts/build_butterfly.py \
    --scenario hybrid \
    --n 128 --butterfly-type GS \
    --layer 4 --position 3 \
    --compute-twiddles --primitive-root 17870292113338400769 \
    --aIn-bound s66 --bIn-bound u32 \
    --pipeline-stages 1 --test-size 1000 --seed 17 \
    --remote-sim
```

```bash
# 3. Hand-picked twiddle (no xlsx, no Sage) — fast loop for a one-off
# regression test or a hardware-corner exploration.
python scripts/build_butterfly.py \
    --scenario hand_picked \
    --n 128 --butterfly-type CT \
    --layer 6 --position 1 \
    --twiddle-naf '+2^43 - 2^91' \
    --aIn-bound s66 --bIn-bound s66 \
    --pipeline-stages 1 --test-size 100 --seed 7
```

```bash
# 4. Inverse NTT butterfly — same shape as forward, but with --inverse so
# Sage builds psi^-1-based twiddles. Pipeline stages = 2.
python scripts/build_butterfly.py \
    --scenario intt_check \
    --n 128 --butterfly-type GS \
    --layer 1 --position 7 \
    --compute-twiddles --primitive-root 17870292113338400769 --inverse \
    --aIn-bound s66 --bIn-bound s66 \
    --pipeline-stages 2 --test-size 1000 --seed 99 \
    --remote-sim
```

```bash
# 5. RTL only, no testbench — for integration into a larger top-level DUT.
python scripts/build_butterfly.py \
    --scenario integration \
    --n 128 --butterfly-type GS \
    --layer 0 --position 0 \
    --twiddle-naf '1' \
    --aIn-bound s66 --bIn-bound s66 \
    --pipeline-stages 0 \
    --no-testbench
```

### 1d. Validation

`build_butterfly.py` runs a **local sanity check** (always on, unless you pass
`--no-testbench`): it reads back the first 8 lines of each testvector hex
file, decodes the inputs, re-runs `propagateValue`, and confirms that the
on-disk `aOut.txt` / `bOut.txt` hex bytes match `propagateValue mod 2^N`.

This catches twos-complement encoding bugs locally before burning a remote-sim
run. A failed sanity check exits the script with code 1 before any V80 work.

The test cases that have been validated end-to-end on real Vivado batch
simulation (V80, Versal LOOKAHEAD8 + Versal-LUT primitives, 1000 testvectors
each):

| Direction | Twiddle | Pipeline | Bounds | Result |
|---|---|---|---|---|
| NTT GS L2 p5 | 1-NAF `[(1, 6)]` | 1 | s66 / s66 | PASS 1000/1000 |
| NTT GS L0 p1 | 2-NAF `[(1, 43), (-1, 91)]` | 2 | s66 / s66 | PASS 1000/1000 |
| NTT CT L6 p1 | 2-NAF `[(1, 43), (-1, 91)]` | 1 | s66 / s66 | PASS 1000/1000 |
| NTT GS L4 p3 | 1-NAF `[(-1, 72)]` | 1 | s66 / u32 | PASS 1000/1000 |
| NTT CT L0 p0 | trivial `[(1, 0)]` | 1 | u64 / s66 | PASS 1000/1000 |
| INTT GS L1 p7 | 1-NAF `[(-1, 15)]` | 2 | s66 / s66 | PASS 1000/1000 |

---

## 2. `build_ntt.py` — full NTT/INTT pipeline RTL (with per-butterfly debug mode)

Generates a self-contained run directory for an entire fully-pipelined
Goldilocks NTT (or INTT) — every butterfly, the top wrapper that wires them
per the in-place memory layout, an end-to-end self-checking testbench with
natural-order packed-hex testvectors, aggregated XDCs, and a manifest.

In **per-butterfly debug mode** (`--debug-butterfly L P`) the same script
generates **only** that one butterfly with a full butterfly-level testbench
— bounds and twiddle inferred from the populated NTT instance, so the user
doesn't have to retype them. This is the recommended way to isolate a
failing butterfly inside a pipeline.

The data flow:

```
              twiddle source (xlsx / Sage compute)
                              |
                              v
   FullyPipelinedNTT / FullyPipelinedINTT (NTT_modeling)
        .setScheme(...)
        .getInputsNatural([bounds]) ; .compute()             (bounds path)
        .getInputsNatural([batches]) ; .compute()            (values path)
                              |
              +---------------+---------------+
              v                               v
   (full mode)                       (debug mode)
   inst.emitRtl(topName,             inst.butterflies[L][P].scheme.emitRtl(name,
       run_dir, ...)                     run_dir, ...)
              |                                 |
              v                                 v
   work/<scenario>/<TOP>/             work/<scenario>/butterflies/L<L>_p<P>/
     RTL_generated/                     RTL_generated/
     xdc_generated/                     xdc_generated/
     testvectors/                       testvectors/
     manifest.json                      spec.json
```

Goldens for the top testbench come directly from the populated instance:
the script's `populate_testvectors` helper samples `--test-size` random
natural-order x batches and runs `compute()` once with both bounds and
values loaded. Then `inst.emitRtl` reads `testVector` from each stage-0
input port and final-stage output port via `_extractGoldensNatural`,
permutes natural ↔ memory order, and feeds the goldens into `NTT_RTL_gen`.
The script no longer does golden plumbing itself.

For the per-butterfly debug mode, the target butterfly's bounds + twiddle
are pulled from the populated instance, copied into a fresh
`GoldilocksSlice64`, and emitted via `scheme.emitRtl(...)` — exactly the
same path `build_butterfly.py` uses.

### 2a. Generated layout — full NTT mode

For `--scenario foo --direction ntt --butterfly-type GS --n 128`:

```
work/foo/NTT_n128_GS/
├── RTL_generated/
│   ├── NTT_n128_GS.sv                         ← top wrapper
│   ├── NTT_n128_GS_tb.sv                      ← top self-checking TB
│   ├── NTT_n128_GS_btf_L0_p0.sv               ← per-butterfly DUT (×448 for n=128)
│   ├── NTT_n128_GS_btf_L0_p0_aOut_cmp.sv      ← per-butterfly aOut compressor
│   ├── NTT_n128_GS_btf_L0_p0_bOut_cmp.sv      ← per-butterfly bOut compressor
│   └── …
├── xdc_generated/
│   ├── NTT_n128_GS_btf_L0_p0_aOut_cmp.xdc     ← LUTNM placement constraints
│   └── …
├── testvectors/
│   ├── x_in.txt                               ← packed natural-order inputs (one cycle per line)
│   └── y_out.txt                              ← packed natural-order goldens
├── bitheap_visualization/                     (only when --visualization)
├── spec.json                                   ← serialized NTTOperatorSpec
└── manifest.json                               ← top_name, layer_latency[], total_latency, …
```

The top wrapper has ports `clk`, `x_in_<i>` (one per natural input,
uniform width = the `--input-bound` bit width), and `y_out_<i>` (one per
natural output, per-slot width from `outputBitWidthsNatural[i]`). The body
is purely structural — instantiate every butterfly module by name and wire
inputs/outputs via the spec's wiring tables.

The top testbench reads `x_in.txt` (`n × inputBitWidth`-bit packed per line,
natural-order MSB-first concatenation) and `y_out.txt` (per-slot widths
concatenated MSB-first). It drives one cycle per testvector, waits
`total_latency` cycles, then compares the entire packed `y_out` bus against
the golden — printing the same `SUCCESS!` / `PASS All <N>` / `FAILED:` /
`WRONG` markers that `run_remote_sim.py` greps for.

### 2b. Generated layout — per-butterfly debug mode

For the same `--scenario foo` plus `--debug-butterfly 3 0`:

```
work/foo/butterflies/L3_p0/
├── RTL_generated/
│   ├── Butterfly_n128_GS_L3_p0.sv             ← wrapper
│   ├── Butterfly_n128_GS_L3_p0_aOut_cmp.sv
│   ├── Butterfly_n128_GS_L3_p0_bOut_cmp.sv
│   └── Butterfly_n128_GS_L3_p0_tb.sv          ← self-checking butterfly TB
├── xdc_generated/
├── testvectors/
│   └── aIn.txt, bIn.txt, aOut.txt, bOut.txt
└── spec.json
```

This is **exactly** the layout `build_butterfly.py` produces for one
butterfly — the bounds and twiddle are extracted from the populated NTT
instance so the user doesn't have to specify `--aIn-bound`, `--bIn-bound`, or
`--twiddle-naf` manually.

### 2c. Argument reference

#### Identity

| Flag | Type | Required | Description |
|---|---|:---:|---|
| `--scenario` | str | **yes** | Subfolder name under `--work-dir`. |
| `--n` | int | no (default 128) | NTT size (power of 2). |
| `--direction` | choice | **yes** | `ntt` (forward) or `intt` (inverse). Picks `FullyPipelinedNTT` vs `FullyPipelinedINTT` and the matching `calculate*Twiddles`. |
| `--butterfly-type` | choice | **yes** | `CT` or `GS`. |
| `--input-bound` | str | **yes** | Single uniform bound for all natural-order x[i] (e.g. `s96`). The pipeline's full-input width equals this; per-port output widths vary and are derived per butterfly. |
| `--negacyclic` | flag | no | Negacyclic NTT (NWC). NWC pairing is forced: forward = CT, inverse = GS. |
| `--primitive-root` | int | (only for `--compute-twiddles`) | Base root of unity. For n=128: `17870292113338400769`. |

#### Twiddle source

| Flag | Description |
|---|---|
| (default) | Load from `--twiddles-xlsx` + `--twiddles-sheet`. Default sheet auto-selects: `NTT_TWIDDLES` for `--direction ntt`, `iNTT_TWIDDLES` for `--direction intt`. The repo's `twiddles.xlsx` ships an NTT_TWIDDLES sheet labeled GS and an iNTT_TWIDDLES sheet labeled CT, so xlsx works out-of-the-box for `ntt+GS` and `intt+CT`. The other two combinations require `--compute-twiddles`. |
| `--compute-twiddles --primitive-root <int>` | Compute the entire grid via Sage. Always uses NAF modulus lifting with `maxNumberOfTerms=3`. |

#### Pipeline / RTL parameters

| Flag | Default | Description |
|---|---|---|
| `--pipeline-stages` | `1` | Single int (broadcast to every layer) **or** comma list of length `log2(n)` for per-layer values, e.g. `1,2,2,1,1,1,1`. Each entry is the `pipeline_stages` forwarded to every butterfly in that layer. |
| `--test-size` | `1000` | Cycles in the testvector files (= number of NTT computations the testbench drives). |
| `--seed` | (none) | Random seed for natural-order x batch generation. |
| `--visualization` | off | Per-butterfly bit-heap PNGs (matplotlib required; large for 448 butterflies). Ignored when `--backend sim`. |
| `--no-testbench` | off | Skip TB + testvector emission (RTL only). |
| `--backend` | `hw` | RTL flavor: `hw` (Versal compressor-tree) or `sim` (behavioral `+/-` from `versal_arith.sim_rtl_gen` — much faster simulation, byte-identical testvectors). In sim mode every butterfly is concatenated into one `<TOP>_butterflies.sv`; no per-butterfly files, no XDC, no bit-heap artifacts. See `versal_arith/docs/USAGE.md §9`. |

#### Per-butterfly debug mode

| Flag | Description |
|---|---|
| `--debug-butterfly LAYER POSITION` | Switch from full-NTT mode to per-butterfly debug. The script still builds the populated NTT instance (so bounds + twiddle for the target butterfly come from there), then chains to the per-butterfly generator exactly like `build_butterfly.py` would. `--pipeline-stages` is interpreted per-layer; the value at index `LAYER` is what the butterfly receives. `--backend` is honored: `sim` lands at `butterflies/L<L>_p<P>_sim/`. |

#### Output location

| Flag | Default | Description |
|---|---|---|
| `--work-dir` | `work/` | Root of the per-scenario tree. Full-NTT hw runs land at `<work_dir>/<scenario>/<TOP>/`, sim runs at `<work_dir>/<scenario>/<TOP>_sim/`. Debug runs at `<work_dir>/<scenario>/butterflies/L<L>_p<P>/` (hw) or `<work_dir>/<scenario>/butterflies/L<L>_p<P>_sim/` (sim). |

#### Remote simulation

| Flag | Default | Description |
|---|---|---|
| `--remote-sim` | off | Chain to `run_remote_sim.py` after generation. |
| `--remote-server` | `$V80_SERVER` or `v80-server` | SSH alias of the V80 server (configure in `~/.ssh/config`; set `V80_SERVER` env var to skip the flag). |
| `--remote-root` | `$V80_REMOTE_ROOT` or `~/AMD_V80_dev` | Vivado project root on the server (set `V80_REMOTE_ROOT` env var to skip the flag). |

### 2d. Examples

```bash
# 1. NTT128 GS with default xlsx twiddles, signed-96 inputs, layer-uniform 1 stage,
#    1000 testvectors, with V80 remote sim. The most common shape.
python scripts/build_ntt.py \
    --scenario v80_ntt128_GS \
    --n 128 --direction ntt --butterfly-type GS \
    --input-bound s96 \
    --pipeline-stages 1 \
    --test-size 1000 --seed 0 \
    --remote-sim
```

```bash
# 2. NTT128 CT — the xlsx is GS-only for forward, so use --compute-twiddles.
python scripts/build_ntt.py \
    --scenario v80_ntt128_CT \
    --n 128 --direction ntt --butterfly-type CT \
    --input-bound s96 \
    --compute-twiddles --primitive-root 17870292113338400769 \
    --pipeline-stages 1 \
    --test-size 1000 --seed 0 \
    --remote-sim
```

```bash
# 3. Per-layer pipeline depth: layer 1 and 4 get 2 stages, the rest 1.
python scripts/build_ntt.py \
    --scenario per_layer \
    --n 128 --direction ntt --butterfly-type GS \
    --input-bound s96 \
    --pipeline-stages 1,2,1,1,2,1,1 \
    --test-size 1000 --seed 0 \
    --remote-sim
```

```bash
# 4. Per-butterfly debug: pick L=3 p=0 in the GS pipeline. The script
#    extracts that butterfly's bounds + twiddle from the populated NTT
#    instance and produces a stand-alone build_butterfly-style run dir.
python scripts/build_ntt.py \
    --scenario v80_ntt128_GS \
    --n 128 --direction ntt --butterfly-type GS \
    --input-bound s96 \
    --pipeline-stages 1 --test-size 1000 --seed 0 \
    --debug-butterfly 3 0 \
    --remote-sim
```

### 2e. Local sanity check

Always on (unless `--no-testbench`): the script reads back the first 8 lines
of `x_in.txt` and `y_out.txt`, decodes the natural-order slots, drives them
through `propagateValue` end-to-end via the same NTT instance, and confirms
each natural-output slot matches mod-2^slot_width. Catches packing /
encoding bugs locally before any remote-sim is launched. Mirrors the
analogous check in `build_butterfly.py`.

### 2f. Validation — V80 batch sim

| Pipeline | Topology | Input bound | Layer latency | Total latency | Result |
|---|---|---|---|---|---|
| `NTT_n128_GS`  | GS forward (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `NTT_n128_CT`  | CT forward (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `INTT_n128_GS` | GS inverse (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `INTT_n128_CT` | CT inverse (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `Butterfly_n128_GS_L3_p0` (debug mode) | GS forward, single butterfly | s66 / s66 | — | 1 | PASS 1000/1000 |

All four full-pipeline sweeps instantiate 448 butterfly modules each and
elaborate + simulate cleanly on Vivado xsim. End-to-end V80 simulation time
is roughly 28–30 minutes per direction (driven mostly by the per-cycle
per-vector $display volume).

---

## 3. `build_bank.py` — bank of constant multipliers

Generates the SV for **N parallel constant multipliers** sharing one input
register width but each with their own constant. Designed for the
negacyclic NTT pre-twist (`x[i] · ψ^i`) and post-twist stages — i.e. cases
where the same input fans out to many constant multipliers in parallel.
Per-stage butterfly twiddles do **not** belong here; those are baked into
individual butterfly modules by `build_butterfly.py`.

Internally calls `versal_arith/cli.py -operator cmultbank` via subprocess.

**Natural-order convention.** With `--sheet PRE_TWIST --column simple` for
n=128, `constants[i] = ψ^i mod q` (NAF-lifted), so the bank's i-th input
port `A_<i>` consumes natural-order `x[i]` and produces
`P_<i> = x[i] · ψ^i` — the standalone pre-twist for a negacyclic forward
NWC NTT. The CT pipeline downstream handles the bit-reversal in its own
memory layout; the bank itself sees natural-order inputs.

**Per-port output widths.** Each `P_<i>` of the wrapper is declared at
exactly its cmult's actual product width — no zero/sign extension to a
uniform max — and a sidecar `output_bounds.json` records the per-port
`IntType` bound for downstream chaining (load via
`NTT_modeling.IntType.loadBoundsJson`).

### 3a. Generated layout

For `--scenario foo`:

```
work/foo/
├── foo_constants.txt              ← snapshot of the constants fed to cli.py
└── cmultbank/                     ← versal_arith run output (per cli.py convention)
    ├── RTL_generated/
    │   ├── Cmult_<W>x<C0>.sv      ← one per constant
    │   ├── Cmult_<W>x<C0>_cmp.sv  ← compressor (only when max col height ≥ 3)
    │   ├── …
    │   ├── cmultbank.sv           ← top-level wrapper instantiating all N
    │   └── cmultbank_tb.sv        ← self-checking testbench
    ├── xdc_generated/             ← LUTNM placement constraints
    ├── testvectors/               ← hex testvectors + per-output goldens
    ├── bitheap_visualization/     ← (when -visualization True; default)
    └── output_bounds.json         ← per-port IntType bound for each P_<i>
```

### 3b. Argument reference

#### Output location

| Flag | Default | Description |
|---|---|---|
| `--scenario` | **required** | Subfolder under `--work-dir`. |
| `--work-dir` | `work/` | Root of the per-scenario tree. |

#### Constants source — pick one

`--sheet` and `--file` are mutually exclusive (argparse enforces).

| Flag | Description |
|---|---|
| `--sheet <name>` | xlsx sheet name. Supported: `PRE_TWIST` / `POST_TWIST` (the `twiddles.xlsx` layout — header row, raw mod-q residue in column A, already-NAF-lifted "Most simple bin rep" in column B) and `PRETWIST` / `POSTTWIST` (the `NewTwiddles.xlsx` layout — a single raw mod-q column A, header row auto-detected, **no** lifted column). (Per-stage butterfly twiddles aren't supported here — use `build_butterfly.py` for those.) |
| `--xlsx <path>` | Path to the workbook (default: `twiddles.xlsx`). Pass `NewTwiddles.xlsx` for the `PRETWIST` / `POSTTWIST` sheets. |
| `--column simple\|raw` | For `PRE_TWIST` / `POST_TWIST`: `simple` (default) reads column B (already-NAF-lifted "Most simple bin rep"); `raw` reads column A (original mod-q residue, pair with `--modulus q` to lift). `PRETWIST` / `POSTTWIST` have only a raw column, so they default to `raw` and reject `simple` — **always pair them with `--modulus 18446744069414584321`**, or the generator NAF-decomposes 64-bit residues verbatim (the script warns if you forget). |
| `--file <path>` | Plain integer-per-line file. Bypasses xlsx parsing entirely. |

#### Versal generator parameters (forwarded to `cli.py`)

| Flag | Default | Description |
|---|---|---|
| `--width-a <int>` | `24` | Input bit-width (shared by every multiplier in the bank). |
| `--pipeline-stages <int>` | `1` | Compressor pipeline depth. |
| `--signed-input` | off | Treat A as signed two's complement. |
| `--test-size <int>` | `1000` | Random testvectors to emit. |
| `--no-visualization` | off | Skip bit-heap PNGs (faster, no matplotlib needed). |
| `--dry-run` | off | Extract constants only; skip RTL generation. Useful to inspect what would be fed to `cli.py`. |

#### NAF modulus lifting (only when `--modulus` is set)

| Flag | Default | Description |
|---|---|---|
| `--modulus <int>` | (none) | If set, the RTL generator replaces each constant `c` with a sparser-NAF equivalent `c' ≡ c (mod q)`. Goldilocks q = `18446744069414584321`. Skip this if your constants are already lifted (e.g. you used `--column simple`). |
| `--lift-max-pow <int>` | `96` | Cap on NAF exponents in the lifted form. |
| `--lift-max-shift <int>` | `32` | Max `t` such that `q · 2^t` enters the search frontier. |
| `--lift-depth <int>` | `3` | Beam-search iterations. |
| `--lift-beam <int>` | `200` | Beam width. |

#### Remote simulation

| Flag | Default | Description |
|---|---|---|
| `--remote-sim` | off | Chain to `run_remote_sim.py` after generation. |
| `--remote-server` | `$V80_SERVER` or `v80-server` | SSH alias of the V80 server (configure in `~/.ssh/config`; set `V80_SERVER` env var to skip the flag). |
| `--remote-root` | `$V80_REMOTE_ROOT` or `~/AMD_V80_dev` | Vivado project root on the server (set `V80_REMOTE_ROOT` env var to skip the flag). |

### 3c. Examples

```bash
# 1. NTT pre-twist for n=128 — uses the already-lifted column B, no --modulus.
python scripts/build_bank.py \
    --scenario pre_twist_NTT128 \
    --sheet PRE_TWIST --column simple \
    --width-a 24 \
    --pipeline-stages 1
```

```bash
# 2. Plain-text constants file, no xlsx involvement.
python scripts/build_bank.py \
    --scenario custom \
    --file work/custom/my_constants.txt \
    --width-a 24
```

---

## 4. `run_remote_sim.py` — V80 Vivado batch simulation

Stages a generated run dir onto the V80 server and runs Vivado's batch
simulator (`xsim`) against it, then pulls the build dir back and prints a
PASS / FAIL verdict.

This script is normally invoked **automatically** via `--remote-sim` from
any of the build scripts (`build_butterfly.py`, `build_ntt.py`,
`build_bank.py`). You'd call it directly when:

- You generated a run without `--remote-sim` and want to simulate it now.
- You want to re-run a previously-generated case with a different remote
  server or remote root.
- You're debugging the staging / patching pipeline itself.

### 4a. Workflow

For each invocation:

1. **Validate** the local run dir; auto-detect the testbench top from
   `RTL_generated/<top>_tb.sv`.
2. **Push GPC primitives** to `<remote_root>/src/rtl_resources/` if missing
   (one-time per remote root).
3. **Wipe the slot**: clear `src/rtl/`, `src/rtl_tb/`, `testvectors/` on the
   server. (Skipped with `--no-prune-server`.)
4. **rsync `RTL_generated/*.sv`** (excluding `*_tb.sv`) into `src/rtl/`.
5. **Patch the testbench's `$readmemh` paths** from the local
   `../../../../../testvectors/` (depth-5) form to `../testvectors/` (depth-1
   from the server's `build_<top>_tb/` build dir). Push patched tb to
   `src/rtl_tb/`.
6. **rsync `testvectors/`** to `<remote_root>/testvectors/`.
7. **Launch sim.sh detached on the server**:
   `setsid nohup bash -c '... > log_file 2>&1; echo $? > exit_marker' &`.
   The launching SSH returns immediately, so the simulation cannot be killed
   by an idle-timed-out jump host or a stuck SSH stdout pipe — both of
   which were observed on long NTT128 runs (~30 minutes per direction).
8. **Poll** for the exit marker (`build_<top>_tb_sim.exit`) every 30 s using
   short, idle-timeout-resistant SSH calls. Each call carries SSH keepalive
   options (`ServerAliveInterval=30`, `ServerAliveCountMax=3`,
   `ConnectTimeout=30`).
9. **rsync the sim log** (`build_<top>_tb_sim.log`) back to
   `<pull-to>/sim_stdout.log` once the marker appears.
10. **Pull `build_<top>_tb/`** back into `<pull-to>/build_<top>_tb/`.
11. **Parse the log** for `PASS All <N>` / `SUCCESS!` (PASS) or
    `FAILED:` / repeated `WRONG` lines (FAIL). Print verdict.
12. **Optionally clean up** the remote `build_<top>_tb/` directory + log +
    exit marker (default).

### 4b. Argument reference

| Flag | Default | Description |
|---|---|---|
| `--run-dir` | **required** | Path to the local run dir (the directory **containing** `RTL_generated/` and `testvectors/`, e.g. `work/foo/butterfly_L2_p5`). |
| `--top` | (auto-detect) | Top module name. Auto-detected from `RTL_generated/<top>_tb.sv`. Pass explicitly if multiple `*_tb.sv` files exist. |
| `--server` | `$V80_SERVER` or `v80-server` | SSH alias of the V80 server. Configure in `~/.ssh/config`; set `V80_SERVER` env var to skip the flag. |
| `--remote-root` | `$V80_REMOTE_ROOT` or `~/AMD_V80_dev` | Vivado project root on the server (must contain `scripts/sim.sh` and `src/{rtl,rtl_tb,rtl_resources}/`); set `V80_REMOTE_ROOT` env var to skip the flag. |
| `--pull-to` | `<run_dir>/sim_remote/` | Local directory for the pulled-back artifacts. |
| `--keep-remote-build` | off | Don't `rm -rf build_<top>_tb` on the server after pulling. |
| `--no-prune-server` | off | Skip wiping `src/rtl/`, `src/rtl_tb/`, `testvectors/` before staging. Use to keep a previous run intact for diff-debugging. |

### 4c. Exit codes

| Code | Meaning |
|---|---|
| `0` | Sim passed (`SUCCESS!` + `PASS All <N>` markers in the log). |
| `1` | Sim failed (any `FAILED:` summary or `WRONG` lines). |
| `2` | Tooling failure (rsync error, ssh error, sim.sh non-zero exit, log parse couldn't decide). The pulled-back log is always available regardless. |

### 4d. Examples

```bash
# 1. Simulate an already-generated butterfly (most common direct use).
python scripts/run_remote_sim.py \
    --run-dir work/foo/butterfly_L2_p5
```

```bash
# 2. Simulate a cmultbank.
python scripts/run_remote_sim.py \
    --run-dir work/pre_twist_NTT128/cmultbank
```

```bash
# 3. Re-run on a different server, keep the build dir for inspection.
python scripts/run_remote_sim.py \
    --run-dir work/foo/butterfly_L2_p5 \
    --server other-v80 \
    --keep-remote-build
```

---

## 5. `run_remote_synth.py` — V80 Vivado out-of-context synthesis

Stages a generated run dir onto the V80 server, runs Vivado batch
**out-of-context (OOC) synthesis** on the top module, and pulls back a
small set of reports (`utilization.rpt`, `timing_summary.rpt`,
`timing_top10.rpt`) plus the synth log. Same stage / detached-launch /
poll-marker / small-rsync pattern as `run_remote_sim.py` — they share
`src/rtl/` on the server, so they must be run **sequentially**.

This script is normally invoked **automatically** via `--remote-synth`
from `build_butterfly.py` / `build_ntt.py`, or chained at the end of a
user-end harness like `runNTT128_GS_after_pretwist.py`. Direct
invocation:

```bash
python scripts/run_remote_synth.py \
    --run-dir work/ntt128_GS_after_pretwist/NTT_n128_GS_after_pretwist
```

### 5a. Workflow

For each invocation:

1. Validate run dir + auto-detect `top` from `RTL_generated/<top>_tb.sv`
   (strip `_tb`); pass `--top` to override.
2. Push GPC primitives if missing on the server (`ensure_resources`,
   shared with `run_remote_sim.py`).
3. Wipe `src/rtl/` (synth shares this slot with sim — sequential discipline).
4. rsync `RTL_generated/*.sv --exclude=*_tb.sv` to `src/rtl/`.
5. Generate a per-run synth tcl on local: globs `src/rtl/` +
   explicitly lists the 9 GPC primitives from `src/rtl_resources/`,
   applies `tcl/const.tcl` (the canonical 5 ns clock from the server
   side), runs `synth_design -top <top> -part <part> -mode out_of_context
   -global_retiming off`, writes `<top>_synth.dcp` +
   `utilization_synth.rpt` (pre-opt baseline), then `opt_design` (logic
   optimization — constant propagation, dead-code removal, register
   merging, LUT combining), writes `<top>_opt.dcp` + `utilization.rpt`
   + `timing_summary.rpt` + `timing_top10.rpt` (post-opt — closer to
   what shows up after place-and-route). Push via SSH stdin to
   `<remote_root>/build_<top>_ooc.tcl`.
6. **Launch detached**:
   `setsid nohup bash -c 'cd remote_root && source ./source && vivado
   -mode batch -source build_<top>_ooc.tcl > log; echo $? > exit' &`.
   The launching SSH returns within seconds.
7. **Poll** the exit-marker every 30 s using short, idle-timeout-resistant
   SSH calls. Versal OOC synth on Vivado 2025.2 takes 5–60 min depending
   on design size (e.g., a 448-butterfly NTT128 pipeline ≳ 30 min).
8. rsync the four small reports (`utilization_synth.rpt`,
   `utilization.rpt`, `timing_summary.rpt`, `timing_top10.rpt`) + the
   Vivado log back into `<pull-to>/`. Skip the multi-MB DCPs by default;
   opt in via `--pull-dcp` to get both `<top>_synth.dcp` (pre-opt) and
   `<top>_opt.dcp` (post-opt).
9. Parse `utilization.rpt` / `timing_summary.rpt` for a one-line summary
   (`LUTs=N1 FFs=N2 WNS=Xns TNS=Yns`); print and exit.
10. Optionally clean up the remote `build_<top>_ooc/` directory + the
    pushed tcl + log + marker (default).

### 5b. Argument reference

| Flag | Default | Description |
|---|---|---|
| `--run-dir` | **required** | Path to the local run dir (the dir **containing** `RTL_generated/`). |
| `--top` | (auto-detect) | Top module to synthesize. Auto-detected from `RTL_generated/<top>_tb.sv`. |
| `--part` | `xcv80-lsva4737-2MHP-e-S` | Versal part. Default targets the AMD Alveo V80 board (server-side `Makefile` typically defines `PART_NAME = xcv80-lsva4737-2MHP-e-S`). The paper documents `xcvc1902-vsva2197-2MP-e-S` (a different Versal dev part); override `--part` if your license covers that instead. |
| `--server` | `$V80_SERVER` or `v80-server` | SSH alias of the V80 server (configure in `~/.ssh/config`; set `V80_SERVER` env var to skip the flag). |
| `--remote-root` | `$V80_REMOTE_ROOT` or `~/AMD_V80_dev` | Vivado project root on the server (set `V80_REMOTE_ROOT` env var to skip the flag). |
| `--pull-to` | `<run_dir>/synth_remote/` | Local dir for pulled-back reports. |
| `--pull-dcp` | off | rsync the multi-MB `<top>_synth.dcp` checkpoint back. Default off. |
| `--keep-remote-build` | off | Don't `rm -rf build_<top>_ooc` on the server after pulling. |
| `--no-prune-server` | off | Skip wiping `src/rtl/` before staging. |

No `--clock-period`: the clock comes from the server's
`tcl/const.tcl` (`create_clock -period 5 -name clk_main [get_ports clk]`).
Editing it is a server-side admin task. The `xdc_generated/` LUTNM
constraints from the bank/butterfly generators are **not applied** for
OOC synth (impl-only).

### 5c. Exit codes

| Code | Meaning |
|---|---|
| `0` | Synth completed; reports written; one-line summary printed. |
| `1` | `synth_design` failed (Vivado returned non-zero). The pulled `synth_stdout.log` carries the diagnostic. |
| `2` | Tooling failure (rsync error, ssh error, log parse couldn't decide). |

### 5d. Examples

```bash
# 1. OOC synth of a full NTT128 pipeline (~30 min on Versal).
python scripts/run_remote_synth.py \
    --run-dir work/ntt128_GS_after_pretwist/NTT_n128_GS_after_pretwist
```

```bash
# 2. Single butterfly debug-run synth.
python scripts/run_remote_synth.py \
    --run-dir work/foo/butterfly_L2_p5
```

```bash
# 3. Pull the DCP back too (e.g., to open in Vivado GUI for waveform / floorplan).
python scripts/run_remote_synth.py \
    --run-dir work/pre_twist_NTT128/cmultbank \
    --pull-dcp
```

### 5e. License prerequisite

The default `--part xcv80-lsva4737-2MHP-e-S` matches a typical AMD Alveo
V80 deployment's Makefile (`PART_NAME = xcv80-lsva4737-2MHP-e-S`). If a
different part is requested via `--part`, the server-side Vivado must
hold a license for that device or `synth_design` fails with
"A valid license was not found for feature 'Synthesis'". The script
exits `1` with the diagnostic in `synth_remote/synth_stdout.log`. xsim
sim flows don't need a Synthesis license, so `run_remote_sim.py` works
regardless of synth licensing.

---

## 6. Common workflows

### 6a. End-to-end: generate one butterfly + simulate

```bash
python scripts/build_butterfly.py \
    --scenario regression \
    --n 128 --butterfly-type GS \
    --layer 2 --position 5 \
    --compute-twiddles --primitive-root 17870292113338400769 \
    --aIn-bound s66 --bIn-bound s66 \
    --pipeline-stages 1 --test-size 1000 --seed 42 \
    --remote-sim
```

End state: `work/regression/butterfly_L2_p5/sim_remote/sim_stdout.log` should
contain `PASS All 1000 Testvectors!`. Exit code 0 on success.

### 6b. End-to-end: generate full NTT pipeline + simulate

```bash
python scripts/build_ntt.py \
    --scenario regression \
    --n 128 --direction ntt --butterfly-type GS \
    --input-bound s96 \
    --pipeline-stages 1 --test-size 1000 --seed 42 \
    --remote-sim
```

End state: `work/regression/NTT_n128_GS/sim_remote/sim_stdout.log` should
contain `PASS All 1000 Testvectors!`. Exit code 0 on success. This produces
448 butterfly modules + 1 top wrapper + 1 top TB and runs them as one DUT
on V80 — total elapsed time ~28-30 minutes. For NTT128 CT, INTT128 GS, or
INTT128 CT, swap the relevant flags (and add `--compute-twiddles
--primitive-root 17870292113338400769` for the CT-forward / GS-inverse
combinations, since the bundled `twiddles.xlsx` only has GS-forward and
CT-inverse pre-baked).

### 6c. Per-butterfly debug from inside an NTT pipeline

When the full pipeline reports a `WRONG` testvector and you want to isolate
which butterfly is to blame, generate just that one butterfly with its own
testbench using `--debug-butterfly`:

```bash
python scripts/build_ntt.py \
    --scenario regression \
    --n 128 --direction ntt --butterfly-type GS \
    --input-bound s96 \
    --pipeline-stages 1 --test-size 1000 --seed 0 \
    --debug-butterfly 3 0 \
    --remote-sim
```

The script reads `inst.butterflies[3][0].inputPortA.bound` /
`.inputPortB.bound` / `.twiddle` from the populated NTT instance — so you
don't have to hand-derive bounds for layer-3 butterflies. Output lands at
`work/regression/butterflies/L3_p0/`, identical in shape to a
`build_butterfly.py` run.

### 6d. Sweep many butterflies in a scenario

For e.g. all 32 distinct twiddles in layer 2 of a GS n=128 NTT:

```bash
for p in $(seq 0 63); do
    python scripts/build_butterfly.py \
        --scenario sweep_L2 \
        --n 128 --butterfly-type GS \
        --layer 2 --position $p \
        --compute-twiddles --primitive-root 17870292113338400769 \
        --aIn-bound s66 --bIn-bound s66 \
        --pipeline-stages 1 --test-size 100 --seed $p \
        --remote-sim || echo "Position $p FAILED"
done
```

(For real coverage you'd batch the local generation first and only `--remote-sim`
afterward in a loop, since each `--remote-sim` wipes the shared V80 slot
sequentially. Run remote sims one at a time.)

### 6e. Local-only iteration on the bit-heap

When iterating on the bit-heap construction (in
`versal_arith/rtl_gen/butterfly.py`), generate without `--remote-sim`. The
**local sanity check** (built into `build_butterfly.py`) reads back the hex
testvectors and confirms they match `propagateValue mod 2^N` byte-for-byte —
which is a strong correctness signal even without Vivado in the loop. Burning
the V80 slot is only needed when the bit-heap math has actually changed.

### 6f. Debugging a failed remote sim

When `run_remote_sim.py` reports `FAIL`:

1. Open `<run_dir>/sim_remote/sim_stdout.log` — it has the `Testvector-<n>
   WRONG` lines with `module output` vs `reference output` per offending
   vector.
2. Check the testbench top for which output (aOut or bOut) failed — the testbench
   prints both deltas separately when both differ.
3. Check `<run_dir>/spec.json` for the operator interface — the term list under
   `aOutTerms` / `bOutTerms` shows which slice contributed to which column.
4. The pulled-back `<run_dir>/sim_remote/build_<top>_tb/` Vivado build dir
   has the full waveform / xsim state if you need to dig deeper.

---

## 7. Environment and prerequisites

### Local (everything)

```bash
conda create -n ntt-sage -c conda-forge sage python=3.11
conda activate ntt-sage
pip install openpyxl matplotlib
```

- **Sage**: required for `--compute-twiddles` and for any twiddle math in
  `NTT_modeling.NTT`.
- **openpyxl**: required for any xlsx-based workflow.
- **matplotlib**: required for `--visualization` (the bit-heap PNGs).

### Remote V80 server

`~/.ssh/config` should define the alias used by `--remote-server`. Set the
default once via the `V80_SERVER` environment variable (or pass `--remote-server`
on every call); the bundled fallback `v80-server` is just a generic placeholder.
The remote root — set via `V80_REMOTE_ROOT` or `--remote-root` (default `~/AMD_V80_dev`) —
must contain:

- `scripts/sim.sh` — the Vivado batch-sim entry point (sources the env, runs
  `xsim`).
- `source` — the env-source file `sim.sh` consumes.
- `src/{rtl,rtl_tb,rtl_resources}/` — the staging directories
  `run_remote_sim.py` writes into.
- `testvectors/` — populated per-run by the script.

The first invocation of `run_remote_sim.py` against any remote root will
push the GPC primitives from `versal_arith/rtl/` into
`<remote_root>/src/rtl_resources/`. Subsequent runs reuse them.

---

## 8. Pitfalls and gotchas

- **Always run from the project root.** `NTT_modeling/` uses relative imports
  (`from .Port import ...`) which require the parent directory on `sys.path`;
  every script in this directory inserts `PROJECT_ROOT` automatically, but
  that only works when the cwd contains `NTT_modeling/` and `versal_arith/`.

- **Asymmetric input bounds are per-butterfly only.** On
  `build_butterfly.py`, `--aIn-bound` and `--bIn-bound` must both be passed
  (no shared default). On `build_ntt.py` there is just one `--input-bound`
  applied to every natural-order x[i]; the per-butterfly aIn/bIn bounds are
  derived inside the pipeline via `propagateBound`, and the spec records
  per-port output widths separately so the top wrapper's y_out ports come out
  with their correct individual widths.

- **The wrapper SV doesn't `include` the GPC primitive modules.** Add
  `versal_arith/rtl/*.sv` (the `c3_2`, `c6_3`, `c15_3`, `c223_4`, `c9_41`,
  `c39_231`, `c413_341`, `c517_451`, `LFSR` modules) as design sources in
  Vivado. `run_remote_sim.py` handles this automatically for batch sim.

- **Pre-baked twiddles only cover GS-forward and CT-inverse.** The bundled
  `twiddles.xlsx` has `NTT_TWIDDLES` for GS forward (default for `--direction
  ntt --butterfly-type GS`) and `iNTT_TWIDDLES` for CT inverse (default for
  `--direction intt --butterfly-type CT`). The other two combinations
  require `--compute-twiddles --primitive-root <int>`.

- **Per-layer pipeline-stages parsing.** `build_ntt.py --pipeline-stages` is
  either a single int (broadcast to every layer) or a comma list of length
  exactly `log2(n)`. Mismatched lengths error out cleanly. Within a layer,
  every butterfly receives the same `pipeline_stages` value — the wrapper
  inserts balancing shift registers automatically when actual latencies
  diverge.

- **Sequential remote sims only.** `run_remote_sim.py` wipes the shared V80
  slot at the start of each run. Don't fire two in parallel against the same
  remote root — you'll get a clobbered build.

- **Long sims survive SSH disconnects.** `run_remote_sim.py` launches
  `sim.sh` detached on the server (`setsid nohup bash -c '... &'`) and polls
  for an exit-marker file. The launching SSH returns within seconds; idle
  timeouts on the SSH-jump host can no longer kill a 30-minute xsim. If you
  Ctrl-C the script, the server-side sim keeps running — re-launch
  `run_remote_sim.py` against the same `--run-dir` to pick up after it
  finishes.

- **Verilator can't lint the compressors locally.** The compressor SV
  instantiates `LOOKAHEAD8`, a Versal hardware primitive that lives only in
  Vivado's library. Verilator-lint the wrapper alone (with the compressors
  stubbed) for syntax checking; rely on Vivado batch sim for full correctness.
