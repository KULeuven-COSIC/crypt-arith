'''NTT schemes: an NTT's *architecture*, meaning the butterfly network itself.

An NTT is a network of butterflies, and the shape of that network is the design
decision — fully pipelined, four-step, iterative with a folded datapath. Those
are different **schemes** of one operator, not different operators, so the grid
belongs here rather than inside the `NTT` class.

That relocation is what makes a second architecture possible: writing one means
subclassing `NTTScheme` and answering six questions about topology, with the
operator around it unchanged.

It also removes two long-standing duplications.

**The scheme grid.** Every caller used to hand-build the same
`log2(n) x n/2` comprehension of `GoldilocksSlice64`s and pass it to
`setScheme` — verbatim, in seven places. A scheme that owns its butterflies can
build their schemes too, so `setScheme` becomes optional, for overriding rather
than for construction.

**The index arithmetic.** The stride and bit-reversal rules were spread across
nine sites in `NTT.py`. They are subtle in one specific way: there are *two*
independent permutations, and which one is the identity flips with the butterfly
type.

    CT   inputs bit-reversed,  outputs pass through
    GS   inputs pass through,  outputs bit-reversed

So a single `naturalToMemory` would be wrong — the input side and the output
side need separate maps, exactly one of which is the identity for a given type.
`inputNaturalToMemory` and `outputMemoryToNatural` are that pair.
'''
from __future__ import annotations

from abc import abstractmethod
from math import log2

from ..core.IntType import IntType
from ..core.OperatorScheme import OperatorScheme
from ..core.utils import bitReverse
from .Butterfly import Butterfly
from .ButterflyScheme import ButterflyScheme, GoldilocksSlice64


def butterflyToMems(p: int, stride: int) -> tuple[int, int]:
    '''The two in-place memory slots butterfly `p` reads and writes.'''
    block = p // stride
    offset = p % stride
    mA = block * 2 * stride + offset
    return mA, mA + stride


def memToButterfly(m: int, stride: int) -> tuple[int, str]:
    '''Which butterfly and which port own memory slot `m`.'''
    block = m // (2 * stride)
    offset = m % (2 * stride)
    p = block * stride + (offset % stride)
    return p, ('A' if offset < stride else 'B')


class NTTScheme(OperatorScheme):
    '''Base for an NTT architecture. Owns the butterfly network and its indexing.'''

    def __init__(self, name: str, n: int, q: int, butterflyType: str,
                 twiddles, negacyclic: bool = False):
        super().__init__(name)
        if n <= 0 or (n & (n - 1)) != 0:
            raise ValueError(f'n must be a positive power of 2, got {n}')
        if q <= 0:
            raise ValueError(f'q must be positive, got {q}')
        if butterflyType not in ('CT', 'GS'):
            raise ValueError(f"butterflyType must be 'CT' or 'GS', got {butterflyType!r}")
        if not isinstance(twiddles, list):
            raise TypeError(f'twiddles must be a list of per-layer lists, got {type(twiddles)}')
        self.n = n
        self.q = q
        self.butterflyType = butterflyType
        self.twiddles = twiddles
        self.negacyclic = negacyclic
        self.layers = int(log2(n))
        self.butterflies: list[list[Butterfly]] = []

    # --- topology: the six questions an architecture answers -------------

    @abstractmethod
    def buildGrid(self) -> list[list[Butterfly]]:
        '''Construct and wire the butterfly network, schemes included.'''

    @abstractmethod
    def strideForLayer(self, layerIndex: int) -> tuple[int, int]:
        '''`(strideThisLayer, stridePreviousLayer)`.'''

    @abstractmethod
    def inputStride(self) -> int:
        '''Memory stride the first layer reads at.'''

    @abstractmethod
    def outputStride(self) -> int:
        '''Memory stride the last layer writes at.'''

    @abstractmethod
    def inputNaturalToMemory(self, i: int) -> int:
        '''Memory slot that natural-order input `x[i]` occupies.'''

    @abstractmethod
    def outputMemoryToNatural(self, m: int) -> int:
        '''Natural-order output index held by memory slot `m`.'''

    def checkPermutationsAreInverses(self) -> None:
        '''Guard against the easy mistake of applying one side's rule to the other.'''
        for i in range(self.n):
            m = self.inputNaturalToMemory(i)
            if not 0 <= m < self.n:
                raise ValueError(f'{self.name}: inputNaturalToMemory({i}) = {m} out of range')
        seen = {self.inputNaturalToMemory(i) for i in range(self.n)}
        if len(seen) != self.n:
            raise ValueError(f'{self.name}: inputNaturalToMemory is not a permutation')
        seen = {self.outputMemoryToNatural(m) for m in range(self.n)}
        if len(seen) != self.n:
            raise ValueError(f'{self.name}: outputMemoryToNatural is not a permutation')


