import copy

from bitheap import BitHeap
from counter import Counter


def isStartColumn(bitheap: BitHeap, col: int) -> bool:
    """True iff every column before `col` has already been compressed to <= 4 bits
    (i.e. they are terminal-adder-ready and won't need any further GPC placement).
    Used as a tiebreaker in the (2,2,3 : 4] necessity check at the leftmost
    still-active column."""
    for i in range(col):
       if bitheap.heap[i].number_of_free_bits + bitheap.heap[i].number_of_bits_next_round > 4:
            return False
    return True


# counter applicability function
### state: list[limited_chain: bool, position: int]
def isCounterApplicable(name: str, bitheap: BitHeap, col: int, cascade_in: bool, state: list) -> bool:
    if name == "(6 : 3]":
        if bitheap.heap[col].number_of_free_bits >= 6:
            return True
        else:
            return False
    elif name == "(3 : 2]":
        if cascade_in:
            if bitheap.heap[col].number_of_free_bits >= 2 and ((not state[0]) or state[0] and state[1] + 1 <= 8):
                return True
            else:
                return False
        else:
            return True if bitheap.heap[col].number_of_free_bits >= 3 else False
    elif name == "(1,5 : 3]":
        if bitheap.heap[col].number_of_free_bits < 4 and cascade_in:
            return False
        if bitheap.heap[col].number_of_free_bits < 5 and (not cascade_in):
            return False
        if bitheap.heap[col+1].number_of_free_bits < 1:
            return False
        if cascade_in and state[0] and state[1] + 2 > 8:
            return False
        return True
    elif name == "(2,2,3 : 4]":
        if bitheap.heap[col].number_of_free_bits < 2 and cascade_in:
            return False
        if bitheap.heap[col].number_of_free_bits < 3 and (not cascade_in):
            return False
        if bitheap.heap[col+1].number_of_free_bits < 2:
            return False
        if bitheap.heap[col+2].number_of_free_bits < 2:
            return False
        if cascade_in and state[1] % 2 == 1:
            return False
        return True
    elif name == "(9 : 4,1)":
        if bitheap.heap[col].number_of_free_bits < 8 and cascade_in:
            return False
        if bitheap.heap[col].number_of_free_bits < 9 and (not cascade_in):
            return False
        if cascade_in and state[1] % 2 == 1:
            return False
        return True
    elif name == "(3,9 : 2,3,1)":
        if bitheap.heap[col].number_of_free_bits < 8 and cascade_in:
            return False
        if bitheap.heap[col].number_of_free_bits < 9 and (not cascade_in):
            return False
        if bitheap.heap[col+1].number_of_free_bits < 3:
            return False
        if cascade_in and state[1] % 2 == 1:
            return False
        return True
    elif name == "(4,13 : 3,4,1)":
        if bitheap.heap[col].number_of_free_bits < 12 and cascade_in:
            return False
        if bitheap.heap[col].number_of_free_bits < 13 and (not cascade_in):
            return False
        if bitheap.heap[col+1].number_of_free_bits < 4:
            return False
        return True
    elif name == "(5,17 : 4,5,1)":
        if bitheap.heap[col].number_of_free_bits < 17:
            return False
        if bitheap.heap[col+1].number_of_free_bits < 5:
            return False
        return True
    else:
        return False


