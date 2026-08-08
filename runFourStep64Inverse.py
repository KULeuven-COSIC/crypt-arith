"""Emulate the INVERSE half of the four-step NTT of size 2^12 = 64 x 64.

Mirror of ``runFourStep64.py``. Target chain::

    point-wise mult -> INTT64 #1 -> transpose -> inter-stage mult -> INTT64 #2 -> post-twist bank

with no modular reduction between stages, exactly as on the forward side.

Two structural differences from the forward harness:

  * **CT butterflies** (decimation-in-time) instead of GS, with twiddles from
    ``NewTwiddles.xlsx!INTT_TWIDDLES`` — verified to be the n=64 CT *inverse*
    cyclic grid at base w64^-1.
  * **The bank comes last.** On the forward side the pre-twist bank fed the
    first NTT64, so its output bounds set that NTT's input widths. Here the
    post-twist bank is fed *by* INTT64 #2, so the dependency runs the other
    way: INTT64 #2's output bound determines the bank's ``--width-a`` and its
    signedness. The bank is therefore generated after the pipeline is
    emulated, using the derived width.

Input-width chain (every step derived, never hard-coded):

  1. **Point-wise multiply** — worst case is the product of two forward NTT64
     outputs, so the forward pipeline's output bound squared. Sets INTT64 #1's
     input width.
  2. **Inter-stage multiply** — INTT64 #1's output times a 64-bit unsigned
     twiddle. Sets INTT64 #2's input width.
  3. **Post-twist bank** — driven at INTT64 #2's output bound.

Note ``FullyPipelinedINTT`` intentionally omits the 1/n scaling, while the
``POSTTWIST`` constants carry a 1/64. That is exactly what makes the composed
check below line up against ``referenceIntt(..., divideByN=True)``.

Run::

    conda activate ntt-sage
    python runFourStep64Inverse.py                        # emulate + verify
    python runFourStep64Inverse.py --emit-rtl --backend both
"""
from __future__ import annotations

import argparse
import json
import random
import subprocess
import sys
from math import log2
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(PROJECT_ROOT))

# Reuse the forward harness's helpers rather than duplicating them.
from runFourStep64 import (  # noqa: E402
    N, Q, PSI, W64, INTER_W, TEST_SIZE, SEED, PIPELINE, WORKBOOK, WORK_DIR,
    build_instance, width_span, interstage_bound,
)

SCENARIO      = "fourstep64_inv"
TOP_A         = "INTT64_A"      # fed by the point-wise multiply
TOP_B         = "INTT64_B"      # fed by the inter-stage multiply
BANK_SCENARIO = "fourstep64_posttwist"
BANK_DIR      = WORK_DIR / BANK_SCENARIO / "cmultbank"
BANK_BOUNDS   = BANK_DIR / "output_bounds.json"

# The forward half's final stage, rebuilt here only to obtain its output bound
# honestly instead of assuming s66.
FWD_INPUT_W = 130               # forward NTT64_B's input bound width


# ---------------------------------------------------------------------------
# Derived bounds
# ---------------------------------------------------------------------------

def forward_output_bound(IntType, twiddlesFwd):
    """Rebuild the forward pipeline's last stage (GS, s130 in) purely to read
    its output bound. Cheap, and keeps the point-wise product derived from the
    real forward result rather than a hard-coded s66."""
    bound = IntType.signed(FWD_INPUT_W)
    _, out = build_instance('fwd_probe', twiddlesFwd, [bound] * N,
                            butterflyType='GS', inverse=False)
    lo = min(b.minValue for b in out)
    hi = max(b.maxValue for b in out)
    return IntType(lo, hi)


def pointwise_bound(IntType, fwdOut):
    """Worst case of multiplying two forward NTT64 results point-wise."""
    return fwdOut * fwdOut


# ---------------------------------------------------------------------------
# Post-twist bank
# ---------------------------------------------------------------------------

def ensure_bank(IntType, inputBound, regen: bool = False) -> tuple[list, list[int]]:
    """Generate the post-twist bank at the derived input width if it is not
    already there, then return (per-index output bounds, lifted constants).

    POSTTWIST holds raw mod-q residues with no pre-lifted column, so the
    generator must do the NAF lift (--modulus). The input is INTT64 #2's
    output, which is signed — hence --signed-input."""
    from NTT_modeling.IntType import loadBoundsJson

    width = inputBound.bitWidth
    if regen or not BANK_BOUNDS.is_file():
        cmd = [
            sys.executable, str(PROJECT_ROOT / "scripts" / "build_bank.py"),
            "--scenario", BANK_SCENARIO,
            "--xlsx", str(WORKBOOK), "--sheet", "POSTTWIST",
            "--width-a", str(width),
            "--modulus", str(Q),
            "--pipeline-stages", str(PIPELINE),
            "--no-visualization",
        ]
        if inputBound.isSigned:
            cmd.append("--signed-input")
        print(f"[fourstep64inv] generating post-twist bank at "
              f"{'s' if inputBound.isSigned else 'u'}{width}:")
        print("  " + " ".join(cmd))
        rc = subprocess.run(cmd).returncode
        if rc != 0:
            raise SystemExit(f"build_bank.py returned exit {rc}")

    bounds = loadBoundsJson(str(BANK_BOUNDS))
    constants = [e["constant"] for e in json.loads(BANK_BOUNDS.read_text())]
    if len(bounds) != N:
        raise SystemExit(f"expected {N} bank entries, got {len(bounds)}")
    # POSTTWIST[i] should be (1/64) * psi^-i.
    invN = pow(N, Q - 2, Q)
    expected = [invN * pow(PSI, (-i) % (2 * N), Q) % Q for i in range(N)]
    bad = [i for i, c in enumerate(constants) if c % Q != expected[i]]
    if bad:
        raise SystemExit(
            f"post-twist constants are not (1/{N})*psi^-i mod q at indices "
            f"{bad[:8]}{'...' if len(bad) > 8 else ''}"
        )
    return bounds, constants


