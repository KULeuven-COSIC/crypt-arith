'''Framework for modelling general (non-constant) multipliers, `P = A * B`.

Several implementations are planned — tiling, Karatsuba, schoolbook, plus the
existing radix-4 Booth multiplier as an opaque primitive. They differ in exactly
one way: how the multiplication is broken into smaller multiplications. So that
is the only thing a subclass writes.

    class MyStrategy(MultiplierScheme):
        def _buildDecomposition(self):
            ...
            return operandWires, subMults, recombinationTerms

Everything else — bound propagation, value propagation, spec extraction, area,
latency, `selfCheck`, `emitRtl` — is concrete on the base class and is never
overridden. A new strategy is one method, in the region of 40 to 70 lines.

`_buildDecomposition` returns three things:

  `operandWires`    `list[WireDef]`, topologically ordered: the operands of the
                    sub-multiplications, each a signed sum of shifted slices of
                    the inputs or of earlier wires.
  `subMults`        `list[(productName, opAWireName, opBWireName, childScheme)]`.
  `recombination`   `list[SliceTerm]` over the product names, giving the output.

A leaf — a multiplier with no internal structure, such as `BoothMult` — returns
`([], [], [])` and is handed to a primitive generator whole.

Why operands are expressions rather than bit ranges
---------------------------------------------------
Karatsuba's middle product is `(A1 + A0) * (B1 + B0)`, so an operand cannot be
just "a slice of A". Representing it as a `SliceTerm` list handles that, and
gets the width right where a hand-written formula does not: splitting a signed
24-bit `A` at bit 12 yields a *signed* 12-bit high half and an *unsigned* 12-bit
low half, so `A1 + A0` spans `[-2048, 6142]` and needs 14 bits rather than the
13 one might expect. `IntType` produces that with no special-casing, which is
what makes the framework able to absorb strategies it was not designed around.
'''
from __future__ import annotations

import os as _os
import random as _random
import sys as _sys
from abc import abstractmethod
from typing import Callable

from ..core.IntType import IntType
from ..core.OperatorScheme import OperatorScheme, resolveBackend, runInDir, sampleBound
from ..core.terms import sumTermsBound, sumTermsValue

_versalArithDir = _os.path.normpath(
    _os.path.join(_os.path.dirname(__file__), '..', '..', 'versal_arith'))
if _versalArithDir not in _sys.path:
    _sys.path.append(_versalArithDir)
from butterfly_spec import SliceTerm                              # noqa: E402
from mult_spec import MultOperatorSpec, SubMultRef, WireDef       # noqa: E402

#: Smallest operand the radix-4 Booth generator accepts (`booth_mult.py`).
BOOTH_MIN_WIDTH = 6


def physicalWidthFor(bound: IntType, requireSigned: bool = False) -> int:
    '''Width of the wire that carries `bound`.

    `requireSigned` adds a bit to an unsigned bound so it can be fed to a
    generator that only handles two's-complement operands — the Booth
    multiplier, for instance, treats both operands as signed unconditionally.
    '''
    width = bound.bitWidth
    if requireSigned and not bound.isSigned:
        width += 1
    return max(width, 1)


def wireFromTerms(name: str, terms: list[SliceTerm],
                  env: dict[str, IntType],
                  requireSigned: bool = False) -> tuple[WireDef, IntType]:
    '''Build a `WireDef` from its terms, sizing it by propagating the bound.

    Returns the definition and the `IntType` it carries, so the caller can put
    the latter straight into the environment for wires defined after it.
    '''
    bound = sumTermsBound(terms, env)
    return WireDef(
        name=name,
        terms=terms,
        bitWidth=physicalWidthFor(bound, requireSigned),
        isSigned=bound.isSigned or requireSigned,
        minValue=bound.minValue,
        maxValue=bound.maxValue,
        zeroLsbs=bound.zeroLsbs,
    ), bound


def sliceTerm(source: str, bound: IntType, start: int, end: int,
              shift: int = 0, sign: int = 1) -> SliceTerm:
    '''Term taking bits `start..end` of `source`, weighted `sign * 2**shift`.

    `isSigned` is **derived** from `bound.slice(start, end)` rather than passed
    in, because getting it wrong is both easy and silent. Splitting a signed
    value in half is the trap: the high slice reaches the top of the value so
    `IntType.slice` keeps its sign, while the low slice is an interior window
    and comes back unsigned. A strategy author should not have to remember that,
    and with this helper they do not.
    '''
    return SliceTerm(source=source, inputShift=0, sliceStart=start,
                     sliceEnd=end, isSigned=bound.slice(start, end).isSigned,
                     limbShift=shift, sign=sign, constValue=0)


