#!/usr/bin/env python3
"""build_ntt.py — bridge operator_modeling and versal_arith for a full NTT/INTT pipeline.

Two modes:

  1. **Full NTT** (default): compose the entire log2(n) x n/2 butterfly grid
     into a top-level wrapper + self-checking testbench + per-butterfly XDCs +
     natural-order hex testvectors, with optional remote V80 simulation.

  2. **Per-butterfly debug** (``--debug-butterfly L P``): generate ONLY the
     butterfly at (layer, position), with its own testbench and testvectors —
     same as ``scripts/build_butterfly.py`` but with bounds and twiddle inferred
     from the populated NTT instance (no need to retype). Useful for isolating
     a failing butterfly.

Layout produced for ``--scenario foo --direction ntt --butterfly-type GS --n 128`` (full mode)::

    work/foo/NTT_n128_GS/
      RTL_generated/
        NTT_n128_GS.sv                                 top wrapper
        NTT_n128_GS_tb.sv                              top TB
        Butterfly_n128_GS_L<s>_p<p>.sv                 per-butterfly DUTs
        Butterfly_n128_GS_L<s>_p<p>_aOut_cmp.sv
        Butterfly_n128_GS_L<s>_p<p>_bOut_cmp.sv
      xdc_generated/
        Butterfly_n128_GS_L<s>_p<p>_{aOut,bOut}_cmp.xdc
      testvectors/
        x_in.txt        natural-order x[0..n-1] packed per cycle
        y_out.txt       natural-order y[0..n-1] packed per cycle (per-slot widths)
      manifest.json     pipeline latency, butterfly module list

Per-butterfly debug mode lands at::

    work/foo/butterflies/L<L>_p<P>/
      (same layout as scripts/build_butterfly.py)

Twiddle sources (mutually exclusive; pick one):

  --twiddles-xlsx PATH --twiddles-sheet SHEET
        Load NAF twiddles from a workbook produced by saveTwiddlesToXlsx
        (default sheet: NTT_TWIDDLES). Shape log2(n) x n/2.

  --compute-twiddles --primitive-root N
        Compute the (possibly inverse) NTT twiddle grid via Sage.

The script must be run inside the ntt-sage conda env (Sage required for
calculateNttTwiddles, openpyxl required for the xlsx loader).
"""

from __future__ import annotations

import argparse
import json
import os
import random
import re
import subprocess
import sys
from math import log2
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
NTT_MODELING_DIR = PROJECT_ROOT / "operator_modeling"
VERSAL_DIR = PROJECT_ROOT / "versal_arith"
SCRIPTS_DIR = PROJECT_ROOT / "scripts"
DEFAULT_XLSX = PROJECT_ROOT / "twiddles.xlsx"
DEFAULT_WORK_DIR = PROJECT_ROOT / "work"

sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(SCRIPTS_DIR))

from operator_modeling.core.IntType import IntType  # noqa: E402
from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64  # noqa: E402
from operator_modeling.ntt.NTT import (  # noqa: E402
    FullyPipelinedNTT, FullyPipelinedINTT,
    calculateNttTwiddles, calculateInttTwiddles, loadTwiddlesFromXlsx,
)

# Reuse the input-bound parser from build_butterfly.py.
import build_butterfly as bb  # noqa: E402


GOLDILOCKS_Q = 2**64 - 2**32 + 1


# ---------------------------------------------------------------------------
# Argument helpers
# ---------------------------------------------------------------------------

def parse_pipeline_stages(s: str, n_layers: int) -> list[int]:
    """Parse '--pipeline-stages 1' (broadcast to all layers) or '1,2,2,1,...'
    (per-layer list of length log2(n))."""
    parts = [p.strip() for p in s.split(",")]
    if len(parts) == 1:
        try:
            v = int(parts[0])
        except ValueError:
            raise SystemExit(f"--pipeline-stages: not an integer: {parts[0]!r}")
        if v < 1:
            raise SystemExit(f"--pipeline-stages: must be >= 1, got {v}")
        return [v] * n_layers
    if len(parts) != n_layers:
        raise SystemExit(
            f"--pipeline-stages: comma list must have length log2(n)={n_layers}, "
            f"got {len(parts)} entries"
        )
    try:
        out = [int(p) for p in parts]
    except ValueError:
        raise SystemExit(f"--pipeline-stages: non-integer entry in {s!r}")
    if any(v < 1 for v in out):
        raise SystemExit(f"--pipeline-stages: every entry must be >= 1, got {out}")
    return out


