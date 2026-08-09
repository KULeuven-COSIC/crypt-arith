'''Memoised bit-heap analysis, one cache per operator family.

Counting the compression layers a bit heap needs means running the GPC placement
heuristic, which deep-copies the whole heap. A 64-entry constant-multiplier bank
would run it 64 times over a handful of distinct shapes, so the result is worth
remembering.

**Why one cache per family rather than one shared table.** The answer depends on
`terminalLayers` as well as the heap shape — 1 for a constant multiplier or a
butterfly, 2 for the Booth multiplier, which prepends a partial-product
generation layer. A single shared table keyed on the shape alone would let
whichever family wrote an entry first decide what the others read back.

The obvious fix is to widen the key. The better fix is to give each family its
own table, because a shared cache only earns its complexity if families actually
hit each other's entries — and measured across 36 distinct Booth heap shapes and
16,758 constant-multiplier heaps, they never do. The shapes are structurally
unlike: a Booth heap is a dense radix-4 trapezoid, a constant-multiplier heap is
sparse and irregular, set by a constant's NAF terms plus Baugh-Wooley
corrections. Sharing buys no hit rate at all and costs a key that must stay
correct forever, including for whoever adds the next operator family.

So `terminalLayers` is a property of the cache, not of the key. Every entry in a
given table means the same thing by construction; there is nothing to
disambiguate and nothing to forget.
'''
from __future__ import annotations


class HeapAnalysisCache:
    '''Memoises `countCompressionLayers` for one family's `terminalLayers`.'''

    def __init__(self, terminalLayers: int, label: str = ''):
        if terminalLayers < 1:
            raise ValueError(
                f'terminalLayers must be >= 1, got {terminalLayers}'
            )
        self.terminalLayers = terminalLayers
        self.label = label
        self._store: dict[tuple, tuple] = {}

    def analyse(self, bitheapList: list[int], widthBh: int) -> tuple:
        '''`(nLayers, layerList, finalHeights)` for this heap, memoised.'''
        from rtl_gen.heap_terms import countCompressionLayers

        key = (tuple(bitheapList), widthBh)
        if key not in self._store:
            self._store[key] = countCompressionLayers(
                bitheapList, widthBh, terminal_layers=self.terminalLayers)
        return self._store[key]

    def clear(self) -> None:
        '''Drop every entry. Nothing needs this yet; a long-running cost search
        eventually might, and a per-family table can be cleared without
        disturbing the others.'''
        self._store.clear()

    def __len__(self) -> int:
        return len(self._store)

    def __repr__(self) -> str:
        tag = f' {self.label}' if self.label else ''
        return (f'HeapAnalysisCache{tag}(terminalLayers={self.terminalLayers}, '
                f'{len(self._store)} entries)')
