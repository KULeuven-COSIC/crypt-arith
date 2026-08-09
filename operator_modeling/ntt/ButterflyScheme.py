from __future__ import annotations
import os as _os
import sys as _sys
from ..core.IntType import IntType
from abc import ABC, abstractmethod
from ..core.utils import (
    nafTermsCount, nafTermsModulusLift,
    vectorAdd, vectorSub, vectorLshift, vectorSlice, vectorConst, vectorBitWidth,
)

# versal_arith is a sibling project, not a Python package (no top-level __init__.py),
# so we add its directory to sys.path on demand. Both the shared spec dataclasses
# and the rtl_gen butterfly generator are imported through that path.
_versalArithDir = _os.path.normpath(_os.path.join(_os.path.dirname(__file__), '..', '..', 'versal_arith'))
if _versalArithDir not in _sys.path:
    _sys.path.append(_versalArithDir)
from butterfly_spec import ButterflyOperatorSpec, SliceTerm


class ButterflyScheme(ABC):
    def __init__(self, name: str = 'Undefined Butterfly Scheme', aIn: IntType | list[int] = IntType(0, 0, 0), bIn: IntType | list[int] = IntType(0, 0, 0), twiddle: IntType | int | list[tuple[int, int]] = IntType(0, 0, 0)):
        self.name: str = name
        self.aIn: IntType | list[int] = aIn
        self.bIn: IntType | list[int] = bIn
        self.twiddle: IntType | int | list[tuple[int, int]] = twiddle
        self.q: int = 0
        # Hardware-register bit widths used for slicing in propagateValue. Set by Butterfly.compute()
        # from the input port's bound.bitWidth so the value path uses the SAME slicing pattern as
        # propagateBound — otherwise the unreduced sums diverge by multiples of q for inputs whose
        # actual bit width is narrower than the bound's bit width.
        self.aInBitWidth: int | None = None
        self.bInBitWidth: int | None = None

    @abstractmethod
    def propagateBound(self) -> tuple[IntType, IntType]:
        '''Given input bounds, return (aOutBound, bOutBound)'''
        # common checks
        if not isinstance(self.aIn, IntType):
            raise TypeError(f'Expected aIn to be of type IntType, got {type(self.aIn)}')
        if not isinstance(self.bIn, IntType):
            raise TypeError(f'Expected bIn to be of type IntType, got {type(self.bIn)}')
        if not isinstance(self.twiddle, (IntType, int, list)):
            raise TypeError(f'Expected twiddle to be of type IntType, int or list[tuple[int, int]] (NAF), got {type(self.twiddle)}')
        return IntType(0, 0, 0), IntType(0, 0, 0)

    @abstractmethod
    def propagateValue(self) -> tuple[list[int], list[int]]:
        '''Given test vectors of inputs, return (aOutTestVec, bOutTestVec)'''
        # common checks
        if not isinstance(self.aIn, list):
            raise TypeError(f'Expected aIn to be of type list[int], got {type(self.aIn)}')
        if not isinstance(self.bIn, list):
            raise TypeError(f'Expected bIn to be of type list[int], got {type(self.bIn)}')
        if not isinstance(self.twiddle, (int, list)):
            raise TypeError(f'Expected twiddle to be of type int or list[tuple[int, int]] (NAF), got {type(self.twiddle)}')
        if not all(isinstance(x, int) for x in self.aIn):
            raise TypeError('Expected all elements of aIn to be of type int')
        if not all(isinstance(x, int) for x in self.bIn):
            raise TypeError('Expected all elements of bIn to be of type int')

    @abstractmethod
    def areaCost(self) -> tuple[int, int]:
        '''Return (LUT cost, DSP cost) for FPGAs, or (real area cost, 0) for ASICs'''
        ...


