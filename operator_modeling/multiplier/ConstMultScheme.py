'''Hardware model of a constant multiplier, `P = A * C`.

The counterpart to `ButterflyScheme` for constant multipliers: it propagates an
`IntType` bound to size the datapath, propagates a value batch to produce
testbench goldens, decides which of the three hardware implementations the
constant lands on, costs the result in LUTs, and emits RTL.

How the constant becomes hardware
---------------------------------
`C` is decomposed into non-adjacent form, so `A * C` is a signed sum of shifted
copies of `A`. `C = 2^9 - 2^4 + 1` gives three terms; the hardware adds
`A << 9`, subtracts `A << 4`, and adds `A`. Each term is one `SliceTerm` — the
whole of `A`, no inner slicing, with the NAF exponent in `limbShift` and the NAF
sign in `sign` — which is the same record the butterfly emits, so both operators
feed the same bit-heap builder.

When a `modulus` is supplied, `C` is first replaced by a congruent value with a
sparser NAF. That lifted value is what the hardware actually multiplies by, and
therefore what every bound, width and golden here is computed from.

Which implementation gets used is not a free choice: it follows from the bit
heap's tallest column, exactly as in `rtl_gen/const_mult.py`. One bit per column
is pure wiring, two is a plain adder, three or more needs a compressor tree. The
Baugh-Wooley correction bits that signed inputs and negative terms introduce
count toward that height, which is why a two-term constant can still land on the
compressor path.
'''
from __future__ import annotations

import os as _os
import random as _random
import sys as _sys

from ..core.HeapAnalysis import HeapAnalysisCache
from ..core.IntType import IntType
from ..core.OperatorScheme import (OperatorScheme, readHexBatch, resolveBackend,
                             runInDir, sampleBound, sampleRegisterRange)
from ..core.terms import sumTermsBound, sumTermsValue
from ..core.utils import formatNafExpr, nafTerms, nafTermsModulusLift

_versalArithDir = _os.path.normpath(
    _os.path.join(_os.path.dirname(__file__), '..', '..', 'versal_arith'))
if _versalArithDir not in _sys.path:
    _sys.path.append(_versalArithDir)
from butterfly_spec import SliceTerm            # noqa: E402
from const_mult_spec import ConstMultOperatorSpec  # noqa: E402


# Bit-heap analysis is memoised: a bank of 64 twiddles reuses constant shapes
# heavily and `compressAll` deep-copies its heap, so repeating it per entry is the
# dominant cost of costing a bank. This family's own table — see core.HeapAnalysis
# on why each family gets one rather than sharing one keyed on terminalLayers.
_CONST_MULT_HEAPS = HeapAnalysisCache(terminalLayers=1, label='constMult')


def defaultModuleName(aInBitWidth: int, constant: int) -> str:
    '''`Cmult_<width>x<constant>`, negatives rendered as `neg<abs>`.

    Matches `rtl_gen/const_mult.py::_module_name` so a model-generated module
    and a legacy CLI-generated one for the same parameters collide by name
    rather than silently coexisting as two different implementations.
    '''
    suffix = f'{constant}' if constant >= 0 else f'neg{abs(constant)}'
    return f'Cmult_{aInBitWidth}x{suffix}'


class ConstMultScheme(OperatorScheme):
    '''Base for constant-multiplier models. One input, one output.'''

    _BOUND_ATTRS = ('aIn',)
    _VALUE_ATTRS = ('aInValues',)

    def __init__(self, name: str = 'Undefined ConstMult Scheme',
                 aIn: IntType = IntType(0, 0, 0),
                 aInValues: list[int] | None = None,
                 inPortName: str = 'A',
                 outPortName: str = 'P'):
        super().__init__(name)
        self.aIn: IntType = aIn
        self.aInValues: list[int] | None = aInValues
        self.inPortName: str = inPortName
        self.outPortName: str = outPortName


