# Versal NTT — algorithm-to-RTL toolkit

This repository contains two related but independent Python subprojects that
together cover an algorithm-to-RTL pipeline for Number Theoretic Transform
(NTT) hardware on AMD Versal FPGAs, plus a thin glue layer that ties them
together.

| Subproject | Purpose | Top-level docs |
|---|---|---|
| [`versal_arith/`](versal_arith/) | Versal-fabric arithmetic RTL generator (compressor trees, Booth multipliers, constant multipliers, Goldilocks NTT butterflies, full NTT pipelines) | [`versal_arith/docs/USAGE.md`](versal_arith/docs/USAGE.md), [`versal_arith/docs/THEORY.md`](versal_arith/docs/THEORY.md) |
| [`NTT_modeling/`](NTT_modeling/) | Bound-propagation + value-batch modeling library that sizes the NTT datapath before it is emitted as RTL | [`docs/USAGE.md`](docs/USAGE.md), [`docs/THEORY.md`](docs/THEORY.md) |
| [`scripts/`](scripts/) | Bridge CLIs: `build_butterfly.py`, `build_ntt.py`, `build_bank.py`, `run_remote_sim.py`, `run_remote_synth.py` | [`scripts/README.md`](scripts/README.md) |

---

## 1. `versal_arith/` — Versal arithmetic RTL generator

`versal_arith/` is an automated RTL generator that emits synthesizable
SystemVerilog (plus XDC placement constraints, self-checking testbenches,
and bit-heap visualizations) targeting the AMD Versal LUT (dual-5-LUT mode
with the new `O5_2` / `PROP` / LUT-cascade pins) and the LOOKAHEAD8 carry
hardware.

It implements the architecture from:

> Z. Miao, X. Pottier, J. Bertels, W. Legiest, I. Verbauwhede.
> *Area-Efficient LUT-Based Multipliers for AMD Versal FPGAs.*
> Submitted to **IEEE ARITH 2026**. IACR ePrint **2026/344**.
> <https://eprint.iacr.org/2026/344>

The paper contributes a Versal-tailored GPC catalogue (including a new
`(9 : 4, 1)` GPC), an area-and-delay heuristic for compressor-tree synthesis
under the LOOKAHEAD8 cascade rules, a two-layer quaternary terminal adder,
and a dual-5-LUT Booth partial-product mapping that yields an asymptotic
~n²/4 LUT cost for an n-bit multiplication. The generator covers all of
these and exposes them through four CLI operators:

| `-operator` | Generates | In paper? |
|---|---|:---:|
| `cmp`       | Compressor tree from a column-height descriptor | ✓ |
| `bmult`     | Signed radix-4 Booth tree multiplier (≥6×6) | ✓ |
| `cmult`     | `unsigned/signed A × constant C` (no DSP, NAF-decomposed) | extension |
| `cmultbank` | Bank of N parallel constant multipliers with uniform pipeline latency | extension |

**Pre-generated artifacts for every Booth-multiplier and compressor-tree
example reported in the ARITH 2026 paper are checked in under
[`versal_arith/ARITH2026_Evaluation_Examples/`](versal_arith/ARITH2026_Evaluation_Examples/)**
(60 ready-to-synthesize run directories: `Bmult6×6 … Bmult32×32`,
`single128/256/512_*`, `double128/256/512_*`, `Mult16_*`). Use them to
reproduce the paper's LUT / FF / WNS / TNS numbers without regenerating
anything — see [`versal_arith/docs/USAGE.md` §14](versal_arith/docs/USAGE.md).

> ⚠️ When bringing any generated RTL into Vivado, every `xdc_generated/*.xdc`
> must be added with `USED_IN_SYNTHESIS false` (implementation-only). The
> `LUTNM` packing directives are placement hints; applying them during
> synthesis silently degrades results. Full details in
> [`versal_arith/docs/USAGE.md` §10](versal_arith/docs/USAGE.md).

Quick start:

```bash
cd versal_arith
python cli.py -operator bmult -width_a 16 -width_b 16
python cli.py -operator cmp   -txt_file_name bitheap.txt -sv_file_name my_compressor
```

---

## 2. `NTT_modeling/` + Goldilocks-NTT pipelines — work in progress

`NTT_modeling/` is the **on-going** modeling and RTL-generator design of
fully-pipelined NTT / INTT datapaths for the Goldilocks prime
`q = 2^64 − 2^32 + 1` on Versal FPGAs. It is the companion to the
arithmetic generator above: the modeling library sizes the datapath, and
the arithmetic generator turns each sized butterfly into Versal-LUT-
optimized RTL.

The library does **not** compute a numeric NTT in the usual sense. It does
two things in parallel through the same butterfly graph:

1. **Bound propagation** — propagates `IntType` interval bounds
   `(minValue, maxValue, zeroLsbs)` through every operator so the resulting
   FPGA datapath can be sized precisely (per-port bit-width and signedness,
   no slack).
2. **Value-batch simulation** — runs `list[int]` test vectors through the
   same graph in lock-step with the bounds, for cross-verification against
   a Sage-based O(n²) reference NTT (`verifyNtt` / `verifyIntt`).

