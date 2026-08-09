from __future__ import annotations
import re
from heapq import nsmallest
from math import log2
from itertools import combinations, product


def nafTerms(x: int) -> list[tuple[int, int]]:
    '''Return the list of (sign, k) pairs for the nonzero terms in the NAF representation of x, where sign is either 1 or -1, and k is the exponent of 2'''
    if x == 0:
        return []
    naf = []
    outerSign = 1 if x > 0 else -1
    x = abs(x)
    k = 0
    while x > 0:
        if x & 1:
            u = 2 - (x & 3)
            naf.append((outerSign * u, k))
            x -= u
        x //= 2
        k += 1
    return naf
            

def nafTermsCount(x: int) -> int:
    '''Return the number of nonzero terms in the NAF representation of x'''
    return len(nafTerms(x))


def nafTermsMaxPower(x: int) -> int:
    '''Return the maximum power of 2 among the nonzero terms in the NAF representation of x, or -1 if x is 0'''
    terms = nafTerms(x)
    if not terms:
        return -1
    return max(k for _, k in terms)


def nafTermsModulusLiftBeamSearch(x: int, modulus: int, maxPower: int, maxMultipleOfModulus: int, maxSearchDepth: int, beamWidth: int) -> tuple[int, list[tuple[int, int]], int, int]:
    '''Return the integer y such that y ≡ x (mod modulus) and the NAF representation of y has the smallest number of nonzero terms among all integers congruent to x modulo modulus and with maximum power of 2 among the nonzero terms in its NAF representation at most maxPower, along with the list of (sign, k) pairs for the nonzero terms in the NAF representation of y, the number of nonzero terms, and the maximum power of 2 among the nonzero terms'''
    def score(x: int) -> tuple[int, int, int]:
        termsCount = nafTermsCount(x)
        termsMaxPower = nafTermsMaxPower(x)
        if termsMaxPower > maxPower:
            return (10**18, 10**18, 10**18)
        absValue = abs(x)
        return (termsCount, absValue, termsMaxPower)
    
    r = x % modulus
    frontier = [r, r - modulus]
    best = min(frontier, key=score)
    if maxMultipleOfModulus < 1:
        raise ValueError(f'maxMultipleOfModulus {maxMultipleOfModulus} must be at least 1')
    maxShift = int(log2(maxMultipleOfModulus)) + 1

    for _ in range(maxSearchDepth):
        candidates = []
        for c in frontier:
            for shift in range(maxShift + 1):
                step = (modulus << shift)
                candidates.append(c + step)
                candidates.append(c - step)
        frontier = nsmallest(beamWidth, candidates, key=score)
        bestCandidate = min(frontier, key=score)
        if score(bestCandidate) < score(best):
            best = bestCandidate

    return best, nafTerms(best), nafTermsCount(best), nafTermsMaxPower(best)


def nafTermsModulusLiftTargetFirstSearch(x: int, modulus: int, maxPower: int, maxNumberOfTerms: int) -> tuple[int, list[tuple[int, int]], int, int] | None:
    '''Find y ≡ x (mod modulus) whose NAF has the fewest nonzero terms (≤ maxNumberOfTerms) with every term's power ≤ maxPower. Returns (y, nafTerms(y), termsCount, maxExponent). Return None if no such y exists in range.'''
    if maxNumberOfTerms < 1:
        raise ValueError(f'maxNumberOfTerms {maxNumberOfTerms} must be at least 1')
    if maxPower < 1:
        raise ValueError(f'maxPower {maxPower} must be at least 1')
    
    r = x % modulus
    if r == 0:
        return 0, [], 0, -1
    
    n = maxPower + 1
    for k in range(1, maxNumberOfTerms + 1):
        # check if k combinations can fit with current maxPower
        if 2 * k - 1 > n:
            break
        for base in combinations(range(n - k + 1), k):
            powers = tuple(p + i for i, p in enumerate(base))
            for signs in product([-1, 1], repeat=k):
                y = sum(s << p for s, p in zip(signs, powers))
                if y % modulus == r:
                    return y, list(zip(signs, powers)), k, powers[-1]
    
    return None


def nafTermsModulusLift(x: int, modulus: int, maxPower: int, maxMultipleOfModulus: int, maxSearchDepth:int, beamWidth: int, maxNumberOfTerms: int) -> tuple[int, list[tuple[int, int]], int, int]:
    '''Return the integer y such that y ≡ x (mod modulus) and the NAF representation of y has the smallest number of nonzero terms among all integers congruent to x modulo modulus and with maximum power of 2 among the nonzero terms in its NAF representation at most maxPower, along with the list of (sign, k) pairs for the nonzero terms in the NAF representation of y, the number of nonzero terms, and the maximum power of 2 among the nonzero terms. This function will first try to find such integer using target-first search, and if it fails, it will fall back to beam search'''
    targetFirstResult = nafTermsModulusLiftTargetFirstSearch(x, modulus, maxPower, maxNumberOfTerms)
    if targetFirstResult is not None:
        return targetFirstResult
    return nafTermsModulusLiftBeamSearch(x, modulus, maxPower, maxMultipleOfModulus, maxSearchDepth, beamWidth)


