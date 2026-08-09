"""Inspect-only sibling of runNTT128_GS_s130.py.

Builds the same FullyPipelinedNTT instance (cyclic GS, n=128, uniform s130
inputs), drives stage-0 inputs at IntType(-2^129, 2^129-1), runs bound
propagation via .compute(), then prints the natural-order output
bit-widths and signedness from the populated spec.

Run:
    conda activate ntt-sage
    python checkNTT128_s130_output_bounds.py
"""
from __future__ import annotations

import sys
from math import log2
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
TOP_NAME     = "NTT_s130"


def main() -> int:
    sys.path.insert(0, str(PROJECT_ROOT))
    from operator_modeling.core.IntType import IntType
    from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64
    from operator_modeling.ntt.NTT import FullyPipelinedNTT
    from operator_modeling.ntt.twiddles import calculateNttTwiddles

    q, n = 2**64 - 2**32 + 1, 128
    L    = int(log2(n))

    twiddles = calculateNttTwiddles(q, n, 'GS', negacyclic=False,
                                    useModulusLiftingNaf=True, maxNumberOfTerms=3)

    inst = FullyPipelinedNTT(name=TOP_NAME, n=n, q=q,
                             butterflyType='GS', twiddles=twiddles,
                             negacyclic=False)
    inst.setScheme([[GoldilocksSlice64(name=f'{TOP_NAME}_L{s}_p{p}',
                                       butterflyType='GS')
                     for p in range(n // 2)] for s in range(L)])

    bound130 = IntType(minValue=-(1 << 129), maxValue=(1 << 129) - 1)
    bounds = [bound130] * n

    inst.getInputsNatural(bounds)
    inst.compute()
    spec = inst.getOperatorInterface(TOP_NAME)

    in_widths = spec.inputBitWidthsNatural
    in_signed = spec.inputIsSignedNatural
    print(f"=== input bounds (length {len(in_widths)}) ===")
    print(f"  distinct widths: {sorted(set(in_widths))}")
    print(f"  distinct signed: {sorted(set(in_signed))}")

    out_widths = spec.outputBitWidthsNatural
    out_signed = spec.outputIsSignedNatural
    print(f"\n=== output bounds (length {len(out_widths)}) ===")
    print(f"  distinct widths: {sorted(set(out_widths))}")
    print(f"  distinct signed: {sorted(set(out_signed))}")
    print(f"  all uniform? widths={len(set(out_widths))==1}, signed={len(set(out_signed))==1}")

    print(f"\n=== summary ===")
    if len(set(out_widths)) == 1 and len(set(out_signed)) == 1:
        w = out_widths[0]
        s = out_signed[0]
        kind = "signed (two's-complement)" if s else "unsigned"
        print(f"  All {n} outputs are {w}-bit {kind}.")
    else:
        print("  Per-index breakdown (first 16):")
        for i in range(min(16, n)):
            print(f"    y_out_{i:3d}: {out_widths[i]}-bit "
                  f"{'signed' if out_signed[i] else 'unsigned'}")

    print(f"\n=== sample raw IntType bounds (first 4 natural outputs) ===")
    final_layer = inst.butterflies[-1]
    for nat_idx in range(4):
        for p, (natA, natB) in enumerate(spec.outputWiring):
            if natA == nat_idx:
                bf, port = final_layer[p], 'A'; break
            if natB == nat_idx:
                bf, port = final_layer[p], 'B'; break
        bound = bf.outputPortA.bound if port == 'A' else bf.outputPortB.bound
        print(f"  y[{nat_idx}] (layer={L-1}, p={p}, port={port}): {bound}")

    # ------------------------------------------------------------------
    # Empirical verification with random s130 testvectors
    # ------------------------------------------------------------------
    import random
    from operator_modeling.ntt.verification import verifyNtt
    BATCH = 1000
    SEED  = 0
    print(f"\n=== verifyNtt with {BATCH} random s130 testvectors ===")
    print(f"  (Sage referenceNtt + Python pipeline propagateValue;")
    print(f"   checks mod-q equality AND bound containment per port)")
    ok = verifyNtt(inst, batchSize=BATCH, seed=SEED, inputBound=bounds, verbose=True)
    if not ok:
        print("  ❌ verifyNtt FAILED")
        return 1

    # Drive the same batches and inspect the actual output range.
    random.seed(SEED)
    batches = [[random.randint(b.minValue, b.maxValue) for _ in range(BATCH)]
               for b in bounds]
    inst.getInputsNatural(bounds)
    inst.getInputsNatural(batches)
    inst.compute()

    # Final-layer outputs in natural-order.
    overall_min, overall_max = None, None
    overflow_count = 0
    BOUND_LO, BOUND_HI = -(1 << 64), (1 << 64)   # [-2^64, +2^64]
    for nat_idx in range(n):
        for p, (natA, natB) in enumerate(spec.outputWiring):
            if natA == nat_idx:
                bf, port = final_layer[p], 'A'; break
            if natB == nat_idx:
                bf, port = final_layer[p], 'B'; break
        tv = bf.outputPortA.testVector if port == 'A' else bf.outputPortB.testVector
        lo, hi = min(tv), max(tv)
        if overall_min is None or lo < overall_min: overall_min = lo
        if overall_max is None or hi > overall_max: overall_max = hi
        for v in tv:
            if v < BOUND_LO or v > BOUND_HI:
                overflow_count += 1

    print(f"\n=== empirical output range across {BATCH} testvectors x {n} slots = "
          f"{BATCH * n} samples ===")
    print(f"  min: {overall_min} ≈ -2^{(-overall_min).bit_length() if overall_min < 0 else 0}")
    print(f"  max: {overall_max} ≈ +2^{overall_max.bit_length()}")
    print(f"  predicted bound [-2^64, +2^64] = [{BOUND_LO}, {BOUND_HI}]")
    print(f"  samples outside bound: {overflow_count} / {BATCH * n}")
    if overflow_count == 0:
        print(f"  ✅ all {BATCH * n} output samples fit in s66 [-2^64, +2^64]")
    return 0


if __name__ == "__main__":
    sys.exit(main())
