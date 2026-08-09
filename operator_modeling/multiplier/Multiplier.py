'''The general-multiplier operator: two input ports, one output port, a scheme.

    scheme = BoothMult(name='b', aIn=IntType.signed(24), bIn=IntType.signed(24))
    op     = Multiplier(name='Bmult24x24', scheme=scheme)

    op.drive([Signal(aBound, aValues), Signal(bBound, bValues)])
    op.compute()

Whichever decomposition the scheme uses — an opaque Booth leaf today, tiling or
Karatsuba later — the operator around it is this one. A new strategy changes
what happens inside `compute()`, never the shape of the thing you connect.
'''
from __future__ import annotations

import random as _random

from ..core.Operator import Operator
from ..core.OperatorScheme import sampleBound
from ..core.Port import SimpleInputPort, SimpleOutputPort
from ..core.Signal import Signal
from .MultiplierScheme import MultiplierScheme


class Multiplier(Operator):
    '''`P = A * B` as a connectable operator.'''

    def __init__(self, name: str = 'Undefined Multiplier',
                 scheme: MultiplierScheme | None = None):
        super().__init__(name)
        if scheme is None:
            raise ValueError(f'{name}: Multiplier requires a scheme')
        self.scheme = scheme
        self.inputPortA = SimpleInputPort(f'{name} Input Port A')
        self.inputPortB = SimpleInputPort(f'{name} Input Port B')
        self.outputPortP = SimpleOutputPort(f'{name} Output Port P')

    @property
    def inputPorts(self) -> list:
        return [self.inputPortA, self.inputPortB]

    @property
    def outputPorts(self) -> list:
        return [self.outputPortP]

    def compute(self) -> None:
        sa, sb = self.inputPortA.signal, self.inputPortB.signal
        if sa is None or sb is None:
            raise ValueError(f'{self.name}.compute: an input port has no signal')

        self.scheme.aIn, self.scheme.bIn = sa.bound, sb.bound
        outBound = self.scheme.propagateBound()

        outValues = None
        if sa.values is not None and sb.values is not None:
            self.scheme.aInValues, self.scheme.bInValues = sa.values, sb.values
            outValues = self.scheme.propagateValue()

        self.outputPortP.signal = Signal(outBound, outValues)
        if self.outputPortP.isConnected:
            self.outputPortP.push()

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        return self.scheme.getOperatorInterface(name, pipelineStages=pipelineStages)

    def areaCost(self) -> tuple[int, int]:
        return self.scheme.areaCost()

    def latency(self, pipelineStages: int = 1) -> int:
        return self.scheme.latency(pipelineStages)

    def selfCheck(self, testSize: int = 256, seed: int | None = None) -> None:
        '''Assert the scheme's decomposition really computes A * B.'''
        self.scheme.selfCheck(testSize=testSize, seed=seed)

    # --- emitRtl hooks --------------------------------------------------

    def _generatorTarget(self) -> tuple[str, str, str]:
        return 'mult', 'Mult_RTL_gen', 'Mult_SimRTL_gen'

    def _prepareTestData(self, spec, test_size: int, seed: int | None,
                         **kwargs) -> dict:
        rng = _random.Random(seed) if seed is not None else _random
        aIn = sampleBound(self.scheme.aIn, test_size, rng)
        bIn = sampleBound(self.scheme.bIn, test_size, rng)
        saved = (self.scheme.aInValues, self.scheme.bInValues)
        try:
            self.scheme.aInValues, self.scheme.bInValues = aIn, bIn
            pOut = self.scheme.propagateValue()
        finally:
            self.scheme.aInValues, self.scheme.bInValues = saved
        return {'A': aIn, 'B': bIn, 'P': pOut}

    def _generatorKwargs(self, data: dict) -> dict:
        return {'A': data.get('A'), 'B': data.get('B'), 'P': data.get('P')}

    def emitRtl(self, name: str, run_dir, **kwargs) -> dict:
        '''Leaves go straight to their primitive generator; decomposed nodes
        have no generator yet (rtl_gen/mult.py is unwritten), so they raise.'''
        if self.scheme.isLeaf():
            return self.scheme.emitRtl(name=name, run_dir=run_dir, **kwargs)
        raise NotImplementedError(
            f'{self.name}.emitRtl: the general-multiplier generator '
            f'(rtl_gen/mult.py) is not implemented yet. Only the modelling '
            f'framework and the Booth leaf have landed.'
        )