def wholeTerm(source: str, bound: IntType, shift: int = 0,
              sign: int = 1) -> SliceTerm:
    '''Term taking all of `source` — used to recombine sub-products.'''
    return sliceTerm(source, bound, 0, max(bound.bitWidth - 1, 0), shift, sign)


class MultiplierScheme(OperatorScheme):
    '''`P = A * B`. Subclasses implement `_buildDecomposition` and nothing else.'''

    _BOUND_ATTRS = ('aIn', 'bIn')
    _VALUE_ATTRS = ('aInValues', 'bInValues')

    #: 'leaf' | 'tiling' | 'karatsuba' | 'schoolbook'
    decomposition: str = 'leaf'
    #: Non-empty only for leaves; names the primitive generator.
    leafKind: str = ''

    def __init__(self,
                 name: str = 'Undefined MultiplierScheme',
                 aIn: IntType = IntType(0, 0, 0),
                 bIn: IntType = IntType(0, 0, 0),
                 aInValues: list[int] | None = None,
                 bInValues: list[int] | None = None,
                 leafFactory: Callable[..., 'MultiplierScheme'] | None = None,
                 maxDepth: int = 8,
                 aPortName: str = 'A',
                 bPortName: str = 'B',
                 outPortName: str = 'P',
                 verbose: bool = False):
        super().__init__(name)
        self.aIn = aIn
        self.bIn = bIn
        self.aInValues = aInValues
        self.bInValues = bInValues
        self.leafFactory = leafFactory or defaultLeafFactory
        self.maxDepth = maxDepth
        self.aPortName = aPortName
        self.bPortName = bPortName
        self.outPortName = outPortName
        self.verbose = verbose

    # ------------------------------------------------------------------
    # The single extension point
    # ------------------------------------------------------------------

    @abstractmethod
    def _buildDecomposition(self) -> tuple[
            list[WireDef],
            list[tuple[str, str, str, 'MultiplierScheme']],
            list[SliceTerm]]:
        '''`(operandWires, subMults, recombinationTerms)`; `([], [], [])` for a leaf.'''

    def isLeaf(self) -> bool:
        wires, subMults, terms = self._buildDecomposition()
        return not subMults

    # ------------------------------------------------------------------
    # Concrete: bound and value paths
    # ------------------------------------------------------------------

    def propagateBound(self) -> IntType:
        '''Exact interval of `A * B`.

        As with the constant multiplier, this is the product bound rather than
        the sum of the recombination terms: a decomposition's sub-products are
        correlated (Karatsuba's `k_hi` appears twice, with opposite signs), so
        interval arithmetic over them over-approximates. The identity guarantees
        the true value fits the product bound, and truncating the heap to it is
        exact.
        '''
        super().propagateBound()
        return self.aIn * self.bIn

    def propagateValue(self) -> list[int]:
        '''Output batch, evaluated through the decomposition.

        A leaf multiplies directly. Anything else builds its operand wires, runs
        each child on them, and sums the recombination — recursively, so a
        Karatsuba over Booth leaves exercises every level.
        '''
        super().propagateValue()
        batch = len(self.aInValues)
        wires, subMults, recombination = self._buildDecomposition()

        if not subMults:
            return [a * b for a, b in zip(self.aInValues, self.bInValues)]

        env: dict[str, list[int]] = {
            self.aPortName: self.aInValues,
            self.bPortName: self.bInValues,
        }
        for wire in wires:
            env[wire.name] = sumTermsValue(wire.terms, env, batch)
        for productName, opA, opB, child in subMults:
            child.aInValues = env[opA]
            child.bInValues = env[opB]
            env[productName] = child.propagateValue()
        return sumTermsValue(recombination, env, batch)

    def selfCheck(self, testSize: int = 256, seed: int | None = None) -> None:
        '''Assert the decomposition actually computes `A * B`.

        Free validation for any new strategy: sign and shift mistakes in a
        recombination show up here, before a spec is extracted or a line of RTL
        is emitted.
        '''
        rng = _random.Random(seed) if seed is not None else _random
        savedA, savedB = self.aInValues, self.bInValues
        try:
            self.aInValues = sampleBound(self.aIn, testSize, rng)
            self.bInValues = sampleBound(self.bIn, testSize, rng)
            got = self.propagateValue()
            want = [a * b for a, b in zip(self.aInValues, self.bInValues)]
            for i, (g, w) in enumerate(zip(got, want)):
                if g != w:
                    raise AssertionError(
                        f'{self.name} ({self.decomposition}): decomposition '
                        f'computes {g} for A={self.aInValues[i]}, '
                        f'B={self.bInValues[i]}, expected {w}'
                    )
        finally:
            self.aInValues, self.bInValues = savedA, savedB

    # ------------------------------------------------------------------
    # Concrete: latency and area
    # ------------------------------------------------------------------

    def latency(self, pipelineStages: int = 1) -> int:
        '''Children run in parallel, so a node costs its deepest child plus its
        own recombination.'''
        if pipelineStages < 1:
            raise ValueError(f'{self.name}: pipelineStages must be >= 1')
        _, subMults, recombination = self._buildDecomposition()
        if not subMults:
            return self._leafLatency(pipelineStages)
        childLatency = max(child.latency(pipelineStages)
                           for _, _, _, child in subMults)
        return childLatency + (pipelineStages if recombination else 0)

    def _leafLatency(self, pipelineStages: int) -> int:
        '''Leaf latency; overridden by concrete leaves that know their generator.'''
        return pipelineStages

    def areaCost(self) -> tuple[int, int]:
        '''Own recombination heap plus the children, de-duplicated.

        Children are keyed by operand width pair, matching how the generator
        emits one module per distinct `(wa, wb)` and instantiates it repeatedly —
        counting a shared `Bmult16x16` four times would badly overstate a
        four-tile design.
        '''
        _, subMults, recombination = self._buildDecomposition()
        if not subMults:
            return self._leafAreaCost()

        seen: dict[tuple[int, int], tuple[int, int]] = {}
        for _, _, _, child in subMults:
            key = (child.aIn.bitWidth, child.bIn.bitWidth)
            if key not in seen:
                seen[key] = child.areaCost()
        lut = sum(c[0] for c in seen.values())
        dsp = sum(c[1] for c in seen.values())

        if recombination:
            from rtl_gen.heap_terms import buildHeapDescriptors, countCompressionLayers, heapLutCost

            outWidth = self.propagateBound().bitWidth
            _, _, bitheapList, widthBh = buildHeapDescriptors(
                recombination, outWidth, '')
            if bitheapList:
                _, layers, finals = countCompressionLayers(bitheapList, widthBh)
                lut += heapLutCost(layers, finals)
        return lut, dsp

    def _leafAreaCost(self) -> tuple[int, int]:
        raise NotImplementedError(
            f'{type(self).__name__} is a leaf but does not implement '
            f'_leafAreaCost'
        )

    # ------------------------------------------------------------------
    # Concrete: spec extraction
    # ------------------------------------------------------------------

    def getOperatorInterface(self, name: str,
                             pipelineStages: int = 1) -> MultOperatorSpec:
        wires, subMults, recombination = self._buildDecomposition()
        outBound = self.propagateBound()

        refs: list[SubMultRef] = []
        childLatencies: list[int] = []
        for productName, opA, opB, child in subMults:
            childLeaf = child.isLeaf()
            childLatencies.append(child.latency(pipelineStages))
            refs.append(SubMultRef(
                name=productName,
                opAWire=opA,
                opBWire=opB,
                leafKind=child.leafKind if childLeaf else '',
                childSpec=(None if childLeaf
                           else child.getOperatorInterface(
                               f'{name}_{productName}', pipelineStages)),
                outBitWidth=child.propagateBound().bitWidth,
                outIsSigned=child.propagateBound().isSigned,
                latency=childLatencies[-1],
            ))

        return MultOperatorSpec(
            name=name,
            decomposition=self.decomposition,
            leafKind=self.leafKind if not subMults else '',
            aPortName=self.aPortName,
            bPortName=self.bPortName,
            outPortName=self.outPortName,
            aInBitWidth=self.aIn.bitWidth,
            aInIsSigned=self.aIn.isSigned,
            bInBitWidth=self.bIn.bitWidth,
            bInIsSigned=self.bIn.isSigned,
            pOutBitWidth=outBound.bitWidth,
            pOutIsSigned=outBound.isSigned,
            pOutMinValue=outBound.minValue,
            pOutMaxValue=outBound.maxValue,
            pOutZeroLsbs=outBound.zeroLsbs,
            operandWires=wires,
            subMults=refs,
            pOutTerms=recombination,
            uniformChildLatency=max(childLatencies) if childLatencies else 0,
            latency=self.latency(pipelineStages),
        )

    def emitRtl(self, name: str, run_dir, **kwargs) -> dict:
        raise NotImplementedError(
            f'{type(self).__name__}.emitRtl: the general-multiplier generator '
            f'(rtl_gen/mult.py) is not implemented yet. Only the modelling '
            f'framework and the BoothMult leaf have landed; see the plan and '
            f'docs/REFACTOR_BACKLOG.md.'
        )


