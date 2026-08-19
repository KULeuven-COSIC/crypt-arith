'''Matrix-transpose schemes: the observable behaviour of a corner turn.

A transpose has no arithmetic. Nothing is added, nothing is multiplied, and no
value ever changes — the same values arrive at different ports. So what a scheme
of this family varies is not a decomposition or a network shape, as it is for
multipliers and NTTs, but the **port contract**: how long before the first
output, how many rows per beat, and how much has to be in flight at once.

That is why the ABC exists even though the transpose itself is one line. A
variant that pauses reception while it drains reports half the throughput and a
different priming figure; it is a sibling scheme over the same operator, not a
constructor flag.

What deliberately does *not* live here is the storage architecture. Two separate
matrix stores is the obvious construction; a single store with skewed addressing
approaches the algorithmic floor. Both satisfy the same port contract, which is
exactly why `areaCost` refuses to answer and only a floor is reported.

**A batch carries whole matrices.** A batch of `B = T * rows` is read as `T`
stacked matrices, with slot `b = t*rows + r` holding row `r` of matrix `t`. That
keeps this operator batch-at-once like every other one in the project, so it
connects to them through ports without an accumulator in between. The price is
that `B` must be a multiple of `rows`, which is the one place in the project a
batch length is constrained.
'''
from __future__ import annotations

from abc import abstractmethod

from ..core.IntType import IntType
from ..core.OperatorScheme import OperatorScheme


class MatrixTransposeScheme(OperatorScheme):
    '''Base for a matrix-transpose architecture. Owns the transpose and the
    declared port contract; the operator owns the ports.

    `_BOUND_ATTRS` / `_VALUE_ATTRS` are empty for the reason `FullyPipelinedGrid`
    leaves them empty: the base class's checks assume one scalar `IntType` per
    named slot, and this scheme holds one per lane. The shape checks below take
    their place.
    '''

    _BOUND_ATTRS = ()
    _VALUE_ATTRS = ()

    def __init__(self, name: str = 'Undefined MatrixTransposeScheme',
                 rows: int = 0, cols: int = 0):
        super().__init__(name)
        if rows <= 0 or cols <= 0:
            raise ValueError(
                f'{name}: rows and cols must be positive, got {rows} x {cols}'
            )
        self.rows = rows
        self.cols = cols
        #: One bound per input lane, length `cols`.
        self.aIn: list[IntType] | None = None
        #: One value batch per input lane, length `cols`; each batch is `T*rows`.
        self.aInValues: list[list[int]] | None = None

    # ------------------------------------------------------------------
    # The declared port contract — what a sibling scheme varies
    # ------------------------------------------------------------------

    @abstractmethod
    def primingBeats(self) -> int:
        '''Beats before the first output row can appear.'''

    @abstractmethod
    def throughputRowsPerBeat(self) -> int:
        '''Rows emitted per beat once primed.'''

    @abstractmethod
    def minimumStorageElements(self) -> int:
        '''Lower bound on elements in flight. A floor, not a cost — it says what
        no implementation can go below, not what any particular one spends.'''

    # ------------------------------------------------------------------
    # Shape checks, standing in for the base class's scalar checks
    # ------------------------------------------------------------------

    def matrixCount(self, batchSize: int) -> int:
        '''How many stacked matrices a batch of `batchSize` carries.

        The one place the batch-length rule is enforced. Everywhere else in this
        project a batch may be any length; here it must be whole matrices,
        because the batch axis carries the row index as well as the trial index.
        '''
        if batchSize <= 0 or batchSize % self.rows:
            raise ValueError(
                f'{self.name}: batch length {batchSize} is not a positive '
                f'multiple of rows={self.rows}. A batch here carries whole '
                f'matrices — slot b = t*{self.rows} + r is row r of matrix t — '
                f'so use {self.rows}, {2 * self.rows}, {3 * self.rows}, ...'
            )
        return batchSize // self.rows

    def _checkLanes(self, lanes, attr: str, expected: int) -> None:
        if not isinstance(lanes, list):
            raise TypeError(
                f'{type(self).__name__}.{attr} must be a list of {expected} '
                f'lanes, got {type(lanes).__name__}'
            )
        if len(lanes) != expected:
            raise ValueError(
                f'{type(self).__name__}.{attr} must have {expected} lanes, '
                f'got {len(lanes)}'
            )

    # ------------------------------------------------------------------
    # The transpose itself — identical for every architecture
    # ------------------------------------------------------------------

    def transposeBatches(self, lanes: list[list[int]]) -> list[list[int]]:
        '''Transpose each stacked matrix within a per-lane batch.

            out[c][t*rows + r] == in[r][t*rows + c]

        The single place the index swap is written; `propagateValue` and the
        operator both route through it, so a row/column mistake cannot exist in
        one and not the other. At `T = 1` this is the plain matrix transpose.
        '''
        self._checkLanes(lanes, 'lanes', self.rows)
        batchSize = len(lanes[0])
        if any(len(v) != batchSize for v in lanes):
            raise ValueError(
                f'{self.name}: lanes carry batches of differing lengths '
                f'{sorted({len(v) for v in lanes})}'
            )
        matrices = self.matrixCount(batchSize)
        rows = self.rows
        return [[lanes[r][t * rows + c]
                 for t in range(matrices) for r in range(rows)]
                for c in range(self.cols)]

    def propagateBound(self) -> list[IntType]:
        '''One bound per output lane.

        Output lane `c` takes slot `t*rows + r` from input lane `r`, so as `r`
        sweeps it draws from **every** input lane. One bound per port for a whole
        batch therefore means every output bound is the union of every input
        bound — and all output lanes end up with the same one.
        '''
        super().propagateBound()
        self._checkLanes(self.aIn, 'aIn', self.rows)
        for c, bound in enumerate(self.aIn):
            if not isinstance(bound, IntType):
                raise TypeError(
                    f'{type(self).__name__}.aIn[{c}] must be an IntType, got '
                    f'{type(bound).__name__}'
                )
        return [IntType.union(self.aIn)] * self.cols

    def propagateValue(self) -> list[list[int]]:
        '''One value batch per output lane, each stacked matrix transposed.'''
        super().propagateValue()
        self._checkLanes(self.aInValues, 'aInValues', self.rows)
        for c, batch in enumerate(self.aInValues):
            if not isinstance(batch, list):
                raise TypeError(
                    f'{type(self).__name__}.aInValues[{c}] must be a list[int], '
                    f'got {type(batch).__name__}'
                )
        return self.transposeBatches(self.aInValues)


