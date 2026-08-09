'''The constant-multiplier operator: one input port, one output port, a scheme.

    scheme = NafConstMult(name='c', constant=12345, aIn=IntType.unsigned(24))
    op     = ConstMult(name='Cmult_24x12345', scheme=scheme)

    op.drive([Signal(IntType.unsigned(24), values)])
    op.compute()
    product = op.read()[0]                 # Signal(bound, values)

    op.emitRtl(name='Cmult_24x12345', run_dir='work/demo')

The scheme owns the arithmetic and knows nothing about neighbours; this class
owns the ports and the RTL emission. Chaining is ordinary port connection —
`op.outputPorts[0].connect(nextOp.inputPorts[0])` — after which `compute()` on
each in turn carries both the bound and the values forward.
'''
from __future__ import annotations

import random as _random

from ..core.IntType import IntType
from ..core.Operator import Operator
from ..core.OperatorScheme import sampleBound, sampleRegisterRange
from ..core.Port import SimpleInputPort, SimpleOutputPort
from ..core.Signal import Signal
from .ConstMultScheme import ConstMultScheme, NafConstMult


class ConstMult(Operator):
    '''`P = A * C` as a connectable operator.'''

    def __init__(self, name: str = 'Undefined ConstMult',
                 scheme: ConstMultScheme | None = None,
                 sampling: str = 'bound'):
        super().__init__(name)
        if scheme is None:
            raise ValueError(f'{name}: ConstMult requires a scheme')
        self.scheme = scheme
        self.sampling = sampling
        self.inputPortA = SimpleInputPort(f'{name} Input Port A')
        self.outputPortP = SimpleOutputPort(f'{name} Output Port P')

    @property
    def inputPorts(self) -> list:
        return [self.inputPortA]

    @property
    def outputPorts(self) -> list:
        return [self.outputPortP]

    # ------------------------------------------------------------------

    def compute(self) -> None:
        '''Bound first, then values at bound-derived widths, then push.

        Both flows move in one pass. A signal with no values simply produces an
        output with no values — a legitimate sizing-only run, not a half state.
        '''
        signal = self.inputPortA.signal
        if signal is None:
            raise ValueError(f'{self.name}.compute: input port has no signal')

        self.scheme.aIn = signal.bound
        outBound = self.scheme.propagateBound()

        outValues = None
        if signal.values is not None:
            self.scheme.aInValues = signal.values
            outValues = self.scheme.propagateValue()

        self.outputPortP.signal = Signal(outBound, outValues)
        if self.outputPortP.isConnected:
            self.outputPortP.push()

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        return self.scheme.getOperatorInterface(name)

    def areaCost(self) -> tuple[int, int]:
        return self.scheme.areaCost()

    def latency(self, pipelineStages: int = 1) -> int:
        return self.scheme.latency(pipelineStages)

    # --- emitRtl hooks --------------------------------------------------

    def _generatorTarget(self) -> tuple[str, str, str]:
        return 'const_mult_op', 'ConstMult_RTL_gen', 'ConstMult_SimRTL_gen'

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

        golden = NafConstMult(name=f'{self.name}_golden', constant=spec.naf,
                              aIn=self.scheme.aIn, aInValues=aIn,
                              inPortName=spec.inPortName,
                              outPortName=spec.outPortName)
        return {'A': aIn, 'P': golden.propagateValue()}

    def _generatorKwargs(self, data: dict) -> dict:
        return {'A': data.get('A'), 'P': data.get('P')}

    def _sanityCheck(self, run_dir, spec, sampleSize: int) -> None:
        from .ConstMultScheme import sanityCheckConstMultTestvectors
        sanityCheckConstMultTestvectors(run_dir, spec, sampleSize)
