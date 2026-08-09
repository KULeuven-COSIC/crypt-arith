'''The bank scheme: N constant multipliers sharing one input.

A composition, not a leaf — it holds N `NafConstMult` schemes and answers the
same questions they do, per entry. Its reason to exist is feeding a downstream
stage, and what that stage wants is a `list[IntType]`, so `propagateBound()`
returns exactly that and the bounds never round-trip through a JSON side-car.

Entries whose constant lands on the wiring or adder strategy are combinational,
so shorter entries receive balancing registers at their own width to match the
deepest compressor. Ports keep their own widths throughout — no widening at the
bank boundary.
'''
from __future__ import annotations

from ..core.IntType import IntType
from .ConstMultScheme import NafConstMult, defaultModuleName


class ConstMultBankScheme:
    '''N constant multipliers over one input, with uniform output latency.

    The bank is where the modelling pays off most. Its whole purpose is to feed
    a downstream stage — an NTT's `getInputsNatural`, typically — and what that
    stage needs is a `list[IntType]`, one per output port. `propagateBound()`
    returns exactly that, so the bounds never have to round-trip through a JSON
    side-car and be reconstructed.

    Ports keep their own widths: `A_<i>` at the shared input width, `P_<i>` at
    that entry's own output width. Entries whose constant lands on the wiring or
    adder strategy are combinational, so they receive balancing registers at
    their own width to match the deepest compressor — no widening at the bank
    boundary.
    '''

    def __init__(self, name: str = 'cmultbank',
                 constants=(),
                 aIn: IntType = IntType(0, 0, 0),
                 aInValues: list[int] | None = None,
                 modulus: int | None = None,
                 sharedInput: bool = True,
                 countInverters: bool = True,
                 verbose: bool = False,
                 **liftKwargs):
        constants = list(constants)
        if not constants:
            raise ValueError(f'{name}: no constants given')
        self.name = name
        self.aIn = aIn
        self.aInValues = aInValues
        self.modulus = modulus
        self.sharedInput = sharedInput
        self.verbose = verbose
        self.schemes: list[NafConstMult] = [
            NafConstMult(name=f'{name}_P{i}', constant=c, aIn=aIn,
                         aInValues=aInValues, modulus=modulus,
                         countInverters=countInverters, verbose=verbose,
                         **liftKwargs)
            for i, c in enumerate(constants)
        ]

    def __len__(self) -> int:
        return len(self.schemes)

    def setInputValues(self, values: list[int]) -> None:
        '''Drive every entry from one shared input batch.'''
        self.aInValues = values
        for scheme in self.schemes:
            scheme.aInValues = values

    def propagateBound(self) -> list[IntType]:
        '''Per-entry output bounds, in port order.

        Feed straight into `FullyPipelinedNTT.getInputsNatural(bounds)`.
        '''
        return [scheme.propagateBound() for scheme in self.schemes]

    def propagateValue(self) -> list[list[int]]:
        '''Per-entry output value batches, in port order.'''
        return [scheme.propagateValue() for scheme in self.schemes]

    def perEntryLatency(self, pipelineStages: int = 1) -> list[int]:
        '''Latency of each entry before balancing registers are added.'''
        return [s.latency(pipelineStages) for s in self.schemes]

    def latency(self, pipelineStages: int = 1) -> int:
        '''Uniform latency every output port sees.

        Mirrors the legacy bank: the deepest compressor, but never fewer cycles
        than were requested, and never zero.
        '''
        return max(max(self.perEntryLatency(pipelineStages)), pipelineStages, 1)

    def areaCost(self) -> tuple[int, int]:
        '''Summed `(LUT, DSP)` over the entries.

        Excludes the balancing registers, which are flip-flops rather than LUTs.
        '''
        luts = sum(s.areaCost()[0] for s in self.schemes)
        return luts, 0

    def getOperatorInterface(self, name: str,
                             pipelineStages: int = 1) -> 'ConstMultBankSpec':
        from const_mult_spec import ConstMultBankSpec

        entries = [
            scheme.getOperatorInterface(
                defaultModuleName(self.aIn.bitWidth, scheme._liftConstant()[0]))
            for scheme in self.schemes
        ]
        perEntry = self.perEntryLatency(pipelineStages)
        return ConstMultBankSpec(
            name=name,
            aInBitWidth=self.aIn.bitWidth,
            aInIsSigned=self.aIn.isSigned,
            aInZeroLsbs=self.aIn.zeroLsbs,
            sharedInput=self.sharedInput,
            entries=entries,
            requestedPipelineStages=pipelineStages,
            uniformLatency=self.latency(pipelineStages),
            perEntryLatency=perEntry,
        )



        aIn: list[int] | None = None
        pOut: list[list[int]] | None = None
        if gen_testbench:
            rng = _random.Random(seed) if seed is not None else _random
            if sampling == 'bound':
                aIn = sampleBound(self.aIn, test_size, rng)
            elif sampling == 'register':
                aIn = sampleRegisterRange(spec.aInBitWidth, spec.aInIsSigned,
                                          test_size, rng)
            else:
                raise ValueError(
                    f"sampling must be 'bound' or 'register', got {sampling!r}"
                )
            saved = self.aInValues
            self.setInputValues(aIn)
            try:
                pOut = self.propagateValue()
            finally:
                if saved is not None:
                    self.setInputValues(saved)

        gen = resolveBackend(backend, 'const_mult_op',
                             'ConstMultBank_RTL_gen', 'ConstMultBank_SimRTL_gen')
        return runInDir(run_dir, gen,
                        spec=spec,
                        pipeline_stages=pipeline_stages,
                        gen_testbench=gen_testbench,
                        visualization=visualization,
                        A=aIn, P=pOut)


