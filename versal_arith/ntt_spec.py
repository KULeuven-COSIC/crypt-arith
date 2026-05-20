"""Cross-subproject contract for the NTT/INTT pipeline RTL generator.

`InterStageWire` and `NTTOperatorSpec` are pure-data dataclasses defined
once and shared between two consumers:

  - `NTT_modeling.NTT.FullyPipelinedNTT.getOperatorInterface` populates an
    `NTTOperatorSpec` from a populated NTT instance (every butterfly's
    inputs and outputs have bounds set by `compute()`).

  - `versal_arith.rtl_gen.ntt.NTT_RTL_gen` consumes the spec and emits the
    top-level wrapper SystemVerilog, the self-checking testbench, the
    aggregated XDC files, and hex testvectors. It also recursively calls
    `versal_arith.rtl_gen.butterfly.Butterfly_RTL_gen` for each butterfly
    in the grid.

The file lives at the top level of `versal_arith/` (NOT inside `rtl_gen/`)
so importing it from `NTT_modeling` does not trigger `rtl_gen/__init__.py`'s
import chain. Same convention as `butterfly_spec.py`.

The wiring tables in `NTTOperatorSpec` are precomputed at extraction time
so the consumer never needs to import any `NTT_modeling` helpers
(`butterflyToMems`, `memToButterfly`, `bitReverse`).
"""
from __future__ import annotations
from dataclasses import dataclass, asdict
from typing import Any

from butterfly_spec import ButterflyOperatorSpec


@dataclass(frozen=True)
class InterStageWire:
    """One input port's upstream binding within the butterfly grid.

    Carried by `NTTOperatorSpec.interStageWiring[s-1][p]` to describe where
    the layer-`s` butterfly at position `p` pulls its `aIn` (or `bIn`) from
    in layer `s-1`.
    """
    src_p: int        # producing butterfly position in the previous layer
    src_port: str     # 'A' | 'B'

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)

    @staticmethod
    def from_dict(d: dict[str, Any]) -> InterStageWire:
        return InterStageWire(**d)


@dataclass(frozen=True)
class NTTOperatorSpec:
    """All RTL-relevant data extracted from a populated `FullyPipelinedNTT`.

    Per-butterfly bit widths, signedness, and twiddle NAFs are inside each
    `ButterflyOperatorSpec` in `butterflySpecs`. The wiring tables describe
    how to connect natural-order x[i] ports to the stage-0 butterflies, how
    to connect each layer's outputs into the next layer, and how to extract
    natural-order y[i] from the final-stage butterflies.
    """
    name: str                                       # top module name, e.g. 'NTT_n128_GS'
    n: int
    butterflyType: str                              # 'CT' | 'GS'
    negacyclic: bool
    q: int

    butterflySpecs: list[list[ButterflyOperatorSpec]]   # shape log2(n) x n/2

    inputBitWidthsNatural: list[int]                # length n; per-natural input width
    inputIsSignedNatural: list[bool]                # length n
    outputBitWidthsNatural: list[int]               # length n
    outputIsSignedNatural: list[bool]               # length n

    inputWiring: list[tuple[int, int]]
    outputWiring: list[tuple[int, int]]

    interStageWiring: list[list[tuple[InterStageWire, InterStageWire]]]

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'n': self.n,
            'butterflyType': self.butterflyType,
            'negacyclic': self.negacyclic,
            'q': self.q,
            'butterflySpecs': [[b.to_dict() for b in layer] for layer in self.butterflySpecs],
            'inputBitWidthsNatural': list(self.inputBitWidthsNatural),
            'inputIsSignedNatural': list(self.inputIsSignedNatural),
            'outputBitWidthsNatural': list(self.outputBitWidthsNatural),
            'outputIsSignedNatural': list(self.outputIsSignedNatural),
            'inputWiring': [list(w) for w in self.inputWiring],
            'outputWiring': [list(w) for w in self.outputWiring],
            'interStageWiring': [
                [[a.to_dict(), b.to_dict()] for (a, b) in layer]
                for layer in self.interStageWiring
            ],
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> NTTOperatorSpec:
        return NTTOperatorSpec(
            name=d['name'],
            n=d['n'],
            butterflyType=d['butterflyType'],
            negacyclic=d['negacyclic'],
            q=d['q'],
            butterflySpecs=[[ButterflyOperatorSpec.from_dict(b) for b in layer]
                            for layer in d['butterflySpecs']],
            inputBitWidthsNatural=list(d['inputBitWidthsNatural']),
            inputIsSignedNatural=list(d['inputIsSignedNatural']),
            outputBitWidthsNatural=list(d['outputBitWidthsNatural']),
            outputIsSignedNatural=list(d['outputIsSignedNatural']),
            inputWiring=[tuple(w) for w in d['inputWiring']],
            outputWiring=[tuple(w) for w in d['outputWiring']],
            interStageWiring=[
                [(InterStageWire.from_dict(a), InterStageWire.from_dict(b)) for (a, b) in layer]
                for layer in d['interStageWiring']
            ],
        )
