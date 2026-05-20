from counter import Counter
from rtl_gen.utils import width_expr
from rtl_gen.lookahead import LOOKAHEAD8_gen


def floatingGPC_gen(counter: Counter, layer_no: int, floatingGPC_no: int, counter_inputs: list, counter_outputs: list, layer_inputs: list[int], layer_outputs: list[int], reg_flag: bool = False ) -> tuple[str, str, str, str]:
    # ------ generation of comments ------
    headComment_str = f"""
    // GPC{floatingGPC_no} in layer{layer_no}: {counter.name} at column {counter.applied_column}
    """
    # ------ generation of GPC LUTs ------
    signal_decl = f""
    instan = f""
    xdc = f""
    if counter.name == "(3 : 2]":
        clk_str = f"clk"
        C0_str = f"C0_c3_2_l{layer_no}_f{floatingGPC_no}"
        O_str = f"O_c3_2_l{layer_no}_i{floatingGPC_no}"
        CY_str = f"CY_c3_2_l{layer_no}_f{floatingGPC_no}"
        PROP_str = f"PROP_c3_2_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {O_str};
    logic         {CY_str};
    logic         {PROP_str};
    """
        port_list = [clk_str, C0_str, O_str, CY_str, PROP_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c3_2 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
           .LEAVEC({'"FALSE"'}),
           .POSODD({'"FALSE"'}),
           .FIRSTS({'"FALSE"'}),
           .LASTS ({'"FALSE"'}))
    c3_2_l{layer_no}_f{floatingGPC_no}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
        # connect the inputs of LUTs with layer inputs
        if len(counter_inputs[0]) == 2:
            instan += f"""
    assign {C0_str}[2:1] = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    assign {C0_str}[0]   = 1'b0;
    """
        else:
            instan += f"""
    assign {C0_str} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    """
        # connect the outputs of LUTs with layer outputs
        if layer_outputs[counter.applied_column] == 1:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}"
        else:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        if layer_outputs[counter.applied_column+1] == 1:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}"
        else:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{counter_outputs[1][0]}]"
        out_str_list = [out_str0, out_str1]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];
    """
    if counter.name == "(6 : 3]":
        clk_str = f"clk"
        C0_str = f"C0_c6_3_l{layer_no}_f{floatingGPC_no}"
        O_str = f"O_c6_3_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [5 : 0] {C0_str};
    logic [2 : 0] {O_str};
    """
        port_list = [clk_str, C0_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c6_3 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
           .LEAVEC("FALSE"))
    c6_3_l{layer_no}_f{floatingGPC_no}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .O   ({O_str.ljust(max_len)}));
    """
        # connect the inputs of LUTs with layer inputs
        instan += f"""
    assign {C0_str} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    """
        # connect the outputs of LUTs with layer outputs
        if layer_outputs[counter.applied_column] == 1:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}"
        else:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        if layer_outputs[counter.applied_column+1] == 1:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}"
        else:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{counter_outputs[1][0]}]"
        if layer_outputs[counter.applied_column+2] == 1:
            out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}"
        else:
            out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}[{counter_outputs[2][0]}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];
    assign {out_str2.ljust(max_len)} = {O_str}[2];"""
    if counter.name == "(9 : 4,1)":
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c9_41_l{layer_no}_f{floatingGPC_no}"
        CLA_str = f"CLA_c9_41_l{layer_no}_f{floatingGPC_no}"
        O0_str = f"O0_c9_41_l{layer_no}_f{floatingGPC_no}"
        O1_str = f"O1_c9_41_l{layer_no}_f{floatingGPC_no}"
        CY_str = f"CY_c9_41_l{layer_no}_f{floatingGPC_no}"
        PROP_str = f"PROP_c9_41_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [8 : 0] {C0_str};
    logic         {CLA_str};
    logic         {O0_str};
    logic [3 : 0] {O1_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    """
        port_list = [clk_str, C0_str, CLA_str, O0_str, O1_str, CY_str, PROP_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c9_41 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
            .LEAVEC({'"FALSE"'}),
            .POSODD({'"FALSE"'}))
    c9_41_l{layer_no}_f{floatingGPC_no}(
        .clk ({clk_str.ljust(max_len)}),
        .C0  ({C0_str.ljust(max_len)}),
        .CLA ({CLA_str.ljust(max_len)}),
        .O0  ({O0_str.ljust(max_len)}),
        .O1  ({O1_str.ljust(max_len)}),
        .CY  ({CY_str.ljust(max_len)}),
        .PROP({PROP_str.ljust(max_len)}));
    """
        # generate xdc to merge two LUT3s into one physical LUT
        xdc += f"""
