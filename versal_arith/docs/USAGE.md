# versal_arith — Usage Guide

Automated RTL generator for Versal-fabric compressor trees and LUT-based integer multipliers, plus user-added constant-multiplier and constant-multiplier-bank operators. Produces synthesizable SystemVerilog targeting the Versal LUT (dual 5-LUT mode with `O5_1` / `O5_2` outputs and the LUT-cascade path) and the LOOKAHEAD8 carry hardware, plus matching XDC constraints, testbenches, and bit-heap visualization.

The compressor and Booth-multiplier portions of this generator implement the architecture from:

> Z. Miao, X. Pottier, J. Bertels, W. Legiest, I. Verbauwhede. *Area-Efficient LUT-Based Multipliers for AMD Versal FPGAs.* IACR ePrint 2026/344. <https://eprint.iacr.org/2026/344>

This document is the **practical guide**: install, CLI reference for all four operators, generated-output layout, simulation/synthesis integration, and common gotchas. For the bit-heap math, GPC catalogue, the proposed compression heuristic, the proposed two-layer quaternary adder, and the dual-5-LUT Booth partial-product mapping, see `THEORY.md`.

---

## 1. Setup

```bash
pip install matplotlib       # only required if -visualization is True (default)
```

That is the entire dependency. Everything else is Python stdlib. Vivado is needed downstream for synthesis but not for generation.

The generator is run **from inside `versal_arith/`** (the modules use unqualified imports such as `from bitheap import ...`):

```bash
cd versal_arith
python cli.py -operator <op> [args...]
```

Project layout after a generation run:

```
versal_arith/
├── cli.py
├── bit.py / bitheap.py / counter.py / heuristic.py / lut_init.py / power_writer.py
├── rtl_gen/                         # RTL generation sub-package
├── sim_rtl_gen/                     # behavioral simulation-only backend (§9)
├── rtl/                             # GPC primitive .sv modules — add ALL to Vivado
├── ARITH2026_Evaluation_Examples/   # checked-in pre-generated runs from the ARITH 2026 paper (§14)
└── versal_arith_generated/          # default output dir
    └── <run_name>/                  # one subdirectory per generation run
        ├── RTL_generated/           # *.sv (DUT) and *_tb.sv (testbench)
        ├── xdc_generated/           # *.xdc placement constraints
        ├── testvectors/             # input/output text vectors for $readmemh
        └── bitheap_visualization/   # PNG of each compression stage (if enabled)
```

The output directory can be overridden with `-output_dir`. The `clean` operator wipes it.

> **Looking for ready-made RTL to read or simulate without generating anything?** `versal_arith/ARITH2026_Evaluation_Examples/` ships pre-generated runs for every compressor-tree and Booth-multiplier example reported in the ARITH 2026 paper (single/double-column compressors at 128/256/512 bits, the `Mult16_*` partial-product heaps, and `Bmult6x6 … Bmult32x32`). See §14 for the full inventory and naming conventions.

---

## 2. The four CLI operators (+ two programmatic generators)

Pick one with `-operator`. Each operator has a fixed set of arguments; arguments for other operators are ignored.

| `-operator` | Generates | In paper? | Section |
|-------------|-----------|:---------:|---------|
| `cmp`       | Compressor tree from a column-height descriptor | ✓ | §3 |
| `bmult`     | Signed radix-4 Booth tree multiplier (≥6×6) | ✓ | §4 |
| `cmult`     | `unsigned/signed A × constant C` (no DSP) | extension | §5 |
| `cmultbank` | Bank of N parallel constant multipliers | extension | §6 |
| `clean`     | Delete the output directory | — | — |

Two additional generators do **not** have CLI hooks because they consume
Python dataclasses (and, for testbench generation, Python callables or
precomputed Python testvector batches) from the caller:

- **Butterfly RTL generator** — `rtl_gen.butterfly.Butterfly_RTL_gen`,
  consuming a `ButterflyOperatorSpec`. Documented in §7. End-to-end driver:
  `scripts/build_butterfly.py`.
- **Pipeline RTL generator** — `rtl_gen.ntt.NTT_RTL_gen`, consuming an
  `NTTOperatorSpec` (which itself bundles every butterfly's
  `ButterflyOperatorSpec` plus precomputed wiring tables). Documented in §8.
  End-to-end driver: `scripts/build_ntt.py`. Internally invokes
  `Butterfly_RTL_gen` per butterfly.

See [`../../scripts/README.md`](../../scripts/README.md) for both CLI wrappers.

Common arguments shared by all four generation operators:

| Argument | Type | Description | Default |
|----------|------|-------------|---------|
| `-pipeline_stages` | int | Number of pipeline stages; `0` = pure combinational | `1` |
| `-gen_testbench`   | bool | Emit testbench + test vectors | `True` |
| `-test_size`       | int | Number of random test vectors | `1000` |
| `-visualization`   | bool | Save per-stage compression PNGs | `True` |
| `-output_dir`      | str | Root output directory | `versal_arith_generated` |

---

## 3. `cmp` — compressor tree

Reduces an arbitrary bit heap (one column-height per line) to a single binary number, using the Versal-tailored GPC catalogue from the paper, the proposed area-and-delay heuristic, and the proposed two-layer-row-counter quaternary terminal adder.

```bash
python cli.py \
  -operator cmp \
  -txt_file_name bitheap.txt \
  -sv_file_name my_compressor \
  -pipeline_stages 1 \
  -gen_testbench True
```

| Argument | Type | Description | Default |
|----------|------|-------------|---------|
| `-txt_file_name`    | str | Path to bit-heap descriptor file | `bitheap.txt` |
| `-sv_file_name`     | str | Output `.sv` filename (without extension) | `bitheap_cmp` |
| `-cmp_module_name`  | str | SystemVerilog module name | `bitheap_cmp` |
| `-tb_out_width`     | int | Output width tested in the testbench | `44` |

**Bit-heap input format** (`bitheap.txt`): one non-negative integer per line, giving the number of bits in each column starting at LSB (rank 0). Blank lines are ignored.

```
2    # column 0 (LSB): 2 bits
1    # column 1: 1 bit
3    # column 2: 3 bits
```

The output module looks like:

```systemverilog
module bitheap_cmp (
    input  logic       clk,
    input  logic [1:0] in_col0,
    input  logic       in_col1,
    input  logic [2:0] in_col2,
    output logic [3:0] comp_out
);
```

**Generated files** under `<output_dir>/<sv_file_name>/`:

| Path | What it is |
|------|------------|
| `RTL_generated/<sv_file_name>.sv` | DUT — Versal-LUT + LOOKAHEAD8 instantiations through the GPC primitives in `rtl/` |
| `RTL_generated/<sv_file_name>_tb.sv` | Self-checking testbench |
| `xdc_generated/<sv_file_name>.xdc` | Placement constraints (LUTNM grouping) |
| `testvectors/in_col*.txt`, `comp_out.txt` | Random inputs and reference outputs (hex) |
| `bitheap_visualization/*.png` | Compression-stage scatter plots |

