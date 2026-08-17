'''Matrix-transpose schemes: the observable behaviour of a corner turn.

A transpose has no arithmetic. Nothing is added, nothing is multiplied, and no
bound ever widens — the same values arrive at different ports at different
times. So what a scheme of this family varies is not a decomposition or a
network shape, as it is for multipliers and NTTs, but the **port contract**: how
long before the first output, how many rows per beat, and how much has to be in
flight at once.

That is why the ABC exists even though the transpose itself is one line. A
variant that pauses reception while it drains reports half the throughput and a
different priming figure; it is a sibling scheme over the same operator, not a
constructor flag.

What deliberately does *not* live here is the storage architecture. Two separate
matrix stores is the obvious construction; a single store with skewed addressing
approaches the algorithmic floor. Both satisfy the same port contract, which is
exactly why `areaCost` refuses to answer and only a floor is reported.
'''
from __future__ import annotations

from abc import abstractmethod

from ..core.IntType import IntType
from ..core.OperatorScheme import OperatorScheme


class MatrixTransposeScheme(OperatorScheme):
    '''Base for a matrix-transpose architecture. Owns the transpose and the
    declared port contract; the operator owns the beat schedule and the ports.

    `_BOUND_ATTRS` / `_VALUE_ATTRS` are empty for the reason `FullyPipelinedGrid`
    leaves them empty: the base class's checks assume one scalar `IntType` per
    named slot, and this scheme holds a `rows x cols` table of them. The shape
    checks below take their place.
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
        #: `rows x cols` table of per-element bounds.
        self.aIn: list[list[IntType]] | None = None
        #: `rows x cols` table of per-element value batches (the third axis is
        #: the trial batch, which a transpose never touches).
        self.aInValues: list[list[list[int]]] | None = None

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

    def _checkTable(self, table, attr: str) -> None:
        if not isinstance(table, list):
            raise TypeError(
                f'{type(self).__name__}.{attr} must be a rows x cols list of '
                f'lists, got {type(table).__name__}'
            )
        if len(table) != self.rows:
            raise ValueError(
                f'{type(self).__name__}.{attr} must have {self.rows} rows, '
                f'got {len(table)}'
            )
        for r, row in enumerate(table):
            if not isinstance(row, list):
                raise TypeError(
                    f'{type(self).__name__}.{attr}[{r}] must be a list, got '
                    f'{type(row).__name__}'
                )
            if len(row) != self.cols:
                raise ValueError(
                    f'{type(self).__name__}.{attr}[{r}] must have {self.cols} '
                    f'entries, got {len(row)}'
                )

    # ------------------------------------------------------------------
    # The transpose itself — identical for every architecture
    # ------------------------------------------------------------------

    def transposeTable(self, table: list[list], attr: str = 'table') -> list[list]:
        '''Permute a `rows x cols` table into `cols x rows`.

        The single place the index swap is written. `propagateBound`,
        `propagateValue` and `MatrixTranspose`'s own emit path all route through
        here, so a row/column mistake cannot exist in one of them and not the
        others. Entries are moved, never copied or inspected — which is what
        lets the operator pass whole `Signal`s through it.
        '''
        self._checkTable(table, attr)
        return [[table[r][c] for r in range(self.rows)]
                for c in range(self.cols)]

    def propagateBound(self) -> list[list[IntType]]:
        '''Per-element bounds, transposed. Nothing is merged: element (r, c)
        keeps exactly the bound it arrived with, it simply leaves at (c, r).'''
        super().propagateBound()
        self._checkTable(self.aIn, 'aIn')
        for r, row in enumerate(self.aIn):
            for c, bound in enumerate(row):
                if not isinstance(bound, IntType):
                    raise TypeError(
                        f'{type(self).__name__}.aIn[{r}][{c}] must be an '
                        f'IntType, got {type(bound).__name__}'
                    )
        return self.transposeTable(self.aIn, 'aIn')

    def propagateValue(self) -> list[list[list[int]]]:
        '''Per-element value batches, transposed. The trial batch inside each
        element is carried across untouched — a transpose moves data, it never
        computes on it.'''
        super().propagateValue()
        self._checkTable(self.aInValues, 'aInValues')
        lengths = set()
        for r, row in enumerate(self.aInValues):
            for c, batch in enumerate(row):
                if not isinstance(batch, list):
                    raise TypeError(
                        f'{type(self).__name__}.aInValues[{r}][{c}] must be a '
                        f'list[int], got {type(batch).__name__}'
                    )
                lengths.add(len(batch))
        if len(lengths) > 1:
            raise ValueError(
                f'{type(self).__name__}.propagateValue: elements carry batches '
                f'of differing lengths {sorted(lengths)}'
            )
        return self.transposeTable(self.aInValues, 'aInValues')


class BehaviouralMatrixTranspose(MatrixTransposeScheme):
    '''A corner turn that never pauses reception, modelled and not implemented.

    The port contract: one row in every beat, forever; nothing out for the first
    `rows` beats; one transposed row out every beat after that, belonging to the
    matrix received during the previous `rows` beats.

    Only the priming figure is derived, and it is derived from the algorithm
    rather than from any hardware: transposed row 0 contains `X[rows-1][0]`,
    which does not arrive until the final beat of the first matrix, so nothing
    can be emitted sooner.

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
                f'lifting this means relaxing the port-count and beat-period '
                f'checks in MatrixTranspose too.'
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
