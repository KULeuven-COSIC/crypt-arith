#!/usr/bin/env python3
"""build_cmult.py — generate one constant multiplier's RTL from the model.

Produces a self-contained run directory for `P = A * C`: wrapper module,
compressor + XDC when the constant needs one, a self-checking testbench, and
hex testvectors whose goldens come from `NafConstMult.propagateValue`.

Layout produced for ``--scenario foo`` with ``--constant 12345``::

    work/foo/cmult_24x12345/
      RTL_generated/
        Cmult_24x12345.sv         wrapper
        Cmult_24x12345_cmp.sv     compressor  (compressor strategy only)
        Cmult_24x12345_tb.sv      self-checking testbench
      xdc_generated/
        Cmult_24x12345_cmp.xdc    placement constraints (compressor only)
      testvectors/
        A.txt, P.txt              hex, two's complement
      spec.json                   operator spec, for traceability

Run from the project root, e.g.::

    python scripts/build_cmult.py \\
        --scenario cmult_demo \\
        --constant 12345 --aIn-bound u24 \\
        --pipeline-stages 2 --test-size 1000 --seed 42

How this differs from ``versal_arith/cli.py -operator cmult``
-------------------------------------------------------------
The CLI is the standalone path: it takes a width and a constant and works
everything out itself. This script goes through the model, which means

  - the output port is sized from the **actual input interval**, not from the
    input width alone. ``--aIn-bound '[0,10000000]'`` times 3 is 25 bits here,
    26 through the CLI, because the CLI has to assume A fills its register;
  - known-zero low bits in the input bound are tracked and honoured when
    sampling testvectors;
  - goldens come from the model, so the same value path that sizes the datapath
    is the one being checked;
  - ``--check-heap`` can verify the emitted bit heap arithmetically before any
    simulator is involved.

Input bound syntax
------------------
  u24            unsigned 24-bit register, [0, 2^24-1]
  s66            signed 66-bit register, [-2^65, 2^65-1]
  [lo,hi]        explicit interval, e.g. '[0,10000000]' or '[-100,100]'
  [lo,hi,z]      explicit interval with z known-zero low bits
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
VERSAL_DIR = PROJECT_ROOT / "versal_arith"
DEFAULT_WORK_DIR = PROJECT_ROOT / "work"

sys.path.insert(0, str(PROJECT_ROOT))

from operator_modeling.core.IntType import IntType  # noqa: E402
from operator_modeling.core.utils import parseNafExpr  # noqa: E402

GOLDILOCKS_Q = 2 ** 64 - 2 ** 32 + 1

_REGISTER_RE = re.compile(r"^([su])(\d+)$")
_INTERVAL_RE = re.compile(r"^\[\s*(-?\d+)\s*,\s*(-?\d+)\s*(?:,\s*(\d+)\s*)?\]$")


def parse_bound(text: str) -> IntType:
    """Parse an input-bound spelling into an `IntType`."""
    m = _REGISTER_RE.match(text.strip())
    if m:
        signed, width = m.group(1) == "s", int(m.group(2))
        if width <= 0:
            raise SystemExit(f"--aIn-bound {text!r}: width must be positive")
        return IntType.signed(width) if signed else IntType.unsigned(width)

    m = _INTERVAL_RE.match(text.strip())
    if m:
        lo, hi = int(m.group(1)), int(m.group(2))
        zeroLsbs = int(m.group(3)) if m.group(3) else 0
        if lo > hi:
            raise SystemExit(f"--aIn-bound {text!r}: lo must not exceed hi")
        return IntType(lo, hi, zeroLsbs)

    raise SystemExit(
        f"--aIn-bound {text!r} not understood. Use u24 / s66 for a full "
        f"register, or [lo,hi] / [lo,hi,zeroLsbs] for an explicit interval."
    )


def main() -> None:
    p = argparse.ArgumentParser(
        description="Generate one constant multiplier's RTL from the model.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    p.add_argument("--scenario", required=True,
                   help="run-directory name under --work-dir")
    p.add_argument("--work-dir", default=str(DEFAULT_WORK_DIR),
                   help=f"root for run directories (default: {DEFAULT_WORK_DIR})")

    src = p.add_mutually_exclusive_group(required=True)
    src.add_argument("--constant", type=int,
                     help="the integer constant C to multiply by")
    src.add_argument("--constant-naf",
                     help="C as a NAF expression, e.g. '2^9 - 2^4 + 1'; "
                          "skips decomposition and lifting entirely")

    p.add_argument("--aIn-bound", required=True,
                   help="input bound: u24 / s66, or [lo,hi] / [lo,hi,zeroLsbs]")
    p.add_argument("--modulus", type=int, default=None,
                   help="lift C to a congruent value with a sparser NAF before "
                        "building hardware. Pass the Goldilocks prime as "
                        f"{GOLDILOCKS_Q} for NTT twiddles.")
    p.add_argument("--lift-max-terms", type=int, default=3,
                   help="NAF term budget for the lift (default: 3)")
    p.add_argument("--lift-max-power", type=int, default=96,
                   help="largest NAF exponent the lift may use (default: 96)")

    p.add_argument("--module-name", default=None,
                   help="override the emitted module name "
                        "(default: Cmult_<width>x<constant>)")
    p.add_argument("--pipeline-stages", type=int, default=1,
                   help="registers to distribute across the compressor tree "
                        "(default: 1). Clamped to the layer count.")
    p.add_argument("--test-size", type=int, default=1000,
                   help="testvectors to generate (default: 1000)")
    p.add_argument("--seed", type=int, default=None,
                   help="RNG seed for reproducible testvectors")
    p.add_argument("--sampling", default="bound", choices=("bound", "register"),
                   help="'bound' samples inside the modelled interval and "
                        "honours its zero LSBs (default); 'register' samples "
                        "the whole declared register")
    p.add_argument("--visualization", action="store_true",
                   help="emit bit-heap PNGs (compressor strategy only)")
    p.add_argument("--no-testbench", action="store_true",
                   help="skip testbench and testvector generation")
    p.add_argument("--backend", default="hw", choices=("hw", "sim"),
                   help="'hw' emits the Versal compressor-tree RTL (default)")
    p.add_argument("--check-heap", action="store_true",
                   help="arithmetically verify the emitted bit heap computes "
                        "A*C before any simulation")

    p.add_argument("--remote-sim", action="store_true",
                   help="after generating, stage to the V80 server and simulate")
    p.add_argument("--remote-server", default=None,
                   help="SSH alias of the V80 server (default: run_remote_sim's)")
    p.add_argument("--remote-root", default=None,
                   help="Vivado project root on the server")

    args = p.parse_args()

    if args.pipeline_stages < 1:
        raise SystemExit("--pipeline-stages must be >= 1")

    sys.path.insert(0, str(VERSAL_DIR))
    from operator_modeling.multiplier.ConstMultScheme import NafConstMult, defaultModuleName

    aIn = parse_bound(args.aIn_bound)
    if aIn.isZero:
        raise SystemExit("--aIn-bound resolves to the zero interval")

    constant = (parseNafExpr(args.constant_naf) if args.constant_naf
                else args.constant)
    if args.constant_naf and args.modulus is not None:
        print("[build_cmult] note: --constant-naf is already decomposed; "
              "--modulus is ignored")

    model = NafConstMult(
        name="cmult",
        constant=constant,
        aIn=aIn,
        modulus=None if args.constant_naf else args.modulus,
        liftMaxTerms=args.lift_max_terms,
        liftMaxPower=args.lift_max_power,
        verbose=True,
    )

    implemented, naf = model._liftConstant()
    module_name = args.module_name or defaultModuleName(aIn.bitWidth, implemented)
    run_dir = Path(args.work_dir) / args.scenario / module_name.lower()

    outBound = model.propagateBound()
    print(f"[build_cmult] A bound      : {aIn}")
    print(f"[build_cmult] C implemented: {implemented} ({len(naf)} NAF terms)")
    print(f"[build_cmult] P bound      : {outBound}")
    print(f"[build_cmult] strategy     : {model.strategy()} "
          f"(max column height {model.maxColumnHeight()})")
    print(f"[build_cmult] area estimate: {model.areaCost()[0]} LUT")

    model.checkTermContainment()
    if args.check_heap:
        model.checkHeapArithmetic(testSize=min(args.test_size, 256), seed=args.seed)
        print("[build_cmult] bit-heap arithmetic verified against A*C")

    meta = model.emitRtl(
        name=module_name,
        run_dir=run_dir,
        pipeline_stages=args.pipeline_stages,
        gen_testbench=not args.no_testbench,
        test_size=args.test_size,
        seed=args.seed,
        visualization=args.visualization,
        backend=args.backend,
        sampling=args.sampling,
    )

    spec = model.getOperatorInterface(module_name)
    with open(run_dir / "spec.json", "w", encoding="utf-8") as f:
        json.dump(spec.to_dict(), f, indent=2)

    print(f"[build_cmult] latency      : {meta['pipeline_latency']} cycles")
    print(f"[build_cmult] RTL          : {run_dir / 'RTL_generated'}")
    if not args.no_testbench:
        print(f"[build_cmult] testvectors  : {run_dir / 'testvectors'}")
    print(f"[build_cmult] spec         : {run_dir / 'spec.json'}")

    if args.remote_sim:
        if args.no_testbench:
            raise SystemExit("--remote-sim requires a testbench (omit --no-testbench)")
        cmd = [
            sys.executable,
            str(PROJECT_ROOT / "scripts" / "run_remote_sim.py"),
            "--run-dir", str(run_dir),
            "--pull-to", str(run_dir / "sim_remote"),
        ]
        if args.remote_server:
            cmd += ["--server", args.remote_server]
        if args.remote_root:
            cmd += ["--remote-root", args.remote_root]
        print(f"[build_cmult] kicking off remote sim (top={module_name})")
        rc = subprocess.run(cmd).returncode
        if rc != 0:
            raise SystemExit(f"[build_cmult] remote sim returned exit {rc}")


if __name__ == "__main__":
    main()
