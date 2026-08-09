'''Common base for hardware operator models, plus the `emitRtl` plumbing.

`ButterflyScheme` established the shape every operator model in this project
follows: an interval-bound path for sizing the datapath, a value-batch path for
producing testbench goldens, a spec extracted for the RTL generator, and an
`emitRtl` that ties them together. This module lifts that shape into a base class
so constant multipliers and general multipliers do not each reinvent it.

Two differences from `ButterflyScheme`, both deliberate:

1. **`getOperatorInterface` and `emitRtl` are abstract here.** On
   `ButterflyScheme` they are not declared at all — they exist only on the
   concrete `GoldilocksSlice64`, so the ABC does not actually describe the
   contract its users rely on.

2. **Bound inputs and value inputs are separate attributes.**
   `GoldilocksSlice64` reuses one `aIn` slot for both an `IntType` and a
   `list[int]`, which forces `Butterfly.compute()` to run the bound path first
   and to smuggle the register width across in `aInBitWidth`. Keeping `aIn` and
   `aInValues` apart lets the value path call the term builder (which needs
   bounds) directly, and removes the back-channel.

`ButterflyScheme` is not reparented onto this class — that work is additive-only
by scope. See `docs/REFACTOR_BACKLOG.md` item 4.
'''
from __future__ import annotations

import os
import random
from abc import ABC, abstractmethod
from pathlib import Path

from .IntType import IntType


class OperatorScheme(ABC):
    '''Base for a modelled arithmetic operator.

    Subclasses declare which attributes carry bounds and which carry value
    batches, then call `super().propagateBound()` / `super().propagateValue()`
    for the shared type checks — the same idiom `ButterflyScheme` uses, where the
    abstract body exists for its side effect and its return value is discarded.

    Keeping the two paths separated by type is what stops an `IntType` reaching
    the value path or a `list[int]` reaching the bound path, either of which
    would produce silently wrong arithmetic rather than an error.
    '''

    #: Attribute names expected to hold an `IntType` when the bound path runs.
    _BOUND_ATTRS: tuple[str, ...] = ()
    #: Attribute names expected to hold a `list[int]` when the value path runs.
    _VALUE_ATTRS: tuple[str, ...] = ()

    def __init__(self, name: str = 'Undefined Operator Scheme'):
        self.name: str = name

    # ------------------------------------------------------------------
    # Abstract surface
    # ------------------------------------------------------------------

    @abstractmethod
    def propagateBound(self):
        '''Interval(s) this operator's output(s) can take.

        The base body only validates; subclasses call it via `super()` first.
        '''
        for attr in self._BOUND_ATTRS:
            value = getattr(self, attr, None)
            if not isinstance(value, IntType):
                raise TypeError(
                    f'{type(self).__name__}.propagateBound: {attr} must be an '
                    f'IntType, got {type(value).__name__}. (Value batches belong '
                    f'in {self._VALUE_ATTRS or "the value attributes"}.)'
                )

    @abstractmethod
    def propagateValue(self):
        '''Output value batch(es) for the loaded input batches.

        The base body only validates; subclasses call it via `super()` first.
        '''
        lengths: set[int] = set()
        for attr in self._VALUE_ATTRS:
            value = getattr(self, attr, None)
            if not isinstance(value, list):
                raise TypeError(
                    f'{type(self).__name__}.propagateValue: {attr} must be a '
                    f'list[int], got {type(value).__name__}. (Bounds belong in '
                    f'{self._BOUND_ATTRS or "the bound attributes"}.)'
                )
            if not all(isinstance(x, int) for x in value):
                raise TypeError(
                    f'{type(self).__name__}.propagateValue: {attr} must contain '
                    f'only ints'
                )
            lengths.add(len(value))
        if len(lengths) > 1:
            raise ValueError(
                f'{type(self).__name__}.propagateValue: input batches have '
                f'differing lengths {sorted(lengths)}'
            )

    @abstractmethod
    def areaCost(self) -> tuple[int, int]:
        '''`(LUT, DSP)` for FPGA targets, or `(area, 0)` for ASIC.'''

    @abstractmethod
    def getOperatorInterface(self, name: str):
        '''Frozen spec dataclass for the RTL generator.'''

    @abstractmethod
    def latency(self, pipelineStages: int = 1) -> int:
        '''Pipeline registers this scheme's hardware can absorb.

        Three of the four schemes already had this; the butterfly's absence was
        a gap rather than a design choice, and it is what `areaCost` and any
        future cost-driven search need alongside area.
        '''

    # NOTE: `emitRtl` is deliberately NOT on this ABC. Generating files is the
    # operator's job — it owns the ports, the sampling and the run directory —
    # while a scheme only answers questions about arithmetic. See
    # `core.Operator.Operator.emitRtl`, whose template absorbs the eight steps
    # every hand-written implementation used to repeat.

    # ------------------------------------------------------------------
    # Shared batch length helper
    # ------------------------------------------------------------------

    def batchSize(self) -> int:
        '''Length of the loaded value batches (0 when none are loaded).'''
        for attr in self._VALUE_ATTRS:
            value = getattr(self, attr, None)
            if isinstance(value, list):
                return len(value)
        return 0


