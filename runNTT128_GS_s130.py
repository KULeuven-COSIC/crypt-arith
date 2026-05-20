"""End-to-end: cyclic GS forward NTT128 with uniform 130-bit signed inputs.

Sibling of `runNTT128_GS_after_pretwist.py`. Same cyclic-GS topology and
twiddles; the only difference is the input-bound source — instead of
loading the per-natural pre-twist bank widths from `output_bounds.json`,
every natural-order x_in_<i> is driven from a uniform s130 bound
`[-2^129, 2^129 - 1]`.

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
SCENARIO     = "ntt_s130"
TOP_NAME     = "NTT_s130"
RUN_DIR_HW   = WORK_DIR / SCENARIO / TOP_NAME
RUN_DIR_SIM  = WORK_DIR / SCENARIO / f"{TOP_NAME}_sim"
TEST_SIZE    = 1000
SEED         = 0
PIPELINE     = 1            # broadcast to every layer (length log2(n))


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--skip-sim", action="store_true",
                   help="skip the V80 batch simulation step (jump straight to synth)")
    p.add_argument("--skip-synth", action="store_true",
                   help="skip the V80 OOC synthesis step")
    p.add_argument("--backend", default="hw", choices=("hw", "sim", "both"),
                   help="RTL backend: 'hw' (compressor-tree, synthesisable; default), "
                        "'sim' (behavioral simulation-only, faster sim, byte-identical "
                        "testvectors, lands at <RUN_DIR>_sim/), or 'both' (emit both "
                        "into <RUN_DIR>/ and <RUN_DIR>_sim/). Remote sim runs on every "
                        "emitted flavor; remote synth runs on hw only.")
    args = p.parse_args()

    # Per-target tuple: (backend, run_dir, top_name). Sim flavor namespaces its
    # top name with a `_sim` suffix so every derived SV module / file name
    # (top wrapper, butterfly modules, consolidated `_butterflies.sv`, TB) is
    # distinguishable from the hw flavor — required when adding both flavors
    # to one Vivado project, useful for shell grep, and makes the chained
    # `--top` arg to run_remote_sim.py unambiguous.
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
    from NTT_modeling.NTT import FullyPipelinedNTT, calculateNttTwiddles, verifyNtt

    q, n = 2**64 - 2**32 + 1, 128
    L    = int(log2(n))

    # 1. Cyclic GS twiddles (identical to the post-pre-twist run).
    print(f"[runNTT128_GS_s130] computing cyclic GS twiddles...")
    twiddles = calculateNttTwiddles(modulus=q, n=n, butterflyType='GS',
                                    negacyclic=False,
                                    useModulusLiftingNaf=True,
                                    maxNumberOfTerms=3)

    # 2. Build + populate the pipeline.
    inst = FullyPipelinedNTT(name=TOP_NAME, n=n, q=q,
                             butterflyType='GS', twiddles=twiddles,
                             negacyclic=False)
    inst.setScheme([[GoldilocksSlice64(name=f'{TOP_NAME}_L{s}_p{p}',
                                       butterflyType='GS')
                     for p in range(n // 2)] for s in range(L)])

    # 3. Uniform 130-bit signed input on every natural-order index.
    bound130 = IntType(minValue=-(1 << 129), maxValue=(1 << 129) - 1)
    bounds   = [bound130] * n
    print(f"[runNTT128_GS_s130] driving all 128 inputs at uniform "
          f"bitWidth={bound130.bitWidth}, signed={bound130.isSigned}")

    inst.getInputsNatural(bounds)
    inst.compute()

    # 4a. Sage-reference verification — feed the same s130 bound to verifyNtt.
    print(f"[runNTT128_GS_s130] verifying against Sage referenceNtt...")
    ok = verifyNtt(inst, batchSize=8, seed=SEED, inputBound=bounds, verbose=True)
    if not ok:
        raise SystemExit("Sage-reference verification failed; aborting before RTL emit")

    # 4b. Random batches inside the s130 bound — built once with a fixed seed so
    #     both backends see the exact same input rows.
    random.seed(SEED)
    batches = [[random.randint(b.minValue, b.maxValue) for _ in range(TEST_SIZE)]
               for b in bounds]

    # 5. RTL emission via the populated-instance method (once per backend).
    #    Re-drive getInputsNatural + compute() before every emit: the previous
    #    call's inline sanity check (`_sanityCheckNttTestvectors`) drives the
    #    instance with only sanity_check_size batches and shortens every
    #    port's testVector. Re-driving from `batches` (same fixed list)
    #    restores the full TEST_SIZE state and keeps the two emits identical.
    for backend, run_dir, target_top in run_targets:
        inst.getInputsNatural(bounds)
        inst.getInputsNatural(batches)
        inst.compute()

        print(f"[runNTT128_GS_s130] emitting {backend} RTL into {run_dir} (top={target_top})")
        manifest = inst.emitRtl(topName=target_top,
                                run_dir=run_dir,
                                pipeline_stages_per_layer=PIPELINE,
                                gen_testbench=True,
                                backend=backend)
        print(f"[runNTT128_GS_s130] {backend}: layer_latency={manifest['layer_latency']}, "
              f"total_latency={manifest['total_latency']}")

    # 6. V80 batch sim (skip with --skip-sim). Runs sequentially on every
    #    emitted flavor — both hw and sim share src/rtl/ on the server, so
    #    they can't run concurrently anyway.
    if args.skip_sim:
        print("[runNTT128_GS_s130] --skip-sim: not running remote sim")
    else:
        for backend, run_dir, target_top in run_targets:
            print(f"[runNTT128_GS_s130] kicking off remote sim ({backend}, top={target_top}) on remote V80 server")
            rc = subprocess.run([
                sys.executable,
                str(PROJECT_ROOT / "scripts" / "run_remote_sim.py"),
                "--run-dir", str(run_dir),
                "--top",     target_top,
            ]).returncode
            if rc != 0:
                raise SystemExit(f"remote sim ({backend}) returned exit {rc}")

    # 7. V80 OOC synthesis (skip with --skip-synth). Sequential after sim.
    #    Only meaningful for hw; the sim backend's behavioral arithmetic is
    #    not intended for synthesis and has no XDC.
    if args.skip_synth:
        print("[runNTT128_GS_s130] --skip-synth: not running remote synth")
    else:
        for backend, run_dir, target_top in run_targets:
            if backend != "hw":
                continue
            print(f"[runNTT128_GS_s130] kicking off remote OOC synth (top={target_top}) on remote V80 server")
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