---

## 4. `bmult` — signed Booth tree multiplier

Generates a signed radix-4 modified-Booth multiplier. Both operands are treated as two's complement; minimum size is 6×6. Partial-product generation uses the dual-5-LUT Booth mapping from the paper (Table III) — **one Versal LUT generates two adjacent partial-product bits**, giving an asymptotic cost of ~n²/4 LUTs for an n-bit multiplication.

```bash
python cli.py \
  -operator bmult \
  -width_a 16 \
  -width_b 16 \
  -pipeline_stages 2
```

| Argument | Type | Description | Default |
|----------|------|-------------|---------|
| `-width_a` | int | Bit-width of operand A | `8` |
| `-width_b` | int | Bit-width of operand B | `8` |

The generator produces three SystemVerilog modules:

| Module | Role |
|--------|------|
| `Bmult{A}x{B}_bitheap_gen` | Modified Booth recoding → partial-product bit heap (LUT5 / LUT6_2) |
| `Bmult{A}x{B}_bitheap_cmp` | GPC compressor tree summing the partial products |
| `Bmult{A}x{B}` | Top-level wrapper wiring `gen → cmp` |

Internally the generator picks whichever operand is wider (after rounding up to even) as the recoded operand `OPB`, sign-extends to even bit-width, then calls the same compressor-tree pipeline as the `cmp` operator. Pipeline stages are distributed across `gen → cmp` and the compressor's internal layers. Sign extension across rows uses the Baugh-Wooley simplification (paper Fig. 5).

---

## 5. `cmult` — constant multiplier *(extension, not in the paper)*

Computes `A × C` where `A` is variable and `C` is a compile-time constant, using only shifts, adds, and a compressor tree if needed. **No DSP blocks are inferred.**

The constant `C` is decomposed into Non-Adjacent Form (NAF), giving a list of signed powers of 2. From these, a partial-product bit heap is assembled (with Baugh-Wooley sign-extension constants if `-signed_input True` or `C < 0`). The strategy is then chosen by the heap's **maximum column height**:

| Max column height | Strategy | Typical example |
|-------------------|----------|-----------------|
| 1 | Pure shift (wiring only) | `A * 8 = A << 3` (1 NAF term, unsigned A) |
| 2 | Verilog `+` / `-` two-operand adder | `A * 7 = (A << 3) - A` (2 NAF terms, unsigned A) |
| ≥ 3 | Bit-heap compressor tree | most twiddles; or any 2-term constant with `-signed_input` (sign-extension lifts column heights) |

NAF term count and column height usually agree, but signed inputs and negative constants add `1'b1` correction bits and inverted-sign-bit bits at boundary columns, which can push a "2-term" constant up into the compressor strategy. See `THEORY.md` §5 for the Baugh-Wooley derivation.

**Specify the constant by integer:**

```bash
python cli.py -operator cmult -width_a 24 -constant 12345
```

**Specify by signed powers of 2:**

```bash
python cli.py -operator cmult -width_a 16 -powers "10,5,-3"
# C = +2^10 + 2^5 - 2^3 = 1024 + 32 - 8 = 1048
```

Positive exponent → add; negative exponent → subtract.

**With modular reduction (twiddle factors):**

```bash
python cli.py \
  -operator cmult \
  -width_a 24 \
  -constant 13797081185216407910 \
  -modulus 18446744069414584321
```

This searches for `C' ≡ C (mod q)` with the fewest NAF terms — a 21-term constant typically drops to 2–4 terms when modular freedom is allowed.

| Argument | Type | Description | Default |
|----------|------|-------------|---------|
| `-width_a`        | int | Bit-width of input A | `8` |
| `-constant`       | int | Constant value (decomposed via NAF) | None |
| `-powers`         | str | Signed power-of-2 exponents, e.g. `"10,5,-3"` | None |
| `-modulus`        | int | Optional modulus q for sparser representation | None |
| `-signed_input`   | bool | Treat A as signed two's complement | `False` |

Either `-constant` or `-powers` must be given. With `-signed_input True`, the bit-heap construction uses the Baugh-Wooley sign-extension trick (replace replicated sign-bit copies with `~A[W-1] +` correction constants) so the heap stays minimal — see `THEORY.md` §5.

**Generated files** under `<output_dir>/Cmult_{W}x{C}/`:

| File | When |
|------|------|
| `Cmult_{W}x{C}.sv` | Always — top-level wrapper |
| `Cmult_{W}x{C}_cmp.sv` + `.xdc` | Only when max column height ≥ 3 (compressor path) |
| `Cmult_{W}x{C}_tb.sv` + `testvectors/` | If `-gen_testbench True` |

---

## 6. `cmultbank` — bank of constant multipliers *(extension, not in the paper)*

Reads a list of constants from a text file (one per line) and generates one constant multiplier per line, plus a top-level wrapper that runs them all in parallel with **uniform pipeline latency**. Typical use case is the negacyclic NTT pre-twist or post-twist stage (`x[i] · ψ^i`), but the operator is generic — any parallel constant-multiply array.

```bash
python cli.py \
  -operator cmultbank \
  -txt_file_name constants.txt \
  -width_a 24 \
  -pipeline_stages 1
```

With NAF modulus lifting (constants are full-width mod-q residues):

```bash
python cli.py \
  -operator cmultbank \
  -txt_file_name constants_raw.txt \
  -width_a 24 \
  -modulus 18446744069414584321
```

| Argument | Type | Description | Default |
|----------|------|-------------|---------|
| `-txt_file_name`  | str  | One integer constant per line | `bitheap.txt` |
| `-width_a`        | int  | Input bit-width (shared by all multipliers) | `8` |
| `-signed_input`   | bool | Treat all inputs as signed | `False` |
| `-modulus`        | int  | If set, lift each constant to a sparser-NAF equivalent mod q before generation. Omit if your constants are already lifted. | `None` |
| `-lift_max_pow`   | int  | NAF exponent ceiling in the lifted form (only when `-modulus` is set) | `96` |
| `-lift_max_shift` | int  | Max `t` such that `q · 2^t` enters the search frontier (only with `-modulus`) | `32` |
| `-lift_depth`     | int  | Beam-search iterations (only with `-modulus`) | `3` |
| `-lift_beam`      | int  | Beam width (only with `-modulus`) | `200` |

The wrapper module is named `cmultbank` and exposes `clk`, `A_0..A_{N-1}`, and `P_0..P_{N-1}`. Each `A_<i>` is `width_a` bits wide; each `P_<i>` is **per-port** at exactly its cmult's actual product width (`bit_length((2^width_a - 1) · |C_i|)`, +1 if signed) — no zero / sign extension to a uniform max. Multipliers with shorter compressor latency receive automatically inserted balancing registers (sized at the cmult's own width) so every output has identical pipeline latency.