# counter necessity function
def isCounterNecessary(name: str, bitheap: BitHeap, col: int) -> bool:
    if name == "(6 : 3]":
        if bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round == 9 and \
            bitheap.heap[col+1].number_of_free_bits + bitheap.heap[col+1].number_of_bits_next_round <= 3 and \
            bitheap.heap[col+2].number_of_free_bits + bitheap.heap[col+2].number_of_bits_next_round <= 3:
            return True
        return False
    elif name == "(9 : 4,1)":
        if bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round >= 12 and \
            (bitheap.heap[col+1].number_of_free_bits + bitheap.heap[col+1].number_of_bits_next_round)/5 < (bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round)/17:
            return True
        return False
    elif name == "(3,9 : 2,3,1)":
        if bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round >= 12:
            return True
        return False
    elif name == "(4,13 : 3,4,1)":
        if bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round >= 16:
            return True
        return False
    elif name == "(5,17 : 4,5,1)":
        return True
    elif name == "(3 : 2]":
        if 5 <= bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round <= 6:
            return True
        return False
    elif name == "(1,5 : 3]":
        return True
    elif name == "(2,2,3 : 4]":
        if 5 <= bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round <= 6 and \
            4 <= bitheap.heap[col+1].number_of_free_bits + bitheap.heap[col+1].number_of_bits_next_round <= 5 and \
            bitheap.heap[col+2].number_of_free_bits + bitheap.heap[col+2].number_of_bits_next_round == 5:
            return True
        if 5 <= bitheap.heap[col].number_of_free_bits + bitheap.heap[col].number_of_bits_next_round <= 6 and \
            4 <= bitheap.heap[col+1].number_of_free_bits + bitheap.heap[col+1].number_of_bits_next_round <= 5 and \
            bitheap.heap[col+2].number_of_free_bits + bitheap.heap[col+2].number_of_bits_next_round == 4 and \
            isStartColumn(bitheap, col):
            return True
        return False
    else:
        return False


