import os
from bitheap import BitHeap
from counter import Counter
from heuristic import compressAll, formGPCChain, merge_last_stage
from rtl_gen.utils import read_nonneg_int_list, gen_bitheap_testvectors
from rtl_gen.layer import layer_gen
from rtl_gen.terminal_add import terminalAdd_gen


def reg_flag_list_gen(pipeline_stages: int, num_layers: int) -> list[bool]:
    reg_flag_list = [False] * num_layers
    base = num_layers // pipeline_stages
    remainder = num_layers % pipeline_stages
    idx = 0
    for stage in range(pipeline_stages):
        group_size = base + (1 if stage < remainder else 0)
        idx += group_size
        reg_flag_list[idx-1] = True
    return reg_flag_list


def compressor_gen(counter_list_rearranged: list[list], first_layer_inputs: list[int], comp_output_name: str, comp_output_width: int, last_compression_layer_bitheap: BitHeap, reg_flag_list: list[bool]) -> tuple[str, str]:
    comments = ""
    declaration = ""
    instantiation = ""
    xdc = ""
    number_of_layers = len(counter_list_rearranged)
    current_layer_inputs = first_layer_inputs
    if number_of_layers >= 2:
        merge_flag_temp, reduced_inputs = merge_last_stage(last_compression_layer_counter_list=counter_list_rearranged[-1],
                                                           last_compression_layer_bitheap=last_compression_layer_bitheap)
    else:
        merge_flag_temp = False
        reduced_inputs = [[[0]]]
    if merge_flag_temp:
        print("Last compression stage is able to be merged with its previous stage!")
        number_of_layers -= 1
    print(f"Maximum Number of Pipeline Stages of the Compressor Tree: {number_of_layers+1}")
    num_pipe = 0
    for val in reg_flag_list:
        num_pipe += 1 if val else 0
    print(f"Generated compressor tree is pipelined into {num_pipe} stages")
    for no in range(number_of_layers):
        merge_flag = True if merge_flag_temp and no == number_of_layers-1 else False
        next_layer_inputs, layer_comments, layer_declaration, layer_instantaion, layer_xdc = layer_gen(layer_no=no,
                                                                                                       layer_inputs=current_layer_inputs,
                                                                                                       chains_list=counter_list_rearranged[no],
                                                                                                       reg_flag=reg_flag_list[no],
                                                                                                       merge_flag=merge_flag,
                                                                                                       merge_counter_list=counter_list_rearranged[-1],
                                                                                                       reduced_inputs=reduced_inputs)
        declaration += layer_comments
        declaration += layer_declaration
        instantiation += layer_comments
        instantiation += layer_instantaion
        xdc += layer_xdc
        current_layer_inputs = next_layer_inputs
    terminal_declaration, terminal_instantiation = terminalAdd_gen(terminal_layer_no=number_of_layers,
                                                                   terminal_inputs=current_layer_inputs,
                                                                   final_output_name=comp_output_name,
                                                                   final_output_width=comp_output_width,
                                                                   terminal_reg_flag=reg_flag_list[-1])
    declaration += f"""
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------"""
    declaration += terminal_declaration
    instantiation += f"""
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------"""
    instantiation += terminal_instantiation
    RTL_compressor = comments + declaration + instantiation
    return RTL_compressor, xdc


def _col_port_names(number_list: list[int], bitheap_desc: list | None) -> list[str]:
    """Derive per-column port names from bitheap_desc or default to in_col{k}."""
    n = len(number_list)
    names = [f"in_col{col}" for col in range(n)]
    if bitheap_desc is not None:
        for entry in bitheap_desc:
            col_idx = entry[0]
            if col_idx < n and len(entry) > 1:
                sig_name = entry[1][0]  # signal_name from first bit tuple
                if sig_name is not None:
                    names[col_idx] = sig_name
    return names