class NafConstMult(ConstMultScheme):
    '''`P = A * C`, with `C` realised as a NAF sum of shifted copies of `A`.'''

    def __init__(self,
                 name: str = 'Undefined NafConstMult',
                 constant: int | list[tuple[int, int]] = 0,
                 aIn: IntType = IntType(0, 0, 0),
                 aInValues: list[int] | None = None,
                 modulus: int | None = None,
                 liftMaxPower: int = 96,
                 liftMaxTerms: int = 3,
                 liftMaxMultipleOfModulus: int = 2 ** 32,
                 liftSearchDepth: int = 3,
                 liftBeamWidth: int = 200,
                 inPortName: str = 'A',
                 outPortName: str = 'P',
                 countInverters: bool = True,
                 verbose: bool = False):
        super().__init__(name, aIn, aInValues, inPortName, outPortName)
        self.constant = constant
        self.modulus = modulus
        self.liftMaxPower = liftMaxPower
        self.liftMaxTerms = liftMaxTerms
        self.liftMaxMultipleOfModulus = liftMaxMultipleOfModulus
        self.liftSearchDepth = liftSearchDepth
        self.liftBeamWidth = liftBeamWidth
        self.countInverters = countInverters
        self.verbose = verbose
        # `_liftConstant` is called by _buildTerms, propagateBound, strategy,
        # areaCost and getOperatorInterface. With a modulus set each call is a
        # fresh beam search, so a 64-entry bank would repeat it hundreds of
        # times. Memoise per instance; invalidated by `setConstant`.
        self._liftCache: tuple[int, list[tuple[int, int]]] | None = None

    # ------------------------------------------------------------------
    # The constant
    # ------------------------------------------------------------------

    def _liftConstant(self) -> tuple[int, list[tuple[int, int]]]:
        '''Resolve `self.constant` to `(implementedValue, nafTerms)`.

        Three input forms, mirroring `GoldilocksSlice64._liftTwiddle`:

          - a pre-lifted NAF list passes straight through;
          - an `int` with no modulus is decomposed as-is;
          - an `int` with a modulus is replaced by the congruent value with the
            sparsest NAF found, which is what the hardware then implements.

        Always uses `operator_modeling.core.utils.nafTermsModulusLift` — the exact
        target-first search with a beam fallback — never
        `versal_arith.power_writer.reduce_mod_q_min_powers_lift`. The result is
        baked into the spec, so the generator never lifts anything itself.

        Memoised: with a modulus set this runs a search, and the callers around
        it (terms, bound, strategy, area, spec) would otherwise repeat it.
        '''
        if self._liftCache is not None:
            return self._liftCache
        self._liftCache = self._computeLift()
        return self._liftCache

    def setConstant(self, constant: int | list[tuple[int, int]]) -> None:
        '''Replace the constant, discarding the memoised lift.'''
        self.constant = constant
        self._liftCache = None

    def _computeLift(self) -> tuple[int, list[tuple[int, int]]]:
        if isinstance(self.constant, list):
            naf = [tuple(t) for t in self.constant]
            for t in naf:
                if len(t) != 2 or t[0] not in (1, -1):
                    raise ValueError(
                        f'{self.name}: NAF terms must be (sign, exponent) with '
                        f'sign in (+1, -1), got {t!r}'
                    )
            value = sum(s * (1 << k) for s, k in naf)
            return value, naf

        if not isinstance(self.constant, int):
            raise TypeError(
                f'{self.name}: constant must be an int or a NAF list, got '
                f'{type(self.constant).__name__}'
            )

        if self.modulus is None:
            naf = nafTerms(self.constant)
            if self.verbose:
                print(f'[{self.name}] C = {self.constant} = {formatNafExpr(naf)} '
                      f'({len(naf)} terms, no lift)')
            return self.constant, naf

        lifted, naf, count, maxPow = nafTermsModulusLift(
            x=self.constant,
            modulus=self.modulus,
            maxPower=self.liftMaxPower,
            maxMultipleOfModulus=self.liftMaxMultipleOfModulus,
            maxSearchDepth=self.liftSearchDepth,
            beamWidth=self.liftBeamWidth,
            maxNumberOfTerms=self.liftMaxTerms,
        )
        if self.verbose:
            original = len(nafTerms(self.constant))
            print(f'[{self.name}] C = {self.constant} -> {lifted} '
                  f'(mod {self.modulus}); NAF {original} -> {count} terms, '
                  f'maxPow {maxPow}: {formatNafExpr(naf)}')
        return lifted, naf

    def _buildTerms(self) -> tuple[list[SliceTerm], int, list[tuple[int, int]]]:
        '''`(pOutTerms, implementedConstant, naf)` — the one place terms are built.

        `propagateValue`, `getOperatorInterface`, `strategy` and `areaCost` all
        consume this, so none of them can disagree about what the hardware sums.

        Each NAF term takes the whole of `A`: `sliceStart = 0`,
        `sliceEnd = aInBitWidth - 1`. That is a full-width slice, so
        `IntType.slice` returns the input unchanged and `isSigned` follows the
        input's own signedness — which is what tells the heap builder whether to
        sign-extend the term up to the output width.
        '''
        if not isinstance(self.aIn, IntType):
            raise TypeError(
                f'{self.name}._buildTerms: aIn must be an IntType, got '
                f'{type(self.aIn).__name__}'
            )
        lifted, naf = self._liftConstant()
        if not naf:
            raise ValueError(
                f'{self.name}: constant {self.constant} has 0 NAF terms '
                f'(C = 0 is not a multiplier)'
            )
        if self.aIn.isZero:
            raise ValueError(
                f'{self.name}: aIn bound is zero — set an input bound before '
                f'building terms'
            )

        width = self.aIn.bitWidth
        terms = [
            SliceTerm(
                source=self.inPortName,
                inputShift=0,
                sliceStart=0,
                sliceEnd=width - 1,
                isSigned=self.aIn.isSigned,
                limbShift=exponent,
                sign=sign,
                constValue=0,
            )
            for sign, exponent in naf
        ]
        return terms, lifted, naf

    # ------------------------------------------------------------------
    # Bound and value paths
    # ------------------------------------------------------------------

    def propagateBound(self) -> IntType:
        '''Exact interval of `A * C`.

        Note this is the product bound, **not** `sumTermsBound(terms)`. The NAF
        terms are correlated copies of one input, so interval arithmetic over
        them over-approximates badly: for `C = 3` it evaluates `4*aIn - aIn` and
        yields roughly five times the reachable range. The reachable set is
        exactly the product, and the datapath should be sized for that.

        The term sum is still a valid *upper* bound on what the bit heap can
        represent, which `checkTermContainment` asserts.
        '''
        super().propagateBound()
        lifted, _ = self._liftConstant()
        return IntType.fromConst(lifted) * self.aIn

    def propagateValue(self) -> list[int]:
        '''Unreduced `A * C` for the loaded input batch.

        Evaluated through the same term list the hardware is built from rather
        than as a plain multiply, so a mistake in the terms shows up here as a
        golden mismatch instead of hiding until simulation.
        '''
        super().propagateValue()
        terms, _, _ = self._buildTerms()
        return sumTermsValue(terms, {self.inPortName: self.aInValues},
                             len(self.aInValues))

    def checkTermContainment(self) -> None:
        '''Assert the bit heap can represent every value the product can take.

        The heap may be wider than the semantics (correlated terms), never
        narrower. A violation would mean the emitted hardware cannot hold a
        result the model considers reachable.
        '''
        terms, _, _ = self._buildTerms()
        heapBound = sumTermsBound(terms, {self.inPortName: self.aIn})
        exact = self.propagateBound()
        if heapBound.minValue > exact.minValue or heapBound.maxValue < exact.maxValue:
            raise AssertionError(
                f'{self.name}: bit-heap bound {heapBound} does not contain the '
                f'product bound {exact}'
            )

    def checkHeapArithmetic(self, testSize: int = 64,
                            seed: int | None = None) -> None:
        '''Check the bit heap itself computes `A * C`, without a simulator.

        `propagateValue` and the local testvector sanity check both run through
        the term list, so they agree with each other by construction and cannot
        catch a mistake in how terms become heap bits. This interprets the heap
        descriptor the RTL is literally wired from — every bit is `A[i]`,
        `~A[i]`, `1'b1` or `1'b0`, weighted by its column — and confirms the sum
        equals `A * C` modulo the output width.

        That covers the Baugh-Wooley correction bits, which is where signed
        inputs and negative constants are easy to get wrong, and it is the
        strongest statement available about the emitted hardware short of
        running a simulation.
        '''
        from rtl_gen.heap_terms import buildHeapDescriptors

        rng = _random.Random(seed) if seed is not None else _random
        lifted, _ = self._liftConstant()
        outWidth = self.propagateBound().bitWidth
        terms, _, _ = self._buildTerms()
        _, assignDesc, _, _ = buildHeapDescriptors(terms, outWidth,
                                                   f'{self.outPortName.lower()}_')

        aWidth = self.aIn.bitWidth
        aMask = (1 << aWidth) - 1
        outMask = (1 << outWidth) - 1

        for _ in range(testSize):
            value = rng.randint(self.aIn.minValue, self.aIn.maxValue)
            raw = value & aMask
            total = 0
            for entry in assignDesc:
                column = entry[0]
                for sigName, sigIndex, negated, isConst in entry[1:]:
                    if isConst:
                        bit = 1
                    elif sigName is None:
                        bit = 0
                    else:
                        index = sigIndex if sigIndex not in (None, -1) else 0
                        bit = (raw >> index) & 1
                        if negated:
                            bit ^= 1
                    total += bit << column
            expected = (value * lifted) & outMask
            if (total & outMask) != expected:
                raise AssertionError(
                    f'{self.name}: bit heap computes {total & outMask:#x} for '
                    f'A={value}, expected {expected:#x} '
                    f'(= {value} * {lifted} mod 2^{outWidth})'
                )

    # ------------------------------------------------------------------
    # Implementation strategy, latency and area
    # ------------------------------------------------------------------

    def _heapDescriptors(self):
        '''`(compressor_desc, assign_desc, bitheap_list, width_bh)` for the output.'''
        from rtl_gen.heap_terms import buildHeapDescriptors

        terms, _, _ = self._buildTerms()
        outWidth = self.propagateBound().bitWidth
        return buildHeapDescriptors(terms, outWidth, f'{self.outPortName.lower()}_')

    def maxColumnHeight(self) -> int:
        '''Tallest bit-heap column, including Baugh-Wooley correction bits.'''
        _, assign_desc, _, _ = self._heapDescriptors()
        if not assign_desc:
            return 0
        return max(len(entry) - 1 for entry in assign_desc)

    def strategy(self) -> str:
        '''`'wire'`, `'adder'` or `'compressor'`.

        The same dispatch `rtl_gen/const_mult.py` performs, but decided once —
        here — and recorded in the spec, so the generator never re-derives it.
        '''
        height = self.maxColumnHeight()
        if height <= 1:
            return 'wire'
        if height == 2:
            return 'adder'
        return 'compressor'

    def _analyseHeap(self):
        '''`(nLayers, layerList, finalHeights)`, memoised across identical heaps.'''
        _, _, bitheap_list, width_bh = self._heapDescriptors()
        return _CONST_MULT_HEAPS.analyse(bitheap_list, width_bh)

    def latency(self, pipelineStages: int = 1) -> int:
        '''Pipeline registers this multiplier contributes.

        Wiring and adder strategies are combinational, so they contribute zero
        and get balancing registers when placed in a bank. The compressor
        strategy can absorb at most one register per compression layer, so
        requesting more stages than there are layers silently clamps — that is
        `reg_flag_list_gen`'s behaviour and this reports what it will actually do.
        '''
        if pipelineStages < 1:
            raise ValueError(
                f'{self.name}: pipelineStages must be >= 1, got {pipelineStages} '
                f'(reg_flag_list_gen divides by it)'
            )
        if self.strategy() != 'compressor':
            return 0
        from rtl_gen.compressor import reg_flag_list_gen

        nLayers, _, _ = self._analyseHeap()
        return sum(reg_flag_list_gen(pipeline_stages=pipelineStages,
                                     num_layers=nLayers))

    def areaCost(self) -> tuple[int, int]:
        '''`(LUT, 0)` — nothing in this operator uses a DSP.

        Wiring costs whatever inverters it cannot give away. A negative NAF term
        emits `~A[i]`, which is free only if some downstream LUT absorbs it; in a
        bank the output goes to a balancing register or straight to a port, so
        there is nothing to absorb it. `countInverters=False` opts out when the
        caller knows the consumer will fuse them.

        Adder costs one LUT and carry per column. Compressor costs the exact
        per-GPC sum from the placement heuristic plus the quaternary terminal
        adder.
        '''
        from rtl_gen.heap_terms import heapLutCost

        strategy = self.strategy()
        _, assign_desc, _, _ = self._heapDescriptors()

        if strategy == 'wire':
            if not self.countInverters:
                return 0, 0
            inverted = sum(
                1
                for entry in assign_desc
                for bit in entry[1:]
                if bit[2]  # the `neg` flag
            )
            return inverted, 0

        if strategy == 'adder':
            return len(assign_desc), 0

        _, layerList, finalHeights = self._analyseHeap()
        return heapLutCost(layerList, finalHeights), 0

    # ------------------------------------------------------------------
    # Spec extraction
    # ------------------------------------------------------------------

    def getOperatorInterface(self, name: str) -> ConstMultOperatorSpec:
        '''Frozen spec for the RTL generator. Requires `aIn` to be set.'''
        if not isinstance(self.aIn, IntType):
            raise TypeError(
                f'{self.name}.getOperatorInterface: aIn must be an IntType, got '
                f'{type(self.aIn).__name__}'
            )
        terms, lifted, naf = self._buildTerms()
        outBound = self.propagateBound()
        original = self.constant if (self.modulus is not None
                                     and isinstance(self.constant, int)) else None

        return ConstMultOperatorSpec(
            name=name,
            constant=lifted,
            originalConstant=original,
            modulus=self.modulus,
            naf=naf,
            inPortName=self.inPortName,
            outPortName=self.outPortName,
            aInBitWidth=self.aIn.bitWidth,
            aInIsSigned=self.aIn.isSigned,
            aInZeroLsbs=self.aIn.zeroLsbs,
            pOutBitWidth=outBound.bitWidth,
            pOutIsSigned=outBound.isSigned,
            pOutMinValue=outBound.minValue,
            pOutMaxValue=outBound.maxValue,
            pOutZeroLsbs=outBound.zeroLsbs,
            strategy=self.strategy(),
            maxColumnHeight=self.maxColumnHeight(),
            pOutTerms=terms,
        )

    # ------------------------------------------------------------------
    # RTL emission
    # ------------------------------------------------------------------

    def emitRtl(self, name: str, run_dir,
                pipeline_stages: int = 1,
                gen_testbench: bool = True,
                test_size: int = 1000,
                seed: int | None = None,
                visualization: bool = False,
                sanity_check_size: int = 8,
                backend: str = 'hw',
                sampling: str = 'bound') -> dict:
        '''Emit RTL for this multiplier into `run_dir`; return generator metadata.

        `sampling` picks how testvectors are drawn:

          - `'bound'` (default) samples inside the modelled interval and honours
            its known-zero LSBs, which is required whenever `aIn.zeroLsbs > 0`
            because the heap has no bits in those positions;
          - `'register'` samples the whole declared register, matching what
            `GoldilocksSlice64.emitRtl` does.

        Goldens come from `propagateValue` on a clone, so the generator never
        samples anything itself.
        '''
        if pipeline_stages < 1:
            raise ValueError(
                f'{self.name}.emitRtl: pipeline_stages must be >= 1, got '
                f'{pipeline_stages}'
            )

        spec = self.getOperatorInterface(name=name)

        aIn: list[int] | None = None
        pOut: list[int] | None = None
        if gen_testbench:
            rng = _random.Random(seed) if seed is not None else _random
            if sampling == 'bound':
                aIn = sampleBound(self.aIn, test_size, rng)
            elif sampling == 'register':
                aIn = sampleRegisterRange(spec.aInBitWidth, spec.aInIsSigned,
                                          test_size, rng)
            else:
                raise ValueError(
                    f"sampling must be 'bound' or 'register', got {sampling!r}"
                )
            golden = NafConstMult(name=f'{name}_golden', constant=spec.naf,
                                  aIn=self.aIn, aInValues=aIn,
                                  inPortName=self.inPortName,
                                  outPortName=self.outPortName)
            pOut = golden.propagateValue()

        gen = resolveBackend(backend, 'const_mult_op',
                             'ConstMult_RTL_gen', 'ConstMult_SimRTL_gen')
        meta = runInDir(run_dir, gen,
                        spec=spec,
                        pipeline_stages=pipeline_stages,
                        gen_testbench=gen_testbench,
                        visualization=visualization,
                        A=aIn, P=pOut)

        if gen_testbench and sanity_check_size > 0:
            sanityCheckConstMultTestvectors(run_dir, spec, sanity_check_size)
        return meta


