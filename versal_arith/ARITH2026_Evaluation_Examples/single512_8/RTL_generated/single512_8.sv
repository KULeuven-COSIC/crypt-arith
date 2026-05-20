`timescale 1ns / 1ps

module Comp_single512_8 (
    input  logic           clk,
    input  logic [511 : 0] in_col0,
    output logic [9   : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [511 : 0] layer0_col0;
    
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
    
    logic [8 : 0] C0_c9_41_l0_f12;
    logic         CLA_c9_41_l0_f12;
    logic         O0_c9_41_l0_f12;
    logic [3 : 0] O1_c9_41_l0_f12;
    logic [1 : 0] CY_c9_41_l0_f12;
    logic [1 : 0] PROP_c9_41_l0_f12;
    
    logic [8 : 0] C0_c9_41_l0_f13;
    logic         CLA_c9_41_l0_f13;
    logic         O0_c9_41_l0_f13;
    logic [3 : 0] O1_c9_41_l0_f13;
    logic [1 : 0] CY_c9_41_l0_f13;
    logic [1 : 0] PROP_c9_41_l0_f13;
    
    logic [8 : 0] C0_c9_41_l0_f14;
    logic         CLA_c9_41_l0_f14;
    logic         O0_c9_41_l0_f14;
    logic [3 : 0] O1_c9_41_l0_f14;
    logic [1 : 0] CY_c9_41_l0_f14;
    logic [1 : 0] PROP_c9_41_l0_f14;
    
    logic [8 : 0] C0_c9_41_l0_f15;
    logic         CLA_c9_41_l0_f15;
    logic         O0_c9_41_l0_f15;
    logic [3 : 0] O1_c9_41_l0_f15;
    logic [1 : 0] CY_c9_41_l0_f15;
    logic [1 : 0] PROP_c9_41_l0_f15;
    
    logic [8 : 0] C0_c9_41_l0_f16;
    logic         CLA_c9_41_l0_f16;
    logic         O0_c9_41_l0_f16;
    logic [3 : 0] O1_c9_41_l0_f16;
    logic [1 : 0] CY_c9_41_l0_f16;
    logic [1 : 0] PROP_c9_41_l0_f16;
    
    logic [8 : 0] C0_c9_41_l0_f17;
    logic         CLA_c9_41_l0_f17;
    logic         O0_c9_41_l0_f17;
    logic [3 : 0] O1_c9_41_l0_f17;
    logic [1 : 0] CY_c9_41_l0_f17;
    logic [1 : 0] PROP_c9_41_l0_f17;
    
    logic [8 : 0] C0_c9_41_l0_f18;
    logic         CLA_c9_41_l0_f18;
    logic         O0_c9_41_l0_f18;
    logic [3 : 0] O1_c9_41_l0_f18;
    logic [1 : 0] CY_c9_41_l0_f18;
    logic [1 : 0] PROP_c9_41_l0_f18;
    
    logic [8 : 0] C0_c9_41_l0_f19;
    logic         CLA_c9_41_l0_f19;
    logic         O0_c9_41_l0_f19;
    logic [3 : 0] O1_c9_41_l0_f19;
    logic [1 : 0] CY_c9_41_l0_f19;
    logic [1 : 0] PROP_c9_41_l0_f19;
    
    logic [8 : 0] C0_c9_41_l0_f20;
    logic         CLA_c9_41_l0_f20;
    logic         O0_c9_41_l0_f20;
    logic [3 : 0] O1_c9_41_l0_f20;
    logic [1 : 0] CY_c9_41_l0_f20;
    logic [1 : 0] PROP_c9_41_l0_f20;
    
    logic [8 : 0] C0_c9_41_l0_f21;
    logic         CLA_c9_41_l0_f21;
    logic         O0_c9_41_l0_f21;
    logic [3 : 0] O1_c9_41_l0_f21;
    logic [1 : 0] CY_c9_41_l0_f21;
    logic [1 : 0] PROP_c9_41_l0_f21;
    
    logic [8 : 0] C0_c9_41_l0_f22;
    logic         CLA_c9_41_l0_f22;
    logic         O0_c9_41_l0_f22;
    logic [3 : 0] O1_c9_41_l0_f22;
    logic [1 : 0] CY_c9_41_l0_f22;
    logic [1 : 0] PROP_c9_41_l0_f22;
    
    logic [8 : 0] C0_c9_41_l0_f23;
    logic         CLA_c9_41_l0_f23;
    logic         O0_c9_41_l0_f23;
    logic [3 : 0] O1_c9_41_l0_f23;
    logic [1 : 0] CY_c9_41_l0_f23;
    logic [1 : 0] PROP_c9_41_l0_f23;
    
    logic [23 : 0] COUT_LA_l0_floating_placement;
    logic [5  : 0] CIN_LA_l0_floating_placement;
    logic [47 : 0] CY_LA_l0_floating_placement;
    logic [47 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
    logic [319 : 0] layer1_col0;
    logic [95  : 0] layer1_col1;
    
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
    
    logic [8 : 0] C0_c9_41_l1_f3;
    logic         CLA_c9_41_l1_f3;
    logic         O0_c9_41_l1_f3;
    logic [3 : 0] O1_c9_41_l1_f3;
    logic [1 : 0] CY_c9_41_l1_f3;
    logic [1 : 0] PROP_c9_41_l1_f3;
    
    logic [8 : 0] C0_c9_41_l1_f4;
    logic         CLA_c9_41_l1_f4;
    logic         O0_c9_41_l1_f4;
    logic [3 : 0] O1_c9_41_l1_f4;
    logic [1 : 0] CY_c9_41_l1_f4;
    logic [1 : 0] PROP_c9_41_l1_f4;
    
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
    
    logic [16 : 0] C0_c517_451_l1_f8;
    logic [4  : 0] C1_c517_451_l1_f8;
    logic [1  : 0] CLA_c517_451_l1_f8;
    logic          O0_c517_451_l1_f8;
    logic [4  : 0] O1_c517_451_l1_f8;
    logic [3  : 0] O2_c517_451_l1_f8;
    logic [3  : 0] CY0_c517_451_l1_f8;
    logic [3  : 0] PROP0_c517_451_l1_f8;
    logic [3  : 0] CY1_c517_451_l1_f8;
    logic [3  : 0] PROP1_c517_451_l1_f8;
    
    logic [3 : 0] COUT_LA_l1_f8;
    logic         CIN_LA_l1_f8;
    logic [7 : 0] CY_LA_l1_f8;
    logic [7 : 0] PROP_LA_l1_f8;
    
    logic [16 : 0] C0_c517_451_l1_f9;
    logic [4  : 0] C1_c517_451_l1_f9;
    logic [1  : 0] CLA_c517_451_l1_f9;
    logic          O0_c517_451_l1_f9;
    logic [4  : 0] O1_c517_451_l1_f9;
    logic [3  : 0] O2_c517_451_l1_f9;
    logic [3  : 0] CY0_c517_451_l1_f9;
    logic [3  : 0] PROP0_c517_451_l1_f9;
    logic [3  : 0] CY1_c517_451_l1_f9;
    logic [3  : 0] PROP1_c517_451_l1_f9;
    
    logic [3 : 0] COUT_LA_l1_f9;
    logic         CIN_LA_l1_f9;
    logic [7 : 0] CY_LA_l1_f9;
    logic [7 : 0] PROP_LA_l1_f9;
    
    logic [16 : 0] C0_c517_451_l1_f10;
    logic [4  : 0] C1_c517_451_l1_f10;
    logic [1  : 0] CLA_c517_451_l1_f10;
    logic          O0_c517_451_l1_f10;
    logic [4  : 0] O1_c517_451_l1_f10;
    logic [3  : 0] O2_c517_451_l1_f10;
    logic [3  : 0] CY0_c517_451_l1_f10;
    logic [3  : 0] PROP0_c517_451_l1_f10;
    logic [3  : 0] CY1_c517_451_l1_f10;
    logic [3  : 0] PROP1_c517_451_l1_f10;
    
    logic [3 : 0] COUT_LA_l1_f10;
    logic         CIN_LA_l1_f10;
    logic [7 : 0] CY_LA_l1_f10;
    logic [7 : 0] PROP_LA_l1_f10;
    
    logic [16 : 0] C0_c517_451_l1_f11;
    logic [4  : 0] C1_c517_451_l1_f11;
    logic [1  : 0] CLA_c517_451_l1_f11;
    logic          O0_c517_451_l1_f11;
    logic [4  : 0] O1_c517_451_l1_f11;
    logic [3  : 0] O2_c517_451_l1_f11;
    logic [3  : 0] CY0_c517_451_l1_f11;
    logic [3  : 0] PROP0_c517_451_l1_f11;
    logic [3  : 0] CY1_c517_451_l1_f11;
    logic [3  : 0] PROP1_c517_451_l1_f11;
    
    logic [3 : 0] COUT_LA_l1_f11;
    logic         CIN_LA_l1_f11;
    logic [7 : 0] CY_LA_l1_f11;
    logic [7 : 0] PROP_LA_l1_f11;
    
    logic [16 : 0] C0_c517_451_l1_f12;
    logic [4  : 0] C1_c517_451_l1_f12;
    logic [1  : 0] CLA_c517_451_l1_f12;
    logic          O0_c517_451_l1_f12;
    logic [4  : 0] O1_c517_451_l1_f12;
    logic [3  : 0] O2_c517_451_l1_f12;
    logic [3  : 0] CY0_c517_451_l1_f12;
    logic [3  : 0] PROP0_c517_451_l1_f12;
    logic [3  : 0] CY1_c517_451_l1_f12;
    logic [3  : 0] PROP1_c517_451_l1_f12;
    
    logic [3 : 0] COUT_LA_l1_f12;
    logic         CIN_LA_l1_f12;
    logic [7 : 0] CY_LA_l1_f12;
    logic [7 : 0] PROP_LA_l1_f12;
    
    logic [16 : 0] C0_c517_451_l1_f13;
    logic [4  : 0] C1_c517_451_l1_f13;
    logic [1  : 0] CLA_c517_451_l1_f13;
    logic          O0_c517_451_l1_f13;
    logic [4  : 0] O1_c517_451_l1_f13;
    logic [3  : 0] O2_c517_451_l1_f13;
    logic [3  : 0] CY0_c517_451_l1_f13;
    logic [3  : 0] PROP0_c517_451_l1_f13;
    logic [3  : 0] CY1_c517_451_l1_f13;
    logic [3  : 0] PROP1_c517_451_l1_f13;
    
    logic [3 : 0] COUT_LA_l1_f13;
    logic         CIN_LA_l1_f13;
    logic [7 : 0] CY_LA_l1_f13;
    logic [7 : 0] PROP_LA_l1_f13;
    
    logic [16 : 0] C0_c517_451_l1_f14;
    logic [4  : 0] C1_c517_451_l1_f14;
    logic [1  : 0] CLA_c517_451_l1_f14;
    logic          O0_c517_451_l1_f14;
    logic [4  : 0] O1_c517_451_l1_f14;
    logic [3  : 0] O2_c517_451_l1_f14;
    logic [3  : 0] CY0_c517_451_l1_f14;
    logic [3  : 0] PROP0_c517_451_l1_f14;
    logic [3  : 0] CY1_c517_451_l1_f14;
    logic [3  : 0] PROP1_c517_451_l1_f14;
    
    logic [3 : 0] COUT_LA_l1_f14;
    logic         CIN_LA_l1_f14;
    logic [7 : 0] CY_LA_l1_f14;
    logic [7 : 0] PROP_LA_l1_f14;
    
    logic [16 : 0] C0_c517_451_l1_f15;
    logic [4  : 0] C1_c517_451_l1_f15;
    logic [1  : 0] CLA_c517_451_l1_f15;
    logic          O0_c517_451_l1_f15;
    logic [4  : 0] O1_c517_451_l1_f15;
    logic [3  : 0] O2_c517_451_l1_f15;
    logic [3  : 0] CY0_c517_451_l1_f15;
    logic [3  : 0] PROP0_c517_451_l1_f15;
    logic [3  : 0] CY1_c517_451_l1_f15;
    logic [3  : 0] PROP1_c517_451_l1_f15;
    
    logic [3 : 0] COUT_LA_l1_f15;
    logic         CIN_LA_l1_f15;
    logic [7 : 0] CY_LA_l1_f15;
    logic [7 : 0] PROP_LA_l1_f15;
    
    logic [3 : 0] COUT_LA_l1_floating_placement;
    logic         CIN_LA_l1_floating_placement;
    logic [7 : 0] CY_LA_l1_floating_placement;
    logic [7 : 0] PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [127 : 0] layer2_col0;
    logic [63  : 0] layer2_col1;
    logic [63  : 0] layer2_col2;
    
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
    
    logic [8 : 0] C0_c9_41_l2_f4;
    logic         CLA_c9_41_l2_f4;
    logic         O0_c9_41_l2_f4;
    logic [3 : 0] O1_c9_41_l2_f4;
    logic [1 : 0] CY_c9_41_l2_f4;
    logic [1 : 0] PROP_c9_41_l2_f4;
    
    logic [16 : 0] C0_c517_451_l2_f5;
    logic [4  : 0] C1_c517_451_l2_f5;
    logic [1  : 0] CLA_c517_451_l2_f5;
    logic          O0_c517_451_l2_f5;
    logic [4  : 0] O1_c517_451_l2_f5;
    logic [3  : 0] O2_c517_451_l2_f5;
    logic [3  : 0] CY0_c517_451_l2_f5;
    logic [3  : 0] PROP0_c517_451_l2_f5;
    logic [3  : 0] CY1_c517_451_l2_f5;
    logic [3  : 0] PROP1_c517_451_l2_f5;
    
    logic [3 : 0] COUT_LA_l2_f5;
    logic         CIN_LA_l2_f5;
    logic [7 : 0] CY_LA_l2_f5;
    logic [7 : 0] PROP_LA_l2_f5;
    
    logic [16 : 0] C0_c517_451_l2_f6;
    logic [4  : 0] C1_c517_451_l2_f6;
    logic [1  : 0] CLA_c517_451_l2_f6;
    logic          O0_c517_451_l2_f6;
    logic [4  : 0] O1_c517_451_l2_f6;
    logic [3  : 0] O2_c517_451_l2_f6;
    logic [3  : 0] CY0_c517_451_l2_f6;
    logic [3  : 0] PROP0_c517_451_l2_f6;
    logic [3  : 0] CY1_c517_451_l2_f6;
    logic [3  : 0] PROP1_c517_451_l2_f6;
    
    logic [3 : 0] COUT_LA_l2_f6;
    logic         CIN_LA_l2_f6;
    logic [7 : 0] CY_LA_l2_f6;
    logic [7 : 0] PROP_LA_l2_f6;
    
    logic [16 : 0] C0_c517_451_l2_f7;
    logic [4  : 0] C1_c517_451_l2_f7;
    logic [1  : 0] CLA_c517_451_l2_f7;
    logic          O0_c517_451_l2_f7;
    logic [4  : 0] O1_c517_451_l2_f7;
    logic [3  : 0] O2_c517_451_l2_f7;
    logic [3  : 0] CY0_c517_451_l2_f7;
    logic [3  : 0] PROP0_c517_451_l2_f7;
    logic [3  : 0] CY1_c517_451_l2_f7;
    logic [3  : 0] PROP1_c517_451_l2_f7;
    
    logic [3 : 0] COUT_LA_l2_f7;
    logic         CIN_LA_l2_f7;
    logic [7 : 0] CY_LA_l2_f7;
    logic [7 : 0] PROP_LA_l2_f7;
    
    logic [12 : 0] C0_c413_341_l2_f8;
    logic [3  : 0] C1_c413_341_l2_f8;
    logic [1  : 0] CLA_c413_341_l2_f8;
    logic          O0_c413_341_l2_f8;
    logic [3  : 0] O1_c413_341_l2_f8;
    logic [2  : 0] O2_c413_341_l2_f8;
    logic [2  : 0] CY0_c413_341_l2_f8;
    logic [2  : 0] PROP0_c413_341_l2_f8;
    logic [2  : 0] CY1_c413_341_l2_f8;
    logic [2  : 0] PROP1_c413_341_l2_f8;
    
    logic [3 : 0] COUT_LA_l2_f8;
    logic         CIN_LA_l2_f8;
    logic [7 : 0] CY_LA_l2_f8;
    logic [7 : 0] PROP_LA_l2_f8;
    
    logic [8 : 0] C0_c9_41_l2_f9;
    logic         CLA_c9_41_l2_f9;
    logic         O0_c9_41_l2_f9;
    logic [3 : 0] O1_c9_41_l2_f9;
    logic [1 : 0] CY_c9_41_l2_f9;
    logic [1 : 0] PROP_c9_41_l2_f9;
    
    logic [4 : 0] C0_c15_3_l2_f10;
    logic         C1_c15_3_l2_f10;
    logic         CLA_c15_3_l2_f10;
    logic [2 : 0] O_c15_3_l2_f10;
    logic [1 : 0] CY_c15_3_l2_f10;
    logic [1 : 0] PROP_c15_3_l2_f10;
    
    logic [4 : 0] C0_c15_3_l2_f11;
    logic         C1_c15_3_l2_f11;
    logic         CLA_c15_3_l2_f11;
    logic [2 : 0] O_c15_3_l2_f11;
    logic [1 : 0] CY_c15_3_l2_f11;
    logic [1 : 0] PROP_c15_3_l2_f11;
    
    logic [7  : 0] COUT_LA_l2_floating_placement;
    logic [1  : 0] CIN_LA_l2_floating_placement;
    logic [15 : 0] CY_LA_l2_floating_placement;
    logic [15 : 0] PROP_LA_l2_floating_placement;
    
    // ------------------------------ LAYER 3 ------------------------------
    logic [63 : 0] layer3_col0;
    logic [23 : 0] layer3_col1;
    logic [53 : 0] layer3_col2;
    logic [22 : 0] layer3_col3;
    
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
    
    logic [16 : 0] C0_c517_451_l3_f1;
    logic [4  : 0] C1_c517_451_l3_f1;
    logic [1  : 0] CLA_c517_451_l3_f1;
    logic          O0_c517_451_l3_f1;
    logic [4  : 0] O1_c517_451_l3_f1;
    logic [3  : 0] O2_c517_451_l3_f1;
    logic [3  : 0] CY0_c517_451_l3_f1;
    logic [3  : 0] PROP0_c517_451_l3_f1;
    logic [3  : 0] CY1_c517_451_l3_f1;
    logic [3  : 0] PROP1_c517_451_l3_f1;
    
    logic [3 : 0] COUT_LA_l3_f1;
    logic         CIN_LA_l3_f1;
    logic [7 : 0] CY_LA_l3_f1;
    logic [7 : 0] PROP_LA_l3_f1;
    
    logic [16 : 0] C0_c517_451_l3_f2;
    logic [4  : 0] C1_c517_451_l3_f2;
    logic [1  : 0] CLA_c517_451_l3_f2;
    logic          O0_c517_451_l3_f2;
    logic [4  : 0] O1_c517_451_l3_f2;
    logic [3  : 0] O2_c517_451_l3_f2;
    logic [3  : 0] CY0_c517_451_l3_f2;
    logic [3  : 0] PROP0_c517_451_l3_f2;
    logic [3  : 0] CY1_c517_451_l3_f2;
    logic [3  : 0] PROP1_c517_451_l3_f2;
    
    logic [3 : 0] COUT_LA_l3_f2;
    logic         CIN_LA_l3_f2;
    logic [7 : 0] CY_LA_l3_f2;
    logic [7 : 0] PROP_LA_l3_f2;
    
    logic [8 : 0] C0_c9_41_l3_f3;
    logic         CLA_c9_41_l3_f3;
    logic         O0_c9_41_l3_f3;
    logic [3 : 0] O1_c9_41_l3_f3;
    logic [1 : 0] CY_c9_41_l3_f3;
    logic [1 : 0] PROP_c9_41_l3_f3;
    
    logic [8 : 0] C0_c9_41_l3_f4;
    logic         CLA_c9_41_l3_f4;
    logic         O0_c9_41_l3_f4;
    logic [3 : 0] O1_c9_41_l3_f4;
    logic [1 : 0] CY_c9_41_l3_f4;
    logic [1 : 0] PROP_c9_41_l3_f4;
    
    logic [4 : 0] C0_c15_3_l3_f5;
    logic         C1_c15_3_l3_f5;
    logic         CLA_c15_3_l3_f5;
    logic [2 : 0] O_c15_3_l3_f5;
    logic [1 : 0] CY_c15_3_l3_f5;
    logic [1 : 0] PROP_c15_3_l3_f5;
    
    logic [16 : 0] C0_c517_451_l3_f6;
    logic [4  : 0] C1_c517_451_l3_f6;
    logic [1  : 0] CLA_c517_451_l3_f6;
    logic          O0_c517_451_l3_f6;
    logic [4  : 0] O1_c517_451_l3_f6;
    logic [3  : 0] O2_c517_451_l3_f6;
    logic [3  : 0] CY0_c517_451_l3_f6;
    logic [3  : 0] PROP0_c517_451_l3_f6;
    logic [3  : 0] CY1_c517_451_l3_f6;
    logic [3  : 0] PROP1_c517_451_l3_f6;
    
    logic [3 : 0] COUT_LA_l3_f6;
    logic         CIN_LA_l3_f6;
    logic [7 : 0] CY_LA_l3_f6;
    logic [7 : 0] PROP_LA_l3_f6;
    
    logic [4 : 0] C0_c15_3_l3_f7;
    logic         C1_c15_3_l3_f7;
    logic         CLA_c15_3_l3_f7;
    logic [2 : 0] O_c15_3_l3_f7;
    logic [1 : 0] CY_c15_3_l3_f7;
    logic [1 : 0] PROP_c15_3_l3_f7;
    
    logic [12 : 0] C0_c413_341_l3_f8;
    logic [3  : 0] C1_c413_341_l3_f8;
    logic [1  : 0] CLA_c413_341_l3_f8;
    logic          O0_c413_341_l3_f8;
    logic [3  : 0] O1_c413_341_l3_f8;
    logic [2  : 0] O2_c413_341_l3_f8;
    logic [2  : 0] CY0_c413_341_l3_f8;
    logic [2  : 0] PROP0_c413_341_l3_f8;
    logic [2  : 0] CY1_c413_341_l3_f8;
    logic [2  : 0] PROP1_c413_341_l3_f8;
    
    logic [3 : 0] COUT_LA_l3_f8;
    logic         CIN_LA_l3_f8;
    logic [7 : 0] CY_LA_l3_f8;
    logic [7 : 0] PROP_LA_l3_f8;
    
    logic [3 : 0] COUT_LA_l3_floating_placement;
    logic         CIN_LA_l3_floating_placement;
    logic [7 : 0] CY_LA_l3_floating_placement;
    logic [7 : 0] PROP_LA_l3_floating_placement;
    
    // ------------------------------ LAYER 4 ------------------------------
    logic [31 : 0] layer4_col0;
    logic [11 : 0] layer4_col1;
    logic [15 : 0] layer4_col2;
    logic [18 : 0] layer4_col3;
    logic [14 : 0] layer4_col4;
    
    logic [16 : 0] C0_c517_451_l4_f0;
    logic [4  : 0] C1_c517_451_l4_f0;
    logic [1  : 0] CLA_c517_451_l4_f0;
    logic          O0_c517_451_l4_f0;
    logic [4  : 0] O1_c517_451_l4_f0;
    logic [3  : 0] O2_c517_451_l4_f0;
    logic [3  : 0] CY0_c517_451_l4_f0;
    logic [3  : 0] PROP0_c517_451_l4_f0;
    logic [3  : 0] CY1_c517_451_l4_f0;
    logic [3  : 0] PROP1_c517_451_l4_f0;
    
    logic [3 : 0] COUT_LA_l4_f0;
    logic         CIN_LA_l4_f0;
    logic [7 : 0] CY_LA_l4_f0;
    logic [7 : 0] PROP_LA_l4_f0;
    
    logic [4 : 0] C0_c15_3_l4_f1;
    logic         C1_c15_3_l4_f1;
    logic         CLA_c15_3_l4_f1;
    logic [2 : 0] O_c15_3_l4_f1;
    logic [1 : 0] CY_c15_3_l4_f1;
    logic [1 : 0] PROP_c15_3_l4_f1;
    
    logic [16 : 0] C0_c517_451_l4_f2;
    logic [4  : 0] C1_c517_451_l4_f2;
    logic [1  : 0] CLA_c517_451_l4_f2;
    logic          O0_c517_451_l4_f2;
    logic [4  : 0] O1_c517_451_l4_f2;
    logic [3  : 0] O2_c517_451_l4_f2;
    logic [3  : 0] CY0_c517_451_l4_f2;
    logic [3  : 0] PROP0_c517_451_l4_f2;
    logic [3  : 0] CY1_c517_451_l4_f2;
    logic [3  : 0] PROP1_c517_451_l4_f2;
    
    logic [3 : 0] COUT_LA_l4_f2;
    logic         CIN_LA_l4_f2;
    logic [7 : 0] CY_LA_l4_f2;
    logic [7 : 0] PROP_LA_l4_f2;
    
    logic [8 : 0] C0_c9_41_l4_f3;
    logic         CLA_c9_41_l4_f3;
    logic         O0_c9_41_l4_f3;
    logic [3 : 0] O1_c9_41_l4_f3;
    logic [1 : 0] CY_c9_41_l4_f3;
    logic [1 : 0] PROP_c9_41_l4_f3;
    
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
    
    logic [8 : 0] C0_c9_41_l4_c0_i1;
    logic         CLA_c9_41_l4_c0_i1;
    logic         O0_c9_41_l4_c0_i1;
    logic [3 : 0] O1_c9_41_l4_c0_i1;
    logic [1 : 0] CY_c9_41_l4_c0_i1;
    logic [1 : 0] PROP_c9_41_l4_c0_i1;
    logic         l4_c0_i1;
    
    logic [4 : 0] C0_c15_3_l4_f4;
    logic         C1_c15_3_l4_f4;
    logic         CLA_c15_3_l4_f4;
    logic [2 : 0] O_c15_3_l4_f4;
    logic [1 : 0] CY_c15_3_l4_f4;
    logic [1 : 0] PROP_c15_3_l4_f4;
    
    logic [4 : 0] C0_c15_3_l4_f5;
    logic         C1_c15_3_l4_f5;
    logic         CLA_c15_3_l4_f5;
    logic [2 : 0] O_c15_3_l4_f5;
    logic [1 : 0] CY_c15_3_l4_f5;
    logic [1 : 0] PROP_c15_3_l4_f5;
    
    logic [3 : 0] COUT_LA_l4_floating_placement;
    logic         CIN_LA_l4_floating_placement;
    logic [7 : 0] CY_LA_l4_floating_placement;
    logic [7 : 0] PROP_LA_l4_floating_placement;
    
    // ------------------------------ LAYER 5 ------------------------------
    logic [7  : 0] layer5_col0;
    logic [7  : 0] layer5_col1;
    logic [9  : 0] layer5_col2;
    logic [7  : 0] layer5_col3;
    logic [7  : 0] layer5_col4;
    logic [7  : 0] layer5_col5;
    
    logic [3 : 0] COUT_LA_l5_c0_s0;
    logic         CIN_LA_l5_c0_s0;
    logic [7 : 0] CY_LA_l5_c0_s0;
    logic [7 : 0] PROP_LA_l5_c0_s0;
    
    logic [4 : 0] C0_c15_3_l5_c0_i0;
    logic         C1_c15_3_l5_c0_i0;
    logic         CLA_c15_3_l5_c0_i0;
    logic [2 : 0] O_c15_3_l5_c0_i0;
    logic [1 : 0] CY_c15_3_l5_c0_i0;
    logic [1 : 0] PROP_c15_3_l5_c0_i0;
    logic         l5_c0_i0;
    
    logic [4 : 0] C0_c15_3_l5_c0_i1;
    logic         C1_c15_3_l5_c0_i1;
    logic         CLA_c15_3_l5_c0_i1;
    logic [2 : 0] O_c15_3_l5_c0_i1;
    logic [1 : 0] CY_c15_3_l5_c0_i1;
    logic [1 : 0] PROP_c15_3_l5_c0_i1;
    logic         l5_c0_i1;
    
    logic [4 : 0] C0_c15_3_l5_c0_i2;
    logic         C1_c15_3_l5_c0_i2;
    logic         CLA_c15_3_l5_c0_i2;
    logic [2 : 0] O_c15_3_l5_c0_i2;
    logic [1 : 0] CY_c15_3_l5_c0_i2;
    logic [1 : 0] PROP_c15_3_l5_c0_i2;
    logic         l5_c0_i2;
    
    logic [3 : 0] COUT_LA_l5_c1_s0;
    logic         CIN_LA_l5_c1_s0;
    logic [7 : 0] CY_LA_l5_c1_s0;
    logic [7 : 0] PROP_LA_l5_c1_s0;
    
    logic [4 : 0] C0_c15_3_l5_c1_i0;
    logic         C1_c15_3_l5_c1_i0;
    logic         CLA_c15_3_l5_c1_i0;
    logic [2 : 0] O_c15_3_l5_c1_i0;
    logic [1 : 0] CY_c15_3_l5_c1_i0;
    logic [1 : 0] PROP_c15_3_l5_c1_i0;
    logic         l5_c1_i0;
    
    logic [4 : 0] C0_c15_3_l5_c1_i1;
    logic         C1_c15_3_l5_c1_i1;
    logic         CLA_c15_3_l5_c1_i1;
    logic [2 : 0] O_c15_3_l5_c1_i1;
    logic [1 : 0] CY_c15_3_l5_c1_i1;
    logic [1 : 0] PROP_c15_3_l5_c1_i1;
    logic         l5_c1_i1;
    
    logic [5 : 0] C0_c6_3_l5_f0;
    logic [2 : 0] O_c6_3_l5_f0;
    
    logic [3 : 0] COUT_LA_l5_c2_s0;
    logic         CIN_LA_l5_c2_s0;
    logic [7 : 0] CY_LA_l5_c2_s0;
    logic [7 : 0] PROP_LA_l5_c2_s0;
    
    logic [4 : 0] C0_c15_3_l5_c2_i0;
    logic         C1_c15_3_l5_c2_i0;
    logic         CLA_c15_3_l5_c2_i0;
    logic [2 : 0] O_c15_3_l5_c2_i0;
    logic [1 : 0] CY_c15_3_l5_c2_i0;
    logic [1 : 0] PROP_c15_3_l5_c2_i0;
    logic         l5_c2_i0;
    
    logic [2 : 0] C0_c3_2_l5_c2_i1;
    logic [1 : 0] O_c3_2_l5_c2_i1;
    logic         CY_c3_2_l5_c2_i1;
    logic         PROP_c3_2_l5_c2_i1;
    logic         l5_c2_i1;
    
    logic    COUT_LA_l5_floating_placement;
    logic    CIN_LA_l5_floating_placement;
    logic    CY_LA_l5_floating_placement;
    logic    PROP_LA_l5_floating_placement;
    
    // ------------------------------ LAYER 6 ------------------------------
    logic [3  : 0] layer6_col0;
    logic [3  : 0] layer6_col1;
    logic [2  : 0] layer6_col2;
    logic [4  : 0] layer6_col3;
    logic [3  : 0] layer6_col4;
    logic [4  : 0] layer6_col5;
    logic [1  : 0] layer6_col6;
    logic          layer6_col7;
    
    logic [2 : 0] C0_c223_4_l6_f0;
    logic [1 : 0] C1_c223_4_l6_f0;
    logic [1 : 0] C2_c223_4_l6_f0;
    logic         CLA_c223_4_l6_f0;
    logic [3 : 0] O_c223_4_l6_f0;
    logic [1 : 0] CY_c223_4_l6_f0;
    logic [1 : 0] PROP_c223_4_l6_f0;
    
    logic [3 : 0] COUT_LA_l6_floating_placement;
    logic         CIN_LA_l6_floating_placement;
    logic [7 : 0] CY_LA_l6_floating_placement;
    logic [7 : 0] PROP_LA_l6_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [3  : 0] layer7_col0;
    logic [3  : 0] layer7_col1;
    logic [2  : 0] layer7_col2;
    logic [2  : 0] layer7_col3;
    logic [2  : 0] layer7_col4;
    logic [3  : 0] layer7_col5;
    logic [2  : 0] layer7_col6;
    logic          layer7_col7;
    
    logic [8 : 0] terminal_chain1_out;
    
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
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i3;
    logic         C1_c15_3_terminal_chain1_i3;
    logic         CLA_c15_3_terminal_chain1_i3;
    logic [2 : 0] O_c15_3_terminal_chain1_i3;
    logic [1 : 0] CY_c15_3_terminal_chain1_i3;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i3;
    logic         terminal_chain1_i3;
    
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    // GPC12 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f12(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f12  ),
        .CLA (CLA_c9_41_l0_f12 ),
        .O0  (O0_c9_41_l0_f12  ),
        .O1  (O1_c9_41_l0_f12  ),
        .CY  (CY_c9_41_l0_f12  ),
        .PROP(PROP_c9_41_l0_f12));
    
    assign C0_c9_41_l0_f12 = layer0_col0[116:108];
    
    assign layer1_col0[12]    = O0_c9_41_l0_f12;
    assign layer1_col1[51:48] = O1_c9_41_l0_f12;
    
    // GPC13 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f13(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f13  ),
        .CLA (CLA_c9_41_l0_f13 ),
        .O0  (O0_c9_41_l0_f13  ),
        .O1  (O1_c9_41_l0_f13  ),
        .CY  (CY_c9_41_l0_f13  ),
        .PROP(PROP_c9_41_l0_f13));
    
    assign C0_c9_41_l0_f13 = layer0_col0[125:117];
    
    assign layer1_col0[13]    = O0_c9_41_l0_f13;
    assign layer1_col1[55:52] = O1_c9_41_l0_f13;
    
    // GPC14 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f14(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f14  ),
        .CLA (CLA_c9_41_l0_f14 ),
        .O0  (O0_c9_41_l0_f14  ),
        .O1  (O1_c9_41_l0_f14  ),
        .CY  (CY_c9_41_l0_f14  ),
        .PROP(PROP_c9_41_l0_f14));
    
    assign C0_c9_41_l0_f14 = layer0_col0[134:126];
    
    assign layer1_col0[14]    = O0_c9_41_l0_f14;
    assign layer1_col1[59:56] = O1_c9_41_l0_f14;
    
    // GPC15 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f15(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f15  ),
        .CLA (CLA_c9_41_l0_f15 ),
        .O0  (O0_c9_41_l0_f15  ),
        .O1  (O1_c9_41_l0_f15  ),
        .CY  (CY_c9_41_l0_f15  ),
        .PROP(PROP_c9_41_l0_f15));
    
    assign C0_c9_41_l0_f15 = layer0_col0[143:135];
    
    assign layer1_col0[15]    = O0_c9_41_l0_f15;
    assign layer1_col1[63:60] = O1_c9_41_l0_f15;
    
    // GPC16 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f16(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f16  ),
        .CLA (CLA_c9_41_l0_f16 ),
        .O0  (O0_c9_41_l0_f16  ),
        .O1  (O1_c9_41_l0_f16  ),
        .CY  (CY_c9_41_l0_f16  ),
        .PROP(PROP_c9_41_l0_f16));
    
    assign C0_c9_41_l0_f16 = layer0_col0[152:144];
    
    assign layer1_col0[16]    = O0_c9_41_l0_f16;
    assign layer1_col1[67:64] = O1_c9_41_l0_f16;
    
    // GPC17 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f17(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f17  ),
        .CLA (CLA_c9_41_l0_f17 ),
        .O0  (O0_c9_41_l0_f17  ),
        .O1  (O1_c9_41_l0_f17  ),
        .CY  (CY_c9_41_l0_f17  ),
        .PROP(PROP_c9_41_l0_f17));
    
    assign C0_c9_41_l0_f17 = layer0_col0[161:153];
    
    assign layer1_col0[17]    = O0_c9_41_l0_f17;
    assign layer1_col1[71:68] = O1_c9_41_l0_f17;
    
    // GPC18 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f18(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f18  ),
        .CLA (CLA_c9_41_l0_f18 ),
        .O0  (O0_c9_41_l0_f18  ),
        .O1  (O1_c9_41_l0_f18  ),
        .CY  (CY_c9_41_l0_f18  ),
        .PROP(PROP_c9_41_l0_f18));
    
    assign C0_c9_41_l0_f18 = layer0_col0[170:162];
    
    assign layer1_col0[18]    = O0_c9_41_l0_f18;
    assign layer1_col1[75:72] = O1_c9_41_l0_f18;
    
    // GPC19 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f19(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f19  ),
        .CLA (CLA_c9_41_l0_f19 ),
        .O0  (O0_c9_41_l0_f19  ),
        .O1  (O1_c9_41_l0_f19  ),
        .CY  (CY_c9_41_l0_f19  ),
        .PROP(PROP_c9_41_l0_f19));
    
    assign C0_c9_41_l0_f19 = layer0_col0[179:171];
    
    assign layer1_col0[19]    = O0_c9_41_l0_f19;
    assign layer1_col1[79:76] = O1_c9_41_l0_f19;
    
    // GPC20 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f20(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f20  ),
        .CLA (CLA_c9_41_l0_f20 ),
        .O0  (O0_c9_41_l0_f20  ),
        .O1  (O1_c9_41_l0_f20  ),
        .CY  (CY_c9_41_l0_f20  ),
        .PROP(PROP_c9_41_l0_f20));
    
    assign C0_c9_41_l0_f20 = layer0_col0[188:180];
    
    assign layer1_col0[20]    = O0_c9_41_l0_f20;
    assign layer1_col1[83:80] = O1_c9_41_l0_f20;
    
    // GPC21 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f21(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f21  ),
        .CLA (CLA_c9_41_l0_f21 ),
        .O0  (O0_c9_41_l0_f21  ),
        .O1  (O1_c9_41_l0_f21  ),
        .CY  (CY_c9_41_l0_f21  ),
        .PROP(PROP_c9_41_l0_f21));
    
    assign C0_c9_41_l0_f21 = layer0_col0[197:189];
    
    assign layer1_col0[21]    = O0_c9_41_l0_f21;
    assign layer1_col1[87:84] = O1_c9_41_l0_f21;
    
    // GPC22 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f22(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f22  ),
        .CLA (CLA_c9_41_l0_f22 ),
        .O0  (O0_c9_41_l0_f22  ),
        .O1  (O1_c9_41_l0_f22  ),
        .CY  (CY_c9_41_l0_f22  ),
        .PROP(PROP_c9_41_l0_f22));
    
    assign C0_c9_41_l0_f22 = layer0_col0[206:198];
    
    assign layer1_col0[22]    = O0_c9_41_l0_f22;
    assign layer1_col1[91:88] = O1_c9_41_l0_f22;
    
    // GPC23 in layer0: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f23(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f23  ),
        .CLA (CLA_c9_41_l0_f23 ),
        .O0  (O0_c9_41_l0_f23  ),
        .O1  (O1_c9_41_l0_f23  ),
        .CY  (CY_c9_41_l0_f23  ),
        .PROP(PROP_c9_41_l0_f23));
    
    assign C0_c9_41_l0_f23 = layer0_col0[215:207];
    
    assign layer1_col0[23]    = O0_c9_41_l0_f23;
    assign layer1_col1[95:92] = O1_c9_41_l0_f23;
    
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

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_floating_placement_inst3 (
        .COUTB(COUT_LA_l0_floating_placement[12]),
        .COUTD(COUT_LA_l0_floating_placement[13]),
        .COUTF(COUT_LA_l0_floating_placement[14]),
        .COUTH(COUT_LA_l0_floating_placement[15]),
        .CIN  (CIN_LA_l0_floating_placement[3]  ),
        .CYA  (CY_LA_l0_floating_placement[24]  ),
        .CYB  (CY_LA_l0_floating_placement[25]  ),
        .CYC  (CY_LA_l0_floating_placement[26]  ),
        .CYD  (CY_LA_l0_floating_placement[27]  ),
        .CYE  (CY_LA_l0_floating_placement[28]  ),
        .CYF  (CY_LA_l0_floating_placement[29]  ),
        .CYG  (CY_LA_l0_floating_placement[30]  ),
        .CYH  (CY_LA_l0_floating_placement[31]  ),
        .PROPA(PROP_LA_l0_floating_placement[24]),
        .PROPB(PROP_LA_l0_floating_placement[25]),
        .PROPC(PROP_LA_l0_floating_placement[26]),
        .PROPD(PROP_LA_l0_floating_placement[27]),
        .PROPE(PROP_LA_l0_floating_placement[28]),
        .PROPF(PROP_LA_l0_floating_placement[29]),
        .PROPG(PROP_LA_l0_floating_placement[30]),
        .PROPH(PROP_LA_l0_floating_placement[31]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_floating_placement_inst4 (
        .COUTB(COUT_LA_l0_floating_placement[16]),
        .COUTD(COUT_LA_l0_floating_placement[17]),
        .COUTF(COUT_LA_l0_floating_placement[18]),
        .COUTH(COUT_LA_l0_floating_placement[19]),
        .CIN  (CIN_LA_l0_floating_placement[4]  ),
        .CYA  (CY_LA_l0_floating_placement[32]  ),
        .CYB  (CY_LA_l0_floating_placement[33]  ),
        .CYC  (CY_LA_l0_floating_placement[34]  ),
        .CYD  (CY_LA_l0_floating_placement[35]  ),
        .CYE  (CY_LA_l0_floating_placement[36]  ),
        .CYF  (CY_LA_l0_floating_placement[37]  ),
        .CYG  (CY_LA_l0_floating_placement[38]  ),
        .CYH  (CY_LA_l0_floating_placement[39]  ),
        .PROPA(PROP_LA_l0_floating_placement[32]),
        .PROPB(PROP_LA_l0_floating_placement[33]),
        .PROPC(PROP_LA_l0_floating_placement[34]),
        .PROPD(PROP_LA_l0_floating_placement[35]),
        .PROPE(PROP_LA_l0_floating_placement[36]),
        .PROPF(PROP_LA_l0_floating_placement[37]),
        .PROPG(PROP_LA_l0_floating_placement[38]),
        .PROPH(PROP_LA_l0_floating_placement[39]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_floating_placement_inst5 (
        .COUTB(COUT_LA_l0_floating_placement[20]),
        .COUTD(COUT_LA_l0_floating_placement[21]),
        .COUTF(COUT_LA_l0_floating_placement[22]),
        .COUTH(COUT_LA_l0_floating_placement[23]),
        .CIN  (CIN_LA_l0_floating_placement[5]  ),
        .CYA  (CY_LA_l0_floating_placement[40]  ),
        .CYB  (CY_LA_l0_floating_placement[41]  ),
        .CYC  (CY_LA_l0_floating_placement[42]  ),
        .CYD  (CY_LA_l0_floating_placement[43]  ),
        .CYE  (CY_LA_l0_floating_placement[44]  ),
        .CYF  (CY_LA_l0_floating_placement[45]  ),
        .CYG  (CY_LA_l0_floating_placement[46]  ),
        .CYH  (CY_LA_l0_floating_placement[47]  ),
        .PROPA(PROP_LA_l0_floating_placement[40]),
        .PROPB(PROP_LA_l0_floating_placement[41]),
        .PROPC(PROP_LA_l0_floating_placement[42]),
        .PROPD(PROP_LA_l0_floating_placement[43]),
        .PROPE(PROP_LA_l0_floating_placement[44]),
        .PROPF(PROP_LA_l0_floating_placement[45]),
        .PROPG(PROP_LA_l0_floating_placement[46]),
        .PROPH(PROP_LA_l0_floating_placement[47]));

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
    
    assign CY_LA_l0_floating_placement[25:24]   = CY_c9_41_l0_f12;
    assign PROP_LA_l0_floating_placement[25:24] = PROP_c9_41_l0_f12;
    assign CIN_LA_l0_floating_placement[3] = C0_c9_41_l0_f12[8];
    
    assign CY_LA_l0_floating_placement[27:26]   = CY_c9_41_l0_f13;
    assign PROP_LA_l0_floating_placement[27:26] = PROP_c9_41_l0_f13;
    
    assign CY_LA_l0_floating_placement[29:28]   = CY_c9_41_l0_f14;
    assign PROP_LA_l0_floating_placement[29:28] = PROP_c9_41_l0_f14;
    
    assign CY_LA_l0_floating_placement[31:30]   = CY_c9_41_l0_f15;
    assign PROP_LA_l0_floating_placement[31:30] = PROP_c9_41_l0_f15;
    
    assign CY_LA_l0_floating_placement[33:32]   = CY_c9_41_l0_f16;
    assign PROP_LA_l0_floating_placement[33:32] = PROP_c9_41_l0_f16;
    assign CIN_LA_l0_floating_placement[4] = C0_c9_41_l0_f16[8];
    
    assign CY_LA_l0_floating_placement[35:34]   = CY_c9_41_l0_f17;
    assign PROP_LA_l0_floating_placement[35:34] = PROP_c9_41_l0_f17;
    
    assign CY_LA_l0_floating_placement[37:36]   = CY_c9_41_l0_f18;
    assign PROP_LA_l0_floating_placement[37:36] = PROP_c9_41_l0_f18;
    
    assign CY_LA_l0_floating_placement[39:38]   = CY_c9_41_l0_f19;
    assign PROP_LA_l0_floating_placement[39:38] = PROP_c9_41_l0_f19;
    
    assign CY_LA_l0_floating_placement[41:40]   = CY_c9_41_l0_f20;
    assign PROP_LA_l0_floating_placement[41:40] = PROP_c9_41_l0_f20;
    assign CIN_LA_l0_floating_placement[5] = C0_c9_41_l0_f20[8];
    
    assign CY_LA_l0_floating_placement[43:42]   = CY_c9_41_l0_f21;
    assign PROP_LA_l0_floating_placement[43:42] = PROP_c9_41_l0_f21;
    
    assign CY_LA_l0_floating_placement[45:44]   = CY_c9_41_l0_f22;
    assign PROP_LA_l0_floating_placement[45:44] = PROP_c9_41_l0_f22;
    
    assign CY_LA_l0_floating_placement[47:46]   = CY_c9_41_l0_f23;
    assign PROP_LA_l0_floating_placement[47:46] = PROP_c9_41_l0_f23;
    
    always_ff @(posedge clk) begin
        layer1_col0[24] <= layer0_col0[216];
        layer1_col0[25] <= layer0_col0[217];
        layer1_col0[26] <= layer0_col0[218];
        layer1_col0[27] <= layer0_col0[219];
        layer1_col0[28] <= layer0_col0[220];
        layer1_col0[29] <= layer0_col0[221];
        layer1_col0[30] <= layer0_col0[222];
        layer1_col0[31] <= layer0_col0[223];
        layer1_col0[32] <= layer0_col0[224];
        layer1_col0[33] <= layer0_col0[225];
        layer1_col0[34] <= layer0_col0[226];
        layer1_col0[35] <= layer0_col0[227];
        layer1_col0[36] <= layer0_col0[228];
        layer1_col0[37] <= layer0_col0[229];
        layer1_col0[38] <= layer0_col0[230];
        layer1_col0[39] <= layer0_col0[231];
        layer1_col0[40] <= layer0_col0[232];
        layer1_col0[41] <= layer0_col0[233];
        layer1_col0[42] <= layer0_col0[234];
        layer1_col0[43] <= layer0_col0[235];
        layer1_col0[44] <= layer0_col0[236];
        layer1_col0[45] <= layer0_col0[237];
        layer1_col0[46] <= layer0_col0[238];
        layer1_col0[47] <= layer0_col0[239];
        layer1_col0[48] <= layer0_col0[240];
        layer1_col0[49] <= layer0_col0[241];
        layer1_col0[50] <= layer0_col0[242];
        layer1_col0[51] <= layer0_col0[243];
        layer1_col0[52] <= layer0_col0[244];
        layer1_col0[53] <= layer0_col0[245];
        layer1_col0[54] <= layer0_col0[246];
        layer1_col0[55] <= layer0_col0[247];
        layer1_col0[56] <= layer0_col0[248];
        layer1_col0[57] <= layer0_col0[249];
        layer1_col0[58] <= layer0_col0[250];
        layer1_col0[59] <= layer0_col0[251];
        layer1_col0[60] <= layer0_col0[252];
        layer1_col0[61] <= layer0_col0[253];
        layer1_col0[62] <= layer0_col0[254];
        layer1_col0[63] <= layer0_col0[255];
        layer1_col0[64] <= layer0_col0[256];
        layer1_col0[65] <= layer0_col0[257];
        layer1_col0[66] <= layer0_col0[258];
        layer1_col0[67] <= layer0_col0[259];
        layer1_col0[68] <= layer0_col0[260];
        layer1_col0[69] <= layer0_col0[261];
        layer1_col0[70] <= layer0_col0[262];
        layer1_col0[71] <= layer0_col0[263];
        layer1_col0[72] <= layer0_col0[264];
        layer1_col0[73] <= layer0_col0[265];
        layer1_col0[74] <= layer0_col0[266];
        layer1_col0[75] <= layer0_col0[267];
        layer1_col0[76] <= layer0_col0[268];
        layer1_col0[77] <= layer0_col0[269];
        layer1_col0[78] <= layer0_col0[270];
        layer1_col0[79] <= layer0_col0[271];
        layer1_col0[80] <= layer0_col0[272];
        layer1_col0[81] <= layer0_col0[273];
        layer1_col0[82] <= layer0_col0[274];
        layer1_col0[83] <= layer0_col0[275];
        layer1_col0[84] <= layer0_col0[276];
        layer1_col0[85] <= layer0_col0[277];
        layer1_col0[86] <= layer0_col0[278];
        layer1_col0[87] <= layer0_col0[279];
        layer1_col0[88] <= layer0_col0[280];
        layer1_col0[89] <= layer0_col0[281];
        layer1_col0[90] <= layer0_col0[282];
        layer1_col0[91] <= layer0_col0[283];
        layer1_col0[92] <= layer0_col0[284];
        layer1_col0[93] <= layer0_col0[285];
        layer1_col0[94] <= layer0_col0[286];
        layer1_col0[95] <= layer0_col0[287];
        layer1_col0[96] <= layer0_col0[288];
        layer1_col0[97] <= layer0_col0[289];
        layer1_col0[98] <= layer0_col0[290];
        layer1_col0[99] <= layer0_col0[291];
        layer1_col0[100] <= layer0_col0[292];
        layer1_col0[101] <= layer0_col0[293];
        layer1_col0[102] <= layer0_col0[294];
        layer1_col0[103] <= layer0_col0[295];
        layer1_col0[104] <= layer0_col0[296];
        layer1_col0[105] <= layer0_col0[297];
        layer1_col0[106] <= layer0_col0[298];
        layer1_col0[107] <= layer0_col0[299];
        layer1_col0[108] <= layer0_col0[300];
        layer1_col0[109] <= layer0_col0[301];
        layer1_col0[110] <= layer0_col0[302];
        layer1_col0[111] <= layer0_col0[303];
        layer1_col0[112] <= layer0_col0[304];
        layer1_col0[113] <= layer0_col0[305];
        layer1_col0[114] <= layer0_col0[306];
        layer1_col0[115] <= layer0_col0[307];
        layer1_col0[116] <= layer0_col0[308];
        layer1_col0[117] <= layer0_col0[309];
        layer1_col0[118] <= layer0_col0[310];
        layer1_col0[119] <= layer0_col0[311];
        layer1_col0[120] <= layer0_col0[312];
        layer1_col0[121] <= layer0_col0[313];
        layer1_col0[122] <= layer0_col0[314];
        layer1_col0[123] <= layer0_col0[315];
        layer1_col0[124] <= layer0_col0[316];
        layer1_col0[125] <= layer0_col0[317];
        layer1_col0[126] <= layer0_col0[318];
        layer1_col0[127] <= layer0_col0[319];
        layer1_col0[128] <= layer0_col0[320];
        layer1_col0[129] <= layer0_col0[321];
        layer1_col0[130] <= layer0_col0[322];
        layer1_col0[131] <= layer0_col0[323];
        layer1_col0[132] <= layer0_col0[324];
        layer1_col0[133] <= layer0_col0[325];
        layer1_col0[134] <= layer0_col0[326];
        layer1_col0[135] <= layer0_col0[327];
        layer1_col0[136] <= layer0_col0[328];
        layer1_col0[137] <= layer0_col0[329];
        layer1_col0[138] <= layer0_col0[330];
        layer1_col0[139] <= layer0_col0[331];
        layer1_col0[140] <= layer0_col0[332];
        layer1_col0[141] <= layer0_col0[333];
        layer1_col0[142] <= layer0_col0[334];
        layer1_col0[143] <= layer0_col0[335];
        layer1_col0[144] <= layer0_col0[336];
        layer1_col0[145] <= layer0_col0[337];
        layer1_col0[146] <= layer0_col0[338];
        layer1_col0[147] <= layer0_col0[339];
        layer1_col0[148] <= layer0_col0[340];
        layer1_col0[149] <= layer0_col0[341];
        layer1_col0[150] <= layer0_col0[342];
        layer1_col0[151] <= layer0_col0[343];
        layer1_col0[152] <= layer0_col0[344];
        layer1_col0[153] <= layer0_col0[345];
        layer1_col0[154] <= layer0_col0[346];
        layer1_col0[155] <= layer0_col0[347];
        layer1_col0[156] <= layer0_col0[348];
        layer1_col0[157] <= layer0_col0[349];
        layer1_col0[158] <= layer0_col0[350];
        layer1_col0[159] <= layer0_col0[351];
        layer1_col0[160] <= layer0_col0[352];
        layer1_col0[161] <= layer0_col0[353];
        layer1_col0[162] <= layer0_col0[354];
        layer1_col0[163] <= layer0_col0[355];
        layer1_col0[164] <= layer0_col0[356];
        layer1_col0[165] <= layer0_col0[357];
        layer1_col0[166] <= layer0_col0[358];
        layer1_col0[167] <= layer0_col0[359];
        layer1_col0[168] <= layer0_col0[360];
        layer1_col0[169] <= layer0_col0[361];
        layer1_col0[170] <= layer0_col0[362];
        layer1_col0[171] <= layer0_col0[363];
        layer1_col0[172] <= layer0_col0[364];
        layer1_col0[173] <= layer0_col0[365];
        layer1_col0[174] <= layer0_col0[366];
        layer1_col0[175] <= layer0_col0[367];
        layer1_col0[176] <= layer0_col0[368];
        layer1_col0[177] <= layer0_col0[369];
        layer1_col0[178] <= layer0_col0[370];
        layer1_col0[179] <= layer0_col0[371];
        layer1_col0[180] <= layer0_col0[372];
        layer1_col0[181] <= layer0_col0[373];
        layer1_col0[182] <= layer0_col0[374];
        layer1_col0[183] <= layer0_col0[375];
        layer1_col0[184] <= layer0_col0[376];
        layer1_col0[185] <= layer0_col0[377];
        layer1_col0[186] <= layer0_col0[378];
        layer1_col0[187] <= layer0_col0[379];
        layer1_col0[188] <= layer0_col0[380];
        layer1_col0[189] <= layer0_col0[381];
        layer1_col0[190] <= layer0_col0[382];
        layer1_col0[191] <= layer0_col0[383];
        layer1_col0[192] <= layer0_col0[384];
        layer1_col0[193] <= layer0_col0[385];
        layer1_col0[194] <= layer0_col0[386];
        layer1_col0[195] <= layer0_col0[387];
        layer1_col0[196] <= layer0_col0[388];
        layer1_col0[197] <= layer0_col0[389];
        layer1_col0[198] <= layer0_col0[390];
        layer1_col0[199] <= layer0_col0[391];
        layer1_col0[200] <= layer0_col0[392];
        layer1_col0[201] <= layer0_col0[393];
        layer1_col0[202] <= layer0_col0[394];
        layer1_col0[203] <= layer0_col0[395];
        layer1_col0[204] <= layer0_col0[396];
        layer1_col0[205] <= layer0_col0[397];
        layer1_col0[206] <= layer0_col0[398];
        layer1_col0[207] <= layer0_col0[399];
        layer1_col0[208] <= layer0_col0[400];
        layer1_col0[209] <= layer0_col0[401];
        layer1_col0[210] <= layer0_col0[402];
        layer1_col0[211] <= layer0_col0[403];
        layer1_col0[212] <= layer0_col0[404];
        layer1_col0[213] <= layer0_col0[405];
        layer1_col0[214] <= layer0_col0[406];
        layer1_col0[215] <= layer0_col0[407];
        layer1_col0[216] <= layer0_col0[408];
        layer1_col0[217] <= layer0_col0[409];
        layer1_col0[218] <= layer0_col0[410];
        layer1_col0[219] <= layer0_col0[411];
        layer1_col0[220] <= layer0_col0[412];
        layer1_col0[221] <= layer0_col0[413];
        layer1_col0[222] <= layer0_col0[414];
        layer1_col0[223] <= layer0_col0[415];
        layer1_col0[224] <= layer0_col0[416];
        layer1_col0[225] <= layer0_col0[417];
        layer1_col0[226] <= layer0_col0[418];
        layer1_col0[227] <= layer0_col0[419];
        layer1_col0[228] <= layer0_col0[420];
        layer1_col0[229] <= layer0_col0[421];
        layer1_col0[230] <= layer0_col0[422];
        layer1_col0[231] <= layer0_col0[423];
        layer1_col0[232] <= layer0_col0[424];
        layer1_col0[233] <= layer0_col0[425];
        layer1_col0[234] <= layer0_col0[426];
        layer1_col0[235] <= layer0_col0[427];
        layer1_col0[236] <= layer0_col0[428];
        layer1_col0[237] <= layer0_col0[429];
        layer1_col0[238] <= layer0_col0[430];
        layer1_col0[239] <= layer0_col0[431];
        layer1_col0[240] <= layer0_col0[432];
        layer1_col0[241] <= layer0_col0[433];
        layer1_col0[242] <= layer0_col0[434];
        layer1_col0[243] <= layer0_col0[435];
        layer1_col0[244] <= layer0_col0[436];
        layer1_col0[245] <= layer0_col0[437];
        layer1_col0[246] <= layer0_col0[438];
        layer1_col0[247] <= layer0_col0[439];
        layer1_col0[248] <= layer0_col0[440];
        layer1_col0[249] <= layer0_col0[441];
        layer1_col0[250] <= layer0_col0[442];
        layer1_col0[251] <= layer0_col0[443];
        layer1_col0[252] <= layer0_col0[444];
        layer1_col0[253] <= layer0_col0[445];
        layer1_col0[254] <= layer0_col0[446];
        layer1_col0[255] <= layer0_col0[447];
        layer1_col0[256] <= layer0_col0[448];
        layer1_col0[257] <= layer0_col0[449];
        layer1_col0[258] <= layer0_col0[450];
        layer1_col0[259] <= layer0_col0[451];
        layer1_col0[260] <= layer0_col0[452];
        layer1_col0[261] <= layer0_col0[453];
        layer1_col0[262] <= layer0_col0[454];
        layer1_col0[263] <= layer0_col0[455];
        layer1_col0[264] <= layer0_col0[456];
        layer1_col0[265] <= layer0_col0[457];
        layer1_col0[266] <= layer0_col0[458];
        layer1_col0[267] <= layer0_col0[459];
        layer1_col0[268] <= layer0_col0[460];
        layer1_col0[269] <= layer0_col0[461];
        layer1_col0[270] <= layer0_col0[462];
        layer1_col0[271] <= layer0_col0[463];
        layer1_col0[272] <= layer0_col0[464];
        layer1_col0[273] <= layer0_col0[465];
        layer1_col0[274] <= layer0_col0[466];
        layer1_col0[275] <= layer0_col0[467];
        layer1_col0[276] <= layer0_col0[468];
        layer1_col0[277] <= layer0_col0[469];
        layer1_col0[278] <= layer0_col0[470];
        layer1_col0[279] <= layer0_col0[471];
        layer1_col0[280] <= layer0_col0[472];
        layer1_col0[281] <= layer0_col0[473];
        layer1_col0[282] <= layer0_col0[474];
        layer1_col0[283] <= layer0_col0[475];
        layer1_col0[284] <= layer0_col0[476];
        layer1_col0[285] <= layer0_col0[477];
        layer1_col0[286] <= layer0_col0[478];
        layer1_col0[287] <= layer0_col0[479];
        layer1_col0[288] <= layer0_col0[480];
        layer1_col0[289] <= layer0_col0[481];
        layer1_col0[290] <= layer0_col0[482];
        layer1_col0[291] <= layer0_col0[483];
        layer1_col0[292] <= layer0_col0[484];
        layer1_col0[293] <= layer0_col0[485];
        layer1_col0[294] <= layer0_col0[486];
        layer1_col0[295] <= layer0_col0[487];
        layer1_col0[296] <= layer0_col0[488];
        layer1_col0[297] <= layer0_col0[489];
        layer1_col0[298] <= layer0_col0[490];
        layer1_col0[299] <= layer0_col0[491];
        layer1_col0[300] <= layer0_col0[492];
        layer1_col0[301] <= layer0_col0[493];
        layer1_col0[302] <= layer0_col0[494];
        layer1_col0[303] <= layer0_col0[495];
        layer1_col0[304] <= layer0_col0[496];
        layer1_col0[305] <= layer0_col0[497];
        layer1_col0[306] <= layer0_col0[498];
        layer1_col0[307] <= layer0_col0[499];
        layer1_col0[308] <= layer0_col0[500];
        layer1_col0[309] <= layer0_col0[501];
        layer1_col0[310] <= layer0_col0[502];
        layer1_col0[311] <= layer0_col0[503];
        layer1_col0[312] <= layer0_col0[504];
        layer1_col0[313] <= layer0_col0[505];
        layer1_col0[314] <= layer0_col0[506];
        layer1_col0[315] <= layer0_col0[507];
        layer1_col0[316] <= layer0_col0[508];
        layer1_col0[317] <= layer0_col0[509];
        layer1_col0[318] <= layer0_col0[510];
        layer1_col0[319] <= layer0_col0[511];
    end
    
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
    
    // GPC3 in layer1: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f3(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f3  ),
        .CLA (CLA_c9_41_l1_f3 ),
        .O0  (O0_c9_41_l1_f3  ),
        .O1  (O1_c9_41_l1_f3  ),
        .CY  (CY_c9_41_l1_f3  ),
        .PROP(PROP_c9_41_l1_f3));
    
    assign C0_c9_41_l1_f3 = layer1_col1[31:23];
    
    assign layer2_col1[7]     = O0_c9_41_l1_f3;
    assign layer2_col2[15:12] = O1_c9_41_l1_f3;
    
    // GPC4 in layer1: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f4(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f4  ),
        .CLA (CLA_c9_41_l1_f4 ),
        .O0  (O0_c9_41_l1_f4  ),
        .O1  (O1_c9_41_l1_f4  ),
        .CY  (CY_c9_41_l1_f4  ),
        .PROP(PROP_c9_41_l1_f4));
    
    assign C0_c9_41_l1_f4 = layer1_col1[40:32];
    
    assign layer2_col1[8]     = O0_c9_41_l1_f4;
    assign layer2_col2[19:16] = O1_c9_41_l1_f4;
    
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
    
    assign C0_c517_451_l1_f5 = layer1_col0[33:17];
    assign C1_c517_451_l1_f5 = layer1_col1[45:41];
    
    assign layer2_col0[1]     = O0_c517_451_l1_f5;
    assign layer2_col1[13:9]  = O1_c517_451_l1_f5;
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
    
    assign C0_c517_451_l1_f6 = layer1_col0[50:34];
    assign C1_c517_451_l1_f6 = layer1_col1[50:46];
    
    assign layer2_col0[2]     = O0_c517_451_l1_f6;
    assign layer2_col1[18:14] = O1_c517_451_l1_f6;
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
    
    assign C0_c517_451_l1_f7 = layer1_col0[67:51];
    assign C1_c517_451_l1_f7 = layer1_col1[55:51];
    
    assign layer2_col0[3]     = O0_c517_451_l1_f7;
    assign layer2_col1[23:19] = O1_c517_451_l1_f7;
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
    
    // GPC8 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f8(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f8   ),
        .C1   (C1_c517_451_l1_f8   ),
        .CLA  (CLA_c517_451_l1_f8  ),
        .O0   (O0_c517_451_l1_f8   ),
        .O1   (O1_c517_451_l1_f8   ),
        .O2   (O2_c517_451_l1_f8   ),
        .CY0  (CY0_c517_451_l1_f8  ),
        .PROP0(PROP0_c517_451_l1_f8),
        .CY1  (CY1_c517_451_l1_f8  ),
        .PROP1(PROP1_c517_451_l1_f8));
    
    assign C0_c517_451_l1_f8 = layer1_col0[84:68];
    assign C1_c517_451_l1_f8 = layer1_col1[60:56];
    
    assign layer2_col0[4]     = O0_c517_451_l1_f8;
    assign layer2_col1[28:24] = O1_c517_451_l1_f8;
    assign layer2_col2[35:32] = O2_c517_451_l1_f8;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f8_inst0 (
        .COUTB(COUT_LA_l1_f8[0]),
        .COUTD(COUT_LA_l1_f8[1]),
        .COUTF(COUT_LA_l1_f8[2]),
        .COUTH(COUT_LA_l1_f8[3]),
        .CIN  (CIN_LA_l1_f8    ),
        .CYA  (CY_LA_l1_f8[0]  ),
        .CYB  (CY_LA_l1_f8[1]  ),
        .CYC  (CY_LA_l1_f8[2]  ),
        .CYD  (CY_LA_l1_f8[3]  ),
        .CYE  (CY_LA_l1_f8[4]  ),
        .CYF  (CY_LA_l1_f8[5]  ),
        .CYG  (CY_LA_l1_f8[6]  ),
        .CYH  (CY_LA_l1_f8[7]  ),
        .PROPA(PROP_LA_l1_f8[0]),
        .PROPB(PROP_LA_l1_f8[1]),
        .PROPC(PROP_LA_l1_f8[2]),
        .PROPD(PROP_LA_l1_f8[3]),
        .PROPE(PROP_LA_l1_f8[4]),
        .PROPF(PROP_LA_l1_f8[5]),
        .PROPG(PROP_LA_l1_f8[6]),
        .PROPH(PROP_LA_l1_f8[7]));

    assign CLA_c517_451_l1_f8[0] = COUT_LA_l1_f8[0];
    assign CLA_c517_451_l1_f8[1] = COUT_LA_l1_f8[2];
    assign CIN_LA_l1_f8          = C0_c517_451_l1_f8[8];
    assign CY_LA_l1_f8[3:0]      = CY0_c517_451_l1_f8;
    assign CY_LA_l1_f8[7:4]      = CY1_c517_451_l1_f8;
    assign PROP_LA_l1_f8[3:0]    = PROP0_c517_451_l1_f8;
    assign PROP_LA_l1_f8[7:4]    = PROP1_c517_451_l1_f8;
    
    // GPC9 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f9(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f9   ),
        .C1   (C1_c517_451_l1_f9   ),
        .CLA  (CLA_c517_451_l1_f9  ),
        .O0   (O0_c517_451_l1_f9   ),
        .O1   (O1_c517_451_l1_f9   ),
        .O2   (O2_c517_451_l1_f9   ),
        .CY0  (CY0_c517_451_l1_f9  ),
        .PROP0(PROP0_c517_451_l1_f9),
        .CY1  (CY1_c517_451_l1_f9  ),
        .PROP1(PROP1_c517_451_l1_f9));
    
    assign C0_c517_451_l1_f9 = layer1_col0[101:85];
    assign C1_c517_451_l1_f9 = layer1_col1[65:61];
    
    assign layer2_col0[5]     = O0_c517_451_l1_f9;
    assign layer2_col1[33:29] = O1_c517_451_l1_f9;
    assign layer2_col2[39:36] = O2_c517_451_l1_f9;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f9_inst0 (
        .COUTB(COUT_LA_l1_f9[0]),
        .COUTD(COUT_LA_l1_f9[1]),
        .COUTF(COUT_LA_l1_f9[2]),
        .COUTH(COUT_LA_l1_f9[3]),
        .CIN  (CIN_LA_l1_f9    ),
        .CYA  (CY_LA_l1_f9[0]  ),
        .CYB  (CY_LA_l1_f9[1]  ),
        .CYC  (CY_LA_l1_f9[2]  ),
        .CYD  (CY_LA_l1_f9[3]  ),
        .CYE  (CY_LA_l1_f9[4]  ),
        .CYF  (CY_LA_l1_f9[5]  ),
        .CYG  (CY_LA_l1_f9[6]  ),
        .CYH  (CY_LA_l1_f9[7]  ),
        .PROPA(PROP_LA_l1_f9[0]),
        .PROPB(PROP_LA_l1_f9[1]),
        .PROPC(PROP_LA_l1_f9[2]),
        .PROPD(PROP_LA_l1_f9[3]),
        .PROPE(PROP_LA_l1_f9[4]),
        .PROPF(PROP_LA_l1_f9[5]),
        .PROPG(PROP_LA_l1_f9[6]),
        .PROPH(PROP_LA_l1_f9[7]));

    assign CLA_c517_451_l1_f9[0] = COUT_LA_l1_f9[0];
    assign CLA_c517_451_l1_f9[1] = COUT_LA_l1_f9[2];
    assign CIN_LA_l1_f9          = C0_c517_451_l1_f9[8];
    assign CY_LA_l1_f9[3:0]      = CY0_c517_451_l1_f9;
    assign CY_LA_l1_f9[7:4]      = CY1_c517_451_l1_f9;
    assign PROP_LA_l1_f9[3:0]    = PROP0_c517_451_l1_f9;
    assign PROP_LA_l1_f9[7:4]    = PROP1_c517_451_l1_f9;
    
    // GPC10 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f10(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f10   ),
        .C1   (C1_c517_451_l1_f10   ),
        .CLA  (CLA_c517_451_l1_f10  ),
        .O0   (O0_c517_451_l1_f10   ),
        .O1   (O1_c517_451_l1_f10   ),
        .O2   (O2_c517_451_l1_f10   ),
        .CY0  (CY0_c517_451_l1_f10  ),
        .PROP0(PROP0_c517_451_l1_f10),
        .CY1  (CY1_c517_451_l1_f10  ),
        .PROP1(PROP1_c517_451_l1_f10));
    
    assign C0_c517_451_l1_f10 = layer1_col0[118:102];
    assign C1_c517_451_l1_f10 = layer1_col1[70:66];
    
    assign layer2_col0[6]     = O0_c517_451_l1_f10;
    assign layer2_col1[38:34] = O1_c517_451_l1_f10;
    assign layer2_col2[43:40] = O2_c517_451_l1_f10;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f10_inst0 (
        .COUTB(COUT_LA_l1_f10[0]),
        .COUTD(COUT_LA_l1_f10[1]),
        .COUTF(COUT_LA_l1_f10[2]),
        .COUTH(COUT_LA_l1_f10[3]),
        .CIN  (CIN_LA_l1_f10    ),
        .CYA  (CY_LA_l1_f10[0]  ),
        .CYB  (CY_LA_l1_f10[1]  ),
        .CYC  (CY_LA_l1_f10[2]  ),
        .CYD  (CY_LA_l1_f10[3]  ),
        .CYE  (CY_LA_l1_f10[4]  ),
        .CYF  (CY_LA_l1_f10[5]  ),
        .CYG  (CY_LA_l1_f10[6]  ),
        .CYH  (CY_LA_l1_f10[7]  ),
        .PROPA(PROP_LA_l1_f10[0]),
        .PROPB(PROP_LA_l1_f10[1]),
        .PROPC(PROP_LA_l1_f10[2]),
        .PROPD(PROP_LA_l1_f10[3]),
        .PROPE(PROP_LA_l1_f10[4]),
        .PROPF(PROP_LA_l1_f10[5]),
        .PROPG(PROP_LA_l1_f10[6]),
        .PROPH(PROP_LA_l1_f10[7]));

    assign CLA_c517_451_l1_f10[0] = COUT_LA_l1_f10[0];
    assign CLA_c517_451_l1_f10[1] = COUT_LA_l1_f10[2];
    assign CIN_LA_l1_f10          = C0_c517_451_l1_f10[8];
    assign CY_LA_l1_f10[3:0]      = CY0_c517_451_l1_f10;
    assign CY_LA_l1_f10[7:4]      = CY1_c517_451_l1_f10;
    assign PROP_LA_l1_f10[3:0]    = PROP0_c517_451_l1_f10;
    assign PROP_LA_l1_f10[7:4]    = PROP1_c517_451_l1_f10;
    
    // GPC11 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f11(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f11   ),
        .C1   (C1_c517_451_l1_f11   ),
        .CLA  (CLA_c517_451_l1_f11  ),
        .O0   (O0_c517_451_l1_f11   ),
        .O1   (O1_c517_451_l1_f11   ),
        .O2   (O2_c517_451_l1_f11   ),
        .CY0  (CY0_c517_451_l1_f11  ),
        .PROP0(PROP0_c517_451_l1_f11),
        .CY1  (CY1_c517_451_l1_f11  ),
        .PROP1(PROP1_c517_451_l1_f11));
    
    assign C0_c517_451_l1_f11 = layer1_col0[135:119];
    assign C1_c517_451_l1_f11 = layer1_col1[75:71];
    
    assign layer2_col0[7]     = O0_c517_451_l1_f11;
    assign layer2_col1[43:39] = O1_c517_451_l1_f11;
    assign layer2_col2[47:44] = O2_c517_451_l1_f11;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f11_inst0 (
        .COUTB(COUT_LA_l1_f11[0]),
        .COUTD(COUT_LA_l1_f11[1]),
        .COUTF(COUT_LA_l1_f11[2]),
        .COUTH(COUT_LA_l1_f11[3]),
        .CIN  (CIN_LA_l1_f11    ),
        .CYA  (CY_LA_l1_f11[0]  ),
        .CYB  (CY_LA_l1_f11[1]  ),
        .CYC  (CY_LA_l1_f11[2]  ),
        .CYD  (CY_LA_l1_f11[3]  ),
        .CYE  (CY_LA_l1_f11[4]  ),
        .CYF  (CY_LA_l1_f11[5]  ),
        .CYG  (CY_LA_l1_f11[6]  ),
        .CYH  (CY_LA_l1_f11[7]  ),
        .PROPA(PROP_LA_l1_f11[0]),
        .PROPB(PROP_LA_l1_f11[1]),
        .PROPC(PROP_LA_l1_f11[2]),
        .PROPD(PROP_LA_l1_f11[3]),
        .PROPE(PROP_LA_l1_f11[4]),
        .PROPF(PROP_LA_l1_f11[5]),
        .PROPG(PROP_LA_l1_f11[6]),
        .PROPH(PROP_LA_l1_f11[7]));

    assign CLA_c517_451_l1_f11[0] = COUT_LA_l1_f11[0];
    assign CLA_c517_451_l1_f11[1] = COUT_LA_l1_f11[2];
    assign CIN_LA_l1_f11          = C0_c517_451_l1_f11[8];
    assign CY_LA_l1_f11[3:0]      = CY0_c517_451_l1_f11;
    assign CY_LA_l1_f11[7:4]      = CY1_c517_451_l1_f11;
    assign PROP_LA_l1_f11[3:0]    = PROP0_c517_451_l1_f11;
    assign PROP_LA_l1_f11[7:4]    = PROP1_c517_451_l1_f11;
    
    // GPC12 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f12(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f12   ),
        .C1   (C1_c517_451_l1_f12   ),
        .CLA  (CLA_c517_451_l1_f12  ),
        .O0   (O0_c517_451_l1_f12   ),
        .O1   (O1_c517_451_l1_f12   ),
        .O2   (O2_c517_451_l1_f12   ),
        .CY0  (CY0_c517_451_l1_f12  ),
        .PROP0(PROP0_c517_451_l1_f12),
        .CY1  (CY1_c517_451_l1_f12  ),
        .PROP1(PROP1_c517_451_l1_f12));
    
    assign C0_c517_451_l1_f12 = layer1_col0[152:136];
    assign C1_c517_451_l1_f12 = layer1_col1[80:76];
    
    assign layer2_col0[8]     = O0_c517_451_l1_f12;
    assign layer2_col1[48:44] = O1_c517_451_l1_f12;
    assign layer2_col2[51:48] = O2_c517_451_l1_f12;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f12_inst0 (
        .COUTB(COUT_LA_l1_f12[0]),
        .COUTD(COUT_LA_l1_f12[1]),
        .COUTF(COUT_LA_l1_f12[2]),
        .COUTH(COUT_LA_l1_f12[3]),
        .CIN  (CIN_LA_l1_f12    ),
        .CYA  (CY_LA_l1_f12[0]  ),
        .CYB  (CY_LA_l1_f12[1]  ),
        .CYC  (CY_LA_l1_f12[2]  ),
        .CYD  (CY_LA_l1_f12[3]  ),
        .CYE  (CY_LA_l1_f12[4]  ),
        .CYF  (CY_LA_l1_f12[5]  ),
        .CYG  (CY_LA_l1_f12[6]  ),
        .CYH  (CY_LA_l1_f12[7]  ),
        .PROPA(PROP_LA_l1_f12[0]),
        .PROPB(PROP_LA_l1_f12[1]),
        .PROPC(PROP_LA_l1_f12[2]),
        .PROPD(PROP_LA_l1_f12[3]),
        .PROPE(PROP_LA_l1_f12[4]),
        .PROPF(PROP_LA_l1_f12[5]),
        .PROPG(PROP_LA_l1_f12[6]),
        .PROPH(PROP_LA_l1_f12[7]));

    assign CLA_c517_451_l1_f12[0] = COUT_LA_l1_f12[0];
    assign CLA_c517_451_l1_f12[1] = COUT_LA_l1_f12[2];
    assign CIN_LA_l1_f12          = C0_c517_451_l1_f12[8];
    assign CY_LA_l1_f12[3:0]      = CY0_c517_451_l1_f12;
    assign CY_LA_l1_f12[7:4]      = CY1_c517_451_l1_f12;
    assign PROP_LA_l1_f12[3:0]    = PROP0_c517_451_l1_f12;
    assign PROP_LA_l1_f12[7:4]    = PROP1_c517_451_l1_f12;
    
    // GPC13 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f13(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f13   ),
        .C1   (C1_c517_451_l1_f13   ),
        .CLA  (CLA_c517_451_l1_f13  ),
        .O0   (O0_c517_451_l1_f13   ),
        .O1   (O1_c517_451_l1_f13   ),
        .O2   (O2_c517_451_l1_f13   ),
        .CY0  (CY0_c517_451_l1_f13  ),
        .PROP0(PROP0_c517_451_l1_f13),
        .CY1  (CY1_c517_451_l1_f13  ),
        .PROP1(PROP1_c517_451_l1_f13));
    
    assign C0_c517_451_l1_f13 = layer1_col0[169:153];
    assign C1_c517_451_l1_f13 = layer1_col1[85:81];
    
    assign layer2_col0[9]     = O0_c517_451_l1_f13;
    assign layer2_col1[53:49] = O1_c517_451_l1_f13;
    assign layer2_col2[55:52] = O2_c517_451_l1_f13;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f13_inst0 (
        .COUTB(COUT_LA_l1_f13[0]),
        .COUTD(COUT_LA_l1_f13[1]),
        .COUTF(COUT_LA_l1_f13[2]),
        .COUTH(COUT_LA_l1_f13[3]),
        .CIN  (CIN_LA_l1_f13    ),
        .CYA  (CY_LA_l1_f13[0]  ),
        .CYB  (CY_LA_l1_f13[1]  ),
        .CYC  (CY_LA_l1_f13[2]  ),
        .CYD  (CY_LA_l1_f13[3]  ),
        .CYE  (CY_LA_l1_f13[4]  ),
        .CYF  (CY_LA_l1_f13[5]  ),
        .CYG  (CY_LA_l1_f13[6]  ),
        .CYH  (CY_LA_l1_f13[7]  ),
        .PROPA(PROP_LA_l1_f13[0]),
        .PROPB(PROP_LA_l1_f13[1]),
        .PROPC(PROP_LA_l1_f13[2]),
        .PROPD(PROP_LA_l1_f13[3]),
        .PROPE(PROP_LA_l1_f13[4]),
        .PROPF(PROP_LA_l1_f13[5]),
        .PROPG(PROP_LA_l1_f13[6]),
        .PROPH(PROP_LA_l1_f13[7]));

    assign CLA_c517_451_l1_f13[0] = COUT_LA_l1_f13[0];
    assign CLA_c517_451_l1_f13[1] = COUT_LA_l1_f13[2];
    assign CIN_LA_l1_f13          = C0_c517_451_l1_f13[8];
    assign CY_LA_l1_f13[3:0]      = CY0_c517_451_l1_f13;
    assign CY_LA_l1_f13[7:4]      = CY1_c517_451_l1_f13;
    assign PROP_LA_l1_f13[3:0]    = PROP0_c517_451_l1_f13;
    assign PROP_LA_l1_f13[7:4]    = PROP1_c517_451_l1_f13;
    
    // GPC14 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f14(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f14   ),
        .C1   (C1_c517_451_l1_f14   ),
        .CLA  (CLA_c517_451_l1_f14  ),
        .O0   (O0_c517_451_l1_f14   ),
        .O1   (O1_c517_451_l1_f14   ),
        .O2   (O2_c517_451_l1_f14   ),
        .CY0  (CY0_c517_451_l1_f14  ),
        .PROP0(PROP0_c517_451_l1_f14),
        .CY1  (CY1_c517_451_l1_f14  ),
        .PROP1(PROP1_c517_451_l1_f14));
    
    assign C0_c517_451_l1_f14 = layer1_col0[186:170];
    assign C1_c517_451_l1_f14 = layer1_col1[90:86];
    
    assign layer2_col0[10]    = O0_c517_451_l1_f14;
    assign layer2_col1[58:54] = O1_c517_451_l1_f14;
    assign layer2_col2[59:56] = O2_c517_451_l1_f14;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f14_inst0 (
        .COUTB(COUT_LA_l1_f14[0]),
        .COUTD(COUT_LA_l1_f14[1]),
        .COUTF(COUT_LA_l1_f14[2]),
        .COUTH(COUT_LA_l1_f14[3]),
        .CIN  (CIN_LA_l1_f14    ),
        .CYA  (CY_LA_l1_f14[0]  ),
        .CYB  (CY_LA_l1_f14[1]  ),
        .CYC  (CY_LA_l1_f14[2]  ),
        .CYD  (CY_LA_l1_f14[3]  ),
        .CYE  (CY_LA_l1_f14[4]  ),
        .CYF  (CY_LA_l1_f14[5]  ),
        .CYG  (CY_LA_l1_f14[6]  ),
        .CYH  (CY_LA_l1_f14[7]  ),
        .PROPA(PROP_LA_l1_f14[0]),
        .PROPB(PROP_LA_l1_f14[1]),
        .PROPC(PROP_LA_l1_f14[2]),
        .PROPD(PROP_LA_l1_f14[3]),
        .PROPE(PROP_LA_l1_f14[4]),
        .PROPF(PROP_LA_l1_f14[5]),
        .PROPG(PROP_LA_l1_f14[6]),
        .PROPH(PROP_LA_l1_f14[7]));

    assign CLA_c517_451_l1_f14[0] = COUT_LA_l1_f14[0];
    assign CLA_c517_451_l1_f14[1] = COUT_LA_l1_f14[2];
    assign CIN_LA_l1_f14          = C0_c517_451_l1_f14[8];
    assign CY_LA_l1_f14[3:0]      = CY0_c517_451_l1_f14;
    assign CY_LA_l1_f14[7:4]      = CY1_c517_451_l1_f14;
    assign PROP_LA_l1_f14[3:0]    = PROP0_c517_451_l1_f14;
    assign PROP_LA_l1_f14[7:4]    = PROP1_c517_451_l1_f14;
    
    // GPC15 in layer1: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l1_f15(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f15   ),
        .C1   (C1_c517_451_l1_f15   ),
        .CLA  (CLA_c517_451_l1_f15  ),
        .O0   (O0_c517_451_l1_f15   ),
        .O1   (O1_c517_451_l1_f15   ),
        .O2   (O2_c517_451_l1_f15   ),
        .CY0  (CY0_c517_451_l1_f15  ),
        .PROP0(PROP0_c517_451_l1_f15),
        .CY1  (CY1_c517_451_l1_f15  ),
        .PROP1(PROP1_c517_451_l1_f15));
    
    assign C0_c517_451_l1_f15 = layer1_col0[203:187];
    assign C1_c517_451_l1_f15 = layer1_col1[95:91];
    
    assign layer2_col0[11]    = O0_c517_451_l1_f15;
    assign layer2_col1[63:59] = O1_c517_451_l1_f15;
    assign layer2_col2[63:60] = O2_c517_451_l1_f15;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f15_inst0 (
        .COUTB(COUT_LA_l1_f15[0]),
        .COUTD(COUT_LA_l1_f15[1]),
        .COUTF(COUT_LA_l1_f15[2]),
        .COUTH(COUT_LA_l1_f15[3]),
        .CIN  (CIN_LA_l1_f15    ),
        .CYA  (CY_LA_l1_f15[0]  ),
        .CYB  (CY_LA_l1_f15[1]  ),
        .CYC  (CY_LA_l1_f15[2]  ),
        .CYD  (CY_LA_l1_f15[3]  ),
        .CYE  (CY_LA_l1_f15[4]  ),
        .CYF  (CY_LA_l1_f15[5]  ),
        .CYG  (CY_LA_l1_f15[6]  ),
        .CYH  (CY_LA_l1_f15[7]  ),
        .PROPA(PROP_LA_l1_f15[0]),
        .PROPB(PROP_LA_l1_f15[1]),
        .PROPC(PROP_LA_l1_f15[2]),
        .PROPD(PROP_LA_l1_f15[3]),
        .PROPE(PROP_LA_l1_f15[4]),
        .PROPF(PROP_LA_l1_f15[5]),
        .PROPG(PROP_LA_l1_f15[6]),
        .PROPH(PROP_LA_l1_f15[7]));

    assign CLA_c517_451_l1_f15[0] = COUT_LA_l1_f15[0];
    assign CLA_c517_451_l1_f15[1] = COUT_LA_l1_f15[2];
    assign CIN_LA_l1_f15          = C0_c517_451_l1_f15[8];
    assign CY_LA_l1_f15[3:0]      = CY0_c517_451_l1_f15;
    assign CY_LA_l1_f15[7:4]      = CY1_c517_451_l1_f15;
    assign PROP_LA_l1_f15[3:0]    = PROP0_c517_451_l1_f15;
    assign PROP_LA_l1_f15[7:4]    = PROP1_c517_451_l1_f15;
    
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
    
    assign CY_LA_l1_floating_placement[5:4]   = CY_c9_41_l1_f3;
    assign PROP_LA_l1_floating_placement[5:4] = PROP_c9_41_l1_f3;
    
    assign CY_LA_l1_floating_placement[7:6]   = CY_c9_41_l1_f4;
    assign PROP_LA_l1_floating_placement[7:6] = PROP_c9_41_l1_f4;
    
    always_ff @(posedge clk) begin
        layer2_col0[12] <= layer1_col0[204];
        layer2_col0[13] <= layer1_col0[205];
        layer2_col0[14] <= layer1_col0[206];
        layer2_col0[15] <= layer1_col0[207];
        layer2_col0[16] <= layer1_col0[208];
        layer2_col0[17] <= layer1_col0[209];
        layer2_col0[18] <= layer1_col0[210];
        layer2_col0[19] <= layer1_col0[211];
        layer2_col0[20] <= layer1_col0[212];
        layer2_col0[21] <= layer1_col0[213];
        layer2_col0[22] <= layer1_col0[214];
        layer2_col0[23] <= layer1_col0[215];
        layer2_col0[24] <= layer1_col0[216];
        layer2_col0[25] <= layer1_col0[217];
        layer2_col0[26] <= layer1_col0[218];
        layer2_col0[27] <= layer1_col0[219];
        layer2_col0[28] <= layer1_col0[220];
        layer2_col0[29] <= layer1_col0[221];
        layer2_col0[30] <= layer1_col0[222];
        layer2_col0[31] <= layer1_col0[223];
        layer2_col0[32] <= layer1_col0[224];
        layer2_col0[33] <= layer1_col0[225];
        layer2_col0[34] <= layer1_col0[226];
        layer2_col0[35] <= layer1_col0[227];
        layer2_col0[36] <= layer1_col0[228];
        layer2_col0[37] <= layer1_col0[229];
        layer2_col0[38] <= layer1_col0[230];
        layer2_col0[39] <= layer1_col0[231];
        layer2_col0[40] <= layer1_col0[232];
        layer2_col0[41] <= layer1_col0[233];
        layer2_col0[42] <= layer1_col0[234];
        layer2_col0[43] <= layer1_col0[235];
        layer2_col0[44] <= layer1_col0[236];
        layer2_col0[45] <= layer1_col0[237];
        layer2_col0[46] <= layer1_col0[238];
        layer2_col0[47] <= layer1_col0[239];
        layer2_col0[48] <= layer1_col0[240];
        layer2_col0[49] <= layer1_col0[241];
        layer2_col0[50] <= layer1_col0[242];
        layer2_col0[51] <= layer1_col0[243];
        layer2_col0[52] <= layer1_col0[244];
        layer2_col0[53] <= layer1_col0[245];
        layer2_col0[54] <= layer1_col0[246];
        layer2_col0[55] <= layer1_col0[247];
        layer2_col0[56] <= layer1_col0[248];
        layer2_col0[57] <= layer1_col0[249];
        layer2_col0[58] <= layer1_col0[250];
        layer2_col0[59] <= layer1_col0[251];
        layer2_col0[60] <= layer1_col0[252];
        layer2_col0[61] <= layer1_col0[253];
        layer2_col0[62] <= layer1_col0[254];
        layer2_col0[63] <= layer1_col0[255];
        layer2_col0[64] <= layer1_col0[256];
        layer2_col0[65] <= layer1_col0[257];
        layer2_col0[66] <= layer1_col0[258];
        layer2_col0[67] <= layer1_col0[259];
        layer2_col0[68] <= layer1_col0[260];
        layer2_col0[69] <= layer1_col0[261];
        layer2_col0[70] <= layer1_col0[262];
        layer2_col0[71] <= layer1_col0[263];
        layer2_col0[72] <= layer1_col0[264];
        layer2_col0[73] <= layer1_col0[265];
        layer2_col0[74] <= layer1_col0[266];
        layer2_col0[75] <= layer1_col0[267];
        layer2_col0[76] <= layer1_col0[268];
        layer2_col0[77] <= layer1_col0[269];
        layer2_col0[78] <= layer1_col0[270];
        layer2_col0[79] <= layer1_col0[271];
        layer2_col0[80] <= layer1_col0[272];
        layer2_col0[81] <= layer1_col0[273];
        layer2_col0[82] <= layer1_col0[274];
        layer2_col0[83] <= layer1_col0[275];
        layer2_col0[84] <= layer1_col0[276];
        layer2_col0[85] <= layer1_col0[277];
        layer2_col0[86] <= layer1_col0[278];
        layer2_col0[87] <= layer1_col0[279];
        layer2_col0[88] <= layer1_col0[280];
        layer2_col0[89] <= layer1_col0[281];
        layer2_col0[90] <= layer1_col0[282];
        layer2_col0[91] <= layer1_col0[283];
        layer2_col0[92] <= layer1_col0[284];
        layer2_col0[93] <= layer1_col0[285];
        layer2_col0[94] <= layer1_col0[286];
        layer2_col0[95] <= layer1_col0[287];
        layer2_col0[96] <= layer1_col0[288];
        layer2_col0[97] <= layer1_col0[289];
        layer2_col0[98] <= layer1_col0[290];
        layer2_col0[99] <= layer1_col0[291];
        layer2_col0[100] <= layer1_col0[292];
        layer2_col0[101] <= layer1_col0[293];
        layer2_col0[102] <= layer1_col0[294];
        layer2_col0[103] <= layer1_col0[295];
        layer2_col0[104] <= layer1_col0[296];
        layer2_col0[105] <= layer1_col0[297];
        layer2_col0[106] <= layer1_col0[298];
        layer2_col0[107] <= layer1_col0[299];
        layer2_col0[108] <= layer1_col0[300];
        layer2_col0[109] <= layer1_col0[301];
        layer2_col0[110] <= layer1_col0[302];
        layer2_col0[111] <= layer1_col0[303];
        layer2_col0[112] <= layer1_col0[304];
        layer2_col0[113] <= layer1_col0[305];
        layer2_col0[114] <= layer1_col0[306];
        layer2_col0[115] <= layer1_col0[307];
        layer2_col0[116] <= layer1_col0[308];
        layer2_col0[117] <= layer1_col0[309];
        layer2_col0[118] <= layer1_col0[310];
        layer2_col0[119] <= layer1_col0[311];
        layer2_col0[120] <= layer1_col0[312];
        layer2_col0[121] <= layer1_col0[313];
        layer2_col0[122] <= layer1_col0[314];
        layer2_col0[123] <= layer1_col0[315];
        layer2_col0[124] <= layer1_col0[316];
        layer2_col0[125] <= layer1_col0[317];
        layer2_col0[126] <= layer1_col0[318];
        layer2_col0[127] <= layer1_col0[319];
    end
    
    // ------------------------------ LAYER 2 ------------------------------
    // GPC0 in layer2: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    c9_41 #(.OUTREG("TRUE" ),
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
    
    // GPC4 in layer2: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f4(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f4  ),
        .CLA (CLA_c9_41_l2_f4 ),
        .O0  (O0_c9_41_l2_f4  ),
        .O1  (O1_c9_41_l2_f4  ),
        .CY  (CY_c9_41_l2_f4  ),
        .PROP(PROP_c9_41_l2_f4));
    
    assign C0_c9_41_l2_f4 = layer2_col2[31:23];
    
    assign layer3_col2[11]    = O0_c9_41_l2_f4;
    assign layer3_col3[15:12] = O1_c9_41_l2_f4;
    
    // GPC5 in layer2: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l2_f5(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f5   ),
        .C1   (C1_c517_451_l2_f5   ),
        .CLA  (CLA_c517_451_l2_f5  ),
        .O0   (O0_c517_451_l2_f5   ),
        .O1   (O1_c517_451_l2_f5   ),
        .O2   (O2_c517_451_l2_f5   ),
        .CY0  (CY0_c517_451_l2_f5  ),
        .PROP0(PROP0_c517_451_l2_f5),
        .CY1  (CY1_c517_451_l2_f5  ),
        .PROP1(PROP1_c517_451_l2_f5));
    
    assign C0_c517_451_l2_f5 = layer2_col0[33:17];
    assign C1_c517_451_l2_f5 = layer2_col1[26:22];
    
    assign layer3_col0[1]     = O0_c517_451_l2_f5;
    assign layer3_col1[10:6]  = O1_c517_451_l2_f5;
    assign layer3_col2[15:12] = O2_c517_451_l2_f5;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f5_inst0 (
        .COUTB(COUT_LA_l2_f5[0]),
        .COUTD(COUT_LA_l2_f5[1]),
        .COUTF(COUT_LA_l2_f5[2]),
        .COUTH(COUT_LA_l2_f5[3]),
        .CIN  (CIN_LA_l2_f5    ),
        .CYA  (CY_LA_l2_f5[0]  ),
        .CYB  (CY_LA_l2_f5[1]  ),
        .CYC  (CY_LA_l2_f5[2]  ),
        .CYD  (CY_LA_l2_f5[3]  ),
        .CYE  (CY_LA_l2_f5[4]  ),
        .CYF  (CY_LA_l2_f5[5]  ),
        .CYG  (CY_LA_l2_f5[6]  ),
        .CYH  (CY_LA_l2_f5[7]  ),
        .PROPA(PROP_LA_l2_f5[0]),
        .PROPB(PROP_LA_l2_f5[1]),
        .PROPC(PROP_LA_l2_f5[2]),
        .PROPD(PROP_LA_l2_f5[3]),
        .PROPE(PROP_LA_l2_f5[4]),
        .PROPF(PROP_LA_l2_f5[5]),
        .PROPG(PROP_LA_l2_f5[6]),
        .PROPH(PROP_LA_l2_f5[7]));

    assign CLA_c517_451_l2_f5[0] = COUT_LA_l2_f5[0];
    assign CLA_c517_451_l2_f5[1] = COUT_LA_l2_f5[2];
    assign CIN_LA_l2_f5          = C0_c517_451_l2_f5[8];
    assign CY_LA_l2_f5[3:0]      = CY0_c517_451_l2_f5;
    assign CY_LA_l2_f5[7:4]      = CY1_c517_451_l2_f5;
    assign PROP_LA_l2_f5[3:0]    = PROP0_c517_451_l2_f5;
    assign PROP_LA_l2_f5[7:4]    = PROP1_c517_451_l2_f5;
    
    // GPC6 in layer2: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l2_f6(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f6   ),
        .C1   (C1_c517_451_l2_f6   ),
        .CLA  (CLA_c517_451_l2_f6  ),
        .O0   (O0_c517_451_l2_f6   ),
        .O1   (O1_c517_451_l2_f6   ),
        .O2   (O2_c517_451_l2_f6   ),
        .CY0  (CY0_c517_451_l2_f6  ),
        .PROP0(PROP0_c517_451_l2_f6),
        .CY1  (CY1_c517_451_l2_f6  ),
        .PROP1(PROP1_c517_451_l2_f6));
    
    assign C0_c517_451_l2_f6 = layer2_col1[43:27];
    assign C1_c517_451_l2_f6 = layer2_col2[36:32];
    
    assign layer3_col1[11]    = O0_c517_451_l2_f6;
    assign layer3_col2[20:16] = O1_c517_451_l2_f6;
    assign layer3_col3[19:16] = O2_c517_451_l2_f6;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f6_inst0 (
        .COUTB(COUT_LA_l2_f6[0]),
        .COUTD(COUT_LA_l2_f6[1]),
        .COUTF(COUT_LA_l2_f6[2]),
        .COUTH(COUT_LA_l2_f6[3]),
        .CIN  (CIN_LA_l2_f6    ),
        .CYA  (CY_LA_l2_f6[0]  ),
        .CYB  (CY_LA_l2_f6[1]  ),
        .CYC  (CY_LA_l2_f6[2]  ),
        .CYD  (CY_LA_l2_f6[3]  ),
        .CYE  (CY_LA_l2_f6[4]  ),
        .CYF  (CY_LA_l2_f6[5]  ),
        .CYG  (CY_LA_l2_f6[6]  ),
        .CYH  (CY_LA_l2_f6[7]  ),
        .PROPA(PROP_LA_l2_f6[0]),
        .PROPB(PROP_LA_l2_f6[1]),
        .PROPC(PROP_LA_l2_f6[2]),
        .PROPD(PROP_LA_l2_f6[3]),
        .PROPE(PROP_LA_l2_f6[4]),
        .PROPF(PROP_LA_l2_f6[5]),
        .PROPG(PROP_LA_l2_f6[6]),
        .PROPH(PROP_LA_l2_f6[7]));

    assign CLA_c517_451_l2_f6[0] = COUT_LA_l2_f6[0];
    assign CLA_c517_451_l2_f6[1] = COUT_LA_l2_f6[2];
    assign CIN_LA_l2_f6          = C0_c517_451_l2_f6[8];
    assign CY_LA_l2_f6[3:0]      = CY0_c517_451_l2_f6;
    assign CY_LA_l2_f6[7:4]      = CY1_c517_451_l2_f6;
    assign PROP_LA_l2_f6[3:0]    = PROP0_c517_451_l2_f6;
    assign PROP_LA_l2_f6[7:4]    = PROP1_c517_451_l2_f6;
    
    // GPC7 in layer2: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l2_f7(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f7   ),
        .C1   (C1_c517_451_l2_f7   ),
        .CLA  (CLA_c517_451_l2_f7  ),
        .O0   (O0_c517_451_l2_f7   ),
        .O1   (O1_c517_451_l2_f7   ),
        .O2   (O2_c517_451_l2_f7   ),
        .CY0  (CY0_c517_451_l2_f7  ),
        .PROP0(PROP0_c517_451_l2_f7),
        .CY1  (CY1_c517_451_l2_f7  ),
        .PROP1(PROP1_c517_451_l2_f7));
    
    assign C0_c517_451_l2_f7 = layer2_col0[50:34];
    assign C1_c517_451_l2_f7 = layer2_col1[48:44];
    
    assign layer3_col0[2]     = O0_c517_451_l2_f7;
    assign layer3_col1[16:12] = O1_c517_451_l2_f7;
    assign layer3_col2[24:21] = O2_c517_451_l2_f7;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f7_inst0 (
        .COUTB(COUT_LA_l2_f7[0]),
        .COUTD(COUT_LA_l2_f7[1]),
        .COUTF(COUT_LA_l2_f7[2]),
        .COUTH(COUT_LA_l2_f7[3]),
        .CIN  (CIN_LA_l2_f7    ),
        .CYA  (CY_LA_l2_f7[0]  ),
        .CYB  (CY_LA_l2_f7[1]  ),
        .CYC  (CY_LA_l2_f7[2]  ),
        .CYD  (CY_LA_l2_f7[3]  ),
        .CYE  (CY_LA_l2_f7[4]  ),
        .CYF  (CY_LA_l2_f7[5]  ),
        .CYG  (CY_LA_l2_f7[6]  ),
        .CYH  (CY_LA_l2_f7[7]  ),
        .PROPA(PROP_LA_l2_f7[0]),
        .PROPB(PROP_LA_l2_f7[1]),
        .PROPC(PROP_LA_l2_f7[2]),
        .PROPD(PROP_LA_l2_f7[3]),
        .PROPE(PROP_LA_l2_f7[4]),
        .PROPF(PROP_LA_l2_f7[5]),
        .PROPG(PROP_LA_l2_f7[6]),
        .PROPH(PROP_LA_l2_f7[7]));

    assign CLA_c517_451_l2_f7[0] = COUT_LA_l2_f7[0];
    assign CLA_c517_451_l2_f7[1] = COUT_LA_l2_f7[2];
    assign CIN_LA_l2_f7          = C0_c517_451_l2_f7[8];
    assign CY_LA_l2_f7[3:0]      = CY0_c517_451_l2_f7;
    assign CY_LA_l2_f7[7:4]      = CY1_c517_451_l2_f7;
    assign PROP_LA_l2_f7[3:0]    = PROP0_c517_451_l2_f7;
    assign PROP_LA_l2_f7[7:4]    = PROP1_c517_451_l2_f7;
    
    // GPC8 in layer2: (4,13 : 3,4,1) at column 1
    
    c413_341 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c413_341_l2_f8(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l2_f8   ),
        .C1   (C1_c413_341_l2_f8   ),
        .CLA  (CLA_c413_341_l2_f8  ),
        .O0   (O0_c413_341_l2_f8   ),
        .O1   (O1_c413_341_l2_f8   ),
        .O2   (O2_c413_341_l2_f8   ),
        .CY0  (CY0_c413_341_l2_f8  ),
        .PROP0(PROP0_c413_341_l2_f8),
        .CY1  (CY1_c413_341_l2_f8  ),
        .PROP1(PROP1_c413_341_l2_f8));
    
    assign C0_c413_341_l2_f8 = layer2_col1[61:49];
    assign C1_c413_341_l2_f8 = layer2_col2[40:37];
    
    assign layer3_col1[17]    = O0_c413_341_l2_f8;
    assign layer3_col2[28:25] = O1_c413_341_l2_f8;
    assign layer3_col3[22:20] = O2_c413_341_l2_f8;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f8_inst0 (
        .COUTB(COUT_LA_l2_f8[0]),
        .COUTD(COUT_LA_l2_f8[1]),
        .COUTF(COUT_LA_l2_f8[2]),
        .COUTH(COUT_LA_l2_f8[3]),
        .CIN  (CIN_LA_l2_f8    ),
        .CYA  (CY_LA_l2_f8[0]  ),
        .CYB  (CY_LA_l2_f8[1]  ),
        .CYC  (CY_LA_l2_f8[2]  ),
        .CYD  (CY_LA_l2_f8[3]  ),
        .CYE  (CY_LA_l2_f8[4]  ),
        .CYF  (CY_LA_l2_f8[5]  ),
        .CYG  (CY_LA_l2_f8[6]  ),
        .CYH  (CY_LA_l2_f8[7]  ),
        .PROPA(PROP_LA_l2_f8[0]),
        .PROPB(PROP_LA_l2_f8[1]),
        .PROPC(PROP_LA_l2_f8[2]),
        .PROPD(PROP_LA_l2_f8[3]),
        .PROPE(PROP_LA_l2_f8[4]),
        .PROPF(PROP_LA_l2_f8[5]),
        .PROPG(PROP_LA_l2_f8[6]),
        .PROPH(PROP_LA_l2_f8[7]));

    assign CLA_c413_341_l2_f8[0] = COUT_LA_l2_f8[0];
    assign CLA_c413_341_l2_f8[1] = COUT_LA_l2_f8[2];
    assign CIN_LA_l2_f8          = C0_c413_341_l2_f8[8];
    assign CY_LA_l2_f8[2:0]      = CY0_c413_341_l2_f8;
    assign CY_LA_l2_f8[6:4]      = CY1_c413_341_l2_f8;
    assign PROP_LA_l2_f8[2:0]    = PROP0_c413_341_l2_f8;
    assign PROP_LA_l2_f8[6:4]    = PROP1_c413_341_l2_f8;
    assign PROP_LA_l2_f8[3]      = 1'b0;
    assign CY_LA_l2_f8[3]        = 1'b0;
    
    // GPC9 in layer2: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f9(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f9  ),
        .CLA (CLA_c9_41_l2_f9 ),
        .O0  (O0_c9_41_l2_f9  ),
        .O1  (O1_c9_41_l2_f9  ),
        .CY  (CY_c9_41_l2_f9  ),
        .PROP(PROP_c9_41_l2_f9));
    
    assign C0_c9_41_l2_f9 = layer2_col0[59:51];
    
    assign layer3_col0[3]     = O0_c9_41_l2_f9;
    assign layer3_col1[21:18] = O1_c9_41_l2_f9;
    
    // GPC10 in layer2: (1,5 : 3] at column 0
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l2_f10(
        .clk (clk              ),
        .C0  (C0_c15_3_l2_f10  ),
        .C1  (C1_c15_3_l2_f10  ),
        .CLA (CLA_c15_3_l2_f10 ),
        .O   (O_c15_3_l2_f10   ),
        .CY  (CY_c15_3_l2_f10  ),
        .PROP(PROP_c15_3_l2_f10));
    
    assign C0_c15_3_l2_f10 = layer2_col0[64:60];
    assign C1_c15_3_l2_f10 = layer2_col1[62];
    
    assign layer3_col0[4]  = O_c15_3_l2_f10[0];
    assign layer3_col1[22] = O_c15_3_l2_f10[1];
    assign layer3_col2[29] = O_c15_3_l2_f10[2];
    
    // GPC11 in layer2: (1,5 : 3] at column 0
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l2_f11(
        .clk (clk              ),
        .C0  (C0_c15_3_l2_f11  ),
        .C1  (C1_c15_3_l2_f11  ),
        .CLA (CLA_c15_3_l2_f11 ),
        .O   (O_c15_3_l2_f11   ),
        .CY  (CY_c15_3_l2_f11  ),
        .PROP(PROP_c15_3_l2_f11));
    
    assign C0_c15_3_l2_f11 = layer2_col0[69:65];
    assign C1_c15_3_l2_f11 = layer2_col1[63];
    
    assign layer3_col0[5]  = O_c15_3_l2_f11[0];
    assign layer3_col1[23] = O_c15_3_l2_f11[1];
    assign layer3_col2[30] = O_c15_3_l2_f11[2];
    
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
        .CIN  (CIN_LA_l2_floating_placement[0] ),
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

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_floating_placement_inst1 (
        .COUTB(COUT_LA_l2_floating_placement[4] ),
        .COUTD(COUT_LA_l2_floating_placement[5] ),
        .COUTF(COUT_LA_l2_floating_placement[6] ),
        .COUTH(COUT_LA_l2_floating_placement[7] ),
        .CIN  (CIN_LA_l2_floating_placement[1]  ),
        .CYA  (CY_LA_l2_floating_placement[8]   ),
        .CYB  (CY_LA_l2_floating_placement[9]   ),
        .CYC  (CY_LA_l2_floating_placement[10]  ),
        .CYD  (CY_LA_l2_floating_placement[11]  ),
        .CYE  (CY_LA_l2_floating_placement[12]  ),
        .CYF  (CY_LA_l2_floating_placement[13]  ),
        .CYG  (CY_LA_l2_floating_placement[14]  ),
        .CYH  (CY_LA_l2_floating_placement[15]  ),
        .PROPA(PROP_LA_l2_floating_placement[8] ),
        .PROPB(PROP_LA_l2_floating_placement[9] ),
        .PROPC(PROP_LA_l2_floating_placement[10]),
        .PROPD(PROP_LA_l2_floating_placement[11]),
        .PROPE(PROP_LA_l2_floating_placement[12]),
        .PROPF(PROP_LA_l2_floating_placement[13]),
        .PROPG(PROP_LA_l2_floating_placement[14]),
        .PROPH(PROP_LA_l2_floating_placement[15]));

    assign CY_LA_l2_floating_placement[1:0]   = CY_c9_41_l2_f2;
    assign PROP_LA_l2_floating_placement[1:0] = PROP_c9_41_l2_f2;
    assign CIN_LA_l2_floating_placement[0] = C0_c9_41_l2_f2[8];
    
    assign CY_LA_l2_floating_placement[3:2]   = CY_c9_41_l2_f3;
    assign PROP_LA_l2_floating_placement[3:2] = PROP_c9_41_l2_f3;
    
    assign CY_LA_l2_floating_placement[5:4]   = CY_c9_41_l2_f4;
    assign PROP_LA_l2_floating_placement[5:4] = PROP_c9_41_l2_f4;
    
    assign CY_LA_l2_floating_placement[7:6]   = CY_c9_41_l2_f9;
    assign PROP_LA_l2_floating_placement[7:6] = PROP_c9_41_l2_f9;
    
    assign CY_LA_l2_floating_placement[9:8]   = CY_c15_3_l2_f10;
    assign PROP_LA_l2_floating_placement[9:8] = PROP_c15_3_l2_f10;
    assign CIN_LA_l2_floating_placement[1] = C0_c15_3_l2_f10[4];
    
    assign CY_LA_l2_floating_placement[11:10]   = CY_c15_3_l2_f11;
    assign PROP_LA_l2_floating_placement[11:10] = PROP_c15_3_l2_f11;
    
    always_ff @(posedge clk) begin
        layer3_col0[6] <= layer2_col0[70];
        layer3_col0[7] <= layer2_col0[71];
        layer3_col0[8] <= layer2_col0[72];
        layer3_col0[9] <= layer2_col0[73];
        layer3_col0[10] <= layer2_col0[74];
        layer3_col0[11] <= layer2_col0[75];
        layer3_col0[12] <= layer2_col0[76];
        layer3_col0[13] <= layer2_col0[77];
        layer3_col0[14] <= layer2_col0[78];
        layer3_col0[15] <= layer2_col0[79];
        layer3_col0[16] <= layer2_col0[80];
        layer3_col0[17] <= layer2_col0[81];
        layer3_col0[18] <= layer2_col0[82];
        layer3_col0[19] <= layer2_col0[83];
        layer3_col0[20] <= layer2_col0[84];
        layer3_col0[21] <= layer2_col0[85];
        layer3_col0[22] <= layer2_col0[86];
        layer3_col0[23] <= layer2_col0[87];
        layer3_col0[24] <= layer2_col0[88];
        layer3_col0[25] <= layer2_col0[89];
        layer3_col0[26] <= layer2_col0[90];
        layer3_col0[27] <= layer2_col0[91];
        layer3_col0[28] <= layer2_col0[92];
        layer3_col0[29] <= layer2_col0[93];
        layer3_col0[30] <= layer2_col0[94];
        layer3_col0[31] <= layer2_col0[95];
        layer3_col0[32] <= layer2_col0[96];
        layer3_col0[33] <= layer2_col0[97];
        layer3_col0[34] <= layer2_col0[98];
        layer3_col0[35] <= layer2_col0[99];
        layer3_col0[36] <= layer2_col0[100];
        layer3_col0[37] <= layer2_col0[101];
        layer3_col0[38] <= layer2_col0[102];
        layer3_col0[39] <= layer2_col0[103];
        layer3_col0[40] <= layer2_col0[104];
        layer3_col0[41] <= layer2_col0[105];
        layer3_col0[42] <= layer2_col0[106];
        layer3_col0[43] <= layer2_col0[107];
        layer3_col0[44] <= layer2_col0[108];
        layer3_col0[45] <= layer2_col0[109];
        layer3_col0[46] <= layer2_col0[110];
        layer3_col0[47] <= layer2_col0[111];
        layer3_col0[48] <= layer2_col0[112];
        layer3_col0[49] <= layer2_col0[113];
        layer3_col0[50] <= layer2_col0[114];
        layer3_col0[51] <= layer2_col0[115];
        layer3_col0[52] <= layer2_col0[116];
        layer3_col0[53] <= layer2_col0[117];
        layer3_col0[54] <= layer2_col0[118];
        layer3_col0[55] <= layer2_col0[119];
        layer3_col0[56] <= layer2_col0[120];
        layer3_col0[57] <= layer2_col0[121];
        layer3_col0[58] <= layer2_col0[122];
        layer3_col0[59] <= layer2_col0[123];
        layer3_col0[60] <= layer2_col0[124];
        layer3_col0[61] <= layer2_col0[125];
        layer3_col0[62] <= layer2_col0[126];
        layer3_col0[63] <= layer2_col0[127];
        layer3_col2[31] <= layer2_col2[41];
        layer3_col2[32] <= layer2_col2[42];
        layer3_col2[33] <= layer2_col2[43];
        layer3_col2[34] <= layer2_col2[44];
        layer3_col2[35] <= layer2_col2[45];
        layer3_col2[36] <= layer2_col2[46];
        layer3_col2[37] <= layer2_col2[47];
        layer3_col2[38] <= layer2_col2[48];
        layer3_col2[39] <= layer2_col2[49];
        layer3_col2[40] <= layer2_col2[50];
        layer3_col2[41] <= layer2_col2[51];
        layer3_col2[42] <= layer2_col2[52];
        layer3_col2[43] <= layer2_col2[53];
        layer3_col2[44] <= layer2_col2[54];
        layer3_col2[45] <= layer2_col2[55];
        layer3_col2[46] <= layer2_col2[56];
        layer3_col2[47] <= layer2_col2[57];
        layer3_col2[48] <= layer2_col2[58];
        layer3_col2[49] <= layer2_col2[59];
        layer3_col2[50] <= layer2_col2[60];
        layer3_col2[51] <= layer2_col2[61];
        layer3_col2[52] <= layer2_col2[62];
        layer3_col2[53] <= layer2_col2[63];
    end
    
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
    
    // GPC1 in layer3: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l3_f1(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l3_f1   ),
        .C1   (C1_c517_451_l3_f1   ),
        .CLA  (CLA_c517_451_l3_f1  ),
        .O0   (O0_c517_451_l3_f1   ),
        .O1   (O1_c517_451_l3_f1   ),
        .O2   (O2_c517_451_l3_f1   ),
        .CY0  (CY0_c517_451_l3_f1  ),
        .PROP0(PROP0_c517_451_l3_f1),
        .CY1  (CY1_c517_451_l3_f1  ),
        .PROP1(PROP1_c517_451_l3_f1));
    
    assign C0_c517_451_l3_f1 = layer3_col1[21:5];
    assign C1_c517_451_l3_f1 = layer3_col2[4:0];
    
    assign layer4_col1[5]   = O0_c517_451_l3_f1;
    assign layer4_col2[8:4] = O1_c517_451_l3_f1;
    assign layer4_col3[3:0] = O2_c517_451_l3_f1;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f1_inst0 (
        .COUTB(COUT_LA_l3_f1[0]),
        .COUTD(COUT_LA_l3_f1[1]),
        .COUTF(COUT_LA_l3_f1[2]),
        .COUTH(COUT_LA_l3_f1[3]),
        .CIN  (CIN_LA_l3_f1    ),
        .CYA  (CY_LA_l3_f1[0]  ),
        .CYB  (CY_LA_l3_f1[1]  ),
        .CYC  (CY_LA_l3_f1[2]  ),
        .CYD  (CY_LA_l3_f1[3]  ),
        .CYE  (CY_LA_l3_f1[4]  ),
        .CYF  (CY_LA_l3_f1[5]  ),
        .CYG  (CY_LA_l3_f1[6]  ),
        .CYH  (CY_LA_l3_f1[7]  ),
        .PROPA(PROP_LA_l3_f1[0]),
        .PROPB(PROP_LA_l3_f1[1]),
        .PROPC(PROP_LA_l3_f1[2]),
        .PROPD(PROP_LA_l3_f1[3]),
        .PROPE(PROP_LA_l3_f1[4]),
        .PROPF(PROP_LA_l3_f1[5]),
        .PROPG(PROP_LA_l3_f1[6]),
        .PROPH(PROP_LA_l3_f1[7]));

    assign CLA_c517_451_l3_f1[0] = COUT_LA_l3_f1[0];
    assign CLA_c517_451_l3_f1[1] = COUT_LA_l3_f1[2];
    assign CIN_LA_l3_f1          = C0_c517_451_l3_f1[8];
    assign CY_LA_l3_f1[3:0]      = CY0_c517_451_l3_f1;
    assign CY_LA_l3_f1[7:4]      = CY1_c517_451_l3_f1;
    assign PROP_LA_l3_f1[3:0]    = PROP0_c517_451_l3_f1;
    assign PROP_LA_l3_f1[7:4]    = PROP1_c517_451_l3_f1;
    
    // GPC2 in layer3: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l3_f2(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l3_f2   ),
        .C1   (C1_c517_451_l3_f2   ),
        .CLA  (CLA_c517_451_l3_f2  ),
        .O0   (O0_c517_451_l3_f2   ),
        .O1   (O1_c517_451_l3_f2   ),
        .O2   (O2_c517_451_l3_f2   ),
        .CY0  (CY0_c517_451_l3_f2  ),
        .PROP0(PROP0_c517_451_l3_f2),
        .CY1  (CY1_c517_451_l3_f2  ),
        .PROP1(PROP1_c517_451_l3_f2));
    
    assign C0_c517_451_l3_f2 = layer3_col2[21:5];
    assign C1_c517_451_l3_f2 = layer3_col3[4:0];
    
    assign layer4_col2[9]   = O0_c517_451_l3_f2;
    assign layer4_col3[8:4] = O1_c517_451_l3_f2;
    assign layer4_col4[3:0] = O2_c517_451_l3_f2;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f2_inst0 (
        .COUTB(COUT_LA_l3_f2[0]),
        .COUTD(COUT_LA_l3_f2[1]),
        .COUTF(COUT_LA_l3_f2[2]),
        .COUTH(COUT_LA_l3_f2[3]),
        .CIN  (CIN_LA_l3_f2    ),
        .CYA  (CY_LA_l3_f2[0]  ),
        .CYB  (CY_LA_l3_f2[1]  ),
        .CYC  (CY_LA_l3_f2[2]  ),
        .CYD  (CY_LA_l3_f2[3]  ),
        .CYE  (CY_LA_l3_f2[4]  ),
        .CYF  (CY_LA_l3_f2[5]  ),
        .CYG  (CY_LA_l3_f2[6]  ),
        .CYH  (CY_LA_l3_f2[7]  ),
        .PROPA(PROP_LA_l3_f2[0]),
        .PROPB(PROP_LA_l3_f2[1]),
        .PROPC(PROP_LA_l3_f2[2]),
        .PROPD(PROP_LA_l3_f2[3]),
        .PROPE(PROP_LA_l3_f2[4]),
        .PROPF(PROP_LA_l3_f2[5]),
        .PROPG(PROP_LA_l3_f2[6]),
        .PROPH(PROP_LA_l3_f2[7]));

    assign CLA_c517_451_l3_f2[0] = COUT_LA_l3_f2[0];
    assign CLA_c517_451_l3_f2[1] = COUT_LA_l3_f2[2];
    assign CIN_LA_l3_f2          = C0_c517_451_l3_f2[8];
    assign CY_LA_l3_f2[3:0]      = CY0_c517_451_l3_f2;
    assign CY_LA_l3_f2[7:4]      = CY1_c517_451_l3_f2;
    assign PROP_LA_l3_f2[3:0]    = PROP0_c517_451_l3_f2;
    assign PROP_LA_l3_f2[7:4]    = PROP1_c517_451_l3_f2;
    
    // GPC3 in layer3: (9 : 4,1) at column 3
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l3_f3(
        .clk (clk             ),
        .C0  (C0_c9_41_l3_f3  ),
        .CLA (CLA_c9_41_l3_f3 ),
        .O0  (O0_c9_41_l3_f3  ),
        .O1  (O1_c9_41_l3_f3  ),
        .CY  (CY_c9_41_l3_f3  ),
        .PROP(PROP_c9_41_l3_f3));
    
    assign C0_c9_41_l3_f3 = layer3_col3[13:5];
    
    assign layer4_col3[9]   = O0_c9_41_l3_f3;
    assign layer4_col4[7:4] = O1_c9_41_l3_f3;
    
    // GPC4 in layer3: (9 : 4,1) at column 0
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l3_f4(
        .clk (clk             ),
        .C0  (C0_c9_41_l3_f4  ),
        .CLA (CLA_c9_41_l3_f4 ),
        .O0  (O0_c9_41_l3_f4  ),
        .O1  (O1_c9_41_l3_f4  ),
        .CY  (CY_c9_41_l3_f4  ),
        .PROP(PROP_c9_41_l3_f4));
    
    assign C0_c9_41_l3_f4 = layer3_col0[25:17];
    
    assign layer4_col0[1]   = O0_c9_41_l3_f4;
    assign layer4_col1[9:6] = O1_c9_41_l3_f4;
    
    // GPC5 in layer3: (1,5 : 3] at column 0
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_f5(
        .clk (clk             ),
        .C0  (C0_c15_3_l3_f5  ),
        .C1  (C1_c15_3_l3_f5  ),
        .CLA (CLA_c15_3_l3_f5 ),
        .O   (O_c15_3_l3_f5   ),
        .CY  (CY_c15_3_l3_f5  ),
        .PROP(PROP_c15_3_l3_f5));
    
    assign C0_c15_3_l3_f5 = layer3_col0[30:26];
    assign C1_c15_3_l3_f5 = layer3_col1[22];
    
    assign layer4_col0[2]  = O_c15_3_l3_f5[0];
    assign layer4_col1[10] = O_c15_3_l3_f5[1];
    assign layer4_col2[10] = O_c15_3_l3_f5[2];
    
    // GPC6 in layer3: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l3_f6(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l3_f6   ),
        .C1   (C1_c517_451_l3_f6   ),
        .CLA  (CLA_c517_451_l3_f6  ),
        .O0   (O0_c517_451_l3_f6   ),
        .O1   (O1_c517_451_l3_f6   ),
        .O2   (O2_c517_451_l3_f6   ),
        .CY0  (CY0_c517_451_l3_f6  ),
        .PROP0(PROP0_c517_451_l3_f6),
        .CY1  (CY1_c517_451_l3_f6  ),
        .PROP1(PROP1_c517_451_l3_f6));
    
    assign C0_c517_451_l3_f6 = layer3_col2[38:22];
    assign C1_c517_451_l3_f6 = layer3_col3[18:14];
    
    assign layer4_col2[11]    = O0_c517_451_l3_f6;
    assign layer4_col3[14:10] = O1_c517_451_l3_f6;
    assign layer4_col4[11:8]  = O2_c517_451_l3_f6;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f6_inst0 (
        .COUTB(COUT_LA_l3_f6[0]),
        .COUTD(COUT_LA_l3_f6[1]),
        .COUTF(COUT_LA_l3_f6[2]),
        .COUTH(COUT_LA_l3_f6[3]),
        .CIN  (CIN_LA_l3_f6    ),
        .CYA  (CY_LA_l3_f6[0]  ),
        .CYB  (CY_LA_l3_f6[1]  ),
        .CYC  (CY_LA_l3_f6[2]  ),
        .CYD  (CY_LA_l3_f6[3]  ),
        .CYE  (CY_LA_l3_f6[4]  ),
        .CYF  (CY_LA_l3_f6[5]  ),
        .CYG  (CY_LA_l3_f6[6]  ),
        .CYH  (CY_LA_l3_f6[7]  ),
        .PROPA(PROP_LA_l3_f6[0]),
        .PROPB(PROP_LA_l3_f6[1]),
        .PROPC(PROP_LA_l3_f6[2]),
        .PROPD(PROP_LA_l3_f6[3]),
        .PROPE(PROP_LA_l3_f6[4]),
        .PROPF(PROP_LA_l3_f6[5]),
        .PROPG(PROP_LA_l3_f6[6]),
        .PROPH(PROP_LA_l3_f6[7]));

    assign CLA_c517_451_l3_f6[0] = COUT_LA_l3_f6[0];
    assign CLA_c517_451_l3_f6[1] = COUT_LA_l3_f6[2];
    assign CIN_LA_l3_f6          = C0_c517_451_l3_f6[8];
    assign CY_LA_l3_f6[3:0]      = CY0_c517_451_l3_f6;
    assign CY_LA_l3_f6[7:4]      = CY1_c517_451_l3_f6;
    assign PROP_LA_l3_f6[3:0]    = PROP0_c517_451_l3_f6;
    assign PROP_LA_l3_f6[7:4]    = PROP1_c517_451_l3_f6;
    
    // GPC7 in layer3: (1,5 : 3] at column 0
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l3_f7(
        .clk (clk             ),
        .C0  (C0_c15_3_l3_f7  ),
        .C1  (C1_c15_3_l3_f7  ),
        .CLA (CLA_c15_3_l3_f7 ),
        .O   (O_c15_3_l3_f7   ),
        .CY  (CY_c15_3_l3_f7  ),
        .PROP(PROP_c15_3_l3_f7));
    
    assign C0_c15_3_l3_f7 = layer3_col0[35:31];
    assign C1_c15_3_l3_f7 = layer3_col1[23];
    
    assign layer4_col0[3]  = O_c15_3_l3_f7[0];
    assign layer4_col1[11] = O_c15_3_l3_f7[1];
    assign layer4_col2[12] = O_c15_3_l3_f7[2];
    
    // GPC8 in layer3: (4,13 : 3,4,1) at column 2
    
    c413_341 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c413_341_l3_f8(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l3_f8   ),
        .C1   (C1_c413_341_l3_f8   ),
        .CLA  (CLA_c413_341_l3_f8  ),
        .O0   (O0_c413_341_l3_f8   ),
        .O1   (O1_c413_341_l3_f8   ),
        .O2   (O2_c413_341_l3_f8   ),
        .CY0  (CY0_c413_341_l3_f8  ),
        .PROP0(PROP0_c413_341_l3_f8),
        .CY1  (CY1_c413_341_l3_f8  ),
        .PROP1(PROP1_c413_341_l3_f8));
    
    assign C0_c413_341_l3_f8 = layer3_col2[51:39];
    assign C1_c413_341_l3_f8 = layer3_col3[22:19];
    
    assign layer4_col2[13]    = O0_c413_341_l3_f8;
    assign layer4_col3[18:15] = O1_c413_341_l3_f8;
    assign layer4_col4[14:12] = O2_c413_341_l3_f8;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f8_inst0 (
        .COUTB(COUT_LA_l3_f8[0]),
        .COUTD(COUT_LA_l3_f8[1]),
        .COUTF(COUT_LA_l3_f8[2]),
        .COUTH(COUT_LA_l3_f8[3]),
        .CIN  (CIN_LA_l3_f8    ),
        .CYA  (CY_LA_l3_f8[0]  ),
        .CYB  (CY_LA_l3_f8[1]  ),
        .CYC  (CY_LA_l3_f8[2]  ),
        .CYD  (CY_LA_l3_f8[3]  ),
        .CYE  (CY_LA_l3_f8[4]  ),
        .CYF  (CY_LA_l3_f8[5]  ),
        .CYG  (CY_LA_l3_f8[6]  ),
        .CYH  (CY_LA_l3_f8[7]  ),
        .PROPA(PROP_LA_l3_f8[0]),
        .PROPB(PROP_LA_l3_f8[1]),
        .PROPC(PROP_LA_l3_f8[2]),
        .PROPD(PROP_LA_l3_f8[3]),
        .PROPE(PROP_LA_l3_f8[4]),
        .PROPF(PROP_LA_l3_f8[5]),
        .PROPG(PROP_LA_l3_f8[6]),
        .PROPH(PROP_LA_l3_f8[7]));

    assign CLA_c413_341_l3_f8[0] = COUT_LA_l3_f8[0];
    assign CLA_c413_341_l3_f8[1] = COUT_LA_l3_f8[2];
    assign CIN_LA_l3_f8          = C0_c413_341_l3_f8[8];
    assign CY_LA_l3_f8[2:0]      = CY0_c413_341_l3_f8;
    assign CY_LA_l3_f8[6:4]      = CY1_c413_341_l3_f8;
    assign PROP_LA_l3_f8[2:0]    = PROP0_c413_341_l3_f8;
    assign PROP_LA_l3_f8[6:4]    = PROP1_c413_341_l3_f8;
    assign PROP_LA_l3_f8[3]      = 1'b0;
    assign CY_LA_l3_f8[3]        = 1'b0;
    
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

    assign CY_LA_l3_floating_placement[1:0]   = CY_c9_41_l3_f3;
    assign PROP_LA_l3_floating_placement[1:0] = PROP_c9_41_l3_f3;
    assign CIN_LA_l3_floating_placement    = C0_c9_41_l3_f3[8];
    
    assign CY_LA_l3_floating_placement[3:2]   = CY_c9_41_l3_f4;
    assign PROP_LA_l3_floating_placement[3:2] = PROP_c9_41_l3_f4;
    
    assign CY_LA_l3_floating_placement[5:4]   = CY_c15_3_l3_f5;
    assign PROP_LA_l3_floating_placement[5:4] = PROP_c15_3_l3_f5;
    
    assign CY_LA_l3_floating_placement[7:6]   = CY_c15_3_l3_f7;
    assign PROP_LA_l3_floating_placement[7:6] = PROP_c15_3_l3_f7;
    
    always_ff @(posedge clk) begin
        layer4_col0[4] <= layer3_col0[36];
        layer4_col0[5] <= layer3_col0[37];
        layer4_col0[6] <= layer3_col0[38];
        layer4_col0[7] <= layer3_col0[39];
        layer4_col0[8] <= layer3_col0[40];
        layer4_col0[9] <= layer3_col0[41];
        layer4_col0[10] <= layer3_col0[42];
        layer4_col0[11] <= layer3_col0[43];
        layer4_col0[12] <= layer3_col0[44];
        layer4_col0[13] <= layer3_col0[45];
        layer4_col0[14] <= layer3_col0[46];
        layer4_col0[15] <= layer3_col0[47];
        layer4_col0[16] <= layer3_col0[48];
        layer4_col0[17] <= layer3_col0[49];
        layer4_col0[18] <= layer3_col0[50];
        layer4_col0[19] <= layer3_col0[51];
        layer4_col0[20] <= layer3_col0[52];
        layer4_col0[21] <= layer3_col0[53];
        layer4_col0[22] <= layer3_col0[54];
        layer4_col0[23] <= layer3_col0[55];
        layer4_col0[24] <= layer3_col0[56];
        layer4_col0[25] <= layer3_col0[57];
        layer4_col0[26] <= layer3_col0[58];
        layer4_col0[27] <= layer3_col0[59];
        layer4_col0[28] <= layer3_col0[60];
        layer4_col0[29] <= layer3_col0[61];
        layer4_col0[30] <= layer3_col0[62];
        layer4_col0[31] <= layer3_col0[63];
        layer4_col2[14] <= layer3_col2[52];
        layer4_col2[15] <= layer3_col2[53];
    end
    
    // ------------------------------ LAYER 4 ------------------------------
    // GPC0 in layer4: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l4_f0(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l4_f0   ),
        .C1   (C1_c517_451_l4_f0   ),
        .CLA  (CLA_c517_451_l4_f0  ),
        .O0   (O0_c517_451_l4_f0   ),
        .O1   (O1_c517_451_l4_f0   ),
        .O2   (O2_c517_451_l4_f0   ),
        .CY0  (CY0_c517_451_l4_f0  ),
        .PROP0(PROP0_c517_451_l4_f0),
        .CY1  (CY1_c517_451_l4_f0  ),
        .PROP1(PROP1_c517_451_l4_f0));
    
    assign C0_c517_451_l4_f0 = layer4_col0[16:0];
    assign C1_c517_451_l4_f0 = layer4_col1[4:0];
    
    assign layer5_col0[0]   = O0_c517_451_l4_f0;
    assign layer5_col1[4:0] = O1_c517_451_l4_f0;
    assign layer5_col2[3:0] = O2_c517_451_l4_f0;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l4_f0_inst0 (
        .COUTB(COUT_LA_l4_f0[0]),
        .COUTD(COUT_LA_l4_f0[1]),
        .COUTF(COUT_LA_l4_f0[2]),
        .COUTH(COUT_LA_l4_f0[3]),
        .CIN  (CIN_LA_l4_f0    ),
        .CYA  (CY_LA_l4_f0[0]  ),
        .CYB  (CY_LA_l4_f0[1]  ),
        .CYC  (CY_LA_l4_f0[2]  ),
        .CYD  (CY_LA_l4_f0[3]  ),
        .CYE  (CY_LA_l4_f0[4]  ),
        .CYF  (CY_LA_l4_f0[5]  ),
        .CYG  (CY_LA_l4_f0[6]  ),
        .CYH  (CY_LA_l4_f0[7]  ),
        .PROPA(PROP_LA_l4_f0[0]),
        .PROPB(PROP_LA_l4_f0[1]),
        .PROPC(PROP_LA_l4_f0[2]),
        .PROPD(PROP_LA_l4_f0[3]),
        .PROPE(PROP_LA_l4_f0[4]),
        .PROPF(PROP_LA_l4_f0[5]),
        .PROPG(PROP_LA_l4_f0[6]),
        .PROPH(PROP_LA_l4_f0[7]));

    assign CLA_c517_451_l4_f0[0] = COUT_LA_l4_f0[0];
    assign CLA_c517_451_l4_f0[1] = COUT_LA_l4_f0[2];
    assign CIN_LA_l4_f0          = C0_c517_451_l4_f0[8];
    assign CY_LA_l4_f0[3:0]      = CY0_c517_451_l4_f0;
    assign CY_LA_l4_f0[7:4]      = CY1_c517_451_l4_f0;
    assign PROP_LA_l4_f0[3:0]    = PROP0_c517_451_l4_f0;
    assign PROP_LA_l4_f0[7:4]    = PROP1_c517_451_l4_f0;
    
    // GPC1 in layer4: (1,5 : 3] at column 1
    
    c15_3 #(.OUTREG("TRUE" ),
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
    
    assign C0_c15_3_l4_f1 = layer4_col1[9:5];
    assign C1_c15_3_l4_f1 = layer4_col2[0];
    
    assign layer5_col1[5] = O_c15_3_l4_f1[0];
    assign layer5_col2[4] = O_c15_3_l4_f1[1];
    assign layer5_col3[0] = O_c15_3_l4_f1[2];
    
    // GPC2 in layer4: (5,17 : 4,5,1) at column 3
    
    c517_451 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c517_451_l4_f2(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l4_f2   ),
        .C1   (C1_c517_451_l4_f2   ),
        .CLA  (CLA_c517_451_l4_f2  ),
        .O0   (O0_c517_451_l4_f2   ),
        .O1   (O1_c517_451_l4_f2   ),
        .O2   (O2_c517_451_l4_f2   ),
        .CY0  (CY0_c517_451_l4_f2  ),
        .PROP0(PROP0_c517_451_l4_f2),
        .CY1  (CY1_c517_451_l4_f2  ),
        .PROP1(PROP1_c517_451_l4_f2));
    
    assign C0_c517_451_l4_f2 = layer4_col3[16:0];
    assign C1_c517_451_l4_f2 = layer4_col4[4:0];
    
    assign layer5_col3[1]   = O0_c517_451_l4_f2;
    assign layer5_col4[4:0] = O1_c517_451_l4_f2;
    assign layer5_col5[3:0] = O2_c517_451_l4_f2;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l4_f2_inst0 (
        .COUTB(COUT_LA_l4_f2[0]),
        .COUTD(COUT_LA_l4_f2[1]),
        .COUTF(COUT_LA_l4_f2[2]),
        .COUTH(COUT_LA_l4_f2[3]),
        .CIN  (CIN_LA_l4_f2    ),
        .CYA  (CY_LA_l4_f2[0]  ),
        .CYB  (CY_LA_l4_f2[1]  ),
        .CYC  (CY_LA_l4_f2[2]  ),
        .CYD  (CY_LA_l4_f2[3]  ),
        .CYE  (CY_LA_l4_f2[4]  ),
        .CYF  (CY_LA_l4_f2[5]  ),
        .CYG  (CY_LA_l4_f2[6]  ),
        .CYH  (CY_LA_l4_f2[7]  ),
        .PROPA(PROP_LA_l4_f2[0]),
        .PROPB(PROP_LA_l4_f2[1]),
        .PROPC(PROP_LA_l4_f2[2]),
        .PROPD(PROP_LA_l4_f2[3]),
        .PROPE(PROP_LA_l4_f2[4]),
        .PROPF(PROP_LA_l4_f2[5]),
        .PROPG(PROP_LA_l4_f2[6]),
        .PROPH(PROP_LA_l4_f2[7]));

    assign CLA_c517_451_l4_f2[0] = COUT_LA_l4_f2[0];
    assign CLA_c517_451_l4_f2[1] = COUT_LA_l4_f2[2];
    assign CIN_LA_l4_f2          = C0_c517_451_l4_f2[8];
    assign CY_LA_l4_f2[3:0]      = CY0_c517_451_l4_f2;
    assign CY_LA_l4_f2[7:4]      = CY1_c517_451_l4_f2;
    assign PROP_LA_l4_f2[3:0]    = PROP0_c517_451_l4_f2;
    assign PROP_LA_l4_f2[7:4]    = PROP1_c517_451_l4_f2;
    
    // GPC3 in layer4: (9 : 4,1) at column 4
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l4_f3(
        .clk (clk             ),
        .C0  (C0_c9_41_l4_f3  ),
        .CLA (CLA_c9_41_l4_f3 ),
        .O0  (O0_c9_41_l4_f3  ),
        .O1  (O1_c9_41_l4_f3  ),
        .CY  (CY_c9_41_l4_f3  ),
        .PROP(PROP_c9_41_l4_f3));
    
    assign C0_c9_41_l4_f3 = layer4_col4[13:5];
    
    assign layer5_col4[5]   = O0_c9_41_l4_f3;
    assign layer5_col5[7:4] = O1_c9_41_l4_f3;
    
    // GPC chain0 in layer4:
    // -- (1,5 : 3] at column 0
    // -- (9 : 4,1) at column 2
    
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

    c15_3 #(.OUTREG("TRUE" ),
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
    
    assign C0_c15_3_l4_c0_i0 = layer4_col0[21:17];
    assign C1_c15_3_l4_c0_i0 = layer4_col1[10];
    
    assign layer5_col0[1] = O_c15_3_l4_c0_i0[0];
    assign layer5_col1[6] = O_c15_3_l4_c0_i0[1];
    
    assign l4_c0_i0              = COUT_LA_l4_c0_s0[0];
    assign CY_LA_l4_c0_s0[1:0]   = CY_c15_3_l4_c0_i0;
    assign PROP_LA_l4_c0_s0[1:0] = PROP_c15_3_l4_c0_i0;
    
    assign CIN_LA_l4_c0_s0    = C0_c15_3_l4_c0_i0[4];
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l4_c0_i1(
        .clk (clk                ),
        .C0  (C0_c9_41_l4_c0_i1  ),
        .CLA (CLA_c9_41_l4_c0_i1 ),
        .O0  (O0_c9_41_l4_c0_i1  ),
        .O1  (O1_c9_41_l4_c0_i1  ),
        .CY  (CY_c9_41_l4_c0_i1  ),
        .PROP(PROP_c9_41_l4_c0_i1));
    
    assign C0_c9_41_l4_c0_i1 = {l4_c0_i0, layer4_col2[8:1]};
    
    assign layer5_col2[5]   = O0_c9_41_l4_c0_i1;
    assign layer5_col3[5:2] = O1_c9_41_l4_c0_i1;
    
    assign l4_c0_i1              = COUT_LA_l4_c0_s0[1];
    assign CY_LA_l4_c0_s0[3:2]   = CY_c9_41_l4_c0_i1;
    assign PROP_LA_l4_c0_s0[3:2] = PROP_c9_41_l4_c0_i1;
    
    // GPC4 in layer4: (1,5 : 3] at column 2
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l4_f4(
        .clk (clk             ),
        .C0  (C0_c15_3_l4_f4  ),
        .C1  (C1_c15_3_l4_f4  ),
        .CLA (CLA_c15_3_l4_f4 ),
        .O   (O_c15_3_l4_f4   ),
        .CY  (CY_c15_3_l4_f4  ),
        .PROP(PROP_c15_3_l4_f4));
    
    assign C0_c15_3_l4_f4 = layer4_col2[13:9];
    assign C1_c15_3_l4_f4 = layer4_col3[17];
    
    assign layer5_col2[6] = O_c15_3_l4_f4[0];
    assign layer5_col3[6] = O_c15_3_l4_f4[1];
    assign layer5_col4[6] = O_c15_3_l4_f4[2];
    
    // GPC5 in layer4: (1,5 : 3] at column 0
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l4_f5(
        .clk (clk             ),
        .C0  (C0_c15_3_l4_f5  ),
        .C1  (C1_c15_3_l4_f5  ),
        .CLA (CLA_c15_3_l4_f5 ),
        .O   (O_c15_3_l4_f5   ),
        .CY  (CY_c15_3_l4_f5  ),
        .PROP(PROP_c15_3_l4_f5));
    
    assign C0_c15_3_l4_f5 = layer4_col0[26:22];
    assign C1_c15_3_l4_f5 = layer4_col1[11];
    
    assign layer5_col0[2] = O_c15_3_l4_f5[0];
    assign layer5_col1[7] = O_c15_3_l4_f5[1];
    assign layer5_col2[7] = O_c15_3_l4_f5[2];
    
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
    
    assign CY_LA_l4_floating_placement[3:2]   = CY_c9_41_l4_f3;
    assign PROP_LA_l4_floating_placement[3:2] = PROP_c9_41_l4_f3;
    
    assign CY_LA_l4_floating_placement[5:4]   = CY_c15_3_l4_f4;
    assign PROP_LA_l4_floating_placement[5:4] = PROP_c15_3_l4_f4;
    
    assign CY_LA_l4_floating_placement[7:6]   = CY_c15_3_l4_f5;
    assign PROP_LA_l4_floating_placement[7:6] = PROP_c15_3_l4_f5;
    
    always_ff @(posedge clk) begin
        layer5_col0[3] <= layer4_col0[27];
        layer5_col0[4] <= layer4_col0[28];
        layer5_col0[5] <= layer4_col0[29];
        layer5_col0[6] <= layer4_col0[30];
        layer5_col0[7] <= layer4_col0[31];
        layer5_col2[8] <= layer4_col2[14];
        layer5_col2[9] <= layer4_col2[15];
        layer5_col3[7] <= layer4_col3[18];
        layer5_col4[7] <= layer4_col4[14];
    end
    
    // ------------------------------ LAYER 5 ------------------------------
    // GPC chain0 in layer5:
    // -- (1,5 : 3] at column 0
    // -- (1,5 : 3] at column 2
    // -- (1,5 : 3] at column 4
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
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

    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l5_c0_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l5_c0_i0  ),
        .C1  (C1_c15_3_l5_c0_i0  ),
        .CLA (CLA_c15_3_l5_c0_i0 ),
        .O   (O_c15_3_l5_c0_i0   ),
        .CY  (CY_c15_3_l5_c0_i0  ),
        .PROP(PROP_c15_3_l5_c0_i0));
    
    assign C0_c15_3_l5_c0_i0 = layer5_col0[4:0];
    assign C1_c15_3_l5_c0_i0 = layer5_col1[0];
    
    assign layer6_col0[0] = O_c15_3_l5_c0_i0[0];
    assign layer6_col1[0] = O_c15_3_l5_c0_i0[1];
    
    assign l5_c0_i0              = COUT_LA_l5_c0_s0[0];
    assign CY_LA_l5_c0_s0[1:0]   = CY_c15_3_l5_c0_i0;
    assign PROP_LA_l5_c0_s0[1:0] = PROP_c15_3_l5_c0_i0;
    
    assign CIN_LA_l5_c0_s0    = C0_c15_3_l5_c0_i0[4];
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l5_c0_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l5_c0_i1  ),
        .C1  (C1_c15_3_l5_c0_i1  ),
        .CLA (CLA_c15_3_l5_c0_i1 ),
        .O   (O_c15_3_l5_c0_i1   ),
        .CY  (CY_c15_3_l5_c0_i1  ),
        .PROP(PROP_c15_3_l5_c0_i1));
    
    assign C0_c15_3_l5_c0_i1 = {l5_c0_i0, layer5_col2[3:0]};
    assign C1_c15_3_l5_c0_i1 = layer5_col3[0];
    
    assign layer6_col2[0] = O_c15_3_l5_c0_i1[0];
    assign layer6_col3[0] = O_c15_3_l5_c0_i1[1];
    
    assign l5_c0_i1              = COUT_LA_l5_c0_s0[1];
    assign CY_LA_l5_c0_s0[3:2]   = CY_c15_3_l5_c0_i1;
    assign PROP_LA_l5_c0_s0[3:2] = PROP_c15_3_l5_c0_i1;
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l5_c0_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l5_c0_i2  ),
        .C1  (C1_c15_3_l5_c0_i2  ),
        .CLA (CLA_c15_3_l5_c0_i2 ),
        .O   (O_c15_3_l5_c0_i2   ),
        .CY  (CY_c15_3_l5_c0_i2  ),
        .PROP(PROP_c15_3_l5_c0_i2));
    
    assign C0_c15_3_l5_c0_i2 = {l5_c0_i1, layer5_col4[3:0]};
    assign C1_c15_3_l5_c0_i2 = layer5_col5[0];
    
    assign layer6_col4[0] = O_c15_3_l5_c0_i2[0];
    assign layer6_col5[0] = O_c15_3_l5_c0_i2[1];
    assign layer6_col6[0] = O_c15_3_l5_c0_i2[2];
    
    assign l5_c0_i2              = COUT_LA_l5_c0_s0[2];
    assign CY_LA_l5_c0_s0[5:4]   = CY_c15_3_l5_c0_i2;
    assign PROP_LA_l5_c0_s0[5:4] = PROP_c15_3_l5_c0_i2;
    
    // GPC chain1 in layer5:
    // -- (1,5 : 3] at column 1
    // -- (1,5 : 3] at column 3
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l5_c1_s0_inst0 (
        .COUTB(COUT_LA_l5_c1_s0[0]),
        .COUTD(COUT_LA_l5_c1_s0[1]),
        .COUTF(COUT_LA_l5_c1_s0[2]),
        .COUTH(COUT_LA_l5_c1_s0[3]),
        .CIN  (CIN_LA_l5_c1_s0    ),
        .CYA  (CY_LA_l5_c1_s0[0]  ),
        .CYB  (CY_LA_l5_c1_s0[1]  ),
        .CYC  (CY_LA_l5_c1_s0[2]  ),
        .CYD  (CY_LA_l5_c1_s0[3]  ),
        .CYE  (CY_LA_l5_c1_s0[4]  ),
        .CYF  (CY_LA_l5_c1_s0[5]  ),
        .CYG  (CY_LA_l5_c1_s0[6]  ),
        .CYH  (CY_LA_l5_c1_s0[7]  ),
        .PROPA(PROP_LA_l5_c1_s0[0]),
        .PROPB(PROP_LA_l5_c1_s0[1]),
        .PROPC(PROP_LA_l5_c1_s0[2]),
        .PROPD(PROP_LA_l5_c1_s0[3]),
        .PROPE(PROP_LA_l5_c1_s0[4]),
        .PROPF(PROP_LA_l5_c1_s0[5]),
        .PROPG(PROP_LA_l5_c1_s0[6]),
        .PROPH(PROP_LA_l5_c1_s0[7]));

    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l5_c1_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l5_c1_i0  ),
        .C1  (C1_c15_3_l5_c1_i0  ),
        .CLA (CLA_c15_3_l5_c1_i0 ),
        .O   (O_c15_3_l5_c1_i0   ),
        .CY  (CY_c15_3_l5_c1_i0  ),
        .PROP(PROP_c15_3_l5_c1_i0));
    
    assign C0_c15_3_l5_c1_i0 = layer5_col1[5:1];
    assign C1_c15_3_l5_c1_i0 = layer5_col2[4];
    
    assign layer6_col1[1] = O_c15_3_l5_c1_i0[0];
    assign layer6_col2[1] = O_c15_3_l5_c1_i0[1];
    
    assign l5_c1_i0              = COUT_LA_l5_c1_s0[0];
    assign CY_LA_l5_c1_s0[1:0]   = CY_c15_3_l5_c1_i0;
    assign PROP_LA_l5_c1_s0[1:0] = PROP_c15_3_l5_c1_i0;
    
    assign CIN_LA_l5_c1_s0    = C0_c15_3_l5_c1_i0[4];
    
    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l5_c1_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l5_c1_i1  ),
        .C1  (C1_c15_3_l5_c1_i1  ),
        .CLA (CLA_c15_3_l5_c1_i1 ),
        .O   (O_c15_3_l5_c1_i1   ),
        .CY  (CY_c15_3_l5_c1_i1  ),
        .PROP(PROP_c15_3_l5_c1_i1));
    
    assign C0_c15_3_l5_c1_i1 = {l5_c1_i0, layer5_col3[4:1]};
    assign C1_c15_3_l5_c1_i1 = layer5_col4[4];
    
    assign layer6_col3[1] = O_c15_3_l5_c1_i1[0];
    assign layer6_col4[1] = O_c15_3_l5_c1_i1[1];
    assign layer6_col5[1] = O_c15_3_l5_c1_i1[2];
    
    assign l5_c1_i1              = COUT_LA_l5_c1_s0[1];
    assign CY_LA_l5_c1_s0[3:2]   = CY_c15_3_l5_c1_i1;
    assign PROP_LA_l5_c1_s0[3:2] = PROP_c15_3_l5_c1_i1;
    
    // GPC0 in layer5: (6 : 3] at column 5
    
    c6_3 #(.OUTREG("TRUE" ),
           .LEAVEC("FALSE"))
    c6_3_l5_f0(
        .clk (clk          ),
        .C0  (C0_c6_3_l5_f0),
        .O   (O_c6_3_l5_f0 ));
    
    assign C0_c6_3_l5_f0 = layer5_col5[6:1];
    
    assign layer6_col5[2] = O_c6_3_l5_f0[0];
    assign layer6_col6[1] = O_c6_3_l5_f0[1];
    assign layer6_col7    = O_c6_3_l5_f0[2];
    // GPC chain2 in layer5:
    // -- (1,5 : 3] at column 2
    // -- (3 : 2] at column 4
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l5_c2_s0_inst0 (
        .COUTB(COUT_LA_l5_c2_s0[0]),
        .COUTD(COUT_LA_l5_c2_s0[1]),
        .COUTF(COUT_LA_l5_c2_s0[2]),
        .COUTH(COUT_LA_l5_c2_s0[3]),
        .CIN  (CIN_LA_l5_c2_s0    ),
        .CYA  (CY_LA_l5_c2_s0[0]  ),
        .CYB  (CY_LA_l5_c2_s0[1]  ),
        .CYC  (CY_LA_l5_c2_s0[2]  ),
        .CYD  (CY_LA_l5_c2_s0[3]  ),
        .CYE  (CY_LA_l5_c2_s0[4]  ),
        .CYF  (CY_LA_l5_c2_s0[5]  ),
        .CYG  (CY_LA_l5_c2_s0[6]  ),
        .CYH  (CY_LA_l5_c2_s0[7]  ),
        .PROPA(PROP_LA_l5_c2_s0[0]),
        .PROPB(PROP_LA_l5_c2_s0[1]),
        .PROPC(PROP_LA_l5_c2_s0[2]),
        .PROPD(PROP_LA_l5_c2_s0[3]),
        .PROPE(PROP_LA_l5_c2_s0[4]),
        .PROPF(PROP_LA_l5_c2_s0[5]),
        .PROPG(PROP_LA_l5_c2_s0[6]),
        .PROPH(PROP_LA_l5_c2_s0[7]));

    c15_3 #(.OUTREG("TRUE" ),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l5_c2_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l5_c2_i0  ),
        .C1  (C1_c15_3_l5_c2_i0  ),
        .CLA (CLA_c15_3_l5_c2_i0 ),
        .O   (O_c15_3_l5_c2_i0   ),
        .CY  (CY_c15_3_l5_c2_i0  ),
        .PROP(PROP_c15_3_l5_c2_i0));
    
    assign C0_c15_3_l5_c2_i0 = layer5_col2[9:5];
    assign C1_c15_3_l5_c2_i0 = layer5_col3[5];
    
    assign layer6_col2[2] = O_c15_3_l5_c2_i0[0];
    assign layer6_col3[2] = O_c15_3_l5_c2_i0[1];
    
    assign l5_c2_i0              = COUT_LA_l5_c2_s0[0];
    assign CY_LA_l5_c2_s0[1:0]   = CY_c15_3_l5_c2_i0;
    assign PROP_LA_l5_c2_s0[1:0] = PROP_c15_3_l5_c2_i0;
    
    assign CIN_LA_l5_c2_s0    = C0_c15_3_l5_c2_i0[4];
    
    c3_2 #(.OUTREG("TRUE" ),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l5_c2_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l5_c2_i1  ),
        .O   (O_c3_2_l5_c2_i1   ),
        .CY  (CY_c3_2_l5_c2_i1  ),
        .PROP(PROP_c3_2_l5_c2_i1));
    
    assign C0_c3_2_l5_c2_i1 = {l5_c2_i0, layer5_col4[6:5]};
    
    assign layer6_col4[2] = O_c3_2_l5_c2_i1[0];
    assign layer6_col5[3] = O_c3_2_l5_c2_i1[1];
    
    assign l5_c2_i1            = O_c3_2_l5_c2_i1[1];
    assign CY_LA_l5_c2_s0[2]   = CY_c3_2_l5_c2_i1;
    assign PROP_LA_l5_c2_s0[2] = PROP_c3_2_l5_c2_i1;
    
    always_ff @(posedge clk) begin
        layer6_col0[1] <= layer5_col0[5];
        layer6_col0[2] <= layer5_col0[6];
        layer6_col0[3] <= layer5_col0[7];
        layer6_col1[2] <= layer5_col1[6];
        layer6_col1[3] <= layer5_col1[7];
        layer6_col3[3] <= layer5_col3[6];
        layer6_col3[4] <= layer5_col3[7];
        layer6_col4[3] <= layer5_col4[7];
        layer6_col5[4] <= layer5_col5[7];
    end
    
    // ------------------------------ LAYER 6 ------------------------------
    // GPC0 in layer6: (2,2,3 : 4] at column 3
    
    c223_4 #(.OUTREG("TRUE" ),
             .LEAVEC("FALSE"),
             .POSODD("FALSE"))
    c223_4_l6_f0(
        .clk (clk              ),
        .C0  (C0_c223_4_l6_f0  ),
        .C1  (C1_c223_4_l6_f0  ),
        .C2  (C2_c223_4_l6_f0  ),
        .CLA (CLA_c223_4_l6_f0 ),
        .O   (O_c223_4_l6_f0   ),
        .CY  (CY_c223_4_l6_f0  ),
        .PROP(PROP_c223_4_l6_f0));
    
    assign C0_c223_4_l6_f0 = layer6_col3[2:0];
    assign C1_c223_4_l6_f0 = layer6_col4[1:0];
    assign C2_c223_4_l6_f0 = layer6_col5[1:0];
    
    assign layer7_col3[0] = O_c223_4_l6_f0[0];
    assign layer7_col4[0] = O_c223_4_l6_f0[1];
    assign layer7_col5[0] = O_c223_4_l6_f0[2];
    assign layer7_col6[0] = O_c223_4_l6_f0[3];
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l6_floating_placement_inst0 (
        .COUTB(COUT_LA_l6_floating_placement[0]),
        .COUTD(COUT_LA_l6_floating_placement[1]),
        .COUTF(COUT_LA_l6_floating_placement[2]),
        .COUTH(COUT_LA_l6_floating_placement[3]),
        .CIN  (CIN_LA_l6_floating_placement    ),
        .CYA  (CY_LA_l6_floating_placement[0]  ),
        .CYB  (CY_LA_l6_floating_placement[1]  ),
        .CYC  (CY_LA_l6_floating_placement[2]  ),
        .CYD  (CY_LA_l6_floating_placement[3]  ),
        .CYE  (CY_LA_l6_floating_placement[4]  ),
        .CYF  (CY_LA_l6_floating_placement[5]  ),
        .CYG  (CY_LA_l6_floating_placement[6]  ),
        .CYH  (CY_LA_l6_floating_placement[7]  ),
        .PROPA(PROP_LA_l6_floating_placement[0]),
        .PROPB(PROP_LA_l6_floating_placement[1]),
        .PROPC(PROP_LA_l6_floating_placement[2]),
        .PROPD(PROP_LA_l6_floating_placement[3]),
        .PROPE(PROP_LA_l6_floating_placement[4]),
        .PROPF(PROP_LA_l6_floating_placement[5]),
        .PROPG(PROP_LA_l6_floating_placement[6]),
        .PROPH(PROP_LA_l6_floating_placement[7]));

    assign CY_LA_l6_floating_placement[1:0]   = CY_c223_4_l6_f0;
    assign PROP_LA_l6_floating_placement[1:0] = PROP_c223_4_l6_f0;
    assign CIN_LA_l6_floating_placement    = C0_c223_4_l6_f0[2];
    
    always_ff @(posedge clk) begin
        layer7_col0[0] <= layer6_col0[0];
        layer7_col0[1] <= layer6_col0[1];
        layer7_col0[2] <= layer6_col0[2];
        layer7_col0[3] <= layer6_col0[3];
        layer7_col1[0] <= layer6_col1[0];
        layer7_col1[1] <= layer6_col1[1];
        layer7_col1[2] <= layer6_col1[2];
        layer7_col1[3] <= layer6_col1[3];
        layer7_col2[0] <= layer6_col2[0];
        layer7_col2[1] <= layer6_col2[1];
        layer7_col2[2] <= layer6_col2[2];
        layer7_col3[1] <= layer6_col3[3];
        layer7_col3[2] <= layer6_col3[4];
        layer7_col4[1] <= layer6_col4[2];
        layer7_col4[2] <= layer6_col4[3];
        layer7_col5[1] <= layer6_col5[2];
        layer7_col5[2] <= layer6_col5[3];
        layer7_col5[3] <= layer6_col5[4];
        layer7_col6[1] <= layer6_col6[0];
        layer7_col6[2] <= layer6_col6[1];
        layer7_col7    <= layer6_col7;
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
    assign C0_c15_3_terminal_chain1_i0[1] = layer7_col0[0];
    assign C0_c15_3_terminal_chain1_i0[2] = layer7_col0[1];
    assign C0_c15_3_terminal_chain1_i0[3] = layer7_col0[2];
    assign C0_c15_3_terminal_chain1_i0[4] = layer7_col0[3];
    assign C1_c15_3_terminal_chain1_i0    = layer7_col1[0];
    
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
    assign C0_c15_3_terminal_chain1_i1[1] = layer7_col2[0];
    assign C0_c15_3_terminal_chain1_i1[2] = layer7_col2[1];
    assign C0_c15_3_terminal_chain1_i1[3] = layer7_col2[2];
    assign C1_c15_3_terminal_chain1_i1    = layer7_col3[0];
    
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer7_col4[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer7_col4[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer7_col4[2];
    assign C1_c15_3_terminal_chain1_i2    = layer7_col5[0];
    
    assign terminal_chain1_out[4] = O_c15_3_terminal_chain1_i2[0];
    assign terminal_chain1_out[5] = O_c15_3_terminal_chain1_i2[1];
    
    assign terminal_chain1_i2           = COUT_LA_terminal_chain1[2];
    assign CY_LA_terminal_chain1[5:4]   = CY_c15_3_terminal_chain1_i2;
    assign PROP_LA_terminal_chain1[5:4] = PROP_c15_3_terminal_chain1_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_terminal_chain1_i3(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i3  ),
        .C1  (C1_c15_3_terminal_chain1_i3  ),
        .CLA (CLA_c15_3_terminal_chain1_i3 ),
        .O   (O_c15_3_terminal_chain1_i3   ),
        .CY  (CY_c15_3_terminal_chain1_i3  ),
        .PROP(PROP_c15_3_terminal_chain1_i3));
    
    assign C0_c15_3_terminal_chain1_i3[4] = terminal_chain1_i2;
    assign C0_c15_3_terminal_chain1_i3[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i3[1] = layer7_col6[0];
    assign C0_c15_3_terminal_chain1_i3[2] = layer7_col6[1];
    assign C0_c15_3_terminal_chain1_i3[3] = layer7_col6[2];
    assign C1_c15_3_terminal_chain1_i3    = layer7_col7;
    
    assign terminal_chain1_out[6] = O_c15_3_terminal_chain1_i3[0];
    assign terminal_chain1_out[7] = O_c15_3_terminal_chain1_i3[1];
    assign terminal_chain1_out[8] = O_c15_3_terminal_chain1_i3[2];
    
    assign terminal_chain1_i3           = COUT_LA_terminal_chain1[3];
    assign CY_LA_terminal_chain1[7:6]   = CY_c15_3_terminal_chain1_i3;
    assign PROP_LA_terminal_chain1[7:6] = PROP_c15_3_terminal_chain1_i3;
    
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
    assign C0_c15_3_terminal_chain2_i0[2] = layer7_col1[3];
    assign C0_c15_3_terminal_chain2_i0[1] = layer7_col1[2];
    assign C0_c15_3_terminal_chain2_i0[0] = layer7_col1[1];
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
    assign C0_c15_3_terminal_chain2_i1[1] = layer7_col3[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer7_col3[2];
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
    assign C0_c15_3_terminal_chain2_i2[0] = layer7_col5[1];
    assign C0_c15_3_terminal_chain2_i2[1] = layer7_col5[2];
    assign C0_c15_3_terminal_chain2_i2[2] = layer7_col5[3];
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
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i3(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i3  ),
        .O   (O_c3_2_terminal_chain2_i3   ),
        .CY  (CY_c3_2_terminal_chain2_i3  ),
        .PROP(PROP_c3_2_terminal_chain2_i3));
    
    assign C0_c3_2_terminal_chain2_i3[2] = terminal_chain2_i2;
    assign C0_c3_2_terminal_chain2_i3[0] = terminal_chain1_out[7];
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
    assign C0_c3_2_terminal_chain2_i4[0] = terminal_chain1_out[8];
    assign C0_c3_2_terminal_chain2_i4[1] = 1'b0;
    
    assign terminal_chain2_out[7] = O_c3_2_terminal_chain2_i4[0];
    assign terminal_chain2_out[8] = O_c3_2_terminal_chain2_i4[1];
    
    assign terminal_chain2_i4         = COUT_LA_terminal_chain2[3];
    assign CY_LA_terminal_chain2[7]   = CY_c3_2_terminal_chain2_i4;
    assign PROP_LA_terminal_chain2[7] = PROP_c3_2_terminal_chain2_i4;
    
    always_ff @(posedge clk) begin
        comp_out[0] <= terminal_chain1_out[0];
    
        comp_out[9:1] <= terminal_chain2_out[8:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = in_col0;
    
endmodule