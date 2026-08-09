from math import log2
from operator_modeling.ntt.ButterflyScheme import GoldilocksSlice64
from operator_modeling.core.IntType import IntType
from operator_modeling.ntt.NTT import FullyPipelinedNTT, FullyPipelinedINTT
from operator_modeling.ntt.twiddles import calculateNttTwiddles, calculateInttTwiddles
from operator_modeling.ntt.verification import verifyNtt, verifyIntt


if __name__ == '__main__':
    q = 2**64 - 2**32 + 1
    n = 128
    L = int(log2(n))
    r128 = 17870292113338400769

    inputBound = IntType.signed(96)
    valueRange = (-(2**95), 2**95 - 1)

    for direction, klass, twiddleFn, verifyFn in (
        ('ntt',  FullyPipelinedNTT,  calculateNttTwiddles,  verifyNtt),
        ('intt', FullyPipelinedINTT, calculateInttTwiddles, verifyIntt),
    ):
        for kind in ('GS', 'CT'):
            twiddles = twiddleFn(modulus=q, n=n, butterflyType=kind,
                                 primitiveRoot=r128,
                                 useModulusLiftingNaf=True,
                                 maxNumberOfTerms=3)
            inst = klass(name=f'{direction}{n}_{kind}', n=n, q=q,
                         butterflyType=kind, twiddles=twiddles)
            schemes = [[GoldilocksSlice64(name=f'{inst.name}_L{s}_p{p}_scheme',
                                          butterflyType=kind)
                        for p in range(n // 2)] for s in range(L)]
            inst.setScheme(schemes)
            ok = verifyFn(inst, primitiveRoot=r128, batchSize=4, seed=0,
                          inputBound=inputBound, valueRange=valueRange)
            if not ok:
                raise RuntimeError(f'{inst.name} verification failed')
            inst.showBounds()
            inst.saveBoundsToXlsx()
            print()