def bitReverse(x: int, bits: int) -> int:
    '''Reverse the low `bits` bits of x.'''
    result = 0
    for _ in range(bits):
        result = (result << 1) | (x & 1)
        x >>= 1
    return result


def vectorAdd(a: list[int], b: list[int]) -> list[int]:
    '''Element-wise addition. Mirrors IntType.__add__ on a value-batch.'''
    if len(a) != len(b):
        raise ValueError(f'vectorAdd: length mismatch, got {len(a)} and {len(b)}')
    return [x + y for x, y in zip(a, b)]


def vectorSub(a: list[int], b: list[int]) -> list[int]:
    '''Element-wise subtraction. Mirrors IntType.__sub__ on a value-batch.'''
    if len(a) != len(b):
        raise ValueError(f'vectorSub: length mismatch, got {len(a)} and {len(b)}')
    return [x - y for x, y in zip(a, b)]


def vectorMul(a: list[int], scalar: int) -> list[int]:
    '''Per-element multiplication by a scalar. Mirrors IntType.__mul__ with an int operand.'''
    return [x * scalar for x in a]


def vectorLshift(a: list[int], shift: int) -> list[int]:
    '''Per-element left shift. Mirrors IntType.__lshift__.'''
    if shift < 0:
        raise ValueError(f'vectorLshift: shift must be non-negative, got {shift}')
    return [x << shift for x in a]


def vectorRshift(a: list[int], shift: int) -> list[int]:
    '''Per-element right shift (Python arithmetic shift). Mirrors IntType.__rshift__.'''
    if shift < 0:
        raise ValueError(f'vectorRshift: shift must be non-negative, got {shift}')
    return [x >> shift for x in a]


def vectorSlice(a: list[int], start: int, end: int, signed: bool = False) -> list[int]:
    '''Per-element bit-slice over the inclusive range [start, end]. Mirrors IntType.slice: when signed=False (interior limb, width < shifted.bitWidth in the IntType case) returns the unsigned slice (x >> start) & mask. When signed=True (boundary limb, width >= shifted.bitWidth in the IntType case) returns the Python-signed (x >> start) without masking — preserving the sign extension that the Goldilocks limb-folding relies on for negative inputs.'''
    width = end - start + 1
    if width <= 0:
        raise ValueError(f'vectorSlice: invalid range ({start}, {end})')
    if signed:
        return [x >> start for x in a]
    mask = (1 << width) - 1
    return [(x >> start) & mask for x in a]


def vectorBitWidth(a: list[int]) -> int:
    '''Worst-case bit width across a value batch, mirroring IntType.bitWidth: 0 for an all-zero batch; max(x.bit_length()) for an all-non-negative batch; max(negWidth, posWidth) + 1 for a mixed/signed batch (the +1 is the sign bit).'''
    if not a or all(x == 0 for x in a):
        return 0
    if any(x < 0 for x in a):
        negWidth = max(((-x - 1).bit_length() for x in a if x < 0), default=0)
        posWidth = max((x.bit_length() for x in a if x > 0), default=0)
        return max(negWidth, posWidth) + 1
    return max(x.bit_length() for x in a)


def vectorConst(value: int, batchSize: int) -> list[int]:
    '''Constant-filled vector. Mirrors IntType(value, value, 0) initialization for a value-batch.'''
    if batchSize < 0:
        raise ValueError(f'vectorConst: batchSize must be non-negative, got {batchSize}')
    return [value] * batchSize


def formatNafExpr(naf: list[tuple[int, int]]) -> str:
    '''Format a NAF list [(sign, exponent), ...] as a string like "-2^91 + 2^43" or "1".'''
    if not naf:
        return '0'
    parts = []
    for i, (sign, k) in enumerate(naf):
        magnitude = '1' if k == 0 else f'2^{k}'
        if i == 0:
            parts.append(('-' if sign < 0 else '') + magnitude)
        else:
            parts.append((' + ' if sign > 0 else ' - ') + magnitude)
    return ''.join(parts)


def parseNafExpr(s: str) -> list[tuple[int, int]]:
    '''Parse a NAF expression string like "-2^91 + 2^43" or "2^39" or "1" into a list of (sign, exponent) tuples.'''
    compact = s.replace(' ', '')
    if not compact:
        raise ValueError(f'empty NAF expression')
    out: list[tuple[int, int]] = []
    for term in re.findall(r'[+-]?[^+-]+', compact):
        if not term:
            continue
        if term[0] == '-':
            sign, body = -1, term[1:]
        elif term[0] == '+':
            sign, body = 1, term[1:]
        else:
            sign, body = 1, term
        if '^' in body:
            base, exp = body.split('^')
            if base != '2':
                raise ValueError(f'unsupported base in NAF term {term!r}, only base-2 is supported')
            k = int(exp)
        else:
            v = int(body)
            if v <= 0 or (v & (v - 1)) != 0:
                raise ValueError(f'NAF term {term!r} must be a positive power of 2')
            k = v.bit_length() - 1
        out.append((sign, k))
    return out
