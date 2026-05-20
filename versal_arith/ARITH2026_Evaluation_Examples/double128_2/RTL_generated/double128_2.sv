`timescale 1ns / 1ps

module Comp_double128_2 (
    input  logic           clk,
    input  logic [127 : 0] in_col0,
    input  logic [127 : 0] in_col1,
    output logic [8   : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [127 : 0] layer0_col0;
    logic [127 : 0] layer0_col1;
    
    logic [16 : 0] C0_c517_451_l0_f0;
    logic [4  : 0] C1_c517_451_l0_f0;
    logic [1  : 0] CLA_c517_451_l0_f0;
    logic          O0_c517_451_l0_f0;
    logic [4  : 0] O1_c517_451_l0_f0;
    logic [3  : 0] O2_c517_451_l0_f0;
    logic [3  : 0] CY0_c517_451_l0_f0;
    logic [3  : 0] PROP0_c517_451_l0_f0;
    logic [3  : 0] CY1_c517_451_l0_f0;
    logic [3  : 0] PROP1_c517_451_l0_f0;
    
    logic [3 : 0] COUT_LA_l0_f0;
    logic         CIN_LA_l0_f0;
    logic [7 : 0] CY_LA_l0_f0;
    logic [7 : 0] PROP_LA_l0_f0;
    
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
    
    logic [16 : 0] C0_c517_451_l0_f7;
    logic [4  : 0] C1_c517_451_l0_f7;
    logic [1  : 0] CLA_c517_451_l0_f7;
    logic          O0_c517_451_l0_f7;
    logic [4  : 0] O1_c517_451_l0_f7;
    logic [3  : 0] O2_c517_451_l0_f7;
    logic [3  : 0] CY0_c517_451_l0_f7;
    logic [3  : 0] PROP0_c517_451_l0_f7;
    logic [3  : 0] CY1_c517_451_l0_f7;
    logic [3  : 0] PROP1_c517_451_l0_f7;
    
    logic [3 : 0] COUT_LA_l0_f7;
    logic         CIN_LA_l0_f7;
    logic [7 : 0] CY_LA_l0_f7;
    logic [7 : 0] PROP_LA_l0_f7;
    
    logic [16 : 0] C0_c517_451_l0_f8;
    logic [4  : 0] C1_c517_451_l0_f8;
    logic [1  : 0] CLA_c517_451_l0_f8;
    logic          O0_c517_451_l0_f8;
    logic [4  : 0] O1_c517_451_l0_f8;
    logic [3  : 0] O2_c517_451_l0_f8;
    logic [3  : 0] CY0_c517_451_l0_f8;
    logic [3  : 0] PROP0_c517_451_l0_f8;
    logic [3  : 0] CY1_c517_451_l0_f8;
    logic [3  : 0] PROP1_c517_451_l0_f8;
    
    logic [3 : 0] COUT_LA_l0_f8;
    logic         CIN_LA_l0_f8;
    logic [7 : 0] CY_LA_l0_f8;
    logic [7 : 0] PROP_LA_l0_f8;
    
    logic [16 : 0] C0_c517_451_l0_f9;
    logic [4  : 0] C1_c517_451_l0_f9;
    logic [1  : 0] CLA_c517_451_l0_f9;
    logic          O0_c517_451_l0_f9;
    logic [4  : 0] O1_c517_451_l0_f9;
    logic [3  : 0] O2_c517_451_l0_f9;
    logic [3  : 0] CY0_c517_451_l0_f9;
    logic [3  : 0] PROP0_c517_451_l0_f9;
    logic [3  : 0] CY1_c517_451_l0_f9;
    logic [3  : 0] PROP1_c517_451_l0_f9;
    
    logic [3 : 0] COUT_LA_l0_f9;
    logic         CIN_LA_l0_f9;
    logic [7 : 0] CY_LA_l0_f9;
    logic [7 : 0] PROP_LA_l0_f9;
    
    logic [16 : 0] C0_c517_451_l0_f10;
    logic [4  : 0] C1_c517_451_l0_f10;
    logic [1  : 0] CLA_c517_451_l0_f10;
    logic          O0_c517_451_l0_f10;
    logic [4  : 0] O1_c517_451_l0_f10;
    logic [3  : 0] O2_c517_451_l0_f10;
    logic [3  : 0] CY0_c517_451_l0_f10;
    logic [3  : 0] PROP0_c517_451_l0_f10;
    logic [3  : 0] CY1_c517_451_l0_f10;
    logic [3  : 0] PROP1_c517_451_l0_f10;
    
    logic [3 : 0] COUT_LA_l0_f10;
    logic         CIN_LA_l0_f10;
    logic [7 : 0] CY_LA_l0_f10;
    logic [7 : 0] PROP_LA_l0_f10;
    
    logic [16 : 0] C0_c517_451_l0_f11;
    logic [4  : 0] C1_c517_451_l0_f11;
    logic [1  : 0] CLA_c517_451_l0_f11;
    logic          O0_c517_451_l0_f11;
    logic [4  : 0] O1_c517_451_l0_f11;
    logic [3  : 0] O2_c517_451_l0_f11;
    logic [3  : 0] CY0_c517_451_l0_f11;
    logic [3  : 0] PROP0_c517_451_l0_f11;
    logic [3  : 0] CY1_c517_451_l0_f11;
    logic [3  : 0] PROP1_c517_451_l0_f11;
    
    logic [3 : 0] COUT_LA_l0_f11;
    logic         CIN_LA_l0_f11;
    logic [7 : 0] CY_LA_l0_f11;
    logic [7 : 0] PROP_LA_l0_f11;
    
    logic [16 : 0] C0_c517_451_l0_f12;
    logic [4  : 0] C1_c517_451_l0_f12;
    logic [1  : 0] CLA_c517_451_l0_f12;
    logic          O0_c517_451_l0_f12;
    logic [4  : 0] O1_c517_451_l0_f12;
    logic [3  : 0] O2_c517_451_l0_f12;
    logic [3  : 0] CY0_c517_451_l0_f12;
    logic [3  : 0] PROP0_c517_451_l0_f12;
    logic [3  : 0] CY1_c517_451_l0_f12;
    logic [3  : 0] PROP1_c517_451_l0_f12;
    
    logic [3 : 0] COUT_LA_l0_f12;
    logic         CIN_LA_l0_f12;
    logic [7 : 0] CY_LA_l0_f12;
    logic [7 : 0] PROP_LA_l0_f12;
    
    logic [8 : 0] C0_c39_231_l0_f13;
    logic [2 : 0] C1_c39_231_l0_f13;
    logic         CLA_c39_231_l0_f13;
    logic         O0_c39_231_l0_f13;
    logic [2 : 0] O1_c39_231_l0_f13;
    logic [1 : 0] O2_c39_231_l0_f13;
    logic [1 : 0] CY0_c39_231_l0_f13;
    logic [1 : 0] CY1_c39_231_l0_f13;
    logic [1 : 0] PROP0_c39_231_l0_f13;
    logic [1 : 0] PROP1_c39_231_l0_f13;
    
    logic [7  : 0] COUT_LA_l0_floating_placement;
    logic [1  : 0] CIN_LA_l0_floating_placement;
    logic [15 : 0] CY_LA_l0_floating_placement;
    logic [15 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
    logic [7  : 0] layer1_col0;
    logic [79 : 0] layer1_col1;
    logic [53 : 0] layer1_col2;
    
    logic [3 : 0] COUT_LA_l1_c0_s0;
    logic         CIN_LA_l1_c0_s0;
    logic [7 : 0] CY_LA_l1_c0_s0;
    logic [7 : 0] PROP_LA_l1_c0_s0;
    
    logic [4 : 0] C0_c15_3_l1_c0_i0;
    logic         C1_c15_3_l1_c0_i0;
    logic         CLA_c15_3_l1_c0_i0;
    logic [2 : 0] O_c15_3_l1_c0_i0;
    logic [1 : 0] CY_c15_3_l1_c0_i0;
    logic [1 : 0] PROP_c15_3_l1_c0_i0;
    logic         l1_c0_i0;
    
    logic [8 : 0] C0_c9_41_l1_c0_i1;
    logic         CLA_c9_41_l1_c0_i1;
    logic         O0_c9_41_l1_c0_i1;
    logic [3 : 0] O1_c9_41_l1_c0_i1;
    logic [1 : 0] CY_c9_41_l1_c0_i1;
    logic [1 : 0] PROP_c9_41_l1_c0_i1;
    logic         l1_c0_i1;
    
    logic [8 : 0] C0_c9_41_l1_f0;
    logic         CLA_c9_41_l1_f0;
    logic         O0_c9_41_l1_f0;
    logic [3 : 0] O1_c9_41_l1_f0;
    logic [1 : 0] CY_c9_41_l1_f0;
    logic [1 : 0] PROP_c9_41_l1_f0;
    
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
    
    logic [8 : 0] C0_c39_231_l1_f6;
    logic [2 : 0] C1_c39_231_l1_f6;
    logic         CLA_c39_231_l1_f6;
    logic         O0_c39_231_l1_f6;
    logic [2 : 0] O1_c39_231_l1_f6;
    logic [1 : 0] O2_c39_231_l1_f6;
    logic [1 : 0] CY0_c39_231_l1_f6;
    logic [1 : 0] CY1_c39_231_l1_f6;
    logic [1 : 0] PROP0_c39_231_l1_f6;
    logic [1 : 0] PROP1_c39_231_l1_f6;
    
    logic [3 : 0] COUT_LA_l1_floating_placement;
    logic         CIN_LA_l1_floating_placement;
    logic [7 : 0] CY_LA_l1_floating_placement;
    logic [7 : 0] PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [3  : 0] layer2_col0;
    logic [7  : 0] layer2_col1;
    logic [30 : 0] layer2_col2;
    logic [29 : 0] layer2_col3;
    
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
    
    logic [8 : 0] C0_c9_41_l2_f0;
    logic         CLA_c9_41_l2_f0;
    logic         O0_c9_41_l2_f0;
    logic [3 : 0] O1_c9_41_l2_f0;
    logic [1 : 0] CY_c9_41_l2_f0;
    logic [1 : 0] PROP_c9_41_l2_f0;
    
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
    
    logic [8 : 0] C0_c39_231_l2_f2;
    logic [2 : 0] C1_c39_231_l2_f2;
    logic         CLA_c39_231_l2_f2;
    logic         O0_c39_231_l2_f2;
    logic [2 : 0] O1_c39_231_l2_f2;
    logic [1 : 0] O2_c39_231_l2_f2;
    logic [1 : 0] CY0_c39_231_l2_f2;
    logic [1 : 0] CY1_c39_231_l2_f2;
    logic [1 : 0] PROP0_c39_231_l2_f2;
    logic [1 : 0] PROP1_c39_231_l2_f2;
    
    logic [3 : 0] COUT_LA_l2_floating_placement;
    logic         CIN_LA_l2_floating_placement;
    logic [7 : 0] CY_LA_l2_floating_placement;
    logic [7 : 0] PROP_LA_l2_floating_placement;
    
    // ------------------------------ LAYER 3 ------------------------------
    logic [3  : 0] layer3_col0;
    logic [3  : 0] layer3_col1;
    logic [6  : 0] layer3_col2;
    logic [14 : 0] layer3_col3;
    logic [13 : 0] layer3_col4;
    
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
    
    logic [8 : 0] C0_c39_231_l3_f0;
    logic [2 : 0] C1_c39_231_l3_f0;
    logic         CLA_c39_231_l3_f0;
    logic         O0_c39_231_l3_f0;
    logic [2 : 0] O1_c39_231_l3_f0;
    logic [1 : 0] O2_c39_231_l3_f0;
    logic [1 : 0] CY0_c39_231_l3_f0;
    logic [1 : 0] CY1_c39_231_l3_f0;
    logic [1 : 0] PROP0_c39_231_l3_f0;
    logic [1 : 0] PROP1_c39_231_l3_f0;
    
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
    logic [2  : 0] layer4_col3;
    logic [6  : 0] layer4_col4;
    logic [6  : 0] layer4_col5;
    
    logic [4 : 0] C0_c15_3_l4_f0;
    logic         C1_c15_3_l4_f0;
    logic         CLA_c15_3_l4_f0;
    logic [2 : 0] O_c15_3_l4_f0;
    logic [1 : 0] CY_c15_3_l4_f0;
    logic [1 : 0] PROP_c15_3_l4_f0;
    
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
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [3  : 0] layer5_col0;
    logic [3  : 0] layer5_col1;
    logic [2  : 0] layer5_col2;
    logic [2  : 0] layer5_col3;
    logic [2  : 0] layer5_col4;
    logic [2  : 0] layer5_col5;
    logic [1  : 0] layer5_col6;
    logic          layer5_col7;
    
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
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i3;
    logic [1 : 0] O_c3_2_terminal_chain1_i3;
    logic         CY_c3_2_terminal_chain1_i3;
    logic         PROP_c3_2_terminal_chain1_i3;
    logic         terminal_chain1_i3;
    
    logic [7 : 0] terminal_chain2_out;
    
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
    
    // ------------------------------ LAYER 0 ------------------------------
    // GPC0 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f0(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l0_f0   ),
        .C1   (C1_c517_451_l0_f0   ),
        .CLA  (CLA_c517_451_l0_f0  ),
        .O0   (O0_c517_451_l0_f0   ),
        .O1   (O1_c517_451_l0_f0   ),
        .O2   (O2_c517_451_l0_f0   ),
        .CY0  (CY0_c517_451_l0_f0  ),
        .PROP0(PROP0_c517_451_l0_f0),
        .CY1  (CY1_c517_451_l0_f0  ),
        .PROP1(PROP1_c517_451_l0_f0));
    
    assign C0_c517_451_l0_f0 = layer0_col0[16:0];
    assign C1_c517_451_l0_f0 = layer0_col1[4:0];
    
    assign layer1_col0[0]   = O0_c517_451_l0_f0;
    assign layer1_col1[4:0] = O1_c517_451_l0_f0;
    assign layer1_col2[3:0] = O2_c517_451_l0_f0;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f0_inst0 (
        .COUTB(COUT_LA_l0_f0[0]),
        .COUTD(COUT_LA_l0_f0[1]),
        .COUTF(COUT_LA_l0_f0[2]),
        .COUTH(COUT_LA_l0_f0[3]),
        .CIN  (CIN_LA_l0_f0    ),
        .CYA  (CY_LA_l0_f0[0]  ),
        .CYB  (CY_LA_l0_f0[1]  ),
        .CYC  (CY_LA_l0_f0[2]  ),
        .CYD  (CY_LA_l0_f0[3]  ),
        .CYE  (CY_LA_l0_f0[4]  ),
        .CYF  (CY_LA_l0_f0[5]  ),
        .CYG  (CY_LA_l0_f0[6]  ),
        .CYH  (CY_LA_l0_f0[7]  ),
        .PROPA(PROP_LA_l0_f0[0]),
        .PROPB(PROP_LA_l0_f0[1]),
        .PROPC(PROP_LA_l0_f0[2]),
        .PROPD(PROP_LA_l0_f0[3]),
        .PROPE(PROP_LA_l0_f0[4]),
        .PROPF(PROP_LA_l0_f0[5]),
        .PROPG(PROP_LA_l0_f0[6]),
        .PROPH(PROP_LA_l0_f0[7]));

    assign CLA_c517_451_l0_f0[0] = COUT_LA_l0_f0[0];
    assign CLA_c517_451_l0_f0[1] = COUT_LA_l0_f0[2];
    assign CIN_LA_l0_f0          = C0_c517_451_l0_f0[8];
    assign CY_LA_l0_f0[3:0]      = CY0_c517_451_l0_f0;
    assign CY_LA_l0_f0[7:4]      = CY1_c517_451_l0_f0;
    assign PROP_LA_l0_f0[3:0]    = PROP0_c517_451_l0_f0;
    assign PROP_LA_l0_f0[7:4]    = PROP1_c517_451_l0_f0;
    
    // GPC1 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f1 = layer0_col1[13:5];
    
    assign layer1_col1[5]   = O0_c9_41_l0_f1;
    assign layer1_col2[7:4] = O1_c9_41_l0_f1;
    
    // GPC2 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f2 = layer0_col1[22:14];
    
    assign layer1_col1[6]    = O0_c9_41_l0_f2;
    assign layer1_col2[11:8] = O1_c9_41_l0_f2;
    
    // GPC3 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f3 = layer0_col1[31:23];
    
    assign layer1_col1[7]     = O0_c9_41_l0_f3;
    assign layer1_col2[15:12] = O1_c9_41_l0_f3;
    
    // GPC4 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f4 = layer0_col1[40:32];
    
    assign layer1_col1[8]     = O0_c9_41_l0_f4;
    assign layer1_col2[19:16] = O1_c9_41_l0_f4;
    
    // GPC5 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f5 = layer0_col1[49:41];
    
    assign layer1_col1[9]     = O0_c9_41_l0_f5;
    assign layer1_col2[23:20] = O1_c9_41_l0_f5;
    
    // GPC6 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f6 = layer0_col1[58:50];
    
    assign layer1_col1[10]    = O0_c9_41_l0_f6;
    assign layer1_col2[27:24] = O1_c9_41_l0_f6;
    
    // GPC7 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f7(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l0_f7   ),
        .C1   (C1_c517_451_l0_f7   ),
        .CLA  (CLA_c517_451_l0_f7  ),
        .O0   (O0_c517_451_l0_f7   ),
        .O1   (O1_c517_451_l0_f7   ),
        .O2   (O2_c517_451_l0_f7   ),
        .CY0  (CY0_c517_451_l0_f7  ),
        .PROP0(PROP0_c517_451_l0_f7),
        .CY1  (CY1_c517_451_l0_f7  ),
        .PROP1(PROP1_c517_451_l0_f7));
    
    assign C0_c517_451_l0_f7 = layer0_col0[33:17];
    assign C1_c517_451_l0_f7 = layer0_col1[63:59];
    
    assign layer1_col0[1]     = O0_c517_451_l0_f7;
    assign layer1_col1[15:11] = O1_c517_451_l0_f7;
    assign layer1_col2[31:28] = O2_c517_451_l0_f7;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f7_inst0 (
        .COUTB(COUT_LA_l0_f7[0]),
        .COUTD(COUT_LA_l0_f7[1]),
        .COUTF(COUT_LA_l0_f7[2]),
        .COUTH(COUT_LA_l0_f7[3]),
        .CIN  (CIN_LA_l0_f7    ),
        .CYA  (CY_LA_l0_f7[0]  ),
        .CYB  (CY_LA_l0_f7[1]  ),
        .CYC  (CY_LA_l0_f7[2]  ),
        .CYD  (CY_LA_l0_f7[3]  ),
        .CYE  (CY_LA_l0_f7[4]  ),
        .CYF  (CY_LA_l0_f7[5]  ),
        .CYG  (CY_LA_l0_f7[6]  ),
        .CYH  (CY_LA_l0_f7[7]  ),
        .PROPA(PROP_LA_l0_f7[0]),
        .PROPB(PROP_LA_l0_f7[1]),
        .PROPC(PROP_LA_l0_f7[2]),
        .PROPD(PROP_LA_l0_f7[3]),
        .PROPE(PROP_LA_l0_f7[4]),
        .PROPF(PROP_LA_l0_f7[5]),
        .PROPG(PROP_LA_l0_f7[6]),
        .PROPH(PROP_LA_l0_f7[7]));

    assign CLA_c517_451_l0_f7[0] = COUT_LA_l0_f7[0];
    assign CLA_c517_451_l0_f7[1] = COUT_LA_l0_f7[2];
    assign CIN_LA_l0_f7          = C0_c517_451_l0_f7[8];
    assign CY_LA_l0_f7[3:0]      = CY0_c517_451_l0_f7;
    assign CY_LA_l0_f7[7:4]      = CY1_c517_451_l0_f7;
    assign PROP_LA_l0_f7[3:0]    = PROP0_c517_451_l0_f7;
    assign PROP_LA_l0_f7[7:4]    = PROP1_c517_451_l0_f7;
    
    // GPC8 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f8(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l0_f8   ),
        .C1   (C1_c517_451_l0_f8   ),
        .CLA  (CLA_c517_451_l0_f8  ),
        .O0   (O0_c517_451_l0_f8   ),
        .O1   (O1_c517_451_l0_f8   ),
        .O2   (O2_c517_451_l0_f8   ),
        .CY0  (CY0_c517_451_l0_f8  ),
        .PROP0(PROP0_c517_451_l0_f8),
        .CY1  (CY1_c517_451_l0_f8  ),
        .PROP1(PROP1_c517_451_l0_f8));
    
    assign C0_c517_451_l0_f8 = layer0_col0[50:34];
    assign C1_c517_451_l0_f8 = layer0_col1[68:64];
    
    assign layer1_col0[2]     = O0_c517_451_l0_f8;
    assign layer1_col1[20:16] = O1_c517_451_l0_f8;
    assign layer1_col2[35:32] = O2_c517_451_l0_f8;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f8_inst0 (
        .COUTB(COUT_LA_l0_f8[0]),
        .COUTD(COUT_LA_l0_f8[1]),
        .COUTF(COUT_LA_l0_f8[2]),
        .COUTH(COUT_LA_l0_f8[3]),
        .CIN  (CIN_LA_l0_f8    ),
        .CYA  (CY_LA_l0_f8[0]  ),
        .CYB  (CY_LA_l0_f8[1]  ),
        .CYC  (CY_LA_l0_f8[2]  ),
        .CYD  (CY_LA_l0_f8[3]  ),
        .CYE  (CY_LA_l0_f8[4]  ),
        .CYF  (CY_LA_l0_f8[5]  ),
        .CYG  (CY_LA_l0_f8[6]  ),
        .CYH  (CY_LA_l0_f8[7]  ),
        .PROPA(PROP_LA_l0_f8[0]),
        .PROPB(PROP_LA_l0_f8[1]),
        .PROPC(PROP_LA_l0_f8[2]),
        .PROPD(PROP_LA_l0_f8[3]),
        .PROPE(PROP_LA_l0_f8[4]),
        .PROPF(PROP_LA_l0_f8[5]),
        .PROPG(PROP_LA_l0_f8[6]),
        .PROPH(PROP_LA_l0_f8[7]));

    assign CLA_c517_451_l0_f8[0] = COUT_LA_l0_f8[0];
    assign CLA_c517_451_l0_f8[1] = COUT_LA_l0_f8[2];
    assign CIN_LA_l0_f8          = C0_c517_451_l0_f8[8];
    assign CY_LA_l0_f8[3:0]      = CY0_c517_451_l0_f8;
    assign CY_LA_l0_f8[7:4]      = CY1_c517_451_l0_f8;
    assign PROP_LA_l0_f8[3:0]    = PROP0_c517_451_l0_f8;
    assign PROP_LA_l0_f8[7:4]    = PROP1_c517_451_l0_f8;
    
    // GPC9 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f9(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l0_f9   ),
        .C1   (C1_c517_451_l0_f9   ),
        .CLA  (CLA_c517_451_l0_f9  ),
        .O0   (O0_c517_451_l0_f9   ),
        .O1   (O1_c517_451_l0_f9   ),
        .O2   (O2_c517_451_l0_f9   ),
        .CY0  (CY0_c517_451_l0_f9  ),
        .PROP0(PROP0_c517_451_l0_f9),
        .CY1  (CY1_c517_451_l0_f9  ),
        .PROP1(PROP1_c517_451_l0_f9));
    
    assign C0_c517_451_l0_f9 = layer0_col0[67:51];
    assign C1_c517_451_l0_f9 = layer0_col1[73:69];
    
    assign layer1_col0[3]     = O0_c517_451_l0_f9;
    assign layer1_col1[25:21] = O1_c517_451_l0_f9;
    assign layer1_col2[39:36] = O2_c517_451_l0_f9;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f9_inst0 (
        .COUTB(COUT_LA_l0_f9[0]),
        .COUTD(COUT_LA_l0_f9[1]),
        .COUTF(COUT_LA_l0_f9[2]),
        .COUTH(COUT_LA_l0_f9[3]),
        .CIN  (CIN_LA_l0_f9    ),
        .CYA  (CY_LA_l0_f9[0]  ),
        .CYB  (CY_LA_l0_f9[1]  ),
        .CYC  (CY_LA_l0_f9[2]  ),
        .CYD  (CY_LA_l0_f9[3]  ),
        .CYE  (CY_LA_l0_f9[4]  ),
        .CYF  (CY_LA_l0_f9[5]  ),
        .CYG  (CY_LA_l0_f9[6]  ),
        .CYH  (CY_LA_l0_f9[7]  ),
        .PROPA(PROP_LA_l0_f9[0]),
        .PROPB(PROP_LA_l0_f9[1]),
        .PROPC(PROP_LA_l0_f9[2]),
        .PROPD(PROP_LA_l0_f9[3]),
        .PROPE(PROP_LA_l0_f9[4]),
        .PROPF(PROP_LA_l0_f9[5]),
        .PROPG(PROP_LA_l0_f9[6]),
        .PROPH(PROP_LA_l0_f9[7]));

    assign CLA_c517_451_l0_f9[0] = COUT_LA_l0_f9[0];
    assign CLA_c517_451_l0_f9[1] = COUT_LA_l0_f9[2];
    assign CIN_LA_l0_f9          = C0_c517_451_l0_f9[8];
    assign CY_LA_l0_f9[3:0]      = CY0_c517_451_l0_f9;
    assign CY_LA_l0_f9[7:4]      = CY1_c517_451_l0_f9;
    assign PROP_LA_l0_f9[3:0]    = PROP0_c517_451_l0_f9;
    assign PROP_LA_l0_f9[7:4]    = PROP1_c517_451_l0_f9;
    
    // GPC10 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f10(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f10   ),
        .C1   (C1_c517_451_l0_f10   ),
        .CLA  (CLA_c517_451_l0_f10  ),
        .O0   (O0_c517_451_l0_f10   ),
        .O1   (O1_c517_451_l0_f10   ),
        .O2   (O2_c517_451_l0_f10   ),
        .CY0  (CY0_c517_451_l0_f10  ),
        .PROP0(PROP0_c517_451_l0_f10),
        .CY1  (CY1_c517_451_l0_f10  ),
        .PROP1(PROP1_c517_451_l0_f10));
    
    assign C0_c517_451_l0_f10 = layer0_col0[84:68];
    assign C1_c517_451_l0_f10 = layer0_col1[78:74];
    
    assign layer1_col0[4]     = O0_c517_451_l0_f10;
    assign layer1_col1[30:26] = O1_c517_451_l0_f10;
    assign layer1_col2[43:40] = O2_c517_451_l0_f10;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f10_inst0 (
        .COUTB(COUT_LA_l0_f10[0]),
        .COUTD(COUT_LA_l0_f10[1]),
        .COUTF(COUT_LA_l0_f10[2]),
        .COUTH(COUT_LA_l0_f10[3]),
        .CIN  (CIN_LA_l0_f10    ),
        .CYA  (CY_LA_l0_f10[0]  ),
        .CYB  (CY_LA_l0_f10[1]  ),
        .CYC  (CY_LA_l0_f10[2]  ),
        .CYD  (CY_LA_l0_f10[3]  ),
        .CYE  (CY_LA_l0_f10[4]  ),
        .CYF  (CY_LA_l0_f10[5]  ),
        .CYG  (CY_LA_l0_f10[6]  ),
        .CYH  (CY_LA_l0_f10[7]  ),
        .PROPA(PROP_LA_l0_f10[0]),
        .PROPB(PROP_LA_l0_f10[1]),
        .PROPC(PROP_LA_l0_f10[2]),
        .PROPD(PROP_LA_l0_f10[3]),
        .PROPE(PROP_LA_l0_f10[4]),
        .PROPF(PROP_LA_l0_f10[5]),
        .PROPG(PROP_LA_l0_f10[6]),
        .PROPH(PROP_LA_l0_f10[7]));

    assign CLA_c517_451_l0_f10[0] = COUT_LA_l0_f10[0];
    assign CLA_c517_451_l0_f10[1] = COUT_LA_l0_f10[2];
    assign CIN_LA_l0_f10          = C0_c517_451_l0_f10[8];
    assign CY_LA_l0_f10[3:0]      = CY0_c517_451_l0_f10;
    assign CY_LA_l0_f10[7:4]      = CY1_c517_451_l0_f10;
    assign PROP_LA_l0_f10[3:0]    = PROP0_c517_451_l0_f10;
    assign PROP_LA_l0_f10[7:4]    = PROP1_c517_451_l0_f10;
    
    // GPC11 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f11(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f11   ),
        .C1   (C1_c517_451_l0_f11   ),
        .CLA  (CLA_c517_451_l0_f11  ),
        .O0   (O0_c517_451_l0_f11   ),
        .O1   (O1_c517_451_l0_f11   ),
        .O2   (O2_c517_451_l0_f11   ),
        .CY0  (CY0_c517_451_l0_f11  ),
        .PROP0(PROP0_c517_451_l0_f11),
        .CY1  (CY1_c517_451_l0_f11  ),
        .PROP1(PROP1_c517_451_l0_f11));
    
    assign C0_c517_451_l0_f11 = layer0_col0[101:85];
    assign C1_c517_451_l0_f11 = layer0_col1[83:79];
    
    assign layer1_col0[5]     = O0_c517_451_l0_f11;
    assign layer1_col1[35:31] = O1_c517_451_l0_f11;
    assign layer1_col2[47:44] = O2_c517_451_l0_f11;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f11_inst0 (
        .COUTB(COUT_LA_l0_f11[0]),
        .COUTD(COUT_LA_l0_f11[1]),
        .COUTF(COUT_LA_l0_f11[2]),
        .COUTH(COUT_LA_l0_f11[3]),
        .CIN  (CIN_LA_l0_f11    ),
        .CYA  (CY_LA_l0_f11[0]  ),
        .CYB  (CY_LA_l0_f11[1]  ),
        .CYC  (CY_LA_l0_f11[2]  ),
        .CYD  (CY_LA_l0_f11[3]  ),
        .CYE  (CY_LA_l0_f11[4]  ),
        .CYF  (CY_LA_l0_f11[5]  ),
        .CYG  (CY_LA_l0_f11[6]  ),
        .CYH  (CY_LA_l0_f11[7]  ),
        .PROPA(PROP_LA_l0_f11[0]),
        .PROPB(PROP_LA_l0_f11[1]),
        .PROPC(PROP_LA_l0_f11[2]),
        .PROPD(PROP_LA_l0_f11[3]),
        .PROPE(PROP_LA_l0_f11[4]),
        .PROPF(PROP_LA_l0_f11[5]),
        .PROPG(PROP_LA_l0_f11[6]),
        .PROPH(PROP_LA_l0_f11[7]));

    assign CLA_c517_451_l0_f11[0] = COUT_LA_l0_f11[0];
    assign CLA_c517_451_l0_f11[1] = COUT_LA_l0_f11[2];
    assign CIN_LA_l0_f11          = C0_c517_451_l0_f11[8];
    assign CY_LA_l0_f11[3:0]      = CY0_c517_451_l0_f11;
    assign CY_LA_l0_f11[7:4]      = CY1_c517_451_l0_f11;
    assign PROP_LA_l0_f11[3:0]    = PROP0_c517_451_l0_f11;
    assign PROP_LA_l0_f11[7:4]    = PROP1_c517_451_l0_f11;
    
    // GPC12 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f12(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f12   ),
        .C1   (C1_c517_451_l0_f12   ),
        .CLA  (CLA_c517_451_l0_f12  ),
        .O0   (O0_c517_451_l0_f12   ),
        .O1   (O1_c517_451_l0_f12   ),
        .O2   (O2_c517_451_l0_f12   ),
        .CY0  (CY0_c517_451_l0_f12  ),
        .PROP0(PROP0_c517_451_l0_f12),
        .CY1  (CY1_c517_451_l0_f12  ),
        .PROP1(PROP1_c517_451_l0_f12));
    
    assign C0_c517_451_l0_f12 = layer0_col0[118:102];
    assign C1_c517_451_l0_f12 = layer0_col1[88:84];
    
    assign layer1_col0[6]     = O0_c517_451_l0_f12;
    assign layer1_col1[40:36] = O1_c517_451_l0_f12;
    assign layer1_col2[51:48] = O2_c517_451_l0_f12;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f12_inst0 (
        .COUTB(COUT_LA_l0_f12[0]),
        .COUTD(COUT_LA_l0_f12[1]),
        .COUTF(COUT_LA_l0_f12[2]),
        .COUTH(COUT_LA_l0_f12[3]),
        .CIN  (CIN_LA_l0_f12    ),
        .CYA  (CY_LA_l0_f12[0]  ),
        .CYB  (CY_LA_l0_f12[1]  ),
        .CYC  (CY_LA_l0_f12[2]  ),
        .CYD  (CY_LA_l0_f12[3]  ),
        .CYE  (CY_LA_l0_f12[4]  ),
        .CYF  (CY_LA_l0_f12[5]  ),
        .CYG  (CY_LA_l0_f12[6]  ),
        .CYH  (CY_LA_l0_f12[7]  ),
        .PROPA(PROP_LA_l0_f12[0]),
        .PROPB(PROP_LA_l0_f12[1]),
        .PROPC(PROP_LA_l0_f12[2]),
        .PROPD(PROP_LA_l0_f12[3]),
        .PROPE(PROP_LA_l0_f12[4]),
        .PROPF(PROP_LA_l0_f12[5]),
        .PROPG(PROP_LA_l0_f12[6]),
        .PROPH(PROP_LA_l0_f12[7]));

    assign CLA_c517_451_l0_f12[0] = COUT_LA_l0_f12[0];
    assign CLA_c517_451_l0_f12[1] = COUT_LA_l0_f12[2];
    assign CIN_LA_l0_f12          = C0_c517_451_l0_f12[8];
    assign CY_LA_l0_f12[3:0]      = CY0_c517_451_l0_f12;
    assign CY_LA_l0_f12[7:4]      = CY1_c517_451_l0_f12;
    assign PROP_LA_l0_f12[3:0]    = PROP0_c517_451_l0_f12;
    assign PROP_LA_l0_f12[7:4]    = PROP1_c517_451_l0_f12;
    
    // GPC13 in layer0: (3,9 : 2,3,1) at column 0
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l0_f13(
        .clk  (clk                 ),
        .C0   (C0_c39_231_l0_f13   ),
        .C1   (C1_c39_231_l0_f13   ),
        .CLA  (CLA_c39_231_l0_f13  ),
        .O0   (O0_c39_231_l0_f13   ),
        .O1   (O1_c39_231_l0_f13   ),
        .O2   (O2_c39_231_l0_f13   ),
        .CY0  (CY0_c39_231_l0_f13  ),
        .CY1  (CY1_c39_231_l0_f13  ),
        .PROP0(PROP0_c39_231_l0_f13),
        .PROP1(PROP1_c39_231_l0_f13));
    
    assign C0_c39_231_l0_f13 = layer0_col0[127:119];
    assign C1_c39_231_l0_f13 = layer0_col1[91:89];
    
    assign layer1_col0[7]     = O0_c39_231_l0_f13;
    assign layer1_col1[43:41] = O1_c39_231_l0_f13;
    assign layer1_col2[53:52] = O2_c39_231_l0_f13;
    
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

    assign CY_LA_l0_floating_placement[1:0]   = CY_c9_41_l0_f1;
    assign PROP_LA_l0_floating_placement[1:0] = PROP_c9_41_l0_f1;
    assign CIN_LA_l0_floating_placement[0] = C0_c9_41_l0_f1[8];
    
    assign CY_LA_l0_floating_placement[3:2]   = CY_c9_41_l0_f2;
    assign PROP_LA_l0_floating_placement[3:2] = PROP_c9_41_l0_f2;
    
    assign CY_LA_l0_floating_placement[5:4]   = CY_c9_41_l0_f3;
    assign PROP_LA_l0_floating_placement[5:4] = PROP_c9_41_l0_f3;
    
    assign CY_LA_l0_floating_placement[7:6]   = CY_c9_41_l0_f4;
    assign PROP_LA_l0_floating_placement[7:6] = PROP_c9_41_l0_f4;
    
    assign CY_LA_l0_floating_placement[9:8]   = CY_c9_41_l0_f5;
    assign PROP_LA_l0_floating_placement[9:8] = PROP_c9_41_l0_f5;
    assign CIN_LA_l0_floating_placement[1] = C0_c9_41_l0_f5[8];
    
    assign CY_LA_l0_floating_placement[11:10]   = CY_c9_41_l0_f6;
    assign PROP_LA_l0_floating_placement[11:10] = PROP_c9_41_l0_f6;
    
    assign CY_LA_l0_floating_placement[13:12]   = CY0_c39_231_l0_f13;
    assign PROP_LA_l0_floating_placement[13:12] = PROP0_c39_231_l0_f13;
    assign CY_LA_l0_floating_placement[15:14]   = CY1_c39_231_l0_f13;
    assign PROP_LA_l0_floating_placement[15:14] = PROP1_c39_231_l0_f13;
    
    assign layer1_col1[44] = layer0_col1[92];
    assign layer1_col1[45] = layer0_col1[93];
    assign layer1_col1[46] = layer0_col1[94];
    assign layer1_col1[47] = layer0_col1[95];
    assign layer1_col1[48] = layer0_col1[96];
    assign layer1_col1[49] = layer0_col1[97];
    assign layer1_col1[50] = layer0_col1[98];
    assign layer1_col1[51] = layer0_col1[99];
    assign layer1_col1[52] = layer0_col1[100];
    assign layer1_col1[53] = layer0_col1[101];
    assign layer1_col1[54] = layer0_col1[102];
    assign layer1_col1[55] = layer0_col1[103];
    assign layer1_col1[56] = layer0_col1[104];
    assign layer1_col1[57] = layer0_col1[105];
    assign layer1_col1[58] = layer0_col1[106];
    assign layer1_col1[59] = layer0_col1[107];
    assign layer1_col1[60] = layer0_col1[108];
    assign layer1_col1[61] = layer0_col1[109];
    assign layer1_col1[62] = layer0_col1[110];
    assign layer1_col1[63] = layer0_col1[111];
    assign layer1_col1[64] = layer0_col1[112];
    assign layer1_col1[65] = layer0_col1[113];
    assign layer1_col1[66] = layer0_col1[114];
    assign layer1_col1[67] = layer0_col1[115];
    assign layer1_col1[68] = layer0_col1[116];
    assign layer1_col1[69] = layer0_col1[117];
    assign layer1_col1[70] = layer0_col1[118];
    assign layer1_col1[71] = layer0_col1[119];
    assign layer1_col1[72] = layer0_col1[120];
    assign layer1_col1[73] = layer0_col1[121];
    assign layer1_col1[74] = layer0_col1[122];
    assign layer1_col1[75] = layer0_col1[123];
    assign layer1_col1[76] = layer0_col1[124];
    assign layer1_col1[77] = layer0_col1[125];
    assign layer1_col1[78] = layer0_col1[126];
    assign layer1_col1[79] = layer0_col1[127];
    // ------------------------------ LAYER 1 ------------------------------
    // GPC chain0 in layer1:
    // -- (1,5 : 3] at column 0
    // -- (9 : 4,1) at column 2
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_c0_s0_inst0 (
        .COUTB(COUT_LA_l1_c0_s0[0]),
        .COUTD(COUT_LA_l1_c0_s0[1]),
        .COUTF(COUT_LA_l1_c0_s0[2]),
        .COUTH(COUT_LA_l1_c0_s0[3]),
        .CIN  (CIN_LA_l1_c0_s0    ),
        .CYA  (CY_LA_l1_c0_s0[0]  ),
        .CYB  (CY_LA_l1_c0_s0[1]  ),
        .CYC  (CY_LA_l1_c0_s0[2]  ),
        .CYD  (CY_LA_l1_c0_s0[3]  ),
        .CYE  (CY_LA_l1_c0_s0[4]  ),
        .CYF  (CY_LA_l1_c0_s0[5]  ),
        .CYG  (CY_LA_l1_c0_s0[6]  ),
        .CYH  (CY_LA_l1_c0_s0[7]  ),
        .PROPA(PROP_LA_l1_c0_s0[0]),
        .PROPB(PROP_LA_l1_c0_s0[1]),
        .PROPC(PROP_LA_l1_c0_s0[2]),
        .PROPD(PROP_LA_l1_c0_s0[3]),
        .PROPE(PROP_LA_l1_c0_s0[4]),
        .PROPF(PROP_LA_l1_c0_s0[5]),
        .PROPG(PROP_LA_l1_c0_s0[6]),
        .PROPH(PROP_LA_l1_c0_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l1_c0_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c0_i0  ),
        .C1  (C1_c15_3_l1_c0_i0  ),
        .CLA (CLA_c15_3_l1_c0_i0 ),
        .O   (O_c15_3_l1_c0_i0   ),
        .CY  (CY_c15_3_l1_c0_i0  ),
        .PROP(PROP_c15_3_l1_c0_i0));
    
    assign C0_c15_3_l1_c0_i0 = layer1_col0[4:0];
    assign C1_c15_3_l1_c0_i0 = layer1_col1[0];
    
    assign layer2_col0[0] = O_c15_3_l1_c0_i0[0];
    assign layer2_col1[0] = O_c15_3_l1_c0_i0[1];
    
    assign l1_c0_i0              = COUT_LA_l1_c0_s0[0];
    assign CY_LA_l1_c0_s0[1:0]   = CY_c15_3_l1_c0_i0;
    assign PROP_LA_l1_c0_s0[1:0] = PROP_c15_3_l1_c0_i0;
    
    assign CIN_LA_l1_c0_s0    = C0_c15_3_l1_c0_i0[4];
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_c0_i1(
        .clk (clk                ),
        .C0  (C0_c9_41_l1_c0_i1  ),
        .CLA (CLA_c9_41_l1_c0_i1 ),
        .O0  (O0_c9_41_l1_c0_i1  ),
        .O1  (O1_c9_41_l1_c0_i1  ),
        .CY  (CY_c9_41_l1_c0_i1  ),
        .PROP(PROP_c9_41_l1_c0_i1));
    
    assign C0_c9_41_l1_c0_i1 = {l1_c0_i0, layer1_col2[7:0]};
    
    assign layer2_col2[0]   = O0_c9_41_l1_c0_i1;
    assign layer2_col3[3:0] = O1_c9_41_l1_c0_i1;
    
    assign l1_c0_i1              = COUT_LA_l1_c0_s0[1];
    assign CY_LA_l1_c0_s0[3:2]   = CY_c9_41_l1_c0_i1;
    assign PROP_LA_l1_c0_s0[3:2] = PROP_c9_41_l1_c0_i1;
    
    // GPC0 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f0(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f0  ),
        .CLA (CLA_c9_41_l1_f0 ),
        .O0  (O0_c9_41_l1_f0  ),
        .O1  (O1_c9_41_l1_f0  ),
        .CY  (CY_c9_41_l1_f0  ),
        .PROP(PROP_c9_41_l1_f0));
    
    assign C0_c9_41_l1_f0 = layer1_col2[16:8];
    
    assign layer2_col2[1]   = O0_c9_41_l1_f0;
    assign layer2_col3[7:4] = O1_c9_41_l1_f0;
    
    // GPC1 in layer1: (9 : 4,1) at column 2
    
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
    
    assign C0_c9_41_l1_f1 = layer1_col2[25:17];
    
    assign layer2_col2[2]    = O0_c9_41_l1_f1;
    assign layer2_col3[11:8] = O1_c9_41_l1_f1;
    
    // GPC2 in layer1: (5,17 : 4,5,1) at column 1
    
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
    
    assign C0_c517_451_l1_f2 = layer1_col1[17:1];
    assign C1_c517_451_l1_f2 = layer1_col2[30:26];
    
    assign layer2_col1[1]     = O0_c517_451_l1_f2;
    assign layer2_col2[7:3]   = O1_c517_451_l1_f2;
    assign layer2_col3[15:12] = O2_c517_451_l1_f2;
    
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
    
    // GPC3 in layer1: (5,17 : 4,5,1) at column 1
    
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
    
    assign C0_c517_451_l1_f3 = layer1_col1[34:18];
    assign C1_c517_451_l1_f3 = layer1_col2[35:31];
    
    assign layer2_col1[2]     = O0_c517_451_l1_f3;
    assign layer2_col2[12:8]  = O1_c517_451_l1_f3;
    assign layer2_col3[19:16] = O2_c517_451_l1_f3;
    
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
    
    // GPC4 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f4 = layer1_col1[51:35];
    assign C1_c517_451_l1_f4 = layer1_col2[40:36];
    
    assign layer2_col1[3]     = O0_c517_451_l1_f4;
    assign layer2_col2[17:13] = O1_c517_451_l1_f4;
    assign layer2_col3[23:20] = O2_c517_451_l1_f4;
    
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
    
    // GPC5 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f5 = layer1_col1[68:52];
    assign C1_c517_451_l1_f5 = layer1_col2[45:41];
    
    assign layer2_col1[4]     = O0_c517_451_l1_f5;
    assign layer2_col2[22:18] = O1_c517_451_l1_f5;
    assign layer2_col3[27:24] = O2_c517_451_l1_f5;
    
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
    
    // GPC6 in layer1: (3,9 : 2,3,1) at column 1
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l1_f6(
        .clk  (clk                ),
        .C0   (C0_c39_231_l1_f6   ),
        .C1   (C1_c39_231_l1_f6   ),
        .CLA  (CLA_c39_231_l1_f6  ),
        .O0   (O0_c39_231_l1_f6   ),
        .O1   (O1_c39_231_l1_f6   ),
        .O2   (O2_c39_231_l1_f6   ),
        .CY0  (CY0_c39_231_l1_f6  ),
        .CY1  (CY1_c39_231_l1_f6  ),
        .PROP0(PROP0_c39_231_l1_f6),
        .PROP1(PROP1_c39_231_l1_f6));
    
    assign C0_c39_231_l1_f6 = layer1_col1[77:69];
    assign C1_c39_231_l1_f6 = layer1_col2[48:46];
    
    assign layer2_col1[5]     = O0_c39_231_l1_f6;
    assign layer2_col2[25:23] = O1_c39_231_l1_f6;
    assign layer2_col3[29:28] = O2_c39_231_l1_f6;
    
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

    assign CY_LA_l1_floating_placement[1:0]   = CY_c9_41_l1_f0;
    assign PROP_LA_l1_floating_placement[1:0] = PROP_c9_41_l1_f0;
    assign CIN_LA_l1_floating_placement    = C0_c9_41_l1_f0[8];
    
    assign CY_LA_l1_floating_placement[3:2]   = CY_c9_41_l1_f1;
    assign PROP_LA_l1_floating_placement[3:2] = PROP_c9_41_l1_f1;
    
    assign CY_LA_l1_floating_placement[5:4]   = CY0_c39_231_l1_f6;
    assign PROP_LA_l1_floating_placement[5:4] = PROP0_c39_231_l1_f6;
    assign CY_LA_l1_floating_placement[7:6]   = CY1_c39_231_l1_f6;
    assign PROP_LA_l1_floating_placement[7:6] = PROP1_c39_231_l1_f6;
    
    assign layer2_col0[1] = layer1_col0[5];
    assign layer2_col0[2] = layer1_col0[6];
    assign layer2_col0[3] = layer1_col0[7];
    assign layer2_col1[6] = layer1_col1[78];
    assign layer2_col1[7] = layer1_col1[79];
    assign layer2_col2[26] = layer1_col2[49];
    assign layer2_col2[27] = layer1_col2[50];
    assign layer2_col2[28] = layer1_col2[51];
    assign layer2_col2[29] = layer1_col2[52];
    assign layer2_col2[30] = layer1_col2[53];
    // ------------------------------ LAYER 2 ------------------------------
    // GPC chain0 in layer2:
    // -- (1,5 : 3] at column 1
    // -- (9 : 4,1) at column 3
    
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

    c15_3 #(.OUTREG("TRUE" ),
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
    
    assign C0_c15_3_l2_c0_i0 = layer2_col1[4:0];
    assign C1_c15_3_l2_c0_i0 = layer2_col2[0];
    
    assign layer3_col1[0] = O_c15_3_l2_c0_i0[0];
    assign layer3_col2[0] = O_c15_3_l2_c0_i0[1];
    
    assign l2_c0_i0              = COUT_LA_l2_c0_s0[0];
    assign CY_LA_l2_c0_s0[1:0]   = CY_c15_3_l2_c0_i0;
    assign PROP_LA_l2_c0_s0[1:0] = PROP_c15_3_l2_c0_i0;
    
    assign CIN_LA_l2_c0_s0    = C0_c15_3_l2_c0_i0[4];
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    assign C0_c9_41_l2_c0_i1 = {l2_c0_i0, layer2_col3[7:0]};
    
    assign layer3_col3[0]   = O0_c9_41_l2_c0_i1;
    assign layer3_col4[3:0] = O1_c9_41_l2_c0_i1;
    
    assign l2_c0_i1              = COUT_LA_l2_c0_s0[1];
    assign CY_LA_l2_c0_s0[3:2]   = CY_c9_41_l2_c0_i1;
    assign PROP_LA_l2_c0_s0[3:2] = PROP_c9_41_l2_c0_i1;
    
    // GPC0 in layer2: (9 : 4,1) at column 3
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f0(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f0  ),
        .CLA (CLA_c9_41_l2_f0 ),
        .O0  (O0_c9_41_l2_f0  ),
        .O1  (O1_c9_41_l2_f0  ),
        .CY  (CY_c9_41_l2_f0  ),
        .PROP(PROP_c9_41_l2_f0));
    
    assign C0_c9_41_l2_f0 = layer2_col3[16:8];
    
    assign layer3_col3[1]   = O0_c9_41_l2_f0;
    assign layer3_col4[7:4] = O1_c9_41_l2_f0;
    
    // GPC1 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("TRUE" ),
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
    
    assign C0_c517_451_l2_f1 = layer2_col2[17:1];
    assign C1_c517_451_l2_f1 = layer2_col3[21:17];
    
    assign layer3_col2[1]    = O0_c517_451_l2_f1;
    assign layer3_col3[6:2]  = O1_c517_451_l2_f1;
    assign layer3_col4[11:8] = O2_c517_451_l2_f1;
    
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
    
    // GPC2 in layer2: (3,9 : 2,3,1) at column 2
    
    c39_231 #(.OUTREG("TRUE" ),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l2_f2(
        .clk  (clk                ),
        .C0   (C0_c39_231_l2_f2   ),
        .C1   (C1_c39_231_l2_f2   ),
        .CLA  (CLA_c39_231_l2_f2  ),
        .O0   (O0_c39_231_l2_f2   ),
        .O1   (O1_c39_231_l2_f2   ),
        .O2   (O2_c39_231_l2_f2   ),
        .CY0  (CY0_c39_231_l2_f2  ),
        .CY1  (CY1_c39_231_l2_f2  ),
        .PROP0(PROP0_c39_231_l2_f2),
        .PROP1(PROP1_c39_231_l2_f2));
    
    assign C0_c39_231_l2_f2 = layer2_col2[26:18];
    assign C1_c39_231_l2_f2 = layer2_col3[24:22];
    
    assign layer3_col2[2]     = O0_c39_231_l2_f2;
    assign layer3_col3[9:7]   = O1_c39_231_l2_f2;
    assign layer3_col4[13:12] = O2_c39_231_l2_f2;
    
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

    assign CY_LA_l2_floating_placement[1:0]   = CY_c9_41_l2_f0;
    assign PROP_LA_l2_floating_placement[1:0] = PROP_c9_41_l2_f0;
    assign CIN_LA_l2_floating_placement    = C0_c9_41_l2_f0[8];
    
    assign CY_LA_l2_floating_placement[3:2]   = CY0_c39_231_l2_f2;
    assign PROP_LA_l2_floating_placement[3:2] = PROP0_c39_231_l2_f2;
    assign CY_LA_l2_floating_placement[5:4]   = CY1_c39_231_l2_f2;
    assign PROP_LA_l2_floating_placement[5:4] = PROP1_c39_231_l2_f2;
    
    always_ff @(posedge clk) begin
        layer3_col0[0] <= layer2_col0[0];
        layer3_col0[1] <= layer2_col0[1];
        layer3_col0[2] <= layer2_col0[2];
        layer3_col0[3] <= layer2_col0[3];
        layer3_col1[1] <= layer2_col1[5];
        layer3_col1[2] <= layer2_col1[6];
        layer3_col1[3] <= layer2_col1[7];
        layer3_col2[3] <= layer2_col2[27];
        layer3_col2[4] <= layer2_col2[28];
        layer3_col2[5] <= layer2_col2[29];
        layer3_col2[6] <= layer2_col2[30];
        layer3_col3[10] <= layer2_col3[25];
        layer3_col3[11] <= layer2_col3[26];
        layer3_col3[12] <= layer2_col3[27];
        layer3_col3[13] <= layer2_col3[28];
        layer3_col3[14] <= layer2_col3[29];
    end
    
    // ------------------------------ LAYER 3 ------------------------------
    // GPC chain0 in layer3:
    // -- (1,5 : 3] at column 2
    // -- (9 : 4,1) at column 4
    
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
    
    assign C0_c15_3_l3_c0_i0 = layer3_col2[4:0];
    assign C1_c15_3_l3_c0_i0 = layer3_col3[0];
    
    assign layer4_col2[0] = O_c15_3_l3_c0_i0[0];
    assign layer4_col3[0] = O_c15_3_l3_c0_i0[1];
    
    assign l3_c0_i0              = COUT_LA_l3_c0_s0[0];
    assign CY_LA_l3_c0_s0[1:0]   = CY_c15_3_l3_c0_i0;
    assign PROP_LA_l3_c0_s0[1:0] = PROP_c15_3_l3_c0_i0;
    
    assign CIN_LA_l3_c0_s0    = C0_c15_3_l3_c0_i0[4];
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l3_c0_i1 = {l3_c0_i0, layer3_col4[7:0]};
    
    assign layer4_col4[0]   = O0_c9_41_l3_c0_i1;
    assign layer4_col5[3:0] = O1_c9_41_l3_c0_i1;
    
    assign l3_c0_i1              = COUT_LA_l3_c0_s0[1];
    assign CY_LA_l3_c0_s0[3:2]   = CY_c9_41_l3_c0_i1;
    assign PROP_LA_l3_c0_s0[3:2] = PROP_c9_41_l3_c0_i1;
    
    // GPC0 in layer3: (3,9 : 2,3,1) at column 3
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l3_f0(
        .clk  (clk                ),
        .C0   (C0_c39_231_l3_f0   ),
        .C1   (C1_c39_231_l3_f0   ),
        .CLA  (CLA_c39_231_l3_f0  ),
        .O0   (O0_c39_231_l3_f0   ),
        .O1   (O1_c39_231_l3_f0   ),
        .O2   (O2_c39_231_l3_f0   ),
        .CY0  (CY0_c39_231_l3_f0  ),
        .CY1  (CY1_c39_231_l3_f0  ),
        .PROP0(PROP0_c39_231_l3_f0),
        .PROP1(PROP1_c39_231_l3_f0));
    
    assign C0_c39_231_l3_f0 = layer3_col3[9:1];
    assign C1_c39_231_l3_f0 = layer3_col4[10:8];
    
    assign layer4_col3[1]   = O0_c39_231_l3_f0;
    assign layer4_col4[3:1] = O1_c39_231_l3_f0;
    assign layer4_col5[5:4] = O2_c39_231_l3_f0;
    
    // GPC1 in layer3: (1,5 : 3] at column 3
    
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
    
    assign C0_c15_3_l3_f1 = layer3_col3[14:10];
    assign C1_c15_3_l3_f1 = layer3_col4[11];
    
    assign layer4_col3[2] = O_c15_3_l3_f1[0];
    assign layer4_col4[4] = O_c15_3_l3_f1[1];
    assign layer4_col5[6] = O_c15_3_l3_f1[2];
    
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

    assign CY_LA_l3_floating_placement[1:0]   = CY0_c39_231_l3_f0;
    assign PROP_LA_l3_floating_placement[1:0] = PROP0_c39_231_l3_f0;
    assign CY_LA_l3_floating_placement[3:2]   = CY1_c39_231_l3_f0;
    assign PROP_LA_l3_floating_placement[3:2] = PROP1_c39_231_l3_f0;
    assign CIN_LA_l3_floating_placement    = C0_c39_231_l3_f0[8];
    
    assign CY_LA_l3_floating_placement[5:4]   = CY_c15_3_l3_f1;
    assign PROP_LA_l3_floating_placement[5:4] = PROP_c15_3_l3_f1;
    
    assign layer4_col0[0] = layer3_col0[0];
    assign layer4_col0[1] = layer3_col0[1];
    assign layer4_col0[2] = layer3_col0[2];
    assign layer4_col0[3] = layer3_col0[3];
    assign layer4_col1[0] = layer3_col1[0];
    assign layer4_col1[1] = layer3_col1[1];
    assign layer4_col1[2] = layer3_col1[2];
    assign layer4_col1[3] = layer3_col1[3];
    assign layer4_col2[1] = layer3_col2[5];
    assign layer4_col2[2] = layer3_col2[6];
    assign layer4_col4[5] = layer3_col4[12];
    assign layer4_col4[6] = layer3_col4[13];
    // ------------------------------ LAYER 4 ------------------------------
    // GPC0 in layer4: (1,5 : 3] at column 4
    
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
    
    assign C0_c15_3_l4_f0 = layer4_col4[4:0];
    assign C1_c15_3_l4_f0 = layer4_col5[0];
    
    assign layer5_col4[0] = O_c15_3_l4_f0[0];
    assign layer5_col5[0] = O_c15_3_l4_f0[1];
    assign layer5_col6[0] = O_c15_3_l4_f0[2];
    
    // GPC1 in layer4: (1,5 : 3] at column 5
    
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
    
    assign C0_c15_3_l4_f1 = layer4_col5[5:1];
    assign C1_c15_3_l4_f1 = 1'b0;
    
    assign layer5_col5[1] = O_c15_3_l4_f1[0];
    assign layer5_col6[1] = O_c15_3_l4_f1[1];
    assign layer5_col7    = O_c15_3_l4_f1[2];
    
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
    
    assign CY_LA_l4_floating_placement[3:2]   = CY_c15_3_l4_f1;
    assign PROP_LA_l4_floating_placement[3:2] = PROP_c15_3_l4_f1;
    
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
    assign layer5_col3[0] = layer4_col3[0];
    assign layer5_col3[1] = layer4_col3[1];
    assign layer5_col3[2] = layer4_col3[2];
    assign layer5_col4[1] = layer4_col4[5];
    assign layer5_col4[2] = layer4_col4[6];
    assign layer5_col5[2] = layer4_col5[6];
    
    
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer5_col4[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer5_col4[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer5_col4[2];
    assign C1_c15_3_terminal_chain1_i2    = layer5_col5[0];
    
    assign terminal_chain1_out[4] = O_c15_3_terminal_chain1_i2[0];
    assign terminal_chain1_out[5] = O_c15_3_terminal_chain1_i2[1];
    
    assign terminal_chain1_i2           = COUT_LA_terminal_chain1[2];
    assign CY_LA_terminal_chain1[5:4]   = CY_c15_3_terminal_chain1_i2;
    assign PROP_LA_terminal_chain1[5:4] = PROP_c15_3_terminal_chain1_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain1_i3(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain1_i3  ),
        .O   (O_c3_2_terminal_chain1_i3   ),
        .CY  (CY_c3_2_terminal_chain1_i3  ),
        .PROP(PROP_c3_2_terminal_chain1_i3));
    
    assign C0_c3_2_terminal_chain1_i3[2] = terminal_chain1_i2;
    assign C0_c3_2_terminal_chain1_i3[0] = layer5_col6[0];
    assign C0_c3_2_terminal_chain1_i3[1] = layer5_col6[1];
    
    assign terminal_chain1_out[6] = O_c3_2_terminal_chain1_i3[0];
    assign terminal_chain1_out[7] = O_c3_2_terminal_chain1_i3[1];
    
    assign terminal_chain1_i3         = O_c3_2_terminal_chain1_i3[1];
    assign CY_LA_terminal_chain1[6]   = CY_c3_2_terminal_chain1_i3;
    assign PROP_LA_terminal_chain1[6] = PROP_c3_2_terminal_chain1_i3;
    
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
    assign C0_c15_3_terminal_chain2_i2[3] = terminal_chain1_out[5];
    assign C0_c15_3_terminal_chain2_i2[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i2[1] = layer5_col5[1];
    assign C0_c15_3_terminal_chain2_i2[2] = layer5_col5[2];
    assign C1_c15_3_terminal_chain2_i2    = terminal_chain1_out[6];
    
    assign terminal_chain2_out[4] = O_c15_3_terminal_chain2_i2[0];
    assign terminal_chain2_out[5] = O_c15_3_terminal_chain2_i2[1];
    
    assign terminal_chain2_i2           = COUT_LA_terminal_chain2[2];
    assign CY_LA_terminal_chain2[5:4]   = CY_c15_3_terminal_chain2_i2;
    assign PROP_LA_terminal_chain2[5:4] = PROP_c15_3_terminal_chain2_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i3(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i3  ),
        .O   (O_c3_2_terminal_chain2_i3   ),
        .CY  (CY_c3_2_terminal_chain2_i3  ),
        .PROP(PROP_c3_2_terminal_chain2_i3));
    
    assign C0_c3_2_terminal_chain2_i3[2] = terminal_chain2_i2;
    assign C0_c3_2_terminal_chain2_i3[0] = terminal_chain1_out[7];
    assign C0_c3_2_terminal_chain2_i3[1] = layer5_col7;
    
    assign terminal_chain2_out[6] = O_c3_2_terminal_chain2_i3[0];
    assign terminal_chain2_out[7] = O_c3_2_terminal_chain2_i3[1];
    
    assign terminal_chain2_i3         = O_c3_2_terminal_chain2_i3[1];
    assign CY_LA_terminal_chain2[6]   = CY_c3_2_terminal_chain2_i3;
    assign PROP_LA_terminal_chain2[6] = PROP_c3_2_terminal_chain2_i3;
    
    always_ff @(posedge clk) begin
        comp_out[0] <= terminal_chain1_out[0];
    
        comp_out[8:1] <= terminal_chain2_out[7:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = in_col0;
    assign layer0_col1    = in_col1;
    
endmodule