# ---------------------------------------------------------------------------
# Twiddle-grid resolution (whole grid, not single butterfly)
# ---------------------------------------------------------------------------

def resolve_twiddle_grid(args: argparse.Namespace) -> tuple[list, str]:
    """Return (twiddle grid shape log2(n) x n/2 of NAF lists, source description)."""
    if args.compute_twiddles:
        twiddleFn = calculateInttTwiddles if args.direction == "intt" else calculateNttTwiddles
        twiddles = twiddleFn(
            modulus=GOLDILOCKS_Q, n=args.n, butterflyType=args.butterfly_type,
            primitiveRoot=args.primitive_root, negacyclic=args.negacyclic,
            useModulusLiftingNaf=True, maxNumberOfTerms=3,
        )
        direction = "INTT" if args.direction == "intt" else "NTT"
        return twiddles, f"computed {direction} twiddle grid (primitive root {args.primitive_root})"

    xlsx_path = Path(args.twiddles_xlsx).resolve()
    if not xlsx_path.is_file():
        raise SystemExit(f"--twiddles-xlsx not found: {xlsx_path}")
    twiddles = loadTwiddlesFromXlsx(str(xlsx_path), sheetName=args.twiddles_sheet)
    return twiddles, f"{xlsx_path}!{args.twiddles_sheet}"


# ---------------------------------------------------------------------------
# Build a populated FullyPipelinedNTT / FullyPipelinedINTT
# ---------------------------------------------------------------------------