class FullyPipelinedGrid(NTTScheme):
    '''One butterfly per position per layer, all layers resident simultaneously.

    The architecture the project has always emitted: `log2(n)` layers of `n/2`
    butterflies, wired in place, no folding and no reuse.
    '''

    _BOUND_ATTRS = ()          # bounds live on the butterflies' own ports
    _VALUE_ATTRS = ()

    def __init__(self, name: str, n: int, q: int, butterflyType: str,
                 twiddles, negacyclic: bool = False,
                 butterflySchemeFactory=None):
        super().__init__(name, n, q, butterflyType, twiddles, negacyclic)
        self.butterflySchemeFactory = butterflySchemeFactory or self._defaultScheme
        self.butterflies = self.buildGrid()

    def _defaultScheme(self, layerIndex: int, position: int) -> ButterflyScheme:
        return GoldilocksSlice64(
            name=f'{self.name}_L{layerIndex}_p{position}',
            butterflyType=self.butterflyType)

    # --- topology ---------------------------------------------------------

    def strideForLayer(self, layerIndex: int) -> tuple[int, int]:
        if self.butterflyType == 'CT':
            strideThis = 1 << layerIndex          # doubles each stage
            return strideThis, strideThis >> 1
        strideThis = 1 << (self.layers - layerIndex - 1)   # halves each stage
        return strideThis, strideThis << 1

    def inputStride(self) -> int:
        return 1 if self.butterflyType == 'CT' else self.n // 2

    def outputStride(self) -> int:
        return self.n // 2 if self.butterflyType == 'CT' else 1

    def inputNaturalToMemory(self, i: int) -> int:
        # CT consumes bit-reversed order; GS consumes natural order.
        return bitReverse(i, self.layers) if self.butterflyType == 'CT' else i

    def outputMemoryToNatural(self, m: int) -> int:
        # ...and the output side is the mirror image: CT emits natural order,
        # GS emits bit-reversed. Exactly one of the two maps is the identity.
        return m if self.butterflyType == 'CT' else bitReverse(m, self.layers)

    # --- construction -----------------------------------------------------

    def buildGrid(self) -> list[list[Butterfly]]:
        grid: list[list[Butterfly]] = []
        for layerIndex in range(self.layers):
            strideThis, stridePrev = self.strideForLayer(layerIndex)
            layer: list[Butterfly] = []
            for position in range(self.n // 2):
                bfly = Butterfly(
                    name=f'{self.name}_layer{layerIndex}_butterfly{position}',
                    butterflyType=self.butterflyType,
                    twiddle=self.twiddles[layerIndex][position],
                )
                # The scheme is built here too. Every caller used to assemble
                # this same comprehension and pass it to setScheme; owning the
                # butterflies means owning their arithmetic as well.
                bfly.scheme = self.butterflySchemeFactory(layerIndex, position)
                if layerIndex > 0:
                    mA, mB = butterflyToMems(position, strideThis)
                    pA, portA = memToButterfly(mA, stridePrev)
                    pB, portB = memToButterfly(mB, stridePrev)
                    bfly.connectInTo(
                        connectATo=(grid[layerIndex - 1][pA], portA),
                        connectBTo=(grid[layerIndex - 1][pB], portB),
                    )
                layer.append(bfly)
            grid.append(layer)
        return grid

    # --- OperatorScheme surface -------------------------------------------
    #
    # An NTT scheme is a network, so its bound and value paths are the network
    # traversal: every butterfly computes in layer order, each pushing to the
    # next. The per-port payloads live on the butterflies' ports, not here.

    def propagateBound(self):
        for layer in self.butterflies:
            for bfly in layer:
                bfly.compute()

    def propagateValue(self):
        for layer in self.butterflies:
            for bfly in layer:
                bfly.compute()

    def areaCost(self) -> tuple[int, int]:
        lut = dsp = 0
        for layer in self.butterflies:
            for bfly in layer:
                cost = bfly.scheme.areaCost()
                if cost is not None:
                    lut += cost[0]
                    dsp += cost[1]
        return lut, dsp

    def latency(self, pipelineStages: int = 1) -> int:
        return self.layers * pipelineStages

    def getOperatorInterface(self, name: str, pipelineStages: int = 1):
        raise NotImplementedError(
            'the NTT spec is assembled by the NTT operator, which owns the '
            'natural-order port widths; see FullyPipelinedNTT.getOperatorInterface'
        )