**Natural-order convention** (driven by `scripts/build_bank.py --sheet PRE_TWIST` for n=128 forward NWC): the i-th input/output pair `A_<i>` / `P_<i>` corresponds to natural-order index `i`. With `--sheet PRE_TWIST --column simple`, `constants[i] = ψ^i mod q` (NAF-lifted), so `P_<i> = x[i] · ψ^i` — the standalone pre-twist for a negacyclic forward NTT. The CT pipeline downstream consumes these `P_<i>` values via its own bit-reversed memory layout; the bit-reversal is *not* part of the bank.

**Sidecar `output_bounds.json`.** Alongside the RTL, `Cmultbank_RTL_gen` writes a JSON list with one entry per port: `{idx, constant, bitWidth, isSigned, minValue, maxValue}`. The four numeric fields together specify each `P_<i>`'s exact `IntType` bound. Downstream NTT generation can plug the bank's outputs straight into a pipeline by loading this file via `operator_modeling.core.IntType.loadBoundsJson(path)` → `list[IntType]` and feeding it to `inst.getInputsNatural([bounds])`.

The console log gives a summary:

```
Cmult bank: 128 constant multipliers, 24-bit unsigned input
  Modulus lifting against q = 18446744069414584321
    lift_max_pow=96, lift_max_shift=32, lift_depth=3, lift_beam=200
  Max NAF terms after lifting: 3
  Output width: 89 bits (signed)
  Generated 0/128: Cmult_24x1 (1 NAF terms, 0 pipe stages)
  Generated 16/128: Cmult_24x9223372032559808513 (3 NAF terms, 1 pipe stages)
  ...
  Max compressor depth: 1 cycle(s)
  Uniform pipeline latency: 1 cycle(s)
```

---

## 7. `Butterfly_RTL_gen` — Goldilocks-NTT butterfly *(programmatic, no CLI)*

The butterfly RTL generator is the only generator in this library that
**does not** have a CLI hook in `cli.py`. Reason: it consumes a Python
`ButterflyOperatorSpec` dataclass produced by
`operator_modeling.ntt.ButterflyScheme.GoldilocksSlice64.getOperatorInterface(name)`, and accepts a
Python callable (`golden_fn`) for testbench golden generation. Both inputs
cross the subproject seam in a way that's awkward to round-trip through
argparse.

The end-to-end CLI driver lives at the project root:
`scripts/build_butterfly.py`. See [`../../scripts/README.md §1`](../../scripts/README.md)
for full argument documentation. This section covers the **programmatic API**
inside `versal_arith` itself, for users who want to construct specs by hand.

### 7a. The spec contract

