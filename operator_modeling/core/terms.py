'''Evaluate a `SliceTerm` list, on either the bound path or the value path.

A hardware signal in this project is a **sum of pieces of other signals**. One
piece is a `SliceTerm` (`versal_arith/butterfly_spec.py`), whose contract is::

    contribution = sign * ( ((source << inputShift)[sliceEnd:sliceStart])
                            << limbShift )

In English: take signal `source`, shift it left by `inputShift`, keep bits
`sliceStart .. sliceEnd` inclusive, shift that left by `limbShift`, then add it
(or subtract it, when `sign` is -1). `source` is just a signal name that the RTL
generator prints literally, so nothing about the record is butterfly-specific.

A whole wire is therefore a `list[SliceTerm]`, and this module answers the only
two questions ever asked of one:

  - `sumTermsBound`  -> what interval can the sum take?  (datapath sizing)
  - `sumTermsValue`  -> what are the actual numbers, for a batch of test
                        inputs?  (goldens for the testbench)

Both take an `env` mapping a signal name to its bound / its value batch, which is
the only difference from `GoldilocksSlice64._sumSliceTerms`: that method reads
`self.aIn` / `self.bIn` directly and so is limited to a two-input operator.

Keeping both on one term list is what stops the two paths drifting. The bound and
the RTL spec already share a source of truth in the butterfly
(`_buildSliceTerms`); the value path there does not, and re-implements the slicing
independently. New models route all three through here instead — see
`docs/REFACTOR_BACKLOG.md` item 2 for retrofitting the butterfly.
'''
from __future__ import annotations

import os as _os
import sys as _sys

from .IntType import IntType
from .utils import vectorAdd, vectorConst, vectorLshift, vectorSlice, vectorSub

# `versal_arith/` is not a package; the spec dataclasses sit at its top level so
# importing them does not pull in rtl_gen/__init__.py's generator chain. Mirror
# the path append ButterflyScheme.py does.
_versalArithDir = _os.path.normpath(
    _os.path.join(_os.path.dirname(__file__), '..', '..', 'versal_arith'))
if _versalArithDir not in _sys.path:
    _sys.path.append(_versalArithDir)
from butterfly_spec import SliceTerm  # noqa: E402


def sumTermsBound(terms: list[SliceTerm], env: dict[str, IntType]) -> IntType:
    '''Interval taken by the sum of `terms`.

    `env` maps each term's `source` to that signal's bound. A term whose source
    is `'const'` contributes the constant itself and needs no env entry.

    Generalizes `GoldilocksSlice64._sumSliceTerms` (ButterflyScheme.py) by
    replacing its hardcoded `self.aIn` / `self.bIn` lookup with `env`.
    '''
    out = IntType(0, 0, 0)
    for t in terms:
        if t.source == 'const':
            piece = IntType(t.constValue, t.constValue, 0) << t.limbShift
        else:
            if t.source not in env:
                raise KeyError(
                    f'sumTermsBound: no bound for source {t.source!r} '
                    f'(env has {sorted(env)})'
                )
            shifted = env[t.source] << t.inputShift
            piece = shifted.slice(t.sliceStart, t.sliceEnd) << t.limbShift
        out = out + piece if t.sign == 1 else out - piece
    return out


def sumTermsValue(terms: list[SliceTerm], env: dict[str, list[int]],
                  batchSize: int) -> list[int]:
    '''Per-element values of the sum of `terms`, over a batch of `batchSize`.

    The value-path mirror of `sumTermsBound`: every step here pairs with the
    `IntType` operator used there — `vectorLshift` with `<<`, `vectorSlice` with
    `IntType.slice`, `vectorAdd` / `vectorSub` with `+` / `-`.

    Slice signedness comes from `term.isSigned`, which was recorded when the
    bound path chose its `IntType.slice` branch. That is the point of routing
    both paths through one term list: the value path does not re-derive whether
    a slice is a boundary slice, it is told.

    Results are unreduced Python ints, matching `propagateValue` elsewhere in the
    package — the caller masks to the port width when writing testvectors.
    '''
    out = vectorConst(0, batchSize)
    for t in terms:
        if t.source == 'const':
            piece = vectorConst(t.constValue << t.limbShift, batchSize)
        else:
            if t.source not in env:
                raise KeyError(
                    f'sumTermsValue: no values for source {t.source!r} '
                    f'(env has {sorted(env)})'
                )
            values = env[t.source]
            if len(values) != batchSize:
                raise ValueError(
                    f'sumTermsValue: source {t.source!r} has {len(values)} '
                    f'values, expected batchSize={batchSize}'
                )
            shifted = vectorLshift(values, t.inputShift)
            sliced = vectorSlice(shifted, t.sliceStart, t.sliceEnd,
                                 signed=t.isSigned)
            piece = vectorLshift(sliced, t.limbShift)
        out = vectorAdd(out, piece) if t.sign == 1 else vectorSub(out, piece)
    return out


def termSources(terms: list[SliceTerm]) -> set[str]:
    '''Signal names `terms` reads, excluding `'const'`.

    Lets a caller check an env covers a term list before evaluating it, and lets
    the general-multiplier framework topologically order its wire definitions.
    '''
    return {t.source for t in terms if t.source != 'const'}
