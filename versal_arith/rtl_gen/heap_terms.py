"""Shared bit-heap construction and costing for term-list-driven operators.

Any operator whose output is a sum of signed, shifted slices of named signals —
a butterfly output, a constant multiplier, a Karatsuba recombination — builds
the same kind of bit heap from the same kind of `SliceTerm` list. This module is
the single entry point new generators use to reach that machinery, so they never
import `rtl_gen.butterfly` directly.

Two groups of names:

  Re-exported from `rtl_gen.butterfly` (the bodies still live there)
    emitTermBits           place one SliceTerm's bits into raw columns
    buildHeapDescriptors   a term list -> (compressor_desc, assign_desc,
                           bitheap_list, width_bh)
    bitAssign              render one heap bit as a Verilog expression

  New here
    countCompressionLayers  how many compression layers a heap needs, plus the
                            column heights entering the terminal adder
    terminalAdderLutCost    LUT cost of the two-layer quaternary terminal adder

**On the re-exports.** Those three are private in `rtl_gen/butterfly.py`
(`_emit_term_bits`, `_build_heap_descriptors`, `_bit_assign`). Reaching across
modules for private names is a smell, and it is deliberate: the alternative was
copying ~180 lines of Baugh-Wooley bit placement, and two copies of that would
drift. The multiplier modeling work was scoped additive-only, so `butterfly.py`
— which is validated on hardware — is not edited.

Because every new module imports these only from here, the eventual cleanup
(move the bodies into this file, have `butterfly.py` import them back) touches
`butterfly.py` and nothing else. See `docs/REFACTOR_BACKLOG.md` item 1.
"""
from __future__ import annotations

from bitheap import BitHeap
from heuristic import compressAll, formGPCChain, merge_last_stage

# Re-exported under public names. See the module docstring on why these are
# imported rather than moved.
from rtl_gen.butterfly import _emit_term_bits as emitTermBits
from rtl_gen.butterfly import _build_heap_descriptors as buildHeapDescriptors
from rtl_gen.butterfly import _bit_assign as bitAssign

__all__ = [
    "emitTermBits",
    "buildHeapDescriptors",
    "bitAssign",
    "countCompressionLayers",
    "terminalAdderLutCost",
    "heapLutCost",
]

# Columns of headroom the placement heuristic needs above its sweep range: it
# probes `bitheap.heap[col + 2]` when testing counter applicability.
_PLACEMENT_LOOKAHEAD = 2