Defined in `versal_arith/butterfly_spec.py` (top-level, NOT inside `rtl_gen/`,
so importing the spec doesn't pull in the rtl_gen `__init__.py` chain):

```python
from butterfly_spec import SliceTerm, ButterflyOperatorSpec

@dataclass(frozen=True)
class SliceTerm:
    source: str          # 'aIn' | 'bIn' | 'const'
    inputShift: int      # left-shift applied to the source before slicing
    sliceStart: int      # inclusive bit position in the shifted source
    sliceEnd: int        # inclusive
    isSigned: bool       # True iff slice covers full bitWidth (3rd branch of IntType.slice)
    limbShift: int       # 0 or 32 (limbs64 limb-factor shift)
    sign: int            # +1 or -1 — outer combined sign
    constValue: int      # only meaningful when source == 'const'
    # to_dict() / from_dict() round-trip via JSON for debugging.

@dataclass(frozen=True)
class ButterflyOperatorSpec:
    name: str                       # SV module name, e.g. 'Butterfly_n128_GS_L2_p5'
    butterflyType: str              # 'CT' | 'GS'
    q: int                          # Goldilocks prime
    aInBitWidth: int                # } per-input width, signedness — INDEPENDENT
    aInIsSigned: bool               # } between aIn and bIn (e.g. s66 / u32)
    bInBitWidth: int                # }
    bInIsSigned: bool               # }
    aOutBitWidth: int               # } per-output width, signedness — derived
    aOutIsSigned: bool              # } from propagateBound
    bOutBitWidth: int               # }
    bOutIsSigned: bool              # }
    liftedTwiddleNaf: list[tuple[int, int]]  # [(sign, exponent), ...] ≤ 3 terms
    aOutTerms: list[SliceTerm]      # bit-level provenance for aOut bit-heap
    bOutTerms: list[SliceTerm]      # bit-level provenance for bOut bit-heap
    # to_dict() / from_dict() round-trip via JSON.
```

The spec is the single source of truth for the wrapper module's port widths,
the bit-heap construction in `rtl_gen.butterfly`, and the testbench's
input/output decoding.

### 7b. Public API

```python
def Butterfly_RTL_gen(
    spec: ButterflyOperatorSpec,
    pipeline_stages: int = 1,
    gen_testbench: bool = True,
    visualization: bool = False,
    aIn: list[int] | None = None,
    bIn: list[int] | None = None,
    aOut: list[int] | None = None,
    bOut: list[int] | None = None,
) -> dict
```

| Parameter | Type | Description |
|---|---|---|
| `spec` | `ButterflyOperatorSpec` | Operator interface — sized, typed, with full bit-heap provenance. |
| `pipeline_stages` | int | Compressor pipeline depth, distributed via `reg_flag_list_gen`. Same value applies to both compressors. |
| `gen_testbench` | bool | If True, emit `<spec.name>_tb.sv` plus the four hex testvector files. Requires all four data arrays. |
| `visualization` | bool | Emit per-output bit-heap PNGs. PNGs auto-prefixed `aOut_*` / `bOut_*` to prevent the two heaps from clobbering each other. |
| `aIn` / `bIn` / `aOut` / `bOut` | `list[int]` | Testvector data arrays. All four required when `gen_testbench=True`; all must agree in length (= `test_size`). The generator no longer samples or computes goldens — caller is responsible for both. The wrapping `operator_modeling.ntt.ButterflyScheme.GoldilocksSlice64.emitRtl` does the random sampling + `propagateValue` golden computation and dispatches here. |

Returns a metadata dict: wrapper module name, per-output compressor module
names, per-output pipeline-stage count, per-output compressor-output width,
overall pipeline latency.

The simpler / recommended entry point for almost all use cases is
`operator_modeling.ntt.ButterflyScheme.GoldilocksSlice64.emitRtl(name, run_dir, ...)`, which wraps
this function with random sampling, `propagateValue` golden computation, the
`os.chdir(run_dir)` dance, and a local twos-complement-encoding sanity check.

### 7c. What gets emitted

Files written relative to cwd (mirroring Cmult's layout):

| Path | Description |
|---|---|
| `RTL_generated/<spec.name>.sv` | Wrapper module: `clk`, `aIn[aBw-1:0]`, `bIn[bBw-1:0]`, `aOut[aOutBw-1:0]`, `bOut[bOutBw-1:0]`. Instantiates the two compressors, routes shared `aIn`/`bIn` registers via fan-out, truncates `comp_out[N-1:0]` to the predicted bound width. |
| `RTL_generated/<spec.name>_aOut_cmp.sv` | aOut bit-heap compressor (one Versal-LUT + LOOKAHEAD8 instantiation per stage). |
| `RTL_generated/<spec.name>_bOut_cmp.sv` | bOut bit-heap compressor. |
| `RTL_generated/<spec.name>_tb.sv` | Self-checking testbench (when `gen_testbench=True`). Uses the `../../../../../testvectors/` 5-deep `$readmemh` path convention; `run_remote_sim.py` patches it to `../testvectors/` for server-side build. |
| `xdc_generated/<spec.name>_{aOut,bOut}_cmp.xdc` | LUTNM placement constraints per compressor. |
| `testvectors/{aIn,bIn,aOut,bOut}.txt` | Hex testvectors — two's complement at the per-port bit width. Goldens come from `golden_fn`. |
| `bitheap_visualization/{aOut,bOut}_*.png` | Per-output PNGs (when `visualization=True`). |
| `<spec.name>_{aOut,bOut}_bitheap.txt` | Column heights (intermediate input to `compressor_RTL_gen`). |

### 7d. Two-output strategy

The butterfly has two outputs (`aOut`, `bOut`) sharing input registers. The
generator builds **two independent bit-heaps**, then routes the same `aIn` /
`bIn` register bits into both compressors via fan-out at the wrapper level.
This mirrors `Bmult`'s `gen → cmp` pattern but with two compressors instead
of one.

Each heap independently goes through:

1. `_build_heap_descriptors(spec.aOutTerms or .bOutTerms, output_width, prefix)`:
   case A/B/C/D Baugh-Wooley assignment per `SliceTerm` into a column array,
   sign-extension and Baugh-Wooley correction constants accumulated in a
   single integer `sign_ext`, then folded into the heap as `1'b1` constants
   at the set bit positions of `sign_ext mod 2^N`.
2. `compressAll → formGPCChain → merge_last_stage → reg_flag_list_gen`
   (existing pipeline shared with Cmult/Bmult).
3. `compressor_RTL_gen` per heap, emitting `<spec.name>_<output>_cmp.sv` + xdc.

The wrapper SV is then assembled to instantiate both compressors, declare the
column wires, emit per-bit assigns from `aIn` / `bIn`, and truncate
`comp_out[N-1:0]` per output.

### 7e. Bit-heap-level handling of signed slices and negation

Five mechanisms, all flowing through one `sign_ext` accumulator (no per-term
constant emission to the heap):

1. **Unsigned slice, sign=+1**: data bits at columns `[k..k+W-1]`. Nothing in
   `sign_ext`.
2. **Unsigned slice, sign=-1**: complemented data bits + `+1` at column k +
   1's at `[k+W..N-1]` (Baugh-Wooley negation).
3. **Signed slice, sign=+1**: `A[0..W-2]` normal, `~A[W-1]` at column k+W-1,
   `+1` at column k+W-1, 1's at `[k+W..N-1]` (signed-slice MSB trick).
4. **Signed slice, sign=-1**: `~A[0..W-2]` complemented, `A[W-1]`
   uncomplemented (double negation cancels), `+1` at column k, `+1` at column
   k+W-1, 1's at `[k+W..N-1]`.
5. **Const term** (e.g. `-q` lazy reduction): folded directly into `sign_ext`
   as `sign * constValue * 2^limbShift`. After mod-2^N it becomes a tight
   set of constant bits.

Truncation kicks in when `k + W - 1 ≥ N` (the slice extends past the heap's
output width). In that case the slice is treated as effectively unsigned (the
sign bit is in the truncated zone) and only its low `N - k` bits are emitted.
For Goldilocks n=128 this never triggers; wider configurations may.

### 7f. Validation

The generator has been validated end-to-end on real Vivado batch simulation
(V80, Versal LOOKAHEAD8 + Versal-LUT primitives) across a range of shapes:

| Direction | Twiddle | Pipeline | Bounds | Result |
|---|---|---|---|---|
| NTT GS L2 p5 | 1-NAF `[(1, 6)]` | 1 | s66 / s66 | PASS 1000/1000 |
| NTT GS L0 p1 | 2-NAF `[(1, 43), (-1, 91)]` | 2 | s66 / s66 | PASS 1000/1000 |
| NTT CT L6 p1 | 2-NAF `[(1, 43), (-1, 91)]` | 1 | s66 / s66 | PASS 1000/1000 |
| NTT GS L4 p3 | 1-NAF `[(-1, 72)]` | 1 | s66 / u32 (asymmetric) | PASS 1000/1000 |
| NTT CT L0 p0 | trivial `[(1, 0)]` | 1 | u64 / s66 (asymmetric) | PASS 1000/1000 |
| INTT GS L1 p7 | 1-NAF `[(-1, 15)]` | 2 | s66 / s66 | PASS 1000/1000 |

---

## 8. `NTT_RTL_gen` — full Goldilocks NTT/INTT pipeline *(programmatic, no CLI)*

The pipeline-level RTL generator at
`versal_arith/rtl_gen/ntt.py::NTT_RTL_gen` composes per-butterfly RTL units
(via `Butterfly_RTL_gen`) into a complete fully-pipelined NTT/INTT datapath:
top wrapper SV that wires butterflies per the in-place memory layout, an
end-to-end self-checking testbench, packed-hex natural-order
input/output testvectors, aggregated XDC files, and a JSON manifest.

Like `Butterfly_RTL_gen`, this generator has **no CLI hook** because it
consumes a Python dataclass plus precomputed Python testvector batches. The
end-to-end CLI driver is `scripts/build_ntt.py` at the project root; see
[`../../scripts/README.md §2`](../../scripts/README.md) for the full argument
documentation. This section documents the **programmatic API**.

### 8a. The spec contract

Defined in `versal_arith/ntt_spec.py` (top-level, mirroring `butterfly_spec.py`):

```python
from butterfly_spec import ButterflyOperatorSpec
from ntt_spec import InterStageWire, NTTOperatorSpec

@dataclass(frozen=True)
class InterStageWire:
    src_p: int        # producing butterfly position in the previous layer
    src_port: str     # 'A' | 'B'

@dataclass(frozen=True)
class NTTOperatorSpec:
    name: str                                       # e.g. 'NTT_n128_GS'
    n: int
    butterflyType: str                              # 'CT' | 'GS'
    negacyclic: bool
    q: int

    butterflySpecs: list[list[ButterflyOperatorSpec]]   # log2(n) x n/2

    # Per-natural-input widths — each x[i]'s width / signedness comes from the
    # corresponding stage-0 butterfly port's bound; no uniformity is assumed.
    inputBitWidthsNatural: list[int]                # length n
    inputIsSignedNatural: list[bool]                # length n
    outputBitWidthsNatural: list[int]               # length n
    outputIsSignedNatural: list[bool]               # length n

    inputWiring: list[tuple[int, int]]              # n/2 (natA, natB) per stage-0 butterfly
    outputWiring: list[tuple[int, int]]             # n/2 (natA, natB) per final-stage butterfly
    interStageWiring: list[list[tuple[InterStageWire, InterStageWire]]]
        # length log2(n)-1, outer length n/2 per layer
    # to_dict() / from_dict() round-trip via JSON.
```

Wiring tables are precomputed at extraction time (in
`operator_modeling.ntt.NTT.FullyPipelinedNTT.getOperatorInterface`). Per-natural input
*and* output widths can both vary — input widths reflect each stage-0
butterfly port's bound (set by the caller's `getInputsNatural`); output
widths come from each final-stage butterfly port's bound (twiddle-driven via
`propagateBound`).

