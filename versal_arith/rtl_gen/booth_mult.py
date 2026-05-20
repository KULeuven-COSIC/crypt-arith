import os
from random import randint
from bitheap import BitHeap
from heuristic import compressAll, formGPCChain, merge_last_stage
from rtl_gen.utils import to_twos_complement_hex, width_expr
from rtl_gen.compressor import reg_flag_list_gen, compressor_RTL_gen


def Bmult_bitheap_RTL_gen(width_a: int, width_b: int, bitheap_list: list[int], out_reg: bool, file_name: str) -> None:
    left_vals = [0, width_a-1, width_b-1]
    for val in bitheap_list:
        left_vals.append(val-1)
    left_w = max(len(str(v)) for v in left_vals)
    width_exprs = []
    width_expr_lens = []
    for val in left_vals:
        width_exprs.append(width_expr(val, left_w))
        width_expr_lens.append(len(width_expr(val, left_w)))
    w = max(width_expr_lens)

    RTL_str = f"""`timescale 1ns / 1ps

module {file_name} (
    input  logic {width_exprs[0]:<{w}} clk,
    input  logic {width_exprs[1]:<{w}} OPA,
    input  logic {width_exprs[2]:<{w}} OPB"""

    for i in range(3, len(width_exprs)):
        RTL_str += f""",
    output logic {width_exprs[i]:<{w}} col{i-3}"""

    RTL_str += f"""
    );
    
    """

    # declare signals for instance connection
    for i in range(3, len(width_exprs)):
        RTL_str += f"""
    logic {width_exprs[i]:<{w}} col{i-3}_wire;"""

    # generate PART1: the main part row by row
    num_of_rows = width_b // 2
    col_pointers = [0] * len(bitheap_list)
    ### generate the first row; using LUT6_2 to force LUT5 merging
    RTL_str += f"""
    
    // the main part of row 0"""
    for j in range(0, width_a, 2):
        if j == width_a - 1 :
            RTL_str += f"""
    LUT6_2 #(.INIT(64'hDD33DD33268C268C))
    LUT6_2_row0_inst{j} (
        .O6(col{j+1}_wire{f"[{col_pointers[j+1]}]" if bitheap_list[j+1] > 1 else ""}),
        .O5(col{j}_wire{f"[{col_pointers[j]}]" if bitheap_list[j] > 1 else ""}),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2({"1'b0" if j == 0 else f"OPA[{j-1}]"}),
        .I3(OPA[{j}]),
        .I4(1'b1),
        .I5(1'b1));
    """
        else:
            RTL_str += f"""
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst{j} (
        .O6(col{j+1}_wire{f"[{col_pointers[j+1]}]" if bitheap_list[j+1] > 1 else ""}),
        .O5(col{j}_wire{f"[{col_pointers[j]}]" if bitheap_list[j] > 1 else ""}),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2({"1'b0" if j == 0 else f"OPA[{j-1}]"}),
        .I3(OPA[{j}]),
        .I4(OPA[{j+1}]),
        .I5(1'b1));
    """
        col_pointers[j] += 1
        col_pointers[j+1] += 1
    if width_a % 2 == 0:
        RTL_str += f"""
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row0_inst{width_a} (
        .O (col{width_a}_wire{f"[{col_pointers[width_a]}]" if bitheap_list[width_a] > 1 else ""}),
        .I0(1'b0),
        .I1(OPB[0]),
        .I2(OPB[1]),
        .I3(OPA[{width_a-1}]),
        .I4(OPA[{width_a-1}]));
    """
        col_pointers[width_a] += 1
        RTL_str += f"""
    assign col{width_a+1}_wire{f"[{col_pointers[width_a+1]}]" if bitheap_list[width_a+1] > 1 else ""} = 1'b1;
    """
        col_pointers[width_a+1] += 1
    else:
        RTL_str += f"""
    assign col{width_a+1}_wire{f"[{col_pointers[width_a+1]}]" if bitheap_list[width_a+1] > 1 else ""} = 1'b1;
    """
        col_pointers[width_a+1] += 1
    # the rest of the rows
    for i in range(1, num_of_rows):
        RTL_str += f"""
    
    // the main part of row {i}"""
        for j in range(width_a+2):
            if j == 0:
                RTL_str += f"""
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row{i}_inst{j} (
        .O6(col{2*i+j+1}_wire{f"[{col_pointers[2*i+j+1]}]" if bitheap_list[2*i+j+1] > 1 else ""}),
        .O5(col{2*i+j}_wire{f"[{col_pointers[2*i+j]}]" if bitheap_list[2*i+j] > 1 else ""}),
        .I0({"1'b0" if i == 0 else f"OPB[{2*i-1}]"}),
        .I1(OPB[{2*i}]),
        .I2(OPB[{2*i+1}]),
        .I3(OPA[{j}]),
        .I4(OPA[{j+1}]),
        .I5(1'b1));
    """
                col_pointers[2*i+j] += 1
                col_pointers[2*i+j+1] += 1
            elif j == 1:
                pass
            elif j == width_a:
                RTL_str += f"""
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row{i}_inst{j} (
        .O (col{2*i+j}_wire{f"[{col_pointers[2*i+j]}]" if bitheap_list[2*i+j] > 1 else ""}),
        .I0({"1'b0" if i == 0 else f"OPB[{2*i-1}]"}),
        .I1(OPB[{2*i}]),
        .I2(OPB[{2*i+1}]),
        .I3(OPA[{width_a-1}]),
        .I4(OPA[{width_a-1}]));
    """
                col_pointers[2*i+j] += 1
            elif j == width_a + 1:
                RTL_str += f"""
    assign col{2*i+j}_wire{f"[{col_pointers[2*i+j]}]" if bitheap_list[2*i+j] > 1 else ""} = 1'b1;
    """
                col_pointers[2*i+j] += 1
            else:
                if j % 2 == 0:
                    RTL_str += f"""
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row{i}_inst{j} (
        .O (col{2*i+j}_wire{f"[{col_pointers[2*i+j]}]" if bitheap_list[2*i+j] > 1 else ""}),
        .I0({"1'b0" if i == 0 else f"OPB[{2*i-1}]"}),
        .I1(OPB[{2*i}]),
        .I2(OPB[{2*i+1}]),
        .I3(OPA[{j}]),
        .I4(OPA[{j-1}]));
    """
                else:
                    RTL_str += f"""
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row{i}_inst{j} (
        .O (col{2*i+j}_wire{f"[{col_pointers[2*i+j]}]" if bitheap_list[2*i+j] > 1 else ""}),
        .I0({"1'b0" if i == 0 else f"OPB[{2*i-1}]"}),
        .I1(OPB[{2*i}]),
        .I2(OPB[{2*i+1}]),
        .I3(OPA[{j-1}]),
        .I4(OPA[{j}]));
    """
                col_pointers[2*i+j] += 1

    # generate PART2: the rest, 1'b1 at column width_a and OPB[2*i+1] at column 2*i
    for i in range(num_of_rows):
        RTL_str += f"""
    assign col{2*i}_wire{f"[{col_pointers[2*i]}]" if bitheap_list[2*i] > 1 else ""} = OPB[{2*i+1}];"""
        col_pointers[2*i] += 1

    RTL_str += f"""
    assign col{width_a}_wire{f"[{col_pointers[width_a]}]" if bitheap_list[width_a] > 1 else ""} = 1'b1;
    """
    col_pointers[width_a] += 1

    # connect internial signal to the outputs
    if out_reg:
        RTL_str += f"""
    always_ff @(posedge clk) begin
    """
        for i in range(len(bitheap_list)):
            RTL_str += f"""    col{i} <= col{i}_wire;
    """
        RTL_str += f"""end
    """
    else:
        for i in range(len(bitheap_list)):
            RTL_str += f"""
    assign col{i} = col{i}_wire;"""

    RTL_str += f"""
endmodule"""

    # generate module .sv file
    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join(folder, f"{file_name}.sv")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(RTL_str)

    # generate the constraint files
    xdc_str = ""
    for i in range(1, num_of_rows):
        for j in range(2, width_a, 2):
            xdc_str += f"""
set pp_row{i}_i{j} [get_cells -hier -filter {{NAME =~ "*/LUT5_row{i}_inst{j}"}}]
set pp_row{i}_i{j+1} [get_cells -hier -filter {{NAME =~ "*/LUT5_row{i}_inst{j+1}"}}]
set_property LUTNM grp{j//2}_row{i} $pp_row{i}_i{j}
set_property LUTNM grp{j//2}_row{i} $pp_row{i}_i{j+1}
# set_property LOCK_PINS {{I0:A1 I1:A2 I2:A3 I3:A4 I4:A5}} $pp_row{i}_i{j}
# set_property LOCK_PINS {{I0:A1 I1:A2 I2:A3 I3:A4 I4:A6}} $pp_row{i}_i{j+1}

"""
    folder = "xdc_generated"
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join(folder, f"{file_name}.xdc")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(xdc_str)


