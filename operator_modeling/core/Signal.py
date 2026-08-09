'''What a wire carries: a bound, and optionally a batch of values drawn from it.

A modelled wire has to answer two different questions. *How wide must the
hardware be?* — that is the bound, an `IntType` interval. *What numbers actually
appear, so a testbench can check them?* — that is a batch of Python ints. Both
travel the same graph, so both live on the same object.

The asymmetry between them is the design, not an accident:

    bound   is the wire's TYPE.   Always present. Sole source of width and
                                  signedness.
    values  are an optional SAMPLE of that type. May be absent, and their
            absence is a legitimate state, not a broken one.

**Why the bound alone decides width.** A batch of values cannot tell you how
wide the register is — if the sample happens not to exercise the top bits, any
width measured from it is too small. That mattered concretely: the Goldilocks
butterfly slices its input at the register boundary to decide which limb gets
sign-extended, and a width measured from the data instead of the bound puts that
boundary in the wrong place, producing a result wrong by a multiple of `q`. So
width questions are answered here, by `bound`, and never by inspecting `values`.

**Why one object rather than two fields.** When the two are separate fields they
can be updated independently, and a pass that refreshes only one leaves the wire
in a half-state — which is exactly what forced every driver script to load bounds
and values back-to-back before computing. A `Signal` is replaced whole, so a
half-state cannot be represented.

**On ordering.** Bound-before-value is a constraint *within* one operator: it
computes its output bound, then slices values at bound-derived widths. It is not
a constraint on the graph. Because every operator does it internally, a single
forward pass carries both flows in lockstep.
'''
from __future__ import annotations

from dataclasses import dataclass, replace

from .IntType import IntType


@dataclass(frozen=True)
class Signal:
    '''One wire's payload. Frozen: replace it, never mutate it in place.'''

    bound: IntType
    values: list[int] | None = None

    # --- everything below delegates to the bound, by design ---------------

    @property
    def bitWidth(self) -> int:
        return self.bound.bitWidth

    @property
    def isSigned(self) -> bool:
        return self.bound.isSigned

    @property
    def zeroLsbs(self) -> int:
        return self.bound.zeroLsbs

    @property
    def hasValues(self) -> bool:
        return self.values is not None

    @property
    def batchSize(self) -> int:
        return len(self.values) if self.values is not None else 0

    # --- construction helpers --------------------------------------------

    def withValues(self, values: list[int] | None) -> 'Signal':
        '''Same bound, different sample. The normal way to add data to a wire.'''
        return replace(self, values=values)

    def withBound(self, bound: IntType) -> 'Signal':
        '''Same sample, different bound. Rare; mostly for re-sizing a driver.'''
        return replace(self, bound=bound)

    # --- checking ---------------------------------------------------------

    def validate(self) -> None:
        '''Raise if the sample contradicts the type it claims to be drawn from.

        Not called on the hot path — bound propagation is deliberately
        conservative, so a value outside its bound means a modelling error
        upstream rather than a slightly loose interval. Useful in tests and when
        debugging a new operator.
        '''
        if not isinstance(self.bound, IntType):
            raise TypeError(
                f'Signal.bound must be an IntType, got '
                f'{type(self.bound).__name__}'
            )
        if self.values is None:
            return
        if not isinstance(self.values, list):
            raise TypeError(
                f'Signal.values must be a list[int] or None, got '
                f'{type(self.values).__name__}'
            )
        step = 1 << self.bound.zeroLsbs
        for i, v in enumerate(self.values):
            if not isinstance(v, int):
                raise TypeError(f'Signal.values[{i}] is {type(v).__name__}, not int')
            if v < self.bound.minValue or v > self.bound.maxValue:
                raise ValueError(
                    f'Signal.values[{i}] = {v} lies outside its bound '
                    f'{self.bound}'
                )
            if step > 1 and v % step != 0:
                raise ValueError(
                    f'Signal.values[{i}] = {v} is not a multiple of '
                    f'2^{self.bound.zeroLsbs}, which the bound claims for every '
                    f'value on this wire'
                )

    def __repr__(self) -> str:
        if self.values is None:
            return f'Signal({self.bound}, no values)'
        return f'Signal({self.bound}, {len(self.values)} values)'
