'''The matrix-transpose operator: step four of a four-step NTT.

    scheme = BehaviouralMatrixTranspose(name='t', rows=128, cols=128)
    op     = MatrixTranspose(name='corner_turn', scheme=scheme)

    for beat in range(rows):                    # priming: nothing comes out
        op.drive([Signal(b, v) for b, v in row(beat)])
        op.compute()                            # -> False

    for beat in range(rows):                    # steady: one row in, one out
        op.drive([Signal(b, v) for b, v in row(rows + beat)])
        if op.compute():                        # -> True
            transposedRow = [p.signal for p in op.outputPorts]

**This is the project's first stateful operator.** Every other one is a pure
function of its input ports, and `compute()` on them is untimed — the whole
loaded batch goes through in a single call. A corner turn cannot work that way:
its output at any moment depends on rows received earlier, so it needs a notion
of *when*.

It introduces that in the only place available: one `compute()` call is one
beat, and state carries across calls. Two things follow, and both are why this
shape is worth the deviation.

The batch axis keeps its meaning. Everywhere in this project `Signal.values` is
a batch of independent trials, and it still is here — the operator moves whole
`Signal`s and never looks inside them, so a batch of T trials is transposed T
times over with no interaction. Had `compute()` instead consumed a whole matrix
per call, the batch axis would have had to carry the matrix's second dimension,
and would have meant something different for this operator than for every other.

And bounds stay per element. Since a whole `Signal` is buffered, the bound
travels welded to the values it describes, and nothing inside this operator ever
merges two bounds. (A caller feeding the emitted beats into a batch-at-once
operator like `FullyPipelinedNTT` does have to collapse them, because
`getInputsNatural` takes one bound per port — but that is the caller's boundary,
not this one's.)

`reset()` exists because state does. Re-running a populated operator without it
resumes mid-period.
'''
from __future__ import annotations

from ..core.Operator import Operator
from ..core.Port import SimpleInputPort, SimpleOutputPort
from ..core.Signal import Signal
from .MatrixTransposeScheme import MatrixTransposeScheme


class MatrixTranspose(Operator):
    '''A corner turn as a connectable operator: `cols` lanes in, `rows` out.'''

    def __init__(self, name: str = 'Undefined MatrixTranspose',
                 scheme: MatrixTransposeScheme | None = None):
        super().__init__(name)
        if scheme is None:
            raise ValueError(f'{name}: MatrixTranspose requires a scheme')
        self.scheme = scheme
        # One input lane per column of an arriving row, one output lane per
        # column of a departing transposed row.
        self._inputPorts = [SimpleInputPort(f'{name} Input Port c{c}')
                            for c in range(scheme.cols)]
        self._outputPorts = [SimpleOutputPort(f'{name} Output Port r{r}')
                             for r in range(scheme.rows)]
        self.reset()

    @property
    def inputPorts(self) -> list:
        return self._inputPorts

    @property
    def outputPorts(self) -> list:
        return self._outputPorts

    # ------------------------------------------------------------------
    # State
    # ------------------------------------------------------------------

    def reset(self) -> None:
        '''Return to beat 0 with nothing in flight.

        Not on the `Operator` ABC, which assumes stateless operators. Call it
        before re-running, or the next `compute()` resumes mid-period.
        '''
        #: The matrix currently being received, `rows x cols` of Signals,
        #: indexed [beat][lane].
        self._incoming: list[list[Signal | None]] = self._emptyMatrix()
        #: The completed matrix currently being emitted, already transposed by
        #: the scheme, so beat b is just row b of it. None while priming.
        self._outgoing: list[list[Signal | None]] | None = None
        self._beat: int = 0

    def _emptyMatrix(self) -> list[list[Signal | None]]:
        return [[None] * self.scheme.cols for _ in range(self.scheme.rows)]

    @property
    def outputValid(self) -> bool:
        '''Whether the next `compute()` will drive the output ports.'''
        return self._outgoing is not None

    @property
    def beat(self) -> int:
        '''Position within the current `rows`-beat period.'''
        return self._beat

    # ------------------------------------------------------------------

    def compute(self) -> bool:
        '''Advance one beat. Returns whether the output ports were driven.

        Accepts a row every beat without exception — reception never pauses —
        and emits one transposed row per beat once a full matrix has arrived.
        The first `rows` calls therefore return False and leave the output
        ports untouched.
        '''
        signals = [p.signal for p in self._inputPorts]
        missing = [i for i, s in enumerate(signals) if s is None]
        if missing:
            raise ValueError(
                f'{self.name}.compute: input lanes {missing[:8]}'
                f'{"..." if len(missing) > 8 else ""} have no signal at beat '
                f'{self._beat}. A corner turn consumes a whole row per beat, so '
                f'every lane must be driven on every call.'
            )

        self._incoming[self._beat] = list(signals)

        drove = self._outgoing is not None
        if drove:
            # `_outgoing` is already transposed, so beat b is simply its row b.
            for r, port in enumerate(self._outputPorts):
                port.signal = self._outgoing[self._beat][r]
                if port.isConnected:
                    port.push()

        self._beat += 1
        if self._beat == self.scheme.rows:
            # The scheme owns the index swap — the operator only decides *when*
            # a matrix is complete, never how it is permuted.
            self._outgoing = self.scheme.transposeTable(self._incoming, 'incoming')
            self._incoming = self._emptyMatrix()
            self._beat = 0
        return drove

    def readRow(self) -> list[Signal | None]:
        '''The transposed row currently on the output ports, lane by lane.'''
        return [p.signal for p in self._outputPorts]

    # ------------------------------------------------------------------

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        return self.scheme.getOperatorInterface(name, pipelineStages=pipelineStages)

    def areaCost(self) -> tuple[int, int]:
        return self.scheme.areaCost()

    def latency(self, pipelineStages: int = 1) -> int:
        return self.scheme.latency(pipelineStages)

    def primingBeats(self) -> int:
        '''Beats before the first output. Demonstrated by `compute()`'s return
        value, not merely claimed.'''
        return self.scheme.primingBeats()

    def minimumStorageElements(self) -> int:
        return self.scheme.minimumStorageElements()

    # --- emitRtl: nothing to emit ---------------------------------------

    def emitRtl(self, name: str, run_dir, **kwargs) -> dict:
        raise NotImplementedError(
            f'{self.name}: MatrixTranspose emits no RTL — rtl_gen/transpose.py '
            f'does not exist, and no storage architecture has been chosen for '
            f'it to generate. Use this operator to move bounds and values '
            f'through a corner turn and to size what it holds; pick a real '
            f'scheme when you need hardware.'
        )

    def _generatorTarget(self) -> tuple[str, str, str]:
        raise NotImplementedError(
            f'{self.name}: there is no transpose generator to target.'
        )

    def _prepareTestData(self, spec, test_size: int, seed: int | None,
                         **kwargs) -> dict:
        raise NotImplementedError(
            f'{self.name}: there is no transpose generator to feed.'
        )

    def _generatorKwargs(self, data: dict) -> dict:
        raise NotImplementedError(
            f'{self.name}: there is no transpose generator to feed.'
        )
