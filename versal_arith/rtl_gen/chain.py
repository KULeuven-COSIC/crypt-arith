from counter import Counter
from rtl_gen.utils import width_expr
from rtl_gen.lookahead import LOOKAHEAD8_gen, analyze_subchain


def chain_gen(counter_list: list[Counter], layer_no: int, chain_no: int, chain_inputs: list, chain_outputs: list, layer_inputs: list[int], layer_outputs: list[int], reg_flag: bool = False) -> tuple[str, str, str, str]:
    # ------ generation of comments ------
    headComment_str = f"""
    // GPC chain{chain_no} in layer{layer_no}:"""

    for counter in counter_list:
        comment_str = f"""
    // -- {counter.name} at column {counter.applied_column}"""
        headComment_str += comment_str
    headComment_str += f"""
    """

    # ------ analyze the chain into subchains ------
    subchain_list, subchain_num_LA, subchain_LA_attr = analyze_subchain(counter_list)

    # ------ generation regarding LOOKAHEAD8 blocks ------
    signal_decl = """"""
    instan = """"""
    xdc = """"""
    num_LA = len(subchain_num_LA)
    for i in range(num_LA):
        LA_signal_decl, LA_instan = LOOKAHEAD8_gen(subchain_num_LA[i], f"l{layer_no}_c{chain_no}_s{i}", subchain_LA_attr[i])
        signal_decl += LA_signal_decl
        instan += LA_instan

    # ------ generation of GPC LUTs and connection with LOOKAHEAD8------
    start_col = subchain_list[0][0].applied_column
    i_cnt = 0
    pos_cnt = 0
    # chain_outputs is one flat list for the whole chain and chain_gen locates a
    # counter's entry by `applied_column - start_col`, which assumes every GPC
    # contributes as many output entries as columns it advances. (9 : 4,1) breaks
    # that: 2 entries (col, col+1) for 1 column of advance. Set to 1 when this chain
    # is headed by a (9 : 4,1) that has a successor, shifting every later lookup.
    out_shift = 0
    num_subchain = len(subchain_list)
    for j in range(num_subchain):
        subchain = subchain_list[j]
        len_subchain = len(subchain)
        for i in range(len_subchain):
            if subchain[i] == "CHAIN_END":
                i_cnt = 0
                pos_cnt = 0
                out_shift = 0
                break
            if subchain[i] == "SUBCHAIN_END":
                pos_cnt = 2
            elif subchain[i].name == "(9 : 4,1)":
                # first declare signals and instantiate LUTs
                clk_str = f"clk"
                C0_str = f"C0_c9_41_l{layer_no}_c{chain_no}_i{i_cnt}"
                CLA_str = f"CLA_c9_41_l{layer_no}_c{chain_no}_i{i_cnt}"
                O0_str = f"O0_c9_41_l{layer_no}_c{chain_no}_i{i_cnt}"
                O1_str = f"O1_c9_41_l{layer_no}_c{chain_no}_i{i_cnt}"
                CY_str = f"CY_c9_41_l{layer_no}_c{chain_no}_i{i_cnt}"
                PROP_str = f"PROP_c9_41_l{layer_no}_c{chain_no}_i{i_cnt}"
                MSB_str = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                signal_decl += f"""
    logic [8 : 0] {C0_str};
    logic         {CLA_str};
    logic         {O0_str};
    logic [3 : 0] {O1_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    logic         {MSB_str};
    """
                port_list = [clk_str, C0_str, CLA_str, O0_str, O1_str, CY_str, PROP_str, MSB_str]
                max_len = max(len(s) for s in port_list)
                instan += f"""
    c9_41 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
            .LEAVEC({'"FALSE"' if subchain[i+1] == "CHAIN_END" else '"TRUE" '}),
            .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}))
    c9_41_l{layer_no}_c{chain_no}_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .CLA ({CLA_str.ljust(max_len)}),
        .O0  ({O0_str.ljust(max_len)}),
        .O1  ({O1_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
                # generate xdc lines to merge two LUT3s into one physical LUT
                xdc += f"""