class BehaviouralMatrixTranspose(MatrixTransposeScheme):
    '''A corner turn that never pauses reception, modelled and not implemented.

    The hardware contract: one row in every beat, forever; nothing out for the
    first `rows` beats; one transposed row out every beat after that, belonging
    to the matrix received during the previous `rows` beats.

    Only the priming figure is derived, and from the algorithm rather than from
    any hardware: transposed row 0 contains `X[rows-1][0]`, which does not
    arrive until the final beat of the first matrix, so nothing can be emitted
    sooner. Note this is now a *declared* number — the model is batch-at-once and
    untimed like the rest of the project, so nothing here demonstrates it.

    Deliberately **unlike** a real scheme, and for the same reason
    `BehaviouralMult` is:

      - no storage architecture, so no area;
      - no latency of its own, only one the caller declares.

    `areaCost` and `emitRtl` therefore raise rather than returning something
    plausible. A corner turn at n = 128 holds at least 16384 elements in flight,
    which at 130 bits apiece is a quarter of a megabyte — the largest single
    block in a four-step NTT. A placeholder reporting zero would make every
    design containing one look free, which is precisely the comparison a
    placeholder must not corrupt.
    '''

    def __init__(self, name: str = 'Undefined BehaviouralMatrixTranspose',
                 rows: int = 0, cols: int = 0,
                 assumedLatency: int | None = None):
        super().__init__(name, rows, cols)
        if rows != cols:
            raise ValueError(
                f'{name}: only square transposes are supported for now, got '
                f'{rows} x {cols}. The transpose itself already generalises; '
                f'lifting this means relaxing the lane-count and batch-length '
                f'checks together.'
            )
        #: Latency to report. Assumed, not derived — there is no hardware to
        #: derive it from. `primingBeats()` is the separate, provable number.
        self.assumedLatency = assumedLatency

    # --- the declared contract -------------------------------------------

    def primingBeats(self) -> int:
        return self.rows

    def throughputRowsPerBeat(self) -> int:
        return 1

    def minimumStorageElements(self) -> int:
        return self.rows * self.cols

    # --- latency ----------------------------------------------------------

    def latency(self, pipelineStages: int = 1) -> int:
        '''Assumed, not derived. For the number that *is* forced by the
        algorithm, see `primingBeats()`.'''
        if pipelineStages < 1:
            raise ValueError(f'{self.name}: pipelineStages must be >= 1')
        return (self.assumedLatency if self.assumedLatency is not None
                else pipelineStages)

    # --- refusals ---------------------------------------------------------

    def areaCost(self) -> tuple[int, int]:
        raise NotImplementedError(
            f'{self.name}: BehaviouralMatrixTranspose has no area — it models '
            f'the port behaviour and picks no storage architecture, and a '
            f'(LUT, DSP) pair could not express a memory in any case. '
            f'Returning 0 would make the largest block in a four-step NTT look '
            f'free, which is exactly the comparison a placeholder must not '
            f'corrupt. See minimumStorageElements() for the floor '
            f'({self.minimumStorageElements()} elements).'
        )

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        raise NotImplementedError(
            f'{self.name}: there is no transpose_spec.py in versal_arith/, so '
            f'there is no spec dataclass to build. This scheme exists to '
            f'propagate bounds and values through a corner turn, not to '
            f'describe one to a generator.'
        )
