'''Template for an operator: a thing with ports that you instantiate and connect.

The split this file completes:

    scheme    the arithmetic. Given input bounds, what is the output bound;
              given input values, what are the output values; what spec
              describes it; what does it cost. No ports, no neighbours.

    operator  the thing in a design. Owns input and output Ports, holds a
              scheme, connects to other operators, and drives RTL emission.

A user script therefore reads the same way for every operator in the project:
build it, connect it, drive its inputs, compute, emit.

Nothing subclasses this yet — the operator classes arrive with their families in
later phases. The file exists now so the tree is complete and the contract is
written down before anything depends on it.
'''
from __future__ import annotations

from abc import ABC, abstractmethod

from .Signal import Signal


class Operator(ABC):
    '''Base for a modelled operator. Ports in, scheme in the middle, ports out.

    Concrete operators supply four hooks and inherit the rest:

        _generatorTarget()      which generator module and entry points to call
        _prepareTestData(spec)  how testvectors and goldens are obtained
        _generatorKwargs(data)  what those arrays are called in this generator
        _sanityCheck(...)       how to re-verify what landed on disk

    Those four are exactly where the five existing `emitRtl` implementations
    genuinely differ; everything else about them is the same eight steps in the
    same order, which is what this class will absorb.
    '''

    def __init__(self, name: str = 'Undefined Operator'):
        self.name: str = name

    # --- ports ------------------------------------------------------------

    @property
    @abstractmethod
    def inputPorts(self) -> list:
        '''Input ports, in this operator's own index order.'''

    @property
    @abstractmethod
    def outputPorts(self) -> list:
        '''Output ports, in this operator's own index order.'''

    def drive(self, signals: list[Signal]) -> None:
        '''Load every input port from `signals`, positionally.'''
        ports = self.inputPorts
        if len(signals) != len(ports):
            raise ValueError(
                f'{self.name}.drive: got {len(signals)} signals for '
                f'{len(ports)} input ports'
            )
        for port, signal in zip(ports, signals):
            port.signal = signal

    def read(self) -> list[Signal]:
        '''Current payload of every output port, in index order.'''
        return [port.signal for port in self.outputPorts]

    # --- behaviour --------------------------------------------------------

    @abstractmethod
    def compute(self) -> None:
        '''Drive this operator's scheme from its input ports into its outputs.'''

    @abstractmethod
    def getOperatorInterface(self, name: str):
        '''Frozen spec for the RTL generator; normally delegates to the scheme.'''

    @abstractmethod
    def areaCost(self) -> tuple[int, int]:
        '''`(LUT, DSP)`. An estimate, held to roughly 5% — not a replica of the
        generator.'''

    @abstractmethod
    def latency(self, pipelineStages: int = 1) -> int:
        '''Pipeline registers between this operator's inputs and its outputs.'''

    @abstractmethod
    def emitRtl(self, name: str, run_dir, **kwargs) -> dict:
        '''Generate RTL into `run_dir`; return the generator's metadata.'''
