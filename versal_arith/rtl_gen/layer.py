from counter import Counter
from rtl_gen.utils import width_expr
from rtl_gen.chain import chain_gen
from rtl_gen.floating_gpc import floatingGPC_gen, floatingGPC_placement


def layer_admin(layer_inputs: list[int], chain_list: list[list[Counter]], merge_flag: bool, merge_chain_list: list[list[Counter]], reduced_inputs: list[list[list[int]]]) -> tuple[list, list, list, list]:
    """
    :param layer_inputs: the list of inputs, indicating how many bits are there in each column
    :param chain_list: the counter chains and floating counters to be applied in current layer
    :param merge_flag: whether a layer of insufficiently used GPCs should be merged with current layer
    :param merge_chain_list: the counter chains and floating counters to be merged with current layer
    :param reduced_inputs: the number input bits of the insufficiently used counters which should be set to 0
    :return: a tuple of four lists:
                first list: the layer outputs, which is the layer_inputs for the next layer
                second list: containing the inputs for counter chains and floating counters, the order corresponds to the chain_list order
                third list: containing the outputs for counter chains and floating counters, the order corresponds to the chain_list order
                fourth list: containing lists of tuples that serve for assign statement in RTL, i.e. directly moving the bits to the next layer
    """
    num_cols = len(layer_inputs)
    input_bit_pointers = [0] * num_cols
    output_bit_pointers = [0] * num_cols
    layer_outputs_list = []
    chain_inputs_list = []
    chain_outputs_list = []
    assignment_list = []
    original_num_chains = len(chain_list)
    if merge_flag:
        chain_list.extend(merge_chain_list)
    num_chains = len(chain_list)
    for k in range(num_chains):
        chain = chain_list[k]
        num_counters = len(chain)
        inputs = []
        outputs = []
        for i in range(num_counters):
            counter_inputs = list(chain[i].inputs)
            counter_inputs[-1] -= 1 if i else 0
            num_in_cols = len(counter_inputs)
            for j in range(num_in_cols):
                inputs.append(list(range(input_bit_pointers[chain[i].applied_column+j], input_bit_pointers[chain[i].applied_column+j]+counter_inputs[num_in_cols-1-j])))
                input_bit_pointers[chain[i].applied_column+j] += counter_inputs[num_in_cols-1-j]
                if k >= original_num_chains:
                    num_reduced_inputs = reduced_inputs[k-original_num_chains][i][num_in_cols-1-j]
                    if num_reduced_inputs > 0:
                        del inputs[-1][-num_reduced_inputs:]
                    input_bit_pointers[chain[i].applied_column+j] -= num_reduced_inputs
            counter_outputs = list(chain[i].outputs)
            counter_outputs[0] -= 1 if i != num_counters-1 else 0
            num_out_cols = len(counter_outputs)
            for j in range(num_out_cols):
                to_append = list(range(output_bit_pointers[chain[i].applied_column+j], output_bit_pointers[chain[i].applied_column+j]+counter_outputs[num_out_cols-1-j]))
                if to_append:
                    if i != 0 and j==0 and chain[i-1].name == "(3,9 : 2,3,1)":
                        outputs[-1].extend(to_append)
                    else:
                        outputs.append(to_append)
                output_bit_pointers[chain[i].applied_column+j] += counter_outputs[num_out_cols-1-j]
        chain_inputs_list.append(inputs)
        chain_outputs_list.append(outputs)
    for i in range(num_cols):
        if input_bit_pointers[i] < layer_inputs[i]:
            col_assign_list = []
            for j in range(layer_inputs[i]-input_bit_pointers[i]):
                old_idx = input_bit_pointers[i]+j
                new_idx = output_bit_pointers[i]+j
                col_assign_list.append((old_idx, new_idx))
            assignment_list.append(col_assign_list)
            output_bit_pointers[i] += (layer_inputs[i]-input_bit_pointers[i])
        else:
            assignment_list.append([])
        layer_outputs_list.append(output_bit_pointers[i])
    return layer_outputs_list, chain_inputs_list, chain_outputs_list, assignment_list


