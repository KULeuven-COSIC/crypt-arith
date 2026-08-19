'''Ground truth for an NTT pipeline: O(n^2) references and the verify harness.

`referenceNtt` / `referenceIntt` are deliberately the naive transforms, computed
in Sage — they exist to be obviously correct, not fast. `verifyNtt` /
`verifyIntt` drive random vectors through a populated pipeline and check two
separate things: that every output matches the reference modulo q, and that
every intermediate value lands inside the interval the bound path predicted for
its port.

**The mod-q half is weaker than it looks.** It compares `output % q`, so a
result that has drifted by a whole multiple of q still passes. That is not
hypothetical — slicing at the wrong register width produces exactly such a
drift, which is why `shiftAndSliceGoldilocks64Value` now refuses to guess a
width, and why the refactor gate is a byte-identical diff of the emitted
testvectors rather than this harness alone.
'''
from __future__ import annotations

import random
from math import log2
from typing import TYPE_CHECKING

from sage.all import GF

from ..core.IntType import IntType
from ..core.OperatorScheme import sampleBound
from ..core.utils import bitReverse
from .NTT import memToButterfly

if TYPE_CHECKING:                      # avoids a circular import at runtime
    from .NTT import FullyPipelinedINTT, FullyPipelinedNTT

def referenceNtt(x: list[int], modulus: int,
                 primitiveRoot: int | None = None,
                 negacyclic: bool = False) -> list[int]:
    '''Slow O(n^2) reference NTT for verification. Computes Y[k] for k in [0, n):
        cyclic:     Y[k] = sum_i x[i] * w^(i*k)         mod modulus
        negacyclic: Y[k] = sum_i x[i] * psi^(i*(2k+1))  mod modulus
    where w = F.zeta(n) and psi = F.zeta(2n) by default (matching calculateNttTwiddles).
    Output is a Python list[int] in [0, modulus), in natural order Y[0], Y[1], ..., Y[n-1].
    To compare against a pipeline whose output is in bit-reversed memory order
    (FullyPipelinedNTT with butterflyType='GS'), apply bitReverse to one side.'''
    if not isinstance(x, list) or not all(isinstance(v, int) for v in x):
        raise TypeError('x must be a list[int]')
    n = len(x)
    if n < 1:
        raise ValueError('x must be non-empty')
    F = GF(modulus)
    base = F(primitiveRoot) if primitiveRoot is not None else (F.zeta(2 * n) if negacyclic else F.zeta(n))
    if negacyclic:
        return [int(sum(F(x[i]) * base ** (i * (2 * k + 1)) for i in range(n))) for k in range(n)]
    return [int(sum(F(x[i]) * base ** (i * k) for i in range(n))) for k in range(n)]


def referenceIntt(y: list[int], modulus: int,
                  primitiveRoot: int | None = None,
                  negacyclic: bool = False,
                  divideByN: bool = True) -> list[int]:
    '''Slow O(n^2) reference inverse NTT for verification. Inverts referenceNtt by raising to w^(-1) (cyclic) or psi^(-1) (negacyclic). With divideByN=True (default), returns the canonical mathematical inverse so referenceIntt(referenceNtt(x)) == x. With divideByN=False, omits the 1/n factor so the result equals n*x mod modulus — useful for verifying FullyPipelinedINTT, which intentionally drops the 1/n scaling. Output is in natural order x[0], x[1], ..., x[n-1].'''
    if not isinstance(y, list) or not all(isinstance(v, int) for v in y):
        raise TypeError('y must be a list[int]')
    n = len(y)
    if n < 1:
        raise ValueError('y must be non-empty')
    F = GF(modulus)
    fwdBase = F(primitiveRoot) if primitiveRoot is not None else (F.zeta(2 * n) if negacyclic else F.zeta(n))
    invBase = fwdBase ** (-1)
    if negacyclic:
        x = [sum(F(y[k]) * invBase ** (i * (2 * k + 1)) for k in range(n)) for i in range(n)]
    else:
        x = [sum(F(y[k]) * invBase ** (i * k) for k in range(n)) for i in range(n)]
    if divideByN:
        nInv = F(n) ** (-1)
        x = [v * nInv for v in x]
    return [int(v) for v in x]


