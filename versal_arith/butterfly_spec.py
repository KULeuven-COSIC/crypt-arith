"""Cross-subproject contract for the butterfly RTL generator.

`SliceTerm` and `ButterflyOperatorSpec` are pure-data dataclasses defined
once and shared between two consumers:

  - `operator_modeling.ntt.ButterflyScheme.GoldilocksSlice64.getOperatorInterface`
    populates a `ButterflyOperatorSpec` from a butterfly scheme that has
    already had its input bounds set (so input bit widths and signedness
    are known).

  - `versal_arith.rtl_gen.butterfly.Butterfly_RTL_gen` (added in a later
    step of this project) consumes the spec and emits SystemVerilog plus
    XDC plus a self-checking testbench.

The file lives at the top level of `versal_arith/` so importing it does
NOT trigger `rtl_gen/__init__.py`'s import chain (which pulls in every
operator generator). Both subprojects can load this module cheaply.

A `SliceTerm` records one signed-shifted-slice contribution to one of
the butterfly's two outputs. The mathematical interpretation is:

    contribution = sign * ( ((source << inputShift)[sliceEnd:sliceStart])
                            << limbShift )

where `source` is one of the input registers (`'aIn'`, `'bIn'`) or a
baked-in constant (the `-q` lazy-reduction term). `isSigned` records
whether the slice came from `IntType.slice`'s signed (third) branch, in
which case the bit-heap construction in step 2 must sign-extend the
slice's MSB up to the output width.
"""
from __future__ import annotations
from dataclasses import dataclass, asdict
from typing import Any


@dataclass(frozen=True)
class SliceTerm:
    source: str          # 'aIn' | 'bIn' | 'const'
    inputShift: int      # left-shift applied to the source before slicing (NAF exponent for shifted inputs; 0 otherwise)
    sliceStart: int      # inclusive bit position in the shifted-source value where the slice starts
    sliceEnd: int        # inclusive bit position where the slice ends
    isSigned: bool       # True iff the slice covers the source's full bitWidth (IntType.slice 3rd branch)
    limbShift: int       # 0 or 32 — the shift baked in by the limbs64 limb-factor table
    sign: int            # +1 or -1 — combined outer sign (limb-factor sign times any per-term NAF sign)
    constValue: int = 0  # only meaningful when source == 'const' (e.g. q for the -q lazy-reduction term)

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)

    @staticmethod
    def from_dict(d: dict[str, Any]) -> SliceTerm:
        return SliceTerm(**d)


@dataclass(frozen=True)
class ButterflyOperatorSpec:
    name: str                                 # e.g. 'Butterfly_n128_GS_L2_p5'
    butterflyType: str                        # 'CT' | 'GS'
    q: int
    aInBitWidth: int
    aInIsSigned: bool
    bInBitWidth: int
    bInIsSigned: bool
    aOutBitWidth: int
    aOutIsSigned: bool
    bOutBitWidth: int
    bOutIsSigned: bool
    liftedTwiddleNaf: list[tuple[int, int]]   # [(sign, exponent), ...]; ≤ 3 terms for GoldilocksSlice64
    aOutTerms: list[SliceTerm]
    bOutTerms: list[SliceTerm]

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'butterflyType': self.butterflyType,
            'q': self.q,
            'aInBitWidth': self.aInBitWidth,
            'aInIsSigned': self.aInIsSigned,
            'bInBitWidth': self.bInBitWidth,
            'bInIsSigned': self.bInIsSigned,
            'aOutBitWidth': self.aOutBitWidth,
            'aOutIsSigned': self.aOutIsSigned,
            'bOutBitWidth': self.bOutBitWidth,
            'bOutIsSigned': self.bOutIsSigned,
            'liftedTwiddleNaf': [list(t) for t in self.liftedTwiddleNaf],
            'aOutTerms': [t.to_dict() for t in self.aOutTerms],
            'bOutTerms': [t.to_dict() for t in self.bOutTerms],
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> ButterflyOperatorSpec:
        return ButterflyOperatorSpec(
            name=d['name'],
            butterflyType=d['butterflyType'],
            q=d['q'],
            aInBitWidth=d['aInBitWidth'],
            aInIsSigned=d['aInIsSigned'],
            bInBitWidth=d['bInBitWidth'],
            bInIsSigned=d['bInIsSigned'],
            aOutBitWidth=d['aOutBitWidth'],
            aOutIsSigned=d['aOutIsSigned'],
            bOutBitWidth=d['bOutBitWidth'],
            bOutIsSigned=d['bOutIsSigned'],
            liftedTwiddleNaf=[tuple(t) for t in d['liftedTwiddleNaf']],
            aOutTerms=[SliceTerm.from_dict(t) for t in d['aOutTerms']],
            bOutTerms=[SliceTerm.from_dict(t) for t in d['bOutTerms']],
        )
