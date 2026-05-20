"""End-to-end: cyclic GS forward NTT128 driven by the pre-twist bank's
output_bounds.json. Generates RTL via FullyPipelinedNTT.emitRtl, then
optionally chains to V80 batch simulation and OOC synthesis.

Decomposition: negacyclic NTT = standalone pre-twist bank · cyclic NTT.
With the pre-twist applied externally, the inner NTT is plain cyclic
(`negacyclic=False`) and any topology is valid — we use GS DIF here.

Wrapper boundary: both `x_in_<i>` and `y_out_<i>` are natural-order
indexed, so:
  - bank's `P_<i>` (= x[i]·ψ^i, natural order) → NTT `x_in_<i>` is a
    direct one-to-one wiring;
  - NTT `y_out_<i>` = Y[i] in natural order (no downstream bit-reverse).

Precondition: work/pre_twist_NTT128/cmultbank/output_bounds.json exists.
Generate it via:
    python scripts/build_bank.py --scenario pre_twist_NTT128 \\
        --sheet PRE_TWIST --column simple --width-a 24 --pipeline-stages 1

CLI flags:
    --skip-sim     skip the V80 batch simulation step (jump to synth)
    --skip-synth   skip the V80 OOC synthesis step
Default: both run sequentially (sim then synth — they share src/rtl/).
"""
from __future__ import annotations

import argparse
import os
import random
import subprocess
import sys
from math import log2
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
BANK_BOUNDS  = PROJECT_ROOT / "work" / "pre_twist_NTT128" / "cmultbank" / "output_bounds.json"
WORK_DIR     = PROJECT_ROOT / "work"
SCENARIO     = "ntt_pretwist"
TOP_NAME     = "NTT_pretwist"
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
    from NTT_modeling.IntType import loadBoundsJson
    from NTT_modeling.ButterflyScheme import GoldilocksSlice64
    from NTT_modeling.NTT import FullyPipelinedNTT, calculateNttTwiddles, verifyNtt

    if not BANK_BOUNDS.is_file():
        raise SystemExit(
            f"missing {BANK_BOUNDS}. Generate the pre-twist bank first via:\n"
            f"  python scripts/build_bank.py --scenario pre_twist_NTT128 \\\n"
            f"      --sheet PRE_TWIST --column simple --width-a 24 --pipeline-stages 1"
        )

    q, n = 2**64 - 2**32 + 1, 128
    L    = int(log2(n))

    # 1. Cyclic GS twiddles. negacyclic=False because the pre-twist is
    #    standalone — the per-stage twiddles do NOT carry the ψ^stepExp
    #    pre-twist factor.
    print(f"[runNTT128_GS_after_pretwist] computing cyclic GS twiddles...")
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

    # 3. Per-natural-input bounds from the pre-twist bank's sidecar — feeds
    #    each natural-order x_in_<i> at exactly its bank-output width.
    bounds = loadBoundsJson(str(BANK_BOUNDS))
    if len(bounds) != n:
        raise SystemExit(f"expected {n} bounds, got {len(bounds)} from {BANK_BOUNDS}")
    widths = sorted({b.bitWidth for b in bounds})
    print(f"[runNTT128_GS_after_pretwist] loaded {len(bounds)} bounds; "
          f"{len(widths)} distinct widths, range {widths[0]}..{widths[-1]}")

    inst.getInputsNatural(bounds)
    inst.compute()

    # 4a. Sage-reference verification against `referenceNtt` (cyclic).
    #     verifyNtt now accepts list[IntType] for per-natural-index bounds —
    #     samples each x[i] within its own pre-twist-derived bound.
    print(f"[runNTT128_GS_after_pretwist] verifying against Sage referenceNtt...")
    ok = verifyNtt(inst, batchSize=8, seed=SEED, inputBound=bounds, verbose=True)
    if not ok:
        raise SystemExit(
            "Sage-reference verification failed; aborting before RTL emit"
        )

    # 4b. Random batches inside each per-natural input bound — built once with
    #     a fixed seed so both backends see identical input rows.
    random.seed(SEED)
    batches = [[random.randint(b.minValue, b.maxValue) for _ in range(TEST_SIZE)]
               for b in bounds]

    # 5. RTL emission via the populated-instance method. Spec extraction,
    #    golden read-out from populated ports, sanity check — all internal.
    #    Re-drive getInputsNatural + compute() before every emit; the inline
    #    sanity check inside emitRtl shortens testVectors to sanity_check_size.
    for backend, run_dir, target_top in run_targets:
        inst.getInputsNatural(bounds)
        inst.getInputsNatural(batches)
        inst.compute()

        print(f"[runNTT128_GS_after_pretwist] emitting {backend} RTL into {run_dir} (top={target_top})")
        manifest = inst.emitRtl(topName=target_top,
                                run_dir=run_dir,
                                pipeline_stages_per_layer=PIPELINE,
                                gen_testbench=True,
                                backend=backend)
        print(f"[runNTT128_GS_after_pretwist] {backend}: "
              f"layer_latency={manifest['layer_latency']}, "
              f"total_latency={manifest['total_latency']}")

    # 6. V80 batch sim (skip with --skip-sim). Sequential per backend; both
    #    flavors share src/rtl/ on the server.
    if args.skip_sim:
        print("[runNTT128_GS_after_pretwist] --skip-sim: not running remote sim")
    else:
        for backend, run_dir, target_top in run_targets:
            print(f"[runNTT128_GS_after_pretwist] kicking off remote sim ({backend}, top={target_top}) on remote V80 server")
            rc = subprocess.run([
                sys.executable,
                str(PROJECT_ROOT / "scripts" / "run_remote_sim.py"),
                "--run-dir", str(run_dir),
                "--top",     target_top,
            ]).returncode
            if rc != 0:
                raise SystemExit(f"remote sim ({backend}) returned exit {rc}")

    # 7. V80 OOC synthesis (skip with --skip-synth). hw only — the sim
    #    backend has no XDC and is not intended for synthesis.
    if args.skip_synth:
        print("[runNTT128_GS_after_pretwist] --skip-synth: not running remote synth")
    else:
        for backend, run_dir, target_top in run_targets:
            if backend != "hw":
                continue
            print(f"[runNTT128_GS_after_pretwist] kicking off remote OOC synth (top={target_top}) on remote V80 server")
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