### constraints for c9_41_l{layer_no}_f{floatingGPC_no} ###
set lut_hi_l{layer_no}_f{floatingGPC_no} [get_cells -hier -filter {{NAME =~ "*/c9_41_l{layer_no}_f{floatingGPC_no}/LUT3_inst0"}}]
set lut_lo_l{layer_no}_f{floatingGPC_no} [get_cells -hier -filter {{NAME =~ "*/c9_41_l{layer_no}_f{floatingGPC_no}/LUT3_inst1"}}]
set_property LUTNM grp_l{layer_no}_f{floatingGPC_no} $lut_hi_l{layer_no}_f{floatingGPC_no}
set_property LUTNM grp_l{layer_no}_f{floatingGPC_no} $lut_lo_l{layer_no}_f{floatingGPC_no}


"""
        # connect the inputs of LUTs with layer inputs
        instan += f"""
    assign {C0_str} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    """
        # connect the outputs of LUTs with layer outputs
        if layer_outputs[counter.applied_column] == 1:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}"
        else:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{max(counter_outputs[1])}:{min(counter_outputs[1])}]"
        out_str_list = [out_str0, out_str1]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O0_str};
    assign {out_str1.ljust(max_len)} = {O1_str};
    """
    if counter.name == "(1,5 : 3]":
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c15_3_l{layer_no}_f{floatingGPC_no}"
        C1_str = f"C1_c15_3_l{layer_no}_f{floatingGPC_no}"
        CLA_str = f"CLA_c15_3_l{layer_no}_f{floatingGPC_no}"
        O_str = f"O_c15_3_l{layer_no}_f{floatingGPC_no}"
        CY_str = f"CY_c15_3_l{layer_no}_f{floatingGPC_no}"
        PROP_str = f"PROP_c15_3_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [4 : 0] {C0_str};
    logic         {C1_str};
    logic         {CLA_str};
    logic [2 : 0] {O_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    """
        port_list = [clk_str, C0_str, C1_str, CLA_str, O_str, CY_str, PROP_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c15_3 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
            .LEAVEC({'"FALSE"'}),
            .POSODD({'"FALSE"'}),
            .FIRSTS({'"TRUE" '}),
            .LASTS ({'"FALSE"'}))
    c15_3_l{layer_no}_f{floatingGPC_no}(
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
        if len(counter_inputs[0]) == 5:
            instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];"""
        elif len(counter_inputs[0]) == 4:
            instan += f"""
    assign {C0_str.ljust(max_len)} = {{layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}], 1'b0}};"""
        else:
            instan += f"""
    assign {C0_str.ljust(max_len)} = {{layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}], 2'b0}};"""
        if len(counter_inputs[1]) == 1:
            if layer_inputs[counter.applied_column+1] == 1:
                instan += f"""
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+1};
    """
            else:
                instan += f"""
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+1}[{counter_inputs[1][0]}];
    """
        else:
            instan += f"""
    assign {C1_str.ljust(max_len)} = 1'b0;
    """
        # connect the outputs of LUTS with layer outputs
        if layer_outputs[counter.applied_column] == 1:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}"
        else:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        if layer_outputs[counter.applied_column+1] == 1:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}"
        else:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{counter_outputs[1][0]}]"
        if layer_outputs[counter.applied_column+2] == 1:
            out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}"
        else:
            out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}[{counter_outputs[2][0]}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];
    assign {out_str2.ljust(max_len)} = {O_str}[2];
    """
    if counter.name == "(3,9 : 2,3,1)":
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c39_231_l{layer_no}_f{floatingGPC_no}"
        C1_str = f"C1_c39_231_l{layer_no}_f{floatingGPC_no}"
        CLA_str = f"CLA_c39_231_l{layer_no}_f{floatingGPC_no}"
        O0_str = f"O0_c39_231_l{layer_no}_f{floatingGPC_no}"
        O1_str = f"O1_c39_231_l{layer_no}_f{floatingGPC_no}"
        O2_str = f"O2_c39_231_l{layer_no}_f{floatingGPC_no}"
        CY0_str = f"CY0_c39_231_l{layer_no}_f{floatingGPC_no}"
        CY1_str = f"CY1_c39_231_l{layer_no}_f{floatingGPC_no}"
        PROP0_str = f"PROP0_c39_231_l{layer_no}_f{floatingGPC_no}"
        PROP1_str = f"PROP1_c39_231_l{layer_no}_f{floatingGPC_no}"
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
    """
        port_list = [clk_str, C0_str, C1_str, CLA_str, O0_str, O1_str, O2_str, CY0_str, CY1_str, PROP0_str, PROP1_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c39_231 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
              .LEAVEC({'"FALSE"'}),
              .POSODD({'"FALSE"'}))
    c39_231_l{layer_no}_f{floatingGPC_no}(
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
        instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+1}[{max(counter_inputs[1])}:{min(counter_inputs[1])}];
    """
        # connect the outputs of LUTS with layer outputs
        if layer_outputs[counter.applied_column] == 1:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}"
        else:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{max(counter_outputs[1])}:{min(counter_outputs[1])}]"
        out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}[{max(counter_outputs[2])}:{min(counter_outputs[2])}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O0_str};
    assign {out_str1.ljust(max_len)} = {O1_str};
    assign {out_str2.ljust(max_len)} = {O2_str};
    """
    if counter.name == "(2,2,3 : 4]":
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c223_4_l{layer_no}_f{floatingGPC_no}"
        C1_str = f"C1_c223_4_l{layer_no}_f{floatingGPC_no}"
        C2_str = f"C2_c223_4_l{layer_no}_f{floatingGPC_no}"
        CLA_str = f"CLA_c223_4_l{layer_no}_f{floatingGPC_no}"
        O_str = f"O_c223_4_l{layer_no}_f{floatingGPC_no}"
        CY_str = f"CY_c223_4_l{layer_no}_f{floatingGPC_no}"
        PROP_str = f"PROP_c223_4_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [2 : 0] {C0_str};
    logic [1 : 0] {C1_str};
    logic [1 : 0] {C2_str};
    logic         {CLA_str};
    logic [3 : 0] {O_str};
    logic [1 : 0] {CY_str};
    logic [1 : 0] {PROP_str};
    """
        port_list = [clk_str, C0_str, C1_str, C2_str, CLA_str, O_str, CY_str, PROP_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c223_4 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
             .LEAVEC({'"FALSE"'}),
             .POSODD({'"FALSE"'}))
    c223_4_l{layer_no}_f{floatingGPC_no}(
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
        instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+1}[{counter_inputs[1][1]}:{counter_inputs[1][0]}];
    assign {C2_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+2}[{counter_inputs[2][1]}:{counter_inputs[2][0]}];
    """
        # connect the outputs of LUTS with layer outputs
        if layer_outputs[counter.applied_column] == 1:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}"
        else:
            out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        if layer_outputs[counter.applied_column+1] == 1:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}"
        else:
            out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{counter_outputs[1][0]}]"
        if layer_outputs[counter.applied_column+2] == 1:
            out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}"
        else:
            out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}[{counter_outputs[2][0]}]"
        if layer_outputs[counter.applied_column+3] == 1:
            out_str3 = f"layer{layer_no+1}_col{counter.applied_column+3}"
        else:
            out_str3 = f"layer{layer_no+1}_col{counter.applied_column+3}[{counter_outputs[3][0]}]"
        out_str_list = [out_str0, out_str1, out_str2, out_str3]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O_str}[0];
    assign {out_str1.ljust(max_len)} = {O_str}[1];
    assign {out_str2.ljust(max_len)} = {O_str}[2];
    assign {out_str3.ljust(max_len)} = {O_str}[3];
    """
    if counter.name == "(4,13 : 3,4,1)":
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c413_341_l{layer_no}_f{floatingGPC_no}"
        C1_str = f"C1_c413_341_l{layer_no}_f{floatingGPC_no}"
        CLA_str = f"CLA_c413_341_l{layer_no}_f{floatingGPC_no}"
        O0_str = f"O0_c413_341_l{layer_no}_f{floatingGPC_no}"
        O1_str = f"O1_c413_341_l{layer_no}_f{floatingGPC_no}"
        O2_str = f"O2_c413_341_l{layer_no}_f{floatingGPC_no}"
        CY0_str = f"CY0_c413_341_l{layer_no}_f{floatingGPC_no}"
        PROP0_str = f"PROP0_c413_341_l{layer_no}_f{floatingGPC_no}"
        CY1_str = f"CY1_c413_341_l{layer_no}_f{floatingGPC_no}"
        PROP1_str = f"PROP1_c413_341_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [12 : 0] {C0_str};
    logic [3  : 0] {C1_str};
    logic [1  : 0] {CLA_str};
    logic          {O0_str};
    logic [3  : 0] {O1_str};
    logic [2  : 0] {O2_str};
    logic [2  : 0] {CY0_str};
    logic [2  : 0] {PROP0_str};
    logic [2  : 0] {CY1_str};
    logic [2  : 0] {PROP1_str};
    """
        port_list = [clk_str, C0_str, C1_str, CLA_str, O0_str, O1_str, O2_str, CY0_str, PROP0_str, CY1_str, PROP1_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c413_341 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
               .LEAVEC({'"FALSE"'}))
    c413_341_l{layer_no}_f{floatingGPC_no}(
        .clk  ({clk_str.ljust(max_len)}),
        .C0   ({C0_str.ljust(max_len)}),
        .C1   ({C1_str.ljust(max_len)}),
        .CLA  ({CLA_str.ljust(max_len)}),
        .O0   ({O0_str.ljust(max_len)}),
        .O1   ({O1_str.ljust(max_len)}),
        .O2   ({O2_str.ljust(max_len)}),
        .CY0  ({CY0_str.ljust(max_len)}),
        .PROP0({PROP0_str.ljust(max_len)}),
        .CY1  ({CY1_str.ljust(max_len)}),
        .PROP1({PROP1_str.ljust(max_len)}));
    """
        # connect the inputs of LUTS with layer inputs
        in_str_list = [C0_str, C1_str]
        max_len = max(len(s) for s in in_str_list)
        instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+1}[{max(counter_inputs[1])}:{min(counter_inputs[1])}];
    """
        # connect the outputs of LUTS with layer outputs
        out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{max(counter_outputs[1])}:{min(counter_outputs[1])}]"
        out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}[{max(counter_outputs[2])}:{min(counter_outputs[2])}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O0_str};
    assign {out_str1.ljust(max_len)} = {O1_str};
    assign {out_str2.ljust(max_len)} = {O2_str};
    """
        # connect LUTs with LOOKAHEAD8
        LA_signal_decl, LA_instan = LOOKAHEAD8_gen(1, f"l{layer_no}_f{floatingGPC_no}", [False, False, False, False])
        signal_decl += LA_signal_decl
        instan += LA_instan
        LA_LUT_str0 = CLA_str+"[0]"
        LA_LUT_str1 = CLA_str+"[1]"
        LA_LUT_str2 = f"CIN_LA_l{layer_no}_f{floatingGPC_no}"
        LA_LUT_str3 = f"CY_LA_l{layer_no}_f{floatingGPC_no}[2:0]"
        LA_LUT_str4 = f"CY_LA_l{layer_no}_f{floatingGPC_no}[6:4]"
        LA_LUT_str5 = f"PROP_LA_l{layer_no}_f{floatingGPC_no}[2:0]"
        LA_LUT_str6 = f"PROP_LA_l{layer_no}_f{floatingGPC_no}[6:4]"
        LA_LUT_str7 = f"PROP_LA_l{layer_no}_f{floatingGPC_no}[3]"
        LA_LUT_str8 = f"CY_LA_l{layer_no}_f{floatingGPC_no}[3]"
        out_str_list = [LA_LUT_str0, LA_LUT_str1, LA_LUT_str2, LA_LUT_str3, LA_LUT_str4, LA_LUT_str5, LA_LUT_str6, LA_LUT_str7, LA_LUT_str8]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {LA_LUT_str0.ljust(max_len)} = COUT_LA_l{layer_no}_f{floatingGPC_no}[0];
    assign {LA_LUT_str1.ljust(max_len)} = COUT_LA_l{layer_no}_f{floatingGPC_no}[2];
    assign {LA_LUT_str2.ljust(max_len)} = {C0_str}[8];
    assign {LA_LUT_str3.ljust(max_len)} = {CY0_str};
    assign {LA_LUT_str4.ljust(max_len)} = {CY1_str};
    assign {LA_LUT_str5.ljust(max_len)} = {PROP0_str};
    assign {LA_LUT_str6.ljust(max_len)} = {PROP1_str};
    assign {LA_LUT_str7.ljust(max_len)} = 1'b0;
    assign {LA_LUT_str8.ljust(max_len)} = 1'b0;
    """
    if counter.name == "(5,17 : 4,5,1)":
        # first declare signals and instantiate LUTs
        clk_str = f"clk"
        C0_str = f"C0_c517_451_l{layer_no}_f{floatingGPC_no}"
        C1_str = f"C1_c517_451_l{layer_no}_f{floatingGPC_no}"
        CLA_str = f"CLA_c517_451_l{layer_no}_f{floatingGPC_no}"
        O0_str = f"O0_c517_451_l{layer_no}_f{floatingGPC_no}"
        O1_str = f"O1_c517_451_l{layer_no}_f{floatingGPC_no}"
        O2_str = f"O2_c517_451_l{layer_no}_f{floatingGPC_no}"
        CY0_str = f"CY0_c517_451_l{layer_no}_f{floatingGPC_no}"
        PROP0_str = f"PROP0_c517_451_l{layer_no}_f{floatingGPC_no}"
        CY1_str = f"CY1_c517_451_l{layer_no}_f{floatingGPC_no}"
        PROP1_str = f"PROP1_c517_451_l{layer_no}_f{floatingGPC_no}"
        signal_decl += f"""
    logic [16 : 0] {C0_str};
    logic [4  : 0] {C1_str};
    logic [1  : 0] {CLA_str};
    logic          {O0_str};
    logic [4  : 0] {O1_str};
    logic [3  : 0] {O2_str};
    logic [3  : 0] {CY0_str};
    logic [3  : 0] {PROP0_str};
    logic [3  : 0] {CY1_str};
    logic [3  : 0] {PROP1_str};
    """
        port_list = [clk_str, C0_str, C1_str, CLA_str, O0_str, O1_str, O2_str, CY0_str, PROP0_str, CY1_str, PROP1_str]
        max_len = max(len(s) for s in port_list)
        instan += f"""
    c517_451 #(.OUTREG({'"TRUE" ' if reg_flag else '"FALSE"'}),
               .LEAVEC({'"FALSE"'}))
    c517_451_l{layer_no}_f{floatingGPC_no}(
        .clk  ({clk_str.ljust(max_len)}),
        .C0   ({C0_str.ljust(max_len)}),
        .C1   ({C1_str.ljust(max_len)}),
        .CLA  ({CLA_str.ljust(max_len)}),
        .O0   ({O0_str.ljust(max_len)}),
        .O1   ({O1_str.ljust(max_len)}),
        .O2   ({O2_str.ljust(max_len)}),
        .CY0  ({CY0_str.ljust(max_len)}),
        .PROP0({PROP0_str.ljust(max_len)}),
        .CY1  ({CY1_str.ljust(max_len)}),
        .PROP1({PROP1_str.ljust(max_len)}));
    """
        # connect the inputs of LUTS with layer inputs
        in_str_list = [C0_str, C1_str]
        max_len = max(len(s) for s in in_str_list)
        instan += f"""
    assign {C0_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column}[{max(counter_inputs[0])}:{min(counter_inputs[0])}];
    assign {C1_str.ljust(max_len)} = layer{layer_no}_col{counter.applied_column+1}[{max(counter_inputs[1])}:{min(counter_inputs[1])}];
    """
        # connect the outputs of LUTS with layer outputs
        out_str0 = f"layer{layer_no+1}_col{counter.applied_column}[{counter_outputs[0][0]}]"
        out_str1 = f"layer{layer_no+1}_col{counter.applied_column+1}[{max(counter_outputs[1])}:{min(counter_outputs[1])}]"
        out_str2 = f"layer{layer_no+1}_col{counter.applied_column+2}[{max(counter_outputs[2])}:{min(counter_outputs[2])}]"
        out_str_list = [out_str0, out_str1, out_str2]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {out_str0.ljust(max_len)} = {O0_str};
    assign {out_str1.ljust(max_len)} = {O1_str};
    assign {out_str2.ljust(max_len)} = {O2_str};
    """
        # connect LUTs with LOOKAHEAD8
        LA_signal_decl, LA_instan = LOOKAHEAD8_gen(1, f"l{layer_no}_f{floatingGPC_no}", [False, False, False, False])
        signal_decl += LA_signal_decl
        instan += LA_instan
        LA_LUT_str0 = CLA_str+"[0]"
        LA_LUT_str1 = CLA_str+"[1]"
        LA_LUT_str2 = f"CIN_LA_l{layer_no}_f{floatingGPC_no}"
        LA_LUT_str3 = f"CY_LA_l{layer_no}_f{floatingGPC_no}[3:0]"
        LA_LUT_str4 = f"CY_LA_l{layer_no}_f{floatingGPC_no}[7:4]"
        LA_LUT_str5 = f"PROP_LA_l{layer_no}_f{floatingGPC_no}[3:0]"
        LA_LUT_str6 = f"PROP_LA_l{layer_no}_f{floatingGPC_no}[7:4]"
        out_str_list = [LA_LUT_str0, LA_LUT_str1, LA_LUT_str2, LA_LUT_str3, LA_LUT_str4, LA_LUT_str5, LA_LUT_str6]
        max_len = max(len(s) for s in out_str_list)
        instan += f"""
    assign {LA_LUT_str0.ljust(max_len)} = COUT_LA_l{layer_no}_f{floatingGPC_no}[0];
    assign {LA_LUT_str1.ljust(max_len)} = COUT_LA_l{layer_no}_f{floatingGPC_no}[2];
    assign {LA_LUT_str2.ljust(max_len)} = {C0_str}[8];
    assign {LA_LUT_str3.ljust(max_len)} = {CY0_str};
    assign {LA_LUT_str4.ljust(max_len)} = {CY1_str};
    assign {LA_LUT_str5.ljust(max_len)} = {PROP0_str};
    assign {LA_LUT_str6.ljust(max_len)} = {PROP1_str};
    """
    return headComment_str, signal_decl, instan, xdc


def floatingGPC_placement(GPC_list: list[tuple[Counter, int]], layer_no: int, placement_len: int) -> tuple[str, str]:
    decl = ""
    instan = ""
    num_LA = placement_len // 8
    num_LA += 1 if placement_len % 8 else 0
    attri_LA = [False, False, False, False] * num_LA
    LA_signal_decl, LA_instan = LOOKAHEAD8_gen(num_LA, f"l{layer_no}_floating_placement", attri_LA)
    decl += LA_signal_decl
    instan += LA_instan
    pos_cnt = 0

    for counter, floatingGPC_no in GPC_list:
        if counter.name == "(9 : 4,1)":
            instan += f"""
    assign CY_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}]   = CY_c9_41_l{layer_no}_f{floatingGPC_no};
    assign PROP_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}] = PROP_c9_41_l{layer_no}_f{floatingGPC_no};"""
            if pos_cnt % 8 == 0:
                instan += f"""
    assign CIN_LA_l{layer_no}_floating_placement{f"[{pos_cnt//8}]" if num_LA > 1 else "   "} = C0_c9_41_l{layer_no}_f{floatingGPC_no}[8];
    """
            else:
                instan += f"""
    """
            pos_cnt += 2

        if counter.name == "(1,5 : 3]":
            instan += f"""
    assign CY_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}]   = CY_c15_3_l{layer_no}_f{floatingGPC_no};
    assign PROP_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}] = PROP_c15_3_l{layer_no}_f{floatingGPC_no};"""
            if pos_cnt % 8 == 0:
                instan += f"""
    assign CIN_LA_l{layer_no}_floating_placement{f"[{pos_cnt//8}]" if num_LA > 1 else "   "} = C0_c15_3_l{layer_no}_f{floatingGPC_no}[4];
    """
            else:
                instan += f"""
    """
            pos_cnt += 2

        if counter.name == "(2,2,3 : 4]":
            instan += f"""
    assign CY_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}]   = CY_c223_4_l{layer_no}_f{floatingGPC_no};
    assign PROP_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}] = PROP_c223_4_l{layer_no}_f{floatingGPC_no};"""
            if pos_cnt % 8 == 0:
                instan += f"""
    assign CIN_LA_l{layer_no}_floating_placement{f"[{pos_cnt//8}]" if num_LA > 1 else "   "} = C0_c223_4_l{layer_no}_f{floatingGPC_no}[2];
    """
            else:
                instan += f"""
    """
            pos_cnt += 2

        if counter.name == "(3,9 : 2,3,1)":
            instan += f"""
    assign CY_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}]   = CY0_c39_231_l{layer_no}_f{floatingGPC_no};
    assign PROP_LA_l{layer_no}_floating_placement[{pos_cnt+1}:{pos_cnt}] = PROP0_c39_231_l{layer_no}_f{floatingGPC_no};
    assign CY_LA_l{layer_no}_floating_placement[{pos_cnt+3}:{pos_cnt+2}]   = CY1_c39_231_l{layer_no}_f{floatingGPC_no};
    assign PROP_LA_l{layer_no}_floating_placement[{pos_cnt+3}:{pos_cnt+2}] = PROP1_c39_231_l{layer_no}_f{floatingGPC_no};"""
            if pos_cnt % 8 == 0:
                instan += f"""
    assign CIN_LA_l{layer_no}_floating_placement{f"[{pos_cnt//8}]" if num_LA > 1 else "   "} = C0_c39_231_l{layer_no}_f{floatingGPC_no}[8];
    """
            elif pos_cnt % 8 == 6:
                instan += f"""
    assign CIN_LA_l{layer_no}_floating_placement[{(pos_cnt+2)//8}] = C1_c39_231_l{layer_no}_f{floatingGPC_no}[1];
    """
            else:
                instan += f"""
    """
            pos_cnt += 4

    return decl, instan