def placeGPCs(BitHeap: BitHeap, startColumn: int, stopColumn: int) -> tuple[list, bool]:
    col = startColumn
    chains: list[list[Counter]] = []
    current_chain: list[Counter] = []
    advance_flag = True
    state = [False, 0]

    def _place(c: Counter) -> None:
        # Track chain boundaries at placement time. A non-cascade-in counter starts a
        # new chain; a cascade-in counter extends the chain currently being built.
        # When a chain-ending counter (out_cascade=False) is placed, it stays in the
        # current chain — the next non-cascade-in placement triggers chain finalization.
        nonlocal current_chain
        if c.in_cascade:
            current_chain.append(c)
        else:
            if current_chain:
                chains.append(current_chain)
            current_chain = [c]

    while col <= stopColumn:
        # try column counters first
        if isCounterApplicable(name="(5,17 : 4,5,1)", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(5,17 : 4,5,1)", bitheap=BitHeap, col=col):
            name = "(5,17 : 4,5,1)"
            inputs = [5, 17]
            outputs = [4, 5, 1]
            in_cascade = False
            out_cascade = False
            applied_column = col
            LUT_cost = 8
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 1
            advance_flag = False
            state[0] = False
            state[1] = 0
            continue
        if isCounterApplicable(name="(4,13 : 3,4,1)", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(4,13 : 3,4,1)", bitheap=BitHeap, col=col):
            name = "(4,13 : 3,4,1)"
            inputs = [4, 13]
            outputs = [3, 4, 1]
            in_cascade = False
            out_cascade = False
            applied_column = col
            LUT_cost = 6
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 1
            advance_flag = False
            state[0] = False
            state[1] = 0
            continue
        if BitHeap.heap[col].have_cascade_bits:
            if isCounterApplicable(name="(3,9 : 2,3,1)", bitheap=BitHeap, col=col, cascade_in=True, state=state) and \
                    isCounterNecessary(name="(3,9 : 2,3,1)", bitheap=BitHeap, col=col):
                name = "(3,9 : 2,3,1)"
                inputs = [3, 9]
                outputs = [2, 3, 1]
                in_cascade = True
                out_cascade = True
                applied_column = col
                LUT_cost = 4
                counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
                counter_inst.commit(bitheap=BitHeap, check_bound=False)
                _place(counter_inst)
                col += 2
                advance_flag = False
                state[0] = True
                state[1] = 2
                continue
        if isCounterApplicable(name="(3,9 : 2,3,1)", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(3,9 : 2,3,1)", bitheap=BitHeap, col=col):
            name = "(3,9 : 2,3,1)"
            inputs = [3, 9]
            outputs = [2, 3, 1]
            in_cascade = False
            out_cascade = True
            applied_column = col
            LUT_cost = 4
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 2
            advance_flag = False
            state[0] = True
            state[1] = 2
            continue
        if BitHeap.heap[col].have_cascade_bits:
            if isCounterApplicable(name="(9 : 4,1)", bitheap=BitHeap, col=col, cascade_in=True, state=state) and \
                    isCounterNecessary(name="(9 : 4,1)", bitheap=BitHeap, col=col):
                name = "(9 : 4,1)"
                inputs = [9]
                outputs = [4, 1]
                in_cascade = True
                out_cascade = False
                applied_column = col
                LUT_cost = 3
                counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
                counter_inst.commit(bitheap=BitHeap, check_bound=False)
                _place(counter_inst)
                # col += 1
                advance_flag = False
                state[0] = False
                state[1] = 0
                continue
        if isCounterApplicable(name="(9 : 4,1)", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(9 : 4,1)", bitheap=BitHeap, col=col):
            name = "(9 : 4,1)"
            inputs = [9]
            outputs = [4, 1]
            in_cascade = False
            out_cascade = True
            applied_column = col
            LUT_cost = 3
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            # col += 1
            advance_flag = False
            state[0] = True
            state[1] = 2
            continue
        if isCounterApplicable(name="(6 : 3]", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(6 : 3]", bitheap=BitHeap, col=col):
            name = "(6 : 3]"
            inputs = [6]
            outputs = [1, 1, 1]
            in_cascade = False
            out_cascade = True
            applied_column = col
            LUT_cost = 3
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 2
            advance_flag = False
            state[0] = True
            state[1] = 1
            continue
        if BitHeap.heap[col].have_cascade_bits:
            if isCounterApplicable(name="(2,2,3 : 4]", bitheap=BitHeap, col=col, cascade_in=True, state=state) and \
                    isCounterNecessary(name="(2,2,3 : 4]", bitheap=BitHeap, col=col):
                name = "(2,2,3 : 4]"
                inputs = [2, 2, 3]
                outputs = [1, 1, 1, 1]
                in_cascade = True
                out_cascade = False
                applied_column = col
                LUT_cost = 2
                counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
                counter_inst.commit(bitheap=BitHeap, check_bound=False)
                _place(counter_inst)
                col += 1
                advance_flag = False
                state[0] = False
                state[1] = 0
                continue
        if isCounterApplicable(name="(2,2,3 : 4]", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(2,2,3 : 4]", bitheap=BitHeap, col=col):
            name = "(2,2,3 : 4]"
            inputs = [2, 2, 3]
            outputs = [1, 1, 1, 1]
            in_cascade = False
            out_cascade = True
            applied_column = col
            LUT_cost = 2
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 3
            advance_flag = False
            state[0] = True
            state[1] = 2
            continue
        if BitHeap.heap[col].have_cascade_bits:
            if isCounterApplicable(name="(3 : 2]", bitheap=BitHeap, col=col, cascade_in=True, state=state) and \
                    isCounterNecessary(name="(3 : 2]", bitheap=BitHeap, col=col):
                name = "(3 : 2]"
                inputs = [3]
                outputs = [1, 1]
                in_cascade = True
                applied_column = col
                LUT_cost = 1
                state[1] += 1
                if state[0] and state[1] + 1 >= 8:
                    out_cascade = False
                    state[0] = False
                    state[1] = 0
                else:
                    out_cascade = True
                counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
                counter_inst.commit(bitheap=BitHeap, check_bound=False)
                _place(counter_inst)
                if not out_cascade:
                    BitHeap.clear_cascade_bits()
                col += 1
                advance_flag = False
                continue
        if isCounterApplicable(name="(3 : 2]", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(3 : 2]", bitheap=BitHeap, col=col):
            name = "(3 : 2]"
            inputs = [3]
            outputs = [1, 1]
            in_cascade = False
            out_cascade = True
            applied_column = col
            LUT_cost = 1
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 1
            advance_flag = False
            state[0] = False
            state[1] = 1
            continue
        if BitHeap.heap[col].have_cascade_bits:
            if isCounterApplicable(name="(1,5 : 3]", bitheap=BitHeap, col=col, cascade_in=True, state=state) and \
                    isCounterNecessary(name="(1,5 : 3]", bitheap=BitHeap, col=col):
                name = "(1,5 : 3]"
                inputs = [1, 5]
                outputs = [1, 1, 1]
                in_cascade = True
                applied_column = col
                LUT_cost = 2
                state[1] += 2
                # If chain reached or nearly reached LOOKAHEAD8 limit, end it here.
                if state[0] and state[1] + 1 >= 8:
                    out_cascade = False
                    state[0] = False
                    state[1] = 0
                else:
                    out_cascade = True
                counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
                counter_inst.commit(bitheap=BitHeap, check_bound=False)
                _place(counter_inst)
                if not out_cascade:
                    BitHeap.clear_cascade_bits()
                col += 2
                advance_flag = False
                continue
        if isCounterApplicable(name="(1,5 : 3]", bitheap=BitHeap, col=col, cascade_in=False, state=state) and \
                isCounterNecessary(name="(1,5 : 3]", bitheap=BitHeap, col=col):
            name = "(1,5 : 3]"
            inputs = [1, 5]
            outputs = [1, 1, 1]
            in_cascade = False
            out_cascade = True
            applied_column = col
            LUT_cost = 2
            counter_inst = Counter(name, inputs, outputs, in_cascade, out_cascade, applied_column, LUT_cost)
            counter_inst.commit(bitheap=BitHeap, check_bound=False)
            _place(counter_inst)
            col += 2
            advance_flag = False
            state[0] = False
            state[1] = 2
            continue
        col += 1
        BitHeap.clear_cascade_bits()
    if current_chain:
        chains.append(current_chain)
    return chains, advance_flag


def compressLayer(bitheap: BitHeap, startColumn: int, stopColumn: int) -> list:
    """Run placeGPCs repeatedly until no more counters fit, accumulating each
    pass's chains into a single per-layer chain list (list[list[Counter]])."""
    advance_flag = False
    layer_chains: list[list[Counter]] = []
    while not advance_flag:
        chains, advance_flag = placeGPCs(bitheap, startColumn, stopColumn)
        layer_chains.extend(chains)
    return layer_chains


def _place_fallback_rescue(bitheap: BitHeap, startColumn: int, stopColumn: int) -> list:
    """Place a last-resort floating (6 : 3] counter after a stalled layer.

    The hand-tuned placement table has no rule for some isolated columns at
    heights 7, 8, 10, or 11 when the neighboring column has no free bits.
    In that state ``compressLayer`` makes no progress and ``compressAll``
    would otherwise loop forever.  This fallback is only used after a full
    layer pass placed nothing, so it does not affect inputs handled by the
    normal table.
    """
    for col in range(startColumn, stopColumn + 1):
        if bitheap.heap[col].number_of_free_bits >= 6:
            counter_inst = Counter("(6 : 3]", [6], [1, 1, 1], False, True, col, 3)
            counter_inst.commit(bitheap=bitheap, check_bound=False)
            return [[counter_inst]]
    return []


def compressAll(bitheap: BitHeap, startColumn: int, stopColumn: int, plotBitHeap: bool, printUsage: bool) -> tuple[BitHeap, list]:
    """Compress the entire bitheap layer by layer until each column has at most 4 free bits.

    Returns (previous_bitheap, layer_list) where:
      - previous_bitheap: the bitheap state before the last compression layer
        was applied (needed for merge_last_stage analysis).
      - layer_list: list[list[list[Counter]]] — one entry per compression layer,
        each entry is a list of chains, each chain is a list of Counter instances.
    """
    finish_flag = False
    layer_list = []
    layer_no = 0
    LUTUsage = 0
    previous_bitheap = copy.deepcopy(bitheap)
    while not finish_flag:
        counter_layer = compressLayer(bitheap, startColumn, stopColumn)
        if not counter_layer:
            done, _ = bitheap.check_last_layer()
            if not done:
                counter_layer = _place_fallback_rescue(
                    bitheap, startColumn, stopColumn
                )
                if not counter_layer:
                    stuck = [
                        (i, column.number_of_free_bits)
                        for i, column in enumerate(bitheap.heap[:bitheap.width])
                        if column.number_of_free_bits > 4
                    ]
                    raise RuntimeError(
                        "compressAll: no counter (including the >=6-free-bits "
                        "fallback) applies to any remaining column, but the "
                        f"heap isn't terminal. Columns still >4 free bits: {stuck}"
                    )
        layer_list.append(counter_layer)
        bitheap.advance_round()
        if plotBitHeap:
            bitheap.visualize(filename=f"after_layer_{layer_no}", use_next_round=False)
            layer_no += 1
        finish_flag, _ = bitheap.check_last_layer()
        if not finish_flag:
            previous_bitheap.advance_round()
            _ = compressLayer(previous_bitheap, startColumn, stopColumn)
    if printUsage:
        for layer in layer_list:
            for chain in layer:
                for counter in chain:
                    LUTUsage += counter.LUT_cost
        print(f"The LUT Usage without terminal addition is {LUTUsage}")

    return previous_bitheap, layer_list


def formGPCChain(all_layers: list[list]) -> list[list]:
    """Identity. Chains are built during placement in placeGPCs (each non-cascade-in
    counter starts a new chain; each cascade-in counter extends the current chain),
    so this is just a name kept for backwards compatibility with call sites that
    pipe `formGPCChain(compressAll(...)[1])` into `compressor_gen`."""
    return all_layers



# function to check whether the last compression stage can be merged with its previous stage by allowing insufficient use of GPCs
# currently, only allow insufficient use of (3 : 2] counter and (1,5 : 3] counter
def merge_last_stage(last_compression_layer_counter_list: list[list], last_compression_layer_bitheap: BitHeap) -> tuple[bool, list[list[list[int]]]]:
    # first check if all counters are (3 : 2] counters and (1,5 : 3] counters
    reduced_inputs_list = []
    for chain in last_compression_layer_counter_list:
        chain_reduced_inputs = []
        for counter in chain:
            if counter.name == "(3 : 2]" and (not counter.in_cascade):
                if last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round == 3 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 2:
                    chain_reduced_inputs.append([1])
                else:
                    return False, [[[0]]]
            elif counter.name == "(3 : 2]" and counter.in_cascade:
                if last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round == 3 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 1:
                    chain_reduced_inputs.append([1])
                elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round == 3 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 2:
                    chain_reduced_inputs.append([0])
                elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round == 2 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 2:
                    chain_reduced_inputs.append([0])
                elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round == 2 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 3:
                    chain_reduced_inputs.append([0])
                else:
                    return False, [[[0]]]
            elif counter.name == "(1,5 : 3]" and (not counter.in_cascade):
                if last_compression_layer_bitheap.heap[counter.applied_column+1].number_of_free_bits == 0:
                    if last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round < 4 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 4:
                        chain_reduced_inputs.append([1, 1])
                    elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits >= 5:
                        chain_reduced_inputs.append([1, 0])
                    else:
                        return False, [[[0]]]
                else:
                    if last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round < 4 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 4:
                        chain_reduced_inputs.append([0, 1])
                    else:
                        return False, [[[0]]]
            elif counter.name == "(1,5 : 3]" and counter.in_cascade:
                if last_compression_layer_bitheap.heap[counter.applied_column+1].number_of_free_bits == 0:
                    if last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round < 4 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 3:
                        chain_reduced_inputs.append([1, 1])
                    elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round < 4 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 2:
                        chain_reduced_inputs.append([1, 2])
                    elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits >= 5:
                        chain_reduced_inputs.append([1, 0])
                    else:
                        return False, [[[0]]]
                else:
                    if last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round < 4 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 3:
                        chain_reduced_inputs.append([0, 1])
                    elif last_compression_layer_bitheap.heap[counter.applied_column].number_of_bits_next_round < 4 and last_compression_layer_bitheap.heap[counter.applied_column].number_of_free_bits == 2:
                        chain_reduced_inputs.append([0, 2])
                    else:
                        return False, [[[0]]]
            else:
                return False, [[[0]]]
        reduced_inputs_list.append(chain_reduced_inputs)
    return True, reduced_inputs_list