class GoldilocksSlice64(ButterflyScheme):
    def __init__(self, name: str = 'Undefined GoldilocksSlice64 Butterfly Scheme', butterflyType: str = None, aIn: IntType | list[int] = IntType(0, 0, 0), bIn: IntType | list[int] = IntType(0, 0, 0), twiddle: IntType | int | list[tuple[int, int]] = IntType(0, 0, 0), verbose: bool = False):
        super().__init__(name, aIn, bIn, twiddle)
        self.q = 2**64 - 2**32 + 1
        self.butterflyType: str = butterflyType
        self.verbose: bool = verbose

    # Goldilocks limb-factor table — encodes the modular identities
    #   2^64  ≡ 2^32 - 1   (mod q)        ->  bits [64:95]  contribute as (shift=0, sign=-1) + (shift=32, sign=+1)
    #   2^96  ≡ -1         (mod q)        ->  bits [96:159] contribute as (shift=0, sign=-1)
    #   2^128 ≡ -2^32      (mod q)        ->  (folded into the bits [96:159] limb via its own shift, no separate entry)
    #   2^160 ≡ -2^32 + 1  (mod q)        ->  bits [160:191] contribute as (shift=0, sign=+1) + (shift=32, sign=-1)
    #   2^192 ≡ 1          (mod q)        ->  the cycle restarts (handled by % 192 in _buildSliceTerms)
    _LIMBS64 = (
        ((0, 63),    ((0, +1),)),
        ((64, 95),   ((0, -1), (32, +1))),
        ((96, 159),  ((0, -1),)),
        ((160, 191), ((0, +1), (32, -1))),
    )
    _SUB_BOUNDARIES = (64, 96, 160)

    def _liftTwiddle(self) -> list[tuple[int, int]]:
        '''Resolve self.twiddle to a NAF list. Modulus-lifts an integer twiddle (≤ 3 NAF terms with maxPower=95); passes a pre-lifted NAF list through unchanged. Verbose-prints the lift summary if self.verbose is set, exactly as the original propagateBound did.'''
        if isinstance(self.twiddle, IntType):
            raise TypeError(f'Expected twiddle to be of type int or list[tuple[int, int]] (NAF) for GoldilocksSlice64 scheme, got IntType')
        if isinstance(self.twiddle, int):
            liftedTwiddle, liftedTwiddleNaf, _, _ = nafTermsModulusLift(
                x=self.twiddle, modulus=self.q, maxPower=95,
                maxMultipleOfModulus=2**32, maxSearchDepth=3, beamWidth=200,
                maxNumberOfTerms=3,
            )
            if self.verbose:
                print(f'Original twiddle: {self.twiddle}, lifted twiddle: {liftedTwiddle}')
                print(f'NAF term count of original twiddle: {nafTermsCount(self.twiddle)}, NAF term count of lifted twiddle: {len(liftedTwiddleNaf)}')
        else:
            liftedTwiddleNaf = list(self.twiddle)
            if self.verbose:
                print(f'Pre-lifted NAF twiddle: {liftedTwiddleNaf} ({len(liftedTwiddleNaf)} terms)')
        if len(liftedTwiddleNaf) > 3:
            raise ValueError(f'GoldilocksSlice64 supports up to 3 NAF terms per twiddle (Goldilocks slice64 hardware constraint), got {len(liftedTwiddleNaf)}: {liftedTwiddleNaf}')
        return list(liftedTwiddleNaf)

    def _shiftAndSliceTerms(self, source: str, input_: IntType, inputShift: int, outerSign: int) -> list[SliceTerm]:
        '''Slice `input_ << inputShift` at the Goldilocks 192-block sub-boundaries (64, 96, 160). For each non-zero limb slice, look up its `_LIMBS64` factors and emit one SliceTerm per factor. Mirrors the inner shiftAndSlice + processGoldilocks64Slices loop from the previous propagateBound.'''
        out: list[SliceTerm] = []
        if inputShift < 0:
            raise ValueError(f'Invalid shift amount {inputShift}, must be non-negative')
        inputShifted = input_ << inputShift
        if inputShifted.isZero:
            return out
        end = inputShifted.bitWidth - 1
        pos = 0
        while pos <= end:
            blockStart = (pos // 192) * 192
            relPos = pos - blockStart
            nextBoundary = blockStart + 192
            for b in self._SUB_BOUNDARIES:
                if b > relPos:
                    nextBoundary = blockStart + b
                    break
            sliceEnd = min(nextBoundary - 1, end)
            sliceIntType = inputShifted.slice(pos, sliceEnd)
            # Skip exactly-zero slices (the IntType.slice first branch, width <= zeroLsbs).
            # Including them would just add IntType(0,0,0) terms that contribute nothing
            # to the bound and would make the bit-heap construction in step 2 wider for no
            # reason.
            if sliceIntType.isZero:
                pos = sliceEnd + 1
                continue
            startMod = pos % 192
            endMod = sliceEnd % 192
            for (limbStart, limbEnd), factors in self._LIMBS64:
                if startMod >= limbStart and endMod <= limbEnd:
                    for limbShift, limbSign in factors:
                        out.append(SliceTerm(
                            source=source,
                            inputShift=inputShift,
                            sliceStart=pos,
                            sliceEnd=sliceEnd,
                            isSigned=sliceIntType.isSigned,
                            limbShift=limbShift,
                            sign=limbSign * outerSign,
                            constValue=0,
                        ))
                    break
            else:
                raise ValueError(f'Slice ({pos}, {sliceEnd}) does not fit any limb range')
            pos = sliceEnd + 1
        return out

    def _buildSliceTerms(self) -> tuple[list[SliceTerm], list[SliceTerm], list[tuple[int, int]]]:
        '''Build the per-output bit-level provenance — every signed-shifted-slice summand that contributes to aOut and bOut, plus the lifted-NAF twiddle list. Both propagateBound (via _sumSliceTerms) and getOperatorInterface call this helper, so the IntType bound and the RTL spec stay derived from a single source of truth. Caller is responsible for the IntType type checks (super().propagateBound() does them in propagateBound; getOperatorInterface re-checks inline).'''
        liftedTwiddleNaf = self._liftTwiddle()

        aOutTerms: list[SliceTerm] = []
        bOutTerms: list[SliceTerm] = []
        # The -q "lazy reduction" constant goes only on aOut for both CT and GS, matching
        # the original propagateBound. q has 65 bits (2^64 - 2^32 + 1 has bits [0:31] and bit 64).
        qConst = SliceTerm(
            source='const', inputShift=0,
            sliceStart=0, sliceEnd=self.q.bit_length() - 1,
            isSigned=False, limbShift=0, sign=-1, constValue=self.q,
        )

        if self.butterflyType == 'CT':
            # Cooley-Tukey (Decimation-in-Time):
            #   aOut = aIn + bIn * twiddle  - q
            #   bOut = aIn - bIn * twiddle
            aOutTerms.append(qConst)
            aInTerms = self._shiftAndSliceTerms('aIn', self.aIn, inputShift=0, outerSign=1)
            aOutTerms.extend(aInTerms)
            bOutTerms.extend(aInTerms)
            for nafSign, nafShift in liftedTwiddleNaf:
                aOutTerms.extend(self._shiftAndSliceTerms('bIn', self.bIn, inputShift=nafShift, outerSign=nafSign))
                bOutTerms.extend(self._shiftAndSliceTerms('bIn', self.bIn, inputShift=nafShift, outerSign=-nafSign))
        elif self.butterflyType == 'GS':
            # Gentleman-Sande (Decimation-in-Frequency):
            #   aOut = aIn + bIn  - q
            #   bOut = (aIn - bIn) * twiddle
            aOutTerms.append(qConst)
            aOutTerms.extend(self._shiftAndSliceTerms('aIn', self.aIn, inputShift=0, outerSign=1))
            aOutTerms.extend(self._shiftAndSliceTerms('bIn', self.bIn, inputShift=0, outerSign=1))
            for nafSign, nafShift in liftedTwiddleNaf:
                bOutTerms.extend(self._shiftAndSliceTerms('aIn', self.aIn, inputShift=nafShift, outerSign=nafSign))
                bOutTerms.extend(self._shiftAndSliceTerms('bIn', self.bIn, inputShift=nafShift, outerSign=-nafSign))
        else:
            raise ValueError(f'Unsupported butterfly type {self.butterflyType} for GoldilocksSlice64 scheme')

        return aOutTerms, bOutTerms, liftedTwiddleNaf

    def _sumSliceTerms(self, terms: list[SliceTerm]) -> IntType:
        '''Sum a SliceTerm list back into an IntType bound, mirroring how the previous propagateBound summed its (slice, sign) accumulator. Each term contributes ±((source << inputShift)[sliceEnd:sliceStart] << limbShift); const terms contribute ±(IntType(constValue, constValue, 0) << limbShift).'''
        out = IntType(0, 0, 0)
        for t in terms:
            if t.source == 'const':
                piece = IntType(t.constValue, t.constValue, 0) << t.limbShift
            else:
                inp = self.aIn if t.source == 'aIn' else self.bIn
                shifted = inp << t.inputShift
                sliced = shifted.slice(t.sliceStart, t.sliceEnd)
                piece = sliced << t.limbShift
            out = out + piece if t.sign == 1 else out - piece
        return out

    def propagateBound(self) -> tuple[IntType, IntType]:
        # perform common checks
        super().propagateBound()
        aOutTerms, bOutTerms, _ = self._buildSliceTerms()
        return self._sumSliceTerms(aOutTerms), self._sumSliceTerms(bOutTerms)

    def getOperatorInterface(self, name: str) -> ButterflyOperatorSpec:
        '''Return a ButterflyOperatorSpec describing this butterfly at RTL granularity: the per-output list of signed-shifted-slice summands, the lifted-NAF twiddle, and the input/output bit-widths and signedness. Consumed by versal_arith's butterfly RTL generator. Requires self.aIn and self.bIn to already be set as IntType bounds; caller is typically Butterfly.compute() or a generator script that has already wired the input bounds.'''
        # Same type checks as super().propagateBound() — replicated inline so we don't
        # invoke the abstract base method just to throw away its return value.
        if not isinstance(self.aIn, IntType):
            raise TypeError(f'Expected aIn to be of type IntType, got {type(self.aIn)}')
        if not isinstance(self.bIn, IntType):
            raise TypeError(f'Expected bIn to be of type IntType, got {type(self.bIn)}')
        if not isinstance(self.twiddle, (int, list)):
            raise TypeError(f'Expected twiddle to be of type int or list[tuple[int, int]] (NAF) for GoldilocksSlice64 scheme, got {type(self.twiddle)}')

        aOutTerms, bOutTerms, liftedNaf = self._buildSliceTerms()
        aOutBound = self._sumSliceTerms(aOutTerms)
        bOutBound = self._sumSliceTerms(bOutTerms)

        return ButterflyOperatorSpec(
            name=name,
            butterflyType=self.butterflyType,
            q=self.q,
            aInBitWidth=self.aIn.bitWidth,
            aInIsSigned=self.aIn.isSigned,
            bInBitWidth=self.bIn.bitWidth,
            bInIsSigned=self.bIn.isSigned,
            aOutBitWidth=aOutBound.bitWidth,
            aOutIsSigned=aOutBound.isSigned,
            bOutBitWidth=bOutBound.bitWidth,
            bOutIsSigned=bOutBound.isSigned,
            liftedTwiddleNaf=list(liftedNaf),
            aOutTerms=aOutTerms,
            bOutTerms=bOutTerms,
        )


    def propagateValue(self) -> tuple[list[int], list[int]]:
        # perform common checks
        super().propagateValue()
        batchSize = len(self.aIn)
        if len(self.bIn) != batchSize:
            raise ValueError(f'aIn and bIn must have the same batch length, got {batchSize} and {len(self.bIn)}')

        if isinstance(self.twiddle, int):
            liftedTwiddle, liftedTwiddleNaf, _, _ = nafTermsModulusLift(x=self.twiddle, modulus=self.q, maxPower=95, maxMultipleOfModulus=2**32, maxSearchDepth=3, beamWidth=200, maxNumberOfTerms=3)
            if self.verbose:
                print(f'Original twiddle: {self.twiddle}, lifted twiddle: {liftedTwiddle}')
                print(f'NAF term count of original twiddle: {nafTermsCount(self.twiddle)}, NAF term count of lifted twiddle: {len(liftedTwiddleNaf)}')
        elif isinstance(self.twiddle, list):
            liftedTwiddleNaf = self.twiddle
            if self.verbose:
                print(f'Pre-lifted NAF twiddle: {liftedTwiddleNaf} ({len(liftedTwiddleNaf)} terms)')
        else:
            raise TypeError(f'Expected twiddle to be of type int or list[tuple[int, int]] (NAF) for GoldilocksSlice64 scheme, got {type(self.twiddle)}')

        if len(liftedTwiddleNaf) > 3:
            raise ValueError(f'GoldilocksSlice64 supports up to 3 NAF terms per twiddle (Goldilocks slice64 hardware constraint), got {len(liftedTwiddleNaf)}: {liftedTwiddleNaf}')

        # Identical limb-factor table to propagateBound (see comments there for the math).
        limbs64 = (
            ((0, 63), ((0, +1),)),
            ((64, 95), ((0, -1), (32, +1))),
            ((96, 159), ((0, -1),)),
            ((160, 191), ((0, +1), (32, -1))),
        )

        def shiftAndSliceGoldilocks64Value(input: list[int], shift: int, inputBitWidth: int | None, start: int = 0, end: int | None = None) -> dict[tuple[int, int], list[int]]:
            '''Value-batch parallel of shiftAndSliceGoldilocks64. Slices `input << shift` into Goldilocks-aligned limbs. The last (boundary) limb is taken as a Python-signed slice so that negative inputs reconstruct correctly via the Goldilocks identities — mirroring IntType.slice's signed branch. `inputBitWidth` MUST be the input bound's bitWidth (mirroring propagateBound's `inputShifted.bitWidth - 1` end), so the value path uses the same slicing pattern as the bound; if None, falls back to vectorBitWidth(inputShifted) and unreduced results may differ from propagateBound predictions by multiples of q.'''
            if shift < 0:
                raise ValueError(f'Invalid shift amount {shift}, must be non-negative')
            inputShifted = vectorLshift(input, shift)
            if all(x == 0 for x in inputShifted):
                return {}
            if end is None:
                if inputBitWidth is not None:
                    end = inputBitWidth + shift - 1
                else:
                    end = vectorBitWidth(inputShifted) - 1
            if end < start:
                raise ValueError(f'Invalid limb range ({start}, {end})')

            SUB_BOUNDARIES = (64, 96, 160)
            outSlices: dict[tuple[int, int], list[int]] = {}
            pos = start
            while pos <= end:
                blockStart = (pos // 192) * 192
                relPos = pos - blockStart
                nextBoundary = blockStart + 192
                for b in SUB_BOUNDARIES:
                    if b > relPos:
                        nextBoundary = blockStart + b
                        break
                sliceEnd = min(nextBoundary - 1, end)
                isBoundary = (sliceEnd == end)
                outSlices[(pos, sliceEnd)] = vectorSlice(inputShifted, pos, sliceEnd, signed=isBoundary)
                pos = sliceEnd + 1
            return outSlices

        def processGoldilocks64SlicesValue(slices: dict[tuple[int, int], list[int]], limbFactors: tuple[tuple[tuple[int, int], tuple[tuple[int, int], ...]], ...], outerSign: int) -> list[tuple[list[int], int]]:
            '''Value-batch parallel of processGoldilocks64Slices. Returns list of (vec, sign) per limb factor.'''
            out: list[tuple[list[int], int]] = []
            for (start, end), slc in slices.items():
                startMod = start % 192
                endMod = end % 192
                for (limbStart, limbEnd), factors in limbFactors:
                    if startMod >= limbStart and endMod <= limbEnd:
                        for shift, sign in factors:
                            shiftedSlice = vectorLshift(slc, shift)
                            out.append((shiftedSlice, sign * outerSign))
                        break
                else:
                    raise ValueError(f'Slice ({start}, {end}) does not fit any limb range')
            return out

        if self.butterflyType == 'CT':
            # Cooley-Tukey: aOut = aIn + bIn * twiddle ; bOut = aIn - bIn * twiddle
            aOutSlices: list[tuple[list[int], int]] = [(vectorConst(self.q, batchSize), -1)]
            bOutSlices: list[tuple[list[int], int]] = []
            aInSlices = shiftAndSliceGoldilocks64Value(input=self.aIn, shift=0, inputBitWidth=self.aInBitWidth)
            aOutSlices.extend(processGoldilocks64SlicesValue(slices=aInSlices, limbFactors=limbs64, outerSign=1))
            bOutSlices.extend(processGoldilocks64SlicesValue(slices=aInSlices, limbFactors=limbs64, outerSign=1))
            for sign, shift in liftedTwiddleNaf:
                bShiftedSlices = shiftAndSliceGoldilocks64Value(input=self.bIn, shift=shift, inputBitWidth=self.bInBitWidth)
                aOutSlices.extend(processGoldilocks64SlicesValue(slices=bShiftedSlices, limbFactors=limbs64, outerSign=sign))
                bOutSlices.extend(processGoldilocks64SlicesValue(slices=bShiftedSlices, limbFactors=limbs64, outerSign=-sign))
            aOut = vectorConst(0, batchSize)
            bOut = vectorConst(0, batchSize)
            for slc, sign in aOutSlices:
                aOut = vectorAdd(aOut, slc) if sign == 1 else vectorSub(aOut, slc)
            for slc, sign in bOutSlices:
                bOut = vectorAdd(bOut, slc) if sign == 1 else vectorSub(bOut, slc)
            return aOut, bOut

        elif self.butterflyType == 'GS':
            # Gentleman-Sande: aOut = aIn + bIn ; bOut = (aIn - bIn) * twiddle
            aOutSlices = [(vectorConst(self.q, batchSize), -1)]
            bOutSlices = []
            aInSlices = shiftAndSliceGoldilocks64Value(input=self.aIn, shift=0, inputBitWidth=self.aInBitWidth)
            bInSlices = shiftAndSliceGoldilocks64Value(input=self.bIn, shift=0, inputBitWidth=self.bInBitWidth)
            aOutSlices.extend(processGoldilocks64SlicesValue(slices=aInSlices, limbFactors=limbs64, outerSign=1))
            aOutSlices.extend(processGoldilocks64SlicesValue(slices=bInSlices, limbFactors=limbs64, outerSign=1))
            for sign, shift in liftedTwiddleNaf:
                aShiftedSlices = shiftAndSliceGoldilocks64Value(input=self.aIn, shift=shift, inputBitWidth=self.aInBitWidth)
                bOutSlices.extend(processGoldilocks64SlicesValue(slices=aShiftedSlices, limbFactors=limbs64, outerSign=sign))
                bShiftedSlices = shiftAndSliceGoldilocks64Value(input=self.bIn, shift=shift, inputBitWidth=self.bInBitWidth)
                bOutSlices.extend(processGoldilocks64SlicesValue(slices=bShiftedSlices, limbFactors=limbs64, outerSign=-sign))
            aOut = vectorConst(0, batchSize)
            bOut = vectorConst(0, batchSize)
            for slc, sign in aOutSlices:
                aOut = vectorAdd(aOut, slc) if sign == 1 else vectorSub(aOut, slc)
            for slc, sign in bOutSlices:
                bOut = vectorAdd(bOut, slc) if sign == 1 else vectorSub(bOut, slc)
            return aOut, bOut

        else:
            raise ValueError(f'Unsupported butterfly type {self.butterflyType} for GoldilocksSlice64 scheme')


    def areaCost(self) -> tuple[int, int]:
        pass


    def emitRtl(self,
                name: str,
                run_dir,
                pipeline_stages: int = 1,
                gen_testbench: bool = True,
                test_size: int = 1000,
                seed: int | None = None,
                visualization: bool = False,
                sanity_check_size: int = 8,
                backend: str = 'hw') -> dict:
        '''Emit RTL for this butterfly scheme. Precondition: self.aIn / self.bIn
        are IntType bounds and self.twiddle is set (i.e., the scheme is fully
        populated for spec extraction).

        When gen_testbench=True, the method samples `test_size` random inputs
        in the spec's bound range, runs propagateValue end-to-end via a fresh
        clone of this scheme to compute goldens, then dispatches to the
        chosen backend generator with cwd inside `run_dir`. A local sanity
        check round-trips the first `sanity_check_size` testvector lines
        through propagateValue to catch twos-complement encoding bugs before
        any remote sim. Returns the metadata dict from the generator.

        `backend` selects the RTL flavor:
          - 'hw'  (default): the optimized Versal compressor-tree generator
            (`rtl_gen.butterfly.Butterfly_RTL_gen`). Files land in
            `<run_dir>/RTL_generated/`, `<run_dir>/xdc_generated/`,
            `<run_dir>/testvectors/` (when gen_testbench),
            `<run_dir>/bitheap_visualization/` (when visualization).
          - 'sim': the behavioral simulation-only generator
            (`sim_rtl_gen.butterfly.Butterfly_SimRTL_gen`). Same testvectors,
            same testbench convention; the SV body is a `+/-` sum of
            signed-shifted-sliced terms instead of a compressor tree. No
            `xdc_generated/` and no bit-heap artifacts are written.'''
        import os as _os
        import random as _random
        from pathlib import Path as _Path

        run_dir = _Path(run_dir)
        run_dir.mkdir(parents=True, exist_ok=True)

        spec = self.getOperatorInterface(name=name)

        a_in: list[int] | None = None
        b_in: list[int] | None = None
        a_out: list[int] | None = None
        b_out: list[int] | None = None
        if gen_testbench:
            if seed is not None:
                _random.seed(seed)
            if spec.aInIsSigned:
                a_lo, a_hi = -(1 << (spec.aInBitWidth - 1)), (1 << (spec.aInBitWidth - 1)) - 1
            else:
                a_lo, a_hi = 0, (1 << spec.aInBitWidth) - 1
            if spec.bInIsSigned:
                b_lo, b_hi = -(1 << (spec.bInBitWidth - 1)), (1 << (spec.bInBitWidth - 1)) - 1
            else:
                b_lo, b_hi = 0, (1 << spec.bInBitWidth) - 1
            a_in = [_random.randint(a_lo, a_hi) for _ in range(test_size)]
            b_in = [_random.randint(b_lo, b_hi) for _ in range(test_size)]

            golden = GoldilocksSlice64(name=f'{name}_golden', butterflyType=self.butterflyType)
            golden.aIn = a_in
            golden.bIn = b_in
            golden.twiddle = spec.liftedTwiddleNaf
            golden.aInBitWidth = spec.aInBitWidth
            golden.bInBitWidth = spec.bInBitWidth
            a_out, b_out = golden.propagateValue()

        if backend == 'sim':
            from sim_rtl_gen.butterfly import Butterfly_SimRTL_gen as _gen
        elif backend == 'hw':
            from rtl_gen.butterfly import Butterfly_RTL_gen as _gen
        else:
            raise ValueError(f"backend must be 'hw' or 'sim', got {backend!r}")

        saved = _os.getcwd()
        _os.chdir(str(run_dir))
        try:
            meta = _gen(
                spec=spec,
                pipeline_stages=pipeline_stages,
                gen_testbench=gen_testbench,
                visualization=visualization,
                aIn=a_in, bIn=b_in, aOut=a_out, bOut=b_out,
            )
        finally:
            _os.chdir(saved)

        if gen_testbench and sanity_check_size > 0:
            _sanityCheckButterflyTestvectors(run_dir, spec, sanity_check_size)

        return meta


def _sanityCheckButterflyTestvectors(run_dir, spec, sample_size: int = 8) -> None:
    '''Read the first `sample_size` lines of each testvector file, decode
    aIn/bIn back to signed Python ints, re-run propagateValue, and confirm the
    aOut/bOut hex bytes match what's on disk. Catches twos-complement encoding
    bugs locally before any remote sim. Mirrors the original
    `scripts/build_butterfly.py::sanity_check_testvectors`.'''
    from pathlib import Path as _Path
    tv = _Path(run_dir) / 'testvectors'

    def _readHex(path, n):
        with path.open() as f:
            return [int(line.strip(), 16) for _, line in zip(range(n), f) if line.strip()]

    aInHex  = _readHex(tv / 'aIn.txt',  sample_size)
    bInHex  = _readHex(tv / 'bIn.txt',  sample_size)
    aOutHex = _readHex(tv / 'aOut.txt', sample_size)
    bOutHex = _readHex(tv / 'bOut.txt', sample_size)
    n = min(len(aInHex), len(bInHex), len(aOutHex), len(bOutHex))
    if n == 0:
        raise RuntimeError('emitRtl sanity-check: no testvectors loaded from disk')

    aBw, bBw = spec.aInBitWidth, spec.bInBitWidth
    aSign, bSign = spec.aInIsSigned, spec.bInIsSigned
    aInDec = [(x - (1 << aBw)) if aSign and (x >> (aBw - 1)) else x for x in aInHex[:n]]
    bInDec = [(x - (1 << bBw)) if bSign and (x >> (bBw - 1)) else x for x in bInHex[:n]]

    sv = GoldilocksSlice64(name='sanity', butterflyType=spec.butterflyType)
    sv.aIn = aInDec
    sv.bIn = bInDec
    sv.twiddle = spec.liftedTwiddleNaf
    sv.aInBitWidth = spec.aInBitWidth
    sv.bInBitWidth = spec.bInBitWidth
    aOutPv, bOutPv = sv.propagateValue()
    aOutExpected = [v & ((1 << spec.aOutBitWidth) - 1) for v in aOutPv]
    bOutExpected = [v & ((1 << spec.bOutBitWidth) - 1) for v in bOutPv]

    aMatch = sum(x == y for x, y in zip(aOutHex[:n], aOutExpected))
    bMatch = sum(x == y for x, y in zip(bOutHex[:n], bOutExpected))
    if aMatch != n or bMatch != n:
        raise RuntimeError(
            f'emitRtl sanity-check FAILED: aOut {aMatch}/{n}, bOut {bMatch}/{n}. '
            f'On-disk hex does not match propagateValue — likely a twos-complement '
            f'encoding bug.'
        )
    print(f'[emitRtl] sanity-check OK: aOut {aMatch}/{n}, bOut {bMatch}/{n}')