### constraints for c9_41_l{layer_no}_c{chain_no}_i{i_cnt} ###
set lut_hi_l{layer_no}_c{chain_no}_i{i_cnt} [get_cells -hier -filter {{NAME =~ "*/c9_41_l{layer_no}_c{chain_no}_i{i_cnt}/LUT3_inst0"}}]
set lut_lo_l{layer_no}_c{chain_no}_i{i_cnt} [get_cells -hier -filter {{NAME =~ "*/c9_41_l{layer_no}_c{chain_no}_i{i_cnt}/LUT3_inst1"}}]
set_property LUTNM grp_l{layer_no}_c{chain_no}_i{i_cnt} $lut_hi_l{layer_no}_c{chain_no}_i{i_cnt}
set_property LUTNM grp_l{layer_no}_c{chain_no}_i{i_cnt} $lut_lo_l{layer_no}_c{chain_no}_i{i_cnt}

"""
                # connect the inputs of LUTs with layer inputs
                col = subchain[i].applied_column - start_col
                if subchain[i].in_cascade is False:
                    instan += f"""
    assign {C0_str} = layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}];
    """
                else:
                    instan += f"""
    assign {C0_str} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}]}};
    """
                # connect the outputs of LUTs with layer outputs
                if layer_outputs[subchain[i].applied_column] == 1:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}"
                else:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}[{chain_outputs[col + out_shift][0]}]"
                out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}[{max(chain_outputs[col+1 + out_shift])}:{min(chain_outputs[col+1 + out_shift])}]"
                out_str_list = [out_str0, out_str1]
                max_len = max(len(s) for s in out_str_list)
                instan += f"""
    assign {out_str0.ljust(max_len)} = {O0_str};"""
                if subchain[i+1] == "CHAIN_END":
                    instan += f"""
    assign {out_str1.ljust(max_len)} = {O1_str};
    """
                else:
                    instan += f"""
    assign {out_str1.ljust(max_len)} = {O1_str}[2:0];
    """
                # connect LUTs with LOOKAHEAD8
                LUTLA_str0 = CLA_str
                LUTLA_str1 = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                LUTLA_str2 = f"CY_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str3 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2, LUTLA_str3]
                max_len = max(len(s) for s in LUTLA_str_list)
                if pos_cnt % 2:
                    instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {O1_str}[3];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
                else:
                    instan += f"""
    assign {LUTLA_str1.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt//2}];
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
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}{"[0]" if subchain_num_LA[j] > 1 else "   "} = {C0_str}[8];
    """
                    else:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt_temp//8}] = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt_temp//2)-1}];
    """
                # increment GPC instance counter and position counter
                pos_cnt += 2
                i_cnt += 1
                # 2 output entries for 1 column of advance -- shift every later
                # lookup in this chain. Same predicate as LEAVEC / O1 vs O1[2:0].
                if subchain[i+1] != "CHAIN_END":
                    out_shift += 1
            elif subchain[i].name == "(6 : 3]":
                # this counter can only start a chain and never ends a chain
                # so it is always the first lut in a counter chain
                # first declare signals and instantiate LUTs
                clk_str = f"clk"
                C0_str = f"C0_c6_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                O_str = f"O_c6_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                MSB_str = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                signal_decl += f"""
    logic [5 : 0] {C0_str};
    logic [2 : 0] {O_str};
    logic         {MSB_str};
    """
                port_list = [clk_str, C0_str, MSB_str]
                max_len = max(len(s) for s in port_list)
                instan += f"""
    c6_3 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
           .LEAVEC('"TRUE" '))
    c6_3_l{layer_no}_c{chain_no}_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}));
    """
                # connect the inputs of LUTs with layer inputs
                col = subchain[i].applied_column - start_col
                instan += f"""
    assign {C0_str} = layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}];
    """
                # connect the outputs of LUTs with layer outputs
                if layer_outputs[subchain[i].applied_column] == 1:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}"
                else:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}[{chain_outputs[col + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+1] == 1:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}"
                else:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}[{chain_outputs[col+1 + out_shift][0]}]"
                out_str_list = [out_str0, out_str1]
                max_len = max(len(s) for s in out_str_list)
                instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];"""
                # connect LUTs with LOOKAHEAD8
                LUTLA_str0 = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                LUTLA_str1 = f"CY_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt}]"
                LUTLA_str2 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt}]"
                LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2]
                max_len = max(len(s) for s in LUTLA_str_list)
                instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = {O_str}[2];
    assign {LUTLA_str1.ljust(max_len)} = {O_str}[2];
    assign {LUTLA_str2.ljust(max_len)} = 1'b0;
    """
                # connect carry in and out between LOOKAHEAD8 blocks is needed
                instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}{"[0]" if subchain_num_LA[j] > 1 else "   "} = {C0_str}[4];
    """
                # increment GPC instance counter and position counter
                pos_cnt += 1
                i_cnt += 1
            elif subchain[i].name == "(2,2,3 : 4]":
                # first declare signals and instantiate LUTs
                clk_str = f"clk"
                C0_str = f"C0_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                C1_str = f"C1_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                C2_str = f"C2_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                CLA_str = f"CLA_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                O_str = f"O_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                CY_str = f"CY_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                PROP_str = f"PROP_c223_4_l{layer_no}_c{chain_no}_i{i_cnt}"
                MSB_str = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {C1_str};
    logic [1 : 0] {C2_str};
    logic         {CLA_str};
    logic [3 : 0] {O_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    logic         {MSB_str};
    """
                port_list = [clk_str, C0_str, C1_str, C2_str, CLA_str, O_str, CY_str, PROP_str, MSB_str]
                max_len = max(len(s) for s in port_list)
                instan += f"""
    c223_4 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
             .LEAVEC({'"FALSE"' if subchain[i+1] == "CHAIN_END" else '"TRUE" '}),
             .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}))
    c223_4_l{layer_no}_c{chain_no}_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .C1  ({C1_str.ljust(max_len)}),
        .C2  ({C2_str.ljust(max_len)}),
        .CLA ({CLA_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
                # connect the inputs of LUTS with layer inputs
                in_str_list = [C0_str, C1_str, C2_str]
                max_len = max(len(s) for s in in_str_list)
                col = subchain[i].applied_column - start_col
                if subchain[i].in_cascade is False:
                    instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}];
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1}[{chain_inputs[col+1][1]}:{chain_inputs[col+1][0]}];
    assign {C2_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+2}[{chain_inputs[col+2][1]}:{chain_inputs[col+2][0]}];
    """
                else:
                    instan += f"""
    assign {C0_str.ljust(max_len)} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}]}};
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1}[{chain_inputs[col+1][1]}:{chain_inputs[col+1][0]}];
    assign {C2_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+2}[{chain_inputs[col+2][1]}:{chain_inputs[col+2][0]}];
    """
                # connect the outputs of LUTS with layer outputs
                if layer_outputs[subchain[i].applied_column] == 1:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}"
                else:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}[{chain_outputs[col + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+1] == 1:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}"
                else:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}[{chain_outputs[col+1 + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+2] == 1:
                    out_str2 = f"layer{layer_no+1}_col{subchain[i].applied_column+2}"
                else:
                    out_str2 = f"layer{layer_no+1}_col{subchain[i].applied_column+2}[{chain_outputs[col+2 + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+3] == 1:
                    out_str3 = f"layer{layer_no+1}_col{subchain[i].applied_column+3}"
                else:
                    out_str3 = f"layer{layer_no+1}_col{subchain[i].applied_column+3}[{chain_outputs[col+3 + out_shift][0]}]"
                out_str_list = [out_str0, out_str1, out_str2, out_str3]
                max_len = max(len(s) for s in out_str_list)
                instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];
    assign {out_str2.ljust(max_len)} = {O_str}[2];"""
                if subchain[i+1] == "CHAIN_END":
                    instan += f"""
    assign {out_str3.ljust(max_len)} = {O_str}[3];
    """
                else:
                    instan += f"""
    """
                # connect LUTs with LOOKAHEAD8
                LUTLA_str0 = CLA_str
                LUTLA_str1 = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                LUTLA_str2 = f"CY_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str3 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2, LUTLA_str3]
                max_len = max(len(s) for s in LUTLA_str_list)
                if pos_cnt % 2:
                    instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {O_str}[3];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
                else:
                    instan += f"""
    assign {LUTLA_str1.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt//2}];
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
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}{"[0]" if subchain_num_LA[j] > 1 else "   "} = {C0_str}[2];
    """
                    else:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt_temp//8}] = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt_temp//2)-1}];
    """
                # increment GPC instance counter and position counter
                pos_cnt += 2
                i_cnt += 1
            elif subchain[i].name == "(3 : 2]":
                # first declare signals and instantiate LUTs
                clk_str = f"clk"
                C0_str = f"C0_c3_2_l{layer_no}_c{chain_no}_i{i_cnt}"
                O_str = f"O_c3_2_l{layer_no}_c{chain_no}_i{i_cnt}"
                CY_str = f"CY_c3_2_l{layer_no}_c{chain_no}_i{i_cnt}"
                PROP_str = f"PROP_c3_2_l{layer_no}_c{chain_no}_i{i_cnt}"
                MSB_str = f"l{layer_no}_c{chain_no}_i{i_cnt}"
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
    c3_2 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
           .LEAVEC({'"FALSE"' if subchain[i+1] == "CHAIN_END" else '"TRUE" '}),
           .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
           .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
           .LASTS ({'"TRUE" ' if i == len_subchain-2 else '"FALSE"'}))
    c3_2_l{layer_no}_c{chain_no}_i{i_cnt}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
                # connect the inputs of LUTs with layer inputs
                col = subchain[i].applied_column - start_col
                if subchain[i].in_cascade is False:
                    if len(chain_inputs[col]) == 2:
                        instan += f"""
    assign {C0_str} = {{layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}], 1'b0}};
    """
                    elif len(chain_inputs[col]) == 1:
                        instan += f"""
    assign {C0_str} = {{layer{layer_no}_col{subchain[i].applied_column}[{chain_inputs[col][0]}], 2'b0}};
    """
                    else:
                        instan += f"""
    assign {C0_str} = layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}];
    """
                else:
                    if len(chain_inputs[col]) == 1:
                        instan += f"""
    assign {C0_str} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{chain_inputs[col][0]}], 1'b0}};
    """
                    else:
                        instan += f"""
    assign {C0_str} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}]}};
    """
                # connect the outputs of LUTs with layer outputs
                if layer_outputs[subchain[i].applied_column] == 1:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}"
                else:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}[{chain_outputs[col + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+1] == 1:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}"
                else:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}[{chain_outputs[col+1 + out_shift][0]}]"
                out_str_list = [out_str0, out_str1]
                max_len = max(len(s) for s in out_str_list)
                instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];"""
                if subchain[i+1] == "CHAIN_END":
                    instan += f"""
    assign {out_str1.ljust(max_len)} = {O_str}[1];
    """
                else:
                    instan += f"""
    """
                # connect LUTs with LOOKAHEAD8
                LUTLA_str0 = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                LUTLA_str1 = f"CY_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt}]"
                LUTLA_str2 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt}]"
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
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {CY_str};
    assign {LUTLA_str2.ljust(max_len)} = {PROP_str};
    """
                # connect carry in and out between LOOKAHEAD8 blocks is needed
                if pos_cnt % 8 == 0:
                    if pos_cnt == 0:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}{"[0]" if subchain_num_LA[j] > 1 else "   "} = {C0_str}[2];
    """
                    else:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt//8}] = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt//2)-1}];
    """
                # increment GPC instance counter and position counter
                pos_cnt += 1
                i_cnt += 1
            elif subchain[i].name == "(1,5 : 3]":
                # first declare signals and instantiate LUTs
                clk_str = f"clk"
                C0_str = f"C0_c15_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                C1_str = f"C1_c15_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                CLA_str = f"CLA_c15_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                O_str = f"O_c15_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                CY_str = f"CY_c15_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                PROP_str = f"PROP_c15_3_l{layer_no}_c{chain_no}_i{i_cnt}"
                MSB_str = f"l{layer_no}_c{chain_no}_i{i_cnt}"
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
    c15_3 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
            .LEAVEC({'"FALSE"' if subchain[i+1] == "CHAIN_END" else '"TRUE" '}),
            .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}),
            .FIRSTS({'"TRUE" ' if pos_cnt < 2 else '"FALSE"'}),
            .LASTS ({'"TRUE" ' if i == len_subchain-2 else '"FALSE"'}))
    c15_3_l{layer_no}_c{chain_no}_i{i_cnt}(
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
                col = subchain[i].applied_column - start_col
                if subchain[i].in_cascade is False:
                    if len(chain_inputs[col]) == 4:
                        instan += f"""
    assign {C0_str.ljust(max_len)} = {{layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}], 1'b0}};"""
                    else:
                        instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}];"""
                else:
                    if len(chain_inputs[col]) == 3:
                        instan += f"""
    assign {C0_str.ljust(max_len)} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}], 1'b0}};"""
                    elif len(chain_inputs[col]) == 2:
                        instan += f"""
    assign {C0_str.ljust(max_len)} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}], 2'b0}};"""
                    else:
                        instan += f"""
    assign {C0_str.ljust(max_len)} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}]}};"""
                if len(chain_inputs[col+1]) == 1:
                    if layer_inputs[subchain[i].applied_column+1] == 1:
                        instan += f"""
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1};
    """
                    else:
                        instan += f"""
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1}[{chain_inputs[col+1][0]}];
    """
                else:
                    instan += f"""
    assign {C1_str.ljust(max_len)} = 1'b0;
    """
                # connect the outputs of LUTS with layer outputs
                if layer_outputs[subchain[i].applied_column] == 1:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}"
                else:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}[{chain_outputs[col + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+1] == 1:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}"
                else:
                    out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}[{chain_outputs[col+1 + out_shift][0]}]"
                if layer_outputs[subchain[i].applied_column+2] == 1:
                    out_str2 = f"layer{layer_no+1}_col{subchain[i].applied_column+2}"
                else:
                    out_str2 = f"layer{layer_no+1}_col{subchain[i].applied_column+2}[{chain_outputs[col+2 + out_shift][0]}]"
                out_str_list = [out_str0, out_str1, out_str2]
                max_len = max(len(s) for s in out_str_list)
                instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];"""
                if subchain[i+1] == "CHAIN_END":
                    instan += f"""
    assign {out_str2.ljust(max_len)} = {O_str}[2];
    """
                else:
                        instan += f"""
    """
                # connect LUTs with LOOKAHEAD8
                LUTLA_str0 = CLA_str
                LUTLA_str1 = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                LUTLA_str2 = f"CY_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str3 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2, LUTLA_str3]
                max_len = max(len(s) for s in LUTLA_str_list)
                if pos_cnt % 2:
                    instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt-1)//2}];
    assign {LUTLA_str1.ljust(max_len)} = {O_str}[2];
    assign {LUTLA_str2.ljust(max_len)} = {CY_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP_str};
    """
                else:
                    instan += f"""
    assign {LUTLA_str1.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt//2}];
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
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}{"[0]" if subchain_num_LA[j] > 1 else "   "} = {C0_str}[4];
    """
                    else:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt_temp//8}] = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt_temp//2)-1}];
    """
                # increment GPC instance counter and position counter
                pos_cnt += 2
                i_cnt += 1
            elif subchain[i].name == "(3,9 : 2,3,1)":
                # the counter that can ends a subchain and starts a new one
                # first declare signals and instantiate LUTs
                clk_str = f"clk"
                C0_str = f"C0_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                C1_str = f"C1_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                CLA_str = f"CLA_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                O0_str = f"O0_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                O1_str = f"O1_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                O2_str = f"O2_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                CY0_str = f"CY0_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                CY1_str = f"CY1_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                PROP0_str = f"PROP0_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                PROP1_str = f"PROP1_c39_231_l{layer_no}_c{chain_no}_i{i_cnt}"
                MSB_str = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                signal_decl += f"""
    logic [8 : 0] {C0_str};
    logic [2 : 0] {C1_str};
    logic         {CLA_str};
    logic         {O0_str};
    logic [2 : 0] {O1_str};
    logic [1 : 0] {O2_str};
    logic [1 : 0] {CY0_str};
    logic [1 : 0] {CY1_str};
    logic [1 : 0] {PROP0_str};
    logic [1 : 0] {PROP1_str};
    logic         {MSB_str};
    """
                port_list = [clk_str, C0_str, C1_str, CLA_str, O0_str, O1_str, O2_str, CY0_str, CY1_str, PROP0_str, PROP1_str, MSB_str]
                max_len = max(len(s) for s in port_list)
                instan += f"""
    c39_231 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
              .LEAVEC({'"FALSE"' if subchain[i+1] == "CHAIN_END" else '"TRUE" '}),
              .POSODD({'"TRUE" ' if pos_cnt % 2 else '"FALSE"'}))
    c39_231_l{layer_no}_c{chain_no}_i{i_cnt}(
        .clk  ({clk_str.ljust(max_len)}),
        .C0   ({C0_str.ljust(max_len)}),
        .C1   ({C1_str.ljust(max_len)}),
        .CLA  ({CLA_str.ljust(max_len)}),
        .O0   ({O0_str.ljust(max_len)}),
        .O1   ({O1_str.ljust(max_len)}),
        .O2   ({O2_str.ljust(max_len)}),
        .CY0  ({CY0_str.ljust(max_len)}),
        .CY1  ({CY1_str.ljust(max_len)}),
        .PROP0({PROP0_str.ljust(max_len)}),
        .PROP1({PROP1_str.ljust(max_len)}));
    """
                # connect the inputs of LUTS with layer inputs
                in_str_list = [C0_str, C1_str]
                max_len = max(len(s) for s in in_str_list)
                col = subchain[i].applied_column - start_col
                if subchain[i].in_cascade is False:
                    instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}];
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1}[{max(chain_inputs[col+1])}:{min(chain_inputs[col+1])}];
    """
                else:
                    instan += f"""
    assign {C0_str.ljust(max_len)} = {{l{layer_no}_c{chain_no}_i{i_cnt-1}, layer{layer_no}_col{subchain[i].applied_column}[{max(chain_inputs[col])}:{min(chain_inputs[col])}]}};
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1}[{max(chain_inputs[col+1])}:{min(chain_inputs[col+1])}];
    """
                # connect the outputs of LUTS with layer outputs
                if layer_outputs[subchain[i].applied_column] == 1:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}"
                else:
                    out_str0 = f"layer{layer_no+1}_col{subchain[i].applied_column}[{chain_outputs[col + out_shift][0]}]"
                out_str1 = f"layer{layer_no+1}_col{subchain[i].applied_column+1}[{max(chain_outputs[col+1 + out_shift])}:{min(chain_outputs[col+1 + out_shift])}]"
                if subchain[i+1] == "CHAIN_END":
                    out_str2 = f"layer{layer_no+1}_col{subchain[i].applied_column+2}[{max(chain_outputs[col+2 + out_shift])}:{min(chain_outputs[col+2 + out_shift])}]"
                else:
                    out_str2 = f"layer{layer_no+1}_col{subchain[i].applied_column+2}[{chain_outputs[col+2 + out_shift][-1]}]"
                out_str_list = [out_str0, out_str1, out_str2]
                max_len = max(len(s) for s in out_str_list)
                instan += f"""
    assign {out_str0.ljust(max_len)} = {O0_str};
    assign {out_str1.ljust(max_len)} = {O1_str};"""
                if subchain[i+1] == "CHAIN_END":
                    instan += f"""
    assign {out_str2.ljust(max_len)} = {O2_str};
    """
                else:
                    instan += f"""
    assign {out_str2.ljust(max_len)} = {O2_str}[0];
    """
                # connect LUTs with LOOKAHEAD8
                LUTLA_str0 = CLA_str
                LUTLA_str1 = f"l{layer_no}_c{chain_no}_i{i_cnt}"
                LUTLA_str2 = f"CY_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str3 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt+1}:{pos_cnt}]"
                LUTLA_str4 = f"CY_LA_l{layer_no}_c{chain_no}_s{j+1}[1:0]"
                LUTLA_str5 = f"PROP_LA_l{layer_no}_c{chain_no}_s{j+1}[1:0]"
                if j == len(subchain_num_LA)-1:
                    LUTLA_str6 = f"CIN_LA_l{layer_no}_c{chain_no}_s{j+1}"
                elif subchain_num_LA[j+1] > 1:
                    LUTLA_str6 = f"CIN_LA_l{layer_no}_c{chain_no}_s{j+1}[0]"
                else:
                    LUTLA_str6 = f"CIN_LA_l{layer_no}_c{chain_no}_s{j+1}"
                LUTLA_str_list = [LUTLA_str0, LUTLA_str1, LUTLA_str2, LUTLA_str3, LUTLA_str4, LUTLA_str5, LUTLA_str6]
                max_len = max(len(s) for s in LUTLA_str_list)
                if subchain[i+1] != "CHAIN_END":
                    idx = pos_cnt if pos_cnt == 0 else (pos_cnt-1)//2
                    instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{idx}];
    assign {LUTLA_str1.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j+1}[0];
    assign {LUTLA_str2.ljust(max_len)} = {CY0_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP0_str};
    assign {LUTLA_str4.ljust(max_len)} = {CY1_str};
    assign {LUTLA_str5.ljust(max_len)} = {PROP1_str};
    assign {LUTLA_str6.ljust(max_len)} = layer{layer_no}_col{subchain[i].applied_column+1}[{chain_inputs[col+1][1]}];
    """
                else:
                    idx = pos_cnt if pos_cnt == 0 else (pos_cnt-1)//2
                    instan += f"""
    assign {LUTLA_str0.ljust(max_len)} = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{idx}];
    assign {LUTLA_str2.ljust(max_len)} = {CY0_str};
    assign {LUTLA_str3.ljust(max_len)} = {PROP0_str};
    """
                # connect carry in and out between LOOKAHEAD8 blocks is needed
                if pos_cnt % 8 == 7 :
                    pos_cnt_temp = pos_cnt + 1
                else:
                    pos_cnt_temp = pos_cnt
                if pos_cnt_temp % 8 == 0:
                    if pos_cnt == 0:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}{"[0]" if subchain_num_LA[j] > 1 else "   "} = {C0_str}[8];
    """
                    else:
                        instan += f"""
    assign CIN_LA_l{layer_no}_c{chain_no}_s{j}[{pos_cnt_temp//8}] = COUT_LA_l{layer_no}_c{chain_no}_s{j}[{(pos_cnt_temp//2)-1}];
    """
                # increment GPC instance counter and position counter(no need for this counter)
                i_cnt += 1

    return headComment_str, signal_decl, instan, xdc