### 8b. Public API

```python
def NTT_RTL_gen(
    spec: NTTOperatorSpec,
    pipeline_stages_per_layer: list[int],   # length log2(n); layer-uniform
    gen_testbench: bool = True,
    test_size: int = 1000,
    seed: int | None = None,
    visualization: bool = False,
    golden_x_natural: list[list[int]] | None = None,   # test_size x n
    golden_y_natural: list[list[int]] | None = None,   # test_size x n
) -> dict
```

| Parameter | Type | Description |
|---|---|---|
| `spec` | `NTTOperatorSpec` | Pipeline-level interface — every butterfly's `ButterflyOperatorSpec` plus the wiring tables. |
| `pipeline_stages_per_layer` | `list[int]` | One entry per layer (length `log2(n)`); every butterfly in layer `s` is generated with `pipeline_stages = entry[s]`. |
| `gen_testbench` | bool | If True, emit `<spec.name>_tb.sv` + `testvectors/x_in.txt` + `testvectors/y_out.txt`. Requires the `golden_*` kwargs. |
| `test_size` | int | Number of cycles in the testvector files. |
| `seed` | int \| None | Forwarded to `Butterfly_RTL_gen`'s per-butterfly random seed (does not affect testvector content, which the caller pre-generates). |
| `visualization` | bool | Per-output bit-heap PNGs for every butterfly in the grid. |
| `golden_x_natural` | `list[list[int]]` | `test_size × n` rows of natural-order inputs; one row per cycle. |
| `golden_y_natural` | `list[list[int]]` | `test_size × n` rows of natural-order expected outputs. Caller is responsible for these — typically `propagateValue` end-to-end on the same `FullyPipelinedNTT` instance that produced the spec. |

Returns a manifest dict (also written as `manifest.json`):
- `top_name`, `n`, `butterflyType`, `negacyclic`
- `pipeline_stages_per_layer` (echoed)
- `butterfly_latencies` (`log2(n) × n/2` actual latencies returned by each `Butterfly_RTL_gen` call)
- `layer_latency` (per-layer max)
- `total_latency` (sum across layers)
- `butterfly_module_names`

### 8c. What gets emitted

Files written relative to cwd:

| Path | Description |
|---|---|
| `RTL_generated/<spec.name>.sv` | Top wrapper. **Per-index named ports**: `clk`, `x_in_<i>` (one per natural input, exactly `inputBitWidthsNatural[i]` bits wide), `y_out_<i>` (one per natural output, exactly `outputBitWidthsNatural[i]` bits). No 2D-array slot, no max-width padding, no implicit truncation at the port boundary. Body is purely structural — instantiate every butterfly by name, wire inputs/outputs per `inputWiring` / `interStageWiring` / `outputWiring`. Within-layer balancing shift registers emitted only when butterflies in the same layer return different `pipeline_latency` from `Butterfly_RTL_gen`. |
| `RTL_generated/<spec.name>_tb.sv` | Self-checking top testbench. Per-index `logic [W_i-1:0] x_in_<i>` / `y_out_<i>` locals + per-index DUT instantiation. Reads `testvectors/x_in.txt` (per-slot widths packed natural-MSB-first per cycle) and `testvectors/y_out.txt` (same scheme). Drives one cycle per testvector, waits `total_latency` cycles, compares `{y_out_{n-1}, ..., y_out_0}` against the packed golden. PASS/FAIL strings match the per-butterfly TB so `scripts/run_remote_sim.py`'s grep patterns work unchanged. |
| `RTL_generated/<topName>_btf_L<s>_p<p>.sv` etc. | Per-butterfly DUT + two compressor SVs. Module names are namespaced by the NTT's `topName` (the `getOperatorInterface(name=...)` argument) — so two NTT instances with the same n/butterflyType but different top names produce non-colliding butterfly modules, required when integrating multiple NTTs into one Vivado project. The `btf` abbreviation (vs full `Butterfly`) keeps identifiers short enough to avoid a Vivado xelab false-positive multi-driver error seen at ~50+ char identifiers in 449-butterfly elaboration. Emitted by `Butterfly_RTL_gen` with `gen_testbench=False` per call (no per-butterfly TBs at the pipeline level — that's what the per-butterfly debug mode of `scripts/build_ntt.py` is for). |
| `xdc_generated/<topName>_btf_L<s>_p<p>_{aOut,bOut}_cmp.xdc` | One pair of LUTNM placement-constraint files per butterfly. |
| `testvectors/x_in.txt`, `testvectors/y_out.txt` | Hex testvectors — **per-slot packed two's-complement** (MSB = highest natural index, LSB = natural index 0; each slot occupies exactly its bound's width). |
| `manifest.json` | Pipeline metadata. |

The simpler / recommended entry point is
`operator_modeling.ntt.NTT.FullyPipelinedNTT.emitRtl(topName, run_dir, ...)`, which
extracts the spec, pulls goldens from the populated instance's testVectors,
and dispatches here.

### 8d. Per-layer pipeline latency

`pipeline_stages_per_layer` is layer-uniform: every butterfly in layer `s`
gets `pipeline_stages = entry[s]` forwarded into `Butterfly_RTL_gen`. After
generation, `layer_latency[s] = max(pipeline_latency[s][p] for p in 0..n/2-1)`,
and any butterfly whose actual latency falls short receives
`layer_latency[s] - pipeline_latency[s][p]` extra register stages on its
output wires before they enter layer `s+1`. The total NTT latency is the sum
of per-layer latencies.

In the common case (`pipeline_stages_per_layer[s]` ≤ the butterfly's
compressor depth in that layer), all butterflies in a layer share the same
actual latency and the wrapper emits no balancing registers.

### 8e. Validation

The generator has been validated end-to-end on real Vivado batch simulation
(V80, Versal LOOKAHEAD8 + Versal-LUT primitives, 1000 testvectors per
direction):

