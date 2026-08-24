from rtl_gen.utils import width_expr
from rtl_gen.lookahead import LOOKAHEAD8_gen


def terminalAdd_gen(terminal_layer_no: int, terminal_inputs: list[int], final_output_width: int, final_output_name: str, terminal_reg_flag: bool) -> tuple[str, str]:
    # The quaternary terminal adder maps each column with the 0/1/2/3/4-bit ladders
    # below; there is no branch for a taller column, so without this guard such a
    # column would emit no C0 assignments at all and its bits would be dropped
    # silently. Fail loudly instead: a column above 4 means the compression heuristic
    # stopped a layer early -- see BitHeap.check_last_layer().
    over = [(col, height) for col, height in enumerate(terminal_inputs) if height > 4]
    if over:
        raise ValueError(
            f"terminalAdd_gen: the quaternary terminal adder takes at most 4 bits per "
            f"column, got (column, height) {over}. The compression heuristic should "
            f"have run another layer -- check BitHeap.check_last_layer()."
        )
    # find out the tail part, the body part and the head part
    num_columns = len(terminal_inputs)
    terminalAdd_start = 0
    tail_end = 0
    head_start = num_columns-1
    terminalAdd_end = num_columns-1
    # find whether there is tail, and if so where it starts
    tail_flag = False
    for col in range(num_columns):
        if terminal_inputs[col] == 2:
            terminalAdd_start = col
            tail_flag = True
            break
        if terminal_inputs[col] == 3:
            terminalAdd_start = col
            if terminal_inputs[col+1] <= 2:
                tail_flag = True
            break
        if terminal_inputs[col] >= 4:
            terminalAdd_start = col
            break
    # if tail exits, find where it ends
    if tail_flag:
        for col in range(terminalAdd_start+1, num_columns):
            if terminal_inputs[col] >= 3:
                tail_end = col-1
                break
    # find whether there is head, and if so where it starts
    head_flag = False
    for col in range(num_columns-1, terminalAdd_start-1, -1):
        if terminal_inputs[col] == 0 and head_flag is False:
            terminalAdd_end = col-1
            head_start = col-1
        if terminal_inputs[col] == 1:
            head_flag = True
            head_start = col
        if terminal_inputs[col] >= 2:
            break
    # find where the first terminal chain ends and how many (3 : 2] counters involved
    chain1_end_col = head_start-1 if head_flag else terminalAdd_end
    two_op_start = chain1_end_col+1
    for col in range(chain1_end_col, terminalAdd_start-1, -1):
        if terminal_inputs[col] > 2:
            break
        else:
            two_op_start = col
    two_op_cols = list(range(two_op_start, chain1_end_col+1))
    ### so now we have the range for the first chain:
    ### starting from the last (1,5 : 3] counter, take two columns down and check if both columns are higher than the chain lower bound
    ### if it can be cascaded with tail part (if the tail part exits), then make the tail part into the chain
    if two_op_cols:
        end_col_15_3 = two_op_start-1
    else:
        if head_flag:
            end_col_15_3 = head_start
        else:
            end_col_15_3 = terminalAdd_end
    tail_cascade_flag = False
    if tail_flag is True and end_col_15_3 % 2 == tail_end % 2:
        tail_cascade_flag = True
    if tail_cascade_flag:
        chain_len = end_col_15_3 - terminalAdd_start + 1 + len(two_op_cols)
    else:
        if tail_flag:
            chain_len = end_col_15_3 - (tail_end + 1) + len(two_op_cols)
        else:
            chain_len = end_col_15_3 - terminalAdd_start + 1 + len(two_op_cols)
    # start to generate RTL for the first terminal chain
    if chain_len % 8 == 0:
        num_LA = chain_len // 8
    else:
        num_LA = chain_len // 8 + 1
    # declaration of the layer (terminal) signal
    signal_decl = f"""
    """
    instan = f""
    left_w = max(len(str(v-1)) for v in terminal_inputs)
    w = max(len(width_expr(v-1, left_w)) for v in terminal_inputs)
    num_col = len(terminal_inputs)
    for i in range(num_col):
        if terminal_inputs[i]:
            signal_decl += f"""logic {width_expr(terminal_inputs[i]-1, left_w):<{w}} layer{terminal_layer_no}_col{i};
    """
    signal_decl += f"""
    logic [{chain_len} : 0] terminal_chain1_out;
    """
    # generation of LOOKAHEAD8 of terminal chain 1
    attri_LA_chain1 = []
    for i in range(num_LA):
        if i == 0:
            attri_LA_chain1.extend([False, True, True, True])
        else:
            attri_LA_chain1.extend([True, True, True, True])
    decl_chain1, instan_chain1 = LOOKAHEAD8_gen(num_LA, f"terminal_chain1", attri_LA_chain1)
    signal_decl += decl_chain1
    instan += instan_chain1
    # generation of LUTs of terminal chain 1:
    ### generation of tail if tail exists
    pos_cnt = 0
    i_cnt = 0
    if tail_cascade_flag:
        for col in range(terminalAdd_start, tail_end+1):
            # first declare signals and instantiate LUTs
            clk_str = f"clk"
            C0_str = f"C0_c3_2_terminal_chain1_i{i_cnt}"
            O_str = f"O_c3_2_terminal_chain1_i{i_cnt}"
            CY_str = f"CY_c3_2_terminal_chain1_i{i_cnt}"
            PROP_str = f"PROP_c3_2_terminal_chain1_i{i_cnt}"
            MSB_str = f"terminal_chain1_i{i_cnt}"
            signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {O_str};
    logic         {CY_str};
    logic         {PROP_str};
    logic         {MSB_str};
    """
            port_list = [clk_str, C0_str, O_str, CY_str, PROP_str, MSB_str]
            max_len = max(len(s) for s in port_list)
            instan += f"""
    c3_2 #(.OUTREG({'"FALSE"'}),
           .LEAVEC({'"TRUE" '}),
           .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
           .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
           .LASTS ({'"FALSE"'}))
    c3_2_terminal_chain1_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
            # connect the inputs of LUTs with layer inputs
            if col == terminalAdd_start:
                if terminal_inputs[col] == 0:
                    instan += f"""
    assign {C0_str}[0] = 1'b0;
    assign {C0_str}[1] = 1'b0;
    assign {C0_str}[2] = 1'b0;
    """
                if terminal_inputs[col] == 1:
                    instan += f"""
    assign {C0_str}[0] = layer{terminal_layer_no}_col{col};
    assign {C0_str}[1] = 1'b0;
    assign {C0_str}[2] = 1'b0;
    """
                if terminal_inputs[col] == 2:
                    instan += f"""
    assign {C0_str}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str}[2] = 1'b0;
    """
                elif terminal_inputs[col] == 3:
                    instan += f"""
    assign {C0_str}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str}[2] = layer{terminal_layer_no}_col{col}[2];
    """
            else:
                instan += f"""
    assign {C0_str}[2] = terminal_chain1_i{i_cnt-1};
    """
                if terminal_inputs[col] == 1:
                    instan += f"""assign {C0_str}[0] = layer{terminal_layer_no}_col{col};
    assign {C0_str}[1] = 1'b0;
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""assign {C0_str}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[1];
    """
            # connect the outputs of LUTs with layer outputs
            out_str0 = f"terminal_chain1_out[{pos_cnt}]"
            instan += f"""
    assign {out_str0} = {O_str}[0];
    """
            # connect LUTs with LOOKAHEAD8
            LUTLA_str0 = f"terminal_chain1_i{i_cnt}"
            LUTLA_str1 = f"CY_LA_terminal_chain1[{pos_cnt}]"
            LUTLA_str2 = f"PROP_LA_terminal_chain1[{pos_cnt}]"
            LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2]
            max_len = max(len(s) for s in LUTLA_str_list)
            if pos_cnt % 2 == 0:
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = {O_str}[1];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
            else:
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_terminal_chain1[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
            # connect carry in and out between LOOKAHEAD8 blocks is needed
            if pos_cnt % 8 == 0:
                if pos_cnt == 0:
                    instan += f"""
    assign CIN_LA_terminal_chain1{"[0]" if num_LA > 1 else "   "} = {C0_str}[2];
    """
                else:
                    instan += f"""
    assign CIN_LA_terminal_chain1[{pos_cnt//8}] = COUT_LA_terminal_chain1[{(pos_cnt//2)-1}];
    """
            # increment GPC instance counter and position counter
            pos_cnt += 1
            i_cnt += 1
    ### generation of body
    ### find where the boday starts and where it ends for chain1
    if tail_cascade_flag:
        body_start = tail_end + 1
    elif tail_flag is True and tail_cascade_flag is False:
        body_start = tail_end + 2
    else:
        body_start = terminalAdd_start
    if two_op_cols:
        body_end = two_op_cols[0] - 1
    else:
        if head_flag:
            body_end = head_start
        else:
            body_end = terminalAdd_end
    if body_start % 2 == body_end % 2:
        body_start += 1
    col = body_start
    while(col < body_end):
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c15_3_terminal_chain1_i{i_cnt}"
        C1_str = f"C1_c15_3_terminal_chain1_i{i_cnt}"
        CLA_str = f"CLA_c15_3_terminal_chain1_i{i_cnt}"
        O_str = f"O_c15_3_terminal_chain1_i{i_cnt}"
        CY_str = f"CY_c15_3_terminal_chain1_i{i_cnt}"
        PROP_str = f"PROP_c15_3_terminal_chain1_i{i_cnt}"
        MSB_str = f"terminal_chain1_i{i_cnt}"
        signal_decl += f"""
    logic [4 : 0] {C0_str};
    logic         {C1_str};
    logic         {CLA_str};
    logic [2 : 0] {O_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    logic         {MSB_str};
    """
        port_list = [clk_str, C0_str, C1_str, CLA_str, O_str, CY_str, PROP_str, MSB_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c15_3 #(.OUTREG({'"FALSE"'}),
            .LEAVEC({'"TRUE" '}),
            .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
            .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
            .LASTS ({'"TRUE" ' if (col+2 >= body_end and not two_op_cols) else '"FALSE"'}))
    c15_3_terminal_chain1_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .C1  ({C1_str.ljust(max_len)}),
        .CLA ({CLA_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
        # connect the inputs of LUTS with layer inputs
        in_str_list = [C0_str, C1_str]
        max_len = max(len(s) for s in in_str_list)
        if pos_cnt == 0:
            if terminal_inputs[col] == 0:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = 1'b0;
    assign {C0_str.ljust(max_len)}[4] = 1'b0;
    """
            elif terminal_inputs[col] == 1:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = 1'b0;
    assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col};
    """
            elif terminal_inputs[col] == 2:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col}[1];
    """
            elif terminal_inputs[col] == 3:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col}[2];
    """
            elif terminal_inputs[col] == 4:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col}[3];
    """
            if col == len(terminal_inputs) - 1:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
            elif terminal_inputs[col+1] == 0:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
            elif terminal_inputs[col+1] == 1:
                instan += f"""assign {C1_str.ljust(max_len)}    = layer{terminal_layer_no}_col{col+1};
    """
            else:
                instan += f"""assign {C1_str.ljust(max_len)}    = layer{terminal_layer_no}_col{col+1}[0];
    """
        else:
            instan += f"""
    assign {C0_str.ljust(max_len)}[4] = terminal_chain1_i{i_cnt-1};
    """
            if terminal_inputs[col] == 0:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = 1'b0;
    """
            elif terminal_inputs[col] == 1:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col};
    """
            elif terminal_inputs[col] == 2:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[1];
    """
            elif terminal_inputs[col] == 3:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[2];
    """
            elif terminal_inputs[col] == 4:
                instan += f"""assign {C0_str.ljust(max_len)}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[3];
    """
            if col == len(terminal_inputs) - 1:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
            elif terminal_inputs[col+1] == 0:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
            elif terminal_inputs[col+1] == 1:
                instan += f"""assign {C1_str.ljust(max_len)}    = layer{terminal_layer_no}_col{col+1};
    """
            else:
                instan += f"""assign {C1_str.ljust(max_len)}    = layer{terminal_layer_no}_col{col+1}[0];
    """
        # connect the outputs of LUTS with layer outputs
        out_str0 = f"terminal_chain1_out[{pos_cnt}]"
        out_str1 = f"terminal_chain1_out[{pos_cnt+1}]"
        out_str2 = f"terminal_chain1_out[{pos_cnt+2}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];"""
        if col == end_col_15_3-1 and not two_op_cols:
            instan += f"""
    assign {out_str2.ljust(max_len)} = {O_str}[2];
    """
        else:
            instan += f"""
    """
        # connect LUTs with LOOKAHEAD8
        LUTLA_str0 = CLA_str
        LUTLA_str1 = f"terminal_chain1_i{i_cnt}"
        LUTLA_str2 = f"CY_LA_terminal_chain1[{pos_cnt+1}:{pos_cnt}]"
        LUTLA_str3 = f"PROP_LA_terminal_chain1[{pos_cnt+1}:{pos_cnt}]"
        LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2, LUTLA_str3]
        max_len = max(len(s) for s in LUTLA_str_list)
        if pos_cnt % 2:
            instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_terminal_chain1[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {O_str}[2];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
        else:
            instan += f"""
    assign {LUTLA_str1.ljust(max_len)} = COUT_LA_terminal_chain1[{pos_cnt//2}];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
        # connect carry in and out between LOOKAHEAD8 blocks is needed
        if pos_cnt % 8 == 7:
            pos_cnt_temp = pos_cnt + 1
        else:
            pos_cnt_temp = pos_cnt
        if pos_cnt_temp % 8 == 0:
            if pos_cnt == 0:
                instan += f"""
    assign CIN_LA_terminal_chain1{"[0]" if num_LA > 1 else "   "} = {C0_str}[4];
    """
            else:
                instan += f"""
    assign CIN_LA_terminal_chain1[{pos_cnt_temp//8}] = COUT_LA_terminal_chain1[{(pos_cnt_temp//2)-1}];
    """
        # increment GPC instance counter and position counter
        pos_cnt += 2
        i_cnt += 1
        # increment column pointer
        col += 2
    ### generation of two-operand part if it exists
    if two_op_cols:
        for col in two_op_cols:
            # first declare signals and instantiate LUTs
            clk_str = f"clk"
            C0_str = f"C0_c3_2_terminal_chain1_i{i_cnt}"
            O_str = f"O_c3_2_terminal_chain1_i{i_cnt}"
            CY_str = f"CY_c3_2_terminal_chain1_i{i_cnt}"
            PROP_str = f"PROP_c3_2_terminal_chain1_i{i_cnt}"
            MSB_str = f"terminal_chain1_i{i_cnt}"
            signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {O_str};
    logic         {CY_str};
    logic         {PROP_str};
    logic         {MSB_str};
    """
            port_list = [clk_str, C0_str, O_str, CY_str, PROP_str, MSB_str]
            max_len = max(len(s) for s in port_list)
            instan += f"""
    c3_2 #(.OUTREG({'"FALSE"'}),
           .LEAVEC({'"TRUE" '}),
           .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
           .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
           .LASTS ({'"TRUE" ' if col == two_op_cols[-1] else '"FALSE"'}))
    c3_2_terminal_chain1_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
            # connect the inputs of LUTs with layer inputs
            if i_cnt == 0:
                # first GPC in chain1 (no prior tail/body) → no previous carry
                instan += f"""
    assign {C0_str}[2] = 1'b0;
    """
            else:
                instan += f"""
    assign {C0_str}[2] = terminal_chain1_i{i_cnt-1};
    """
            if terminal_inputs[col] == 0:
                instan += f"""assign {C0_str}[0] = 1'b0;
    assign {C0_str}[1] = 1'b0;
    """
            elif terminal_inputs[col] == 1:
                instan += f"""assign {C0_str}[0] = layer{terminal_layer_no}_col{col};
    assign {C0_str}[1] = 1'b0;
    """
            elif terminal_inputs[col] == 2:
                instan += f"""assign {C0_str}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[1];
    """
            # connect the outputs of LUTs with layer outputs
            out_str0 = f"terminal_chain1_out[{pos_cnt}]"
            out_str1 = f"terminal_chain1_out[{pos_cnt+1}]"
            out_str_list = [out_str0, out_str1]
            max_len = max(len(s) for s in out_str_list)
            instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    """
            if col == two_op_cols[-1]:
                instan += f"""assign {out_str1.ljust(max_len)} = {O_str}[1];
    """
            # connect LUTs with LOOKAHEAD8
            LUTLA_str0 = f"terminal_chain1_i{i_cnt}"
            LUTLA_str1 = f"CY_LA_terminal_chain1[{pos_cnt}]"
            LUTLA_str2 = f"PROP_LA_terminal_chain1[{pos_cnt}]"
            LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2]
            max_len = max(len(s) for s in LUTLA_str_list)
            if pos_cnt % 2 == 0:
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = {O_str}[1];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
            else:
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_terminal_chain1[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
            # connect carry in and out between LOOKAHEAD8 blocks is needed
            if pos_cnt % 8 == 0:
                if pos_cnt == 0:
                    instan += f"""
    assign CIN_LA_terminal_chain1{"[0]" if num_LA > 1 else "   "} = {C0_str}[2];
    """
                else:
                    instan += f"""
    assign CIN_LA_terminal_chain1[{pos_cnt//8}] = COUT_LA_terminal_chain1[{(pos_cnt//2)-1}];
    """
            # increment GPC instance counter and position counter
            pos_cnt += 1
            i_cnt += 1
    # =================================================================================================================================
    ### so now we have the first chain, then start generation of the second chain:
    ### first, calculate the chain length and generate LOOKAHEAD8 blocks
    ##### check if there is a tail part and check further whether it has been cascaded with chain1
    ##### if there is a tail, and it hasn't been cascaded, start from the beginning of the tail to generate chain2
    ##### if there is a tail, and it has been in chain1, skip generation for tail part and start chain2 from (tail_end + 2)
    ##### if there isn't a tail, start chain2 from terminalAdd_start with (1,5 : 3] counters
    if tail_flag is True and tail_cascade_flag is False:
        chain_len = terminalAdd_end - terminalAdd_start + 1
        chain1_start = tail_end + 2
    elif tail_flag is True and tail_cascade_flag is True:
        chain_len = terminalAdd_end - (tail_end + 2) + 1
        chain1_start = terminalAdd_start
    else:
        if body_start == terminalAdd_start:
            chain_len = terminalAdd_end - (terminalAdd_start+1) + 1
            chain1_start = body_start
        else:
            chain_len = terminalAdd_end - terminalAdd_start + 1
            chain1_start = body_start
    if two_op_cols and col == terminalAdd_end:
        chain_len += 1
    if not two_op_cols and col > terminalAdd_end:
        chain_len += 1
    num_LA = chain_len // 8 if chain_len % 8 == 0 else chain_len // 8 + 1
    signal_decl += f"""
    logic [{chain_len} : 0] terminal_chain2_out;
    """
    # generation of LOOKAHEAD8 of terminal chain2
    attri_LA_chain2 = []
    for i in range(num_LA):
        if i == 0:
            attri_LA_chain2.extend([False, True, True, True])
        else:
            attri_LA_chain2.extend([True, True, True, True])
    decl_chain2, instan_chain2 = LOOKAHEAD8_gen(num_LA, f"terminal_chain2", attri_LA_chain2)
    signal_decl += decl_chain2
    instan += instan_chain2
    # generation of GPC LUTs of terminal chain2
    pos_cnt = 0
    i_cnt = 0
    if tail_flag is True and tail_cascade_flag is False:
        for col in range(terminalAdd_start, tail_end+1):
            # first declare signals and instantiate LUTs
            clk_str = f"clk"
            C0_str = f"C0_c3_2_terminal_chain2_i{i_cnt}"
            O_str = f"O_c3_2_terminal_chain2_i{i_cnt}"
            CY_str = f"CY_c3_2_terminal_chain2_i{i_cnt}"
            PROP_str = f"PROP_c3_2_terminal_chain2_i{i_cnt}"
            MSB_str = f"terminal_chain2_i{i_cnt}"
            signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {O_str};
    logic         {CY_str};
    logic         {PROP_str};
    logic         {MSB_str};
    """
            port_list = [clk_str, C0_str, O_str, CY_str, PROP_str, MSB_str]
            max_len = max(len(s) for s in port_list)
            instan += f"""
    c3_2 #(.OUTREG({'"FALSE"'}),
           .LEAVEC({'"TRUE" '}),
           .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
           .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
           .LASTS ({'"FALSE"'}))
    c3_2_terminal_chain2_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
            # connect the inputs of LUTs with layer inputs
            if col == terminalAdd_start:
                if terminal_inputs[col] == 0:
                    instan += f"""
    assign {C0_str}[0] = 1'b0;
    assign {C0_str}[1] = 1'b0;
    assign {C0_str}[2] = 1'b0;
    """
                elif terminal_inputs[col] == 1:
                    instan += f"""
    assign {C0_str}[0] = 1'b0;
    assign {C0_str}[1] = 1'b0;
    assign {C0_str}[2] = layer{terminal_layer_no}_col{col};
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""
    assign {C0_str}[0] = 1'b0;
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[2] = layer{terminal_layer_no}_col{col}[1];
    """
                elif terminal_inputs[col] == 3:
                    instan += f"""
    assign {C0_str}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str}[2] = layer{terminal_layer_no}_col{col}[2];
    """
            else:
                instan += f"""
    assign {C0_str}[2] = terminal_chain2_i{i_cnt-1};
    """
                if terminal_inputs[col] == 1:
                    instan += f"""assign {C0_str}[0] = layer{terminal_layer_no}_col{col};
    assign {C0_str}[1] = 1'b0;
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""assign {C0_str}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str}[1] = layer{terminal_layer_no}_col{col}[1];
    """
            # connect the outputs of LUTs with layer outputs
            out_str0 = f"terminal_chain2_out[{pos_cnt}]"
            instan += f"""
    assign {out_str0} = {O_str}[0];"""
            # connect LUTs with LOOKAHEAD8
            LUTLA_str0 = f"terminal_chain2_i{i_cnt}"
            LUTLA_str1 = f"CY_LA_terminal_chain2[{pos_cnt}]"
            LUTLA_str2 = f"PROP_LA_terminal_chain2[{pos_cnt}]"
            LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2]
            max_len = max(len(s) for s in LUTLA_str_list)
            if pos_cnt % 2 == 0:
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = {O_str}[1];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
            else:
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_terminal_chain2[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
            # connect carry in and out between LOOKAHEAD8 blocks is needed
            if pos_cnt % 8 == 0:
                if pos_cnt == 0:
                    instan += f"""
    assign CIN_LA_terminal_chain2{"[0]" if num_LA > 1 else "   "} = {C0_str}[2];
    """
                else:
                    instan += f"""
    assign CIN_LA_terminal_chain2[{pos_cnt//8}] = COUT_LA_terminal_chain2[{(pos_cnt//2)-1}];
    """
            # increment GPC instance counter and position counter
            pos_cnt += 1
            i_cnt += 1
    ### generation of body
    ### find where the body starts and where it ends for chain2
    body_start_old = body_start
    if tail_flag is True and tail_cascade_flag is False:
        body_start = tail_end + 1
        chain1to2_start = tail_end + 2
    elif tail_flag is True and tail_cascade_flag is True:
        body_start = tail_end + 2
        chain1to2_start = body_start
    else:
        if body_start_old == terminalAdd_start:
            body_start = terminalAdd_start + 1
            chain1to2_start = body_start
        else:
            body_start = terminalAdd_start
            chain1to2_start = body_start + 1
    if two_op_cols:
        body_end = two_op_cols[0]
        chain1to2_end = two_op_cols[-1] + 1
    else:
        if head_flag:
            body_end = head_start
            chain1to2_end = head_start + 1    # changed to debug single128
        else:
            body_end = terminalAdd_end + 1
            chain1to2_end = end_col_15_3 + 1
    col = body_start
    while(col < body_end):
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c15_3_terminal_chain2_i{i_cnt}"
        C1_str = f"C1_c15_3_terminal_chain2_i{i_cnt}"
        CLA_str = f"CLA_c15_3_terminal_chain2_i{i_cnt}"
        O_str = f"O_c15_3_terminal_chain2_i{i_cnt}"
        CY_str = f"CY_c15_3_terminal_chain2_i{i_cnt}"
        PROP_str = f"PROP_c15_3_terminal_chain2_i{i_cnt}"
        MSB_str = f"terminal_chain2_i{i_cnt}"
        signal_decl += f"""
    logic [4 : 0] {C0_str};
    logic         {C1_str};
    logic         {CLA_str};
    logic [2 : 0] {O_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    logic         {MSB_str};
    """
        port_list = [clk_str, C0_str, C1_str, CLA_str, O_str, CY_str, PROP_str, MSB_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c15_3 #(.OUTREG({'"FALSE"'}),
            .LEAVEC({'"TRUE" '}),
            .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
            .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
            .LASTS ({'"TRUE" ' if (col+2 >= body_end and (not two_op_cols) and (not head_flag)) else '"FALSE"'}))
    c15_3_terminal_chain2_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .C1  ({C1_str.ljust(max_len)}),
        .CLA ({CLA_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
        # connect the inputs of LUTS with layer inputs
        in_str_list = [C0_str, C1_str]
        max_len = max(len(s) for s in in_str_list)
        if pos_cnt == 0:
            if chain1to2_start <= col <= chain1to2_end:
                instan += f"""
    assign {C0_str.ljust(max_len)}[4] = 1'b0;
    """
                instan += f"""assign {C0_str.ljust(max_len)}[3] = terminal_chain1_out[{col-chain1_start}];
    """
                if terminal_inputs[col] == 0 or terminal_inputs[col] == 1:
                    instan += f"""assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 3:
                    instan += f"""assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 4:
                    instan += f"""assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[3];
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[0] = layer{terminal_layer_no}_col{col}[1];
    """
            else:
                if terminal_inputs[col] == 0:
                    instan += f"""assign {C0_str.ljust(max_len)}[4] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 1:
                    instan += f"""assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col};
    assign {C0_str.ljust(max_len)}[3] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 3:
                    instan += f"""assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
                elif terminal_inputs[col] == 4:
                    instan += f"""assign {C0_str.ljust(max_len)}[4] = layer{terminal_layer_no}_col{col}[3];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[0] = 1'b0;
    """
            if chain1to2_start <= col+1 <= chain1to2_end:
                instan += f"""assign {C1_str.ljust(max_len)}    = terminal_chain1_out[{col+1-chain1_start}];
    """
            elif col == len(terminal_inputs) - 1:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
            elif terminal_inputs[col+1] == 0:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
            elif terminal_inputs[col+1] == 1:
                instan += f"""assign {C1_str.ljust(max_len)}    = layer{terminal_layer_no}_col{col+1};
    """
            else:
                instan += f"""assign {C1_str.ljust(max_len)}    = layer{terminal_layer_no}_col{col+1}[0];
    """
        else:
            instan += f"""
    assign {C0_str.ljust(max_len)}[4] = terminal_chain2_i{i_cnt-1};
    """
            if chain1to2_start <= col <= chain1to2_end:
                instan += f"""assign {C0_str.ljust(max_len)}[3] = terminal_chain1_out[{col-chain1_start}];
    """
                if terminal_inputs[col] == 1 or terminal_inputs[col] == 0:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[1];
    """
                elif terminal_inputs[col] == 3:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[2];
    """
                elif terminal_inputs[col] == 4:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[3];
    """
            else:
                if terminal_inputs[col] == 0:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = 1'b0;
    """
                elif terminal_inputs[col] == 1:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = 1'b0;
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[0];
    """
                elif terminal_inputs[col] == 2:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = 1'b0;
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[1];
    """
                elif terminal_inputs[col] == 3:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = 1'b0;
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[2];
    """
                elif terminal_inputs[col] == 4:
                    instan += f"""assign {C0_str.ljust(max_len)}[0] = layer{terminal_layer_no}_col{col}[0];
    assign {C0_str.ljust(max_len)}[1] = layer{terminal_layer_no}_col{col}[1];
    assign {C0_str.ljust(max_len)}[2] = layer{terminal_layer_no}_col{col}[2];
    assign {C0_str.ljust(max_len)}[3] = layer{terminal_layer_no}_col{col}[3];
    """
            if chain1to2_start <= col+1 <= chain1to2_end:
                instan += f"""assign {C1_str.ljust(max_len)}    = terminal_chain1_out[{col+1-chain1_start}];
    """
            else:
                instan += f"""assign {C1_str.ljust(max_len)}    = 1'b0;
    """
        # connect the outputs of LUTS with layer outputs
        out_str0 = f"terminal_chain2_out[{pos_cnt}]"
        out_str1 = f"terminal_chain2_out[{pos_cnt+1}]"
        out_str2 = f"terminal_chain2_out[{pos_cnt+2}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];"""
        if col+2 > chain1to2_end and col+2 >= terminalAdd_end+2:
            instan += f"""
    assign {out_str2.ljust(max_len)} = {O_str}[2];
    """
        else:
            instan += f"""
    """
        # connect LUTs with LOOKAHEAD8
        LUTLA_str0 = CLA_str
        LUTLA_str1 = f"terminal_chain2_i{i_cnt}"
        LUTLA_str2 = f"CY_LA_terminal_chain2[{pos_cnt+1}:{pos_cnt}]"
        LUTLA_str3 = f"PROP_LA_terminal_chain2[{pos_cnt+1}:{pos_cnt}]"
        LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2, LUTLA_str3]
        max_len = max(len(s) for s in LUTLA_str_list)
        if pos_cnt % 2:
            instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_terminal_chain2[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {O_str}[2];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
        else:
            instan += f"""
    assign {LUTLA_str1.ljust(max_len)} = COUT_LA_terminal_chain2[{pos_cnt//2}];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
        # connect carry in and out between LOOKAHEAD8 blocks is needed
        if pos_cnt % 8 == 7:
            pos_cnt_temp = pos_cnt + 1
        else:
            pos_cnt_temp = pos_cnt
        if pos_cnt_temp % 8 == 0:
            if pos_cnt == 0:
                instan += f"""
    assign CIN_LA_terminal_chain2{"[0]" if num_LA > 1 else  "   "} = {C0_str}[4];
    """
            else:
                instan += f"""
    assign CIN_LA_terminal_chain2[{pos_cnt_temp//8}] = COUT_LA_terminal_chain2[{(pos_cnt_temp//2)-1}];
    """
        # increment GPC instance counter and position counter
        pos_cnt += 2
        i_cnt += 1
        # increment column pointer
        col += 2
    ### generation of the rest of terminal chain2
    rest_start = col
    rest_end = rest_start+chain_len-pos_cnt-1
    for col in range(rest_start, rest_end+1):
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c3_2_terminal_chain2_i{i_cnt}"
        O_str = f"O_c3_2_terminal_chain2_i{i_cnt}"
        CY_str = f"CY_c3_2_terminal_chain2_i{i_cnt}"
        PROP_str = f"PROP_c3_2_terminal_chain2_i{i_cnt}"
        MSB_str = f"terminal_chain2_i{i_cnt}"
        signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {O_str};
    logic         {CY_str};
    logic         {PROP_str};
    logic         {MSB_str};
    """
        port_list = [clk_str, C0_str, O_str, CY_str, PROP_str, MSB_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c3_2 #(.OUTREG({'"FALSE"'}),
           .LEAVEC({'"TRUE" '}),
           .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
           .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
           .LASTS ({'"TRUE" ' if col == rest_end else '"FALSE"'}))
    c3_2_terminal_chain2_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
        # connect the inputs of LUTs with layer inputs
        if i_cnt == 0:
            # first GPC in chain2 (no prior tail/body) → no previous carry
            instan += f"""
    assign {C0_str}[2] = 1'b0;
    """
        else:
            instan += f"""
    assign {C0_str}[2] = terminal_chain2_i{i_cnt-1};
    """
        if col in two_op_cols:
            instan += f"""assign {C0_str}[0] = terminal_chain1_out[{col-chain1_start}];
    assign {C0_str}[1] = 1'b0;
    """
        elif col <= chain1to2_end:
            instan += f"""assign {C0_str}[0] = terminal_chain1_out[{col-chain1_start}];
    """
            if col <= terminalAdd_end and col == chain1to2_end:
                instan += f"""assign {C0_str}[1] = layer{terminal_layer_no}_col{col};
    """
            else:
                instan += f"""assign {C0_str}[1] = 1'b0;
    """
        else:
            instan += f"""assign {C0_str}[0] = 1'b0;
    """
            if col <= terminalAdd_end:
                instan += f"""assign {C0_str}[1] = layer{terminal_layer_no}_col{col};
    """
            else:
                instan += f"""assign {C0_str}[1] = 1'b0;
    """
        # connect the outputs of LUTs with layer outputs
        out_str0 = f"terminal_chain2_out[{pos_cnt}]"
        out_str1 = f"terminal_chain2_out[{pos_cnt+1}]"
        out_str_list = [out_str0, out_str1]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    """
        if col == rest_end:
            instan += f"""assign {out_str1.ljust(max_len)} = {O_str}[1];
    """
        # connect LUTs with LOOKAHEAD8
        LUTLA_str0 = f"terminal_chain2_i{i_cnt}"
        LUTLA_str1 = f"CY_LA_terminal_chain2[{pos_cnt}]"
        LUTLA_str2 = f"PROP_LA_terminal_chain2[{pos_cnt}]"
        LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2]
        max_len = max(len(s) for s in LUTLA_str_list)
        if pos_cnt % 2 == 0:
            instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = {O_str}[1];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
        else:
            instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_terminal_chain2[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
        # connect carry in and out between LOOKAHEAD8 blocks is needed
        if pos_cnt % 8 == 0:
            if pos_cnt == 0:
                instan += f"""
    assign CIN_LA_terminal_chain2{"[0]" if num_LA > 1 else "   "} = {C0_str}[2];
    """
            else:
                instan += f"""
    assign CIN_LA_terminal_chain2[{pos_cnt//8}] = COUT_LA_terminal_chain2[{(pos_cnt//2)-1}];
    """
        # increment GPC instance counter and position counter
        pos_cnt += 1
        i_cnt += 1
    ### Finally, connect the outputs of two terminal chains with the compressor tree output
    if not terminal_reg_flag:
        if terminalAdd_start != 0:
            for col in range(terminalAdd_start):
                if terminal_inputs[col] == 0:
                    instan += f"""
    assign {final_output_name}[{col}] = 1'b0;"""
                else:
                    instan += f"""
    assign {final_output_name}[{col}] = layer{terminal_layer_no}_col{col};"""
            instan += f"""
    """
        if tail_flag:
            if tail_cascade_flag:
                instan += f"""
    assign {final_output_name}[{tail_end+1}:{terminalAdd_start}] = terminal_chain1_out[{tail_end-terminalAdd_start+1}:0];
    """
                instan += f"""
    assign {final_output_name}[{final_output_width-1}:{tail_end+2}] = terminal_chain2_out[{final_output_width-tail_end-3}:0];
    """
            else:
                instan += f"""
    assign {final_output_name}[{tail_end}:{terminalAdd_start}] = terminal_chain2_out[{tail_end-terminalAdd_start}:0];
    """
                instan += f"""
    assign {final_output_name}[{final_output_width-1}:{tail_end+1}] = terminal_chain2_out[{final_output_width-terminalAdd_start-1}:{tail_end-terminalAdd_start+1}];
    """
        else:
            if chain1_start == terminalAdd_start:
                instan += f"""
    assign {final_output_name}[{terminalAdd_start}] = terminal_chain1_out[0];
    """
                instan += f"""
    assign {final_output_name}[{final_output_width-1}:{terminalAdd_start+1}] = terminal_chain2_out[{final_output_width-terminalAdd_start-2}:0];
    """
            else:
                instan += f"""
    assign {final_output_name}[{final_output_width-1}:{terminalAdd_start}] = terminal_chain2_out[{final_output_width-terminalAdd_start-1}:0];
    """
    else:
        instan += f"""
    always_ff @(posedge clk) begin"""
        if terminalAdd_start != 0:
            for col in range(terminalAdd_start):
                if terminal_inputs[col] == 0:
                    instan += f"""
        {final_output_name}[{col}] <= 1'b0;"""
                else:
                    instan += f"""
        {final_output_name}[{col}] <= layer{terminal_layer_no}_col{col};"""
            instan += f"""
    """
        if tail_flag:
            if tail_cascade_flag:
                instan += f"""
        {final_output_name}[{tail_end+1}:{terminalAdd_start}] <= terminal_chain1_out[{tail_end-terminalAdd_start+1}:0];
    """
                instan += f"""
        {final_output_name}[{final_output_width-1}:{tail_end+2}] <= terminal_chain2_out[{final_output_width-tail_end-3}:0];
    """
            else:
                instan += f"""
        {final_output_name}[{tail_end}:{terminalAdd_start}] <= terminal_chain2_out[{tail_end-terminalAdd_start}:0];
    """
                instan += f"""
        {final_output_name}[{final_output_width-1}:{tail_end+1}] <= terminal_chain2_out[{final_output_width-terminalAdd_start-1}:{tail_end-terminalAdd_start+1}];
    """
        else:
            if chain1_start == terminalAdd_start:
                instan += f"""
        {final_output_name}[{terminalAdd_start}] <= terminal_chain1_out[0];
    """
                instan += f"""
        {final_output_name}[{final_output_width-1}:{terminalAdd_start+1}] <= terminal_chain2_out[{final_output_width-terminalAdd_start-2}:0];
    """
            else:
                instan += f"""
        {final_output_name}[{final_output_width-1}:{terminalAdd_start}] <= terminal_chain2_out[{final_output_width-terminalAdd_start-1}:0];
    """
        instan += f"""end
    """
    return signal_decl, instan

