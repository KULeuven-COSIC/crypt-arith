'''The constant-multiplier bank operator: one shared input, N outputs.

    scheme = ConstMultBankScheme(name='cmultbank', constants=twiddles,
                                 aIn=IntType.unsigned(24), modulus=q)
    op     = ConstMultBank(name='cmultbank', scheme=scheme)

    op.drive([Signal(IntType.unsigned(24), values)] * len(scheme))
    op.compute()
    op.emitRtl(name='cmultbank', run_dir='work/demo')

The payoff over reading `output_bounds.json` back: `op.read()` hands you a
`Signal` per output port, bound and values together, ready to drive the next
stage directly.
'''
from __future__ import annotations

import random as _random

from ..core.Operator import Operator
from ..core.OperatorScheme import sampleBound, sampleRegisterRange
from ..core.Port import SimpleInputPort, SimpleOutputPort
from ..core.Signal import Signal
from .BankScheme import ConstMultBankScheme


class ConstMultBank(Operator):
    '''N constant multipliers over one input, with uniform output latency.'''

    def __init__(self, name: str = 'cmultbank',
                 scheme: ConstMultBankScheme | None = None,
                 sampling: str = 'bound'):
        super().__init__(name)
        if scheme is None:
            raise ValueError(f'{name}: ConstMultBank requires a scheme')
        self.scheme = scheme
        self.sampling = sampling
        n = len(scheme)
        # One input port per entry even when the input is shared: that mirrors
        # the emitted wrapper, whose A_<i> ports are separate nets driven from
        # one source. Modelling it as N ports keeps the operator's port list and
        # the RTL port list the same shape.
        self._inputPorts = [SimpleInputPort(f'{name} Input Port A_{i}')
                            for i in range(n)]
        self._outputPorts = [SimpleOutputPort(f'{name} Output Port P_{i}')
                             for i in range(n)]

    def __len__(self) -> int:
        return len(self.scheme)

    @property
    def inputPorts(self) -> list:
        return self._inputPorts

    @property
    def outputPorts(self) -> list:
        return self._outputPorts

    def driveShared(self, signal: Signal) -> None:
        '''Drive every input port from one signal — the usual case.'''
        self.drive([signal] * len(self._inputPorts))

    # ------------------------------------------------------------------

    def compute(self) -> None:
        signals = [p.signal for p in self._inputPorts]
        if any(s is None for s in signals):
            raise ValueError(f'{self.name}.compute: some input ports have no signal')

        for entry, port, signal in zip(self.scheme.schemes, self._outputPorts,
                                       signals):
            entry.aIn = signal.bound
            outBound = entry.propagateBound()
            outValues = None
            if signal.values is not None:
                entry.aInValues = signal.values
                outValues = entry.propagateValue()
            port.signal = Signal(outBound, outValues)
            if port.isConnected:
                port.push()

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        return self.scheme.getOperatorInterface(name, pipelineStages=pipelineStages)

    def areaCost(self) -> tuple[int, int]:
        return self.scheme.areaCost()

    def latency(self, pipelineStages: int = 1) -> int:
        return self.scheme.latency(pipelineStages)

    # --- emitRtl hooks --------------------------------------------------

    def _generatorTarget(self) -> tuple[str, str, str]:
        return ('const_mult_op', 'ConstMultBank_RTL_gen',
                'ConstMultBank_SimRTL_gen')

    def _prepareTestData(self, spec, test_size: int, seed: int | None,
                         **kwargs) -> dict:
        sampling = kwargs.pop('sampling', self.sampling)
        rng = _random.Random(seed) if seed is not None else _random
        if sampling == 'bound':
            aIn = sampleBound(self.scheme.aIn, test_size, rng)
        elif sampling == 'register':
            aIn = sampleRegisterRange(spec.aInBitWidth, spec.aInIsSigned,
                                      test_size, rng)
        else:
            raise ValueError(
                f"sampling must be 'bound' or 'register', got {sampling!r}")

        # Goldens come from the scheme's own value path, on a shared batch.
        saved = [e.aInValues for e in self.scheme.schemes]
        try:
            for e in self.scheme.schemes:
                e.aInValues = aIn
            pOut = [e.propagateValue() for e in self.scheme.schemes]
        finally:
            for e, s in zip(self.scheme.schemes, saved):
                e.aInValues = s
        return {'A': aIn, 'P': pOut}

    def _generatorKwargs(self, data: dict) -> dict:
        return {'A': data.get('A'), 'P': data.get('P')}
