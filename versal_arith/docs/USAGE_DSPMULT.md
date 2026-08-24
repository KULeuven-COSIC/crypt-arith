# versal_arith — DSP/LUT Multiplier: Usage Guide

Practical guide for `-operator dspmult` — hybrid DSP58+LUT multiplier search and RTL generation.
For the search/costing/timing-model theory, see `THEORY_DSPMULT.md`. For the base setup and the
other four operators (`cmp`, `bmult`, `cmult`, `cmultbank`), see `USAGE.md`.

---

## 1. Setup

Same as `USAGE.md` §1:

```bash
pip install matplotlib       # only required if -visualization is True (default)
```

That is the entire dependency. Everything else is Python stdlib. Vivado is needed downstream for
synthesis but not for generation. Run from inside `versal_arith/`:

```bash
cd versal_arith
python cli.py -operator dspmult [args...]
```

`dspmult` manages its own output hierarchy under `<output_dir>/dspmult/` (default
`versal_arith_generated/dspmult/`), separate from the other operators' `<output_dir>/<run_name>/`
layout:

```
versal_arith_generated/
└── dspmult/
    ├── bundles/                                  # frontend output: solved-solution JSON
    │   └── sol_<width_a>x<width_b>_<sign_code>_<budget>dsp.json
    └── rtl/
        └── rtl_out_<bundle_stem>_<module_name>/   # backend output: one dir per bundle+module
            ├── <module_name>.sv                   # top-level RTL
            ├── wrappers/*.sv                       # per-tile wrapper modules
            ├── inner/*.sv                          # DSP/bitheap/Booth inner implementations
            ├── gpc/*.sv                            # GPC counter primitives (only if a compressor tree is used)
            ├── xdc/*.xdc                            # per-tile placement constraints (LUTNM etc.)
            ├── filelist.f                           # full source list, for Vivado add_files / Verilator
            ├── synth_settings.tcl                   # always written by -rtl, see §2.3
            ├── <module_name>_tb.sv                  # -evaluate: self-checking testbench
            ├── intermediates.txt                    # -evaluate: per-stage reference values for debug
            ├── <module_name>_hweval.sv               # -evaluate: on-chip evaluation shell (direct or LFSR-driven)
            ├── <module_name>_hweval_ooc.xdc          # -evaluate: out-of-context clock constraint
            ├── LFSR.sv                               # -evaluate, only if the LFSR hweval style was chosen
            └── scoped_xdc_project.tcl                # -evaluate, only if xdc/ is non-empty, see §2.3
```

---

## 2. `dspmult` — CLI reference

`dspmult` is split into a **frontend** (solve: search for the cheapest tiling within a DSP
budget, save a bundle) and a **backend** (lower a solved bundle to RTL and/or an evaluation
harness). Passing neither `-frontend` nor `-backend` runs both in one invocation; passing just one
lets you split a slow search from a fast re-emit (e.g. re-running `-backend` with a different
`-latency_budget` against an already-solved bundle).

```bash
python cli.py -operator dspmult \
  -width_a 256 -width_b 256 -a_sign signed -b_sign signed \
  -budget 110 \
  -rtl -evaluate
```

### 2.1 Arguments

| Argument | Type | Scope | Description | Default |
|----------|------|-------|-------------|---------|
| `-width_a`, `-width_b` | int | both | operand bit-widths | `8` |
| `-a_sign`, `-b_sign` | `signed`\|`unsigned` | both | operand signedness | `signed` |
| `-frontend` | flag | select stage | run the search, save a bundle | off |
| `-backend` | flag | select stage | load/lower a bundle, emit selected outputs | off |
| `-budget` | int | frontend | DSP budget (required if `-frontend` runs); the search never exceeds it | — |
| `-bundle` | path | both | solution bundle to write (frontend) or read (backend-only); default is the auto-named path under `dspmult/bundles/` | — |
| `-rtl` | flag | backend | generate the complete RTL project | off |
| `-evaluate` / `-eval` | flag | backend | generate testbench + evaluation harness | off |
| `-latency_budget` | int | backend | cap total pipeline latency (cycles); picks the fastest-critical-path Pareto point within it — see `THEORY_DSPMULT.md` §1.2. Omit for the unconstrained fastest-critical-path point | — |
| `-clock_period_ns` | float | backend, `-evaluate` only | explicit hweval clock period; if omitted, derived as `worst_ns * 1.25` from the selected Pareto point | derived |
| `-test_size` | int | backend, `-evaluate` only | number of random test vectors (shared with the other operators) | `1000` |
| `-seed` | int | backend, `-evaluate` only | random test-vector seed | `1` |
| `-output_dir` | str | both | root output directory (shared with the other operators) | `versal_arith_generated` |