def gen_Bmult_testvectors(width_a: int, width_b: int, test_size: int) -> None:
    A_ts = []
    B_ts = []
    P_ts = []
    for i in range(test_size):
        A = randint(-2**(width_a-1), 2**(width_a-1)-1)
        B = randint(-2**(width_b-1), 2**(width_b-1)-1)
        P = A * B
        A_ts.append(A)
        B_ts.append(B)
        P_ts.append(P)
    folder = "testvectors"
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join(folder, "A.txt")
    with open(file_path, "w", encoding="utf-8") as f:
        for v in A_ts:
            f.write(to_twos_complement_hex(v, width_a) + "\n")
    file_path = os.path.join(folder, "B.txt")
    with open(file_path, "w", encoding="utf-8") as f:
        for v in B_ts:
            f.write(to_twos_complement_hex(v, width_b) + "\n")
    file_path = os.path.join(folder, "P.txt")
    with open(file_path, "w", encoding="utf-8") as f:
        for v in P_ts:
            f.write(to_twos_complement_hex(v, width_a + width_b) + "\n")


def Bmult_RTL_gen(width_a: int, width_b: int, pipeline_stages: int, gen_testbenches: bool, test_size: int) -> None:
    """Generate a complete radix-4 Booth tree multiplier.

    Produces three SystemVerilog modules:
      - bitheap_gen: partial product generation via modified Booth recoding
      - bitheap_cmp: compressor tree to sum partial products
      - top-level wrapper: connects gen → cmp

    Minimum operand size: 6 bits. Both operands are treated as signed
    (two's complement). Output files are written to RTL_generated/ and
    xdc_generated/ directories.
    """

    ### First, extend two bit operands to even bits and take the one of more bits to recode
    if width_a % 2 == 0:
        OPA_width = width_a
        A_extend_flag = False
    else:
        OPA_width = width_a + 1
        A_extend_flag = True
    if width_b % 2 == 0:
        OPB_width = width_b
        B_extend_flag = False
    else:
        OPB_width = width_b + 1
        B_extend_flag = True
    if OPB_width < OPA_width:
        OPB_width = OPA_width
        B_extend_flag = A_extend_flag
        OPA_width = width_b
        switch_flag = True
    else:
        OPA_width = width_a
        switch_flag = False

    ### generate the list describing the bit heap
    bitheap_list = [0] * (OPA_width + OPB_width)
    num_rows = OPB_width // 2
    for i in range(num_rows):
        for j in range(OPA_width+2):
            bitheap_list[2*i+j] += 1
        bitheap_list[2*i] += 1
    bitheap_list[OPA_width] += 1

    ### build the bitheap descriptor with signal metadata
    # Each column's bits come from the bitheap_gen output port col{k}
    # bit_idx tracks the position within each column signal
    bitheap_desc = []
    for col_idx in range(len(bitheap_list)):
        n = bitheap_list[col_idx]
        if n == 0:
            continue
        entry = [col_idx]
        for bit_idx in range(n):
            entry.append((f"col{col_idx}", bit_idx if n > 1 else None))
        bitheap_desc.append(entry)

    ### generate reg_flag_list according to specified pipeline stages
    ### first, the number of layers should be obtained
    number_of_columns = len(bitheap_list)
    sum_max = 0
    for col in range(number_of_columns):
        sum_max += bitheap_list[col]*(2**col)
    width_bh = sum_max.bit_length()
    bh_layer_cal = BitHeap(width_bh, 0)
    for col in range(number_of_columns):
        bh_layer_cal.add_bits(col, bitheap_list[col])
    last_compression_layer_bitheap, raw_counter_list = compressAll(bh_layer_cal, 0, width_bh-1, False, False)
    counter_list = formGPCChain(raw_counter_list)
    number_of_layers = len(counter_list)
    if number_of_layers >= 2:
        merge_flag_temp, reduced_inputs = merge_last_stage(last_compression_layer_counter_list=counter_list[-1],
                                                           last_compression_layer_bitheap=last_compression_layer_bitheap)
    else:
        merge_flag_temp = False
    if merge_flag_temp:
        number_of_layers -= 1
    number_of_layers += 2
    reg_flag_list = reg_flag_list_gen(pipeline_stages=pipeline_stages,
                                      num_layers=number_of_layers)

    ### generate the RTL and XDC for partial product bit heap generation
    Bmult_bitheap_RTL_gen(width_a=OPA_width,
                          width_b=OPB_width,
                          bitheap_list=bitheap_list,
                          out_reg=reg_flag_list[0],
                          file_name=f"Bmult{width_a}x{width_b}_bitheap_gen")

    ### generate the RTL and XDC compressor for bit heap compression
    with open("bitheap.txt", "w", encoding="utf-8") as f:
        for val in bitheap_list:
            f.write(f"{val}\n")
    comp_reg_flag_list = reg_flag_list[1:]
    compressor_RTL_gen(txt_file_name="bitheap.txt",
                       sv_file_name=f"Bmult{width_a}x{width_b}_bitheap_cmp",
                       compressor_module_name=f"Bmult{width_a}x{width_b}_bitheap_cmp",
                       visualization=True,
                       tb_out_width=(OPA_width+OPB_width),
                       gen_testbench=gen_testbenches,
                       test_size=test_size,
                       reg_flag_list=comp_reg_flag_list,
                       bitheap_desc=bitheap_desc)

    ### generate the top-level RTL for the multiplier
    left_vals = [0, width_a-1, width_b-1, width_a+width_b-1]
    left_w = max(len(str(v)) for v in left_vals)
    width_exprs = []
    width_expr_lens = []
    for val in left_vals:
        width_exprs.append(width_expr(val, left_w))
        width_expr_lens.append(len(width_expr(val, left_w)))
    w = max(width_expr_lens)
    RTL_str = f"""`timescale 1ns / 1ps

module Bmult{width_a}x{width_b} (
    input  logic {width_exprs[0]:<{w}} clk,
    input  logic {width_exprs[1]:<{w}} A,
    input  logic {width_exprs[2]:<{w}} B,
    output logic {width_exprs[3]:<{w}} P
    );
    """
    left_vals = [OPA_width-1, OPB_width-1]
    for val in bitheap_list:
        left_vals.append(val-1)
    left_vals.append(OPA_width+OPB_width)
    left_w = max(len(str(v)) for v in left_vals)
    width_exprs = []
    width_expr_lens = []
    for val in left_vals:
        width_exprs.append(width_expr(val, left_w))
        width_expr_lens.append(len(width_expr(val, left_w)))
    w = max(width_expr_lens)
    RTL_str += f"""
    logic {width_exprs[0]:<{w}} OPA;
    logic {width_exprs[1]:<{w}} OPB;
    """
    for i in range(2, len(width_exprs)-1):
        RTL_str += f"""logic {width_exprs[i]:<{w}} col{i-2};
    """
    RTL_str += f"""logic {width_exprs[-1]:<{w}} comp_out;
    """
    # connect module inputs with instance inputs
    if switch_flag:
        RTL_str += f"""
    assign OPA = B;"""
        if B_extend_flag:
            RTL_str += f"""
    assign OPB = {{A[{width_a-1}], A}};
    """
        else:
            RTL_str += f"""
    assign OPB = A;
    """
    else:
        RTL_str += f"""
    assign OPA = A;"""
        if B_extend_flag:
            RTL_str += f"""
    assign OPB = {{B[{width_b-1}], B}};
    """
        else:
            RTL_str += f"""
    assign OPB = B;
    """

    # instantiate the bit heap generation module
    RTL_str += f"""
    Bmult{width_a}x{width_b}_bitheap_gen Bmult{width_a}x{width_b}_bitheap_gen_inst (
        .clk(clk),
        .OPA(OPA),
        .OPB(OPB)"""
    for i in range(len(bitheap_list)):
        RTL_str += f""",
        .col{i}(col{i})"""
    RTL_str += f""");
    """

    # instantiate the compressor tree module
    # port names come from bitheap_desc (col{i} instead of in_col{i})
    RTL_str += f"""
    Bmult{width_a}x{width_b}_bitheap_cmp Bmult{width_a}x{width_b}_bitheap_cmp_inst(
        .clk(clk)"""
    for i in range(len(bitheap_list)):
        RTL_str += f""",
        .col{i}(col{i})"""
    RTL_str += f""",
        .comp_out(comp_out));
    """

    # connect the instance outputs to module outputs
    RTL_str += f"""
    assign P = comp_out[{width_a+width_b-1}:0];

endmodule
"""

    # write into .sv file
    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join(folder, f"Bmult{width_a}x{width_b}.sv")
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(RTL_str)

    ### generate testbench and testvectors if required
    if gen_testbenches:
        left_vals = [width_a-1, width_b-1, width_a+width_b-1]
        left_w = max(len(str(v)) for v in left_vals)
        width_exprs = []
        width_expr_lens = []
        for val in left_vals:
            width_exprs.append(width_expr(val, left_w))
            width_expr_lens.append(len(width_expr(val, left_w)))
        w = max(width_expr_lens)
        tb_str = f"""`timescale 1ns / 1ps

module Bmult{width_a}x{width_b}_tb ();
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
    logic {width_exprs[0]:<{w}} A;
    logic {width_exprs[1]:<{w}} B;
    logic {width_exprs[2]:<{w}} P;
    logic {width_exprs[0]:<{w}} A_ts[`TS_SIZE-1 : 0];
    logic {width_exprs[1]:<{w}} B_ts[`TS_SIZE-1 : 0];
    logic {width_exprs[2]:<{w}} P_ts[`TS_SIZE-1 : 0];

    // ============================== read testvector values ==============================
    initial begin
        $readmemh("../../../../../testvectors/A.txt", A_ts);
        $readmemh("../../../../../testvectors/B.txt", B_ts);
        $readmemh("../../../../../testvectors/P.txt", P_ts);
    end
    
    // ============================== instantiate DUT and connect its ports ==============================
    Bmult{width_a}x{width_b} DUT (
        .clk(clk),
        .A  (A  ),
        .B  (B  ),
        .P  (P  ));
    
    // ============================== provide test input vectors ==============================
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            A = A_ts[i];
            B = B_ts[i];
            #`CLK_P;
        end
    end
    
    // ============================== check the correctness of output ==============================    
    int j;
    int correct_cnt;
    initial begin
        correct_cnt = 0;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*{pipeline_stages});
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            if (P == P_ts[j]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %b", P);
                $display("reference output: %b", P_ts[j]);
                $display("difference:       %b", P_ts[j] - P);
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

endmodule
    """
        # write the testbench into .sv files
        folder = "RTL_generated"
        os.makedirs(folder, exist_ok=True)
        file_path = os.path.join(folder, f"Bmult{width_a}x{width_b}_tb.sv")
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(tb_str)
        gen_Bmult_testvectors(width_a=width_a, width_b=width_b, test_size=test_size)