def compressor_RTL_gen(txt_file_name: str, sv_file_name: str, compressor_module_name: str, tb_out_width: int, reg_flag_list: list[bool], visualization: bool=False, gen_testbench: bool=True, test_size: int=1000, bitheap_desc: list | None = None) -> None:
    """Generate complete compressor tree RTL from a bitheap description file.

    Reads the bitheap .txt file, runs compression heuristics, generates
    SystemVerilog, XDC constraints, and optionally testbenches + test vectors.
    Output files are written to RTL_generated/ and xdc_generated/ directories.

    If bitheap_desc is provided, column port names are derived from Bit
    metadata instead of using the default in_col{k} naming.
    """
    # read .txt to build bit heap instances
    number_list = read_nonneg_int_list(txt_file_name)
    number_of_columns = len(number_list)
    sum_max = 0
    for col in range(number_of_columns):
        sum_max += number_list[col]*(2**col)
    width_bh = sum_max.bit_length()
    bh_inst = BitHeap(width_bh, 0)
    for col in range(number_of_columns):
        bh_inst.add_bits(col, number_list[col])

    # derive per-column port names
    col_names = _col_port_names(number_list, bitheap_desc)

    # generation of the module head
    left_w = max(len(str(v-1)) for v in number_list)
    left_w = max([left_w, len(str(width_bh-1))])
    RTL_str = f"""`timescale 1ns / 1ps

module {compressor_module_name} (
    input  logic  {' '*left_w}      clk,
    """
    for col in range(number_of_columns):
        if number_list[col] == 0:
            continue
        elif number_list[col] == 1:
            RTL_str += f"""input  logic  {' '*left_w}      {col_names[col]},
    """
        else:
            RTL_str += f"""input  logic [{(number_list[col]-1):<{left_w}} : 0] {col_names[col]},
    """
    RTL_str += f"""output logic [{(width_bh-1):<{left_w}} : 0] comp_out
    );

    """

    # compress the bitheap and arrange layers of counters and counter chains
    if visualization:
        bh_inst.visualize(f"original_bitheap", False)
    last_compression_layer_bitheap, raw_counter_list = compressAll(bh_inst, 0, width_bh-1, visualization, True)
    counter_list = formGPCChain(raw_counter_list)

    # generate the RTL for the bit heap compressor obtained above
    first_layer_inputs = []
    for col in range(width_bh):
        if col > len(number_list)-1:
            first_layer_inputs.append(0)
        else:
            first_layer_inputs.append(number_list[col])

    compressor_RTL, compressor_xdc = compressor_gen(counter_list_rearranged=counter_list,
                                                    first_layer_inputs=first_layer_inputs,
                                                    comp_output_name="comp_out",
                                                    comp_output_width=width_bh,
                                                    last_compression_layer_bitheap=last_compression_layer_bitheap,
                                                    reg_flag_list=reg_flag_list)
    RTL_str += compressor_RTL
    # assign the module inputs with compressor inputs
    RTL_str += f"""
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    """
    for col in range(number_of_columns):
        actual_bits = number_list[col]
        padded_bits = first_layer_inputs[col] if col < len(first_layer_inputs) else 0
        if padded_bits > actual_bits and actual_bits > 0:
            # Zero-pad upper bits when the compressor column is wider than the input port
            pad = padded_bits - actual_bits
            RTL_str += f"""assign layer0_col{col:<{4}} = {{{pad}'b0, {col_names[col]}}};
    """
        elif actual_bits > 0:
            RTL_str += f"""assign layer0_col{col:<{4}} = {col_names[col]};
    """
        elif padded_bits > 0:
            # No module-input bits, but compressor widened this column — drive zeros
            RTL_str += f"""assign layer0_col{col:<{4}} = {padded_bits}'b0;
    """
        # else: padded_bits == 0 → layer_gen did not declare layer0_col{col}; nothing to assign

    # the tail of module
    RTL_str += f"""
endmodule"""
    # write into .sv and .xdc files
    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join(folder, f"{sv_file_name}.sv")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(RTL_str)
    folder = "xdc_generated"
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join(folder, f"{sv_file_name}.xdc")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(compressor_xdc)

    if gen_testbench:
        tb_str = f"""`timescale 1ns / 1ps
    
module {compressor_module_name}_tb ();
    // ============================== parameters ==============================
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       {test_size}
    `define INIT_RESET    200
    
    // ============================== clock ==============================
    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    // ============================== in/out signals for DUT ==============================
    """
        for col in range(number_of_columns):
            if number_list[col] == 0:
                continue
            elif number_list[col] == 1:
                tb_str += f"""logic  {' '*left_w}      {col_names[col]};
    """
            else:
                tb_str += f"""logic [{(number_list[col]-1):<{left_w}} : 0] {col_names[col]};
    """
        tb_str += f"""logic [{(width_bh-1):<{left_w}} : 0] comp_out;
        """
        w = number_of_columns.bit_length()
        tb_str += f"""
    // ============================== DUT and its port connections ==============================
    {compressor_module_name} dut (
        .clk{' '*(w+1+3)}(clk{' '*(w+1+3)}),
        """
        for col in range(number_of_columns):
            if number_list[col] == 0:
                continue
            else:
                cn = col_names[col]
                tb_str += f""".{cn:<{w+1+7}}({cn:<{w+1+7}}),
        """
        tb_str += f""".comp_out(comp_out));
    """
        tb_str += f"""
    // ============================== testvectors ==============================
    """
        for col in range(number_of_columns):
            if number_list[col] == 0:
                continue
            elif number_list[col] == 1:
                tb_str += f"""logic  {' '*left_w}      {col_names[col]}_ts [`TS_SIZE-1 : 0];
    """
            else:
                tb_str += f"""logic [{(number_list[col]-1):<{left_w}} : 0] {col_names[col]}_ts [`TS_SIZE-1 : 0];
    """
        tb_str += f"""logic [{(width_bh-1):<{left_w}} : 0] comp_out_ts [`TS_SIZE-1 : 0];
    """
        tb_str += f"""
    // ============================== read testvector values ==============================
    initial begin
        """
        for col in range(number_of_columns):
            if number_list[col] == 0:
                continue
            else:
                tb_str += f"""$readmemh("../../../../../testvectors/{col_names[col]}.txt", {col_names[col]}_ts);
        """
        tb_str += f"""$readmemh("../../../../../testvectors/comp_out.txt", comp_out_ts);
    end
    """
        tb_str += f"""
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            """
        # calculate the number of pipeline stages
        comp_pipeline_stages = 0
        for val in reg_flag_list:
            if val:
                comp_pipeline_stages += 1
        for col in range(number_of_columns):
            if number_list[col] == 0:
                continue
            else:
                cn = col_names[col]
                tb_str += f"""{cn:<{w+7}} = {cn}_ts[i];
            """
        tb_str += f"""#`CLK_P;
        end
    end
    """
        tb_str += f"""
    // ============================== check the correctness of output ==============================
    int j;
    int correct_cnt;
    initial begin
        correct_cnt = 0;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*{comp_pipeline_stages});
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            if (comp_out[{tb_out_width-1}:0] == comp_out_ts[j][{tb_out_width-1}:0]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", comp_out[{tb_out_width-1}:0]);
                $display("reference output: %b", comp_out_ts[j][{tb_out_width-1}:0]);
                $display("difference:       %b", comp_out_ts[j][{tb_out_width-1}:0] - comp_out[{tb_out_width-1}:0]);
                $display("=================================================================================");
            end
            #`CLK_P;
        end
        if (correct_cnt == `TS_SIZE) begin
            $display("SUCCESS!");
            $display("PASS All %d Testvectors!", `TS_SIZE);
        end else begin
            $display("TO BE DEBUGGED...");
            $display("%d out of %d testvectors failed...", (`TS_SIZE-correct_cnt), `TS_SIZE);
        end
        $finish();
    end

endmodule"""
        folder = "RTL_generated"
        os.makedirs(folder, exist_ok=True)
        file_path = os.path.join(folder, f"{sv_file_name}_tb.sv")
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(tb_str)
        gen_bitheap_testvectors(number_list=number_list, test_size=test_size, col_names=col_names)