| Pipeline | n | Topology | Input bound | Layer latency | Total latency | Result |
|---|---|---|---|---|---|---|
| `NTT_n128_GS`  | 128 | GS forward (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `NTT_n128_CT`  | 128 | CT forward (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `INTT_n128_GS` | 128 | GS inverse (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |
| `INTT_n128_CT` | 128 | CT inverse (cyclic)   | s96 | `[1,1,1,1,1,1,1]` | 7 | PASS 1000/1000 (128k slot checks) |

Each sweep instantiates 448 butterfly modules (7 layers × 64 positions). The
per-butterfly debug-sim path (driven by `--debug-butterfly L P`, see
`scripts/README.md §2`) was also independently verified for one
representative butterfly per topology.

---

## 9. Simulation-only behavioral backend (`sim_rtl_gen`)

The compressor-tree RTL from `Butterfly_RTL_gen` / `NTT_RTL_gen` is
Versal-fabric-optimised — synthesises and timing-closes well, but
xsim/Verilator runs are slow on deep gate-shaped netlists, especially
at n=128 (449 butterflies, hundreds of compression layers each). For
workflows that only need functional simulation (no synthesis), the
`versal_arith/sim_rtl_gen/` package emits a parallel **behavioral**
flavor that wraps every butterfly in `+/-` Verilog instead of GPCs +
LOOKAHEAD8 chains.

### Public API

Mirrors `rtl_gen.butterfly` / `rtl_gen.ntt` exactly so the operator_modeling
`emitRtl` methods can switch backends via a single `backend` kwarg:

  - `sim_rtl_gen.butterfly.Butterfly_SimRTL_gen(spec, pipeline_stages,
    gen_testbench, aIn, bIn, aOut, bOut, ...)` — same signature and
    return-shape as `Butterfly_RTL_gen`. Writes
    `RTL_generated/<spec.name>.sv`, optionally `<spec.name>_tb.sv` and
    `testvectors/{aIn,bIn,aOut,bOut}.txt`.
  - `sim_rtl_gen.ntt.NTT_SimRTL_gen(spec, pipeline_stages_per_layer,
    gen_testbench, golden_x_natural, golden_y_natural, test_size, ...)`
    — same signature and return-shape as `NTT_RTL_gen`. Walks the
    butterfly grid via `render_butterfly_sv` (an internal string
    builder) and **concatenates every butterfly module into one file**
    `RTL_generated/<topName>_butterflies.sv` (banner-separated). Plus
    `<topName>.sv` (top wrapper), `<topName>_tb.sv` (testbench),
    `testvectors/{x_in,y_out}.txt`, `manifest.json`.

What the sim backend does NOT write:

  - No `xdc_generated/` (simulation does not need placement constraints).
  - No `*_bitheap.txt` (no bit-heap construction at all).
  - No per-butterfly `*.sv` files in NTT mode (everything in one
    `<topName>_butterflies.sv`).
  - No compressor or visualization artifacts.

### How each butterfly module is shaped

For one butterfly module the body is:

```
  // signed aliases of unsigned ports (or zero-extended for unsigned bounds)
  wire signed [aInExt-1:0] aIn_ext = $signed(aIn);
  wire signed [bInExt-1:0] bIn_ext = $signed(bIn);

  // one wire per SliceTerm, declared signed iff term.isSigned
  wire signed [W0-1:0] aOut_t0 = $signed(W0'h...);     // -q literal
  wire        [Wi-1:0] aOut_ti = aIn_ext[hi:lo];       // unsigned slice
  wire signed [Wj-1:0] aOut_tj = aIn_ext[hi:lo];       // signed full-width slice
  // ... etc per term, with zero-LSB padding when inputShift > 0

  // combinational accumulator
  logic signed [ACC_W-1:0] aOut_sum_comb;
  always_comb aOut_sum_comb =
      signed'(ACC_W'(aOut_t0))                            // sign-extend then add
    + (signed'(ACC_W'(aOut_t1)) <<< limbShift1)           // shift-left after widen
    - (signed'(ACC_W'(aOut_t2)) <<< limbShift2);          // - for sign=-1

  // pipeline shift register of depth max(pipeline_stages, 1)
  logic [aOutBitWidth-1:0] aOut_pipe [0:N-1];
  always_ff @(posedge clk) begin
      aOut_pipe[0] <= aOut_sum_comb[aOutBitWidth-1:0];   // truncate to bound width
      for (int s = 1; s <= N-1; s++) aOut_pipe[s] <= aOut_pipe[s-1];
  end
  assign aOut = aOut_pipe[N-1];
```

This is a direct rendering of the spec's `aOutTerms` / `bOutTerms` —
the `-q` constant is baked in as a `SliceTerm(source='const')`, the
NAF twiddle is already multiplied into each `bIn`-source term's
`inputShift` and `sign`, and the limb-folding factors are in each
term's `limbShift` and `sign`. The generator just walks the term lists.

### Selecting the backend

Through the build scripts (preferred):

```bash
# default 'hw' — compressor-tree, lands at work/<scenario>/<NTT_or_INTT>_n<N>_<TYPE>/
python scripts/build_ntt.py ... --backend hw

# 'sim' — behavioral, lands at work/<scenario>/<NTT_or_INTT>_n<N>_<TYPE>_sim/
python scripts/build_ntt.py ... --backend sim

# standalone butterfly: same flag works
python scripts/build_butterfly.py ... --backend sim
```

Through `emitRtl` directly:

```python
GoldilocksSlice64(...).emitRtl(name=..., run_dir=..., backend='sim')
FullyPipelinedNTT(...).emitRtl(topName=..., run_dir=..., backend='sim')
```

### Testvector compatibility guarantee

Both backends derive testvectors from the same `propagateValue` call
in `operator_modeling`, so `testvectors/x_in.txt` and `testvectors/y_out.txt`
(and `aIn.txt` / `bIn.txt` / `aOut.txt` / `bOut.txt` for standalone
butterflies) are **byte-identical** between the `_sim` and non-`_sim`
run directories. The two backends can be diffed for cross-validation,
and `scripts/run_remote_sim.py` works on a sim-backend run dir without
any changes (testbench `$readmemh` paths, PASS/FAIL grep tokens, and
the run-dir layout all match).

The wrapping `emitRtl` method's local sanity check (re-runs
`propagateValue` on the first 8 testvectors and confirms the on-disk
hex matches mod 2^N) fires for both backends.

### When not to use the sim backend

  - **Synthesis**: the behavioral body uses arbitrary-width
    `<<<`-shift sums that any synthesis tool will infer as a wide
    combinational adder — it will not match the Versal LUT/LOOKAHEAD8
    structure the hw backend was designed for. Use `--backend hw`
    for any synthesis-bound flow.
  - **Place-and-route timing closure**: ditto. The sim backend has no
    XDCs.
  - **Bit-heap visualization**: not produced. Use the hw backend with
    `--visualization`.

---

## 10. Bringing the output into Vivado

> ### ⚠️ Critical: XDC files are **implementation-only** — *never* synthesis
>
> **Every `*.xdc` file under `xdc_generated/` must be added to the Vivado project with `USED_IN_SYNTHESIS` disabled (i.e. set as an *implementation-only* constraints file).** They contain `set_property LUTNM …` directives (and, on Booth runs, optional `LOCK_PINS`) — both are **placement/packing** hints that the synthesizer cannot honor, and applying them during synthesis can silently degrade results or be rejected outright.
>
> In the Vivado GUI: open the constraints file's *Source File Properties* pane and **uncheck "Used in Synthesis"** (leave "Used in Implementation" checked). In Tcl: `set_property USED_IN_SYNTHESIS false [get_files <name>.xdc]`. The provided `scripts/run_remote_synth.py` already filters XDCs out of the synth step automatically — this caveat only applies when you load the runs into Vivado by hand. **Reproducing the LUT/timing numbers reported in the ARITH 2026 paper requires this setting.**

For any operator:

1. **Source files**: add every `*.sv` from your run's `RTL_generated/` directory **and every file under `versal_arith/rtl/`** (the GPC primitive modules: `c3_2.sv`, `c6_3.sv`, `c15_3.sv`, `c223_4.sv`, `c9_41.sv`, `c39_231.sv`, `c413_341.sv`, `c517_451.sv`, `LFSR.sv`).

2. **Constraints** *(implementation-only — see callout above)*: add the matching `*.xdc` from `xdc_generated/` and set them with `USED_IN_SYNTHESIS false` (uncheck "Used in Synthesis" in the Source File Properties pane, leave "Used in Implementation" checked). The XDC contains `set_property LUTNM` directives that group paired sub-LUTs onto a single Versal LUT site so dual-5-LUT mode is preserved during placement — a synthesis-only or all-stages assignment will not produce the intended packing.

3. **Simulation**: open the generated `*_tb.sv`, set it as the simulation top, and run behavioral simulation. The testbench reads test vectors from `testvectors/` via `$readmemh`. If you moved the generated tree, edit the relative paths in the `$readmemh` calls (they assume the default `versal_arith_generated/<run>/RTL_generated/` location relative to the testvectors).

4. **Synthesis tweaks** if Vivado stalls: try disabling automatic global retiming. The Booth multiplier's XDC also locks specific LUT pin assignments via `LOCK_PINS` — these are commented out by default; uncomment if Vivado refuses the LUTNM grouping.

5. **Batch out-of-context synthesis on a remote V80 server**: `scripts/run_remote_synth.py` (added in this project) stages a generated run dir onto your V80 server, runs Vivado batch OOC synth on the top module (clock from `tcl/const.tcl`, **no LUTNM XDCs applied during synth — those are implementation-only; see step 2 above**), and pulls back small `utilization.rpt` / `timing_summary.rpt` / `timing_top10.rpt` reports plus a one-line LUT/FF/WNS/TNS summary. Same detached-launch + poll-marker pattern as `run_remote_sim.py`. Direct invocation: `python scripts/run_remote_synth.py --run-dir <run_dir>` (configure the server via the `V80_SERVER` env var or the `--server` flag). Or chain after generation via `--remote-synth` on `build_butterfly.py` / `build_ntt.py`. See `scripts/README.md §5` for the full argument table. Defaults to part `xcv80-lsva4737-2MHP-e-S` (AMD Alveo V80). Override via `--part` to target the paper's `xcvc1902-vsva2197-2MP-e-S` if your license covers it.

The paper targets Versal `xcvc1902-vsva2197-2MP-e-S` with Vivado 2025.2. Compressor comparisons against Hoßfeld et al. [20] use Vivado 2023.1.

---

## 11. The eight GPCs at a glance

The compressor tree is built from the catalogue introduced in the paper (Table IV). `(9 : 4, 1)` is a **new GPC proposed by this work** to replace `(10 : 4, 2)`. Per Versal LOOKAHEAD8 timing, **only `(3 : 2]` and `(1, 5 : 3]` are fully carry-lookahead compatible**; the others must appear at the start (with `LOOKB` forcing propagation) or end of a chain, with a length cap of 8 LUTs when the chain begins with an incompatible GPC. `(3, 9 : 2, 3, 1)` is an exception — its dual-rail structure (paper Fig. 4) lets it cascade via a parallel physical carry path.

| GPC | Inputs | Outputs | LUTs | E | S | LOOKAHEAD8 compatible | Row-counter eligible |
|-----|--------|---------|:----:|:----:|:----:|:----:|:----:|
| `(5, 17 : 4, 5, 1)`   | 5 + 17     | 4, 5, 1    | 8 | 1.5  | 2.2   | ✗ | ✗ |
| `(4, 13 : 3, 4, 1)`   | 4 + 13     | 3, 4, 1    | 6 | 1.5  | 2.125 | ✗ | ✗ |
| `(3, 9 : 2, 3, 1)`    | 3 + 9      | 2, 3, 1    | 4 | 1.5  | 2.0   | ✗ (dual-rail exception) | ✓ |
| `(9 : 4, 1)`*         | 9          | 4, 1       | 3 | 1.33 | 1.8   | ✗ | ✓ |
| `(6 : 3]`             | 6          | 1, 1, 1    | 3 | 1.0  | 2.0   | ✗ | ✓ |
| `(2, 2, 3 : 4]`       | 2 + 2 + 3  | 1, 1, 1, 1 | 2 | 1.5  | 1.75  | ✗ | ✓ |
| `(3 : 2]`             | 3          | 1, 1       | 1 | 1.0  | 1.5   | ✓ | ✓ |
| `(1, 5 : 3]`          | 1 + 5      | 1, 1, 1    | 2 | 1.5  | 2.0   | ✓ | ✓ |

\* New GPC introduced by this work.

The compression heuristic (`heuristic.py`) is the **area-and-delay heuristic from the paper**: it schedules counters per stage from the LSB column upward, applying each candidate GPC in priority order if it is both *applicable* (enough free bits in the required columns under the LOOKAHEAD8 cascade rules) and *necessary* (its necessity condition in paper Table V is satisfied), continuing along a row counter when possible. Compression terminates once every column has ≤ 4 free bits; the remainder is summed by the **two-layer-of-row-counters quaternary adder** (paper Fig. 10), built primarily from `(1, 5 : 3]` GPCs and stitched together at single-bit columns by `(3 : 2]` GPCs.

---

## 12. Common gotchas

- **🚨 Generated `*.xdc` files are implementation-only — never synthesis.** Set them with `USED_IN_SYNTHESIS false` in Vivado, otherwise the `LUTNM` packing directives are silently mis-applied during synth and you will not reproduce the paper's LUT/timing numbers. See the callout at the top of §10.
- **Run from `versal_arith/`** — `cli.py` and the modules use unqualified imports. Running `python versal_arith/cli.py` from the project root will fail.
- **Add the `rtl/` primitives to Vivado.** Generated `.sv` files instantiate `c3_2`, `c6_3`, etc. without including them, so synthesis errors with "module not found" mean you forgot to add `rtl/*.sv` as design sources.
- **Booth multiplier minimum is 6×6.** Smaller widths waste a partial-product row; the code does not guard against this — keep `width_a, width_b ≥ 6`.
- **Constant 0 is rejected.** `cmult` raises `ValueError` if NAF returns no terms.
- **Negative `-constant` values work**, but the module name suffix becomes `neg{abs(C)}` (the SystemVerilog identifier rules disallow leading `-`).
- **`-powers` is taken verbatim.** `"10,5,-3"` is the *same value* as `-constant 1048`, but the bit-heap is built from the exponents you gave; if those aren't already the minimum NAF, the generator does not minimize them further.
- **Modulus lifting takes seconds for large N.** `cmultbank` over 128 constants with `-modulus` enabled per-constant takes a few seconds; tune the search via `-lift_max_pow / -lift_max_shift / -lift_depth / -lift_beam`.
- **Testbench paths are relative**, hard-coded to `../../../../../testvectors/` (five levels up from `RTL_generated/`). If you move generated files, fix the `$readmemh` calls.
- **Visualization is matplotlib-only.** Pass `-visualization False` to skip if matplotlib isn't available.
- **Pipeline depth has a maximum** that depends on bit-heap shape (paper Table VI shows the limits for the standard cases). `reg_flag_list_gen` distributes registers evenly between layers; requesting more stages than there are layer boundaries silently caps at the maximum.

---

## 13. End-to-end example: NTT twiddle constant multiplier

This is the most common use of `cmult` in the project:

```bash
# A 24-bit input multiplied by a Goldilocks twiddle, with modular freedom
python cli.py \
  -operator cmult \
  -width_a 24 \
  -constant 13797081185216407910 \
  -modulus 18446744069414584321 \
  -pipeline_stages 1

# Console output:
# Constant multiplier: 24-bit unsigned x 13797081185216407910 (3 NAF terms, max col height=3)
#   Strategy: bitheap compressor (max height=3)
# Maximum Number of Pipeline Stages of the Compressor Tree: 2
# Generated compressor tree is pipelined into 1 stages
#
# Output written to: versal_arith_generated/Cmult_24x13797081185216407910/
```

Files produced:

```
versal_arith_generated/Cmult_24x13797081185216407910/
├── RTL_generated/
│   ├── Cmult_24x13797081185216407910.sv         # wrapper
│   ├── Cmult_24x13797081185216407910_cmp.sv     # compressor tree
│   └── Cmult_24x13797081185216407910_tb.sv      # self-checking testbench
├── xdc_generated/
│   └── Cmult_24x13797081185216407910_cmp.xdc    # LUTNM grouping constraints
├── testvectors/
│   ├── A.txt
│   └── P.txt
└── bitheap_visualization/
    ├── original_bitheap.png
    └── after_layer_*.png
```

Add all four `.sv` files plus everything in `versal_arith/rtl/` as design sources, the `.xdc` as implementation constraints, set the testbench as simulation top, and run.

---

## 14. `ARITH2026_Evaluation_Examples/` — pre-generated RTL for the paper

The folder `versal_arith/ARITH2026_Evaluation_Examples/` is **checked into the repository** and contains one ready-to-use generator run per example reported in the ARITH 2026 paper (Miao, Pottier, Bertels, Legiest, Verbauwhede — IACR ePrint 2026/344). Use it when you want to **read the generated SystemVerilog, drop the RTL into Vivado for synthesis/PnR, or re-run the self-checking testbenches without first regenerating anything**. Every directory inside it is byte-for-byte the layout a fresh `cli.py` run would produce.

### Inventory

| Subfolder | Source operator | What it is | Paper reference |
|-----------|-----------------|------------|-----------------|
| `Bmult6x6/`, `Bmult8x8/`, … `Bmult32x32/` | `-operator bmult -width_a N -width_b N` | Signed radix-4 Booth tree multipliers from 6×6 through 32×32 (even widths) — the dual-5-LUT Booth mapping from paper Table III, with `~n²/4` LUTs asymptotic cost | Booth-multiplier results table |
| `single128_1/` … `single128_6/` | `-operator cmp` | Six single-column bit heaps of width 128 (one `in_col0[127:0]` input, 8-bit `comp_out`) used as compressor-tree microbenchmarks | Compressor benchmarks |
| `single256_1/` … `single256_7/` | `-operator cmp` | Single-column heaps of width 256 | Compressor benchmarks |
| `single512_1/` … `single512_8/` | `-operator cmp` | Single-column heaps of width 512 | Compressor benchmarks |
| `double128_1/` … `double128_6/` | `-operator cmp` | Two-column heaps with two 128-bit inputs (`in_col0`, `in_col1`) | Compressor benchmarks |
| `double256_1/` … `double256_7/` | `-operator cmp` | Two-column heaps, 256-bit | Compressor benchmarks |
| `double512_1/` … `double512_8/` | `-operator cmp` | Two-column heaps, 512-bit | Compressor benchmarks |
| `Mult16_1/` … `Mult16_4/` | `-operator cmp` | 16×16-multiplier-shaped partial-product heaps (triangular column heights), four variants used as compressor comparisons against prior work | Comparison with Hoßfeld et al. [20] |

Counts at the time of writing: **14 Booth runs + 42 compressor runs + 4 Mult16 runs = 60 example directories.**

### What each directory contains

Identical to a freshly generated run (compare with §3 and §4):

```
ARITH2026_Evaluation_Examples/<name>/
├── RTL_generated/
│   ├── <name>.sv                       # top wrapper (Comp_<name> for cmp, Bmult<A>x<B> for bmult)
│   ├── <name>_tb.sv                    # self-checking testbench
│   └── <name>_bitheap_{gen,cmp}.sv     # (bmult only) Booth partial-product gen + compressor
├── xdc_generated/
│   └── <name>{_bitheap_cmp,_bitheap_gen}.xdc   # LUTNM placement constraints
├── testvectors/                        # hex testvectors for $readmemh
├── bitheap_visualization/              # per-stage compression PNGs
└── bitheap.txt                         # (bmult only) the partial-product column heights
```

Compressor module names are prefixed `Comp_` (e.g. `Comp_single128_1`, `Comp_double256_3`, `Comp_Mult16_1`); Booth top modules use the plain `Bmult<A>x<B>` name. The `_tb.sv` testbenches use the same `../../../../../testvectors/` 5-deep `$readmemh` convention as every other generated run, so `scripts/run_remote_sim.py` works on these folders without changes.

### Reproducing an example

Each directory is the result of one `cli.py` invocation. To rebuild — for example — `single256_3/` from scratch:

```bash
cd versal_arith
python cli.py -operator cmp \
  -txt_file_name <path-to-the-bitheap.txt-for-single256_3> \
  -sv_file_name single256_3 \
  -cmp_module_name Comp_single256_3 \
  -tb_out_width 10
```

For the Booth examples, the inputs are just the two operand widths:

```bash
cd versal_arith
python cli.py -operator bmult -width_a 16 -width_b 16
```

The folder is intended as a **stable, citable artifact** alongside the paper — synthesizing any of these and reproducing the LUT/FF/WNS numbers reported in the paper does not require running the generator at all.

> **Reproducing the paper's results — read this first.** When you load the `xdc_generated/*.xdc` from any example into Vivado, mark each file as an **implementation-only** constraints file (`USED_IN_SYNTHESIS false`). The XDC contains placement/packing directives (`LUTNM`, optional `LOCK_PINS`) that only take effect during implementation; applying them at the synth stage will silently degrade results. See the callout at the top of §10.