class BoothMult(MultiplierScheme):
    '''Radix-4 Booth multiplier — an opaque leaf around `Bmult_RTL_gen`.

    The generator treats both operands as two's complement unconditionally and
    requires at least 6 bits each, so a parent that feeds it an unsigned operand
    must widen by one bit — `physicalWidthFor(bound, requireSigned=True)`.
    '''

    decomposition = 'leaf'
    leafKind = 'booth'

    def _buildDecomposition(self):
        return [], [], []

    def physicalWidths(self) -> tuple[int, int]:
        '''`(widthA, widthB)` as the Booth generator will see them.'''
        return (physicalWidthFor(self.aIn, requireSigned=True),
                physicalWidthFor(self.bIn, requireSigned=True))

    def checkGeneratorLimits(self) -> None:
        wa, wb = self.physicalWidths()
        if wa < BOOTH_MIN_WIDTH or wb < BOOTH_MIN_WIDTH:
            raise ValueError(
                f'{self.name}: Bmult_RTL_gen needs both operands at least '
                f'{BOOTH_MIN_WIDTH} bits, got {wa}x{wb}. Use a schoolbook leaf '
                f'for operands this small.'
            )

    def _leafLatency(self, pipelineStages: int) -> int:
        return pipelineStages

    def _leafAreaCost(self) -> tuple[int, int]:
        '''Partial-product heap plus its compressor tree.

        Reproduces the heap shape `booth_mult.py` builds: `wb/2` radix-4 rows
        each spanning `wa+2` columns from column `2i`, one extra bit per row for
        the Booth negation, and one Baugh-Wooley constant at column `wa`.
        '''
        from rtl_gen.heap_terms import countCompressionLayers, heapLutCost

        wa, wb = self.physicalWidths()
        wa += wa % 2          # the generator rounds each operand up to even
        wb += wb % 2
        if wb < wa:           # and swaps so the recoded operand is the wider one
            wa, wb = wb, wa

        heights = [0] * (wa + wb)
        for i in range(wb // 2):
            for j in range(wa + 2):
                if 2 * i + j < len(heights):
                    heights[2 * i + j] += 1
            heights[2 * i] += 1
        heights[wa] += 1

        widthBh = sum(h * (2 ** c) for c, h in enumerate(heights)).bit_length()
        # terminal_layers=2: Booth prepends a partial-product generation layer.
        _, layers, finals = countCompressionLayers(heights, widthBh,
                                                   terminal_layers=2)
        return heapLutCost(layers, finals), 0

    def emitRtl(self, name: str, run_dir,
                pipeline_stages: int = 1,
                gen_testbench: bool = False,
                **kwargs) -> dict:
        '''Emit the Booth multiplier via the existing scalar generator.

        `gen_testbench` defaults to **False**: the generator writes
        `testvectors/{A,B,P}.txt`, which would overwrite a parent multiplier's
        shared testvector directory when this is instantiated as a leaf.
        '''
        self.checkGeneratorLimits()
        wa, wb = self.physicalWidths()

        def _call():
            from rtl_gen.booth_mult import Bmult_RTL_gen
            Bmult_RTL_gen(width_a=wa, width_b=wb,
                          pipeline_stages=pipeline_stages,
                          gen_testbenches=gen_testbench,
                          test_size=kwargs.get('test_size', 1000))

        runInDir(run_dir, _call)
        return {
            'module': f'Bmult{wa}x{wb}',
            'leafKind': self.leafKind,
            'aIn_bit_width': wa,
            'bIn_bit_width': wb,
            'pOut_bit_width': wa + wb,
            'pipeline_latency': pipeline_stages,
        }


def defaultLeafFactory(name: str, aIn: IntType, bIn: IntType,
                       **kwargs) -> MultiplierScheme:
    '''Pick a leaf for a pair of operand bounds.

    Booth whenever both operands reach its minimum width. Smaller operands have
    no leaf yet — `SchoolbookMult` lands with the decomposition strategies.
    '''
    wa = physicalWidthFor(aIn, requireSigned=True)
    wb = physicalWidthFor(bIn, requireSigned=True)
    if wa >= BOOTH_MIN_WIDTH and wb >= BOOTH_MIN_WIDTH:
        return BoothMult(name=name, aIn=aIn, bIn=bIn, **kwargs)
    raise NotImplementedError(
        f'{name}: operands {wa}x{wb} are below the Booth minimum of '
        f'{BOOTH_MIN_WIDTH} and SchoolbookMult is not implemented yet'
    )
