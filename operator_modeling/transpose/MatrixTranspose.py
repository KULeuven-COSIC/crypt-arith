'''The matrix-transpose operator: step four of a four-step NTT.

    scheme = BehaviouralMatrixTranspose(name='t', rows=128, cols=128)
    op     = MatrixTranspose(name='corner_turn', scheme=scheme)

    op.drive([Signal(bound[r], values[r]) for r in range(128)])
    op.compute()
    out = op.read()

A batch of `T * rows` is read as `T` stacked matrices, slot `b = t*rows + r`
being row `r` of matrix `t`:

    out[c].values[t*rows + r] == in[r].values[t*rows + c]

At `T = 1` that is the plain matrix transpose. Keeping it batch-at-once is what
lets it connect to the rest of the project through ports: `push()` overwrites
rather than accumulates, so an operator that consumed one row per `compute()`
could never be wired to one that reads a whole batch — every row but the last
would be thrown away, silently. Reading whole matrices out of the batch removes
that mismatch instead of guarding against it.

The price is the one constraint in the project on batch length: it must be a
multiple of `rows`, because the batch axis now carries the row index as well as
the trial index. `MatrixTransposeScheme.matrixCount` is where that is enforced.

Bounds cannot stay per element under that arrangement. A port carries one bound
for its whole batch, and output lane `c` draws from every input lane as `r`
sweeps, so every output bound is `IntType.union` of every input bound. In a
four-step this costs nothing — the inter-stage bounds are identical — but it is
a real widening when the input lanes differ.
'''
from __future__ import annotations

from ..core.Operator import Operator
from ..core.Port import SimpleInputPort, SimpleOutputPort
from ..core.Signal import Signal
from .MatrixTransposeScheme import MatrixTransposeScheme


class MatrixTranspose(Operator):
    '''A corner turn as a connectable operator: `rows` lanes in, `cols` out.'''

    def __init__(self, name: str = 'Undefined MatrixTranspose',
                 scheme: MatrixTransposeScheme | None = None):
        super().__init__(name)
        if scheme is None:
            raise ValueError(f'{name}: MatrixTranspose requires a scheme')
        self.scheme = scheme
        # Input lanes are indexed by row, output lanes by column — see the
        # formula above. Equal while the transpose is square.
        self._inputPorts = [SimpleInputPort(f'{name} Input Port r{r}')
                            for r in range(scheme.rows)]
        self._outputPorts = [SimpleOutputPort(f'{name} Output Port c{c}')
                             for c in range(scheme.cols)]

    @property
    def inputPorts(self) -> list:
        return self._inputPorts

    @property
    def outputPorts(self) -> list:
        return self._outputPorts

    # ------------------------------------------------------------------

    def compute(self) -> None:
        '''Transpose every matrix the loaded batch carries.

        Bounds always; values too when every lane has them, so a sizing-only
        pass works exactly as in `ConstMultBank.compute()`.
        '''
        signals = [p.signal for p in self._inputPorts]
        missing = [i for i, s in enumerate(signals) if s is None]
        if missing:
            raise ValueError(
                f'{self.name}.compute: input lanes {missing[:8]}'
                f'{"..." if len(missing) > 8 else ""} have no signal. A transpose '
                f'consumes whole matrices, so every lane must be driven.'
            )

        self.scheme.aIn = [s.bound for s in signals]
        outBounds = self.scheme.propagateBound()

        outValues = None
        if all(s.values is not None for s in signals):
            self.scheme.aInValues = [s.values for s in signals]
            outValues = self.scheme.propagateValue()

        for c, port in enumerate(self._outputPorts):
            port.signal = Signal(outBounds[c],
                                 outValues[c] if outValues is not None else None)
            if port.isConnected:
                port.push()

    # ------------------------------------------------------------------

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        return self.scheme.getOperatorInterface(name, pipelineStages=pipelineStages)

    def areaCost(self) -> tuple[int, int]:
        return self.scheme.areaCost()

    def latency(self, pipelineStages: int = 1) -> int:
        return self.scheme.latency(pipelineStages)

    def primingBeats(self) -> int:
        '''Beats of hardware latency before the first output row. Declared: this
        model is batch-at-once and untimed, so nothing here demonstrates it.'''
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
