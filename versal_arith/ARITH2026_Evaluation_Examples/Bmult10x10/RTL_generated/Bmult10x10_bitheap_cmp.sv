`timescale 1ns / 1ps

module Bmult10x10_bitheap_cmp (
    input  logic          clk,
    input  logic [1  : 0] col0,
    input  logic          col1,
    input  logic [2  : 0] col2,
    input  logic [1  : 0] col3,
    input  logic [3  : 0] col4,
    input  logic [2  : 0] col5,
    input  logic [4  : 0] col6,
    input  logic [3  : 0] col7,
    input  logic [5  : 0] col8,
    input  logic [4  : 0] col9,
    input  logic [5  : 0] col10,
    input  logic [4  : 0] col11,
    input  logic [3  : 0] col12,
    input  logic [3  : 0] col13,
    input  logic [2  : 0] col14,
    input  logic [2  : 0] col15,
    input  logic [1  : 0] col16,
    input  logic [1  : 0] col17,
    input  logic          col18,
    input  logic          col19,
    output logic [20 : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [1  : 0] layer0_col0;
    logic          layer0_col1;
    logic [2  : 0] layer0_col2;
    logic [1  : 0] layer0_col3;
    logic [3  : 0] layer0_col4;
    logic [2  : 0] layer0_col5;
    logic [4  : 0] layer0_col6;
    logic [3  : 0] layer0_col7;
    logic [5  : 0] layer0_col8;
    logic [4  : 0] layer0_col9;
    logic [5  : 0] layer0_col10;
    logic [4  : 0] layer0_col11;
    logic [3  : 0] layer0_col12;
    logic [3  : 0] layer0_col13;
    logic [2  : 0] layer0_col14;
    logic [2  : 0] layer0_col15;
    logic [1  : 0] layer0_col16;
    logic [1  : 0] layer0_col17;
    logic          layer0_col18;
    logic          layer0_col19;
    
    logic [3 : 0] COUT_LA_l0_c0_s0;
    logic         CIN_LA_l0_c0_s0;
    logic [7 : 0] CY_LA_l0_c0_s0;
    logic [7 : 0] PROP_LA_l0_c0_s0;
    
    logic [2 : 0] C0_c3_2_l0_c0_i0;
    logic [1 : 0] O_c3_2_l0_c0_i0;
    logic         CY_c3_2_l0_c0_i0;
    logic         PROP_c3_2_l0_c0_i0;
    logic         l0_c0_i0;
    
    logic [2 : 0] C0_c3_2_l0_c0_i1;
    logic [1 : 0] O_c3_2_l0_c0_i1;
    logic         CY_c3_2_l0_c0_i1;
    logic         PROP_c3_2_l0_c0_i1;
    logic         l0_c0_i1;
    
    logic [4 : 0] C0_c15_3_l0_c0_i2;
    logic         C1_c15_3_l0_c0_i2;
    logic         CLA_c15_3_l0_c0_i2;
    logic [2 : 0] O_c15_3_l0_c0_i2;
    logic [1 : 0] CY_c15_3_l0_c0_i2;
    logic [1 : 0] PROP_c15_3_l0_c0_i2;
    logic         l0_c0_i2;
    
    logic [4 : 0] C0_c15_3_l0_c0_i3;
    logic         C1_c15_3_l0_c0_i3;
    logic         CLA_c15_3_l0_c0_i3;
    logic [2 : 0] O_c15_3_l0_c0_i3;
    logic [1 : 0] CY_c15_3_l0_c0_i3;
    logic [1 : 0] PROP_c15_3_l0_c0_i3;
    logic         l0_c0_i3;
    
    logic [2 : 0] C0_c3_2_l0_c0_i4;
    logic [1 : 0] O_c3_2_l0_c0_i4;
    logic         CY_c3_2_l0_c0_i4;
    logic         PROP_c3_2_l0_c0_i4;
    logic         l0_c0_i4;
    
    logic [2 : 0] C0_c3_2_l0_c0_i5;
    logic [1 : 0] O_c3_2_l0_c0_i5;
    logic         CY_c3_2_l0_c0_i5;
    logic         PROP_c3_2_l0_c0_i5;
    logic         l0_c0_i5;
    
    logic [2 : 0] C0_c3_2_l0_f0;
    logic [1 : 0] O_c3_2_l0_i0;
    logic         CY_c3_2_l0_f0;
    logic         PROP_c3_2_l0_f0;
    
    logic [2 : 0] C0_c3_2_l0_f1;
    logic [1 : 0] O_c3_2_l0_i1;
    logic         CY_c3_2_l0_f1;
    logic         PROP_c3_2_l0_f1;
    
    logic    COUT_LA_l0_floating_placement;
    logic    CIN_LA_l0_floating_placement;
    logic    CY_LA_l0_floating_placement;
    logic    PROP_LA_l0_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [1  : 0] layer1_col0;
    logic          layer1_col1;
    logic [2  : 0] layer1_col2;
    logic [1  : 0] layer1_col3;
    logic [3  : 0] layer1_col4;
    logic [2  : 0] layer1_col5;
    logic [2  : 0] layer1_col6;
    logic [2  : 0] layer1_col7;
    logic [2  : 0] layer1_col8;
    logic [2  : 0] layer1_col9;
    logic [3  : 0] layer1_col10;
    logic [2  : 0] layer1_col11;
    logic [3  : 0] layer1_col12;
    logic [2  : 0] layer1_col13;
    logic [3  : 0] layer1_col14;
    logic [2  : 0] layer1_col15;
    logic [1  : 0] layer1_col16;
    logic [1  : 0] layer1_col17;
    logic          layer1_col18;
    logic          layer1_col19;
    
    logic [18 : 0] terminal_chain1_out;
    
    logic [11 : 0] COUT_LA_terminal_chain1;
    logic [2  : 0] CIN_LA_terminal_chain1;
    logic [23 : 0] CY_LA_terminal_chain1;
    logic [23 : 0] PROP_LA_terminal_chain1;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i0;
    logic [1 : 0] O_c3_2_terminal_chain1_i0;
    logic         CY_c3_2_terminal_chain1_i0;
    logic         PROP_c3_2_terminal_chain1_i0;
    logic         terminal_chain1_i0;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i1;
    logic [1 : 0] O_c3_2_terminal_chain1_i1;
    logic         CY_c3_2_terminal_chain1_i1;
    logic         PROP_c3_2_terminal_chain1_i1;
    logic         terminal_chain1_i1;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i2;
    logic         C1_c15_3_terminal_chain1_i2;
    logic         CLA_c15_3_terminal_chain1_i2;
    logic [2 : 0] O_c15_3_terminal_chain1_i2;
    logic [1 : 0] CY_c15_3_terminal_chain1_i2;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i2;
    logic         terminal_chain1_i2;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i3;
    logic         C1_c15_3_terminal_chain1_i3;
    logic         CLA_c15_3_terminal_chain1_i3;
    logic [2 : 0] O_c15_3_terminal_chain1_i3;
    logic [1 : 0] CY_c15_3_terminal_chain1_i3;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i3;
    logic         terminal_chain1_i3;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i4;
    logic         C1_c15_3_terminal_chain1_i4;
    logic         CLA_c15_3_terminal_chain1_i4;
    logic [2 : 0] O_c15_3_terminal_chain1_i4;
    logic [1 : 0] CY_c15_3_terminal_chain1_i4;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i4;
    logic         terminal_chain1_i4;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i5;
    logic         C1_c15_3_terminal_chain1_i5;
    logic         CLA_c15_3_terminal_chain1_i5;
    logic [2 : 0] O_c15_3_terminal_chain1_i5;
    logic [1 : 0] CY_c15_3_terminal_chain1_i5;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i5;
    logic         terminal_chain1_i5;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i6;
    logic         C1_c15_3_terminal_chain1_i6;
    logic         CLA_c15_3_terminal_chain1_i6;
    logic [2 : 0] O_c15_3_terminal_chain1_i6;
    logic [1 : 0] CY_c15_3_terminal_chain1_i6;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i6;
    logic         terminal_chain1_i6;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i7;
    logic         C1_c15_3_terminal_chain1_i7;
    logic         CLA_c15_3_terminal_chain1_i7;
    logic [2 : 0] O_c15_3_terminal_chain1_i7;
    logic [1 : 0] CY_c15_3_terminal_chain1_i7;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i7;
    logic         terminal_chain1_i7;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i8;
    logic         C1_c15_3_terminal_chain1_i8;
    logic         CLA_c15_3_terminal_chain1_i8;
    logic [2 : 0] O_c15_3_terminal_chain1_i8;
    logic [1 : 0] CY_c15_3_terminal_chain1_i8;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i8;
    logic         terminal_chain1_i8;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i9;
    logic [1 : 0] O_c3_2_terminal_chain1_i9;
    logic         CY_c3_2_terminal_chain1_i9;
    logic         PROP_c3_2_terminal_chain1_i9;
    logic         terminal_chain1_i9;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i10;
    logic [1 : 0] O_c3_2_terminal_chain1_i10;
    logic         CY_c3_2_terminal_chain1_i10;
    logic         PROP_c3_2_terminal_chain1_i10;
    logic         terminal_chain1_i10;
    
    logic [17 : 0] terminal_chain2_out;
    
    logic [11 : 0] COUT_LA_terminal_chain2;
    logic [2  : 0] CIN_LA_terminal_chain2;
    logic [23 : 0] CY_LA_terminal_chain2;
    logic [23 : 0] PROP_LA_terminal_chain2;
    
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
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i2;
    logic         C1_c15_3_terminal_chain2_i2;
    logic         CLA_c15_3_terminal_chain2_i2;
    logic [2 : 0] O_c15_3_terminal_chain2_i2;
    logic [1 : 0] CY_c15_3_terminal_chain2_i2;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i2;
    logic         terminal_chain2_i2;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i3;
    logic         C1_c15_3_terminal_chain2_i3;
    logic         CLA_c15_3_terminal_chain2_i3;
    logic [2 : 0] O_c15_3_terminal_chain2_i3;
    logic [1 : 0] CY_c15_3_terminal_chain2_i3;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i3;
    logic         terminal_chain2_i3;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i4;
    logic         C1_c15_3_terminal_chain2_i4;
    logic         CLA_c15_3_terminal_chain2_i4;
    logic [2 : 0] O_c15_3_terminal_chain2_i4;
    logic [1 : 0] CY_c15_3_terminal_chain2_i4;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i4;
    logic         terminal_chain2_i4;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i5;
    logic         C1_c15_3_terminal_chain2_i5;
    logic         CLA_c15_3_terminal_chain2_i5;
    logic [2 : 0] O_c15_3_terminal_chain2_i5;
    logic [1 : 0] CY_c15_3_terminal_chain2_i5;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i5;
    logic         terminal_chain2_i5;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i6;
    logic         C1_c15_3_terminal_chain2_i6;
    logic         CLA_c15_3_terminal_chain2_i6;
    logic [2 : 0] O_c15_3_terminal_chain2_i6;
    logic [1 : 0] CY_c15_3_terminal_chain2_i6;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i6;
    logic         terminal_chain2_i6;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i7;
    logic [1 : 0] O_c3_2_terminal_chain2_i7;
    logic         CY_c3_2_terminal_chain2_i7;
    logic         PROP_c3_2_terminal_chain2_i7;
    logic         terminal_chain2_i7;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i8;
    logic [1 : 0] O_c3_2_terminal_chain2_i8;
    logic         CY_c3_2_terminal_chain2_i8;
    logic         PROP_c3_2_terminal_chain2_i8;
    logic         terminal_chain2_i8;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i9;
    logic [1 : 0] O_c3_2_terminal_chain2_i9;
    logic         CY_c3_2_terminal_chain2_i9;
    logic         PROP_c3_2_terminal_chain2_i9;
    logic         terminal_chain2_i9;
    
    // ------------------------------ LAYER 0 ------------------------------
    // GPC chain0 in layer0:
    // -- (3 : 2] at column 6
    // -- (3 : 2] at column 7
    // -- (1,5 : 3] at column 8
    // -- (1,5 : 3] at column 10
    // -- (3 : 2] at column 12
    // -- (3 : 2] at column 13
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c0_s0_inst0 (
        .COUTB(COUT_LA_l0_c0_s0[0]),
        .COUTD(COUT_LA_l0_c0_s0[1]),
        .COUTF(COUT_LA_l0_c0_s0[2]),
        .COUTH(COUT_LA_l0_c0_s0[3]),
        .CIN  (CIN_LA_l0_c0_s0    ),
        .CYA  (CY_LA_l0_c0_s0[0]  ),
        .CYB  (CY_LA_l0_c0_s0[1]  ),
        .CYC  (CY_LA_l0_c0_s0[2]  ),
        .CYD  (CY_LA_l0_c0_s0[3]  ),
        .CYE  (CY_LA_l0_c0_s0[4]  ),
        .CYF  (CY_LA_l0_c0_s0[5]  ),
        .CYG  (CY_LA_l0_c0_s0[6]  ),
        .CYH  (CY_LA_l0_c0_s0[7]  ),
        .PROPA(PROP_LA_l0_c0_s0[0]),
        .PROPB(PROP_LA_l0_c0_s0[1]),
        .PROPC(PROP_LA_l0_c0_s0[2]),
        .PROPD(PROP_LA_l0_c0_s0[3]),
        .PROPE(PROP_LA_l0_c0_s0[4]),
        .PROPF(PROP_LA_l0_c0_s0[5]),
        .PROPG(PROP_LA_l0_c0_s0[6]),
        .PROPH(PROP_LA_l0_c0_s0[7]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c0_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c0_i0  ),
        .O   (O_c3_2_l0_c0_i0   ),
        .CY  (CY_c3_2_l0_c0_i0  ),
        .PROP(PROP_c3_2_l0_c0_i0));
    
    assign C0_c3_2_l0_c0_i0 = layer0_col6[2:0];
    
    assign layer1_col6[0] = O_c3_2_l0_c0_i0[0];
    
    assign l0_c0_i0            = O_c3_2_l0_c0_i0[1];
    assign CY_LA_l0_c0_s0[0]   = CY_c3_2_l0_c0_i0;
    assign PROP_LA_l0_c0_s0[0] = PROP_c3_2_l0_c0_i0;
    
    assign CIN_LA_l0_c0_s0    = C0_c3_2_l0_c0_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c0_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c0_i1  ),
        .O   (O_c3_2_l0_c0_i1   ),
        .CY  (CY_c3_2_l0_c0_i1  ),
        .PROP(PROP_c3_2_l0_c0_i1));
    
    assign C0_c3_2_l0_c0_i1 = {l0_c0_i0, layer0_col7[1:0]};
    
    assign layer1_col7[0] = O_c3_2_l0_c0_i1[0];
    
    assign l0_c0_i1            = COUT_LA_l0_c0_s0[0];
    assign CY_LA_l0_c0_s0[1]   = CY_c3_2_l0_c0_i1;
    assign PROP_LA_l0_c0_s0[1] = PROP_c3_2_l0_c0_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i2  ),
        .C1  (C1_c15_3_l0_c0_i2  ),
        .CLA (CLA_c15_3_l0_c0_i2 ),
        .O   (O_c15_3_l0_c0_i2   ),
        .CY  (CY_c15_3_l0_c0_i2  ),
        .PROP(PROP_c15_3_l0_c0_i2));
    
    assign C0_c15_3_l0_c0_i2 = {l0_c0_i1, layer0_col8[3:0]};
    assign C1_c15_3_l0_c0_i2 = layer0_col9[0];
    
    assign layer1_col8[0]  = O_c15_3_l0_c0_i2[0];
    assign layer1_col9[0]  = O_c15_3_l0_c0_i2[1];
    
    assign l0_c0_i2              = COUT_LA_l0_c0_s0[1];
    assign CY_LA_l0_c0_s0[3:2]   = CY_c15_3_l0_c0_i2;
    assign PROP_LA_l0_c0_s0[3:2] = PROP_c15_3_l0_c0_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i3  ),
        .C1  (C1_c15_3_l0_c0_i3  ),
        .CLA (CLA_c15_3_l0_c0_i3 ),
        .O   (O_c15_3_l0_c0_i3   ),
        .CY  (CY_c15_3_l0_c0_i3  ),
        .PROP(PROP_c15_3_l0_c0_i3));
    
    assign C0_c15_3_l0_c0_i3 = {l0_c0_i2, layer0_col10[3:0]};
    assign C1_c15_3_l0_c0_i3 = layer0_col11[0];
    
    assign layer1_col10[0] = O_c15_3_l0_c0_i3[0];
    assign layer1_col11[0] = O_c15_3_l0_c0_i3[1];
    
    assign l0_c0_i3              = COUT_LA_l0_c0_s0[2];
    assign CY_LA_l0_c0_s0[5:4]   = CY_c15_3_l0_c0_i3;
    assign PROP_LA_l0_c0_s0[5:4] = PROP_c15_3_l0_c0_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c0_i4(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c0_i4  ),
        .O   (O_c3_2_l0_c0_i4   ),
        .CY  (CY_c3_2_l0_c0_i4  ),
        .PROP(PROP_c3_2_l0_c0_i4));
    
    assign C0_c3_2_l0_c0_i4 = {l0_c0_i3, layer0_col12[1:0]};
    
    assign layer1_col12[0] = O_c3_2_l0_c0_i4[0];
    
    assign l0_c0_i4            = O_c3_2_l0_c0_i4[1];
    assign CY_LA_l0_c0_s0[6]   = CY_c3_2_l0_c0_i4;
    assign PROP_LA_l0_c0_s0[6] = PROP_c3_2_l0_c0_i4;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c0_i5(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c0_i5  ),
        .O   (O_c3_2_l0_c0_i5   ),
        .CY  (CY_c3_2_l0_c0_i5  ),
        .PROP(PROP_c3_2_l0_c0_i5));
    
    assign C0_c3_2_l0_c0_i5 = {l0_c0_i4, layer0_col13[1:0]};
    
    assign layer1_col13[0] = O_c3_2_l0_c0_i5[0];
    assign layer1_col14[0] = O_c3_2_l0_c0_i5[1];
    
    assign l0_c0_i5            = COUT_LA_l0_c0_s0[3];
    assign CY_LA_l0_c0_s0[7]   = CY_c3_2_l0_c0_i5;
    assign PROP_LA_l0_c0_s0[7] = PROP_c3_2_l0_c0_i5;
    
    // GPC0 in layer0: (3 : 2] at column 9
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_f0(
        .clk (clk            ),
        .C0  (C0_c3_2_l0_f0  ),
        .O   (O_c3_2_l0_i0   ),
        .CY  (CY_c3_2_l0_f0  ),
        .PROP(PROP_c3_2_l0_f0));
    
    assign C0_c3_2_l0_f0 = layer0_col9[3:1];
    
    assign layer1_col9[1]  = O_c3_2_l0_i0[0];
    assign layer1_col10[1] = O_c3_2_l0_i0[1];
    
    // GPC1 in layer0: (3 : 2] at column 11
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_f1(
        .clk (clk            ),
        .C0  (C0_c3_2_l0_f1  ),
        .O   (O_c3_2_l0_i1   ),
        .CY  (CY_c3_2_l0_f1  ),
        .PROP(PROP_c3_2_l0_f1));
    
    assign C0_c3_2_l0_f1 = layer0_col11[3:1];
    
    assign layer1_col11[1] = O_c3_2_l0_i1[0];
    assign layer1_col12[1] = O_c3_2_l0_i1[1];
    
    assign layer1_col0[0] = layer0_col0[0];
    assign layer1_col0[1] = layer0_col0[1];
    assign layer1_col1    = layer0_col1;
    assign layer1_col2[0] = layer0_col2[0];
    assign layer1_col2[1] = layer0_col2[1];
    assign layer1_col2[2] = layer0_col2[2];
    assign layer1_col3[0] = layer0_col3[0];
    assign layer1_col3[1] = layer0_col3[1];
    assign layer1_col4[0] = layer0_col4[0];
    assign layer1_col4[1] = layer0_col4[1];
    assign layer1_col4[2] = layer0_col4[2];
    assign layer1_col4[3] = layer0_col4[3];
    assign layer1_col5[0] = layer0_col5[0];
    assign layer1_col5[1] = layer0_col5[1];
    assign layer1_col5[2] = layer0_col5[2];
    assign layer1_col6[1] = layer0_col6[3];
    assign layer1_col6[2] = layer0_col6[4];
    assign layer1_col7[1] = layer0_col7[2];
    assign layer1_col7[2] = layer0_col7[3];
    assign layer1_col8[1] = layer0_col8[4];
    assign layer1_col8[2] = layer0_col8[5];
    assign layer1_col9[2] = layer0_col9[4];
    assign layer1_col10[2] = layer0_col10[4];
    assign layer1_col10[3] = layer0_col10[5];
    assign layer1_col11[2] = layer0_col11[4];
    assign layer1_col12[2] = layer0_col12[2];
    assign layer1_col12[3] = layer0_col12[3];
    assign layer1_col13[1] = layer0_col13[2];
    assign layer1_col13[2] = layer0_col13[3];
    assign layer1_col14[1] = layer0_col14[0];
    assign layer1_col14[2] = layer0_col14[1];
    assign layer1_col14[3] = layer0_col14[2];
    assign layer1_col15[0] = layer0_col15[0];
    assign layer1_col15[1] = layer0_col15[1];
    assign layer1_col15[2] = layer0_col15[2];
    assign layer1_col16[0] = layer0_col16[0];
    assign layer1_col16[1] = layer0_col16[1];
    assign layer1_col17[0] = layer0_col17[0];
    assign layer1_col17[1] = layer0_col17[1];
    assign layer1_col18    = layer0_col18;
    assign layer1_col19    = layer0_col19;
    
    
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
        .CIN  (CIN_LA_terminal_chain1[0] ),
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

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst1 (
        .COUTB(COUT_LA_terminal_chain1[4] ),
        .COUTD(COUT_LA_terminal_chain1[5] ),
        .COUTF(COUT_LA_terminal_chain1[6] ),
        .COUTH(COUT_LA_terminal_chain1[7] ),
        .CIN  (CIN_LA_terminal_chain1[1]  ),
        .CYA  (CY_LA_terminal_chain1[8]   ),
        .CYB  (CY_LA_terminal_chain1[9]   ),
        .CYC  (CY_LA_terminal_chain1[10]  ),
        .CYD  (CY_LA_terminal_chain1[11]  ),
        .CYE  (CY_LA_terminal_chain1[12]  ),
        .CYF  (CY_LA_terminal_chain1[13]  ),
        .CYG  (CY_LA_terminal_chain1[14]  ),
        .CYH  (CY_LA_terminal_chain1[15]  ),
        .PROPA(PROP_LA_terminal_chain1[8] ),
        .PROPB(PROP_LA_terminal_chain1[9] ),
        .PROPC(PROP_LA_terminal_chain1[10]),
        .PROPD(PROP_LA_terminal_chain1[11]),
        .PROPE(PROP_LA_terminal_chain1[12]),
        .PROPF(PROP_LA_terminal_chain1[13]),
        .PROPG(PROP_LA_terminal_chain1[14]),
        .PROPH(PROP_LA_terminal_chain1[15]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst2 (
        .COUTB(COUT_LA_terminal_chain1[8] ),
        .COUTD(COUT_LA_terminal_chain1[9] ),
        .COUTF(COUT_LA_terminal_chain1[10]),
        .COUTH(COUT_LA_terminal_chain1[11]),
        .CIN  (CIN_LA_terminal_chain1[2]  ),
        .CYA  (CY_LA_terminal_chain1[16]  ),
        .CYB  (CY_LA_terminal_chain1[17]  ),
        .CYC  (CY_LA_terminal_chain1[18]  ),
        .CYD  (CY_LA_terminal_chain1[19]  ),
        .CYE  (CY_LA_terminal_chain1[20]  ),
        .CYF  (CY_LA_terminal_chain1[21]  ),
        .CYG  (CY_LA_terminal_chain1[22]  ),
        .CYH  (CY_LA_terminal_chain1[23]  ),
        .PROPA(PROP_LA_terminal_chain1[16]),
        .PROPB(PROP_LA_terminal_chain1[17]),
        .PROPC(PROP_LA_terminal_chain1[18]),
        .PROPD(PROP_LA_terminal_chain1[19]),
        .PROPE(PROP_LA_terminal_chain1[20]),
        .PROPF(PROP_LA_terminal_chain1[21]),
        .PROPG(PROP_LA_terminal_chain1[22]),
        .PROPH(PROP_LA_terminal_chain1[23]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_terminal_chain1_i0(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain1_i0  ),
        .O   (O_c3_2_terminal_chain1_i0   ),
        .CY  (CY_c3_2_terminal_chain1_i0  ),
        .PROP(PROP_c3_2_terminal_chain1_i0));
    
    assign C0_c3_2_terminal_chain1_i0[0] = layer1_col0[0];
    assign C0_c3_2_terminal_chain1_i0[1] = layer1_col0[1];
    assign C0_c3_2_terminal_chain1_i0[2] = 1'b0;
    
    assign terminal_chain1_out[0] = O_c3_2_terminal_chain1_i0[0];
    
    assign terminal_chain1_i0         = O_c3_2_terminal_chain1_i0[1];
    assign CY_LA_terminal_chain1[0]   = CY_c3_2_terminal_chain1_i0;
    assign PROP_LA_terminal_chain1[0] = PROP_c3_2_terminal_chain1_i0;
    
    assign CIN_LA_terminal_chain1[0] = C0_c3_2_terminal_chain1_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_terminal_chain1_i1(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain1_i1  ),
        .O   (O_c3_2_terminal_chain1_i1   ),
        .CY  (CY_c3_2_terminal_chain1_i1  ),
        .PROP(PROP_c3_2_terminal_chain1_i1));
    
    assign C0_c3_2_terminal_chain1_i1[2] = terminal_chain1_i0;
    assign C0_c3_2_terminal_chain1_i1[0] = layer1_col1;
    assign C0_c3_2_terminal_chain1_i1[1] = 1'b0;
    
    assign terminal_chain1_out[1] = O_c3_2_terminal_chain1_i1[0];
    
    assign terminal_chain1_i1         = COUT_LA_terminal_chain1[0];
    assign CY_LA_terminal_chain1[1]   = CY_c3_2_terminal_chain1_i1;
    assign PROP_LA_terminal_chain1[1] = PROP_c3_2_terminal_chain1_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer1_col2[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer1_col2[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer1_col2[2];
    assign C1_c15_3_terminal_chain1_i2    = layer1_col3[0];
    
    assign terminal_chain1_out[2] = O_c15_3_terminal_chain1_i2[0];
    assign terminal_chain1_out[3] = O_c15_3_terminal_chain1_i2[1];
    
    assign terminal_chain1_i2           = COUT_LA_terminal_chain1[1];
    assign CY_LA_terminal_chain1[3:2]   = CY_c15_3_terminal_chain1_i2;
    assign PROP_LA_terminal_chain1[3:2] = PROP_c15_3_terminal_chain1_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i3(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i3  ),
        .C1  (C1_c15_3_terminal_chain1_i3  ),
        .CLA (CLA_c15_3_terminal_chain1_i3 ),
        .O   (O_c15_3_terminal_chain1_i3   ),
        .CY  (CY_c15_3_terminal_chain1_i3  ),
        .PROP(PROP_c15_3_terminal_chain1_i3));
    
    assign C0_c15_3_terminal_chain1_i3[4] = terminal_chain1_i2;
    assign C0_c15_3_terminal_chain1_i3[0] = layer1_col4[0];
    assign C0_c15_3_terminal_chain1_i3[1] = layer1_col4[1];
    assign C0_c15_3_terminal_chain1_i3[2] = layer1_col4[2];
    assign C0_c15_3_terminal_chain1_i3[3] = layer1_col4[3];
    assign C1_c15_3_terminal_chain1_i3    = layer1_col5[0];
    
    assign terminal_chain1_out[4] = O_c15_3_terminal_chain1_i3[0];
    assign terminal_chain1_out[5] = O_c15_3_terminal_chain1_i3[1];
    
    assign terminal_chain1_i3           = COUT_LA_terminal_chain1[2];
    assign CY_LA_terminal_chain1[5:4]   = CY_c15_3_terminal_chain1_i3;
    assign PROP_LA_terminal_chain1[5:4] = PROP_c15_3_terminal_chain1_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i4(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i4  ),
        .C1  (C1_c15_3_terminal_chain1_i4  ),
        .CLA (CLA_c15_3_terminal_chain1_i4 ),
        .O   (O_c15_3_terminal_chain1_i4   ),
        .CY  (CY_c15_3_terminal_chain1_i4  ),
        .PROP(PROP_c15_3_terminal_chain1_i4));
    
    assign C0_c15_3_terminal_chain1_i4[4] = terminal_chain1_i3;
    assign C0_c15_3_terminal_chain1_i4[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i4[1] = layer1_col6[0];
    assign C0_c15_3_terminal_chain1_i4[2] = layer1_col6[1];
    assign C0_c15_3_terminal_chain1_i4[3] = layer1_col6[2];
    assign C1_c15_3_terminal_chain1_i4    = layer1_col7[0];
    
    assign terminal_chain1_out[6] = O_c15_3_terminal_chain1_i4[0];
    assign terminal_chain1_out[7] = O_c15_3_terminal_chain1_i4[1];
    
    assign terminal_chain1_i4           = COUT_LA_terminal_chain1[3];
    assign CY_LA_terminal_chain1[7:6]   = CY_c15_3_terminal_chain1_i4;
    assign PROP_LA_terminal_chain1[7:6] = PROP_c15_3_terminal_chain1_i4;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i5(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i5  ),
        .C1  (C1_c15_3_terminal_chain1_i5  ),
        .CLA (CLA_c15_3_terminal_chain1_i5 ),
        .O   (O_c15_3_terminal_chain1_i5   ),
        .CY  (CY_c15_3_terminal_chain1_i5  ),
        .PROP(PROP_c15_3_terminal_chain1_i5));
    
    assign C0_c15_3_terminal_chain1_i5[4] = terminal_chain1_i4;
    assign C0_c15_3_terminal_chain1_i5[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i5[1] = layer1_col8[0];
    assign C0_c15_3_terminal_chain1_i5[2] = layer1_col8[1];
    assign C0_c15_3_terminal_chain1_i5[3] = layer1_col8[2];
    assign C1_c15_3_terminal_chain1_i5    = layer1_col9[0];
    
    assign terminal_chain1_out[8]  = O_c15_3_terminal_chain1_i5[0];
    assign terminal_chain1_out[9]  = O_c15_3_terminal_chain1_i5[1];
    
    assign terminal_chain1_i5           = COUT_LA_terminal_chain1[4];
    assign CY_LA_terminal_chain1[9:8]   = CY_c15_3_terminal_chain1_i5;
    assign PROP_LA_terminal_chain1[9:8] = PROP_c15_3_terminal_chain1_i5;
    
    assign CIN_LA_terminal_chain1[1] = COUT_LA_terminal_chain1[3];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i6(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i6  ),
        .C1  (C1_c15_3_terminal_chain1_i6  ),
        .CLA (CLA_c15_3_terminal_chain1_i6 ),
        .O   (O_c15_3_terminal_chain1_i6   ),
        .CY  (CY_c15_3_terminal_chain1_i6  ),
        .PROP(PROP_c15_3_terminal_chain1_i6));
    
    assign C0_c15_3_terminal_chain1_i6[4] = terminal_chain1_i5;
    assign C0_c15_3_terminal_chain1_i6[0] = layer1_col10[0];
    assign C0_c15_3_terminal_chain1_i6[1] = layer1_col10[1];
    assign C0_c15_3_terminal_chain1_i6[2] = layer1_col10[2];
    assign C0_c15_3_terminal_chain1_i6[3] = layer1_col10[3];
    assign C1_c15_3_terminal_chain1_i6    = layer1_col11[0];
    
    assign terminal_chain1_out[10] = O_c15_3_terminal_chain1_i6[0];
    assign terminal_chain1_out[11] = O_c15_3_terminal_chain1_i6[1];
    
    assign terminal_chain1_i6             = COUT_LA_terminal_chain1[5];
    assign CY_LA_terminal_chain1[11:10]   = CY_c15_3_terminal_chain1_i6;
    assign PROP_LA_terminal_chain1[11:10] = PROP_c15_3_terminal_chain1_i6;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i7(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i7  ),
        .C1  (C1_c15_3_terminal_chain1_i7  ),
        .CLA (CLA_c15_3_terminal_chain1_i7 ),
        .O   (O_c15_3_terminal_chain1_i7   ),
        .CY  (CY_c15_3_terminal_chain1_i7  ),
        .PROP(PROP_c15_3_terminal_chain1_i7));
    
    assign C0_c15_3_terminal_chain1_i7[4] = terminal_chain1_i6;
    assign C0_c15_3_terminal_chain1_i7[0] = layer1_col12[0];
    assign C0_c15_3_terminal_chain1_i7[1] = layer1_col12[1];
    assign C0_c15_3_terminal_chain1_i7[2] = layer1_col12[2];
    assign C0_c15_3_terminal_chain1_i7[3] = layer1_col12[3];
    assign C1_c15_3_terminal_chain1_i7    = layer1_col13[0];
    
    assign terminal_chain1_out[12] = O_c15_3_terminal_chain1_i7[0];
    assign terminal_chain1_out[13] = O_c15_3_terminal_chain1_i7[1];
    
    assign terminal_chain1_i7             = COUT_LA_terminal_chain1[6];
    assign CY_LA_terminal_chain1[13:12]   = CY_c15_3_terminal_chain1_i7;
    assign PROP_LA_terminal_chain1[13:12] = PROP_c15_3_terminal_chain1_i7;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i8(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i8  ),
        .C1  (C1_c15_3_terminal_chain1_i8  ),
        .CLA (CLA_c15_3_terminal_chain1_i8 ),
        .O   (O_c15_3_terminal_chain1_i8   ),
        .CY  (CY_c15_3_terminal_chain1_i8  ),
        .PROP(PROP_c15_3_terminal_chain1_i8));
    
    assign C0_c15_3_terminal_chain1_i8[4] = terminal_chain1_i7;
    assign C0_c15_3_terminal_chain1_i8[0] = layer1_col14[0];
    assign C0_c15_3_terminal_chain1_i8[1] = layer1_col14[1];
    assign C0_c15_3_terminal_chain1_i8[2] = layer1_col14[2];
    assign C0_c15_3_terminal_chain1_i8[3] = layer1_col14[3];
    assign C1_c15_3_terminal_chain1_i8    = layer1_col15[0];
    
    assign terminal_chain1_out[14] = O_c15_3_terminal_chain1_i8[0];
    assign terminal_chain1_out[15] = O_c15_3_terminal_chain1_i8[1];
    
    assign terminal_chain1_i8             = COUT_LA_terminal_chain1[7];
    assign CY_LA_terminal_chain1[15:14]   = CY_c15_3_terminal_chain1_i8;
    assign PROP_LA_terminal_chain1[15:14] = PROP_c15_3_terminal_chain1_i8;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain1_i9(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain1_i9  ),
        .O   (O_c3_2_terminal_chain1_i9   ),
        .CY  (CY_c3_2_terminal_chain1_i9  ),
        .PROP(PROP_c3_2_terminal_chain1_i9));
    
    assign C0_c3_2_terminal_chain1_i9[2] = terminal_chain1_i8;
    assign C0_c3_2_terminal_chain1_i9[0] = layer1_col16[0];
    assign C0_c3_2_terminal_chain1_i9[1] = layer1_col16[1];
    
    assign terminal_chain1_out[16] = O_c3_2_terminal_chain1_i9[0];
    
    assign terminal_chain1_i9          = O_c3_2_terminal_chain1_i9[1];
    assign CY_LA_terminal_chain1[16]   = CY_c3_2_terminal_chain1_i9;
    assign PROP_LA_terminal_chain1[16] = PROP_c3_2_terminal_chain1_i9;
    
    assign CIN_LA_terminal_chain1[2] = COUT_LA_terminal_chain1[7];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain1_i10(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain1_i10  ),
        .O   (O_c3_2_terminal_chain1_i10   ),
        .CY  (CY_c3_2_terminal_chain1_i10  ),
        .PROP(PROP_c3_2_terminal_chain1_i10));
    
    assign C0_c3_2_terminal_chain1_i10[2] = terminal_chain1_i9;
    assign C0_c3_2_terminal_chain1_i10[0] = layer1_col17[0];
    assign C0_c3_2_terminal_chain1_i10[1] = layer1_col17[1];
    
    assign terminal_chain1_out[17] = O_c3_2_terminal_chain1_i10[0];
    assign terminal_chain1_out[18] = O_c3_2_terminal_chain1_i10[1];
    
    assign terminal_chain1_i10         = COUT_LA_terminal_chain1[8];
    assign CY_LA_terminal_chain1[17]   = CY_c3_2_terminal_chain1_i10;
    assign PROP_LA_terminal_chain1[17] = PROP_c3_2_terminal_chain1_i10;
    
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
        .CIN  (CIN_LA_terminal_chain2[0] ),
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

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst1 (
        .COUTB(COUT_LA_terminal_chain2[4] ),
        .COUTD(COUT_LA_terminal_chain2[5] ),
        .COUTF(COUT_LA_terminal_chain2[6] ),
        .COUTH(COUT_LA_terminal_chain2[7] ),
        .CIN  (CIN_LA_terminal_chain2[1]  ),
        .CYA  (CY_LA_terminal_chain2[8]   ),
        .CYB  (CY_LA_terminal_chain2[9]   ),
        .CYC  (CY_LA_terminal_chain2[10]  ),
        .CYD  (CY_LA_terminal_chain2[11]  ),
        .CYE  (CY_LA_terminal_chain2[12]  ),
        .CYF  (CY_LA_terminal_chain2[13]  ),
        .CYG  (CY_LA_terminal_chain2[14]  ),
        .CYH  (CY_LA_terminal_chain2[15]  ),
        .PROPA(PROP_LA_terminal_chain2[8] ),
        .PROPB(PROP_LA_terminal_chain2[9] ),
        .PROPC(PROP_LA_terminal_chain2[10]),
        .PROPD(PROP_LA_terminal_chain2[11]),
        .PROPE(PROP_LA_terminal_chain2[12]),
        .PROPF(PROP_LA_terminal_chain2[13]),
        .PROPG(PROP_LA_terminal_chain2[14]),
        .PROPH(PROP_LA_terminal_chain2[15]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst2 (
        .COUTB(COUT_LA_terminal_chain2[8] ),
        .COUTD(COUT_LA_terminal_chain2[9] ),
        .COUTF(COUT_LA_terminal_chain2[10]),
        .COUTH(COUT_LA_terminal_chain2[11]),
        .CIN  (CIN_LA_terminal_chain2[2]  ),
        .CYA  (CY_LA_terminal_chain2[16]  ),
        .CYB  (CY_LA_terminal_chain2[17]  ),
        .CYC  (CY_LA_terminal_chain2[18]  ),
        .CYD  (CY_LA_terminal_chain2[19]  ),
        .CYE  (CY_LA_terminal_chain2[20]  ),
        .CYF  (CY_LA_terminal_chain2[21]  ),
        .CYG  (CY_LA_terminal_chain2[22]  ),
        .CYH  (CY_LA_terminal_chain2[23]  ),
        .PROPA(PROP_LA_terminal_chain2[16]),
        .PROPB(PROP_LA_terminal_chain2[17]),
        .PROPC(PROP_LA_terminal_chain2[18]),
        .PROPD(PROP_LA_terminal_chain2[19]),
        .PROPE(PROP_LA_terminal_chain2[20]),
        .PROPF(PROP_LA_terminal_chain2[21]),
        .PROPG(PROP_LA_terminal_chain2[22]),
        .PROPH(PROP_LA_terminal_chain2[23]));

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
    assign C0_c15_3_terminal_chain2_i0[3] = terminal_chain1_out[3];
    assign C0_c15_3_terminal_chain2_i0[2] = layer1_col3[1];
    assign C0_c15_3_terminal_chain2_i0[1] = 1'b0;
    assign C0_c15_3_terminal_chain2_i0[0] = 1'b0;
    assign C1_c15_3_terminal_chain2_i0    = terminal_chain1_out[4];
    
    assign terminal_chain2_out[0] = O_c15_3_terminal_chain2_i0[0];
    assign terminal_chain2_out[1] = O_c15_3_terminal_chain2_i0[1];
    
    assign terminal_chain2_i0           = COUT_LA_terminal_chain2[0];
    assign CY_LA_terminal_chain2[1:0]   = CY_c15_3_terminal_chain2_i0;
    assign PROP_LA_terminal_chain2[1:0] = PROP_c15_3_terminal_chain2_i0;
    
    assign CIN_LA_terminal_chain2[0] = C0_c15_3_terminal_chain2_i0[4];
    
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
    assign C0_c15_3_terminal_chain2_i1[3] = terminal_chain1_out[5];
    assign C0_c15_3_terminal_chain2_i1[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i1[1] = layer1_col5[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer1_col5[2];
    assign C1_c15_3_terminal_chain2_i1    = terminal_chain1_out[6];
    
    assign terminal_chain2_out[2] = O_c15_3_terminal_chain2_i1[0];
    assign terminal_chain2_out[3] = O_c15_3_terminal_chain2_i1[1];
    
    assign terminal_chain2_i1           = COUT_LA_terminal_chain2[1];
    assign CY_LA_terminal_chain2[3:2]   = CY_c15_3_terminal_chain2_i1;
    assign PROP_LA_terminal_chain2[3:2] = PROP_c15_3_terminal_chain2_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i2(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i2  ),
        .C1  (C1_c15_3_terminal_chain2_i2  ),
        .CLA (CLA_c15_3_terminal_chain2_i2 ),
        .O   (O_c15_3_terminal_chain2_i2   ),
        .CY  (CY_c15_3_terminal_chain2_i2  ),
        .PROP(PROP_c15_3_terminal_chain2_i2));
    
    assign C0_c15_3_terminal_chain2_i2[4] = terminal_chain2_i1;
    assign C0_c15_3_terminal_chain2_i2[3] = terminal_chain1_out[7];
    assign C0_c15_3_terminal_chain2_i2[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i2[1] = layer1_col7[1];
    assign C0_c15_3_terminal_chain2_i2[2] = layer1_col7[2];
    assign C1_c15_3_terminal_chain2_i2    = terminal_chain1_out[8];
    
    assign terminal_chain2_out[4] = O_c15_3_terminal_chain2_i2[0];
    assign terminal_chain2_out[5] = O_c15_3_terminal_chain2_i2[1];
    
    assign terminal_chain2_i2           = COUT_LA_terminal_chain2[2];
    assign CY_LA_terminal_chain2[5:4]   = CY_c15_3_terminal_chain2_i2;
    assign PROP_LA_terminal_chain2[5:4] = PROP_c15_3_terminal_chain2_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i3(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i3  ),
        .C1  (C1_c15_3_terminal_chain2_i3  ),
        .CLA (CLA_c15_3_terminal_chain2_i3 ),
        .O   (O_c15_3_terminal_chain2_i3   ),
        .CY  (CY_c15_3_terminal_chain2_i3  ),
        .PROP(PROP_c15_3_terminal_chain2_i3));
    
    assign C0_c15_3_terminal_chain2_i3[4] = terminal_chain2_i2;
    assign C0_c15_3_terminal_chain2_i3[3] = terminal_chain1_out[9];
    assign C0_c15_3_terminal_chain2_i3[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i3[1] = layer1_col9[1];
    assign C0_c15_3_terminal_chain2_i3[2] = layer1_col9[2];
    assign C1_c15_3_terminal_chain2_i3    = terminal_chain1_out[10];
    
    assign terminal_chain2_out[6] = O_c15_3_terminal_chain2_i3[0];
    assign terminal_chain2_out[7] = O_c15_3_terminal_chain2_i3[1];
    
    assign terminal_chain2_i3           = COUT_LA_terminal_chain2[3];
    assign CY_LA_terminal_chain2[7:6]   = CY_c15_3_terminal_chain2_i3;
    assign PROP_LA_terminal_chain2[7:6] = PROP_c15_3_terminal_chain2_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i4(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i4  ),
        .C1  (C1_c15_3_terminal_chain2_i4  ),
        .CLA (CLA_c15_3_terminal_chain2_i4 ),
        .O   (O_c15_3_terminal_chain2_i4   ),
        .CY  (CY_c15_3_terminal_chain2_i4  ),
        .PROP(PROP_c15_3_terminal_chain2_i4));
    
    assign C0_c15_3_terminal_chain2_i4[4] = terminal_chain2_i3;
    assign C0_c15_3_terminal_chain2_i4[3] = terminal_chain1_out[11];
    assign C0_c15_3_terminal_chain2_i4[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i4[1] = layer1_col11[1];
    assign C0_c15_3_terminal_chain2_i4[2] = layer1_col11[2];
    assign C1_c15_3_terminal_chain2_i4    = terminal_chain1_out[12];
    
    assign terminal_chain2_out[8]  = O_c15_3_terminal_chain2_i4[0];
    assign terminal_chain2_out[9]  = O_c15_3_terminal_chain2_i4[1];
    
    assign terminal_chain2_i4           = COUT_LA_terminal_chain2[4];
    assign CY_LA_terminal_chain2[9:8]   = CY_c15_3_terminal_chain2_i4;
    assign PROP_LA_terminal_chain2[9:8] = PROP_c15_3_terminal_chain2_i4;
    
    assign CIN_LA_terminal_chain2[1] = COUT_LA_terminal_chain2[3];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i5(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i5  ),
        .C1  (C1_c15_3_terminal_chain2_i5  ),
        .CLA (CLA_c15_3_terminal_chain2_i5 ),
        .O   (O_c15_3_terminal_chain2_i5   ),
        .CY  (CY_c15_3_terminal_chain2_i5  ),
        .PROP(PROP_c15_3_terminal_chain2_i5));
    
    assign C0_c15_3_terminal_chain2_i5[4] = terminal_chain2_i4;
    assign C0_c15_3_terminal_chain2_i5[3] = terminal_chain1_out[13];
    assign C0_c15_3_terminal_chain2_i5[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i5[1] = layer1_col13[1];
    assign C0_c15_3_terminal_chain2_i5[2] = layer1_col13[2];
    assign C1_c15_3_terminal_chain2_i5    = terminal_chain1_out[14];
    
    assign terminal_chain2_out[10] = O_c15_3_terminal_chain2_i5[0];
    assign terminal_chain2_out[11] = O_c15_3_terminal_chain2_i5[1];
    
    assign terminal_chain2_i5             = COUT_LA_terminal_chain2[5];
    assign CY_LA_terminal_chain2[11:10]   = CY_c15_3_terminal_chain2_i5;
    assign PROP_LA_terminal_chain2[11:10] = PROP_c15_3_terminal_chain2_i5;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i6(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i6  ),
        .C1  (C1_c15_3_terminal_chain2_i6  ),
        .CLA (CLA_c15_3_terminal_chain2_i6 ),
        .O   (O_c15_3_terminal_chain2_i6   ),
        .CY  (CY_c15_3_terminal_chain2_i6  ),
        .PROP(PROP_c15_3_terminal_chain2_i6));
    
    assign C0_c15_3_terminal_chain2_i6[4] = terminal_chain2_i5;
    assign C0_c15_3_terminal_chain2_i6[3] = terminal_chain1_out[15];
    assign C0_c15_3_terminal_chain2_i6[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i6[1] = layer1_col15[1];
    assign C0_c15_3_terminal_chain2_i6[2] = layer1_col15[2];
    assign C1_c15_3_terminal_chain2_i6    = terminal_chain1_out[16];
    
    assign terminal_chain2_out[12] = O_c15_3_terminal_chain2_i6[0];
    assign terminal_chain2_out[13] = O_c15_3_terminal_chain2_i6[1];
    
    assign terminal_chain2_i6             = COUT_LA_terminal_chain2[6];
    assign CY_LA_terminal_chain2[13:12]   = CY_c15_3_terminal_chain2_i6;
    assign PROP_LA_terminal_chain2[13:12] = PROP_c15_3_terminal_chain2_i6;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i7(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i7  ),
        .O   (O_c3_2_terminal_chain2_i7   ),
        .CY  (CY_c3_2_terminal_chain2_i7  ),
        .PROP(PROP_c3_2_terminal_chain2_i7));
    
    assign C0_c3_2_terminal_chain2_i7[2] = terminal_chain2_i6;
    assign C0_c3_2_terminal_chain2_i7[0] = terminal_chain1_out[17];
    assign C0_c3_2_terminal_chain2_i7[1] = 1'b0;
    
    assign terminal_chain2_out[14] = O_c3_2_terminal_chain2_i7[0];
    
    assign terminal_chain2_i7          = O_c3_2_terminal_chain2_i7[1];
    assign CY_LA_terminal_chain2[14]   = CY_c3_2_terminal_chain2_i7;
    assign PROP_LA_terminal_chain2[14] = PROP_c3_2_terminal_chain2_i7;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i8(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i8  ),
        .O   (O_c3_2_terminal_chain2_i8   ),
        .CY  (CY_c3_2_terminal_chain2_i8  ),
        .PROP(PROP_c3_2_terminal_chain2_i8));
    
    assign C0_c3_2_terminal_chain2_i8[2] = terminal_chain2_i7;
    assign C0_c3_2_terminal_chain2_i8[0] = terminal_chain1_out[18];
    assign C0_c3_2_terminal_chain2_i8[1] = layer1_col18;
    
    assign terminal_chain2_out[15] = O_c3_2_terminal_chain2_i8[0];
    
    assign terminal_chain2_i8          = COUT_LA_terminal_chain2[7];
    assign CY_LA_terminal_chain2[15]   = CY_c3_2_terminal_chain2_i8;
    assign PROP_LA_terminal_chain2[15] = PROP_c3_2_terminal_chain2_i8;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i9(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i9  ),
        .O   (O_c3_2_terminal_chain2_i9   ),
        .CY  (CY_c3_2_terminal_chain2_i9  ),
        .PROP(PROP_c3_2_terminal_chain2_i9));
    
    assign C0_c3_2_terminal_chain2_i9[2] = terminal_chain2_i8;
    assign C0_c3_2_terminal_chain2_i9[0] = 1'b0;
    assign C0_c3_2_terminal_chain2_i9[1] = layer1_col19;
    
    assign terminal_chain2_out[16] = O_c3_2_terminal_chain2_i9[0];
    assign terminal_chain2_out[17] = O_c3_2_terminal_chain2_i9[1];
    
    assign terminal_chain2_i9          = O_c3_2_terminal_chain2_i9[1];
    assign CY_LA_terminal_chain2[16]   = CY_c3_2_terminal_chain2_i9;
    assign PROP_LA_terminal_chain2[16] = PROP_c3_2_terminal_chain2_i9;
    
    assign CIN_LA_terminal_chain2[2] = COUT_LA_terminal_chain2[7];
    
    always_ff @(posedge clk) begin
        comp_out[2:0] <= terminal_chain1_out[2:0];
    
        comp_out[20:3] <= terminal_chain2_out[17:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = col0;
    assign layer0_col1    = col1;
    assign layer0_col2    = col2;
    assign layer0_col3    = col3;
    assign layer0_col4    = col4;
    assign layer0_col5    = col5;
    assign layer0_col6    = col6;
    assign layer0_col7    = col7;
    assign layer0_col8    = col8;
    assign layer0_col9    = col9;
    assign layer0_col10   = col10;
    assign layer0_col11   = col11;
    assign layer0_col12   = col12;
    assign layer0_col13   = col13;
    assign layer0_col14   = col14;
    assign layer0_col15   = col15;
    assign layer0_col16   = col16;
    assign layer0_col17   = col17;
    assign layer0_col18   = col18;
    assign layer0_col19   = col19;
    
endmodule