def build_populated_instance(args: argparse.Namespace, inputBound: IntType):
    twiddles, twiddle_src = resolve_twiddle_grid(args)
    klass = FullyPipelinedINTT if args.direction == "intt" else FullyPipelinedNTT
    inst_name = f"{'INTT' if args.direction == 'intt' else 'NTT'}{args.n}_{args.butterfly_type}"
    inst = klass(name=inst_name, n=args.n, q=GOLDILOCKS_Q,
                 butterflyType=args.butterfly_type, twiddles=twiddles,
                 negacyclic=args.negacyclic)
    L = int(log2(args.n))
    schemes = [[GoldilocksSlice64(name=f"{inst_name}_L{s}_p{p}_scheme",
                                   butterflyType=args.butterfly_type)
                for p in range(args.n // 2)] for s in range(L)]
    inst.setScheme(schemes)
    inst.getInputsNatural([inputBound] * args.n)
    inst.compute()
    print(f"[build_ntt] populated {inst_name}: twiddle source = {twiddle_src}")
    return inst, L


# ---------------------------------------------------------------------------
# Populate the instance's testVectors via propagateValue
# ---------------------------------------------------------------------------

def populate_testvectors(inst, n: int, inputBound: IntType,
                         test_size: int, seed: int | None) -> None:
    """Sample `test_size` random natural-order x batches inside `inputBound`,
    drive them into the populated instance, and run compute() so every
    stage-0 input port and final-stage output port carries a testVector.
    `inst.emitRtl` then reads those testVectors directly — the script no
    longer extracts or threads goldens explicitly."""
    if seed is not None:
        random.seed(seed)
    lo, hi = inputBound.minValue, inputBound.maxValue
    natural = [[random.randint(lo, hi) for _ in range(test_size)] for _ in range(n)]
    inst.getInputsNatural([inputBound] * n)
    inst.getInputsNatural(natural)
    inst.compute()


# ---------------------------------------------------------------------------
# Per-butterfly debug mode — same shape as build_butterfly.py but with bounds
# and twiddle pulled from the populated NTT instance.
# ---------------------------------------------------------------------------

def run_debug_butterfly(args: argparse.Namespace, inst, L: int,
                        layer: int, position: int,
                        pipeline_stages_per_layer: list[int]) -> None:
    if not (0 <= layer < L):
        raise SystemExit(f"--debug-butterfly: layer {layer} out of range [0, {L})")
    if not (0 <= position < args.n // 2):
        raise SystemExit(f"--debug-butterfly: position {position} out of range [0, {args.n // 2})")

    bfly = inst.butterflies[layer][position]
    if bfly.inputPortA.bound is None or bfly.inputPortB.bound is None:
        raise SystemExit("[build_ntt] debug-butterfly: input bounds not populated; was compute() run?")
    if bfly.twiddle is None:
        raise SystemExit("[build_ntt] debug-butterfly: butterfly has no twiddle assigned")
    print(f"[build_ntt] debug-butterfly L{layer} p{position}: "
          f"aIn={bfly.inputPortA.bound}, bIn={bfly.inputPortB.bound}, twiddle={bfly.twiddle}")

    # Build a fresh GoldilocksSlice64 populated with the target butterfly's bounds
    # + twiddle, then dispatch through scheme.emitRtl. The scheme on the populated
    # butterfly itself can't be reused directly because Butterfly.compute() leaves
    # its scheme.aIn/bIn as testVector lists (not IntType bounds).
    scheme = GoldilocksSlice64(
        name=f"scheme_n{args.n}_{args.butterfly_type}_L{layer}_p{position}",
        butterflyType=args.butterfly_type,
    )
    scheme.aIn = bfly.inputPortA.bound
    scheme.bIn = bfly.inputPortB.bound
    scheme.twiddle = bfly.twiddle

    base_dir = Path(args.work_dir).resolve() / args.scenario / "butterflies" / f"L{layer}_p{position}"
    base_spec = f"Butterfly_n{args.n}_{args.butterfly_type}_L{layer}_p{position}"
    if args.backend == "both":
        backends = [
            ("hw",  base_dir,                                       base_spec),
            ("sim", base_dir.with_name(base_dir.name + "_sim"),     f"{base_spec}_sim"),
        ]
    elif args.backend == "sim":
        backends = [("sim", base_dir.with_name(base_dir.name + "_sim"), f"{base_spec}_sim")]
    else:
        backends = [("hw",  base_dir,                                   base_spec)]
    metas: list[tuple[str, Path, str, dict]] = []
    for backend, run_dir, target_spec in backends:
        meta = scheme.emitRtl(
            name=target_spec,
            run_dir=run_dir,
            pipeline_stages=pipeline_stages_per_layer[layer],
            gen_testbench=True,
            test_size=args.test_size,
            seed=args.seed,
            visualization=args.visualization,
            backend=backend,
        )
        print(f"[build_ntt] debug-butterfly {backend} meta: {meta}")
        print(f"[build_ntt] debug-butterfly {backend} outputs at {run_dir}")
        metas.append((backend, run_dir, target_spec, meta))

    for backend, run_dir, target_spec, _ in metas:
        spec = scheme.getOperatorInterface(name=target_spec)
        (run_dir / "spec.json").write_text(json.dumps(spec.to_dict(), indent=2) + "\n")

    if args.remote_sim:
        for backend, run_dir, target_spec, _ in metas:
            print(f"[build_ntt] kicking off remote sim ({backend}, top={target_spec}) on {args.remote_server}")
            rc = subprocess.run([
                sys.executable,
                str(SCRIPTS_DIR / "run_remote_sim.py"),
                "--run-dir",     str(run_dir),
                "--server",      args.remote_server,
                "--remote-root", args.remote_root,
                "--pull-to",     str(run_dir / "sim_remote"),
            ]).returncode
            if rc != 0:
                raise SystemExit(f"[build_ntt] remote sim ({backend}) returned exit {rc}")

    if args.remote_synth:
        for backend, run_dir, target_spec, _ in metas:
            if backend != "hw":
                continue
            print(f"[build_ntt] kicking off remote OOC synth on {args.remote_server}")
            synth_cmd = [
                sys.executable,
                str(SCRIPTS_DIR / "run_remote_synth.py"),
                "--run-dir",     str(run_dir),
                "--server",      args.remote_server,
                "--remote-root", args.remote_root,
                "--pull-to",     str(run_dir / "synth_remote"),
            ]
            if args.pull_dcp:
                synth_cmd.append("--pull-dcp")
            rc = subprocess.run(synth_cmd).returncode
            if rc != 0:
                raise SystemExit(f"[build_ntt] remote synth returned exit {rc}")


# ---------------------------------------------------------------------------
# Full-NTT mode — thin orchestrator around FullyPipelinedNTT.emitRtl
# ---------------------------------------------------------------------------

def run_full_ntt(args: argparse.Namespace, inst, L: int, inputBound: IntType,
                 pipeline_stages_per_layer: list[int]) -> None:
    n = args.n
    direction_label = "INTT" if args.direction == "intt" else "NTT"
    top_name = f"{direction_label}_n{n}_{args.butterfly_type}"
    base_dir = Path(args.work_dir).resolve() / args.scenario / top_name
    # (backend, run_dir, top_name); sim namespaces its top with `_sim` so all
    # derived module/file names are distinct from hw.
    if args.backend == "both":
        backends = [
            ("hw",  base_dir,                                       top_name),
            ("sim", base_dir.with_name(base_dir.name + "_sim"),     f"{top_name}_sim"),
        ]
    elif args.backend == "sim":
        backends = [("sim", base_dir.with_name(base_dir.name + "_sim"), f"{top_name}_sim")]
    else:
        backends = [("hw",  base_dir,                                   top_name)]

    metas: list[tuple[str, Path, str, dict]] = []
    for backend, run_dir, target_top in backends:
        # Re-populate testVectors before every emitRtl: the previous call's
        # inline sanity check (`_sanityCheckNttTestvectors`) drives the
        # instance with only `sanity_check_size` batches and so leaves the
        # ports' testVectors shortened. The second emit would otherwise pick
        # up that shortened state and write fewer lines than `--test-size`.
        # Re-seeding with the same `args.seed` keeps the sampled inputs
        # byte-identical across the two backends.
        if not args.no_testbench:
            print(f"[build_ntt] sampling {args.test_size} testvector batches for {backend}...")
            populate_testvectors(inst, n, inputBound, args.test_size, args.seed)

        manifest = inst.emitRtl(
            topName=target_top,
            run_dir=run_dir,
            pipeline_stages_per_layer=pipeline_stages_per_layer,
            gen_testbench=not args.no_testbench,
            visualization=args.visualization,
            backend=backend,
        )
        print(f"[build_ntt] {backend} manifest: top={manifest['top_name']}, "
              f"layer_latency={manifest['layer_latency']}, "
              f"total_latency={manifest['total_latency']}")
        print(f"[build_ntt] {backend} outputs at {run_dir}")
        metas.append((backend, run_dir, target_top, manifest))

    # spec is per-target since `name` differs between hw and sim. Re-emit per target.
    for backend, run_dir, target_top, _ in metas:
        spec = inst.getOperatorInterface(name=target_top)
        (run_dir / "spec.json").write_text(json.dumps(spec.to_dict(), indent=2) + "\n")

    if args.remote_sim:
        if args.no_testbench:
            raise SystemExit("--remote-sim requires a testbench (omit --no-testbench)")
        for backend, run_dir, target_top, _ in metas:
            print(f"[build_ntt] kicking off remote sim ({backend}, top={target_top}) on {args.remote_server}")
            rc = subprocess.run([
                sys.executable,
                str(SCRIPTS_DIR / "run_remote_sim.py"),
                "--run-dir",     str(run_dir),
                "--server",      args.remote_server,
                "--remote-root", args.remote_root,
                "--pull-to",     str(run_dir / "sim_remote"),
                "--top",         target_top,
            ]).returncode
            if rc != 0:
                raise SystemExit(f"[build_ntt] remote sim ({backend}) returned exit {rc}")

    if args.remote_synth:
        for backend, run_dir, target_top, _ in metas:
            if backend != "hw":
                continue
            print(f"[build_ntt] kicking off remote OOC synth (top={target_top}) on {args.remote_server}")
            synth_cmd = [
                sys.executable,
                str(SCRIPTS_DIR / "run_remote_synth.py"),
                "--run-dir",     str(run_dir),
                "--server",      args.remote_server,
                "--remote-root", args.remote_root,
                "--pull-to",     str(run_dir / "synth_remote"),
                "--top",         target_top,
            ]
            if args.pull_dcp:
                synth_cmd.append("--pull-dcp")
            rc = subprocess.run(synth_cmd).returncode
            if rc != 0:
                raise SystemExit(f"[build_ntt] remote synth returned exit {rc}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    p = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=__doc__,
    )
    p.add_argument("--scenario", required=True,
                   help="name of the work-dir subfolder (e.g. ntt128_GS_run1)")
    p.add_argument("--work-dir", default=str(DEFAULT_WORK_DIR),
                   help=f"root work directory (default: {DEFAULT_WORK_DIR})")

    p.add_argument("--n", type=int, default=128,
                   help="NTT size (must be a power of 2; default: 128)")
    p.add_argument("--direction", required=True, choices=("ntt", "intt"),
                   help="forward NTT or inverse NTT")
    p.add_argument("--butterfly-type", required=True, choices=("CT", "GS"),
                   help="butterfly variant (CT or GS)")
    p.add_argument("--input-bound", required=True,
                   help="natural-order input bound, e.g. 's96' (signed 96-bit) or 'u32'")
    p.add_argument("--negacyclic", action="store_true",
                   help="negacyclic NTT (NWC); pairing forced: forward=CT, inverse=GS")
    p.add_argument("--primitive-root", type=int, default=None,
                   help="primitive root for --compute-twiddles (e.g. 17870292113338400769 for n=128)")

    src = p.add_mutually_exclusive_group()
    src.add_argument("--compute-twiddles", action="store_true",
                     help="compute the twiddle grid via Sage (requires --primitive-root)")
    p.add_argument("--twiddles-xlsx", default=str(DEFAULT_XLSX),
                   help=f"path to twiddles.xlsx (default: {DEFAULT_XLSX})")
    p.add_argument("--twiddles-sheet", default=None,
                   help="sheet name inside the xlsx (default: NTT_TWIDDLES for "
                        "--direction ntt, iNTT_TWIDDLES for --direction intt)")

    p.add_argument("--pipeline-stages", default="1",
                   help="per-layer compressor pipeline stages: single int (broadcast) "
                        "or comma list of length log2(n) (default: '1')")
    p.add_argument("--test-size", type=int, default=1000,
                   help="random testvectors to generate (default: 1000)")
    p.add_argument("--seed", type=int, default=None,
                   help="random seed for testvector generation (default: nondeterministic)")
    p.add_argument("--visualization", action="store_true",
                   help="emit per-output bit-heap PNGs (matplotlib required)")
    p.add_argument("--no-testbench", action="store_true",
                   help="skip TB + testvector generation (skeleton wrapper only)")
    p.add_argument("--backend", default="hw", choices=("hw", "sim", "both"),
                   help="RTL backend: 'hw' (compressor-tree, Versal-optimized; default), "
                        "'sim' (behavioral +/- sum, simulation-only — much faster sim, "
                        "byte-identical testvectors), or 'both' (emit hw at <run>/ and "
                        "sim at <run>_sim/ in one invocation). In sim mode every "
                        "butterfly module is concatenated into one '<top>_butterflies.sv'. "
                        "Remote sim runs on every emitted flavor; remote synth runs on "
                        "hw only.")

    p.add_argument("--debug-butterfly", nargs=2, type=int, metavar=("LAYER", "POSITION"),
                   help="debug mode: generate ONLY the butterfly at (LAYER, POSITION) "
                        "with full TB+testvectors+optional remote-sim. Bounds and twiddle "
                        "are inferred from the populated NTT instance.")

    p.add_argument("--remote-sim", action="store_true",
                   help="after generation, stage onto the V80 server and run "
                        "Vivado batch simulation; pull artifacts back")
    p.add_argument("--remote-synth", action="store_true",
                   help="after generation, stage onto the V80 server and run "
                        "Vivado out-of-context synthesis; pull reports back. "
                        "Sequential with --remote-sim (both share src/rtl/).")
    p.add_argument("--pull-dcp", action="store_true",
                   help="for --remote-synth: also rsync the multi-MB synth DCP "
                        "checkpoint back. Default off.")
    p.add_argument("--remote-server",
                   default=os.environ.get("V80_SERVER", "v80-server"),
                   help="SSH alias of the V80 server (default: $V80_SERVER or 'v80-server'; "
                        "configure in ~/.ssh/config)")
    p.add_argument("--remote-root",
                   default=os.environ.get("V80_REMOTE_ROOT", "~/AMD_V80_dev"),
                   help="path to the Vivado project on the server "
                        "(default: $V80_REMOTE_ROOT or '~/AMD_V80_dev')")

    args = p.parse_args()

    if args.compute_twiddles and args.primitive_root is None:
        raise SystemExit("--compute-twiddles requires --primitive-root")
    if args.n < 2 or (args.n & (args.n - 1)) != 0:
        raise SystemExit(f"--n must be a power of 2 >= 2, got {args.n}")
    if args.twiddles_sheet is None:
        args.twiddles_sheet = "iNTT_TWIDDLES" if args.direction == "intt" else "NTT_TWIDDLES"
    L = int(log2(args.n))
    pipeline_stages_per_layer = parse_pipeline_stages(args.pipeline_stages, L)
    print(f"[build_ntt] pipeline_stages_per_layer = {pipeline_stages_per_layer}")

    inputBound = bb.parse_input_bound(args.input_bound)
    print(f"[build_ntt] input bound: {args.input_bound} -> {inputBound}")

    inst, _ = build_populated_instance(args, inputBound)

    if args.debug_butterfly is not None:
        run_debug_butterfly(args, inst, L,
                            layer=args.debug_butterfly[0],
                            position=args.debug_butterfly[1],
                            pipeline_stages_per_layer=pipeline_stages_per_layer)
    else:
        run_full_ntt(args, inst, L, inputBound, pipeline_stages_per_layer)


if __name__ == "__main__":
    main()
