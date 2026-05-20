`timescale 1ns / 1ps

module Comp_single256_4 (
    input  logic           clk,
    input  logic [255 : 0] in_col0,
    output logic [8   : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [255 : 0] layer0_col0;
    
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
    
    logic [8 : 0] C0_c9_41_l0_f6;
    logic         CLA_c9_41_l0_f6;
    logic         O0_c9_41_l0_f6;
    logic [3 : 0] O1_c9_41_l0_f6;
    logic [1 : 0] CY_c9_41_l0_f6;
    logic [1 : 0] PROP_c9_41_l0_f6;
    
    logic [8 : 0] C0_c9_41_l0_f7;
    logic         CLA_c9_41_l0_f7;
    logic         O0_c9_41_l0_f7;
    logic [3 : 0] O1_c9_41_l0_f7;
    logic [1 : 0] CY_c9_41_l0_f7;
    logic [1 : 0] PROP_c9_41_l0_f7;
    
    logic [8 : 0] C0_c9_41_l0_f8;
    logic         CLA_c9_41_l0_f8;
    logic         O0_c9_41_l0_f8;
    logic [3 : 0] O1_c9_41_l0_f8;
    logic [1 : 0] CY_c9_41_l0_f8;
    logic [1 : 0] PROP_c9_41_l0_f8;
    
    logic [8 : 0] C0_c9_41_l0_f9;
    logic         CLA_c9_41_l0_f9;
    logic         O0_c9_41_l0_f9;
    logic [3 : 0] O1_c9_41_l0_f9;
    logic [1 : 0] CY_c9_41_l0_f9;
    logic [1 : 0] PROP_c9_41_l0_f9;
    
    logic [8 : 0] C0_c9_41_l0_f10;
    logic         CLA_c9_41_l0_f10;
    logic         O0_c9_41_l0_f10;
    logic [3 : 0] O1_c9_41_l0_f10;
    logic [1 : 0] CY_c9_41_l0_f10;
    logic [1 : 0] PROP_c9_41_l0_f10;
    
    logic [8 : 0] C0_c9_41_l0_f11;
    logic         CLA_c9_41_l0_f11;
    logic         O0_c9_41_l0_f11;
    logic [3 : 0] O1_c9_41_l0_f11;
    logic [1 : 0] CY_c9_41_l0_f11;
    logic [1 : 0] PROP_c9_41_l0_f11;
    
    logic [11 : 0] COUT_LA_l0_floating_placement;
    logic [2  : 0] CIN_LA_l0_floating_placement;
    logic [23 : 0] CY_LA_l0_floating_placement;
    logic [23 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
    logic [159 : 0] layer1_col0;
    logic [47  : 0] layer1_col1;
    
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
    
    logic [8 : 0] C0_c9_41_l1_f2;
    logic         CLA_c9_41_l1_f2;
    logic         O0_c9_41_l1_f2;
    logic [3 : 0] O1_c9_41_l1_f2;
    logic [1 : 0] CY_c9_41_l1_f2;
    logic [1 : 0] PROP_c9_41_l1_f2;
    
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
    
    logic [16 : 0] C0_c517_451_l1_f4;
    logic [4  : 0] C1_c517_451_l1_f4;
    logic [1  : 0] CLA_c517_451_l1_f4;
    logic          O0_c517_451_l1_f4;
    logic [4  : 0] O1_c517_451_l1_f4;
    logic [3  : 0] O2_c517_451_l1_f4;
    logic [3  : 0] CY0_c517_451_l1_f4;
    logic [3  : 0] PROP0_c517_451_l1_f4;
    logic [3  : 0] CY1_c517_451_l1_f4;
    logic [3  : 0] PROP1_c517_451_l1_f4;
    
    logic [3 : 0] COUT_LA_l1_f4;
    logic         CIN_LA_l1_f4;
    logic [7 : 0] CY_LA_l1_f4;
    logic [7 : 0] PROP_LA_l1_f4;
    
    logic [16 : 0] C0_c517_451_l1_f5;
    logic [4  : 0] C1_c517_451_l1_f5;
    logic [1  : 0] CLA_c517_451_l1_f5;
    logic          O0_c517_451_l1_f5;
    logic [4  : 0] O1_c517_451_l1_f5;
    logic [3  : 0] O2_c517_451_l1_f5;
    logic [3  : 0] CY0_c517_451_l1_f5;
    logic [3  : 0] PROP0_c517_451_l1_f5;
    logic [3  : 0] CY1_c517_451_l1_f5;
    logic [3  : 0] PROP1_c517_451_l1_f5;
    
    logic [3 : 0] COUT_LA_l1_f5;
    logic         CIN_LA_l1_f5;
    logic [7 : 0] CY_LA_l1_f5;
    logic [7 : 0] PROP_LA_l1_f5;
    
    logic [16 : 0] C0_c517_451_l1_f6;
    logic [4  : 0] C1_c517_451_l1_f6;
    logic [1  : 0] CLA_c517_451_l1_f6;
    logic          O0_c517_451_l1_f6;
    logic [4  : 0] O1_c517_451_l1_f6;
    logic [3  : 0] O2_c517_451_l1_f6;
    logic [3  : 0] CY0_c517_451_l1_f6;
    logic [3  : 0] PROP0_c517_451_l1_f6;
    logic [3  : 0] CY1_c517_451_l1_f6;
    logic [3  : 0] PROP1_c517_451_l1_f6;
    
    logic [3 : 0] COUT_LA_l1_f6;
    logic         CIN_LA_l1_f6;
    logic [7 : 0] CY_LA_l1_f6;
    logic [7 : 0] PROP_LA_l1_f6;
    
    logic [16 : 0] C0_c517_451_l1_f7;
    logic [4  : 0] C1_c517_451_l1_f7;
    logic [1  : 0] CLA_c517_451_l1_f7;
    logic          O0_c517_451_l1_f7;
    logic [4  : 0] O1_c517_451_l1_f7;
    logic [3  : 0] O2_c517_451_l1_f7;
    logic [3  : 0] CY0_c517_451_l1_f7;
    logic [3  : 0] PROP0_c517_451_l1_f7;
    logic [3  : 0] CY1_c517_451_l1_f7;
    logic [3  : 0] PROP1_c517_451_l1_f7;
    
    logic [3 : 0] COUT_LA_l1_f7;
    logic         CIN_LA_l1_f7;
    logic [7 : 0] CY_LA_l1_f7;
    logic [7 : 0] PROP_LA_l1_f7;
    
    logic [3 : 0] COUT_LA_l1_floating_placement;
    logic         CIN_LA_l1_floating_placement;
    logic [7 : 0] CY_LA_l1_floating_placement;
    logic [7 : 0] PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [63 : 0] layer2_col0;
    logic [31 : 0] layer2_col1;
    logic [31 : 0] layer2_col2;
    
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
    
    logic [16 : 0] C0_c517_451_l2_f1;
    logic [4  : 0] C1_c517_451_l2_f1;
    logic [1  : 0] CLA_c517_451_l2_f1;
    logic          O0_c517_451_l2_f1;
    logic [4  : 0] O1_c517_451_l2_f1;
    logic [3  : 0] O2_c517_451_l2_f1;
    logic [3  : 0] CY0_c517_451_l2_f1;
    logic [3  : 0] PROP0_c517_451_l2_f1;
    logic [3  : 0] CY1_c517_451_l2_f1;
    logic [3  : 0] PROP1_c517_451_l2_f1;
    
    logic [3 : 0] COUT_LA_l2_f1;
    logic         CIN_LA_l2_f1;
    logic [7 : 0] CY_LA_l2_f1;
    logic [7 : 0] PROP_LA_l2_f1;
    
    logic [8 : 0] C0_c9_41_l2_f2;
    logic         CLA_c9_41_l2_f2;
    logic         O0_c9_41_l2_f2;
    logic [3 : 0] O1_c9_41_l2_f2;
    logic [1 : 0] CY_c9_41_l2_f2;
    logic [1 : 0] PROP_c9_41_l2_f2;
    
    logic [8 : 0] C0_c9_41_l2_f3;
    logic         CLA_c9_41_l2_f3;
    logic         O0_c9_41_l2_f3;
    logic [3 : 0] O1_c9_41_l2_f3;
    logic [1 : 0] CY_c9_41_l2_f3;
    logic [1 : 0] PROP_c9_41_l2_f3;
    
    logic [16 : 0] C0_c517_451_l2_f4;
    logic [4  : 0] C1_c517_451_l2_f4;
    logic [1  : 0] CLA_c517_451_l2_f4;
    logic          O0_c517_451_l2_f4;
    logic [4  : 0] O1_c517_451_l2_f4;
    logic [3  : 0] O2_c517_451_l2_f4;
    logic [3  : 0] CY0_c517_451_l2_f4;
    logic [3  : 0] PROP0_c517_451_l2_f4;
    logic [3  : 0] CY1_c517_451_l2_f4;
    logic [3  : 0] PROP1_c517_451_l2_f4;
    
    logic [3 : 0] COUT_LA_l2_f4;
    logic         CIN_LA_l2_f4;
    logic [7 : 0] CY_LA_l2_f4;
    logic [7 : 0] PROP_LA_l2_f4;
    
    logic [4 : 0] C0_c15_3_l2_f5;
    logic         C1_c15_3_l2_f5;
    logic         CLA_c15_3_l2_f5;
    logic [2 : 0] O_c15_3_l2_f5;
    logic [1 : 0] CY_c15_3_l2_f5;
    logic [1 : 0] PROP_c15_3_l2_f5;
    
    logic [3 : 0] COUT_LA_l2_floating_placement;
    logic         CIN_LA_l2_floating_placement;
    logic [7 : 0] CY_LA_l2_floating_placement;
    logic [7 : 0] PROP_LA_l2_floating_placement;
    
    // ------------------------------ LAYER 3 ------------------------------
    logic [31 : 0] layer3_col0;
    logic [11 : 0] layer3_col1;
    logic [23 : 0] layer3_col2;
    logic [12 : 0] layer3_col3;
    
    logic [16 : 0] C0_c517_451_l3_f0;
    logic [4  : 0] C1_c517_451_l3_f0;
    logic [1  : 0] CLA_c517_451_l3_f0;
    logic          O0_c517_451_l3_f0;
    logic [4  : 0] O1_c517_451_l3_f0;
    logic [3  : 0] O2_c517_451_l3_f0;
    logic [3  : 0] CY0_c517_451_l3_f0;
    logic [3  : 0] PROP0_c517_451_l3_f0;
    logic [3  : 0] CY1_c517_451_l3_f0;
    logic [3  : 0] PROP1_c517_451_l3_f0;
    
    logic [3 : 0] COUT_LA_l3_f0;
    logic         CIN_LA_l3_f0;
    logic [7 : 0] CY_LA_l3_f0;
    logic [7 : 0] PROP_LA_l3_f0;
    
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
    
    logic [8 : 0] C0_c9_41_l3_c0_i1;
    logic         CLA_c9_41_l3_c0_i1;
    logic         O0_c9_41_l3_c0_i1;
    logic [3 : 0] O1_c9_41_l3_c0_i1;
    logic [1 : 0] CY_c9_41_l3_c0_i1;
    logic [1 : 0] PROP_c9_41_l3_c0_i1;
    logic         l3_c0_i1;
    
    logic [2 : 0] C0_c3_2_l3_f1;
    logic [1 : 0] O_c3_2_l3_i1;
    logic         CY_c3_2_l3_f1;
    logic         PROP_c3_2_l3_f1;
    
    logic [3 : 0] COUT_LA_l3_c1_s0;
    logic         CIN_LA_l3_c1_s0;
    logic [7 : 0] CY_LA_l3_c1_s0;
    logic [7 : 0] PROP_LA_l3_c1_s0;
    
    logic [4 : 0] C0_c15_3_l3_c1_i0;
    logic         C1_c15_3_l3_c1_i0;
    logic         CLA_c15_3_l3_c1_i0;
    logic [2 : 0] O_c15_3_l3_c1_i0;
    logic [1 : 0] CY_c15_3_l3_c1_i0;
    logic [1 : 0] PROP_c15_3_l3_c1_i0;
    logic         l3_c1_i0;
    
    logic [8 : 0] C0_c9_41_l3_c1_i1;
    logic         CLA_c9_41_l3_c1_i1;
    logic         O0_c9_41_l3_c1_i1;
    logic [3 : 0] O1_c9_41_l3_c1_i1;
    logic [1 : 0] CY_c9_41_l3_c1_i1;
    logic [1 : 0] PROP_c9_41_l3_c1_i1;
    logic         l3_c1_i1;
    
    logic [4 : 0] C0_c15_3_l3_f2;
    logic         C1_c15_3_l3_f2;
    logic         CLA_c15_3_l3_f2;
    logic [2 : 0] O_c15_3_l3_f2;
    logic [1 : 0] CY_c15_3_l3_f2;
    logic [1 : 0] PROP_c15_3_l3_f2;
    
    logic [3 : 0] COUT_LA_l3_c2_s0;
    logic         CIN_LA_l3_c2_s0;
    logic [7 : 0] CY_LA_l3_c2_s0;
    logic [7 : 0] PROP_LA_l3_c2_s0;
    
    logic [4 : 0] C0_c15_3_l3_c2_i0;
    logic         C1_c15_3_l3_c2_i0;
    logic         CLA_c15_3_l3_c2_i0;
    logic [2 : 0] O_c15_3_l3_c2_i0;
    logic [1 : 0] CY_c15_3_l3_c2_i0;
    logic [1 : 0] PROP_c15_3_l3_c2_i0;
    logic         l3_c2_i0;
    
    logic [4 : 0] C0_c15_3_l3_c2_i1;
    logic         C1_c15_3_l3_c2_i1;
    logic         CLA_c15_3_l3_c2_i1;
    logic [2 : 0] O_c15_3_l3_c2_i1;
    logic [1 : 0] CY_c15_3_l3_c2_i1;
    logic [1 : 0] PROP_c15_3_l3_c2_i1;
    logic         l3_c2_i1;
    
    logic [3 : 0] COUT_LA_l3_floating_placement;
    logic         CIN_LA_l3_floating_placement;
    logic [7 : 0] CY_LA_l3_floating_placement;
    logic [7 : 0] PROP_LA_l3_floating_placement;
    
    // ------------------------------ LAYER 4 ------------------------------
    logic [7  : 0] layer4_col0;
    logic [7  : 0] layer4_col1;
    logic [13 : 0] layer4_col2;
    logic [7  : 0] layer4_col3;
    logic [6  : 0] layer4_col4;
    
    logic [3 : 0] COUT_LA_l4_c0_s0;
    logic         CIN_LA_l4_c0_s0;
    logic [7 : 0] CY_LA_l4_c0_s0;
    logic [7 : 0] PROP_LA_l4_c0_s0;
    
    logic [4 : 0] C0_c15_3_l4_c0_i0;
    logic         C1_c15_3_l4_c0_i0;
    logic         CLA_c15_3_l4_c0_i0;
    logic [2 : 0] O_c15_3_l4_c0_i0;
    logic [1 : 0] CY_c15_3_l4_c0_i0;
    logic [1 : 0] PROP_c15_3_l4_c0_i0;
    logic         l4_c0_i0;
    
    logic [8 : 0] C0_c39_231_l4_c0_i1;
    logic [2 : 0] C1_c39_231_l4_c0_i1;
    logic         CLA_c39_231_l4_c0_i1;
    logic         O0_c39_231_l4_c0_i1;
    logic [2 : 0] O1_c39_231_l4_c0_i1;
    logic [1 : 0] O2_c39_231_l4_c0_i1;
    logic [1 : 0] CY0_c39_231_l4_c0_i1;
    logic [1 : 0] CY1_c39_231_l4_c0_i1;
    logic [1 : 0] PROP0_c39_231_l4_c0_i1;
    logic [1 : 0] PROP1_c39_231_l4_c0_i1;
    logic         l4_c0_i1;
    
    logic [5 : 0] C0_c6_3_l4_f0;
    logic [2 : 0] O_c6_3_l4_f0;
    
    logic [3 : 0] COUT_LA_l4_c1_s0;
    logic         CIN_LA_l4_c1_s0;
    logic [7 : 0] CY_LA_l4_c1_s0;
    logic [7 : 0] PROP_LA_l4_c1_s0;
    
    logic [4 : 0] C0_c15_3_l4_c1_i0;
    logic         C1_c15_3_l4_c1_i0;
    logic         CLA_c15_3_l4_c1_i0;
    logic [2 : 0] O_c15_3_l4_c1_i0;
    logic [1 : 0] CY_c15_3_l4_c1_i0;
    logic [1 : 0] PROP_c15_3_l4_c1_i0;
    logic         l4_c1_i0;
    
    logic [4 : 0] C0_c15_3_l4_c1_i1;
    logic         C1_c15_3_l4_c1_i1;
    logic         CLA_c15_3_l4_c1_i1;
    logic [2 : 0] O_c15_3_l4_c1_i1;
    logic [1 : 0] CY_c15_3_l4_c1_i1;
    logic [1 : 0] PROP_c15_3_l4_c1_i1;
    logic         l4_c1_i1;
    
    logic [4 : 0] C0_c15_3_l4_f1;
    logic         C1_c15_3_l4_f1;
    logic         CLA_c15_3_l4_f1;
    logic [2 : 0] O_c15_3_l4_f1;
    logic [1 : 0] CY_c15_3_l4_f1;
    logic [1 : 0] PROP_c15_3_l4_f1;
    
    logic [3 : 0] COUT_LA_l4_floating_placement;
    logic         CIN_LA_l4_floating_placement;
    logic [7 : 0] CY_LA_l4_floating_placement;
    logic [7 : 0] PROP_LA_l4_floating_placement;
    
    // ------------------------------ LAYER 5 ------------------------------
    logic [3  : 0] layer5_col0;
    logic [3  : 0] layer5_col1;
    logic [2  : 0] layer5_col2;
    logic [4  : 0] layer5_col3;
    logic [4  : 0] layer5_col4;
    logic [1  : 0] layer5_col5;
    logic          layer5_col6;
    
    logic [3 : 0] COUT_LA_l5_c0_s0;
    logic         CIN_LA_l5_c0_s0;
    logic [7 : 0] CY_LA_l5_c0_s0;
    logic [7 : 0] PROP_LA_l5_c0_s0;
    
    logic [2 : 0] C0_c3_2_l5_c0_i0;
    logic [1 : 0] O_c3_2_l5_c0_i0;
    logic         CY_c3_2_l5_c0_i0;
    logic         PROP_c3_2_l5_c0_i0;
    logic         l5_c0_i0;
    
    logic [2 : 0] C0_c3_2_l5_c0_i1;
    logic [1 : 0] O_c3_2_l5_c0_i1;
    logic         CY_c3_2_l5_c0_i1;
    logic         PROP_c3_2_l5_c0_i1;
    logic         l5_c0_i1;
    
    logic    COUT_LA_l5_floating_placement;
    logic    CIN_LA_l5_floating_placement;
    logic    CY_LA_l5_floating_placement;
    logic    PROP_LA_l5_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [3  : 0] layer6_col0;
    logic [3  : 0] layer6_col1;
    logic [2  : 0] layer6_col2;
    logic [2  : 0] layer6_col3;
    logic [3  : 0] layer6_col4;
    logic [2  : 0] layer6_col5;
    logic          layer6_col6;
    
    logic [7 : 0] terminal_chain1_out;
    
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
    
    logic [8 : 0] terminal_chain2_out;
    
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
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i2;
    logic         C1_c15_3_terminal_chain2_i2;
    logic         CLA_c15_3_terminal_chain2_i2;
    logic [2 : 0] O_c15_3_terminal_chain2_i2;
    logic [1 : 0] CY_c15_3_terminal_chain2_i2;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i2;
    logic         terminal_chain2_i2;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i3;
    logic [1 : 0] O_c3_2_terminal_chain2_i3;
    logic         CY_c3_2_terminal_chain2_i3;
    logic         PROP_c3_2_terminal_chain2_i3;
    logic         terminal_chain2_i3;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i4;
    logic [1 : 0] O_c3_2_terminal_chain2_i4;
    logic         CY_c3_2_terminal_chain2_i4;
    logic         PROP_c3_2_terminal_chain2_i4;
    logic         terminal_chain2_i4;
    
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
    
    // GPC6 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f6(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f6  ),
        .CLA (CLA_c9_41_l0_f6 ),
        .O0  (O0_c9_41_l0_f6  ),
        .O1  (O1_c9_41_l0_f6  ),
        .CY  (CY_c9_41_l0_f6  ),
        .PROP(PROP_c9_41_l0_f6));
    
    assign C0_c9_41_l0_f6 = layer0_col0[62:54];
    
    assign layer1_col0[6]     = O0_c9_41_l0_f6;
    assign layer1_col1[27:24] = O1_c9_41_l0_f6;
    
    // GPC7 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f7(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f7  ),
        .CLA (CLA_c9_41_l0_f7 ),
        .O0  (O0_c9_41_l0_f7  ),
        .O1  (O1_c9_41_l0_f7  ),
        .CY  (CY_c9_41_l0_f7  ),
        .PROP(PROP_c9_41_l0_f7));
    
    assign C0_c9_41_l0_f7 = layer0_col0[71:63];
    
    assign layer1_col0[7]     = O0_c9_41_l0_f7;
    assign layer1_col1[31:28] = O1_c9_41_l0_f7;
    
    // GPC8 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f8(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f8  ),
        .CLA (CLA_c9_41_l0_f8 ),
        .O0  (O0_c9_41_l0_f8  ),
        .O1  (O1_c9_41_l0_f8  ),
        .CY  (CY_c9_41_l0_f8  ),
        .PROP(PROP_c9_41_l0_f8));
    
    assign C0_c9_41_l0_f8 = layer0_col0[80:72];
    
    assign layer1_col0[8]     = O0_c9_41_l0_f8;
    assign layer1_col1[35:32] = O1_c9_41_l0_f8;
    
    // GPC9 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f9(
        .clk (clk             ),
        .C0  (C0_c9_41_l0_f9  ),
        .CLA (CLA_c9_41_l0_f9 ),
        .O0  (O0_c9_41_l0_f9  ),
        .O1  (O1_c9_41_l0_f9  ),
        .CY  (CY_c9_41_l0_f9  ),
        .PROP(PROP_c9_41_l0_f9));
    
    assign C0_c9_41_l0_f9 = layer0_col0[89:81];
    
    assign layer1_col0[9]     = O0_c9_41_l0_f9;
    assign layer1_col1[39:36] = O1_c9_41_l0_f9;
    
    // GPC10 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f10(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f10  ),
        .CLA (CLA_c9_41_l0_f10 ),
        .O0  (O0_c9_41_l0_f10  ),
        .O1  (O1_c9_41_l0_f10  ),
        .CY  (CY_c9_41_l0_f10  ),
        .PROP(PROP_c9_41_l0_f10));
    
    assign C0_c9_41_l0_f10 = layer0_col0[98:90];
    
    assign layer1_col0[10]    = O0_c9_41_l0_f10;
    assign layer1_col1[43:40] = O1_c9_41_l0_f10;
    
    // GPC11 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f11(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f11  ),
        .CLA (CLA_c9_41_l0_f11 ),
        .O0  (O0_c9_41_l0_f11  ),
        .O1  (O1_c9_41_l0_f11  ),
        .CY  (CY_c9_41_l0_f11  ),
        .PROP(PROP_c9_41_l0_f11));
    
    assign C0_c9_41_l0_f11 = layer0_col0[107:99];
    
    assign layer1_col0[11]    = O0_c9_41_l0_f11;
    assign layer1_col1[47:44] = O1_c9_41_l0_f11;
    
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

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_floating_placement_inst2 (
        .COUTB(COUT_LA_l0_floating_placement[8] ),
        .COUTD(COUT_LA_l0_floating_placement[9] ),
        .COUTF(COUT_LA_l0_floating_placement[10]),
        .COUTH(COUT_LA_l0_floating_placement[11]),
        .CIN  (CIN_LA_l0_floating_placement[2]  ),
        .CYA  (CY_LA_l0_floating_placement[16]  ),
        .CYB  (CY_LA_l0_floating_placement[17]  ),
        .CYC  (CY_LA_l0_floating_placement[18]  ),
        .CYD  (CY_LA_l0_floating_placement[19]  ),
        .CYE  (CY_LA_l0_floating_placement[20]  ),
        .CYF  (CY_LA_l0_floating_placement[21]  ),
        .CYG  (CY_LA_l0_floating_placement[22]  ),
        .CYH  (CY_LA_l0_floating_placement[23]  ),
        .PROPA(PROP_LA_l0_floating_placement[16]),
        .PROPB(PROP_LA_l0_floating_placement[17]),
        .PROPC(PROP_LA_l0_floating_placement[18]),
        .PROPD(PROP_LA_l0_floating_placement[19]),
        .PROPE(PROP_LA_l0_floating_placement[20]),
        .PROPF(PROP_LA_l0_floating_placement[21]),
        .PROPG(PROP_LA_l0_floating_placement[22]),
        .PROPH(PROP_LA_l0_floating_placement[23]));

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
    
    assign CY_LA_l0_floating_placement[13:12]   = CY_c9_41_l0_f6;
    assign PROP_LA_l0_floating_placement[13:12] = PROP_c9_41_l0_f6;
    
    assign CY_LA_l0_floating_placement[15:14]   = CY_c9_41_l0_f7;
    assign PROP_LA_l0_floating_placement[15:14] = PROP_c9_41_l0_f7;
    
    assign CY_LA_l0_floating_placement[17:16]   = CY_c9_41_l0_f8;
    assign PROP_LA_l0_floating_placement[17:16] = PROP_c9_41_l0_f8;
    assign CIN_LA_l0_floating_placement[2] = C0_c9_41_l0_f8[8];
    
    assign CY_LA_l0_floating_placement[19:18]   = CY_c9_41_l0_f9;
    assign PROP_LA_l0_floating_placement[19:18] = PROP_c9_41_l0_f9;
    
    assign CY_LA_l0_floating_placement[21:20]   = CY_c9_41_l0_f10;
    assign PROP_LA_l0_floating_placement[21:20] = PROP_c9_41_l0_f10;
    
    assign CY_LA_l0_floating_placement[23:22]   = CY_c9_41_l0_f11;
    assign PROP_LA_l0_floating_placement[23:22] = PROP_c9_41_l0_f11;
    
    assign layer1_col0[12] = layer0_col0[108];
    assign layer1_col0[13] = layer0_col0[109];
    assign layer1_col0[14] = layer0_col0[110];
    assign layer1_col0[15] = layer0_col0[111];
    assign layer1_col0[16] = layer0_col0[112];
    assign layer1_col0[17] = layer0_col0[113];
    assign layer1_col0[18] = layer0_col0[114];
    assign layer1_col0[19] = layer0_col0[115];
    assign layer1_col0[20] = layer0_col0[116];
    assign layer1_col0[21] = layer0_col0[117];
    assign layer1_col0[22] = layer0_col0[118];
    assign layer1_col0[23] = layer0_col0[119];
    assign layer1_col0[24] = layer0_col0[120];
    assign layer1_col0[25] = layer0_col0[121];
    assign layer1_col0[26] = layer0_col0[122];
    assign layer1_col0[27] = layer0_col0[123];
    assign layer1_col0[28] = layer0_col0[124];
    assign layer1_col0[29] = layer0_col0[125];
    assign layer1_col0[30] = layer0_col0[126];
    assign layer1_col0[31] = layer0_col0[127];
    assign layer1_col0[32] = layer0_col0[128];
    assign layer1_col0[33] = layer0_col0[129];
    assign layer1_col0[34] = layer0_col0[130];
    assign layer1_col0[35] = layer0_col0[131];
    assign layer1_col0[36] = layer0_col0[132];
    assign layer1_col0[37] = layer0_col0[133];
    assign layer1_col0[38] = layer0_col0[134];
    assign layer1_col0[39] = layer0_col0[135];
    assign layer1_col0[40] = layer0_col0[136];
    assign layer1_col0[41] = layer0_col0[137];
    assign layer1_col0[42] = layer0_col0[138];
    assign layer1_col0[43] = layer0_col0[139];
    assign layer1_col0[44] = layer0_col0[140];
    assign layer1_col0[45] = layer0_col0[141];
    assign layer1_col0[46] = layer0_col0[142];
    assign layer1_col0[47] = layer0_col0[143];
    assign layer1_col0[48] = layer0_col0[144];
    assign layer1_col0[49] = layer0_col0[145];
    assign layer1_col0[50] = layer0_col0[146];
    assign layer1_col0[51] = layer0_col0[147];
    assign layer1_col0[52] = layer0_col0[148];
    assign layer1_col0[53] = layer0_col0[149];
    assign layer1_col0[54] = layer0_col0[150];
    assign layer1_col0[55] = layer0_col0[151];
    assign layer1_col0[56] = layer0_col0[152];
    assign layer1_col0[57] = layer0_col0[153];
    assign layer1_col0[58] = layer0_col0[154];
    assign layer1_col0[59] = layer0_col0[155];
    assign layer1_col0[60] = layer0_col0[156];
    assign layer1_col0[61] = layer0_col0[157];
    assign layer1_col0[62] = layer0_col0[158];
    assign layer1_col0[63] = layer0_col0[159];
    assign layer1_col0[64] = layer0_col0[160];
    assign layer1_col0[65] = layer0_col0[161];
    assign layer1_col0[66] = layer0_col0[162];
    assign layer1_col0[67] = layer0_col0[163];
    assign layer1_col0[68] = layer0_col0[164];
    assign layer1_col0[69] = layer0_col0[165];
    assign layer1_col0[70] = layer0_col0[166];
    assign layer1_col0[71] = layer0_col0[167];
    assign layer1_col0[72] = layer0_col0[168];
    assign layer1_col0[73] = layer0_col0[169];
    assign layer1_col0[74] = layer0_col0[170];
    assign layer1_col0[75] = layer0_col0[171];
    assign layer1_col0[76] = layer0_col0[172];
    assign layer1_col0[77] = layer0_col0[173];
    assign layer1_col0[78] = layer0_col0[174];
    assign layer1_col0[79] = layer0_col0[175];
    assign layer1_col0[80] = layer0_col0[176];
    assign layer1_col0[81] = layer0_col0[177];
    assign layer1_col0[82] = layer0_col0[178];
    assign layer1_col0[83] = layer0_col0[179];
    assign layer1_col0[84] = layer0_col0[180];
    assign layer1_col0[85] = layer0_col0[181];
    assign layer1_col0[86] = layer0_col0[182];
    assign layer1_col0[87] = layer0_col0[183];
    assign layer1_col0[88] = layer0_col0[184];
    assign layer1_col0[89] = layer0_col0[185];
    assign layer1_col0[90] = layer0_col0[186];
    assign layer1_col0[91] = layer0_col0[187];
    assign layer1_col0[92] = layer0_col0[188];
    assign layer1_col0[93] = layer0_col0[189];
    assign layer1_col0[94] = layer0_col0[190];
    assign layer1_col0[95] = layer0_col0[191];
    assign layer1_col0[96] = layer0_col0[192];
    assign layer1_col0[97] = layer0_col0[193];
    assign layer1_col0[98] = layer0_col0[194];
    assign layer1_col0[99] = layer0_col0[195];
    assign layer1_col0[100] = layer0_col0[196];
    assign layer1_col0[101] = layer0_col0[197];
    assign layer1_col0[102] = layer0_col0[198];
    assign layer1_col0[103] = layer0_col0[199];
    assign layer1_col0[104] = layer0_col0[200];
    assign layer1_col0[105] = layer0_col0[201];
    assign layer1_col0[106] = layer0_col0[202];
    assign layer1_col0[107] = layer0_col0[203];
    assign layer1_col0[108] = layer0_col0[204];
    assign layer1_col0[109] = layer0_col0[205];
    assign layer1_col0[110] = layer0_col0[206];
    assign layer1_col0[111] = layer0_col0[207];
    assign layer1_col0[112] = layer0_col0[208];
    assign layer1_col0[113] = layer0_col0[209];
    assign layer1_col0[114] = layer0_col0[210];
    assign layer1_col0[115] = layer0_col0[211];
    assign layer1_col0[116] = layer0_col0[212];
    assign layer1_col0[117] = layer0_col0[213];
    assign layer1_col0[118] = layer0_col0[214];
    assign layer1_col0[119] = layer0_col0[215];
    assign layer1_col0[120] = layer0_col0[216];
    assign layer1_col0[121] = layer0_col0[217];
    assign layer1_col0[122] = layer0_col0[218];
    assign layer1_col0[123] = layer0_col0[219];
    assign layer1_col0[124] = layer0_col0[220];
    assign layer1_col0[125] = layer0_col0[221];
    assign layer1_col0[126] = layer0_col0[222];
    assign layer1_col0[127] = layer0_col0[223];
    assign layer1_col0[128] = layer0_col0[224];
    assign layer1_col0[129] = layer0_col0[225];
    assign layer1_col0[130] = layer0_col0[226];
    assign layer1_col0[131] = layer0_col0[227];
    assign layer1_col0[132] = layer0_col0[228];
    assign layer1_col0[133] = layer0_col0[229];
    assign layer1_col0[134] = layer0_col0[230];
    assign layer1_col0[135] = layer0_col0[231];
    assign layer1_col0[136] = layer0_col0[232];
    assign layer1_col0[137] = layer0_col0[233];
    assign layer1_col0[138] = layer0_col0[234];
    assign layer1_col0[139] = layer0_col0[235];
    assign layer1_col0[140] = layer0_col0[236];
    assign layer1_col0[141] = layer0_col0[237];
    assign layer1_col0[142] = layer0_col0[238];
    assign layer1_col0[143] = layer0_col0[239];
    assign layer1_col0[144] = layer0_col0[240];
    assign layer1_col0[145] = layer0_col0[241];
    assign layer1_col0[146] = layer0_col0[242];
    assign layer1_col0[147] = layer0_col0[243];
    assign layer1_col0[148] = layer0_col0[244];
    assign layer1_col0[149] = layer0_col0[245];
    assign layer1_col0[150] = layer0_col0[246];
    assign layer1_col0[151] = layer0_col0[247];
    assign layer1_col0[152] = layer0_col0[248];
    assign layer1_col0[153] = layer0_col0[249];
    assign layer1_col0[154] = layer0_col0[250];
    assign layer1_col0[155] = layer0_col0[251];
    assign layer1_col0[156] = layer0_col0[252];
    assign layer1_col0[157] = layer0_col0[253];
    assign layer1_col0[158] = layer0_col0[254];
    assign layer1_col0[159] = layer0_col0[255];
    // ------------------------------ LAYER 1 ------------------------------
    // GPC0 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    // GPC2 in layer1: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f2(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f2  ),
        .CLA (CLA_c9_41_l1_f2 ),
        .O0  (O0_c9_41_l1_f2  ),
        .O1  (O1_c9_41_l1_f2  ),
        .CY  (CY_c9_41_l1_f2  ),
        .PROP(PROP_c9_41_l1_f2));
    
    assign C0_c9_41_l1_f2 = layer1_col1[22:14];
    
    assign layer2_col1[6]    = O0_c9_41_l1_f2;
    assign layer2_col2[11:8] = O1_c9_41_l1_f2;
    
    // GPC3 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
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
    
    assign C0_c517_451_l1_f3 = layer1_col0[33:17];
    assign C1_c517_451_l1_f3 = layer1_col1[27:23];
    
    assign layer2_col0[1]     = O0_c517_451_l1_f3;
    assign layer2_col1[11:7]  = O1_c517_451_l1_f3;
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
    
    // GPC4 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f4(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f4   ),
        .C1   (C1_c517_451_l1_f4   ),
        .CLA  (CLA_c517_451_l1_f4  ),
        .O0   (O0_c517_451_l1_f4   ),
        .O1   (O1_c517_451_l1_f4   ),
        .O2   (O2_c517_451_l1_f4   ),
        .CY0  (CY0_c517_451_l1_f4  ),
        .PROP0(PROP0_c517_451_l1_f4),
        .CY1  (CY1_c517_451_l1_f4  ),
        .PROP1(PROP1_c517_451_l1_f4));
    
    assign C0_c517_451_l1_f4 = layer1_col0[50:34];
    assign C1_c517_451_l1_f4 = layer1_col1[32:28];
    
    assign layer2_col0[2]     = O0_c517_451_l1_f4;
    assign layer2_col1[16:12] = O1_c517_451_l1_f4;
    assign layer2_col2[19:16] = O2_c517_451_l1_f4;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f4_inst0 (
        .COUTB(COUT_LA_l1_f4[0]),
        .COUTD(COUT_LA_l1_f4[1]),
        .COUTF(COUT_LA_l1_f4[2]),
        .COUTH(COUT_LA_l1_f4[3]),
        .CIN  (CIN_LA_l1_f4    ),
        .CYA  (CY_LA_l1_f4[0]  ),
        .CYB  (CY_LA_l1_f4[1]  ),
        .CYC  (CY_LA_l1_f4[2]  ),
        .CYD  (CY_LA_l1_f4[3]  ),
        .CYE  (CY_LA_l1_f4[4]  ),
        .CYF  (CY_LA_l1_f4[5]  ),
        .CYG  (CY_LA_l1_f4[6]  ),
        .CYH  (CY_LA_l1_f4[7]  ),
        .PROPA(PROP_LA_l1_f4[0]),
        .PROPB(PROP_LA_l1_f4[1]),
        .PROPC(PROP_LA_l1_f4[2]),
        .PROPD(PROP_LA_l1_f4[3]),
        .PROPE(PROP_LA_l1_f4[4]),
        .PROPF(PROP_LA_l1_f4[5]),
        .PROPG(PROP_LA_l1_f4[6]),
        .PROPH(PROP_LA_l1_f4[7]));

    assign CLA_c517_451_l1_f4[0] = COUT_LA_l1_f4[0];
    assign CLA_c517_451_l1_f4[1] = COUT_LA_l1_f4[2];
    assign CIN_LA_l1_f4          = C0_c517_451_l1_f4[8];
    assign CY_LA_l1_f4[3:0]      = CY0_c517_451_l1_f4;
    assign CY_LA_l1_f4[7:4]      = CY1_c517_451_l1_f4;
    assign PROP_LA_l1_f4[3:0]    = PROP0_c517_451_l1_f4;
    assign PROP_LA_l1_f4[7:4]    = PROP1_c517_451_l1_f4;
    
    // GPC5 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f5(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f5   ),
        .C1   (C1_c517_451_l1_f5   ),
        .CLA  (CLA_c517_451_l1_f5  ),
        .O0   (O0_c517_451_l1_f5   ),
        .O1   (O1_c517_451_l1_f5   ),
        .O2   (O2_c517_451_l1_f5   ),
        .CY0  (CY0_c517_451_l1_f5  ),
        .PROP0(PROP0_c517_451_l1_f5),
        .CY1  (CY1_c517_451_l1_f5  ),
        .PROP1(PROP1_c517_451_l1_f5));
    
    assign C0_c517_451_l1_f5 = layer1_col0[67:51];
    assign C1_c517_451_l1_f5 = layer1_col1[37:33];
    
    assign layer2_col0[3]     = O0_c517_451_l1_f5;
    assign layer2_col1[21:17] = O1_c517_451_l1_f5;
    assign layer2_col2[23:20] = O2_c517_451_l1_f5;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f5_inst0 (
        .COUTB(COUT_LA_l1_f5[0]),
        .COUTD(COUT_LA_l1_f5[1]),
        .COUTF(COUT_LA_l1_f5[2]),
        .COUTH(COUT_LA_l1_f5[3]),
        .CIN  (CIN_LA_l1_f5    ),
        .CYA  (CY_LA_l1_f5[0]  ),
        .CYB  (CY_LA_l1_f5[1]  ),
        .CYC  (CY_LA_l1_f5[2]  ),
        .CYD  (CY_LA_l1_f5[3]  ),
        .CYE  (CY_LA_l1_f5[4]  ),
        .CYF  (CY_LA_l1_f5[5]  ),
        .CYG  (CY_LA_l1_f5[6]  ),
        .CYH  (CY_LA_l1_f5[7]  ),
        .PROPA(PROP_LA_l1_f5[0]),
        .PROPB(PROP_LA_l1_f5[1]),
        .PROPC(PROP_LA_l1_f5[2]),
        .PROPD(PROP_LA_l1_f5[3]),
        .PROPE(PROP_LA_l1_f5[4]),
        .PROPF(PROP_LA_l1_f5[5]),
        .PROPG(PROP_LA_l1_f5[6]),
        .PROPH(PROP_LA_l1_f5[7]));

    assign CLA_c517_451_l1_f5[0] = COUT_LA_l1_f5[0];
    assign CLA_c517_451_l1_f5[1] = COUT_LA_l1_f5[2];
    assign CIN_LA_l1_f5          = C0_c517_451_l1_f5[8];
    assign CY_LA_l1_f5[3:0]      = CY0_c517_451_l1_f5;
    assign CY_LA_l1_f5[7:4]      = CY1_c517_451_l1_f5;
    assign PROP_LA_l1_f5[3:0]    = PROP0_c517_451_l1_f5;
    assign PROP_LA_l1_f5[7:4]    = PROP1_c517_451_l1_f5;
    
    // GPC6 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f6(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f6   ),
        .C1   (C1_c517_451_l1_f6   ),
        .CLA  (CLA_c517_451_l1_f6  ),
        .O0   (O0_c517_451_l1_f6   ),
        .O1   (O1_c517_451_l1_f6   ),
        .O2   (O2_c517_451_l1_f6   ),
        .CY0  (CY0_c517_451_l1_f6  ),
        .PROP0(PROP0_c517_451_l1_f6),
        .CY1  (CY1_c517_451_l1_f6  ),
        .PROP1(PROP1_c517_451_l1_f6));
    
    assign C0_c517_451_l1_f6 = layer1_col0[84:68];
    assign C1_c517_451_l1_f6 = layer1_col1[42:38];
    
    assign layer2_col0[4]     = O0_c517_451_l1_f6;
    assign layer2_col1[26:22] = O1_c517_451_l1_f6;
    assign layer2_col2[27:24] = O2_c517_451_l1_f6;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f6_inst0 (
        .COUTB(COUT_LA_l1_f6[0]),
        .COUTD(COUT_LA_l1_f6[1]),
        .COUTF(COUT_LA_l1_f6[2]),
        .COUTH(COUT_LA_l1_f6[3]),
        .CIN  (CIN_LA_l1_f6    ),
        .CYA  (CY_LA_l1_f6[0]  ),
        .CYB  (CY_LA_l1_f6[1]  ),
        .CYC  (CY_LA_l1_f6[2]  ),
        .CYD  (CY_LA_l1_f6[3]  ),
        .CYE  (CY_LA_l1_f6[4]  ),
        .CYF  (CY_LA_l1_f6[5]  ),
        .CYG  (CY_LA_l1_f6[6]  ),
        .CYH  (CY_LA_l1_f6[7]  ),
        .PROPA(PROP_LA_l1_f6[0]),
        .PROPB(PROP_LA_l1_f6[1]),
        .PROPC(PROP_LA_l1_f6[2]),
        .PROPD(PROP_LA_l1_f6[3]),
        .PROPE(PROP_LA_l1_f6[4]),
        .PROPF(PROP_LA_l1_f6[5]),
        .PROPG(PROP_LA_l1_f6[6]),
        .PROPH(PROP_LA_l1_f6[7]));

    assign CLA_c517_451_l1_f6[0] = COUT_LA_l1_f6[0];
    assign CLA_c517_451_l1_f6[1] = COUT_LA_l1_f6[2];
    assign CIN_LA_l1_f6          = C0_c517_451_l1_f6[8];
    assign CY_LA_l1_f6[3:0]      = CY0_c517_451_l1_f6;
    assign CY_LA_l1_f6[7:4]      = CY1_c517_451_l1_f6;
    assign PROP_LA_l1_f6[3:0]    = PROP0_c517_451_l1_f6;
    assign PROP_LA_l1_f6[7:4]    = PROP1_c517_451_l1_f6;
    
    // GPC7 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f7(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f7   ),
        .C1   (C1_c517_451_l1_f7   ),
        .CLA  (CLA_c517_451_l1_f7  ),
        .O0   (O0_c517_451_l1_f7   ),
        .O1   (O1_c517_451_l1_f7   ),
        .O2   (O2_c517_451_l1_f7   ),
        .CY0  (CY0_c517_451_l1_f7  ),
        .PROP0(PROP0_c517_451_l1_f7),
        .CY1  (CY1_c517_451_l1_f7  ),
        .PROP1(PROP1_c517_451_l1_f7));
    
    assign C0_c517_451_l1_f7 = layer1_col0[101:85];
    assign C1_c517_451_l1_f7 = layer1_col1[47:43];
    
    assign layer2_col0[5]     = O0_c517_451_l1_f7;
    assign layer2_col1[31:27] = O1_c517_451_l1_f7;
    assign layer2_col2[31:28] = O2_c517_451_l1_f7;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f7_inst0 (
        .COUTB(COUT_LA_l1_f7[0]),
        .COUTD(COUT_LA_l1_f7[1]),
        .COUTF(COUT_LA_l1_f7[2]),
        .COUTH(COUT_LA_l1_f7[3]),
        .CIN  (CIN_LA_l1_f7    ),
        .CYA  (CY_LA_l1_f7[0]  ),
        .CYB  (CY_LA_l1_f7[1]  ),
        .CYC  (CY_LA_l1_f7[2]  ),
        .CYD  (CY_LA_l1_f7[3]  ),
        .CYE  (CY_LA_l1_f7[4]  ),
        .CYF  (CY_LA_l1_f7[5]  ),
        .CYG  (CY_LA_l1_f7[6]  ),
        .CYH  (CY_LA_l1_f7[7]  ),
        .PROPA(PROP_LA_l1_f7[0]),
        .PROPB(PROP_LA_l1_f7[1]),
        .PROPC(PROP_LA_l1_f7[2]),
        .PROPD(PROP_LA_l1_f7[3]),
        .PROPE(PROP_LA_l1_f7[4]),
        .PROPF(PROP_LA_l1_f7[5]),
        .PROPG(PROP_LA_l1_f7[6]),
        .PROPH(PROP_LA_l1_f7[7]));

    assign CLA_c517_451_l1_f7[0] = COUT_LA_l1_f7[0];
    assign CLA_c517_451_l1_f7[1] = COUT_LA_l1_f7[2];
    assign CIN_LA_l1_f7          = C0_c517_451_l1_f7[8];
    assign CY_LA_l1_f7[3:0]      = CY0_c517_451_l1_f7;
    assign CY_LA_l1_f7[7:4]      = CY1_c517_451_l1_f7;
    assign PROP_LA_l1_f7[3:0]    = PROP0_c517_451_l1_f7;
    assign PROP_LA_l1_f7[7:4]    = PROP1_c517_451_l1_f7;
    
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
    
    assign CY_LA_l1_floating_placement[3:2]   = CY_c9_41_l1_f2;
    assign PROP_LA_l1_floating_placement[3:2] = PROP_c9_41_l1_f2;
    
    always_ff @(posedge clk) begin
        layer2_col0[6] <= layer1_col0[102];
        layer2_col0[7] <= layer1_col0[103];
        layer2_col0[8] <= layer1_col0[104];
        layer2_col0[9] <= layer1_col0[105];
        layer2_col0[10] <= layer1_col0[106];
        layer2_col0[11] <= layer1_col0[107];
        layer2_col0[12] <= layer1_col0[108];
        layer2_col0[13] <= layer1_col0[109];
        layer2_col0[14] <= layer1_col0[110];
        layer2_col0[15] <= layer1_col0[111];
        layer2_col0[16] <= layer1_col0[112];
        layer2_col0[17] <= layer1_col0[113];
        layer2_col0[18] <= layer1_col0[114];
        layer2_col0[19] <= layer1_col0[115];
        layer2_col0[20] <= layer1_col0[116];
        layer2_col0[21] <= layer1_col0[117];
        layer2_col0[22] <= layer1_col0[118];
        layer2_col0[23] <= layer1_col0[119];
        layer2_col0[24] <= layer1_col0[120];
        layer2_col0[25] <= layer1_col0[121];
        layer2_col0[26] <= layer1_col0[122];
        layer2_col0[27] <= layer1_col0[123];
        layer2_col0[28] <= layer1_col0[124];
        layer2_col0[29] <= layer1_col0[125];
        layer2_col0[30] <= layer1_col0[126];
        layer2_col0[31] <= layer1_col0[127];
        layer2_col0[32] <= layer1_col0[128];
        layer2_col0[33] <= layer1_col0[129];
        layer2_col0[34] <= layer1_col0[130];
        layer2_col0[35] <= layer1_col0[131];
        layer2_col0[36] <= layer1_col0[132];
        layer2_col0[37] <= layer1_col0[133];
        layer2_col0[38] <= layer1_col0[134];
        layer2_col0[39] <= layer1_col0[135];
        layer2_col0[40] <= layer1_col0[136];
        layer2_col0[41] <= layer1_col0[137];
        layer2_col0[42] <= layer1_col0[138];
        layer2_col0[43] <= layer1_col0[139];
        layer2_col0[44] <= layer1_col0[140];
        layer2_col0[45] <= layer1_col0[141];
        layer2_col0[46] <= layer1_col0[142];
        layer2_col0[47] <= layer1_col0[143];
        layer2_col0[48] <= layer1_col0[144];
        layer2_col0[49] <= layer1_col0[145];
        layer2_col0[50] <= layer1_col0[146];
        layer2_col0[51] <= layer1_col0[147];
        layer2_col0[52] <= layer1_col0[148];
        layer2_col0[53] <= layer1_col0[149];
        layer2_col0[54] <= layer1_col0[150];
        layer2_col0[55] <= layer1_col0[151];
        layer2_col0[56] <= layer1_col0[152];
        layer2_col0[57] <= layer1_col0[153];
        layer2_col0[58] <= layer1_col0[154];
        layer2_col0[59] <= layer1_col0[155];
        layer2_col0[60] <= layer1_col0[156];
        layer2_col0[61] <= layer1_col0[157];
        layer2_col0[62] <= layer1_col0[158];
        layer2_col0[63] <= layer1_col0[159];
    end
    
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
    
    // GPC1 in layer2: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f1(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f1   ),
        .C1   (C1_c517_451_l2_f1   ),
        .CLA  (CLA_c517_451_l2_f1  ),
        .O0   (O0_c517_451_l2_f1   ),
        .O1   (O1_c517_451_l2_f1   ),
        .O2   (O2_c517_451_l2_f1   ),
        .CY0  (CY0_c517_451_l2_f1  ),
        .PROP0(PROP0_c517_451_l2_f1),
        .CY1  (CY1_c517_451_l2_f1  ),
        .PROP1(PROP1_c517_451_l2_f1));
    
    assign C0_c517_451_l2_f1 = layer2_col1[21:5];
    assign C1_c517_451_l2_f1 = layer2_col2[4:0];
    
    assign layer3_col1[5]   = O0_c517_451_l2_f1;
    assign layer3_col2[8:4] = O1_c517_451_l2_f1;
    assign layer3_col3[3:0] = O2_c517_451_l2_f1;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f1_inst0 (
        .COUTB(COUT_LA_l2_f1[0]),
        .COUTD(COUT_LA_l2_f1[1]),
        .COUTF(COUT_LA_l2_f1[2]),
        .COUTH(COUT_LA_l2_f1[3]),
        .CIN  (CIN_LA_l2_f1    ),
        .CYA  (CY_LA_l2_f1[0]  ),
        .CYB  (CY_LA_l2_f1[1]  ),
        .CYC  (CY_LA_l2_f1[2]  ),
        .CYD  (CY_LA_l2_f1[3]  ),
        .CYE  (CY_LA_l2_f1[4]  ),
        .CYF  (CY_LA_l2_f1[5]  ),
        .CYG  (CY_LA_l2_f1[6]  ),
        .CYH  (CY_LA_l2_f1[7]  ),
        .PROPA(PROP_LA_l2_f1[0]),
        .PROPB(PROP_LA_l2_f1[1]),
        .PROPC(PROP_LA_l2_f1[2]),
        .PROPD(PROP_LA_l2_f1[3]),
        .PROPE(PROP_LA_l2_f1[4]),
        .PROPF(PROP_LA_l2_f1[5]),
        .PROPG(PROP_LA_l2_f1[6]),
        .PROPH(PROP_LA_l2_f1[7]));

    assign CLA_c517_451_l2_f1[0] = COUT_LA_l2_f1[0];
    assign CLA_c517_451_l2_f1[1] = COUT_LA_l2_f1[2];
    assign CIN_LA_l2_f1          = C0_c517_451_l2_f1[8];
    assign CY_LA_l2_f1[3:0]      = CY0_c517_451_l2_f1;
    assign CY_LA_l2_f1[7:4]      = CY1_c517_451_l2_f1;
    assign PROP_LA_l2_f1[3:0]    = PROP0_c517_451_l2_f1;
    assign PROP_LA_l2_f1[7:4]    = PROP1_c517_451_l2_f1;
    
    // GPC2 in layer2: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f2(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f2  ),
        .CLA (CLA_c9_41_l2_f2 ),
        .O0  (O0_c9_41_l2_f2  ),
        .O1  (O1_c9_41_l2_f2  ),
        .CY  (CY_c9_41_l2_f2  ),
        .PROP(PROP_c9_41_l2_f2));
    
    assign C0_c9_41_l2_f2 = layer2_col2[13:5];
    
    assign layer3_col2[9]   = O0_c9_41_l2_f2;
    assign layer3_col3[7:4] = O1_c9_41_l2_f2;
    
    // GPC3 in layer2: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f3(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f3  ),
        .CLA (CLA_c9_41_l2_f3 ),
        .O0  (O0_c9_41_l2_f3  ),
        .O1  (O1_c9_41_l2_f3  ),
        .CY  (CY_c9_41_l2_f3  ),
        .PROP(PROP_c9_41_l2_f3));
    
    assign C0_c9_41_l2_f3 = layer2_col2[22:14];
    
    assign layer3_col2[10]   = O0_c9_41_l2_f3;
    assign layer3_col3[11:8] = O1_c9_41_l2_f3;
    
    // GPC4 in layer2: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f4(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f4   ),
        .C1   (C1_c517_451_l2_f4   ),
        .CLA  (CLA_c517_451_l2_f4  ),
        .O0   (O0_c517_451_l2_f4   ),
        .O1   (O1_c517_451_l2_f4   ),
        .O2   (O2_c517_451_l2_f4   ),
        .CY0  (CY0_c517_451_l2_f4  ),
        .PROP0(PROP0_c517_451_l2_f4),
        .CY1  (CY1_c517_451_l2_f4  ),
        .PROP1(PROP1_c517_451_l2_f4));
    
    assign C0_c517_451_l2_f4 = layer2_col0[33:17];
    assign C1_c517_451_l2_f4 = layer2_col1[26:22];
    
    assign layer3_col0[1]     = O0_c517_451_l2_f4;
    assign layer3_col1[10:6]  = O1_c517_451_l2_f4;
    assign layer3_col2[14:11] = O2_c517_451_l2_f4;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f4_inst0 (
        .COUTB(COUT_LA_l2_f4[0]),
        .COUTD(COUT_LA_l2_f4[1]),
        .COUTF(COUT_LA_l2_f4[2]),
        .COUTH(COUT_LA_l2_f4[3]),
        .CIN  (CIN_LA_l2_f4    ),
        .CYA  (CY_LA_l2_f4[0]  ),
        .CYB  (CY_LA_l2_f4[1]  ),
        .CYC  (CY_LA_l2_f4[2]  ),
        .CYD  (CY_LA_l2_f4[3]  ),
        .CYE  (CY_LA_l2_f4[4]  ),
        .CYF  (CY_LA_l2_f4[5]  ),
        .CYG  (CY_LA_l2_f4[6]  ),
        .CYH  (CY_LA_l2_f4[7]  ),
        .PROPA(PROP_LA_l2_f4[0]),
        .PROPB(PROP_LA_l2_f4[1]),
        .PROPC(PROP_LA_l2_f4[2]),
        .PROPD(PROP_LA_l2_f4[3]),
        .PROPE(PROP_LA_l2_f4[4]),
        .PROPF(PROP_LA_l2_f4[5]),
        .PROPG(PROP_LA_l2_f4[6]),
        .PROPH(PROP_LA_l2_f4[7]));

    assign CLA_c517_451_l2_f4[0] = COUT_LA_l2_f4[0];
    assign CLA_c517_451_l2_f4[1] = COUT_LA_l2_f4[2];
    assign CIN_LA_l2_f4          = C0_c517_451_l2_f4[8];
    assign CY_LA_l2_f4[3:0]      = CY0_c517_451_l2_f4;
    assign CY_LA_l2_f4[7:4]      = CY1_c517_451_l2_f4;
    assign PROP_LA_l2_f4[3:0]    = PROP0_c517_451_l2_f4;
    assign PROP_LA_l2_f4[7:4]    = PROP1_c517_451_l2_f4;
    
    // GPC5 in layer2: (1,5 : 3] at column 1
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l2_f5(
        .clk (clk             ),
        .C0  (C0_c15_3_l2_f5  ),
        .C1  (C1_c15_3_l2_f5  ),
        .CLA (CLA_c15_3_l2_f5 ),
        .O   (O_c15_3_l2_f5   ),
        .CY  (CY_c15_3_l2_f5  ),
        .PROP(PROP_c15_3_l2_f5));
    
    assign C0_c15_3_l2_f5 = layer2_col1[31:27];
    assign C1_c15_3_l2_f5 = layer2_col2[23];
    
    assign layer3_col1[11] = O_c15_3_l2_f5[0];
    assign layer3_col2[15] = O_c15_3_l2_f5[1];
    assign layer3_col3[12] = O_c15_3_l2_f5[2];
    
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

    assign CY_LA_l2_floating_placement[1:0]   = CY_c9_41_l2_f2;
    assign PROP_LA_l2_floating_placement[1:0] = PROP_c9_41_l2_f2;
    assign CIN_LA_l2_floating_placement    = C0_c9_41_l2_f2[8];
    
    assign CY_LA_l2_floating_placement[3:2]   = CY_c9_41_l2_f3;
    assign PROP_LA_l2_floating_placement[3:2] = PROP_c9_41_l2_f3;
    
    assign CY_LA_l2_floating_placement[5:4]   = CY_c15_3_l2_f5;
    assign PROP_LA_l2_floating_placement[5:4] = PROP_c15_3_l2_f5;
    
    assign layer3_col0[2] = layer2_col0[34];
    assign layer3_col0[3] = layer2_col0[35];
    assign layer3_col0[4] = layer2_col0[36];
    assign layer3_col0[5] = layer2_col0[37];
    assign layer3_col0[6] = layer2_col0[38];
    assign layer3_col0[7] = layer2_col0[39];
    assign layer3_col0[8] = layer2_col0[40];
    assign layer3_col0[9] = layer2_col0[41];
    assign layer3_col0[10] = layer2_col0[42];
    assign layer3_col0[11] = layer2_col0[43];
    assign layer3_col0[12] = layer2_col0[44];
    assign layer3_col0[13] = layer2_col0[45];
    assign layer3_col0[14] = layer2_col0[46];
    assign layer3_col0[15] = layer2_col0[47];
    assign layer3_col0[16] = layer2_col0[48];
    assign layer3_col0[17] = layer2_col0[49];
    assign layer3_col0[18] = layer2_col0[50];
    assign layer3_col0[19] = layer2_col0[51];
    assign layer3_col0[20] = layer2_col0[52];
    assign layer3_col0[21] = layer2_col0[53];
    assign layer3_col0[22] = layer2_col0[54];
    assign layer3_col0[23] = layer2_col0[55];
    assign layer3_col0[24] = layer2_col0[56];
    assign layer3_col0[25] = layer2_col0[57];
    assign layer3_col0[26] = layer2_col0[58];
    assign layer3_col0[27] = layer2_col0[59];
    assign layer3_col0[28] = layer2_col0[60];
    assign layer3_col0[29] = layer2_col0[61];
    assign layer3_col0[30] = layer2_col0[62];
    assign layer3_col0[31] = layer2_col0[63];
    assign layer3_col2[16] = layer2_col2[24];
    assign layer3_col2[17] = layer2_col2[25];
    assign layer3_col2[18] = layer2_col2[26];
    assign layer3_col2[19] = layer2_col2[27];
    assign layer3_col2[20] = layer2_col2[28];
    assign layer3_col2[21] = layer2_col2[29];
    assign layer3_col2[22] = layer2_col2[30];
    assign layer3_col2[23] = layer2_col2[31];
    // ------------------------------ LAYER 3 ------------------------------
    // GPC0 in layer3: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l3_f0(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l3_f0   ),
        .C1   (C1_c517_451_l3_f0   ),
        .CLA  (CLA_c517_451_l3_f0  ),
        .O0   (O0_c517_451_l3_f0   ),
        .O1   (O1_c517_451_l3_f0   ),
        .O2   (O2_c517_451_l3_f0   ),
        .CY0  (CY0_c517_451_l3_f0  ),
        .PROP0(PROP0_c517_451_l3_f0),
        .CY1  (CY1_c517_451_l3_f0  ),
        .PROP1(PROP1_c517_451_l3_f0));
    
    assign C0_c517_451_l3_f0 = layer3_col0[16:0];
    assign C1_c517_451_l3_f0 = layer3_col1[4:0];
    
    assign layer4_col0[0]   = O0_c517_451_l3_f0;
    assign layer4_col1[4:0] = O1_c517_451_l3_f0;
    assign layer4_col2[3:0] = O2_c517_451_l3_f0;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f0_inst0 (
        .COUTB(COUT_LA_l3_f0[0]),
        .COUTD(COUT_LA_l3_f0[1]),
        .COUTF(COUT_LA_l3_f0[2]),
        .COUTH(COUT_LA_l3_f0[3]),
        .CIN  (CIN_LA_l3_f0    ),
        .CYA  (CY_LA_l3_f0[0]  ),
        .CYB  (CY_LA_l3_f0[1]  ),
        .CYC  (CY_LA_l3_f0[2]  ),
        .CYD  (CY_LA_l3_f0[3]  ),
        .CYE  (CY_LA_l3_f0[4]  ),
        .CYF  (CY_LA_l3_f0[5]  ),
        .CYG  (CY_LA_l3_f0[6]  ),
        .CYH  (CY_LA_l3_f0[7]  ),
        .PROPA(PROP_LA_l3_f0[0]),
        .PROPB(PROP_LA_l3_f0[1]),
        .PROPC(PROP_LA_l3_f0[2]),
        .PROPD(PROP_LA_l3_f0[3]),
        .PROPE(PROP_LA_l3_f0[4]),
        .PROPF(PROP_LA_l3_f0[5]),
        .PROPG(PROP_LA_l3_f0[6]),
        .PROPH(PROP_LA_l3_f0[7]));

    assign CLA_c517_451_l3_f0[0] = COUT_LA_l3_f0[0];
    assign CLA_c517_451_l3_f0[1] = COUT_LA_l3_f0[2];
    assign CIN_LA_l3_f0          = C0_c517_451_l3_f0[8];
    assign CY_LA_l3_f0[3:0]      = CY0_c517_451_l3_f0;
    assign CY_LA_l3_f0[7:4]      = CY1_c517_451_l3_f0;
    assign PROP_LA_l3_f0[3:0]    = PROP0_c517_451_l3_f0;
    assign PROP_LA_l3_f0[7:4]    = PROP1_c517_451_l3_f0;
    
    // GPC chain0 in layer3:
    // -- (1,5 : 3] at column 1
    // -- (9 : 4,1) at column 3
    
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

    c15_3 #(.OUTREG("TRUE" ),
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
    
    assign C0_c15_3_l3_c0_i0 = layer3_col1[9:5];
    assign C1_c15_3_l3_c0_i0 = layer3_col2[0];
    
    assign layer4_col1[5] = O_c15_3_l3_c0_i0[0];
    assign layer4_col2[4] = O_c15_3_l3_c0_i0[1];
    
    assign l3_c0_i0              = COUT_LA_l3_c0_s0[0];
    assign CY_LA_l3_c0_s0[1:0]   = CY_c15_3_l3_c0_i0;
    assign PROP_LA_l3_c0_s0[1:0] = PROP_c15_3_l3_c0_i0;
    
    assign CIN_LA_l3_c0_s0    = C0_c15_3_l3_c0_i0[4];
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l3_c0_i1(
        .clk (clk                ),
        .C0  (C0_c9_41_l3_c0_i1  ),
        .CLA (CLA_c9_41_l3_c0_i1 ),
        .O0  (O0_c9_41_l3_c0_i1  ),
        .O1  (O1_c9_41_l3_c0_i1  ),
        .CY  (CY_c9_41_l3_c0_i1  ),
        .PROP(PROP_c9_41_l3_c0_i1));
    
    assign C0_c9_41_l3_c0_i1 = {l3_c0_i0, layer3_col3[7:0]};
    
    assign layer4_col3[0]   = O0_c9_41_l3_c0_i1;
    assign layer4_col4[3:0] = O1_c9_41_l3_c0_i1;
    
    assign l3_c0_i1              = COUT_LA_l3_c0_s0[1];
    assign CY_LA_l3_c0_s0[3:2]   = CY_c9_41_l3_c0_i1;
    assign PROP_LA_l3_c0_s0[3:2] = PROP_c9_41_l3_c0_i1;
    
    // GPC1 in layer3: (3 : 2] at column 3
    
    c3_2 #(.OUTREG("TRUE" ),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l3_f1(
        .clk (clk            ),
        .C0  (C0_c3_2_l3_f1  ),
        .O   (O_c3_2_l3_i1   ),
        .CY  (CY_c3_2_l3_f1  ),
        .PROP(PROP_c3_2_l3_f1));
    
    assign C0_c3_2_l3_f1 = layer3_col3[10:8];
    
    assign layer4_col3[1] = O_c3_2_l3_i1[0];
    assign layer4_col4[4] = O_c3_2_l3_i1[1];
    
    // GPC chain1 in layer3:
    // -- (1,5 : 3] at column 0
    // -- (9 : 4,1) at column 2
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_c1_s0_inst0 (
        .COUTB(COUT_LA_l3_c1_s0[0]),
        .COUTD(COUT_LA_l3_c1_s0[1]),
        .COUTF(COUT_LA_l3_c1_s0[2]),
        .COUTH(COUT_LA_l3_c1_s0[3]),
        .CIN  (CIN_LA_l3_c1_s0    ),
        .CYA  (CY_LA_l3_c1_s0[0]  ),
        .CYB  (CY_LA_l3_c1_s0[1]  ),
        .CYC  (CY_LA_l3_c1_s0[2]  ),
        .CYD  (CY_LA_l3_c1_s0[3]  ),
        .CYE  (CY_LA_l3_c1_s0[4]  ),
        .CYF  (CY_LA_l3_c1_s0[5]  ),
        .CYG  (CY_LA_l3_c1_s0[6]  ),
        .CYH  (CY_LA_l3_c1_s0[7]  ),
        .PROPA(PROP_LA_l3_c1_s0[0]),
        .PROPB(PROP_LA_l3_c1_s0[1]),
        .PROPC(PROP_LA_l3_c1_s0[2]),
        .PROPD(PROP_LA_l3_c1_s0[3]),
        .PROPE(PROP_LA_l3_c1_s0[4]),
        .PROPF(PROP_LA_l3_c1_s0[5]),
        .PROPG(PROP_LA_l3_c1_s0[6]),
        .PROPH(PROP_LA_l3_c1_s0[7]));

    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_c1_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l3_c1_i0  ),
        .C1  (C1_c15_3_l3_c1_i0  ),
        .CLA (CLA_c15_3_l3_c1_i0 ),
        .O   (O_c15_3_l3_c1_i0   ),
        .CY  (CY_c15_3_l3_c1_i0  ),
        .PROP(PROP_c15_3_l3_c1_i0));
    
    assign C0_c15_3_l3_c1_i0 = layer3_col0[21:17];
    assign C1_c15_3_l3_c1_i0 = layer3_col1[10];
    
    assign layer4_col0[1] = O_c15_3_l3_c1_i0[0];
    assign layer4_col1[6] = O_c15_3_l3_c1_i0[1];
    
    assign l3_c1_i0              = COUT_LA_l3_c1_s0[0];
    assign CY_LA_l3_c1_s0[1:0]   = CY_c15_3_l3_c1_i0;
    assign PROP_LA_l3_c1_s0[1:0] = PROP_c15_3_l3_c1_i0;
    
    assign CIN_LA_l3_c1_s0    = C0_c15_3_l3_c1_i0[4];
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l3_c1_i1(
        .clk (clk                ),
        .C0  (C0_c9_41_l3_c1_i1  ),
        .CLA (CLA_c9_41_l3_c1_i1 ),
        .O0  (O0_c9_41_l3_c1_i1  ),
        .O1  (O1_c9_41_l3_c1_i1  ),
        .CY  (CY_c9_41_l3_c1_i1  ),
        .PROP(PROP_c9_41_l3_c1_i1));
    
    assign C0_c9_41_l3_c1_i1 = {l3_c1_i0, layer3_col2[8:1]};
    
    assign layer4_col2[5]   = O0_c9_41_l3_c1_i1;
    assign layer4_col3[5:2] = O1_c9_41_l3_c1_i1;
    
    assign l3_c1_i1              = COUT_LA_l3_c1_s0[1];
    assign CY_LA_l3_c1_s0[3:2]   = CY_c9_41_l3_c1_i1;
    assign PROP_LA_l3_c1_s0[3:2] = PROP_c9_41_l3_c1_i1;
    
    // GPC2 in layer3: (1,5 : 3] at column 2
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_f2(
        .clk (clk             ),
        .C0  (C0_c15_3_l3_f2  ),
        .C1  (C1_c15_3_l3_f2  ),
        .CLA (CLA_c15_3_l3_f2 ),
        .O   (O_c15_3_l3_f2   ),
        .CY  (CY_c15_3_l3_f2  ),
        .PROP(PROP_c15_3_l3_f2));
    
    assign C0_c15_3_l3_f2 = layer3_col2[13:9];
    assign C1_c15_3_l3_f2 = layer3_col3[11];
    
    assign layer4_col2[6] = O_c15_3_l3_f2[0];
    assign layer4_col3[6] = O_c15_3_l3_f2[1];
    assign layer4_col4[5] = O_c15_3_l3_f2[2];
    
    // GPC chain2 in layer3:
    // -- (1,5 : 3] at column 0
    // -- (1,5 : 3] at column 2
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_c2_s0_inst0 (
        .COUTB(COUT_LA_l3_c2_s0[0]),
        .COUTD(COUT_LA_l3_c2_s0[1]),
        .COUTF(COUT_LA_l3_c2_s0[2]),
        .COUTH(COUT_LA_l3_c2_s0[3]),
        .CIN  (CIN_LA_l3_c2_s0    ),
        .CYA  (CY_LA_l3_c2_s0[0]  ),
        .CYB  (CY_LA_l3_c2_s0[1]  ),
        .CYC  (CY_LA_l3_c2_s0[2]  ),
        .CYD  (CY_LA_l3_c2_s0[3]  ),
        .CYE  (CY_LA_l3_c2_s0[4]  ),
        .CYF  (CY_LA_l3_c2_s0[5]  ),
        .CYG  (CY_LA_l3_c2_s0[6]  ),
        .CYH  (CY_LA_l3_c2_s0[7]  ),
        .PROPA(PROP_LA_l3_c2_s0[0]),
        .PROPB(PROP_LA_l3_c2_s0[1]),
        .PROPC(PROP_LA_l3_c2_s0[2]),
        .PROPD(PROP_LA_l3_c2_s0[3]),
        .PROPE(PROP_LA_l3_c2_s0[4]),
        .PROPF(PROP_LA_l3_c2_s0[5]),
        .PROPG(PROP_LA_l3_c2_s0[6]),
        .PROPH(PROP_LA_l3_c2_s0[7]));

    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_c2_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l3_c2_i0  ),
        .C1  (C1_c15_3_l3_c2_i0  ),
        .CLA (CLA_c15_3_l3_c2_i0 ),
        .O   (O_c15_3_l3_c2_i0   ),
        .CY  (CY_c15_3_l3_c2_i0  ),
        .PROP(PROP_c15_3_l3_c2_i0));
    
    assign C0_c15_3_l3_c2_i0 = layer3_col0[26:22];
    assign C1_c15_3_l3_c2_i0 = layer3_col1[11];
    
    assign layer4_col0[2] = O_c15_3_l3_c2_i0[0];
    assign layer4_col1[7] = O_c15_3_l3_c2_i0[1];
    
    assign l3_c2_i0              = COUT_LA_l3_c2_s0[0];
    assign CY_LA_l3_c2_s0[1:0]   = CY_c15_3_l3_c2_i0;
    assign PROP_LA_l3_c2_s0[1:0] = PROP_c15_3_l3_c2_i0;
    
    assign CIN_LA_l3_c2_s0    = C0_c15_3_l3_c2_i0[4];
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l3_c2_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l3_c2_i1  ),
        .C1  (C1_c15_3_l3_c2_i1  ),
        .CLA (CLA_c15_3_l3_c2_i1 ),
        .O   (O_c15_3_l3_c2_i1   ),
        .CY  (CY_c15_3_l3_c2_i1  ),
        .PROP(PROP_c15_3_l3_c2_i1));
    
    assign C0_c15_3_l3_c2_i1 = {l3_c2_i0, layer3_col2[17:14]};
    assign C1_c15_3_l3_c2_i1 = layer3_col3[12];
    
    assign layer4_col2[7] = O_c15_3_l3_c2_i1[0];
    assign layer4_col3[7] = O_c15_3_l3_c2_i1[1];
    assign layer4_col4[6] = O_c15_3_l3_c2_i1[2];
    
    assign l3_c2_i1              = COUT_LA_l3_c2_s0[1];
    assign CY_LA_l3_c2_s0[3:2]   = CY_c15_3_l3_c2_i1;
    assign PROP_LA_l3_c2_s0[3:2] = PROP_c15_3_l3_c2_i1;
    
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

    assign CY_LA_l3_floating_placement[1:0]   = CY_c15_3_l3_f2;
    assign PROP_LA_l3_floating_placement[1:0] = PROP_c15_3_l3_f2;
    assign CIN_LA_l3_floating_placement    = C0_c15_3_l3_f2[4];
    
    always_ff @(posedge clk) begin
        layer4_col0[3] <= layer3_col0[27];
        layer4_col0[4] <= layer3_col0[28];
        layer4_col0[5] <= layer3_col0[29];
        layer4_col0[6] <= layer3_col0[30];
        layer4_col0[7] <= layer3_col0[31];
        layer4_col2[8] <= layer3_col2[18];
        layer4_col2[9] <= layer3_col2[19];
        layer4_col2[10] <= layer3_col2[20];
        layer4_col2[11] <= layer3_col2[21];
        layer4_col2[12] <= layer3_col2[22];
        layer4_col2[13] <= layer3_col2[23];
    end
    
    // ------------------------------ LAYER 4 ------------------------------
    // GPC chain0 in layer4:
    // -- (1,5 : 3] at column 0
    // -- (3,9 : 2,3,1) at column 2
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l4_c0_s0_inst0 (
        .COUTB(COUT_LA_l4_c0_s0[0]),
        .COUTD(COUT_LA_l4_c0_s0[1]),
        .COUTF(COUT_LA_l4_c0_s0[2]),
        .COUTH(COUT_LA_l4_c0_s0[3]),
        .CIN  (CIN_LA_l4_c0_s0    ),
        .CYA  (CY_LA_l4_c0_s0[0]  ),
        .CYB  (CY_LA_l4_c0_s0[1]  ),
        .CYC  (CY_LA_l4_c0_s0[2]  ),
        .CYD  (CY_LA_l4_c0_s0[3]  ),
        .CYE  (CY_LA_l4_c0_s0[4]  ),
        .CYF  (CY_LA_l4_c0_s0[5]  ),
        .CYG  (CY_LA_l4_c0_s0[6]  ),
        .CYH  (CY_LA_l4_c0_s0[7]  ),
        .PROPA(PROP_LA_l4_c0_s0[0]),
        .PROPB(PROP_LA_l4_c0_s0[1]),
        .PROPC(PROP_LA_l4_c0_s0[2]),
        .PROPD(PROP_LA_l4_c0_s0[3]),
        .PROPE(PROP_LA_l4_c0_s0[4]),
        .PROPF(PROP_LA_l4_c0_s0[5]),
        .PROPG(PROP_LA_l4_c0_s0[6]),
        .PROPH(PROP_LA_l4_c0_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l4_c0_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l4_c0_i0  ),
        .C1  (C1_c15_3_l4_c0_i0  ),
        .CLA (CLA_c15_3_l4_c0_i0 ),
        .O   (O_c15_3_l4_c0_i0   ),
        .CY  (CY_c15_3_l4_c0_i0  ),
        .PROP(PROP_c15_3_l4_c0_i0));
    
    assign C0_c15_3_l4_c0_i0 = layer4_col0[4:0];
    assign C1_c15_3_l4_c0_i0 = layer4_col1[0];
    
    assign layer5_col0[0] = O_c15_3_l4_c0_i0[0];
    assign layer5_col1[0] = O_c15_3_l4_c0_i0[1];
    
    assign l4_c0_i0              = COUT_LA_l4_c0_s0[0];
    assign CY_LA_l4_c0_s0[1:0]   = CY_c15_3_l4_c0_i0;
    assign PROP_LA_l4_c0_s0[1:0] = PROP_c15_3_l4_c0_i0;
    
    assign CIN_LA_l4_c0_s0    = C0_c15_3_l4_c0_i0[4];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l4_c0_i1(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l4_c0_i1   ),
        .C1   (C1_c39_231_l4_c0_i1   ),
        .CLA  (CLA_c39_231_l4_c0_i1  ),
        .O0   (O0_c39_231_l4_c0_i1   ),
        .O1   (O1_c39_231_l4_c0_i1   ),
        .O2   (O2_c39_231_l4_c0_i1   ),
        .CY0  (CY0_c39_231_l4_c0_i1  ),
        .CY1  (CY1_c39_231_l4_c0_i1  ),
        .PROP0(PROP0_c39_231_l4_c0_i1),
        .PROP1(PROP1_c39_231_l4_c0_i1));
    
    assign C0_c39_231_l4_c0_i1 = {l4_c0_i0, layer4_col2[7:0]};
    assign C1_c39_231_l4_c0_i1 = layer4_col3[2:0];
    
    assign layer5_col2[0]   = O0_c39_231_l4_c0_i1;
    assign layer5_col3[2:0] = O1_c39_231_l4_c0_i1;
    assign layer5_col4[1:0] = O2_c39_231_l4_c0_i1;
    
    assign CLA_c39_231_l4_c0_i1  = COUT_LA_l4_c0_s0[0];
    assign CY_LA_l4_c0_s0[3:2]   = CY0_c39_231_l4_c0_i1;
    assign PROP_LA_l4_c0_s0[3:2] = PROP0_c39_231_l4_c0_i1;
    
    // GPC0 in layer4: (6 : 3] at column 4
    
    c6_3 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"))
    c6_3_l4_f0(
        .clk (clk          ),
        .C0  (C0_c6_3_l4_f0),
        .O   (O_c6_3_l4_f0 ));
    
    assign C0_c6_3_l4_f0 = layer4_col4[5:0];
    
    assign layer5_col4[2] = O_c6_3_l4_f0[0];
    assign layer5_col5[0] = O_c6_3_l4_f0[1];
    assign layer5_col6    = O_c6_3_l4_f0[2];
    // GPC chain1 in layer4:
    // -- (1,5 : 3] at column 1
    // -- (1,5 : 3] at column 3
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l4_c1_s0_inst0 (
        .COUTB(COUT_LA_l4_c1_s0[0]),
        .COUTD(COUT_LA_l4_c1_s0[1]),
        .COUTF(COUT_LA_l4_c1_s0[2]),
        .COUTH(COUT_LA_l4_c1_s0[3]),
        .CIN  (CIN_LA_l4_c1_s0    ),
        .CYA  (CY_LA_l4_c1_s0[0]  ),
        .CYB  (CY_LA_l4_c1_s0[1]  ),
        .CYC  (CY_LA_l4_c1_s0[2]  ),
        .CYD  (CY_LA_l4_c1_s0[3]  ),
        .CYE  (CY_LA_l4_c1_s0[4]  ),
        .CYF  (CY_LA_l4_c1_s0[5]  ),
        .CYG  (CY_LA_l4_c1_s0[6]  ),
        .CYH  (CY_LA_l4_c1_s0[7]  ),
        .PROPA(PROP_LA_l4_c1_s0[0]),
        .PROPB(PROP_LA_l4_c1_s0[1]),
        .PROPC(PROP_LA_l4_c1_s0[2]),
        .PROPD(PROP_LA_l4_c1_s0[3]),
        .PROPE(PROP_LA_l4_c1_s0[4]),
        .PROPF(PROP_LA_l4_c1_s0[5]),
        .PROPG(PROP_LA_l4_c1_s0[6]),
        .PROPH(PROP_LA_l4_c1_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l4_c1_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l4_c1_i0  ),
        .C1  (C1_c15_3_l4_c1_i0  ),
        .CLA (CLA_c15_3_l4_c1_i0 ),
        .O   (O_c15_3_l4_c1_i0   ),
        .CY  (CY_c15_3_l4_c1_i0  ),
        .PROP(PROP_c15_3_l4_c1_i0));
    
    assign C0_c15_3_l4_c1_i0 = layer4_col1[5:1];
    assign C1_c15_3_l4_c1_i0 = layer4_col2[8];
    
    assign layer5_col1[1] = O_c15_3_l4_c1_i0[0];
    assign layer5_col2[1] = O_c15_3_l4_c1_i0[1];
    
    assign l4_c1_i0              = COUT_LA_l4_c1_s0[0];
    assign CY_LA_l4_c1_s0[1:0]   = CY_c15_3_l4_c1_i0;
    assign PROP_LA_l4_c1_s0[1:0] = PROP_c15_3_l4_c1_i0;
    
    assign CIN_LA_l4_c1_s0    = C0_c15_3_l4_c1_i0[4];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l4_c1_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l4_c1_i1  ),
        .C1  (C1_c15_3_l4_c1_i1  ),
        .CLA (CLA_c15_3_l4_c1_i1 ),
        .O   (O_c15_3_l4_c1_i1   ),
        .CY  (CY_c15_3_l4_c1_i1  ),
        .PROP(PROP_c15_3_l4_c1_i1));
    
    assign C0_c15_3_l4_c1_i1 = {l4_c1_i0, layer4_col3[6:3]};
    assign C1_c15_3_l4_c1_i1 = layer4_col4[6];
    
    assign layer5_col3[3] = O_c15_3_l4_c1_i1[0];
    assign layer5_col4[3] = O_c15_3_l4_c1_i1[1];
    assign layer5_col5[1] = O_c15_3_l4_c1_i1[2];
    
    assign l4_c1_i1              = COUT_LA_l4_c1_s0[1];
    assign CY_LA_l4_c1_s0[3:2]   = CY_c15_3_l4_c1_i1;
    assign PROP_LA_l4_c1_s0[3:2] = PROP_c15_3_l4_c1_i1;
    
    // GPC1 in layer4: (1,5 : 3] at column 2
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l4_f1(
        .clk (clk             ),
        .C0  (C0_c15_3_l4_f1  ),
        .C1  (C1_c15_3_l4_f1  ),
        .CLA (CLA_c15_3_l4_f1 ),
        .O   (O_c15_3_l4_f1   ),
        .CY  (CY_c15_3_l4_f1  ),
        .PROP(PROP_c15_3_l4_f1));
    
    assign C0_c15_3_l4_f1 = layer4_col2[13:9];
    assign C1_c15_3_l4_f1 = layer4_col3[7];
    
    assign layer5_col2[2] = O_c15_3_l4_f1[0];
    assign layer5_col3[4] = O_c15_3_l4_f1[1];
    assign layer5_col4[4] = O_c15_3_l4_f1[2];
    
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

    assign CY_LA_l4_floating_placement[1:0]   = CY_c15_3_l4_f1;
    assign PROP_LA_l4_floating_placement[1:0] = PROP_c15_3_l4_f1;
    assign CIN_LA_l4_floating_placement    = C0_c15_3_l4_f1[4];
    
    assign layer5_col0[1] = layer4_col0[5];
    assign layer5_col0[2] = layer4_col0[6];
    assign layer5_col0[3] = layer4_col0[7];
    assign layer5_col1[2] = layer4_col1[6];
    assign layer5_col1[3] = layer4_col1[7];
    // ------------------------------ LAYER 5 ------------------------------
    // GPC chain0 in layer5:
    // -- (3 : 2] at column 3
    // -- (3 : 2] at column 4
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l5_c0_s0_inst0 (
        .COUTB(COUT_LA_l5_c0_s0[0]),
        .COUTD(COUT_LA_l5_c0_s0[1]),
        .COUTF(COUT_LA_l5_c0_s0[2]),
        .COUTH(COUT_LA_l5_c0_s0[3]),
        .CIN  (CIN_LA_l5_c0_s0    ),
        .CYA  (CY_LA_l5_c0_s0[0]  ),
        .CYB  (CY_LA_l5_c0_s0[1]  ),
        .CYC  (CY_LA_l5_c0_s0[2]  ),
        .CYD  (CY_LA_l5_c0_s0[3]  ),
        .CYE  (CY_LA_l5_c0_s0[4]  ),
        .CYF  (CY_LA_l5_c0_s0[5]  ),
        .CYG  (CY_LA_l5_c0_s0[6]  ),
        .CYH  (CY_LA_l5_c0_s0[7]  ),
        .PROPA(PROP_LA_l5_c0_s0[0]),
        .PROPB(PROP_LA_l5_c0_s0[1]),
        .PROPC(PROP_LA_l5_c0_s0[2]),
        .PROPD(PROP_LA_l5_c0_s0[3]),
        .PROPE(PROP_LA_l5_c0_s0[4]),
        .PROPF(PROP_LA_l5_c0_s0[5]),
        .PROPG(PROP_LA_l5_c0_s0[6]),
        .PROPH(PROP_LA_l5_c0_s0[7]));

    c3_2 #(.OUTREG("TRUE" ),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l5_c0_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l5_c0_i0  ),
        .O   (O_c3_2_l5_c0_i0   ),
        .CY  (CY_c3_2_l5_c0_i0  ),
        .PROP(PROP_c3_2_l5_c0_i0));
    
    assign C0_c3_2_l5_c0_i0 = layer5_col3[2:0];
    
    assign layer6_col3[0] = O_c3_2_l5_c0_i0[0];
    
    assign l5_c0_i0            = O_c3_2_l5_c0_i0[1];
    assign CY_LA_l5_c0_s0[0]   = CY_c3_2_l5_c0_i0;
    assign PROP_LA_l5_c0_s0[0] = PROP_c3_2_l5_c0_i0;
    
    assign CIN_LA_l5_c0_s0    = C0_c3_2_l5_c0_i0[2];
    
    c3_2 #(.OUTREG("TRUE" ),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("TRUE" ))
    c3_2_l5_c0_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l5_c0_i1  ),
        .O   (O_c3_2_l5_c0_i1   ),
        .CY  (CY_c3_2_l5_c0_i1  ),
        .PROP(PROP_c3_2_l5_c0_i1));
    
    assign C0_c3_2_l5_c0_i1 = {l5_c0_i0, layer5_col4[1:0]};
    
    assign layer6_col4[0] = O_c3_2_l5_c0_i1[0];
    assign layer6_col5[0] = O_c3_2_l5_c0_i1[1];
    
    assign l5_c0_i1            = COUT_LA_l5_c0_s0[0];
    assign CY_LA_l5_c0_s0[1]   = CY_c3_2_l5_c0_i1;
    assign PROP_LA_l5_c0_s0[1] = PROP_c3_2_l5_c0_i1;
    
    always_ff @(posedge clk) begin
        layer6_col0[0] <= layer5_col0[0];
        layer6_col0[1] <= layer5_col0[1];
        layer6_col0[2] <= layer5_col0[2];
        layer6_col0[3] <= layer5_col0[3];
        layer6_col1[0] <= layer5_col1[0];
        layer6_col1[1] <= layer5_col1[1];
        layer6_col1[2] <= layer5_col1[2];
        layer6_col1[3] <= layer5_col1[3];
        layer6_col2[0] <= layer5_col2[0];
        layer6_col2[1] <= layer5_col2[1];
        layer6_col2[2] <= layer5_col2[2];
        layer6_col3[1] <= layer5_col3[3];
        layer6_col3[2] <= layer5_col3[4];
        layer6_col4[1] <= layer5_col4[2];
        layer6_col4[2] <= layer5_col4[3];
        layer6_col4[3] <= layer5_col4[4];
        layer6_col5[1] <= layer5_col5[0];
        layer6_col5[2] <= layer5_col5[1];
        layer6_col6    <= layer5_col6;
    end
    
    
    
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
    assign C0_c15_3_terminal_chain1_i0[1] = layer6_col1[0];
    assign C0_c15_3_terminal_chain1_i0[2] = layer6_col1[1];
    assign C0_c15_3_terminal_chain1_i0[3] = layer6_col1[2];
    assign C0_c15_3_terminal_chain1_i0[4] = layer6_col1[3];
    assign C1_c15_3_terminal_chain1_i0    = layer6_col2[0];
    
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
    assign C0_c15_3_terminal_chain1_i1[1] = layer6_col3[0];
    assign C0_c15_3_terminal_chain1_i1[2] = layer6_col3[1];
    assign C0_c15_3_terminal_chain1_i1[3] = layer6_col3[2];
    assign C1_c15_3_terminal_chain1_i1    = layer6_col4[0];
    
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer6_col5[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer6_col5[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer6_col5[2];
    assign C1_c15_3_terminal_chain1_i2    = layer6_col6;
    
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
    assign C0_c15_3_terminal_chain2_i0[4] = layer6_col0[3];
    assign C0_c15_3_terminal_chain2_i0[3] = layer6_col0[2];
    assign C0_c15_3_terminal_chain2_i0[2] = layer6_col0[1];
    assign C0_c15_3_terminal_chain2_i0[1] = layer6_col0[0];
    assign C0_c15_3_terminal_chain2_i0[0] = 1'b0;
    assign C1_c15_3_terminal_chain2_i0    = terminal_chain1_out[0];
    
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
    assign C0_c15_3_terminal_chain2_i1[3] = terminal_chain1_out[1];
    assign C0_c15_3_terminal_chain2_i1[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i1[1] = layer6_col2[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer6_col2[2];
    assign C1_c15_3_terminal_chain2_i1    = terminal_chain1_out[2];
    
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
    assign C0_c15_3_terminal_chain2_i2[3] = terminal_chain1_out[3];
    assign C0_c15_3_terminal_chain2_i2[0] = layer6_col4[1];
    assign C0_c15_3_terminal_chain2_i2[1] = layer6_col4[2];
    assign C0_c15_3_terminal_chain2_i2[2] = layer6_col4[3];
    assign C1_c15_3_terminal_chain2_i2    = terminal_chain1_out[4];
    
    assign terminal_chain2_out[4] = O_c15_3_terminal_chain2_i2[0];
    assign terminal_chain2_out[5] = O_c15_3_terminal_chain2_i2[1];
    
    assign terminal_chain2_i2           = COUT_LA_terminal_chain2[2];
    assign CY_LA_terminal_chain2[5:4]   = CY_c15_3_terminal_chain2_i2;
    assign PROP_LA_terminal_chain2[5:4] = PROP_c15_3_terminal_chain2_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i3(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i3  ),
        .O   (O_c3_2_terminal_chain2_i3   ),
        .CY  (CY_c3_2_terminal_chain2_i3  ),
        .PROP(PROP_c3_2_terminal_chain2_i3));
    
    assign C0_c3_2_terminal_chain2_i3[2] = terminal_chain2_i2;
    assign C0_c3_2_terminal_chain2_i3[0] = terminal_chain1_out[5];
    assign C0_c3_2_terminal_chain2_i3[1] = 1'b0;
    
    assign terminal_chain2_out[6] = O_c3_2_terminal_chain2_i3[0];
    
    assign terminal_chain2_i3         = O_c3_2_terminal_chain2_i3[1];
    assign CY_LA_terminal_chain2[6]   = CY_c3_2_terminal_chain2_i3;
    assign PROP_LA_terminal_chain2[6] = PROP_c3_2_terminal_chain2_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i4(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i4  ),
        .O   (O_c3_2_terminal_chain2_i4   ),
        .CY  (CY_c3_2_terminal_chain2_i4  ),
        .PROP(PROP_c3_2_terminal_chain2_i4));
    
    assign C0_c3_2_terminal_chain2_i4[2] = terminal_chain2_i3;
    assign C0_c3_2_terminal_chain2_i4[0] = terminal_chain1_out[6];
    assign C0_c3_2_terminal_chain2_i4[1] = 1'b0;
    
    assign terminal_chain2_out[7] = O_c3_2_terminal_chain2_i4[0];
    assign terminal_chain2_out[8] = O_c3_2_terminal_chain2_i4[1];
    
    assign terminal_chain2_i4         = COUT_LA_terminal_chain2[3];
    assign CY_LA_terminal_chain2[7]   = CY_c3_2_terminal_chain2_i4;
    assign PROP_LA_terminal_chain2[7] = PROP_c3_2_terminal_chain2_i4;
    
    always_ff @(posedge clk) begin
        comp_out[8:0] <= terminal_chain2_out[8:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = in_col0;
    
endmodule