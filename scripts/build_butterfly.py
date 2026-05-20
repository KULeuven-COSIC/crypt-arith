#!/usr/bin/env python3
"""build_butterfly.py — bridge NTT_modeling and versal_arith for a single butterfly.

Produces a self-contained run directory for one Goldilocks-NTT butterfly
``(layer, position)``: wrapper module + two compressors + self-checking
testbench + hex testvectors driven by ``GoldilocksSlice64.propagateValue``
as the golden source.

Layout produced for ``--scenario foo``, layer 2, position 5::

    work/foo/butterfly_L2_p5/
      RTL_generated/
        Butterfly_n128_GS_L2_p5.sv          wrapper
        Butterfly_n128_GS_L2_p5_aOut_cmp.sv aOut compressor
        Butterfly_n128_GS_L2_p5_bOut_cmp.sv bOut compressor
        Butterfly_n128_GS_L2_p5_tb.sv       self-checking testbench
      xdc_generated/
        *_aOut_cmp.xdc, *_bOut_cmp.xdc      placement constraints
      testvectors/
        aIn.txt, bIn.txt, aOut.txt, bOut.txt  (hex, two's complement)
      bitheap_visualization/                  (when --visualization)
        aOut_*.png, bOut_*.png
      spec.json                               operator spec for traceability

Run from the project root, e.g.::

    python scripts/build_butterfly.py \\
        --scenario ntt128_GS \\
        --n 128 --butterfly-type GS \\
        --layer 2 --position 5 \\
        --twiddles-xlsx twiddles.xlsx \\
        --twiddles-sheet NTT_TWIDDLES \\
        --aIn-bound s66 --bIn-bound s66 \\
        --pipeline-stages 1 \\
        --test-size 1000 --seed 42

The two input bounds are independent — a butterfly's two operands routinely
have different bit widths and signedness in a real pipeline (e.g. layer 0
takes s66 and s96, downstream layers shrink). Pass each via its own flag.

Twiddle sources (mutually exclusive; pick one):

  --twiddles-xlsx PATH --twiddles-sheet SHEET
        Load NAF twiddles from a workbook produced by saveTwiddlesToXlsx
        (default sheet: NTT_TWIDDLES). Indexed by --layer / --position.

  --twiddle-naf '+2^43 -2^91'
        One-off NAF expression for the twiddle (parseNafExpr syntax).
        Skips xlsx loading entirely; useful for hand-picked test cases.

  --compute-twiddles --primitive-root N [--inverse]
        Compute the (possibly inverse) NTT twiddle grid via Sage and pick
        ``twiddles[layer][position]``. Always lifts via NAF modulus lifting
        with maxNumberOfTerms=3 (the GoldilocksSlice64 hardware constraint).

The script must be run inside the ntt-sage conda env (Sage is required for
calculateNttTwiddles and openpyxl is required for the xlsx loader).
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
NTT_MODELING_DIR = PROJECT_ROOT / "NTT_modeling"
VERSAL_DIR = PROJECT_ROOT / "versal_arith"
DEFAULT_XLSX = PROJECT_ROOT / "twiddles.xlsx"
DEFAULT_WORK_DIR = PROJECT_ROOT / "work"

# NTT_modeling is a real Python package (relative imports), so this path entry
# lets us do `from NTT_modeling.NTT import ...`. versal_arith uses unqualified
# imports (`from butterfly_spec import ...`), so we add ITS directory directly
# to sys.path — see the just-in-time insertion inside main().
sys.path.insert(0, str(PROJECT_ROOT))

from NTT_modeling.IntType import IntType  # noqa: E402
from NTT_modeling.utils import parseNafExpr  # noqa: E402
from NTT_modeling.ButterflyScheme import GoldilocksSlice64  # noqa: E402


GOLDILOCKS_Q = 2**64 - 2**32 + 1


# ---------------------------------------------------------------------------
# Argument parsing helpers
# ---------------------------------------------------------------------------

_BOUND_RE = re.compile(r"^([su])(\d+)$")


def parse_input_bound(s: str) -> IntType:
    """Parse 's66' / 'u32' style strings into an IntType.signed(W) / unsigned(W)."""
    m = _BOUND_RE.match(s.strip())
    if not m:
        raise SystemExit(
            f"--input-bound: expected 's<W>' or 'u<W>' (e.g. 's66'), got {s!r}"
        )
    kind, width = m.group(1), int(m.group(2))
    if width <= 0:
        raise SystemExit(f"--input-bound: bit-width must be positive, got {width}")
    return IntType.signed(width) if kind == "s" else IntType.unsigned(width)


def parse_twiddle_naf(naf_str: str) -> list[tuple[int, int]]:
    """Wrap parseNafExpr with a friendlier error and ensure the list is sorted
    by exponent ascending — matching what calculateNttTwiddles emits, so spec
    consumers can rely on a single canonical form."""
    try:
        terms = parseNafExpr(naf_str)
    except Exception as e:
        raise SystemExit(f"--twiddle-naf: failed to parse {naf_str!r}: {e}")
    terms.sort(key=lambda t: t[1])
    if not terms:
        raise SystemExit("--twiddle-naf: empty expression (zero twiddle is not supported)")
    return terms


# ---------------------------------------------------------------------------
# Twiddle resolution
# ---------------------------------------------------------------------------


def resolve_twiddle(
    args: argparse.Namespace,
) -> tuple[list[tuple[int, int]], str]:
    """Return (NAF list, source description). Exactly one twiddle source must
    be selected by the caller; argparse's mutually-exclusive group enforces
    this at parse time."""
    if args.twiddle_naf is not None:
        return parse_twiddle_naf(args.twiddle_naf), f"NAF expression {args.twiddle_naf!r}"

    if args.compute_twiddles:
        # Sage import deferred until we know we need it — the import is heavy
        # and unnecessary when the user is loading from xlsx.
        from NTT_modeling.NTT import calculateNttTwiddles, calculateInttTwiddles  # noqa: E402
        twiddleFn = calculateInttTwiddles if args.inverse else calculateNttTwiddles
        twiddles = twiddleFn(
            modulus=GOLDILOCKS_Q, n=args.n, butterflyType=args.butterfly_type,
            primitiveRoot=args.primitive_root,
            useModulusLiftingNaf=True, maxNumberOfTerms=3,
        )
        if args.layer >= len(twiddles) or args.position >= len(twiddles[args.layer]):
            raise SystemExit(
                f"--layer {args.layer} / --position {args.position} out of range "
                f"for n={args.n} (got {len(twiddles)} layers, "
                f"{len(twiddles[args.layer]) if twiddles else 0} positions per layer)"
            )
        naf = twiddles[args.layer][args.position]
        direction = "INTT" if args.inverse else "NTT"
        src = f"computed {direction} twiddle (primitive root {args.primitive_root}) at L{args.layer} p{args.position}"
        return list(naf), src

    # xlsx path
    from NTT_modeling.NTT import loadTwiddlesFromXlsx  # noqa: E402
    xlsx_path = Path(args.twiddles_xlsx).resolve()
    if not xlsx_path.is_file():
        raise SystemExit(f"--twiddles-xlsx not found: {xlsx_path}")
    twiddles = loadTwiddlesFromXlsx(str(xlsx_path), sheetName=args.twiddles_sheet)
    if args.layer >= len(twiddles):
        raise SystemExit(
            f"--layer {args.layer} out of range for sheet {args.twiddles_sheet!r} "
            f"(only {len(twiddles)} layers)"
        )
    if args.position >= len(twiddles[args.layer]):
        raise SystemExit(
            f"--position {args.position} out of range for layer {args.layer} "
            f"of sheet {args.twiddles_sheet!r} (only {len(twiddles[args.layer])} positions)"
        )
    naf = twiddles[args.layer][args.position]
    src = f"{xlsx_path}!{args.twiddles_sheet}[L{args.layer}][p{args.position}]"
    return list(naf), src


# ---------------------------------------------------------------------------
# Main — thin orchestrator around GoldilocksSlice64.emitRtl
# ---------------------------------------------------------------------------


def main() -> None:
    p = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=__doc__,
    )

    # Where to put things
    p.add_argument("--scenario", required=True,
                   help="name of the work-dir subfolder (e.g. ntt128_GS)")
    p.add_argument("--work-dir", default=str(DEFAULT_WORK_DIR),
                   help=f"root work directory (default: {DEFAULT_WORK_DIR})")

    # Butterfly identity
    p.add_argument("--n", type=int, required=True,
                   help="NTT size (must be a power of 2)")
    p.add_argument("--butterfly-type", required=True, choices=("CT", "GS"),
                   help="butterfly variant (CT or GS)")
    p.add_argument("--layer", type=int, required=True,
                   help="0-indexed pipeline stage")
    p.add_argument("--position", type=int, required=True,
                   help="0-indexed butterfly position within the stage")

    # Twiddle source — mutually exclusive
    src = p.add_mutually_exclusive_group()
    src.add_argument("--twiddle-naf",
                     help="one-off NAF expression like '+2^43 -2^91'; skips xlsx loading")
    src.add_argument("--compute-twiddles", action="store_true",
                     help="compute the twiddle grid via Sage (requires --primitive-root)")
    # xlsx path is the implicit default when neither --twiddle-naf nor --compute-twiddles is set
    p.add_argument("--twiddles-xlsx", default=str(DEFAULT_XLSX),
                   help=f"path to twiddles.xlsx (default: {DEFAULT_XLSX})")
    p.add_argument("--twiddles-sheet", default="NTT_TWIDDLES",
                   help="sheet name inside the xlsx (default: NTT_TWIDDLES)")

    # Sage-compute-only options
    p.add_argument("--primitive-root", type=int, default=None,
                   help="primitive root for --compute-twiddles (e.g. 17870292113338400769 for n=128)")
    p.add_argument("--inverse", action="store_true",
                   help="for --compute-twiddles: use calculateInttTwiddles (inverse NTT)")

    # Bound + RTL parameters
    p.add_argument("--aIn-bound", required=True,
                   help="aIn IntType bound, e.g. 's66' (signed 66-bit) or 'u32' (unsigned 32-bit). "
                        "Passed independently of --bIn-bound — the two ports routinely have "
                        "different widths/signedness in a real pipeline.")
    p.add_argument("--bIn-bound", required=True,
                   help="bIn IntType bound, e.g. 's66' or 'u32'. Independent of --aIn-bound.")
    p.add_argument("--pipeline-stages", type=int, default=1,
                   help="compressor pipeline stages (default: 1)")
    p.add_argument("--test-size", type=int, default=1000,
                   help="random testvectors to generate (default: 1000)")
    p.add_argument("--seed", type=int, default=None,
                   help="random seed for testvector generation (default: nondeterministic)")
    p.add_argument("--visualization", action="store_true",
                   help="emit per-output bit-heap PNGs (matplotlib required)")
    p.add_argument("--no-testbench", action="store_true",
                   help="skip testbench + testvector generation")
    p.add_argument("--backend", default="hw", choices=("hw", "sim", "both"),
                   help="RTL backend: 'hw' (compressor-tree, Versal-optimized; default), "
                        "'sim' (behavioral +/- sum, simulation-only — much faster sim, "
                        "byte-identical testvectors), or 'both' (emit hw at <run>/ and "
                        "sim at <run>_sim/ in one invocation). Remote sim runs on every "
                        "emitted flavor; remote synth runs on hw only.")

    # Remote simulation / synthesis control
    p.add_argument("--remote-sim", action="store_true",
                   help="after generation, stage onto the V80 server and run "
                        "Vivado batch simulation; pull verdict to "
                        "<run_dir>/sim_remote/")
    p.add_argument("--remote-synth", action="store_true",
                   help="after generation, stage onto the V80 server and run "
                        "Vivado out-of-context synthesis (using tcl/const.tcl "
                        "for the clock); pull reports to <run_dir>/synth_remote/. "
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
    if args.inverse and not args.compute_twiddles:
        raise SystemExit("--inverse only applies to --compute-twiddles")

    # 1. Resolve the twiddle (xlsx / NAF expression / Sage compute).
    twiddle_naf, twiddle_src = resolve_twiddle(args)
    if len(twiddle_naf) > 3:
        raise SystemExit(
            f"twiddle has {len(twiddle_naf)} NAF terms but GoldilocksSlice64 caps "
            f"at 3 (hardware constraint). Re-lift via --compute-twiddles or "
            f"hand-edit the xlsx cell."
        )
    print(f"[build_butterfly] twiddle: {twiddle_naf}  (source: {twiddle_src})")

    # 2. Construct + populate the GoldilocksSlice64 scheme.
    aIn = parse_input_bound(args.aIn_bound)
    bIn = parse_input_bound(args.bIn_bound)
    print(f"[build_butterfly] aIn bound: {args.aIn_bound}, bIn bound: {args.bIn_bound}")

    scheme = GoldilocksSlice64(
        name=f"scheme_n{args.n}_{args.butterfly_type}_L{args.layer}_p{args.position}",
        butterflyType=args.butterfly_type,
    )
    scheme.aIn = aIn
    scheme.bIn = bIn
    scheme.twiddle = twiddle_naf

    # 3. Run dir + dispatch to GoldilocksSlice64.emitRtl. The method handles
    #    spec extraction, random testvector sampling, propagateValue goldens,
    #    Butterfly_RTL_gen invocation with cwd inside run_dir, and the local
    #    twos-complement-encoding sanity check.
    base_run_dir = Path(args.work_dir).resolve() / args.scenario / f"butterfly_L{args.layer}_p{args.position}"
    base_spec = f"Butterfly_n{args.n}_{args.butterfly_type}_L{args.layer}_p{args.position}"
    if args.backend == "both":
        backends = [
            ("hw",  base_run_dir,                                       base_spec),
            ("sim", base_run_dir.with_name(base_run_dir.name + "_sim"), f"{base_spec}_sim"),
        ]
    elif args.backend == "sim":
        backends = [("sim", base_run_dir.with_name(base_run_dir.name + "_sim"), f"{base_spec}_sim")]
    else:
        backends = [("hw",  base_run_dir,                                       base_spec)]
    metas: list[tuple[str, Path, str, dict]] = []
    for backend, run_dir, target_spec in backends:
        meta = scheme.emitRtl(
            name=target_spec,
            run_dir=run_dir,
            pipeline_stages=args.pipeline_stages,
            gen_testbench=not args.no_testbench,
            test_size=args.test_size,
            seed=args.seed,
            visualization=args.visualization,
            backend=backend,
        )
        print(f"[build_butterfly] {backend} meta: {meta}")
        metas.append((backend, run_dir, target_spec, meta))

    # 4. Snapshot the spec for traceability (per backend, since module names differ).
    for backend, run_dir, target_spec, _ in metas:
        spec = scheme.getOperatorInterface(name=target_spec)
        spec_path = run_dir / "spec.json"
        spec_path.write_text(json.dumps(spec.to_dict(), indent=2) + "\n")
        print(f"[build_butterfly] wrote {spec_path}")

    print(f"[build_butterfly] done.")
    for backend, rd, _, _ in metas:
        print(f"  [{backend}] RTL: {rd / 'RTL_generated'}")
        if backend == "hw":
            print(f"  [{backend}] XDC: {rd / 'xdc_generated'}")
        if not args.no_testbench:
            print(f"  [{backend}] TBs/data: {rd / 'testvectors'}")
        if args.visualization and backend == "hw":
            print(f"  [{backend}] PNGs: {rd / 'bitheap_visualization'}")

    # 5. Optional remote simulation. Runs on every emitted flavor.
    if args.remote_sim:
        if args.no_testbench:
            raise SystemExit("--remote-sim requires a testbench (omit --no-testbench)")
        for backend, rd, target_spec, _ in metas:
            print(f"[build_butterfly] kicking off remote sim ({backend}, top={target_spec}) on {args.remote_server}")
            rc = subprocess.run([
                sys.executable,
                str(PROJECT_ROOT / "scripts" / "run_remote_sim.py"),
                "--run-dir",     str(rd),
                "--server",      args.remote_server,
                "--remote-root", args.remote_root,
                "--pull-to",     str(rd / "sim_remote"),
            ]).returncode
            if rc != 0:
                raise SystemExit(f"[build_butterfly] remote sim ({backend}) returned exit {rc}")

    # 6. Optional remote OOC synthesis. hw only — sim has no XDC.
    if args.remote_synth:
        for backend, rd, target_spec, _ in metas:
            if backend != "hw":
                continue
            print(f"[build_butterfly] kicking off remote OOC synth on {args.remote_server}")
            synth_cmd = [
                sys.executable,
                str(PROJECT_ROOT / "scripts" / "run_remote_synth.py"),
                "--run-dir",     str(rd),
                "--server",      args.remote_server,
                "--remote-root", args.remote_root,
                "--pull-to",     str(rd / "synth_remote"),
            ]
            if args.pull_dcp:
                synth_cmd.append("--pull-dcp")
            rc = subprocess.run(synth_cmd).returncode
            if rc != 0:
                raise SystemExit(f"[build_butterfly] remote synth returned exit {rc}")


if __name__ == "__main__":
    main()
