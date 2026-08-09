"""Inspect-only sibling of runNTT128_GS_after_pretwist.py.

Builds the same FullyPipelinedNTT instance (cyclic GS, n=128, post-pre-twist
input bounds), drives stage-0 inputs at the per-natural bounds from the
pre-twist bank's sidecar, runs bound propagation via .compute(), then prints
the natural-order output bit-widths and signedness from the populated spec.

Run:
    conda activate ntt-sage
    python checkNTT128_output_bounds.py
"""
from __future__ import annotations

import sys
from math import log2
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
BANK_BOUNDS  = PROJECT_ROOT / "work" / "pre_twist_NTT128" / "cmultbank" / "output_bounds.json"
TOP_NAME     = "NTT_n128_GS_after_pretwist"


def main() -> int:
    sys.path.insert(0, str(PROJECT_ROOT))
    from operator_modeling.core.IntType import loadBoundsJson
    from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64
    from operator_modeling.ntt.NTT import FullyPipelinedNTT, calculateNttTwiddles

    q, n = 2**64 - 2**32 + 1, 128
    L    = int(log2(n))

    twiddles = calculateNttTwiddles(modulus=q, n=n, butterflyType='GS',
                                    negacyclic=False,
                                    useModulusLiftingNaf=True,
                                    maxNumberOfTerms=3)

    inst = FullyPipelinedNTT(name=TOP_NAME, n=n, q=q,
                             butterflyType='GS', twiddles=twiddles,
                             negacyclic=False)
    inst.setScheme([[GoldilocksSlice64(name=f'{TOP_NAME}_L{s}_p{p}',
                                       butterflyType='GS')
                     for p in range(n // 2)] for s in range(L)])

    bounds = loadBoundsJson(str(BANK_BOUNDS))
    inst.getInputsNatural(bounds)
    inst.compute()

    spec = inst.getOperatorInterface(TOP_NAME)

    print(f"=== input bounds (length {len(spec.inputBitWidthsNatural)}) ===")
    in_widths = spec.inputBitWidthsNatural
    in_signed = spec.inputIsSignedNatural
    print(f"  distinct widths: {sorted(set(in_widths))}")
    print(f"  distinct signed: {sorted(set(in_signed))}")
    print(f"  all uniform? widths={len(set(in_widths))==1}, signed={len(set(in_signed))==1}")

    print(f"\n=== output bounds (length {len(spec.outputBitWidthsNatural)}) ===")
    out_widths = spec.outputBitWidthsNatural
    out_signed = spec.outputIsSignedNatural
    print(f"  distinct widths: {sorted(set(out_widths))}")
    print(f"  distinct signed: {sorted(set(out_signed))}")
    print(f"  all uniform? widths={len(set(out_widths))==1}, signed={len(set(out_signed))==1}")

    print(f"\n=== summary ===")
    if len(set(out_widths)) == 1 and len(set(out_signed)) == 1:
        w = out_widths[0]
        s = out_signed[0]
        kind = "signed (two's-complement)" if s else "unsigned"
        print(f"  All 128 outputs are {w}-bit {kind}.")
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
    return 0


if __name__ == "__main__":
    sys.exit(main())