def _verifyImpl(instance: FullyPipelinedNTT, isInverse: bool, primitiveRoot: int | None,
                batchSize: int, seed: int | None,
                inputBound: 'IntType | list[IntType] | None',
                valueRange: tuple[int, int] | None, verbose: bool) -> bool:
    if instance.negacyclic:
        # NWC requires the standard pairing: forward = CT, inverse = GS.
        if not isInverse and instance.butterflyType != 'CT':
            raise ValueError(
                f"verifyNtt for negacyclic instance requires butterflyType == 'CT'; "
                f"got {instance.butterflyType!r}. The GS butterfly equation does not "
                f"compute a forward NWC NTT under cyclic-CT-style wiring."
            )
        if isInverse and instance.butterflyType != 'GS':
            raise ValueError(
                f"verifyIntt for negacyclic instance requires butterflyType == 'GS'; "
                f"got {instance.butterflyType!r}. The CT butterfly equation does not "
                f"compute an inverse NWC NTT under cyclic-CT-style wiring."
            )
    if seed is not None:
        random.seed(seed)
    n = instance.n
    q = instance.q
    negacyclic = instance.negacyclic

    # inputBound accepts three forms:
    #   - None         : default IntType.signed(66) broadcast to every natural index
    #   - IntType      : broadcast to every natural index (current behavior)
    #   - list[IntType]: per-natural-index list of length n; each x[i]'s value
    #                    range is derived from its own bound's [minValue, maxValue]
    #                    and `valueRange` is ignored (a single global range cannot
    #                    represent per-port mixed signed/unsigned widths)
    if inputBound is None:
        inputBound = IntType.signed(66)
    if isinstance(inputBound, list):
        if len(inputBound) != n:
            raise ValueError(
                f'inputBound list must have length n={n}, got {len(inputBound)}'
            )
        bounds_per_natural = inputBound
        # Must go through sampleBound, not a bare randint over [min, max]: a
        # bound carries known-zero LSBs, and the emitted hardware has no bits in
        # those positions at all. A sample with nonzero bits down there is a
        # value the datapath cannot represent, so propagating it lands outside
        # the predicted interval and the containment check fails on correct
        # hardware. Primary NTT inputs have zeroLsbs == 0 and never noticed;
        # inputs driven from a constant-multiplier bank routinely do not.
        natural = [sampleBound(b, batchSize, random) for b in bounds_per_natural]
    else:
        if valueRange is None:
            valueRange = (-(2 ** 65), 2 ** 65 - 1)
        bounds_per_natural = [inputBound] * n
        # `valueRange` overrides the bound's interval, but it cannot override the
        # bound's known-zero LSBs — same unrepresentability argument as above, so
        # snap the range onto that lattice. A no-op when zeroLsbs == 0, which
        # keeps every existing caller sampling exactly the values it did before.
        step = 1 << inputBound.zeroLsbs
        lo = (-((-valueRange[0]) // step) if valueRange[0] < 0
              else valueRange[0] // step)
        hi = valueRange[1] // step
        natural = [[random.randint(lo, hi) * step for _ in range(batchSize)]
                   for _ in range(n)]

    instance.getInputsNatural(bounds_per_natural)
    instance.getInputsNatural(natural)
    instance.compute()

    # Read testVector straight off the natural-order output ports. Not
    # getOutputsNatural(), which prefers `bound` when both are set — and both are
    # set above. The ports themselves are already in natural order, so there is
    # no permutation to redo here.
    pipelineOutNatural = [p.testVector for p in instance.outputPorts]

    modQFails = 0
    for b in range(batchSize):
        x = [natural[m][b] for m in range(n)]
        if isInverse:
            ref = referenceIntt(x, q, primitiveRoot=primitiveRoot, negacyclic=negacyclic, divideByN=False)
        else:
            ref = referenceNtt(x, q, primitiveRoot=primitiveRoot, negacyclic=negacyclic)
        for m in range(n):
            actual = pipelineOutNatural[m][b] % q
            if actual != ref[m]:
                modQFails += 1
                if verbose and modQFails <= 5:
                    print(f'  mod-q mismatch batch {b} pos {m}: actual={actual}, ref={ref[m]}')

    boundFails = 0
    portCount = 0
    for layer in instance.butterflies:
        for bfly in layer:
            for outPort in (bfly.outputPortA, bfly.outputPortB):
                bnd = outPort.bound
                vec = outPort.testVector
                if bnd is None or vec is None:
                    continue
                portCount += len(vec)
                for v in vec:
                    if v < bnd.minValue or v > bnd.maxValue:
                        boundFails += 1

    totalModQ = batchSize * n
    if verbose:
        label = 'verifyIntt' if isInverse else 'verifyNtt'
        print(f'{label} {instance.name}: '
              f'mod-q {totalModQ - modQFails}/{totalModQ}, '
              f'bound containment {portCount - boundFails}/{portCount}')
    return modQFails == 0 and boundFails == 0


def verifyNtt(instance: FullyPipelinedNTT,
              primitiveRoot: int | None = None,
              batchSize: int = 4,
              seed: int | None = None,
              inputBound: 'IntType | list[IntType] | None' = None,
              valueRange: tuple[int, int] | None = None,
              verbose: bool = True) -> bool:
    '''Generate `batchSize` random natural-order test vectors, run them through `instance` (loading both bounds and values so propagateValue uses the same hardware-register slicing as propagateBound), compute the reference via referenceNtt, and check (a) pipeline_output[m] mod q == referenceNtt(x)[m] for every m and every batch element, and (b) every actual test value at every output port lies inside that port's bound interval. Returns True iff both pass everywhere; False otherwise. With verbose=True (default) prints the first 5 mod-q failure lines and a summary. `primitiveRoot` should match what was used to build the twiddles; if None, defaults to F.zeta(n) (cyclic) or F.zeta(2n) (negacyclic), matching calculateNttTwiddles. `inputBound` accepts three forms: None (default IntType.signed(66) broadcast), a single IntType (broadcast to every natural index), or a list[IntType] of length n (per-natural-index bounds — values sampled within each bound's [minValue, maxValue], `valueRange` is ignored in this case). `valueRange` defaults to (-(2**65), 2**65 - 1) when broadcasting; override both consistently if changing either.'''
    return _verifyImpl(instance=instance, isInverse=False, primitiveRoot=primitiveRoot,
                       batchSize=batchSize, seed=seed, inputBound=inputBound,
                       valueRange=valueRange, verbose=verbose)


def verifyIntt(instance: FullyPipelinedINTT,
               primitiveRoot: int | None = None,
               batchSize: int = 4,
               seed: int | None = None,
               inputBound: 'IntType | list[IntType] | None' = None,
               valueRange: tuple[int, int] | None = None,
               verbose: bool = True) -> bool:
    '''Same as verifyNtt but compares against referenceIntt(..., divideByN=False), since FullyPipelinedINTT intentionally drops the 1/n scaling. Pass the FORWARD `primitiveRoot` (referenceIntt inverts it internally to get the inverse base). `inputBound` accepts the same three forms as verifyNtt: None, a single IntType, or a list[IntType] of length n.'''
    return _verifyImpl(instance=instance, isInverse=True, primitiveRoot=primitiveRoot,
                       batchSize=batchSize, seed=seed, inputBound=inputBound,
                       valueRange=valueRange, verbose=verbose)