The two paths share one wiring layout (`log2(n) × n/2` butterflies wired
in-place via `butterflyToMems` / `memToButterfly`) and one populated
instance — so the spec extracted at the end (`getOperatorInterface`)
carries each butterfly's sized inputs/outputs *and* its NAF-lifted twiddle
*and* the bit-level provenance of every output bit.

The RTL bridge is the second-half story:

- **Per-butterfly**:
  `GoldilocksSlice64.emitRtl(name, run_dir, ...)` → extracts a
  `ButterflyOperatorSpec` and dispatches to
  `versal_arith.rtl_gen.butterfly.Butterfly_RTL_gen`.
- **Full pipeline**:
  `FullyPipelinedNTT.emitRtl(topName, run_dir, ...)` → extracts an
  `NTTOperatorSpec` (every butterfly's spec + precomputed in-place wiring
  tables) and dispatches to `versal_arith.rtl_gen.ntt.NTT_RTL_gen`, which
  emits a per-index-named-port top wrapper, per-butterfly compressor-tree
  modules, balancing shift registers, and a self-checking testbench.

A parallel **simulation-only behavioral backend** (`versal_arith/sim_rtl_gen/`)
mirrors the hw entry points so `emitRtl(..., backend='sim')` swaps in fast
`+/-` Verilog instead of GPC + LOOKAHEAD8 chains — byte-identical testvectors,
same TB conventions, much faster `xsim` runs at n=128 (449 butterflies).

End-to-end CLI drivers live in [`scripts/`](scripts/):

```bash
# Generate one Goldilocks butterfly with explicit per-input bounds + twiddle
python scripts/build_butterfly.py --n 128 --layer 2 --position 5 \
  --butterfly-type GS --aIn-bound s66 --bIn-bound s66 \
  --twiddle-source xlsx --twiddle-xlsx twiddles.xlsx

# Generate a full NTT128 forward pipeline (GS, cyclic) with per-layer pipelining
python scripts/build_ntt.py --scenario ntt128_GS --n 128 \
  --direction NTT --butterfly-type GS --input-bound s96 \
  --pipeline-stages 1 --test-size 1000

# Behavioral fast-sim variant of the same pipeline
python scripts/build_ntt.py --scenario ntt128_GS --n 128 \
  --direction NTT --butterfly-type GS --input-bound s96 \
  --pipeline-stages 1 --test-size 1000 --backend sim
```

**Status.** Pipelines have been validated end-to-end on real Vivado batch
simulation on a V80 board across `NTT_n128_GS`, `NTT_n128_CT`,
`INTT_n128_GS`, `INTT_n128_CT` (1000 testvectors per direction, ~128k slot
checks per run, all PASS). Negacyclic (NWC) pre/post-twist banks are
generated via `scripts/build_bank.py`. Area-cost modeling
(`ButterflyScheme.areaCost`) is still a stub, and a paper covering the
full NTT pipeline design is in preparation.

---

## Layout

```
PythonProjects/
├── versal_arith/                 # arithmetic RTL generator (subproject 1)
│   ├── cli.py
│   ├── rtl_gen/                  # synth-targeted Versal RTL backend
│   ├── sim_rtl_gen/              # behavioral simulation-only backend
│   ├── rtl/                      # GPC primitives — add ALL to Vivado
│   ├── ARITH2026_Evaluation_Examples/  # paper artifacts (checked in)
│   └── docs/
├── NTT_modeling/                 # bound-propagation + value-batch library (subproject 2)
├── docs/                         # NTT_modeling USAGE.md + THEORY.md
├── scripts/                      # bridge CLIs
├── runButterfly.py               # example modeling driver
├── runNTT128_GS_s130.py          # example end-to-end runs
├── runNTT128_GS_after_pretwist.py
├── runINTT128_CT_s132.py
├── twiddles.xlsx                 # NAF-lifted twiddles
└── NTT_bounds.xlsx               # per-stage bound table (generated by the modeling lib)
```

---

## Setup

Two environments cover both subprojects:

```bash
# Arithmetic generator (stdlib + matplotlib for bit-heap PNGs)
pip install matplotlib

# Modeling library (Sage for GF(q), openpyxl for xlsx I/O)
conda create -n ntt-sage -c conda-forge sage python=3.11
conda activate ntt-sage
pip install openpyxl
```

Vivado is needed only downstream of generation, for synthesis / place-and-route / simulation.

---

## Citation

If you use the arithmetic generator in academic work, please cite the
ARITH 2026 paper:

```bibtex
@misc{miao2026versal,
  author       = {Zetao Miao and Xavier Pottier and Jonas Bertels and
                  Wouter Legiest and Ingrid Verbauwhede},
  title        = {{Area-Efficient LUT-Based Multipliers for AMD Versal FPGAs}},
  howpublished = {Cryptology ePrint Archive, Paper 2026/344},
  year         = {2026},
  url          = {https://eprint.iacr.org/2026/344},
  note         = {Submitted to IEEE ARITH 2026},
}
```
