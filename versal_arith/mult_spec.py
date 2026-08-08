"""Cross-subproject contract for the general (non-constant) multiplier generator.

Describes `P = A * B` for any decomposition strategy — schoolbook, tiling,
Karatsuba, or an opaque leaf such as the radix-4 Booth multiplier — with one
recursive shape.

Every node in the tree says the same three things:

  1. **operand wires** — how to build the operands of my sub-multiplications
     from my own inputs (`operandWires`);
  2. **sub-multiplications** — which pairs of those wires get multiplied, and
     by what (`subMults`, recursing through `childSpec`);
  3. **recombination** — how to weigh and sum the sub-products into my output
     (`pOutTerms`).

Why operands are expressions, not slices
----------------------------------------
The obvious representation — "a sub-multiplier takes a bit range of A" —
cannot express Karatsuba, whose middle product takes `(A1 + A0)`. Making an
operand a `SliceTerm` list instead handles that for free, and gets the width
right where a hand-written formula would not.

Splitting a signed 24-bit `A` at bit 12 gives a **signed** 12-bit high half
(`IntType.slice` keeps the sign on a boundary slice) and an **unsigned** 12-bit
low half (an interior slice discards it). So `A1 + A0` spans `[-2048, 6142]` and
needs **14** bits, not the 13 that "one wider than a 12-bit slice" suggests.
`IntType`'s own arithmetic produces that number with no special-casing.

Physical width vs value bound
-----------------------------
`WireDef` carries both, and the split is load-bearing. `bitWidth` / `isSigned`
describe the wire the RTL declares; `minValue` / `maxValue` / `zeroLsbs`
describe what it can actually hold, which may be tighter. Bound propagation uses
the tight interval, while the heap builder slices at `sliceStart..sliceEnd` taken
from the physical width. Because `IntType.slice(0, physicalWidth-1)` on a tighter
bound lands on the boundary branch and returns it unchanged, the two views stay
consistent automatically.

Like the other spec modules this lives at the top level of `versal_arith/` so
importing it does not pull in `rtl_gen/__init__.py`'s generator chain.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from butterfly_spec import SliceTerm


@dataclass(frozen=True)
class WireDef:
    """One named internal wire: a signed sum of shifted slices of earlier wires.

    Wires are listed in topological order within a spec, so every `SliceTerm`
    source is either a port name or a wire defined earlier in the list.
    """

    name: str
    terms: list[SliceTerm]
    bitWidth: int          # physical width of the emitted wire
    isSigned: bool
    minValue: int          # tight value bound; may be narrower than bitWidth
    maxValue: int
    zeroLsbs: int

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'terms': [t.to_dict() for t in self.terms],
            'bitWidth': self.bitWidth,
            'isSigned': self.isSigned,
            'minValue': self.minValue,
            'maxValue': self.maxValue,
            'zeroLsbs': self.zeroLsbs,
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> WireDef:
        return WireDef(
            name=d['name'],
            terms=[SliceTerm.from_dict(t) for t in d['terms']],
            bitWidth=d['bitWidth'],
            isSigned=d['isSigned'],
            minValue=d['minValue'],
            maxValue=d['maxValue'],
            zeroLsbs=d['zeroLsbs'],
        )


@dataclass(frozen=True)
class SubMultRef:
    """One child multiplication: `<name> = <opAWire> * <opBWire>`.

    `childSpec` is `None` exactly when this is a leaf, in which case `leafKind`
    names the primitive generator to instantiate.
    """

    name: str
    opAWire: str
    opBWire: str
    leafKind: str                          # '' when decomposed; else 'booth' | 'schoolbook'
    childSpec: 'MultOperatorSpec | None'
    outBitWidth: int
    outIsSigned: bool
    latency: int

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'opAWire': self.opAWire,
            'opBWire': self.opBWire,
            'leafKind': self.leafKind,
            'childSpec': self.childSpec.to_dict() if self.childSpec else None,
            'outBitWidth': self.outBitWidth,
            'outIsSigned': self.outIsSigned,
            'latency': self.latency,
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> SubMultRef:
        return SubMultRef(
            name=d['name'],
            opAWire=d['opAWire'],
            opBWire=d['opBWire'],
            leafKind=d['leafKind'],
            childSpec=(MultOperatorSpec.from_dict(d['childSpec'])
                       if d['childSpec'] else None),
            outBitWidth=d['outBitWidth'],
            outIsSigned=d['outIsSigned'],
            latency=d['latency'],
        )


@dataclass(frozen=True)
class MultOperatorSpec:
    """`P = A * B`, decomposed (possibly recursively) or an opaque leaf."""

    name: str
    decomposition: str                     # 'leaf' | 'tiling' | 'karatsuba' | 'schoolbook'
    leafKind: str                          # non-empty only when decomposition == 'leaf'

    aPortName: str
    bPortName: str
    outPortName: str

    aInBitWidth: int
    aInIsSigned: bool
    bInBitWidth: int
    bInIsSigned: bool

    pOutBitWidth: int
    pOutIsSigned: bool
    pOutMinValue: int
    pOutMaxValue: int
    pOutZeroLsbs: int

    operandWires: list[WireDef]
    subMults: list[SubMultRef]
    pOutTerms: list[SliceTerm]             # over sub-product wire names

    uniformChildLatency: int
    latency: int

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'decomposition': self.decomposition,
            'leafKind': self.leafKind,
            'aPortName': self.aPortName,
            'bPortName': self.bPortName,
            'outPortName': self.outPortName,
            'aInBitWidth': self.aInBitWidth,
            'aInIsSigned': self.aInIsSigned,
            'bInBitWidth': self.bInBitWidth,
            'bInIsSigned': self.bInIsSigned,
            'pOutBitWidth': self.pOutBitWidth,
            'pOutIsSigned': self.pOutIsSigned,
            'pOutMinValue': self.pOutMinValue,
            'pOutMaxValue': self.pOutMaxValue,
            'pOutZeroLsbs': self.pOutZeroLsbs,
            'operandWires': [w.to_dict() for w in self.operandWires],
            'subMults': [s.to_dict() for s in self.subMults],
            'pOutTerms': [t.to_dict() for t in self.pOutTerms],
            'uniformChildLatency': self.uniformChildLatency,
            'latency': self.latency,
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> MultOperatorSpec:
        return MultOperatorSpec(
            name=d['name'],
            decomposition=d['decomposition'],
            leafKind=d['leafKind'],
            aPortName=d['aPortName'],
            bPortName=d['bPortName'],
            outPortName=d['outPortName'],
            aInBitWidth=d['aInBitWidth'],
            aInIsSigned=d['aInIsSigned'],
            bInBitWidth=d['bInBitWidth'],
            bInIsSigned=d['bInIsSigned'],
            pOutBitWidth=d['pOutBitWidth'],
            pOutIsSigned=d['pOutIsSigned'],
            pOutMinValue=d['pOutMinValue'],
            pOutMaxValue=d['pOutMaxValue'],
            pOutZeroLsbs=d['pOutZeroLsbs'],
            operandWires=[WireDef.from_dict(w) for w in d['operandWires']],
            subMults=[SubMultRef.from_dict(s) for s in d['subMults']],
            pOutTerms=[SliceTerm.from_dict(t) for t in d['pOutTerms']],
            uniformChildLatency=d['uniformChildLatency'],
            latency=d['latency'],
        )