Running `-backend` alone requires `-bundle` (nothing to load otherwise); running `-backend`
requires at least one of `-rtl`/`-evaluate` (nothing to do otherwise). `-pipeline_stages`,
`-gen_testbench`, and `-visualization` (used by the other four operators) don't apply here.

### 2.2 Two-step workflow (recommended for large boards)

Search can be the slow part on a large board/tight budget; split it out so `-backend` re-runs are
cheap:

```bash
# 1) frontend only: search, save the bundle
python cli.py -operator dspmult -width_a 256 -width_b 256 -budget 110 -frontend

# 2) backend only, re-run as many times as you like against the saved bundle
python cli.py -operator dspmult -backend -rtl \
  -bundle versal_arith_generated/dspmult/bundles/sol_256x256_ss_110dsp.json

python cli.py -operator dspmult -backend -evaluate -latency_budget 6 \
  -bundle versal_arith_generated/dspmult/bundles/sol_256x256_ss_110dsp.json
```

### 2.3 Generated files

Beyond the RTL/wrapper/inner/gpc/xdc/filelist tree in §1, two Tcl helpers are written for
Vivado **project-mode** flows:

**`synth_settings.tcl`** (written by `-rtl`, always) — a fixed, design-independent set of
`synth_1` run properties, meant to be sourced in the Vivado GUI's Tcl console (or a project-mode
batch script) *before* launching synthesis:

```tcl
# Disable global retiming
set_property STEPS.SYNTH_DESIGN.ARGS.GLOBAL_RETIMING off \
    [get_runs synth_1]

# Reduce synthesis runtime
set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE RuntimeOptimized \
    [get_runs synth_1]

# Preserve hierarchy globally
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none \
    [get_runs synth_1]
```

It's also handy on its own for **batch-mode LUT-usage debugging** (apply it to any run to get a
fast, flattened synthesis pass to read utilization off of). In a full project-mode
synthesis+implementation flow, though, each setting has a caveat and isn't strictly required:

- **`GLOBAL_RETIMING off`** — leaving retiming *on* has, in some designs, made the Booth
  multiplier (`bmult`) error out partway through implementation. Turning it off avoids that; only
  turn it back on if you've confirmed your specific design doesn't hit it.
- **`DIRECTIVE RuntimeOptimized`** — the delay lines that keep pipeline timing correct can insert a
  large number of flip-flops, and without `RuntimeOptimized` the default directive spends a lot of
  time weighing optimization choices across all of them, which has in some cases taken hours to
  finish. `RuntimeOptimized` keeps that search cheap; drop it only if you specifically need a
  different synthesis directive and have runtime to spare.
- **`FLATTEN_HIERARCHY none`** — purely for debugging (keeps instance names/hierarchy readable in
  the implemented netlist); safe to turn off if you don't need that.

**`scoped_xdc_project.tcl`** (written by `-evaluate`, only if any per-tile `.xdc` files were
generated into `xdc/`) — attaches each generated `.xdc` as `SCOPED_TO_REF` (i.e. applies at every
instance of that module, not by absolute path) and validates the ref exists once a design is open.
Usage in the Vivado GUI's Tcl console, in a **project-mode** flow:

1. **Source once before synthesis** — attaches `SCOPED_TO_REF`/`USED_IN_IMPLEMENTATION` to each
   xdc file in the project.
2. `synth_design` → `open_run synth_1` (open the synthesized design).
3. **Source again** — this time it also validates: for each scoped xdc it reports how many
   instances of that `REF_NAME` actually exist in the netlist (a `0` means the constraint won't
   take effect — check the ref name / that the file made it into the project).
4. Proceed to implementation as normal.

It only matters for project-mode (GUI-driven) flows; a non-project batch script would instead use
`read_xdc -ref` after `synth_design`, which `emit_scoped_xdc.py` can also emit (`mode="batch"`,
not wired to the CLI by default — see `rtl_gen/dsp_multiplier/emit_scoped_xdc.py` if you need it).
