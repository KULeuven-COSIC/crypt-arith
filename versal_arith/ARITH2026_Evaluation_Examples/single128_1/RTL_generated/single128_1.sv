`timescale 1ns / 1ps

module Comp_single128_1 (
    input  logic           clk,
    input  logic [127 : 0] in_col0,
    output logic [7   : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [127 : 0] layer0_col0;
    
    logic [8 : 0] C0_c9_41_l0_f0;
    logic         CLA_c9_41_l0_f0;
    logic         O0_c9_41_l0_f0;
    logic [3 : 0] O1_c9_41_l0_f0;
    logic [1 : 0] CY_c9_41_l0_f0;
    logic [1 : 0] PROP_c9_41_l0_f0;
    
    logic [8 : 0] C0_c9_41_l0_f1;
    logic         CLA_c9_41_l0_f1;
    logic         O0_c9_41_l0_f1;
    logic [3 : 0] O1_c9_41_l0_f1;
    logic [1 : 0] CY_c9_41_l0_f1;
    logic [1 : 0] PROP_c9_41_l0_f1;
    
    logic [8 : 0] C0_c9_41_l0_f2;
    logic         CLA_c9_41_l0_f2;
    logic         O0_c9_41_l0_f2;
    logic [3 : 0] O1_c9_41_l0_f2;
    logic [1 : 0] CY_c9_41_l0_f2;
    logic [1 : 0] PROP_c9_41_l0_f2;
    
    logic [8 : 0] C0_c9_41_l0_f3;
    logic         CLA_c9_41_l0_f3;
    logic         O0_c9_41_l0_f3;
    logic [3 : 0] O1_c9_41_l0_f3;
    logic [1 : 0] CY_c9_41_l0_f3;
    logic [1 : 0] PROP_c9_41_l0_f3;
    
    logic [8 : 0] C0_c9_41_l0_f4;
    logic         CLA_c9_41_l0_f4;
    logic         O0_c9_41_l0_f4;
    logic [3 : 0] O1_c9_41_l0_f4;
    logic [1 : 0] CY_c9_41_l0_f4;
    logic [1 : 0] PROP_c9_41_l0_f4;
    
    logic [8 : 0] C0_c9_41_l0_f5;
    logic         CLA_c9_41_l0_f5;
    logic         O0_c9_41_l0_f5;
    logic [3 : 0] O1_c9_41_l0_f5;
    logic [1 : 0] CY_c9_41_l0_f5;
    logic [1 : 0] PROP_c9_41_l0_f5;
    
    logic [7  : 0] COUT_LA_l0_floating_placement;
    logic [1  : 0] CIN_LA_l0_floating_placement;
    logic [15 : 0] CY_LA_l0_floating_placement;
    logic [15 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
    logic [79 : 0] layer1_col0;
    logic [23 : 0] layer1_col1;
    
    logic [16 : 0] C0_c517_451_l1_f0;
    logic [4  : 0] C1_c517_451_l1_f0;
    logic [1  : 0] CLA_c517_451_l1_f0;
    logic          O0_c517_451_l1_f0;
    logic [4  : 0] O1_c517_451_l1_f0;
    logic [3  : 0] O2_c517_451_l1_f0;
    logic [3  : 0] CY0_c517_451_l1_f0;
    logic [3  : 0] PROP0_c517_451_l1_f0;
    logic [3  : 0] CY1_c517_451_l1_f0;
    logic [3  : 0] PROP1_c517_451_l1_f0;
    
    logic [3 : 0] COUT_LA_l1_f0;
    logic         CIN_LA_l1_f0;
    logic [7 : 0] CY_LA_l1_f0;
    logic [7 : 0] PROP_LA_l1_f0;
    
    logic [8 : 0] C0_c9_41_l1_f1;
    logic         CLA_c9_41_l1_f1;
    logic         O0_c9_41_l1_f1;
    logic [3 : 0] O1_c9_41_l1_f1;
    logic [1 : 0] CY_c9_41_l1_f1;
    logic [1 : 0] PROP_c9_41_l1_f1;
    
    logic [16 : 0] C0_c517_451_l1_f2;
    logic [4  : 0] C1_c517_451_l1_f2;
    logic [1  : 0] CLA_c517_451_l1_f2;
    logic          O0_c517_451_l1_f2;
    logic [4  : 0] O1_c517_451_l1_f2;
    logic [3  : 0] O2_c517_451_l1_f2;
    logic [3  : 0] CY0_c517_451_l1_f2;
    logic [3  : 0] PROP0_c517_451_l1_f2;
    logic [3  : 0] CY1_c517_451_l1_f2;
    logic [3  : 0] PROP1_c517_451_l1_f2;
    
    logic [3 : 0] COUT_LA_l1_f2;
    logic         CIN_LA_l1_f2;
    logic [7 : 0] CY_LA_l1_f2;
    logic [7 : 0] PROP_LA_l1_f2;
    
    logic [16 : 0] C0_c517_451_l1_f3;
    logic [4  : 0] C1_c517_451_l1_f3;
    logic [1  : 0] CLA_c517_451_l1_f3;
    logic          O0_c517_451_l1_f3;
    logic [4  : 0] O1_c517_451_l1_f3;
    logic [3  : 0] O2_c517_451_l1_f3;
    logic [3  : 0] CY0_c517_451_l1_f3;
    logic [3  : 0] PROP0_c517_451_l1_f3;
    logic [3  : 0] CY1_c517_451_l1_f3;
    logic [3  : 0] PROP1_c517_451_l1_f3;
    
    logic [3 : 0] COUT_LA_l1_f3;
    logic         CIN_LA_l1_f3;
    logic [7 : 0] CY_LA_l1_f3;
    logic [7 : 0] PROP_LA_l1_f3;
    
    logic [3 : 0] COUT_LA_l1_floating_placement;
    logic         CIN_LA_l1_floating_placement;
    logic [7 : 0] CY_LA_l1_floating_placement;
    logic [7 : 0] PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [31 : 0] layer2_col0;
    logic [15 : 0] layer2_col1;
    logic [15 : 0] layer2_col2;
    
    logic [16 : 0] C0_c517_451_l2_f0;
    logic [4  : 0] C1_c517_451_l2_f0;
    logic [1  : 0] CLA_c517_451_l2_f0;
    logic          O0_c517_451_l2_f0;
    logic [4  : 0] O1_c517_451_l2_f0;
    logic [3  : 0] O2_c517_451_l2_f0;
    logic [3  : 0] CY0_c517_451_l2_f0;
    logic [3  : 0] PROP0_c517_451_l2_f0;
    logic [3  : 0] CY1_c517_451_l2_f0;
    logic [3  : 0] PROP1_c517_451_l2_f0;
    
    logic [3 : 0] COUT_LA_l2_f0;
    logic         CIN_LA_l2_f0;
    logic [7 : 0] CY_LA_l2_f0;
    logic [7 : 0] PROP_LA_l2_f0;
    
    logic [8 : 0] C0_c39_231_l2_f1;
    logic [2 : 0] C1_c39_231_l2_f1;
    logic         CLA_c39_231_l2_f1;
    logic         O0_c39_231_l2_f1;
    logic [2 : 0] O1_c39_231_l2_f1;
    logic [1 : 0] O2_c39_231_l2_f1;
    logic [1 : 0] CY0_c39_231_l2_f1;
    logic [1 : 0] CY1_c39_231_l2_f1;
    logic [1 : 0] PROP0_c39_231_l2_f1;
    logic [1 : 0] PROP1_c39_231_l2_f1;
    
    logic [3 : 0] COUT_LA_l2_c0_s0;
    logic         CIN_LA_l2_c0_s0;
    logic [7 : 0] CY_LA_l2_c0_s0;
    logic [7 : 0] PROP_LA_l2_c0_s0;
    
    logic [4 : 0] C0_c15_3_l2_c0_i0;
    logic         C1_c15_3_l2_c0_i0;
    logic         CLA_c15_3_l2_c0_i0;
    logic [2 : 0] O_c15_3_l2_c0_i0;
    logic [1 : 0] CY_c15_3_l2_c0_i0;
    logic [1 : 0] PROP_c15_3_l2_c0_i0;
    logic         l2_c0_i0;
    
    logic [8 : 0] C0_c9_41_l2_c0_i1;
    logic         CLA_c9_41_l2_c0_i1;
    logic         O0_c9_41_l2_c0_i1;
    logic [3 : 0] O1_c9_41_l2_c0_i1;
    logic [1 : 0] CY_c9_41_l2_c0_i1;
    logic [1 : 0] PROP_c9_41_l2_c0_i1;
    logic         l2_c0_i1;
    
    logic [4 : 0] C0_c15_3_l2_f2;
    logic         C1_c15_3_l2_f2;
    logic         CLA_c15_3_l2_f2;
    logic [2 : 0] O_c15_3_l2_f2;
    logic [1 : 0] CY_c15_3_l2_f2;
    logic [1 : 0] PROP_c15_3_l2_f2;
    
    logic [3 : 0] COUT_LA_l2_floating_placement;
    logic         CIN_LA_l2_floating_placement;
    logic [7 : 0] CY_LA_l2_floating_placement;
    logic [7 : 0] PROP_LA_l2_floating_placement;
    
    // ------------------------------ LAYER 3 ------------------------------
    logic [7  : 0] layer3_col0;
    logic [7  : 0] layer3_col1;
    logic [13 : 0] layer3_col2;
    logic [5  : 0] layer3_col3;
    
    logic [3 : 0] COUT_LA_l3_c0_s0;
    logic         CIN_LA_l3_c0_s0;
    logic [7 : 0] CY_LA_l3_c0_s0;
    logic [7 : 0] PROP_LA_l3_c0_s0;
    
    logic [4 : 0] C0_c15_3_l3_c0_i0;
    logic         C1_c15_3_l3_c0_i0;
    logic         CLA_c15_3_l3_c0_i0;
    logic [2 : 0] O_c15_3_l3_c0_i0;
    logic [1 : 0] CY_c15_3_l3_c0_i0;
    logic [1 : 0] PROP_c15_3_l3_c0_i0;
    logic         l3_c0_i0;
    
    logic [8 : 0] C0_c39_231_l3_c0_i1;
    logic [2 : 0] C1_c39_231_l3_c0_i1;
    logic         CLA_c39_231_l3_c0_i1;
    logic         O0_c39_231_l3_c0_i1;
    logic [2 : 0] O1_c39_231_l3_c0_i1;
    logic [1 : 0] O2_c39_231_l3_c0_i1;
    logic [1 : 0] CY0_c39_231_l3_c0_i1;
    logic [1 : 0] CY1_c39_231_l3_c0_i1;
    logic [1 : 0] PROP0_c39_231_l3_c0_i1;
    logic [1 : 0] PROP1_c39_231_l3_c0_i1;
    logic         l3_c0_i1;
    
    logic [4 : 0] C0_c15_3_l3_f0;
    logic         C1_c15_3_l3_f0;
    logic         CLA_c15_3_l3_f0;
    logic [2 : 0] O_c15_3_l3_f0;
    logic [1 : 0] CY_c15_3_l3_f0;
    logic [1 : 0] PROP_c15_3_l3_f0;
    
    logic [4 : 0] C0_c15_3_l3_f1;
    logic         C1_c15_3_l3_f1;
    logic         CLA_c15_3_l3_f1;
    logic [2 : 0] O_c15_3_l3_f1;
    logic [1 : 0] CY_c15_3_l3_f1;
    logic [1 : 0] PROP_c15_3_l3_f1;
    
    logic [3 : 0] COUT_LA_l3_floating_placement;
    logic         CIN_LA_l3_floating_placement;
    logic [7 : 0] CY_LA_l3_floating_placement;
    logic [7 : 0] PROP_LA_l3_floating_placement;
    
    // ------------------------------ LAYER 4 ------------------------------
    logic [3  : 0] layer4_col0;
    logic [3  : 0] layer4_col1;
    logic [2  : 0] layer4_col2;
    logic [6  : 0] layer4_col3;
    logic [2  : 0] layer4_col4;
    
    logic [4 : 0] C0_c15_3_l4_f0;
    logic         C1_c15_3_l4_f0;
    logic         CLA_c15_3_l4_f0;
    logic [2 : 0] O_c15_3_l4_f0;
    logic [1 : 0] CY_c15_3_l4_f0;
    logic [1 : 0] PROP_c15_3_l4_f0;
    
    logic [3 : 0] COUT_LA_l4_floating_placement;
    logic         CIN_LA_l4_floating_placement;
    logic [7 : 0] CY_LA_l4_floating_placement;
    logic [7 : 0] PROP_LA_l4_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [3  : 0] layer5_col0;
    logic [3  : 0] layer5_col1;
    logic [2  : 0] layer5_col2;
    logic [2  : 0] layer5_col3;
    logic [2  : 0] layer5_col4;
    logic          layer5_col5;
    
    logic [6 : 0] terminal_chain1_out;
    
    logic [3 : 0] COUT_LA_terminal_chain1;
    logic         CIN_LA_terminal_chain1;
    logic [7 : 0] CY_LA_terminal_chain1;
    logic [7 : 0] PROP_LA_terminal_chain1;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i0;
    logic         C1_c15_3_terminal_chain1_i0;
    logic         CLA_c15_3_terminal_chain1_i0;
    logic [2 : 0] O_c15_3_terminal_chain1_i0;
    logic [1 : 0] CY_c15_3_terminal_chain1_i0;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i0;
    logic         terminal_chain1_i0;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i1;
    logic         C1_c15_3_terminal_chain1_i1;
    logic         CLA_c15_3_terminal_chain1_i1;
    logic [2 : 0] O_c15_3_terminal_chain1_i1;
    logic [1 : 0] CY_c15_3_terminal_chain1_i1;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i1;
    logic         terminal_chain1_i1;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i2;
    logic         C1_c15_3_terminal_chain1_i2;
    logic         CLA_c15_3_terminal_chain1_i2;
    logic [2 : 0] O_c15_3_terminal_chain1_i2;
    logic [1 : 0] CY_c15_3_terminal_chain1_i2;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i2;
    logic         terminal_chain1_i2;
    
    logic [6 : 0] terminal_chain2_out;
    
    logic [3 : 0] COUT_LA_terminal_chain2;
    logic         CIN_LA_terminal_chain2;
    logic [7 : 0] CY_LA_terminal_chain2;
    logic [7 : 0] PROP_LA_terminal_chain2;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i0;
    logic         C1_c15_3_terminal_chain2_i0;
    logic         CLA_c15_3_terminal_chain2_i0;
    logic [2 : 0] O_c15_3_terminal_chain2_i0;
    logic [1 : 0] CY_c15_3_terminal_chain2_i0;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i0;
    logic         terminal_chain2_i0;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i1;
    logic         C1_c15_3_terminal_chain2_i1;
    logic         CLA_c15_3_terminal_chain2_i1;
    logic [2 : 0] O_c15_3_terminal_chain2_i1;
    logic [1 : 0] CY_c15_3_terminal_chain2_i1;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i1;
    logic         terminal_chain2_i1;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i2;
    logic [1 : 0] O_c3_2_terminal_chain2_i2;
    logic         CY_c3_2_terminal_chain2_i2;
    logic         PROP_c3_2_terminal_chain2_i2;
    logic         terminal_chain2_i2;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i3;
    logic [1 : 0] O_c3_2_terminal_chain2_i3;
    logic         CY_c3_2_terminal_chain2_i3;
    logic         PROP_c3_2_terminal_chain2_i3;
    logic         terminal_chain2_i3;
    
    // ------------------------------ LAYER 0 ------------------------------
    // GPC0 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f0(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f0  ),
        .CLA (CLA_c9_41_l0_f0 ),
        .O0  (O0_c9_41_l0_f0  ),
        .O1  (O1_c9_41_l0_f0  ),
        .CY  (CY_c9_41_l0_f0  ),
        .PROP(PROP_c9_41_l0_f0));
    
    assign C0_c9_41_l0_f0 = layer0_col0[8:0];
    
    assign layer1_col0[0]   = O0_c9_41_l0_f0;
    assign layer1_col1[3:0] = O1_c9_41_l0_f0;
    
    // GPC1 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f1(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f1  ),
        .CLA (CLA_c9_41_l0_f1 ),
        .O0  (O0_c9_41_l0_f1  ),
        .O1  (O1_c9_41_l0_f1  ),
        .CY  (CY_c9_41_l0_f1  ),
        .PROP(PROP_c9_41_l0_f1));
    
    assign C0_c9_41_l0_f1 = layer0_col0[17:9];
    
    assign layer1_col0[1]   = O0_c9_41_l0_f1;
    assign layer1_col1[7:4] = O1_c9_41_l0_f1;
    
    // GPC2 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f2(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f2  ),
        .CLA (CLA_c9_41_l0_f2 ),
        .O0  (O0_c9_41_l0_f2  ),
        .O1  (O1_c9_41_l0_f2  ),
        .CY  (CY_c9_41_l0_f2  ),
        .PROP(PROP_c9_41_l0_f2));
    
    assign C0_c9_41_l0_f2 = layer0_col0[26:18];
    
    assign layer1_col0[2]    = O0_c9_41_l0_f2;
    assign layer1_col1[11:8] = O1_c9_41_l0_f2;
    
    // GPC3 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f3(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f3  ),
        .CLA (CLA_c9_41_l0_f3 ),
        .O0  (O0_c9_41_l0_f3  ),
        .O1  (O1_c9_41_l0_f3  ),
        .CY  (CY_c9_41_l0_f3  ),
        .PROP(PROP_c9_41_l0_f3));
    
    assign C0_c9_41_l0_f3 = layer0_col0[35:27];
    
    assign layer1_col0[3]     = O0_c9_41_l0_f3;
    assign layer1_col1[15:12] = O1_c9_41_l0_f3;
    
    // GPC4 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f4(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f4  ),
        .CLA (CLA_c9_41_l0_f4 ),
        .O0  (O0_c9_41_l0_f4  ),
        .O1  (O1_c9_41_l0_f4  ),
        .CY  (CY_c9_41_l0_f4  ),
        .PROP(PROP_c9_41_l0_f4));
    
    assign C0_c9_41_l0_f4 = layer0_col0[44:36];
    
    assign layer1_col0[4]     = O0_c9_41_l0_f4;
    assign layer1_col1[19:16] = O1_c9_41_l0_f4;
    
    // GPC5 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f5(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f5  ),
        .CLA (CLA_c9_41_l0_f5 ),
        .O0  (O0_c9_41_l0_f5  ),
        .O1  (O1_c9_41_l0_f5  ),
        .CY  (CY_c9_41_l0_f5  ),
        .PROP(PROP_c9_41_l0_f5));
    
    assign C0_c9_41_l0_f5 = layer0_col0[53:45];
    
    assign layer1_col0[5]     = O0_c9_41_l0_f5;
    assign layer1_col1[23:20] = O1_c9_41_l0_f5;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_floating_placement_inst0 (
        .COUTB(COUT_LA_l0_floating_placement[0]),
        .COUTD(COUT_LA_l0_floating_placement[1]),
        .COUTF(COUT_LA_l0_floating_placement[2]),
        .COUTH(COUT_LA_l0_floating_placement[3]),
        .CIN  (CIN_LA_l0_floating_placement[0] ),
        .CYA  (CY_LA_l0_floating_placement[0]  ),
        .CYB  (CY_LA_l0_floating_placement[1]  ),
        .CYC  (CY_LA_l0_floating_placement[2]  ),
        .CYD  (CY_LA_l0_floating_placement[3]  ),
        .CYE  (CY_LA_l0_floating_placement[4]  ),
        .CYF  (CY_LA_l0_floating_placement[5]  ),
        .CYG  (CY_LA_l0_floating_placement[6]  ),
        .CYH  (CY_LA_l0_floating_placement[7]  ),
        .PROPA(PROP_LA_l0_floating_placement[0]),
        .PROPB(PROP_LA_l0_floating_placement[1]),
        .PROPC(PROP_LA_l0_floating_placement[2]),
        .PROPD(PROP_LA_l0_floating_placement[3]),
        .PROPE(PROP_LA_l0_floating_placement[4]),
        .PROPF(PROP_LA_l0_floating_placement[5]),
        .PROPG(PROP_LA_l0_floating_placement[6]),
        .PROPH(PROP_LA_l0_floating_placement[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_floating_placement_inst1 (
        .COUTB(COUT_LA_l0_floating_placement[4] ),
        .COUTD(COUT_LA_l0_floating_placement[5] ),
        .COUTF(COUT_LA_l0_floating_placement[6] ),
        .COUTH(COUT_LA_l0_floating_placement[7] ),
        .CIN  (CIN_LA_l0_floating_placement[1]  ),
        .CYA  (CY_LA_l0_floating_placement[8]   ),
        .CYB  (CY_LA_l0_floating_placement[9]   ),
        .CYC  (CY_LA_l0_floating_placement[10]  ),
        .CYD  (CY_LA_l0_floating_placement[11]  ),
        .CYE  (CY_LA_l0_floating_placement[12]  ),
        .CYF  (CY_LA_l0_floating_placement[13]  ),
        .CYG  (CY_LA_l0_floating_placement[14]  ),
        .CYH  (CY_LA_l0_floating_placement[15]  ),
        .PROPA(PROP_LA_l0_floating_placement[8] ),
        .PROPB(PROP_LA_l0_floating_placement[9] ),
        .PROPC(PROP_LA_l0_floating_placement[10]),
        .PROPD(PROP_LA_l0_floating_placement[11]),
        .PROPE(PROP_LA_l0_floating_placement[12]),
        .PROPF(PROP_LA_l0_floating_placement[13]),
        .PROPG(PROP_LA_l0_floating_placement[14]),
        .PROPH(PROP_LA_l0_floating_placement[15]));

    assign CY_LA_l0_floating_placement[1:0]   = CY_c9_41_l0_f0;
    assign PROP_LA_l0_floating_placement[1:0] = PROP_c9_41_l0_f0;
    assign CIN_LA_l0_floating_placement[0] = C0_c9_41_l0_f0[8];
    
    assign CY_LA_l0_floating_placement[3:2]   = CY_c9_41_l0_f1;
    assign PROP_LA_l0_floating_placement[3:2] = PROP_c9_41_l0_f1;
    
    assign CY_LA_l0_floating_placement[5:4]   = CY_c9_41_l0_f2;
    assign PROP_LA_l0_floating_placement[5:4] = PROP_c9_41_l0_f2;
    
    assign CY_LA_l0_floating_placement[7:6]   = CY_c9_41_l0_f3;
    assign PROP_LA_l0_floating_placement[7:6] = PROP_c9_41_l0_f3;
    
    assign CY_LA_l0_floating_placement[9:8]   = CY_c9_41_l0_f4;
    assign PROP_LA_l0_floating_placement[9:8] = PROP_c9_41_l0_f4;
    assign CIN_LA_l0_floating_placement[1] = C0_c9_41_l0_f4[8];
    
    assign CY_LA_l0_floating_placement[11:10]   = CY_c9_41_l0_f5;
    assign PROP_LA_l0_floating_placement[11:10] = PROP_c9_41_l0_f5;
    
    assign layer1_col0[6] = layer0_col0[54];
    assign layer1_col0[7] = layer0_col0[55];
    assign layer1_col0[8] = layer0_col0[56];
    assign layer1_col0[9] = layer0_col0[57];
    assign layer1_col0[10] = layer0_col0[58];
    assign layer1_col0[11] = layer0_col0[59];
    assign layer1_col0[12] = layer0_col0[60];
    assign layer1_col0[13] = layer0_col0[61];
    assign layer1_col0[14] = layer0_col0[62];
    assign layer1_col0[15] = layer0_col0[63];
    assign layer1_col0[16] = layer0_col0[64];
    assign layer1_col0[17] = layer0_col0[65];
    assign layer1_col0[18] = layer0_col0[66];
    assign layer1_col0[19] = layer0_col0[67];
    assign layer1_col0[20] = layer0_col0[68];
    assign layer1_col0[21] = layer0_col0[69];
    assign layer1_col0[22] = layer0_col0[70];
    assign layer1_col0[23] = layer0_col0[71];
    assign layer1_col0[24] = layer0_col0[72];
    assign layer1_col0[25] = layer0_col0[73];
    assign layer1_col0[26] = layer0_col0[74];
    assign layer1_col0[27] = layer0_col0[75];
    assign layer1_col0[28] = layer0_col0[76];
    assign layer1_col0[29] = layer0_col0[77];
    assign layer1_col0[30] = layer0_col0[78];
    assign layer1_col0[31] = layer0_col0[79];
    assign layer1_col0[32] = layer0_col0[80];
    assign layer1_col0[33] = layer0_col0[81];
    assign layer1_col0[34] = layer0_col0[82];
    assign layer1_col0[35] = layer0_col0[83];
    assign layer1_col0[36] = layer0_col0[84];
    assign layer1_col0[37] = layer0_col0[85];
    assign layer1_col0[38] = layer0_col0[86];
    assign layer1_col0[39] = layer0_col0[87];
    assign layer1_col0[40] = layer0_col0[88];
    assign layer1_col0[41] = layer0_col0[89];
    assign layer1_col0[42] = layer0_col0[90];
    assign layer1_col0[43] = layer0_col0[91];
    assign layer1_col0[44] = layer0_col0[92];
    assign layer1_col0[45] = layer0_col0[93];
    assign layer1_col0[46] = layer0_col0[94];
    assign layer1_col0[47] = layer0_col0[95];
    assign layer1_col0[48] = layer0_col0[96];
    assign layer1_col0[49] = layer0_col0[97];
    assign layer1_col0[50] = layer0_col0[98];
    assign layer1_col0[51] = layer0_col0[99];
    assign layer1_col0[52] = layer0_col0[100];
    assign layer1_col0[53] = layer0_col0[101];
    assign layer1_col0[54] = layer0_col0[102];
    assign layer1_col0[55] = layer0_col0[103];
    assign layer1_col0[56] = layer0_col0[104];
    assign layer1_col0[57] = layer0_col0[105];
    assign layer1_col0[58] = layer0_col0[106];
    assign layer1_col0[59] = layer0_col0[107];
    assign layer1_col0[60] = layer0_col0[108];
    assign layer1_col0[61] = layer0_col0[109];
    assign layer1_col0[62] = layer0_col0[110];
    assign layer1_col0[63] = layer0_col0[111];
    assign layer1_col0[64] = layer0_col0[112];
    assign layer1_col0[65] = layer0_col0[113];
    assign layer1_col0[66] = layer0_col0[114];
    assign layer1_col0[67] = layer0_col0[115];
    assign layer1_col0[68] = layer0_col0[116];
    assign layer1_col0[69] = layer0_col0[117];
    assign layer1_col0[70] = layer0_col0[118];
    assign layer1_col0[71] = layer0_col0[119];
    assign layer1_col0[72] = layer0_col0[120];
    assign layer1_col0[73] = layer0_col0[121];
    assign layer1_col0[74] = layer0_col0[122];
    assign layer1_col0[75] = layer0_col0[123];
    assign layer1_col0[76] = layer0_col0[124];
    assign layer1_col0[77] = layer0_col0[125];
    assign layer1_col0[78] = layer0_col0[126];
    assign layer1_col0[79] = layer0_col0[127];
    // ------------------------------ LAYER 1 ------------------------------
    // GPC0 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f0(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f0   ),
        .C1   (C1_c517_451_l1_f0   ),
        .CLA  (CLA_c517_451_l1_f0  ),
        .O0   (O0_c517_451_l1_f0   ),
        .O1   (O1_c517_451_l1_f0   ),
        .O2   (O2_c517_451_l1_f0   ),
        .CY0  (CY0_c517_451_l1_f0  ),
        .PROP0(PROP0_c517_451_l1_f0),
        .CY1  (CY1_c517_451_l1_f0  ),
        .PROP1(PROP1_c517_451_l1_f0));
    
    assign C0_c517_451_l1_f0 = layer1_col0[16:0];
    assign C1_c517_451_l1_f0 = layer1_col1[4:0];
    
    assign layer2_col0[0]   = O0_c517_451_l1_f0;
    assign layer2_col1[4:0] = O1_c517_451_l1_f0;
    assign layer2_col2[3:0] = O2_c517_451_l1_f0;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f0_inst0 (
        .COUTB(COUT_LA_l1_f0[0]),
        .COUTD(COUT_LA_l1_f0[1]),
        .COUTF(COUT_LA_l1_f0[2]),
        .COUTH(COUT_LA_l1_f0[3]),
        .CIN  (CIN_LA_l1_f0    ),
        .CYA  (CY_LA_l1_f0[0]  ),
        .CYB  (CY_LA_l1_f0[1]  ),
        .CYC  (CY_LA_l1_f0[2]  ),
        .CYD  (CY_LA_l1_f0[3]  ),
        .CYE  (CY_LA_l1_f0[4]  ),
        .CYF  (CY_LA_l1_f0[5]  ),
        .CYG  (CY_LA_l1_f0[6]  ),
        .CYH  (CY_LA_l1_f0[7]  ),
        .PROPA(PROP_LA_l1_f0[0]),
        .PROPB(PROP_LA_l1_f0[1]),
        .PROPC(PROP_LA_l1_f0[2]),
        .PROPD(PROP_LA_l1_f0[3]),
        .PROPE(PROP_LA_l1_f0[4]),
        .PROPF(PROP_LA_l1_f0[5]),
        .PROPG(PROP_LA_l1_f0[6]),
        .PROPH(PROP_LA_l1_f0[7]));

    assign CLA_c517_451_l1_f0[0] = COUT_LA_l1_f0[0];
    assign CLA_c517_451_l1_f0[1] = COUT_LA_l1_f0[2];
    assign CIN_LA_l1_f0          = C0_c517_451_l1_f0[8];
    assign CY_LA_l1_f0[3:0]      = CY0_c517_451_l1_f0;
    assign CY_LA_l1_f0[7:4]      = CY1_c517_451_l1_f0;
    assign PROP_LA_l1_f0[3:0]    = PROP0_c517_451_l1_f0;
    assign PROP_LA_l1_f0[7:4]    = PROP1_c517_451_l1_f0;
    
    // GPC1 in layer1: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f1(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f1  ),
        .CLA (CLA_c9_41_l1_f1 ),
        .O0  (O0_c9_41_l1_f1  ),
        .O1  (O1_c9_41_l1_f1  ),
        .CY  (CY_c9_41_l1_f1  ),
        .PROP(PROP_c9_41_l1_f1));
    
    assign C0_c9_41_l1_f1 = layer1_col1[13:5];
    
    assign layer2_col1[5]   = O0_c9_41_l1_f1;
    assign layer2_col2[7:4] = O1_c9_41_l1_f1;
    
    // GPC2 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f2(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f2   ),
        .C1   (C1_c517_451_l1_f2   ),
        .CLA  (CLA_c517_451_l1_f2  ),
        .O0   (O0_c517_451_l1_f2   ),
        .O1   (O1_c517_451_l1_f2   ),
        .O2   (O2_c517_451_l1_f2   ),
        .CY0  (CY0_c517_451_l1_f2  ),
        .PROP0(PROP0_c517_451_l1_f2),
        .CY1  (CY1_c517_451_l1_f2  ),
        .PROP1(PROP1_c517_451_l1_f2));
    
    assign C0_c517_451_l1_f2 = layer1_col0[33:17];
    assign C1_c517_451_l1_f2 = layer1_col1[18:14];
    
    assign layer2_col0[1]    = O0_c517_451_l1_f2;
    assign layer2_col1[10:6] = O1_c517_451_l1_f2;
    assign layer2_col2[11:8] = O2_c517_451_l1_f2;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f2_inst0 (
        .COUTB(COUT_LA_l1_f2[0]),
        .COUTD(COUT_LA_l1_f2[1]),
        .COUTF(COUT_LA_l1_f2[2]),
        .COUTH(COUT_LA_l1_f2[3]),
        .CIN  (CIN_LA_l1_f2    ),
        .CYA  (CY_LA_l1_f2[0]  ),
        .CYB  (CY_LA_l1_f2[1]  ),
        .CYC  (CY_LA_l1_f2[2]  ),
        .CYD  (CY_LA_l1_f2[3]  ),
        .CYE  (CY_LA_l1_f2[4]  ),
        .CYF  (CY_LA_l1_f2[5]  ),
        .CYG  (CY_LA_l1_f2[6]  ),
        .CYH  (CY_LA_l1_f2[7]  ),
        .PROPA(PROP_LA_l1_f2[0]),
        .PROPB(PROP_LA_l1_f2[1]),
        .PROPC(PROP_LA_l1_f2[2]),
        .PROPD(PROP_LA_l1_f2[3]),
        .PROPE(PROP_LA_l1_f2[4]),
        .PROPF(PROP_LA_l1_f2[5]),
        .PROPG(PROP_LA_l1_f2[6]),
        .PROPH(PROP_LA_l1_f2[7]));

    assign CLA_c517_451_l1_f2[0] = COUT_LA_l1_f2[0];
    assign CLA_c517_451_l1_f2[1] = COUT_LA_l1_f2[2];
    assign CIN_LA_l1_f2          = C0_c517_451_l1_f2[8];
    assign CY_LA_l1_f2[3:0]      = CY0_c517_451_l1_f2;
    assign CY_LA_l1_f2[7:4]      = CY1_c517_451_l1_f2;
    assign PROP_LA_l1_f2[3:0]    = PROP0_c517_451_l1_f2;
    assign PROP_LA_l1_f2[7:4]    = PROP1_c517_451_l1_f2;
    
    // GPC3 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f3(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f3   ),
        .C1   (C1_c517_451_l1_f3   ),
        .CLA  (CLA_c517_451_l1_f3  ),
        .O0   (O0_c517_451_l1_f3   ),
        .O1   (O1_c517_451_l1_f3   ),
        .O2   (O2_c517_451_l1_f3   ),
        .CY0  (CY0_c517_451_l1_f3  ),
        .PROP0(PROP0_c517_451_l1_f3),
        .CY1  (CY1_c517_451_l1_f3  ),
        .PROP1(PROP1_c517_451_l1_f3));
    
    assign C0_c517_451_l1_f3 = layer1_col0[50:34];
    assign C1_c517_451_l1_f3 = layer1_col1[23:19];
    
    assign layer2_col0[2]     = O0_c517_451_l1_f3;
    assign layer2_col1[15:11] = O1_c517_451_l1_f3;
    assign layer2_col2[15:12] = O2_c517_451_l1_f3;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f3_inst0 (
        .COUTB(COUT_LA_l1_f3[0]),
        .COUTD(COUT_LA_l1_f3[1]),
        .COUTF(COUT_LA_l1_f3[2]),
        .COUTH(COUT_LA_l1_f3[3]),
        .CIN  (CIN_LA_l1_f3    ),
        .CYA  (CY_LA_l1_f3[0]  ),
        .CYB  (CY_LA_l1_f3[1]  ),
        .CYC  (CY_LA_l1_f3[2]  ),
        .CYD  (CY_LA_l1_f3[3]  ),
        .CYE  (CY_LA_l1_f3[4]  ),
        .CYF  (CY_LA_l1_f3[5]  ),
        .CYG  (CY_LA_l1_f3[6]  ),
        .CYH  (CY_LA_l1_f3[7]  ),
        .PROPA(PROP_LA_l1_f3[0]),
        .PROPB(PROP_LA_l1_f3[1]),
        .PROPC(PROP_LA_l1_f3[2]),
        .PROPD(PROP_LA_l1_f3[3]),
        .PROPE(PROP_LA_l1_f3[4]),
        .PROPF(PROP_LA_l1_f3[5]),
        .PROPG(PROP_LA_l1_f3[6]),
        .PROPH(PROP_LA_l1_f3[7]));

    assign CLA_c517_451_l1_f3[0] = COUT_LA_l1_f3[0];
    assign CLA_c517_451_l1_f3[1] = COUT_LA_l1_f3[2];
    assign CIN_LA_l1_f3          = C0_c517_451_l1_f3[8];
    assign CY_LA_l1_f3[3:0]      = CY0_c517_451_l1_f3;
    assign CY_LA_l1_f3[7:4]      = CY1_c517_451_l1_f3;
    assign PROP_LA_l1_f3[3:0]    = PROP0_c517_451_l1_f3;
    assign PROP_LA_l1_f3[7:4]    = PROP1_c517_451_l1_f3;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_floating_placement_inst0 (
        .COUTB(COUT_LA_l1_floating_placement[0]),
        .COUTD(COUT_LA_l1_floating_placement[1]),
        .COUTF(COUT_LA_l1_floating_placement[2]),
        .COUTH(COUT_LA_l1_floating_placement[3]),
        .CIN  (CIN_LA_l1_floating_placement    ),
        .CYA  (CY_LA_l1_floating_placement[0]  ),
        .CYB  (CY_LA_l1_floating_placement[1]  ),
        .CYC  (CY_LA_l1_floating_placement[2]  ),
        .CYD  (CY_LA_l1_floating_placement[3]  ),
        .CYE  (CY_LA_l1_floating_placement[4]  ),
        .CYF  (CY_LA_l1_floating_placement[5]  ),
        .CYG  (CY_LA_l1_floating_placement[6]  ),
        .CYH  (CY_LA_l1_floating_placement[7]  ),
        .PROPA(PROP_LA_l1_floating_placement[0]),
        .PROPB(PROP_LA_l1_floating_placement[1]),
        .PROPC(PROP_LA_l1_floating_placement[2]),
        .PROPD(PROP_LA_l1_floating_placement[3]),
        .PROPE(PROP_LA_l1_floating_placement[4]),
        .PROPF(PROP_LA_l1_floating_placement[5]),
        .PROPG(PROP_LA_l1_floating_placement[6]),
        .PROPH(PROP_LA_l1_floating_placement[7]));

    assign CY_LA_l1_floating_placement[1:0]   = CY_c9_41_l1_f1;
    assign PROP_LA_l1_floating_placement[1:0] = PROP_c9_41_l1_f1;
    assign CIN_LA_l1_floating_placement    = C0_c9_41_l1_f1[8];
    
    assign layer2_col0[3] = layer1_col0[51];
    assign layer2_col0[4] = layer1_col0[52];
    assign layer2_col0[5] = layer1_col0[53];
    assign layer2_col0[6] = layer1_col0[54];
    assign layer2_col0[7] = layer1_col0[55];
    assign layer2_col0[8] = layer1_col0[56];
    assign layer2_col0[9] = layer1_col0[57];
    assign layer2_col0[10] = layer1_col0[58];
    assign layer2_col0[11] = layer1_col0[59];
    assign layer2_col0[12] = layer1_col0[60];
    assign layer2_col0[13] = layer1_col0[61];
    assign layer2_col0[14] = layer1_col0[62];
    assign layer2_col0[15] = layer1_col0[63];
    assign layer2_col0[16] = layer1_col0[64];
    assign layer2_col0[17] = layer1_col0[65];
    assign layer2_col0[18] = layer1_col0[66];
    assign layer2_col0[19] = layer1_col0[67];
    assign layer2_col0[20] = layer1_col0[68];
    assign layer2_col0[21] = layer1_col0[69];
    assign layer2_col0[22] = layer1_col0[70];
    assign layer2_col0[23] = layer1_col0[71];
    assign layer2_col0[24] = layer1_col0[72];
    assign layer2_col0[25] = layer1_col0[73];
    assign layer2_col0[26] = layer1_col0[74];
    assign layer2_col0[27] = layer1_col0[75];
    assign layer2_col0[28] = layer1_col0[76];
    assign layer2_col0[29] = layer1_col0[77];
    assign layer2_col0[30] = layer1_col0[78];
    assign layer2_col0[31] = layer1_col0[79];
    // ------------------------------ LAYER 2 ------------------------------
    // GPC0 in layer2: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f0(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f0   ),
        .C1   (C1_c517_451_l2_f0   ),
        .CLA  (CLA_c517_451_l2_f0  ),
        .O0   (O0_c517_451_l2_f0   ),
        .O1   (O1_c517_451_l2_f0   ),
        .O2   (O2_c517_451_l2_f0   ),
        .CY0  (CY0_c517_451_l2_f0  ),
        .PROP0(PROP0_c517_451_l2_f0),
        .CY1  (CY1_c517_451_l2_f0  ),
        .PROP1(PROP1_c517_451_l2_f0));
    
    assign C0_c517_451_l2_f0 = layer2_col0[16:0];
    assign C1_c517_451_l2_f0 = layer2_col1[4:0];
    
    assign layer3_col0[0]   = O0_c517_451_l2_f0;
    assign layer3_col1[4:0] = O1_c517_451_l2_f0;
    assign layer3_col2[3:0] = O2_c517_451_l2_f0;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f0_inst0 (
        .COUTB(COUT_LA_l2_f0[0]),
        .COUTD(COUT_LA_l2_f0[1]),
        .COUTF(COUT_LA_l2_f0[2]),
        .COUTH(COUT_LA_l2_f0[3]),
        .CIN  (CIN_LA_l2_f0    ),
        .CYA  (CY_LA_l2_f0[0]  ),
        .CYB  (CY_LA_l2_f0[1]  ),
        .CYC  (CY_LA_l2_f0[2]  ),
        .CYD  (CY_LA_l2_f0[3]  ),
        .CYE  (CY_LA_l2_f0[4]  ),
        .CYF  (CY_LA_l2_f0[5]  ),
        .CYG  (CY_LA_l2_f0[6]  ),
        .CYH  (CY_LA_l2_f0[7]  ),
        .PROPA(PROP_LA_l2_f0[0]),
        .PROPB(PROP_LA_l2_f0[1]),
        .PROPC(PROP_LA_l2_f0[2]),
        .PROPD(PROP_LA_l2_f0[3]),
        .PROPE(PROP_LA_l2_f0[4]),
        .PROPF(PROP_LA_l2_f0[5]),
        .PROPG(PROP_LA_l2_f0[6]),
        .PROPH(PROP_LA_l2_f0[7]));

    assign CLA_c517_451_l2_f0[0] = COUT_LA_l2_f0[0];
    assign CLA_c517_451_l2_f0[1] = COUT_LA_l2_f0[2];
    assign CIN_LA_l2_f0          = C0_c517_451_l2_f0[8];
    assign CY_LA_l2_f0[3:0]      = CY0_c517_451_l2_f0;
    assign CY_LA_l2_f0[7:4]      = CY1_c517_451_l2_f0;
    assign PROP_LA_l2_f0[3:0]    = PROP0_c517_451_l2_f0;
    assign PROP_LA_l2_f0[7:4]    = PROP1_c517_451_l2_f0;
    
    // GPC1 in layer2: (3,9 : 2,3,1) at column 1
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l2_f1(
        .clk  (clk                ),
        .C0   (C0_c39_231_l2_f1   ),
        .C1   (C1_c39_231_l2_f1   ),
        .CLA  (CLA_c39_231_l2_f1  ),
        .O0   (O0_c39_231_l2_f1   ),
        .O1   (O1_c39_231_l2_f1   ),
        .O2   (O2_c39_231_l2_f1   ),
        .CY0  (CY0_c39_231_l2_f1  ),
        .CY1  (CY1_c39_231_l2_f1  ),
        .PROP0(PROP0_c39_231_l2_f1),
        .PROP1(PROP1_c39_231_l2_f1));
    
    assign C0_c39_231_l2_f1 = layer2_col1[13:5];
    assign C1_c39_231_l2_f1 = layer2_col2[2:0];
    
    assign layer3_col1[5]   = O0_c39_231_l2_f1;
    assign layer3_col2[6:4] = O1_c39_231_l2_f1;
    assign layer3_col3[1:0] = O2_c39_231_l2_f1;
    
    // GPC chain0 in layer2:
    // -- (1,5 : 3] at column 0
    // -- (9 : 4,1) at column 2
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_c0_s0_inst0 (
        .COUTB(COUT_LA_l2_c0_s0[0]),
        .COUTD(COUT_LA_l2_c0_s0[1]),
        .COUTF(COUT_LA_l2_c0_s0[2]),
        .COUTH(COUT_LA_l2_c0_s0[3]),
        .CIN  (CIN_LA_l2_c0_s0    ),
        .CYA  (CY_LA_l2_c0_s0[0]  ),
        .CYB  (CY_LA_l2_c0_s0[1]  ),
        .CYC  (CY_LA_l2_c0_s0[2]  ),
        .CYD  (CY_LA_l2_c0_s0[3]  ),
        .CYE  (CY_LA_l2_c0_s0[4]  ),
        .CYF  (CY_LA_l2_c0_s0[5]  ),
        .CYG  (CY_LA_l2_c0_s0[6]  ),
        .CYH  (CY_LA_l2_c0_s0[7]  ),
        .PROPA(PROP_LA_l2_c0_s0[0]),
        .PROPB(PROP_LA_l2_c0_s0[1]),
        .PROPC(PROP_LA_l2_c0_s0[2]),
        .PROPD(PROP_LA_l2_c0_s0[3]),
        .PROPE(PROP_LA_l2_c0_s0[4]),
        .PROPF(PROP_LA_l2_c0_s0[5]),
        .PROPG(PROP_LA_l2_c0_s0[6]),
        .PROPH(PROP_LA_l2_c0_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l2_c0_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l2_c0_i0  ),
        .C1  (C1_c15_3_l2_c0_i0  ),
        .CLA (CLA_c15_3_l2_c0_i0 ),
        .O   (O_c15_3_l2_c0_i0   ),
        .CY  (CY_c15_3_l2_c0_i0  ),
        .PROP(PROP_c15_3_l2_c0_i0));
    
    assign C0_c15_3_l2_c0_i0 = layer2_col0[21:17];
    assign C1_c15_3_l2_c0_i0 = layer2_col1[14];
    
    assign layer3_col0[1] = O_c15_3_l2_c0_i0[0];
    assign layer3_col1[6] = O_c15_3_l2_c0_i0[1];
    
    assign l2_c0_i0              = COUT_LA_l2_c0_s0[0];
    assign CY_LA_l2_c0_s0[1:0]   = CY_c15_3_l2_c0_i0;
    assign PROP_LA_l2_c0_s0[1:0] = PROP_c15_3_l2_c0_i0;
    
    assign CIN_LA_l2_c0_s0    = C0_c15_3_l2_c0_i0[4];
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_c0_i1(
        .clk (clk                ),
        .C0  (C0_c9_41_l2_c0_i1  ),
        .CLA (CLA_c9_41_l2_c0_i1 ),
        .O0  (O0_c9_41_l2_c0_i1  ),
        .O1  (O1_c9_41_l2_c0_i1  ),
        .CY  (CY_c9_41_l2_c0_i1  ),
        .PROP(PROP_c9_41_l2_c0_i1));
    
    assign C0_c9_41_l2_c0_i1 = {l2_c0_i0, layer2_col2[10:3]};
    
    assign layer3_col2[7]   = O0_c9_41_l2_c0_i1;
    assign layer3_col3[5:2] = O1_c9_41_l2_c0_i1;
    
    assign l2_c0_i1              = COUT_LA_l2_c0_s0[1];
    assign CY_LA_l2_c0_s0[3:2]   = CY_c9_41_l2_c0_i1;
    assign PROP_LA_l2_c0_s0[3:2] = PROP_c9_41_l2_c0_i1;
    
    // GPC2 in layer2: (1,5 : 3] at column 0
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l2_f2(
        .clk (clk             ),
        .C0  (C0_c15_3_l2_f2  ),
        .C1  (C1_c15_3_l2_f2  ),
        .CLA (CLA_c15_3_l2_f2 ),
        .O   (O_c15_3_l2_f2   ),
        .CY  (CY_c15_3_l2_f2  ),
        .PROP(PROP_c15_3_l2_f2));
    
    assign C0_c15_3_l2_f2 = layer2_col0[26:22];
    assign C1_c15_3_l2_f2 = layer2_col1[15];
    
    assign layer3_col0[2] = O_c15_3_l2_f2[0];
    assign layer3_col1[7] = O_c15_3_l2_f2[1];
    assign layer3_col2[8] = O_c15_3_l2_f2[2];
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_floating_placement_inst0 (
        .COUTB(COUT_LA_l2_floating_placement[0]),
        .COUTD(COUT_LA_l2_floating_placement[1]),
        .COUTF(COUT_LA_l2_floating_placement[2]),
        .COUTH(COUT_LA_l2_floating_placement[3]),
        .CIN  (CIN_LA_l2_floating_placement    ),
        .CYA  (CY_LA_l2_floating_placement[0]  ),
        .CYB  (CY_LA_l2_floating_placement[1]  ),
        .CYC  (CY_LA_l2_floating_placement[2]  ),
        .CYD  (CY_LA_l2_floating_placement[3]  ),
        .CYE  (CY_LA_l2_floating_placement[4]  ),
        .CYF  (CY_LA_l2_floating_placement[5]  ),
        .CYG  (CY_LA_l2_floating_placement[6]  ),
        .CYH  (CY_LA_l2_floating_placement[7]  ),
        .PROPA(PROP_LA_l2_floating_placement[0]),
        .PROPB(PROP_LA_l2_floating_placement[1]),
        .PROPC(PROP_LA_l2_floating_placement[2]),
        .PROPD(PROP_LA_l2_floating_placement[3]),
        .PROPE(PROP_LA_l2_floating_placement[4]),
        .PROPF(PROP_LA_l2_floating_placement[5]),
        .PROPG(PROP_LA_l2_floating_placement[6]),
        .PROPH(PROP_LA_l2_floating_placement[7]));

    assign CY_LA_l2_floating_placement[1:0]   = CY0_c39_231_l2_f1;
    assign PROP_LA_l2_floating_placement[1:0] = PROP0_c39_231_l2_f1;
    assign CY_LA_l2_floating_placement[3:2]   = CY1_c39_231_l2_f1;
    assign PROP_LA_l2_floating_placement[3:2] = PROP1_c39_231_l2_f1;
    assign CIN_LA_l2_floating_placement    = C0_c39_231_l2_f1[8];
    
    assign CY_LA_l2_floating_placement[5:4]   = CY_c15_3_l2_f2;
    assign PROP_LA_l2_floating_placement[5:4] = PROP_c15_3_l2_f2;
    
    assign layer3_col0[3] = layer2_col0[27];
    assign layer3_col0[4] = layer2_col0[28];
    assign layer3_col0[5] = layer2_col0[29];
    assign layer3_col0[6] = layer2_col0[30];
    assign layer3_col0[7] = layer2_col0[31];
    assign layer3_col2[9] = layer2_col2[11];
    assign layer3_col2[10] = layer2_col2[12];
    assign layer3_col2[11] = layer2_col2[13];
    assign layer3_col2[12] = layer2_col2[14];
    assign layer3_col2[13] = layer2_col2[15];
    // ------------------------------ LAYER 3 ------------------------------
    // GPC chain0 in layer3:
    // -- (1,5 : 3] at column 0
    // -- (3,9 : 2,3,1) at column 2
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_c0_s0_inst0 (
        .COUTB(COUT_LA_l3_c0_s0[0]),
        .COUTD(COUT_LA_l3_c0_s0[1]),
        .COUTF(COUT_LA_l3_c0_s0[2]),
        .COUTH(COUT_LA_l3_c0_s0[3]),
        .CIN  (CIN_LA_l3_c0_s0    ),
        .CYA  (CY_LA_l3_c0_s0[0]  ),
        .CYB  (CY_LA_l3_c0_s0[1]  ),
        .CYC  (CY_LA_l3_c0_s0[2]  ),
        .CYD  (CY_LA_l3_c0_s0[3]  ),
        .CYE  (CY_LA_l3_c0_s0[4]  ),
        .CYF  (CY_LA_l3_c0_s0[5]  ),
        .CYG  (CY_LA_l3_c0_s0[6]  ),
        .CYH  (CY_LA_l3_c0_s0[7]  ),
        .PROPA(PROP_LA_l3_c0_s0[0]),
        .PROPB(PROP_LA_l3_c0_s0[1]),
        .PROPC(PROP_LA_l3_c0_s0[2]),
        .PROPD(PROP_LA_l3_c0_s0[3]),
        .PROPE(PROP_LA_l3_c0_s0[4]),
        .PROPF(PROP_LA_l3_c0_s0[5]),
        .PROPG(PROP_LA_l3_c0_s0[6]),
        .PROPH(PROP_LA_l3_c0_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_c0_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l3_c0_i0  ),
        .C1  (C1_c15_3_l3_c0_i0  ),
        .CLA (CLA_c15_3_l3_c0_i0 ),
        .O   (O_c15_3_l3_c0_i0   ),
        .CY  (CY_c15_3_l3_c0_i0  ),
        .PROP(PROP_c15_3_l3_c0_i0));
    
    assign C0_c15_3_l3_c0_i0 = layer3_col0[4:0];
    assign C1_c15_3_l3_c0_i0 = layer3_col1[0];
    
    assign layer4_col0[0] = O_c15_3_l3_c0_i0[0];
    assign layer4_col1[0] = O_c15_3_l3_c0_i0[1];
    
    assign l3_c0_i0              = COUT_LA_l3_c0_s0[0];
    assign CY_LA_l3_c0_s0[1:0]   = CY_c15_3_l3_c0_i0;
    assign PROP_LA_l3_c0_s0[1:0] = PROP_c15_3_l3_c0_i0;
    
    assign CIN_LA_l3_c0_s0    = C0_c15_3_l3_c0_i0[4];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l3_c0_i1(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l3_c0_i1   ),
        .C1   (C1_c39_231_l3_c0_i1   ),
        .CLA  (CLA_c39_231_l3_c0_i1  ),
        .O0   (O0_c39_231_l3_c0_i1   ),
        .O1   (O1_c39_231_l3_c0_i1   ),
        .O2   (O2_c39_231_l3_c0_i1   ),
        .CY0  (CY0_c39_231_l3_c0_i1  ),
        .CY1  (CY1_c39_231_l3_c0_i1  ),
        .PROP0(PROP0_c39_231_l3_c0_i1),
        .PROP1(PROP1_c39_231_l3_c0_i1));
    
    assign C0_c39_231_l3_c0_i1 = {l3_c0_i0, layer3_col2[7:0]};
    assign C1_c39_231_l3_c0_i1 = layer3_col3[2:0];
    
    assign layer4_col2[0]   = O0_c39_231_l3_c0_i1;
    assign layer4_col3[2:0] = O1_c39_231_l3_c0_i1;
    assign layer4_col4[1:0] = O2_c39_231_l3_c0_i1;
    
    assign CLA_c39_231_l3_c0_i1  = COUT_LA_l3_c0_s0[0];
    assign CY_LA_l3_c0_s0[3:2]   = CY0_c39_231_l3_c0_i1;
    assign PROP_LA_l3_c0_s0[3:2] = PROP0_c39_231_l3_c0_i1;
    
    // GPC0 in layer3: (1,5 : 3] at column 1
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_f0(
        .clk (clk             ),
        .C0  (C0_c15_3_l3_f0  ),
        .C1  (C1_c15_3_l3_f0  ),
        .CLA (CLA_c15_3_l3_f0 ),
        .O   (O_c15_3_l3_f0   ),
        .CY  (CY_c15_3_l3_f0  ),
        .PROP(PROP_c15_3_l3_f0));
    
    assign C0_c15_3_l3_f0 = layer3_col1[5:1];
    assign C1_c15_3_l3_f0 = layer3_col2[8];
    
    assign layer4_col1[1] = O_c15_3_l3_f0[0];
    assign layer4_col2[1] = O_c15_3_l3_f0[1];
    assign layer4_col3[3] = O_c15_3_l3_f0[2];
    
    // GPC1 in layer3: (1,5 : 3] at column 2
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_f1(
        .clk (clk             ),
        .C0  (C0_c15_3_l3_f1  ),
        .C1  (C1_c15_3_l3_f1  ),
        .CLA (CLA_c15_3_l3_f1 ),
        .O   (O_c15_3_l3_f1   ),
        .CY  (CY_c15_3_l3_f1  ),
        .PROP(PROP_c15_3_l3_f1));
    
    assign C0_c15_3_l3_f1 = layer3_col2[13:9];
    assign C1_c15_3_l3_f1 = layer3_col3[3];
    
    assign layer4_col2[2] = O_c15_3_l3_f1[0];
    assign layer4_col3[4] = O_c15_3_l3_f1[1];
    assign layer4_col4[2] = O_c15_3_l3_f1[2];
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_floating_placement_inst0 (
        .COUTB(COUT_LA_l3_floating_placement[0]),
        .COUTD(COUT_LA_l3_floating_placement[1]),
        .COUTF(COUT_LA_l3_floating_placement[2]),
        .COUTH(COUT_LA_l3_floating_placement[3]),
        .CIN  (CIN_LA_l3_floating_placement    ),
        .CYA  (CY_LA_l3_floating_placement[0]  ),
        .CYB  (CY_LA_l3_floating_placement[1]  ),
        .CYC  (CY_LA_l3_floating_placement[2]  ),
        .CYD  (CY_LA_l3_floating_placement[3]  ),
        .CYE  (CY_LA_l3_floating_placement[4]  ),
        .CYF  (CY_LA_l3_floating_placement[5]  ),
        .CYG  (CY_LA_l3_floating_placement[6]  ),
        .CYH  (CY_LA_l3_floating_placement[7]  ),
        .PROPA(PROP_LA_l3_floating_placement[0]),
        .PROPB(PROP_LA_l3_floating_placement[1]),
        .PROPC(PROP_LA_l3_floating_placement[2]),
        .PROPD(PROP_LA_l3_floating_placement[3]),
        .PROPE(PROP_LA_l3_floating_placement[4]),
        .PROPF(PROP_LA_l3_floating_placement[5]),
        .PROPG(PROP_LA_l3_floating_placement[6]),
        .PROPH(PROP_LA_l3_floating_placement[7]));

    assign CY_LA_l3_floating_placement[1:0]   = CY_c15_3_l3_f0;
    assign PROP_LA_l3_floating_placement[1:0] = PROP_c15_3_l3_f0;
    assign CIN_LA_l3_floating_placement    = C0_c15_3_l3_f0[4];
    
    assign CY_LA_l3_floating_placement[3:2]   = CY_c15_3_l3_f1;
    assign PROP_LA_l3_floating_placement[3:2] = PROP_c15_3_l3_f1;
    
    assign layer4_col0[1] = layer3_col0[5];
    assign layer4_col0[2] = layer3_col0[6];
    assign layer4_col0[3] = layer3_col0[7];
    assign layer4_col1[2] = layer3_col1[6];
    assign layer4_col1[3] = layer3_col1[7];
    assign layer4_col3[5] = layer3_col3[4];
    assign layer4_col3[6] = layer3_col3[5];
    // ------------------------------ LAYER 4 ------------------------------
    // GPC0 in layer4: (1,5 : 3] at column 3
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l4_f0(
        .clk (clk             ),
        .C0  (C0_c15_3_l4_f0  ),
        .C1  (C1_c15_3_l4_f0  ),
        .CLA (CLA_c15_3_l4_f0 ),
        .O   (O_c15_3_l4_f0   ),
        .CY  (CY_c15_3_l4_f0  ),
        .PROP(PROP_c15_3_l4_f0));
    
    assign C0_c15_3_l4_f0 = layer4_col3[4:0];
    assign C1_c15_3_l4_f0 = layer4_col4[0];
    
    assign layer5_col3[0] = O_c15_3_l4_f0[0];
    assign layer5_col4[0] = O_c15_3_l4_f0[1];
    assign layer5_col5    = O_c15_3_l4_f0[2];
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l4_floating_placement_inst0 (
        .COUTB(COUT_LA_l4_floating_placement[0]),
        .COUTD(COUT_LA_l4_floating_placement[1]),
        .COUTF(COUT_LA_l4_floating_placement[2]),
        .COUTH(COUT_LA_l4_floating_placement[3]),
        .CIN  (CIN_LA_l4_floating_placement    ),
        .CYA  (CY_LA_l4_floating_placement[0]  ),
        .CYB  (CY_LA_l4_floating_placement[1]  ),
        .CYC  (CY_LA_l4_floating_placement[2]  ),
        .CYD  (CY_LA_l4_floating_placement[3]  ),
        .CYE  (CY_LA_l4_floating_placement[4]  ),
        .CYF  (CY_LA_l4_floating_placement[5]  ),
        .CYG  (CY_LA_l4_floating_placement[6]  ),
        .CYH  (CY_LA_l4_floating_placement[7]  ),
        .PROPA(PROP_LA_l4_floating_placement[0]),
        .PROPB(PROP_LA_l4_floating_placement[1]),
        .PROPC(PROP_LA_l4_floating_placement[2]),
        .PROPD(PROP_LA_l4_floating_placement[3]),
        .PROPE(PROP_LA_l4_floating_placement[4]),
        .PROPF(PROP_LA_l4_floating_placement[5]),
        .PROPG(PROP_LA_l4_floating_placement[6]),
        .PROPH(PROP_LA_l4_floating_placement[7]));

    assign CY_LA_l4_floating_placement[1:0]   = CY_c15_3_l4_f0;
    assign PROP_LA_l4_floating_placement[1:0] = PROP_c15_3_l4_f0;
    assign CIN_LA_l4_floating_placement    = C0_c15_3_l4_f0[4];
    
    assign layer5_col0[0] = layer4_col0[0];
    assign layer5_col0[1] = layer4_col0[1];
    assign layer5_col0[2] = layer4_col0[2];
    assign layer5_col0[3] = layer4_col0[3];
    assign layer5_col1[0] = layer4_col1[0];
    assign layer5_col1[1] = layer4_col1[1];
    assign layer5_col1[2] = layer4_col1[2];
    assign layer5_col1[3] = layer4_col1[3];
    assign layer5_col2[0] = layer4_col2[0];
    assign layer5_col2[1] = layer4_col2[1];
    assign layer5_col2[2] = layer4_col2[2];
    assign layer5_col3[1] = layer4_col3[5];
    assign layer5_col3[2] = layer4_col3[6];
    assign layer5_col4[1] = layer4_col4[1];
    assign layer5_col4[2] = layer4_col4[2];
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_terminal_chain1_inst0 (
        .COUTB(COUT_LA_terminal_chain1[0]),
        .COUTD(COUT_LA_terminal_chain1[1]),
        .COUTF(COUT_LA_terminal_chain1[2]),
        .COUTH(COUT_LA_terminal_chain1[3]),
        .CIN  (CIN_LA_terminal_chain1    ),
        .CYA  (CY_LA_terminal_chain1[0]  ),
        .CYB  (CY_LA_terminal_chain1[1]  ),
        .CYC  (CY_LA_terminal_chain1[2]  ),
        .CYD  (CY_LA_terminal_chain1[3]  ),
        .CYE  (CY_LA_terminal_chain1[4]  ),
        .CYF  (CY_LA_terminal_chain1[5]  ),
        .CYG  (CY_LA_terminal_chain1[6]  ),
        .CYH  (CY_LA_terminal_chain1[7]  ),
        .PROPA(PROP_LA_terminal_chain1[0]),
        .PROPB(PROP_LA_terminal_chain1[1]),
        .PROPC(PROP_LA_terminal_chain1[2]),
        .PROPD(PROP_LA_terminal_chain1[3]),
        .PROPE(PROP_LA_terminal_chain1[4]),
        .PROPF(PROP_LA_terminal_chain1[5]),
        .PROPG(PROP_LA_terminal_chain1[6]),
        .PROPH(PROP_LA_terminal_chain1[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i0(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i0  ),
        .C1  (C1_c15_3_terminal_chain1_i0  ),
        .CLA (CLA_c15_3_terminal_chain1_i0 ),
        .O   (O_c15_3_terminal_chain1_i0   ),
        .CY  (CY_c15_3_terminal_chain1_i0  ),
        .PROP(PROP_c15_3_terminal_chain1_i0));
    assign C0_c15_3_terminal_chain1_i0[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i0[1] = layer5_col0[0];
    assign C0_c15_3_terminal_chain1_i0[2] = layer5_col0[1];
    assign C0_c15_3_terminal_chain1_i0[3] = layer5_col0[2];
    assign C0_c15_3_terminal_chain1_i0[4] = layer5_col0[3];
    assign C1_c15_3_terminal_chain1_i0    = layer5_col1[0];
    
    assign terminal_chain1_out[0] = O_c15_3_terminal_chain1_i0[0];
    assign terminal_chain1_out[1] = O_c15_3_terminal_chain1_i0[1];
    
    assign terminal_chain1_i0           = COUT_LA_terminal_chain1[0];
    assign CY_LA_terminal_chain1[1:0]   = CY_c15_3_terminal_chain1_i0;
    assign PROP_LA_terminal_chain1[1:0] = PROP_c15_3_terminal_chain1_i0;
    
    assign CIN_LA_terminal_chain1    = C0_c15_3_terminal_chain1_i0[4];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i1(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i1  ),
        .C1  (C1_c15_3_terminal_chain1_i1  ),
        .CLA (CLA_c15_3_terminal_chain1_i1 ),
        .O   (O_c15_3_terminal_chain1_i1   ),
        .CY  (CY_c15_3_terminal_chain1_i1  ),
        .PROP(PROP_c15_3_terminal_chain1_i1));
    
    assign C0_c15_3_terminal_chain1_i1[4] = terminal_chain1_i0;
    assign C0_c15_3_terminal_chain1_i1[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i1[1] = layer5_col2[0];
    assign C0_c15_3_terminal_chain1_i1[2] = layer5_col2[1];
    assign C0_c15_3_terminal_chain1_i1[3] = layer5_col2[2];
    assign C1_c15_3_terminal_chain1_i1    = layer5_col3[0];
    
    assign terminal_chain1_out[2] = O_c15_3_terminal_chain1_i1[0];
    assign terminal_chain1_out[3] = O_c15_3_terminal_chain1_i1[1];
    
    assign terminal_chain1_i1           = COUT_LA_terminal_chain1[1];
    assign CY_LA_terminal_chain1[3:2]   = CY_c15_3_terminal_chain1_i1;
    assign PROP_LA_terminal_chain1[3:2] = PROP_c15_3_terminal_chain1_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_terminal_chain1_i2(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i2  ),
        .C1  (C1_c15_3_terminal_chain1_i2  ),
        .CLA (CLA_c15_3_terminal_chain1_i2 ),
        .O   (O_c15_3_terminal_chain1_i2   ),
        .CY  (CY_c15_3_terminal_chain1_i2  ),
        .PROP(PROP_c15_3_terminal_chain1_i2));
    
    assign C0_c15_3_terminal_chain1_i2[4] = terminal_chain1_i1;
    assign C0_c15_3_terminal_chain1_i2[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i2[1] = layer5_col4[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer5_col4[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer5_col4[2];
    assign C1_c15_3_terminal_chain1_i2    = layer5_col5;
    
    assign terminal_chain1_out[4] = O_c15_3_terminal_chain1_i2[0];
    assign terminal_chain1_out[5] = O_c15_3_terminal_chain1_i2[1];
    assign terminal_chain1_out[6] = O_c15_3_terminal_chain1_i2[2];
    
    assign terminal_chain1_i2           = COUT_LA_terminal_chain1[2];
    assign CY_LA_terminal_chain1[5:4]   = CY_c15_3_terminal_chain1_i2;
    assign PROP_LA_terminal_chain1[5:4] = PROP_c15_3_terminal_chain1_i2;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_terminal_chain2_inst0 (
        .COUTB(COUT_LA_terminal_chain2[0]),
        .COUTD(COUT_LA_terminal_chain2[1]),
        .COUTF(COUT_LA_terminal_chain2[2]),
        .COUTH(COUT_LA_terminal_chain2[3]),
        .CIN  (CIN_LA_terminal_chain2    ),
        .CYA  (CY_LA_terminal_chain2[0]  ),
        .CYB  (CY_LA_terminal_chain2[1]  ),
        .CYC  (CY_LA_terminal_chain2[2]  ),
        .CYD  (CY_LA_terminal_chain2[3]  ),
        .CYE  (CY_LA_terminal_chain2[4]  ),
        .CYF  (CY_LA_terminal_chain2[5]  ),
        .CYG  (CY_LA_terminal_chain2[6]  ),
        .CYH  (CY_LA_terminal_chain2[7]  ),
        .PROPA(PROP_LA_terminal_chain2[0]),
        .PROPB(PROP_LA_terminal_chain2[1]),
        .PROPC(PROP_LA_terminal_chain2[2]),
        .PROPD(PROP_LA_terminal_chain2[3]),
        .PROPE(PROP_LA_terminal_chain2[4]),
        .PROPF(PROP_LA_terminal_chain2[5]),
        .PROPG(PROP_LA_terminal_chain2[6]),
        .PROPH(PROP_LA_terminal_chain2[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i0(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i0  ),
        .C1  (C1_c15_3_terminal_chain2_i0  ),
        .CLA (CLA_c15_3_terminal_chain2_i0 ),
        .O   (O_c15_3_terminal_chain2_i0   ),
        .CY  (CY_c15_3_terminal_chain2_i0  ),
        .PROP(PROP_c15_3_terminal_chain2_i0));
    
    assign C0_c15_3_terminal_chain2_i0[4] = 1'b0;
    assign C0_c15_3_terminal_chain2_i0[3] = terminal_chain1_out[1];
    assign C0_c15_3_terminal_chain2_i0[2] = layer5_col1[3];
    assign C0_c15_3_terminal_chain2_i0[1] = layer5_col1[2];
    assign C0_c15_3_terminal_chain2_i0[0] = layer5_col1[1];
    assign C1_c15_3_terminal_chain2_i0    = terminal_chain1_out[2];
    
    assign terminal_chain2_out[0] = O_c15_3_terminal_chain2_i0[0];
    assign terminal_chain2_out[1] = O_c15_3_terminal_chain2_i0[1];
    
    assign terminal_chain2_i0           = COUT_LA_terminal_chain2[0];
    assign CY_LA_terminal_chain2[1:0]   = CY_c15_3_terminal_chain2_i0;
    assign PROP_LA_terminal_chain2[1:0] = PROP_c15_3_terminal_chain2_i0;
    
    assign CIN_LA_terminal_chain2    = C0_c15_3_terminal_chain2_i0[4];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i1(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i1  ),
        .C1  (C1_c15_3_terminal_chain2_i1  ),
        .CLA (CLA_c15_3_terminal_chain2_i1 ),
        .O   (O_c15_3_terminal_chain2_i1   ),
        .CY  (CY_c15_3_terminal_chain2_i1  ),
        .PROP(PROP_c15_3_terminal_chain2_i1));
    
    assign C0_c15_3_terminal_chain2_i1[4] = terminal_chain2_i0;
    assign C0_c15_3_terminal_chain2_i1[3] = terminal_chain1_out[3];
    assign C0_c15_3_terminal_chain2_i1[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i1[1] = layer5_col3[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer5_col3[2];
    assign C1_c15_3_terminal_chain2_i1    = terminal_chain1_out[4];
    
    assign terminal_chain2_out[2] = O_c15_3_terminal_chain2_i1[0];
    assign terminal_chain2_out[3] = O_c15_3_terminal_chain2_i1[1];
    
    assign terminal_chain2_i1           = COUT_LA_terminal_chain2[1];
    assign CY_LA_terminal_chain2[3:2]   = CY_c15_3_terminal_chain2_i1;
    assign PROP_LA_terminal_chain2[3:2] = PROP_c15_3_terminal_chain2_i1;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i2(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i2  ),
        .O   (O_c3_2_terminal_chain2_i2   ),
        .CY  (CY_c3_2_terminal_chain2_i2  ),
        .PROP(PROP_c3_2_terminal_chain2_i2));
    
    assign C0_c3_2_terminal_chain2_i2[2] = terminal_chain2_i1;
    assign C0_c3_2_terminal_chain2_i2[0] = terminal_chain1_out[5];
    assign C0_c3_2_terminal_chain2_i2[1] = 1'b0;
    
    assign terminal_chain2_out[4] = O_c3_2_terminal_chain2_i2[0];
    
    assign terminal_chain2_i2         = O_c3_2_terminal_chain2_i2[1];
    assign CY_LA_terminal_chain2[4]   = CY_c3_2_terminal_chain2_i2;
    assign PROP_LA_terminal_chain2[4] = PROP_c3_2_terminal_chain2_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i3(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i3  ),
        .O   (O_c3_2_terminal_chain2_i3   ),
        .CY  (CY_c3_2_terminal_chain2_i3  ),
        .PROP(PROP_c3_2_terminal_chain2_i3));
    
    assign C0_c3_2_terminal_chain2_i3[2] = terminal_chain2_i2;
    assign C0_c3_2_terminal_chain2_i3[0] = terminal_chain1_out[6];
    assign C0_c3_2_terminal_chain2_i3[1] = 1'b0;
    
    assign terminal_chain2_out[5] = O_c3_2_terminal_chain2_i3[0];
    assign terminal_chain2_out[6] = O_c3_2_terminal_chain2_i3[1];
    
    assign terminal_chain2_i3         = COUT_LA_terminal_chain2[2];
    assign CY_LA_terminal_chain2[5]   = CY_c3_2_terminal_chain2_i3;
    assign PROP_LA_terminal_chain2[5] = PROP_c3_2_terminal_chain2_i3;
    
    always_ff @(posedge clk) begin
        comp_out[0] <= terminal_chain1_out[0];
    
        comp_out[7:1] <= terminal_chain2_out[6:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = in_col0;
    
endmodule