def assignment_gen(layer_no: int, assign_list: list, reg_flag: bool) -> str:
    assign_str = f""
    num_col = len(assign_list)
    if not reg_flag:
        for col in range(num_col):
            col_assign_list = assign_list[col]
            for old_idx, new_idx in col_assign_list:
                if len(col_assign_list) == 1:
                    if old_idx == 0 and new_idx == 0:
                        assign_str += f"""
    assign layer{layer_no+1}_col{col}    = layer{layer_no}_col{col};"""
                    elif old_idx == 0:
                        assign_str += f"""
    assign layer{layer_no+1}_col{col}[{new_idx}] = layer{layer_no}_col{col};"""
                    elif new_idx == 0:
                        assign_str += f"""
    assign layer{layer_no+1}_col{col}    = layer{layer_no}_col{col}[{old_idx}];"""
                    else:
                        assign_str += f"""
    assign layer{layer_no+1}_col{col}[{new_idx}] = layer{layer_no}_col{col}[{old_idx}];"""
                else:
                    assign_str += f"""
    assign layer{layer_no+1}_col{col}[{new_idx}] = layer{layer_no}_col{col}[{old_idx}];"""
    else:
        assign_str += f"""
    always_ff @(posedge clk) begin"""
        for col in range(num_col):
            col_assign_list = assign_list[col]
            for old_idx, new_idx in col_assign_list:
                if len(col_assign_list) == 1:
                    if old_idx == 0 and new_idx == 0:
                        assign_str += f"""
        layer{layer_no+1}_col{col}    <= layer{layer_no}_col{col};"""
                    elif old_idx == 0:
                        assign_str += f"""
        layer{layer_no+1}_col{col}[{new_idx}] <= layer{layer_no}_col{col};"""
                    elif new_idx == 0:
                        assign_str += f"""
        layer{layer_no+1}_col{col}    <= layer{layer_no}_col{col}[{old_idx}];"""
                    else:
                        assign_str += f"""
        layer{layer_no+1}_col{col}[{new_idx}] <= layer{layer_no}_col{col}[{old_idx}];"""
                else:
                    assign_str += f"""
        layer{layer_no+1}_col{col}[{new_idx}] <= layer{layer_no}_col{col}[{old_idx}];"""
        assign_str += f"""
    end
    """
    return assign_str


def layer_gen(layer_no: int, layer_inputs: list[int], chains_list: list[list[Counter]], reg_flag: bool, merge_flag: bool, merge_counter_list: list[list[Counter]], reduced_inputs: list[list[list[int]]]) -> tuple[list[int], str, str, str, str]:
    """
    :param layer_no: the index of the layer to generate RTL for
    :param layer_inputs: the list of inputs, indicating how many bits are there in each column
    :param chains_list: the counter chains and floating counters to be applied in current layer
    :param reg_flag: whether to register the outputs of this layer
    :return: a tuple of one list of integers and four strings:
                the list: the layer outputs, will be used as the layer_inputs
                first string: layer head comments
                second string: signal declaration with GPC (chain) comments
                third string: GPC instantiation and assignments
                fourth string: constraints
    """
    # analyze the layer
    next_layer_inputs, chains_inputs, chains_outputs, assignments_list = layer_admin(layer_inputs=layer_inputs,
                                                                                     chain_list=chains_list,
                                                                                     merge_flag=merge_flag,
                                                                                     merge_chain_list=merge_counter_list,
                                                                                     reduced_inputs=reduced_inputs)
    layer_head_comments = f"""
    // ------------------------------ LAYER {layer_no} ------------------------------"""
    signal_decl = f"""
    """
    instan = f""
    xdc = f""
    # declaration of the layer signal
    left_w = max(len(str(v-1)) for v in layer_inputs)
    w = max(len(width_expr(v-1, left_w)) for v in layer_inputs)
    num_col = len(layer_inputs)
    for i in range(num_col):
        if layer_inputs[i]:
            sig = width_expr(layer_inputs[i]-1, left_w)
            signal_decl += f"""logic {sig:<{w}} layer{layer_no}_col{i};
    """
    # constructing the layer with GPC (chains)
    num_chains_and_floating = len(chains_list)
    chain_cnt = 0
    floating_cnt = 0
    floating_placement_list = []
    floating_placement_len = 0
    for i in range(num_chains_and_floating):
        if len(chains_list[i]) == 1:
            f_comments, f_declaration, f_instance, f_xdc = floatingGPC_gen(chains_list[i][0], layer_no, floating_cnt, chains_inputs[i], chains_outputs[i], layer_inputs, next_layer_inputs, reg_flag)
            signal_decl += f_declaration
            instan += f_comments
            instan += f_instance
            xdc += f_xdc
            if chains_list[i][0].name == "(9 : 4,1)" or chains_list[i][0].name == "(1,5 : 3]" or chains_list[i][0].name == "(2,2,3 : 4]" or chains_list[i][0].name == "(3,9 : 2,3,1)":
                floating_placement_list.append((chains_list[i][0], floating_cnt))
                if chains_list[i][0].name == "(3,9 : 2,3,1)":
                    floating_placement_len += 4
                else:
                    floating_placement_len += 2
            floating_cnt += 1
        else:
            c_comments, c_declaration, c_instance, c_xdc = chain_gen(chains_list[i], layer_no, chain_cnt, chains_inputs[i], chains_outputs[i], layer_inputs, next_layer_inputs, reg_flag)
            signal_decl += c_declaration
            instan += c_comments
            instan += c_instance
            xdc += c_xdc
            chain_cnt += 1
    # place floating GPCs using LOOKAHEAD8
    floating_placement_decl, floating_placement_instan = floatingGPC_placement(floating_placement_list, layer_no, floating_placement_len)
    signal_decl += floating_placement_decl
    instan += floating_placement_instan
    # assign the rest of the bits in the current layer to the next layer
    instan += assignment_gen(layer_no, assignments_list, reg_flag)

    return next_layer_inputs, layer_head_comments, signal_decl, instan, xdc