class ConstMultBank:
    '''N constant multipliers over one input, with uniform output latency.

    The bank is where the modelling pays off most. Its whole purpose is to feed
    a downstream stage — an NTT's `getInputsNatural`, typically — and what that
    stage needs is a `list[IntType]`, one per output port. `propagateBound()`
    returns exactly that, so the bounds never have to round-trip through a JSON
    side-car and be reconstructed.

    Ports keep their own widths: `A_<i>` at the shared input width, `P_<i>` at
    that entry's own output width. Entries whose constant lands on the wiring or
    adder strategy are combinational, so they receive balancing registers at
    their own width to match the deepest compressor — no widening at the bank
    boundary.
    '''

    def __init__(self, name: str = 'cmultbank',
                 constants=(),
                 aIn: IntType = IntType(0, 0, 0),
                 aInValues: list[int] | None = None,
                 modulus: int | None = None,
                 sharedInput: bool = True,
                 countInverters: bool = True,
                 verbose: bool = False,
                 **liftKwargs):
        constants = list(constants)
        if not constants:
            raise ValueError(f'{name}: no constants given')
        self.name = name
        self.aIn = aIn
        self.aInValues = aInValues
        self.modulus = modulus
        self.sharedInput = sharedInput
        self.verbose = verbose
        self.schemes: list[NafConstMult] = [
            NafConstMult(name=f'{name}_P{i}', constant=c, aIn=aIn,
                         aInValues=aInValues, modulus=modulus,
                         countInverters=countInverters, verbose=verbose,
                         **liftKwargs)
            for i, c in enumerate(constants)
        ]

    def __len__(self) -> int:
        return len(self.schemes)

    def setInputValues(self, values: list[int]) -> None:
        '''Drive every entry from one shared input batch.'''
        self.aInValues = values
        for scheme in self.schemes:
            scheme.aInValues = values

    def propagateBound(self) -> list[IntType]:
        '''Per-entry output bounds, in port order.

        Feed straight into `FullyPipelinedNTT.getInputsNatural(bounds)`.
        '''
        return [scheme.propagateBound() for scheme in self.schemes]

    def propagateValue(self) -> list[list[int]]:
        '''Per-entry output value batches, in port order.'''
        return [scheme.propagateValue() for scheme in self.schemes]

    def perEntryLatency(self, pipelineStages: int = 1) -> list[int]:
        '''Latency of each entry before balancing registers are added.'''
        return [s.latency(pipelineStages) for s in self.schemes]

    def latency(self, pipelineStages: int = 1) -> int:
        '''Uniform latency every output port sees.

        Mirrors the legacy bank: the deepest compressor, but never fewer cycles
        than were requested, and never zero.
        '''
        return max(max(self.perEntryLatency(pipelineStages)), pipelineStages, 1)

    def areaCost(self) -> tuple[int, int]:
        '''Summed `(LUT, DSP)` over the entries.

        Excludes the balancing registers, which are flip-flops rather than LUTs.
        '''
        luts = sum(s.areaCost()[0] for s in self.schemes)
        return luts, 0

    def getOperatorInterface(self, name: str,
                             pipelineStages: int = 1) -> 'ConstMultBankSpec':
        from const_mult_spec import ConstMultBankSpec

        entries = [
            scheme.getOperatorInterface(
                defaultModuleName(self.aIn.bitWidth, scheme._liftConstant()[0]))
            for scheme in self.schemes
        ]
        perEntry = self.perEntryLatency(pipelineStages)
        return ConstMultBankSpec(
            name=name,
            aInBitWidth=self.aIn.bitWidth,
            aInIsSigned=self.aIn.isSigned,
            aInZeroLsbs=self.aIn.zeroLsbs,
            sharedInput=self.sharedInput,
            entries=entries,
            requestedPipelineStages=pipelineStages,
            uniformLatency=self.latency(pipelineStages),
            perEntryLatency=perEntry,
        )

    def emitRtl(self, name: str, run_dir,
                pipeline_stages: int = 1,
                gen_testbench: bool = True,
                test_size: int = 1000,
                seed: int | None = None,
                visualization: bool = False,
                backend: str = 'hw',
                sampling: str = 'bound') -> dict:
        '''Emit the whole bank into `run_dir`, with `output_bounds.json`.'''
        if pipeline_stages < 1:
            raise ValueError(
                f'{self.name}.emitRtl: pipeline_stages must be >= 1, got '
                f'{pipeline_stages}'
            )
        spec = self.getOperatorInterface(name, pipelineStages=pipeline_stages)

        aIn: list[int] | None = None
        pOut: list[list[int]] | None = None
        if gen_testbench:
            rng = _random.Random(seed) if seed is not None else _random
            if sampling == 'bound':
                aIn = sampleBound(self.aIn, test_size, rng)
            elif sampling == 'register':
                aIn = sampleRegisterRange(spec.aInBitWidth, spec.aInIsSigned,
                                          test_size, rng)
            else:
                raise ValueError(
                    f"sampling must be 'bound' or 'register', got {sampling!r}"
                )
            saved = self.aInValues
            self.setInputValues(aIn)
            try:
                pOut = self.propagateValue()
            finally:
                if saved is not None:
                    self.setInputValues(saved)

        gen = resolveBackend(backend, 'const_mult_op',
                             'ConstMultBank_RTL_gen', 'ConstMultBank_SimRTL_gen')
        return runInDir(run_dir, gen,
                        spec=spec,
                        pipeline_stages=pipeline_stages,
                        gen_testbench=gen_testbench,
                        visualization=visualization,
                        A=aIn, P=pOut)