# ---------------------------------------------------------------------------
# Verification
# ---------------------------------------------------------------------------

def verify_composed_negacyclic_inverse(inst, bounds: list, constants: list[int],
                                       batch_size: int = 8) -> bool:
    """A cyclic CT INTT (which omits 1/n) followed by a post-twist of
    (1/n)*psi^-i is exactly the negacyclic inverse:

        (1/n) * psi^-i * sum_k y[k] * w^(-ik) = referenceIntt(y, negacyclic=True)

    So push random y through INTT64 #2, scale by the bank's actual lifted
    constants, and compare mod q against the Sage negacyclic inverse *with*
    divideByN=True. Mirror of the forward harness's composed check.
    """
    from NTT_modeling.NTT import referenceIntt

    random.seed(SEED)
    ys = [[random.randint(b.minValue, b.maxValue) for _ in range(batch_size)]
          for b in bounds]

    inst.getInputsNatural(bounds)
    inst.getInputsNatural(ys)
    inst.compute()
    _, goldenY = inst._extractGoldensNatural()   # [batch][natural index]

    fails = 0
    for b in range(batch_size):
        y = [ys[i][b] for i in range(N)]
        ref = referenceIntt(y, Q, primitiveRoot=PSI, negacyclic=True,
                            divideByN=True)
        for i in range(N):
            got = (goldenY[b][i] * constants[i]) % Q
            if got != ref[i]:
                fails += 1
                if fails <= 5:
                    print(f'    mismatch batch {b} index {i}: '
                          f'got {got}, ref {ref[i]}')
    total = batch_size * N
    print(f'  composed INTT64_B+post-twist vs negacyclic inverse: '
          f'{total - fails}/{total}')
    return fails == 0


# ---------------------------------------------------------------------------
# RTL emission
# ---------------------------------------------------------------------------