def countCompressionLayers(
    bitheap_list: list[int],
    width_bh: int,
    terminal_layers: int = 1,
) -> tuple[int, list, list[int]]:
    """Count compression layers for a heap, and report its terminal-adder input.

    Returns `(n_layers, layer_list, final_heights)`:

      - `n_layers` — layers to distribute pipeline registers across, i.e. what
        `reg_flag_list_gen(pipeline_stages, num_layers)` expects. Includes the
        terminal-addition layer(s).
      - `layer_list` — `list[layer][chain][Counter]` from the heuristic. Each
        `Counter` carries a `LUT_cost`, so summing over this gives the exact
        GPC-tree area with no separate cost table to keep in sync.
      - `final_heights` — per-column free-bit counts **entering the terminal
        adder**, for `terminalAdderLutCost`.

    `terminal_layers` is 1 for compressor-only operators (constant multipliers,
    butterfly outputs) and 2 for the Booth multiplier, which prepends a
    partial-product generation layer. It mirrors the `n_layers += 1` / `+= 2`
    that `rtl_gen/const_mult.py`, `rtl_gen/butterfly.py` and
    `rtl_gen/booth_mult.py` each apply by hand.

    The sequence replicates `rtl_gen/butterfly.py`'s block exactly, so all four
    copies stay in agreement until they are consolidated (REFACTOR_BACKLOG
    item 3).
    """
    if width_bh <= 0:
        raise ValueError(f"countCompressionLayers: width_bh must be > 0, got {width_bh}")
    if not bitheap_list:
        raise ValueError("countCompressionLayers: bitheap_list is empty")
    if width_bh < len(bitheap_list):
        raise ValueError(
            f"countCompressionLayers: width_bh ({width_bh}) is narrower than the "
            f"{len(bitheap_list)} populated columns; pass the width_bh that "
            f"buildHeapDescriptors returned"
        )

    # `placeGPCs` tests candidate counters by looking up to two columns past the
    # one it is working on (`bitheap.heap[col+2]`), and it sweeps the whole
    # placement range [0, width_bh-1] — so the column list must extend two past
    # width_bh or the lookahead raises IndexError.
    #
    # `BitHeap(n, preallocate)` sets `width = n` and allocates `n + preallocate`
    # columns, so the padding is invisible to everything that matters:
    # `compressAll` is still called over [0, width_bh-1], and `check_last_layer`
    # iterates `self.width`. Results are therefore identical to the
    # `BitHeap(width_bh, 0)` the existing generators use, which happens not to
    # trip the lookahead on the heap shapes they produce.
    bh = BitHeap(width_bh, _PLACEMENT_LOOKAHEAD)
    for col in range(len(bitheap_list)):
        bh.add_bits(col, bitheap_list[col])

    # compressAll mutates `bh` in place: on return it holds the FINAL, fully
    # compressed state (every column at most 4 free bits) — which is precisely
    # the terminal adder's input. `last_bh` is a different object, the state
    # before the last layer, needed only for the merge analysis below.
    last_bh, raw_cl = compressAll(bh, 0, width_bh - 1, False, False)

    cl_formed = formGPCChain(raw_cl)
    n_layers = len(cl_formed)
    if n_layers >= 2:
        merge_flag, _ = merge_last_stage(
            last_compression_layer_counter_list=cl_formed[-1],
            last_compression_layer_bitheap=last_bh,
        )
    else:
        merge_flag = False
    if merge_flag:
        n_layers -= 1
    n_layers += terminal_layers

    final_heights = [bh.heap[i].number_of_free_bits for i in range(bh.width)]
    return n_layers, cl_formed, final_heights


def terminalAdderLutCost(final_heights: list[int]) -> int:
    """LUT cost of the two-layer quaternary terminal adder.

    The adder's cost is not uniform per column — it depends on where a column
    sits relative to two transitions in the post-compression heights:

      - the LSB run, where every column holds at most 2 bits, behaves like a
        plain two-operand adder:                            **1 LUT per column**
      - from the first column holding 3 or more bits, moving toward the MSB, the
        quaternary structure is needed:                      **2 LUT per column**
      - once every remaining higher column holds a single bit, there is nothing
        left to add and cost drops back to:                  **1 LUT per column**

    Example — heights `[2, 2, 3, 4, 3, 1, 1]` cost `2*1 + 3*2 + 2*1 = 10`.
    """
    n = len(final_heights)
    if n == 0:
        return 0

    # First column needing the quaternary structure.
    first_wide = next((i for i, h in enumerate(final_heights) if h >= 3), n)

    # Lowest index from which every higher column holds at most one bit.
    tail = n
    for i in range(n - 1, -1, -1):
        if final_heights[i] <= 1:
            tail = i
        else:
            break
    tail = max(tail, first_wide)

    return first_wide + 2 * (tail - first_wide) + (n - tail)


def heapLutCost(layer_list: list, final_heights: list[int]) -> int:
    """Total LUT cost of a compressor tree: GPC layers plus the terminal adder.

    The GPC part is exact — `Counter.LUT_cost` is the per-GPC model from the
    ARITH 2026 paper, and this is the same sum `compressAll` prints under
    `printUsage`. The terminal-adder part follows `terminalAdderLutCost`.
    """
    gpc = sum(
        counter.LUT_cost
        for layer in layer_list
        for chain in layer
        for counter in chain
    )
    return gpc + terminalAdderLutCost(final_heights)