def sanityCheckConstMultTestvectors(run_dir, spec: ConstMultOperatorSpec,
                                    sampleSize: int = 8) -> None:
    '''Re-derive the on-disk goldens from the on-disk inputs, and compare.

    Reads back what was actually written, decodes it at the spec's declared
    widths, pushes it through `propagateValue` again, and checks the result
    matches modulo `2^pOutBitWidth`. Catches two's-complement encoding mistakes
    locally, before a simulation is scheduled on the remote server.
    '''
    from pathlib import Path

    run_dir = Path(run_dir)
    tvDir = run_dir / 'testvectors'
    aVals = readHexBatch(tvDir / f'{spec.inPortName}.txt', sampleSize,
                         spec.aInBitWidth, spec.aInIsSigned)
    pVals = readHexBatch(tvDir / f'{spec.outPortName}.txt', len(aVals),
                         spec.pOutBitWidth, False)

    # Rebuild from the DECLARED register rather than the modelled interval: the
    # terms only need the right slice width and signedness to reproduce what the
    # RTL computes, and the register is what the RTL port actually is.
    aInRegister = (IntType.signed(spec.aInBitWidth) if spec.aInIsSigned
                   else IntType.unsigned(spec.aInBitWidth))
    model = NafConstMult(name=f'{spec.name}_sanity', constant=spec.naf,
                         aIn=aInRegister, aInValues=aVals,
                         inPortName=spec.inPortName,
                         outPortName=spec.outPortName)
    expected = model.propagateValue()

    mask = (1 << spec.pOutBitWidth) - 1
    mismatches = [
        (i, aVals[i], expected[i] & mask, pVals[i])
        for i in range(len(pVals))
        if (expected[i] & mask) != (pVals[i] & mask)
    ]
    if mismatches:
        lines = '\n'.join(
            f'    [{i}] A={a} expected={e:#x} onDisk={d:#x}'
            for i, a, e, d in mismatches[:5]
        )
        raise RuntimeError(
            f'{spec.name}: {len(mismatches)}/{len(pVals)} testvectors disagree '
            f'with propagateValue — likely a twos-complement encoding bug\n{lines}'
        )
    print(f'[emitRtl] sanity-check OK: {len(pVals)} testvectors round-trip '
          f'through propagateValue')