def emit(inst, top: str, bounds: list, backend: str, run_dir: Path) -> dict:
    """Emit one INTT64's RTL. Re-drives bounds + values first — emitRtl's
    inline sanity check shortens each port's testVector to sanity_check_size."""
    random.seed(SEED)
    batches = [[random.randint(b.minValue, b.maxValue) for _ in range(TEST_SIZE)]
               for b in bounds]
    inst.getInputsNatural(bounds)
    inst.getInputsNatural(batches)
    inst.compute()

    print(f'[fourstep64inv] emitting {backend} RTL for {top} -> {run_dir}')
    manifest = inst.emitRtl(topName=top, run_dir=run_dir,
                            pipeline_stages_per_layer=PIPELINE,
                            gen_testbench=True, backend=backend)
    print(f"[fourstep64inv]   layer_latency={manifest['layer_latency']}, "
          f"total_latency={manifest['total_latency']}")
    spec = inst.getOperatorInterface(name=top)
    (run_dir / 'spec.json').write_text(json.dumps(spec.to_dict(), indent=2) + '\n')
    return manifest


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--emit-rtl", action="store_true",
                   help="also generate RTL for both INTT64s (default: emulate only)")
    p.add_argument("--backend", default="sim", choices=("hw", "sim", "both"),
                   help="RTL backend when --emit-rtl is set (default: sim)")
    p.add_argument("--batch-size", type=int, default=8,
                   help="batches per verification pass (default: 8)")
    p.add_argument("--regen-bank", action="store_true",
                   help="regenerate the post-twist bank even if it exists")
    args = p.parse_args()

    from NTT_modeling.IntType import IntType
    from NTT_modeling.NTT import loadTwiddlesFromXlsx, verifyIntt

    print("=" * 78)
    print(f"four-step NTT4096 — INVERSE half, n={N}, q={Q}")
    print(f"  psi = {PSI}   w64 = {W64} = 2^{W64.bit_length() - 1}")
    print("=" * 78)

    twFwd = loadTwiddlesFromXlsx(str(WORKBOOK), sheetName='NTT_TWIDDLES')
    twInv = loadTwiddlesFromXlsx(str(WORKBOOK), sheetName='INTT_TWIDDLES')
    L = int(log2(N))
    for label, tw in (('NTT_TWIDDLES', twFwd), ('INTT_TWIDDLES', twInv)):
        if len(tw) != L or any(len(layer) != N // 2 for layer in tw):
            raise SystemExit(f"{label} is not {L} x {N // 2}")
    print(f"\n    twiddles: {WORKBOOK.name}!INTT_TWIDDLES, {L} layers x {N // 2} (CT inverse)")

    # ---- Point-wise multiply --------------------------------------------
    fwdOut = forward_output_bound(IntType, twFwd)
    pwBound = pointwise_bound(IntType, fwdOut)
    print(f"\n[1] forward NTT64 output   : {fwdOut.bitWidth} bits "
          f"({'signed' if fwdOut.isSigned else 'unsigned'})")
    print(f"    point-wise mult (x^2)  : {pwBound.bitWidth} bits "
          f"({'signed' if pwBound.isSigned else 'unsigned'})")
    print(f"    {pwBound}")

    # ---- INTT64 #1 --------------------------------------------------------
    boundsA = [pwBound] * N
    instA, outA = build_instance(TOP_A, twInv, boundsA,
                                 butterflyType='CT', inverse=True)
    print(f"\n[2] {TOP_A} (CT inverse cyclic): in {width_span(boundsA)} -> "
          f"out {width_span(outA)}")
    instA.showBounds()

    # ---- Inter-stage multiply --------------------------------------------
    interBound = interstage_bound(IntType, outA)
    print(f"\n[3] inter-stage multiply: out({TOP_A}) x u{INTER_W} -> "
          f"{interBound.bitWidth} bits "
          f"({'signed' if interBound.isSigned else 'unsigned'})")
    print(f"    {interBound}")

    # ---- INTT64 #2 --------------------------------------------------------
    boundsB = [interBound] * N
    instB, outB = build_instance(TOP_B, twInv, boundsB,
                                 butterflyType='CT', inverse=True)
    print(f"\n[4] {TOP_B} (CT inverse cyclic): in {width_span(boundsB)} -> "
          f"out {width_span(outB)}")
    instB.showBounds()

    # ---- Post-twist bank, at the derived width ---------------------------
    bankIn = IntType(min(b.minValue for b in outB), max(b.maxValue for b in outB))
    bankBounds, bankConstants = ensure_bank(IntType, bankIn, regen=args.regen_bank)
    print(f"\n[5] post-twist bank: in {'s' if bankIn.isSigned else 'u'}"
          f"{bankIn.bitWidth} -> out {width_span(bankBounds)}")
    print(f"    constants verified == (1/{N})*psi^-i mod q")

    # ---- Verification -----------------------------------------------------
    print("\n" + "=" * 78)
    print("verification (Sage references)")
    print("=" * 78)

    print(f"\n  [a] {TOP_A} standalone, cyclic inverse, primitiveRoot=w64")
    okA = verifyIntt(instA, primitiveRoot=W64, inputBound=boundsA,
                     batchSize=args.batch_size, seed=SEED, verbose=True)

    print(f"\n  [b] {TOP_B} standalone, cyclic inverse, primitiveRoot=w64")
    okB = verifyIntt(instB, primitiveRoot=W64, inputBound=boundsB,
                     batchSize=args.batch_size, seed=SEED, verbose=True)

    print(f"\n  [c] {TOP_B} + post-twist bank == negacyclic inverse (with 1/n)")
    okC = verify_composed_negacyclic_inverse(instB, boundsB, bankConstants,
                                             batch_size=args.batch_size)

    # ---- Width report -----------------------------------------------------
    print("\n" + "=" * 78)
    print("width report — inverse half")
    print("=" * 78)
    rows = [
        ("point-wise mult",   f"{fwdOut.bitWidth}b x {fwdOut.bitWidth}b",
                              f"{pwBound.bitWidth} bits (signed)"),
        (f"{TOP_A} (INTT64)", width_span(boundsA), width_span(outA)),
        ("inter-stage mult",  width_span(outA) + f" x u{INTER_W}",
                              f"{interBound.bitWidth} bits (signed)"),
        (f"{TOP_B} (INTT64)", width_span(boundsB), width_span(outB)),
        ("post-twist bank",   f"s{bankIn.bitWidth}", width_span(bankBounds)),
    ]
    w0 = max(len(r[0]) for r in rows)
    w1 = max(len(r[1]) for r in rows)
    print(f"  {'block'.ljust(w0)}  {'in'.ljust(w1)}  out")
    print(f"  {'-' * w0}  {'-' * w1}  {'-' * 34}")
    for name, i, o in rows:
        print(f"  {name.ljust(w0)}  {i.ljust(w1)}  {o}")

    if not (okA and okB and okC):
        print("\nVERIFICATION FAILED — not emitting RTL")
        return 1
    print("\nall three verifications passed")

    if args.emit_rtl:
        backends = ["hw", "sim"] if args.backend == "both" else [args.backend]
        for inst, top, bounds in ((instA, TOP_A, boundsA),
                                  (instB, TOP_B, boundsB)):
            for backend in backends:
                target = top if backend == "hw" else f"{top}_sim"
                emit(inst, target, bounds, backend,
                     WORK_DIR / SCENARIO / target)
    return 0


if __name__ == "__main__":
    sys.exit(main())