# ----------------------------------------------------------------------
# emitRtl helpers
#
# Extracted from the boilerplate that GoldilocksSlice64.emitRtl and
# FullyPipelinedNTT.emitRtl each carry: mkdir -> spec -> goldens -> lazy backend
# import -> chdir -> generate -> sanity check -> return meta.
# ----------------------------------------------------------------------


def sampleRegisterRange(bitWidth: int, isSigned: bool, count: int,
                        rng: random.Random | None = None) -> list[int]:
    '''Uniform samples over the whole register a port declares.

    This is what `GoldilocksSlice64.emitRtl` does: exercise every bit pattern the
    hardware register can hold, regardless of how tight the modelled bound is.
    '''
    r = rng or random
    if bitWidth <= 0:
        return [0] * count
    if isSigned:
        lo, hi = -(1 << (bitWidth - 1)), (1 << (bitWidth - 1)) - 1
    else:
        lo, hi = 0, (1 << bitWidth) - 1
    return [r.randint(lo, hi) for _ in range(count)]


def sampleBound(bound: IntType, count: int,
                rng: random.Random | None = None) -> list[int]:
    '''Uniform samples from inside `bound`, respecting its known-zero LSBs.

    Preferred over `sampleRegisterRange` for multiplier models, for a reason
    specific to how the bit heap is built: the term builders **drop slices that
    are provably zero**, so the emitted hardware has no bits in those positions
    at all. Feeding it a testvector with nonzero bits down there makes the RTL
    and the golden disagree — the golden would carry the extra weight, the
    hardware would not.

    Butterflies never hit this because their primary-input bounds have
    `zeroLsbs == 0`. A constant multiplier fed from a bank output can have
    `zeroLsbs > 0`, so sampling has to honour it.
    '''
    r = rng or random
    if bound.isZero:
        return [0] * count
    step = 1 << bound.zeroLsbs
    lo = -((-bound.minValue) // step) if bound.minValue < 0 else bound.minValue // step
    hi = bound.maxValue // step
    if lo > hi:  # interval narrower than one step; the only multiple is 0
        return [0] * count
    return [r.randint(lo, hi) * step for _ in range(count)]


def resolveBackend(backend: str, moduleStem: str, hwEntry: str, simEntry: str):
    '''Import a generator entry point for the `'hw'` or `'sim'` backend.

    Imported lazily, at call time, so merely importing a model does not drag in
    `rtl_gen`'s generator chain (and, through `bitheap`, matplotlib).

    `moduleStem` is the module name shared by both packages, e.g. `'const_mult_op'`
    resolves to `rtl_gen.const_mult_op` / `sim_rtl_gen.const_mult_op`.
    '''
    import importlib

    if backend == 'hw':
        package, entry = 'rtl_gen', hwEntry
    elif backend == 'sim':
        package, entry = 'sim_rtl_gen', simEntry
    else:
        raise ValueError(f"backend must be 'hw' or 'sim', got {backend!r}")

    try:
        module = importlib.import_module(f'{package}.{moduleStem}')
    except ImportError as e:
        raise ImportError(
            f'{backend} backend: cannot import {package}.{moduleStem} ({e}). '
            f'versal_arith/ must be on sys.path — importing any operator_modeling '
            f'module arranges that.'
        ) from e
    try:
        return getattr(module, entry)
    except AttributeError as e:
        raise ImportError(
            f'{package}.{moduleStem} has no entry point {entry!r}'
        ) from e


def runInDir(runDir, fn, /, **kwargs):
    '''Call `fn(**kwargs)` with the process cwd inside `runDir`.

    Every generator writes `RTL_generated/`, `testvectors/` and friends relative
    to the cwd, so the caller has to move there. The directory is created if
    needed and the original cwd is always restored.
    '''
    runDir = Path(runDir)
    runDir.mkdir(parents=True, exist_ok=True)
    saved = os.getcwd()
    os.chdir(str(runDir))
    try:
        return fn(**kwargs)
    finally:
        os.chdir(saved)


def decodeTwosComplement(raw: int, bitWidth: int, isSigned: bool) -> int:
    '''Interpret `bitWidth` raw bits as a Python int.'''
    if isSigned and bitWidth > 0 and (raw >> (bitWidth - 1)) & 1:
        return raw - (1 << bitWidth)
    return raw


def readHexBatch(path, count: int, bitWidth: int, isSigned: bool) -> list[int]:
    '''Read the first `count` hex lines of a testvector file as Python ints.

    Used by the local sanity checks that re-run the value path over what was
    actually written to disk, catching two's-complement encoding bugs before any
    simulation is scheduled.
    '''
    path = Path(path)
    if not path.is_file():
        raise FileNotFoundError(f'testvector file not found: {path}')
    out: list[int] = []
    with open(path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            out.append(decodeTwosComplement(int(line, 16), bitWidth, isSigned))
            if len(out) >= count:
                break
    if not out:
        raise ValueError(f'testvector file is empty: {path}')
    return out
