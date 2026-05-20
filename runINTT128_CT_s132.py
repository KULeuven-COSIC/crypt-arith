"""End-to-end: cyclic CT inverse NTT128 with uniform 132-bit signed inputs.

CT direction inverse, cyclic (negacyclic=False — negacyclic inverse requires
GS). Twiddles computed via calculateInttTwiddles match twiddles.xlsx::
iNTT_TWIDDLES byte-for-byte.

CLI flags:
    --skip-sim     skip the V80 batch simulation step (jump to synth)
    --skip-synth   skip the V80 OOC synthesis step
"""
from __future__ import annotations

import argparse
import random
import subprocess
import sys
from math import log2
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
WORK_DIR     = PROJECT_ROOT / "work"
SCENARIO     = "intt_s132"
TOP_NAME     = "INTT_s132"
RUN_DIR_HW   = WORK_DIR / SCENARIO / TOP_NAME
RUN_DIR_SIM  = WORK_DIR / SCENARIO / f"{TOP_NAME}_sim"
TEST_SIZE    = 1000
SEED         = 0
PIPELINE     = 1


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--skip-sim", action="store_true")
    p.add_argument("--skip-synth", action="store_true")
    p.add_argument("--backend", default="hw", choices=("hw", "sim", "both"),
                   help="RTL backend: 'hw' (default), 'sim', or 'both'. See "
                        "runNTT128_GS_s130.py for details.")
    args = p.parse_args()

    # (backend, run_dir, top_name); sim namespaces its top with `_sim` so all
    # derived module/file names are distinct from the hw flavor.
    if args.backend == "hw":
        run_targets = [("hw", RUN_DIR_HW, TOP_NAME)]
    elif args.backend == "sim":
        run_targets = [("sim", RUN_DIR_SIM, f"{TOP_NAME}_sim")]
    else:
        run_targets = [("hw", RUN_DIR_HW, TOP_NAME),
                       ("sim", RUN_DIR_SIM, f"{TOP_NAME}_sim")]

    sys.path.insert(0, str(PROJECT_ROOT))
    from NTT_modeling.IntType import IntType
    from NTT_modeling.ButterflyScheme import GoldilocksSlice64
    from NTT_modeling.NTT import (FullyPipelinedINTT, calculateInttTwiddles,
                                  verifyIntt)

    q, n = 2**64 - 2**32 + 1, 128
    L    = int(log2(n))

    print(f"[runINTT128_CT_s132] computing cyclic CT INTT twiddles...")
    twiddles = calculateInttTwiddles(modulus=q, n=n, butterflyType='CT',
                                     negacyclic=False,
                                     useModulusLiftingNaf=True,
                                     maxNumberOfTerms=3)

    inst = FullyPipelinedINTT(name=TOP_NAME, n=n, q=q,
                              butterflyType='CT', twiddles=twiddles,
                              negacyclic=False)
    inst.setScheme([[GoldilocksSlice64(name=f'{TOP_NAME}_L{s}_p{p}',
                                       butterflyType='CT')
                     for p in range(n // 2)] for s in range(L)])

    bound132 = IntType(minValue=-(1 << 131), maxValue=(1 << 131) - 1)
    bounds   = [bound132] * n
    print(f"[runINTT128_CT_s132] driving all 128 inputs at uniform "
          f"bitWidth={bound132.bitWidth}, signed={bound132.isSigned}")

    inst.getInputsNatural(bounds)
    inst.compute()

    print(f"[runINTT128_CT_s132] verifying against Sage referenceIntt...")
    ok = verifyIntt(inst, batchSize=8, seed=SEED, inputBound=bounds, verbose=True)
    if not ok:
        raise SystemExit("Sage-reference verification failed; aborting before RTL emit")

    random.seed(SEED)
    batches = [[random.randint(b.minValue, b.maxValue) for _ in range(TEST_SIZE)]
               for b in bounds]

    # Re-drive inputs before every emit; emitRtl's inline sanity check
    # shortens testVectors, so each backend needs a fresh full-size state.
    for backend, run_dir, target_top in run_targets:
        inst.getInputsNatural(bounds)
        inst.getInputsNatural(batches)
        inst.compute()

        print(f"[runINTT128_CT_s132] emitting {backend} RTL into {run_dir} (top={target_top})")
        manifest = inst.emitRtl(topName=target_top,
                                run_dir=run_dir,
                                pipeline_stages_per_layer=PIPELINE,
                                gen_testbench=True,
                                backend=backend)
        print(f"[runINTT128_CT_s132] {backend}: layer_latency={manifest['layer_latency']}, "
              f"total_latency={manifest['total_latency']}")

    if args.skip_sim:
        print("[runINTT128_CT_s132] --skip-sim: not running remote sim")
    else:
        for backend, run_dir, target_top in run_targets:
            print(f"[runINTT128_CT_s132] kicking off remote sim ({backend}, top={target_top}) on remote V80 server")
            rc = subprocess.run([
                sys.executable,
                str(PROJECT_ROOT / "scripts" / "run_remote_sim.py"),
                "--run-dir", str(run_dir),
                "--top",     target_top,
            ]).returncode
            if rc != 0:
                raise SystemExit(f"remote sim ({backend}) returned exit {rc}")

    if args.skip_synth:
        print("[runINTT128_CT_s132] --skip-synth: not running remote synth")
    else:
        for backend, run_dir, target_top in run_targets:
            if backend != "hw":
                continue
            print(f"[runINTT128_CT_s132] kicking off remote OOC synth (top={target_top}) on remote V80 server")
            rc = subprocess.run([
                sys.executable,
                str(PROJECT_ROOT / "scripts" / "run_remote_synth.py"),
                "--run-dir", str(run_dir),
                "--top",     target_top,
            ]).returncode
            if rc != 0:
                raise SystemExit(f"remote synth returned exit {rc}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
