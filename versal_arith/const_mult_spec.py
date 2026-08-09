"""Cross-subproject contract for the constant-multiplier RTL generator.

`ConstMultOperatorSpec` and `ConstMultBankSpec` are pure-data dataclasses shared
between two consumers:

  - `NTT_modeling.ConstMultScheme.NafConstMult.getOperatorInterface` populates a
    spec from a model whose input bound is already set, so the output width,
    signedness and implementation strategy are all known.

  - `versal_arith.rtl_gen.const_mult_op.ConstMult_RTL_gen` consumes it and emits
    SystemVerilog plus a self-checking testbench.

Like `butterfly_spec.py` and `ntt_spec.py`, this file lives at the top level of
`versal_arith/` so importing it does NOT trigger `rtl_gen/__init__.py`'s import
chain, which pulls in every operator generator (and, through `bitheap`,
matplotlib). Both subprojects can load this module cheaply.

Relationship to the legacy scalar path
--------------------------------------
`rtl_gen/const_mult.py`'s `Cmult_RTL_gen` takes `width_a` plus a constant and
derives everything itself. That path is unchanged and still backs
`cli.py -operator cmult`. The difference here is that **the model owns the
numbers**: the generator is told the output width, the strategy and the exact
value interval rather than recomputing them.

That matters for two reasons.

First, correctness of the declared width. `_output_width` computes
`max_abs.bit_length() + 1` where `IntType.bitWidth` computes
`max((-min-1).bit_length(), max.bit_length()) + 1`. A 25288-combination sweep
found these differ on 783 cases — every one a signed input with a positive
power-of-two constant — with the generator always the wider of the two. That gap
is what `IntType.loadBoundsJson`'s widening workaround exists to paper over. When
the spec carries the width, there is no second calculation to disagree with.

Second, tightness. `width_a` alone forces the assumption that A fills its whole
register. The model knows the real interval, so an input bounded by `[0, 10^7]`
(24 bits wide, but only reaching ~2^23.25) times 3 is sized at 25 bits rather
than 26. It also tracks `zeroLsbs`, which a `signed_input: bool` cannot express
at all.

The output is described as a `SliceTerm` list in `pOutTerms`, the same primitive
the butterfly uses, so both operators feed the same bit-heap builder. For a
constant multiplier each NAF term becomes one record: the whole of A, no inner
slicing, `limbShift` carrying the NAF exponent and `sign` its sign.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from butterfly_spec import SliceTerm


@dataclass(frozen=True)
class ConstMultOperatorSpec:
    """One constant multiplier: `P = A * constant`."""

    name: str                       # module name, e.g. 'Cmult_24x12345'

    # --- the constant ---------------------------------------------------
    constant: int                   # the value ACTUALLY implemented (post-lift)
    originalConstant: int | None    # pre-lift value, when a modulus lift ran
    modulus: int | None             # modulus the lift was performed against
    naf: list[tuple[int, int]]      # [(sign, exponent), ...] of `constant`

    # --- ports ----------------------------------------------------------
    inPortName: str                 # 'A'
    outPortName: str                # 'P'
    aInBitWidth: int
    aInIsSigned: bool
    aInZeroLsbs: int

    pOutBitWidth: int
    pOutIsSigned: bool
    pOutMinValue: int               # tight: exactly min(constant * aIn)
    pOutMaxValue: int               # tight: exactly max(constant * aIn)
    pOutZeroLsbs: int

    # --- implementation -------------------------------------------------
    strategy: str                   # 'wire' | 'adder' | 'compressor'
    maxColumnHeight: int            # bit-heap max column height; picks `strategy`
    pOutTerms: list[SliceTerm]

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'constant': self.constant,
            'originalConstant': self.originalConstant,
            'modulus': self.modulus,
            'naf': [list(t) for t in self.naf],
            'inPortName': self.inPortName,
            'outPortName': self.outPortName,
            'aInBitWidth': self.aInBitWidth,
            'aInIsSigned': self.aInIsSigned,
            'aInZeroLsbs': self.aInZeroLsbs,
            'pOutBitWidth': self.pOutBitWidth,
            'pOutIsSigned': self.pOutIsSigned,
            'pOutMinValue': self.pOutMinValue,
            'pOutMaxValue': self.pOutMaxValue,
            'pOutZeroLsbs': self.pOutZeroLsbs,
            'strategy': self.strategy,
            'maxColumnHeight': self.maxColumnHeight,
            'pOutTerms': [t.to_dict() for t in self.pOutTerms],
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> ConstMultOperatorSpec:
        return ConstMultOperatorSpec(
            name=d['name'],
            constant=d['constant'],
            originalConstant=d['originalConstant'],
            modulus=d['modulus'],
            naf=[tuple(t) for t in d['naf']],
            inPortName=d['inPortName'],
            outPortName=d['outPortName'],
            aInBitWidth=d['aInBitWidth'],
            aInIsSigned=d['aInIsSigned'],
            aInZeroLsbs=d['aInZeroLsbs'],
            pOutBitWidth=d['pOutBitWidth'],
            pOutIsSigned=d['pOutIsSigned'],
            pOutMinValue=d['pOutMinValue'],
            pOutMaxValue=d['pOutMaxValue'],
            pOutZeroLsbs=d['pOutZeroLsbs'],
            strategy=d['strategy'],
            maxColumnHeight=d['maxColumnHeight'],
            pOutTerms=[SliceTerm.from_dict(t) for t in d['pOutTerms']],
        )


@dataclass(frozen=True)
class ConstMultBankSpec:
    """N constant multipliers sharing one input, with uniform output latency.

    Per-entry ports stay at their own widths — `A_<i>` at `aInBitWidth` and
    `P_<i>` at that entry's `pOutBitWidth` — matching the wrapper the legacy
    bank emits. `sharedInput` only tells the testbench generator that every
    `A_<i>` is driven from a single stimulus stream.

    Latency is uniform across outputs by construction: entries whose strategy is
    `'wire'` or `'adder'` are combinational, so shorter entries get balancing
    registers at their own output width. `perEntryLatency` is the pre-balancing
    latency of each entry; `uniformLatency` is what every output actually sees.
    """

    name: str                                   # top module, e.g. 'cmultbank'
    aInBitWidth: int
    aInIsSigned: bool
    aInZeroLsbs: int
    sharedInput: bool
    entries: list[ConstMultOperatorSpec]
    requestedPipelineStages: int
    uniformLatency: int
    perEntryLatency: list[int]

    def to_dict(self) -> dict[str, Any]:
        return {
            'name': self.name,
            'aInBitWidth': self.aInBitWidth,
            'aInIsSigned': self.aInIsSigned,
            'aInZeroLsbs': self.aInZeroLsbs,
            'sharedInput': self.sharedInput,
            'entries': [e.to_dict() for e in self.entries],
            'requestedPipelineStages': self.requestedPipelineStages,
            'uniformLatency': self.uniformLatency,
            'perEntryLatency': list(self.perEntryLatency),
        }

    @staticmethod
    def from_dict(d: dict[str, Any]) -> ConstMultBankSpec:
        return ConstMultBankSpec(
            name=d['name'],
            aInBitWidth=d['aInBitWidth'],
            aInIsSigned=d['aInIsSigned'],
            aInZeroLsbs=d['aInZeroLsbs'],
            sharedInput=d['sharedInput'],
            entries=[ConstMultOperatorSpec.from_dict(e) for e in d['entries']],
            requestedPipelineStages=d['requestedPipelineStages'],
            uniformLatency=d['uniformLatency'],
            perEntryLatency=list(d['perEntryLatency']),
        )
