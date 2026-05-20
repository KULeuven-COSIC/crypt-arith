`timescale 1ns / 1ps

module Comp_double256_2 (
    input  logic           clk,
    input  logic [255 : 0] in_col0,
    input  logic [255 : 0] in_col1,
    output logic [9   : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [255 : 0] layer0_col0;
    logic [255 : 0] layer0_col1;
    
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
    
    logic [16 : 0] C0_c517_451_l0_f13;
    logic [4  : 0] C1_c517_451_l0_f13;
    logic [1  : 0] CLA_c517_451_l0_f13;
    logic          O0_c517_451_l0_f13;
    logic [4  : 0] O1_c517_451_l0_f13;
    logic [3  : 0] O2_c517_451_l0_f13;
    logic [3  : 0] CY0_c517_451_l0_f13;
    logic [3  : 0] PROP0_c517_451_l0_f13;
    logic [3  : 0] CY1_c517_451_l0_f13;
    logic [3  : 0] PROP1_c517_451_l0_f13;
    
    logic [3 : 0] COUT_LA_l0_f13;
    logic         CIN_LA_l0_f13;
    logic [7 : 0] CY_LA_l0_f13;
    logic [7 : 0] PROP_LA_l0_f13;
    
    logic [16 : 0] C0_c517_451_l0_f14;
    logic [4  : 0] C1_c517_451_l0_f14;
    logic [1  : 0] CLA_c517_451_l0_f14;
    logic          O0_c517_451_l0_f14;
    logic [4  : 0] O1_c517_451_l0_f14;
    logic [3  : 0] O2_c517_451_l0_f14;
    logic [3  : 0] CY0_c517_451_l0_f14;
    logic [3  : 0] PROP0_c517_451_l0_f14;
    logic [3  : 0] CY1_c517_451_l0_f14;
    logic [3  : 0] PROP1_c517_451_l0_f14;
    
    logic [3 : 0] COUT_LA_l0_f14;
    logic         CIN_LA_l0_f14;
    logic [7 : 0] CY_LA_l0_f14;
    logic [7 : 0] PROP_LA_l0_f14;
    
    logic [16 : 0] C0_c517_451_l0_f15;
    logic [4  : 0] C1_c517_451_l0_f15;
    logic [1  : 0] CLA_c517_451_l0_f15;
    logic          O0_c517_451_l0_f15;
    logic [4  : 0] O1_c517_451_l0_f15;
    logic [3  : 0] O2_c517_451_l0_f15;
    logic [3  : 0] CY0_c517_451_l0_f15;
    logic [3  : 0] PROP0_c517_451_l0_f15;
    logic [3  : 0] CY1_c517_451_l0_f15;
    logic [3  : 0] PROP1_c517_451_l0_f15;
    
    logic [3 : 0] COUT_LA_l0_f15;
    logic         CIN_LA_l0_f15;
    logic [7 : 0] CY_LA_l0_f15;
    logic [7 : 0] PROP_LA_l0_f15;
    
    logic [16 : 0] C0_c517_451_l0_f16;
    logic [4  : 0] C1_c517_451_l0_f16;
    logic [1  : 0] CLA_c517_451_l0_f16;
    logic          O0_c517_451_l0_f16;
    logic [4  : 0] O1_c517_451_l0_f16;
    logic [3  : 0] O2_c517_451_l0_f16;
    logic [3  : 0] CY0_c517_451_l0_f16;
    logic [3  : 0] PROP0_c517_451_l0_f16;
    logic [3  : 0] CY1_c517_451_l0_f16;
    logic [3  : 0] PROP1_c517_451_l0_f16;
    
    logic [3 : 0] COUT_LA_l0_f16;
    logic         CIN_LA_l0_f16;
    logic [7 : 0] CY_LA_l0_f16;
    logic [7 : 0] PROP_LA_l0_f16;
    
    logic [16 : 0] C0_c517_451_l0_f17;
    logic [4  : 0] C1_c517_451_l0_f17;
    logic [1  : 0] CLA_c517_451_l0_f17;
    logic          O0_c517_451_l0_f17;
    logic [4  : 0] O1_c517_451_l0_f17;
    logic [3  : 0] O2_c517_451_l0_f17;
    logic [3  : 0] CY0_c517_451_l0_f17;
    logic [3  : 0] PROP0_c517_451_l0_f17;
    logic [3  : 0] CY1_c517_451_l0_f17;
    logic [3  : 0] PROP1_c517_451_l0_f17;
    
    logic [3 : 0] COUT_LA_l0_f17;
    logic         CIN_LA_l0_f17;
    logic [7 : 0] CY_LA_l0_f17;
    logic [7 : 0] PROP_LA_l0_f17;
    
    logic [16 : 0] C0_c517_451_l0_f18;
    logic [4  : 0] C1_c517_451_l0_f18;
    logic [1  : 0] CLA_c517_451_l0_f18;
    logic          O0_c517_451_l0_f18;
    logic [4  : 0] O1_c517_451_l0_f18;
    logic [3  : 0] O2_c517_451_l0_f18;
    logic [3  : 0] CY0_c517_451_l0_f18;
    logic [3  : 0] PROP0_c517_451_l0_f18;
    logic [3  : 0] CY1_c517_451_l0_f18;
    logic [3  : 0] PROP1_c517_451_l0_f18;
    
    logic [3 : 0] COUT_LA_l0_f18;
    logic         CIN_LA_l0_f18;
    logic [7 : 0] CY_LA_l0_f18;
    logic [7 : 0] PROP_LA_l0_f18;
    
    logic [16 : 0] C0_c517_451_l0_f19;
    logic [4  : 0] C1_c517_451_l0_f19;
    logic [1  : 0] CLA_c517_451_l0_f19;
    logic          O0_c517_451_l0_f19;
    logic [4  : 0] O1_c517_451_l0_f19;
    logic [3  : 0] O2_c517_451_l0_f19;
    logic [3  : 0] CY0_c517_451_l0_f19;
    logic [3  : 0] PROP0_c517_451_l0_f19;
    logic [3  : 0] CY1_c517_451_l0_f19;
    logic [3  : 0] PROP1_c517_451_l0_f19;
    
    logic [3 : 0] COUT_LA_l0_f19;
    logic         CIN_LA_l0_f19;
    logic [7 : 0] CY_LA_l0_f19;
    logic [7 : 0] PROP_LA_l0_f19;
    
    logic [16 : 0] C0_c517_451_l0_f20;
    logic [4  : 0] C1_c517_451_l0_f20;
    logic [1  : 0] CLA_c517_451_l0_f20;
    logic          O0_c517_451_l0_f20;
    logic [4  : 0] O1_c517_451_l0_f20;
    logic [3  : 0] O2_c517_451_l0_f20;
    logic [3  : 0] CY0_c517_451_l0_f20;
    logic [3  : 0] PROP0_c517_451_l0_f20;
    logic [3  : 0] CY1_c517_451_l0_f20;
    logic [3  : 0] PROP1_c517_451_l0_f20;
    
    logic [3 : 0] COUT_LA_l0_f20;
    logic         CIN_LA_l0_f20;
    logic [7 : 0] CY_LA_l0_f20;
    logic [7 : 0] PROP_LA_l0_f20;
    
    logic [16 : 0] C0_c517_451_l0_f21;
    logic [4  : 0] C1_c517_451_l0_f21;
    logic [1  : 0] CLA_c517_451_l0_f21;
    logic          O0_c517_451_l0_f21;
    logic [4  : 0] O1_c517_451_l0_f21;
    logic [3  : 0] O2_c517_451_l0_f21;
    logic [3  : 0] CY0_c517_451_l0_f21;
    logic [3  : 0] PROP0_c517_451_l0_f21;
    logic [3  : 0] CY1_c517_451_l0_f21;
    logic [3  : 0] PROP1_c517_451_l0_f21;
    
    logic [3 : 0] COUT_LA_l0_f21;
    logic         CIN_LA_l0_f21;
    logic [7 : 0] CY_LA_l0_f21;
    logic [7 : 0] PROP_LA_l0_f21;
    
    logic [16 : 0] C0_c517_451_l0_f22;
    logic [4  : 0] C1_c517_451_l0_f22;
    logic [1  : 0] CLA_c517_451_l0_f22;
    logic          O0_c517_451_l0_f22;
    logic [4  : 0] O1_c517_451_l0_f22;
    logic [3  : 0] O2_c517_451_l0_f22;
    logic [3  : 0] CY0_c517_451_l0_f22;
    logic [3  : 0] PROP0_c517_451_l0_f22;
    logic [3  : 0] CY1_c517_451_l0_f22;
    logic [3  : 0] PROP1_c517_451_l0_f22;
    
    logic [3 : 0] COUT_LA_l0_f22;
    logic         CIN_LA_l0_f22;
    logic [7 : 0] CY_LA_l0_f22;
    logic [7 : 0] PROP_LA_l0_f22;
    
    logic [16 : 0] C0_c517_451_l0_f23;
    logic [4  : 0] C1_c517_451_l0_f23;
    logic [1  : 0] CLA_c517_451_l0_f23;
    logic          O0_c517_451_l0_f23;
    logic [4  : 0] O1_c517_451_l0_f23;
    logic [3  : 0] O2_c517_451_l0_f23;
    logic [3  : 0] CY0_c517_451_l0_f23;
    logic [3  : 0] PROP0_c517_451_l0_f23;
    logic [3  : 0] CY1_c517_451_l0_f23;
    logic [3  : 0] PROP1_c517_451_l0_f23;
    
    logic [3 : 0] COUT_LA_l0_f23;
    logic         CIN_LA_l0_f23;
    logic [7 : 0] CY_LA_l0_f23;
    logic [7 : 0] PROP_LA_l0_f23;
    
    logic [16 : 0] C0_c517_451_l0_f24;
    logic [4  : 0] C1_c517_451_l0_f24;
    logic [1  : 0] CLA_c517_451_l0_f24;
    logic          O0_c517_451_l0_f24;
    logic [4  : 0] O1_c517_451_l0_f24;
    logic [3  : 0] O2_c517_451_l0_f24;
    logic [3  : 0] CY0_c517_451_l0_f24;
    logic [3  : 0] PROP0_c517_451_l0_f24;
    logic [3  : 0] CY1_c517_451_l0_f24;
    logic [3  : 0] PROP1_c517_451_l0_f24;
    
    logic [3 : 0] COUT_LA_l0_f24;
    logic         CIN_LA_l0_f24;
    logic [7 : 0] CY_LA_l0_f24;
    logic [7 : 0] PROP_LA_l0_f24;
    
    logic [16 : 0] C0_c517_451_l0_f25;
    logic [4  : 0] C1_c517_451_l0_f25;
    logic [1  : 0] CLA_c517_451_l0_f25;
    logic          O0_c517_451_l0_f25;
    logic [4  : 0] O1_c517_451_l0_f25;
    logic [3  : 0] O2_c517_451_l0_f25;
    logic [3  : 0] CY0_c517_451_l0_f25;
    logic [3  : 0] PROP0_c517_451_l0_f25;
    logic [3  : 0] CY1_c517_451_l0_f25;
    logic [3  : 0] PROP1_c517_451_l0_f25;
    
    logic [3 : 0] COUT_LA_l0_f25;
    logic         CIN_LA_l0_f25;
    logic [7 : 0] CY_LA_l0_f25;
    logic [7 : 0] PROP_LA_l0_f25;
    
    logic [16 : 0] C0_c517_451_l0_f26;
    logic [4  : 0] C1_c517_451_l0_f26;
    logic [1  : 0] CLA_c517_451_l0_f26;
    logic          O0_c517_451_l0_f26;
    logic [4  : 0] O1_c517_451_l0_f26;
    logic [3  : 0] O2_c517_451_l0_f26;
    logic [3  : 0] CY0_c517_451_l0_f26;
    logic [3  : 0] PROP0_c517_451_l0_f26;
    logic [3  : 0] CY1_c517_451_l0_f26;
    logic [3  : 0] PROP1_c517_451_l0_f26;
    
    logic [3 : 0] COUT_LA_l0_f26;
    logic         CIN_LA_l0_f26;
    logic [7 : 0] CY_LA_l0_f26;
    logic [7 : 0] PROP_LA_l0_f26;
    
    logic [11 : 0] COUT_LA_l0_floating_placement;
    logic [2  : 0] CIN_LA_l0_floating_placement;
    logic [23 : 0] CY_LA_l0_floating_placement;
    logic [23 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
    logic [15  : 0] layer1_col0;
    logic [159 : 0] layer1_col1;
    logic [107 : 0] layer1_col2;
    
    logic [12 : 0] C0_c413_341_l1_f0;
    logic [3  : 0] C1_c413_341_l1_f0;
    logic [1  : 0] CLA_c413_341_l1_f0;
    logic          O0_c413_341_l1_f0;
    logic [3  : 0] O1_c413_341_l1_f0;
    logic [2  : 0] O2_c413_341_l1_f0;
    logic [2  : 0] CY0_c413_341_l1_f0;
    logic [2  : 0] PROP0_c413_341_l1_f0;
    logic [2  : 0] CY1_c413_341_l1_f0;
    logic [2  : 0] PROP1_c413_341_l1_f0;
    
    logic [3 : 0] COUT_LA_l1_f0;
    logic         CIN_LA_l1_f0;
    logic [7 : 0] CY_LA_l1_f0;
    logic [7 : 0] PROP_LA_l1_f0;
    
    logic [16 : 0] C0_c517_451_l1_f1;
    logic [4  : 0] C1_c517_451_l1_f1;
    logic [1  : 0] CLA_c517_451_l1_f1;
    logic          O0_c517_451_l1_f1;
    logic [4  : 0] O1_c517_451_l1_f1;
    logic [3  : 0] O2_c517_451_l1_f1;
    logic [3  : 0] CY0_c517_451_l1_f1;
    logic [3  : 0] PROP0_c517_451_l1_f1;
    logic [3  : 0] CY1_c517_451_l1_f1;
    logic [3  : 0] PROP1_c517_451_l1_f1;
    
    logic [3 : 0] COUT_LA_l1_f1;
    logic         CIN_LA_l1_f1;
    logic [7 : 0] CY_LA_l1_f1;
    logic [7 : 0] PROP_LA_l1_f1;
    
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
    
    logic [8 : 0] C0_c9_41_l1_f5;
    logic         CLA_c9_41_l1_f5;
    logic         O0_c9_41_l1_f5;
    logic [3 : 0] O1_c9_41_l1_f5;
    logic [1 : 0] CY_c9_41_l1_f5;
    logic [1 : 0] PROP_c9_41_l1_f5;
    
    logic [8 : 0] C0_c9_41_l1_f6;
    logic         CLA_c9_41_l1_f6;
    logic         O0_c9_41_l1_f6;
    logic [3 : 0] O1_c9_41_l1_f6;
    logic [1 : 0] CY_c9_41_l1_f6;
    logic [1 : 0] PROP_c9_41_l1_f6;
    
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
    
    logic [7  : 0] COUT_LA_l1_floating_placement;
    logic [1  : 0] CIN_LA_l1_floating_placement;
    logic [15 : 0] CY_LA_l1_floating_placement;
    logic [15 : 0] PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [3  : 0] layer2_col0;
    logic [15 : 0] layer2_col1;
    logic [70 : 0] layer2_col2;
    logic [55 : 0] layer2_col3;
    
    logic [12 : 0] C0_c413_341_l2_f0;
    logic [3  : 0] C1_c413_341_l2_f0;
    logic [1  : 0] CLA_c413_341_l2_f0;
    logic          O0_c413_341_l2_f0;
    logic [3  : 0] O1_c413_341_l2_f0;
    logic [2  : 0] O2_c413_341_l2_f0;
    logic [2  : 0] CY0_c413_341_l2_f0;
    logic [2  : 0] PROP0_c413_341_l2_f0;
    logic [2  : 0] CY1_c413_341_l2_f0;
    logic [2  : 0] PROP1_c413_341_l2_f0;
    
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
    
    logic [12 : 0] C0_c413_341_l2_f7;
    logic [3  : 0] C1_c413_341_l2_f7;
    logic [1  : 0] CLA_c413_341_l2_f7;
    logic          O0_c413_341_l2_f7;
    logic [3  : 0] O1_c413_341_l2_f7;
    logic [2  : 0] O2_c413_341_l2_f7;
    logic [2  : 0] CY0_c413_341_l2_f7;
    logic [2  : 0] PROP0_c413_341_l2_f7;
    logic [2  : 0] CY1_c413_341_l2_f7;
    logic [2  : 0] PROP1_c413_341_l2_f7;
    
    logic [3 : 0] COUT_LA_l2_f7;
    logic         CIN_LA_l2_f7;
    logic [7 : 0] CY_LA_l2_f7;
    logic [7 : 0] PROP_LA_l2_f7;
    
    logic [3 : 0] COUT_LA_l2_floating_placement;
    logic         CIN_LA_l2_floating_placement;
    logic [7 : 0] CY_LA_l2_floating_placement;
    logic [7 : 0] PROP_LA_l2_floating_placement;
    
    // ------------------------------ LAYER 3 ------------------------------
    logic [3  : 0] layer3_col0;
    logic [3  : 0] layer3_col1;
    logic [10 : 0] layer3_col2;
    logic [34 : 0] layer3_col3;
    logic [26 : 0] layer3_col4;
    
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
    
    logic [8 : 0] C0_c9_41_l3_f0;
    logic         CLA_c9_41_l3_f0;
    logic         O0_c9_41_l3_f0;
    logic [3 : 0] O1_c9_41_l3_f0;
    logic [1 : 0] CY_c9_41_l3_f0;
    logic [1 : 0] PROP_c9_41_l3_f0;
    
    logic [4 : 0] C0_c15_3_l3_f1;
    logic         C1_c15_3_l3_f1;
    logic         CLA_c15_3_l3_f1;
    logic [2 : 0] O_c15_3_l3_f1;
    logic [1 : 0] CY_c15_3_l3_f1;
    logic [1 : 0] PROP_c15_3_l3_f1;
    
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
    
    logic [12 : 0] C0_c413_341_l3_f3;
    logic [3  : 0] C1_c413_341_l3_f3;
    logic [1  : 0] CLA_c413_341_l3_f3;
    logic          O0_c413_341_l3_f3;
    logic [3  : 0] O1_c413_341_l3_f3;
    logic [2  : 0] O2_c413_341_l3_f3;
    logic [2  : 0] CY0_c413_341_l3_f3;
    logic [2  : 0] PROP0_c413_341_l3_f3;
    logic [2  : 0] CY1_c413_341_l3_f3;
    logic [2  : 0] PROP1_c413_341_l3_f3;
    
    logic [3 : 0] COUT_LA_l3_f3;
    logic         CIN_LA_l3_f3;
    logic [7 : 0] CY_LA_l3_f3;
    logic [7 : 0] PROP_LA_l3_f3;
    
    logic [3 : 0] COUT_LA_l3_floating_placement;
    logic         CIN_LA_l3_floating_placement;
    logic [7 : 0] CY_LA_l3_floating_placement;
    logic [7 : 0] PROP_LA_l3_floating_placement;
    
    // ------------------------------ LAYER 4 ------------------------------
    logic [3  : 0] layer4_col0;
    logic [3  : 0] layer4_col1;
    logic [2  : 0] layer4_col2;
    logic [6  : 0] layer4_col3;
    logic [12 : 0] layer4_col4;
    logic [14 : 0] layer4_col5;
    
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
    
    logic [8 : 0] C0_c39_231_l4_f0;
    logic [2 : 0] C1_c39_231_l4_f0;
    logic         CLA_c39_231_l4_f0;
    logic         O0_c39_231_l4_f0;
    logic [2 : 0] O1_c39_231_l4_f0;
    logic [1 : 0] O2_c39_231_l4_f0;
    logic [1 : 0] CY0_c39_231_l4_f0;
    logic [1 : 0] CY1_c39_231_l4_f0;
    logic [1 : 0] PROP0_c39_231_l4_f0;
    logic [1 : 0] PROP1_c39_231_l4_f0;
    
    logic [2 : 0] C0_c3_2_l4_f1;
    logic [1 : 0] O_c3_2_l4_i1;
    logic         CY_c3_2_l4_f1;
    logic         PROP_c3_2_l4_f1;
    
    logic [3 : 0] COUT_LA_l4_floating_placement;
    logic         CIN_LA_l4_floating_placement;
    logic [7 : 0] CY_LA_l4_floating_placement;
    logic [7 : 0] PROP_LA_l4_floating_placement;
    
    // ------------------------------ LAYER 5 ------------------------------
    logic [3  : 0] layer5_col0;
    logic [3  : 0] layer5_col1;
    logic [2  : 0] layer5_col2;
    logic [2  : 0] layer5_col3;
    logic [2  : 0] layer5_col4;
    logic [8  : 0] layer5_col5;
    logic [5  : 0] layer5_col6;
    
    logic [4 : 0] C0_c15_3_l5_f0;
    logic         C1_c15_3_l5_f0;
    logic         CLA_c15_3_l5_f0;
    logic [2 : 0] O_c15_3_l5_f0;
    logic [1 : 0] CY_c15_3_l5_f0;
    logic [1 : 0] PROP_c15_3_l5_f0;
    
    logic [2 : 0] C0_c3_2_l5_f1;
    logic [1 : 0] O_c3_2_l5_i1;
    logic         CY_c3_2_l5_f1;
    logic         PROP_c3_2_l5_f1;
    
    logic [4 : 0] C0_c15_3_l5_f2;
    logic         C1_c15_3_l5_f2;
    logic         CLA_c15_3_l5_f2;
    logic [2 : 0] O_c15_3_l5_f2;
    logic [1 : 0] CY_c15_3_l5_f2;
    logic [1 : 0] PROP_c15_3_l5_f2;
    
    logic [3 : 0] COUT_LA_l5_floating_placement;
    logic         CIN_LA_l5_floating_placement;
    logic [7 : 0] CY_LA_l5_floating_placement;
    logic [7 : 0] PROP_LA_l5_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [3  : 0] layer6_col0;
    logic [3  : 0] layer6_col1;
    logic [2  : 0] layer6_col2;
    logic [2  : 0] layer6_col3;
    logic [2  : 0] layer6_col4;
    logic [2  : 0] layer6_col5;
    logic [2  : 0] layer6_col6;
    logic [1  : 0] layer6_col7;
    logic          layer6_col8;
    
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
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i3;
    logic [1 : 0] O_c3_2_terminal_chain1_i3;
    logic         CY_c3_2_terminal_chain1_i3;
    logic         PROP_c3_2_terminal_chain1_i3;
    logic         terminal_chain1_i3;
    
    logic [9 : 0] terminal_chain2_out;
    
    logic [7  : 0] COUT_LA_terminal_chain2;
    logic [1  : 0] CIN_LA_terminal_chain2;
    logic [15 : 0] CY_LA_terminal_chain2;
    logic [15 : 0] PROP_LA_terminal_chain2;
    
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
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i4;
    logic [1 : 0] O_c3_2_terminal_chain2_i4;
    logic         CY_c3_2_terminal_chain2_i4;
    logic         PROP_c3_2_terminal_chain2_i4;
    logic         terminal_chain2_i4;
    
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
    
    // GPC7 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f7 = layer0_col1[67:59];
    
    assign layer1_col1[11]    = O0_c9_41_l0_f7;
    assign layer1_col2[31:28] = O1_c9_41_l0_f7;
    
    // GPC8 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f8 = layer0_col1[76:68];
    
    assign layer1_col1[12]    = O0_c9_41_l0_f8;
    assign layer1_col2[35:32] = O1_c9_41_l0_f8;
    
    // GPC9 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f9 = layer0_col1[85:77];
    
    assign layer1_col1[13]    = O0_c9_41_l0_f9;
    assign layer1_col2[39:36] = O1_c9_41_l0_f9;
    
    // GPC10 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f10 = layer0_col1[94:86];
    
    assign layer1_col1[14]    = O0_c9_41_l0_f10;
    assign layer1_col2[43:40] = O1_c9_41_l0_f10;
    
    // GPC11 in layer0: (9 : 4,1) at column 1
    
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
    
    assign C0_c9_41_l0_f11 = layer0_col1[103:95];
    
    assign layer1_col1[15]    = O0_c9_41_l0_f11;
    assign layer1_col2[47:44] = O1_c9_41_l0_f11;
    
    // GPC12 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f12 = layer0_col1[112:104];
    
    assign layer1_col1[16]    = O0_c9_41_l0_f12;
    assign layer1_col2[51:48] = O1_c9_41_l0_f12;
    
    // GPC13 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f13(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f13   ),
        .C1   (C1_c517_451_l0_f13   ),
        .CLA  (CLA_c517_451_l0_f13  ),
        .O0   (O0_c517_451_l0_f13   ),
        .O1   (O1_c517_451_l0_f13   ),
        .O2   (O2_c517_451_l0_f13   ),
        .CY0  (CY0_c517_451_l0_f13  ),
        .PROP0(PROP0_c517_451_l0_f13),
        .CY1  (CY1_c517_451_l0_f13  ),
        .PROP1(PROP1_c517_451_l0_f13));
    
    assign C0_c517_451_l0_f13 = layer0_col0[33:17];
    assign C1_c517_451_l0_f13 = layer0_col1[117:113];
    
    assign layer1_col0[1]     = O0_c517_451_l0_f13;
    assign layer1_col1[21:17] = O1_c517_451_l0_f13;
    assign layer1_col2[55:52] = O2_c517_451_l0_f13;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f13_inst0 (
        .COUTB(COUT_LA_l0_f13[0]),
        .COUTD(COUT_LA_l0_f13[1]),
        .COUTF(COUT_LA_l0_f13[2]),
        .COUTH(COUT_LA_l0_f13[3]),
        .CIN  (CIN_LA_l0_f13    ),
        .CYA  (CY_LA_l0_f13[0]  ),
        .CYB  (CY_LA_l0_f13[1]  ),
        .CYC  (CY_LA_l0_f13[2]  ),
        .CYD  (CY_LA_l0_f13[3]  ),
        .CYE  (CY_LA_l0_f13[4]  ),
        .CYF  (CY_LA_l0_f13[5]  ),
        .CYG  (CY_LA_l0_f13[6]  ),
        .CYH  (CY_LA_l0_f13[7]  ),
        .PROPA(PROP_LA_l0_f13[0]),
        .PROPB(PROP_LA_l0_f13[1]),
        .PROPC(PROP_LA_l0_f13[2]),
        .PROPD(PROP_LA_l0_f13[3]),
        .PROPE(PROP_LA_l0_f13[4]),
        .PROPF(PROP_LA_l0_f13[5]),
        .PROPG(PROP_LA_l0_f13[6]),
        .PROPH(PROP_LA_l0_f13[7]));

    assign CLA_c517_451_l0_f13[0] = COUT_LA_l0_f13[0];
    assign CLA_c517_451_l0_f13[1] = COUT_LA_l0_f13[2];
    assign CIN_LA_l0_f13          = C0_c517_451_l0_f13[8];
    assign CY_LA_l0_f13[3:0]      = CY0_c517_451_l0_f13;
    assign CY_LA_l0_f13[7:4]      = CY1_c517_451_l0_f13;
    assign PROP_LA_l0_f13[3:0]    = PROP0_c517_451_l0_f13;
    assign PROP_LA_l0_f13[7:4]    = PROP1_c517_451_l0_f13;
    
    // GPC14 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f14(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f14   ),
        .C1   (C1_c517_451_l0_f14   ),
        .CLA  (CLA_c517_451_l0_f14  ),
        .O0   (O0_c517_451_l0_f14   ),
        .O1   (O1_c517_451_l0_f14   ),
        .O2   (O2_c517_451_l0_f14   ),
        .CY0  (CY0_c517_451_l0_f14  ),
        .PROP0(PROP0_c517_451_l0_f14),
        .CY1  (CY1_c517_451_l0_f14  ),
        .PROP1(PROP1_c517_451_l0_f14));
    
    assign C0_c517_451_l0_f14 = layer0_col0[50:34];
    assign C1_c517_451_l0_f14 = layer0_col1[122:118];
    
    assign layer1_col0[2]     = O0_c517_451_l0_f14;
    assign layer1_col1[26:22] = O1_c517_451_l0_f14;
    assign layer1_col2[59:56] = O2_c517_451_l0_f14;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f14_inst0 (
        .COUTB(COUT_LA_l0_f14[0]),
        .COUTD(COUT_LA_l0_f14[1]),
        .COUTF(COUT_LA_l0_f14[2]),
        .COUTH(COUT_LA_l0_f14[3]),
        .CIN  (CIN_LA_l0_f14    ),
        .CYA  (CY_LA_l0_f14[0]  ),
        .CYB  (CY_LA_l0_f14[1]  ),
        .CYC  (CY_LA_l0_f14[2]  ),
        .CYD  (CY_LA_l0_f14[3]  ),
        .CYE  (CY_LA_l0_f14[4]  ),
        .CYF  (CY_LA_l0_f14[5]  ),
        .CYG  (CY_LA_l0_f14[6]  ),
        .CYH  (CY_LA_l0_f14[7]  ),
        .PROPA(PROP_LA_l0_f14[0]),
        .PROPB(PROP_LA_l0_f14[1]),
        .PROPC(PROP_LA_l0_f14[2]),
        .PROPD(PROP_LA_l0_f14[3]),
        .PROPE(PROP_LA_l0_f14[4]),
        .PROPF(PROP_LA_l0_f14[5]),
        .PROPG(PROP_LA_l0_f14[6]),
        .PROPH(PROP_LA_l0_f14[7]));

    assign CLA_c517_451_l0_f14[0] = COUT_LA_l0_f14[0];
    assign CLA_c517_451_l0_f14[1] = COUT_LA_l0_f14[2];
    assign CIN_LA_l0_f14          = C0_c517_451_l0_f14[8];
    assign CY_LA_l0_f14[3:0]      = CY0_c517_451_l0_f14;
    assign CY_LA_l0_f14[7:4]      = CY1_c517_451_l0_f14;
    assign PROP_LA_l0_f14[3:0]    = PROP0_c517_451_l0_f14;
    assign PROP_LA_l0_f14[7:4]    = PROP1_c517_451_l0_f14;
    
    // GPC15 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f15(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f15   ),
        .C1   (C1_c517_451_l0_f15   ),
        .CLA  (CLA_c517_451_l0_f15  ),
        .O0   (O0_c517_451_l0_f15   ),
        .O1   (O1_c517_451_l0_f15   ),
        .O2   (O2_c517_451_l0_f15   ),
        .CY0  (CY0_c517_451_l0_f15  ),
        .PROP0(PROP0_c517_451_l0_f15),
        .CY1  (CY1_c517_451_l0_f15  ),
        .PROP1(PROP1_c517_451_l0_f15));
    
    assign C0_c517_451_l0_f15 = layer0_col0[67:51];
    assign C1_c517_451_l0_f15 = layer0_col1[127:123];
    
    assign layer1_col0[3]     = O0_c517_451_l0_f15;
    assign layer1_col1[31:27] = O1_c517_451_l0_f15;
    assign layer1_col2[63:60] = O2_c517_451_l0_f15;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f15_inst0 (
        .COUTB(COUT_LA_l0_f15[0]),
        .COUTD(COUT_LA_l0_f15[1]),
        .COUTF(COUT_LA_l0_f15[2]),
        .COUTH(COUT_LA_l0_f15[3]),
        .CIN  (CIN_LA_l0_f15    ),
        .CYA  (CY_LA_l0_f15[0]  ),
        .CYB  (CY_LA_l0_f15[1]  ),
        .CYC  (CY_LA_l0_f15[2]  ),
        .CYD  (CY_LA_l0_f15[3]  ),
        .CYE  (CY_LA_l0_f15[4]  ),
        .CYF  (CY_LA_l0_f15[5]  ),
        .CYG  (CY_LA_l0_f15[6]  ),
        .CYH  (CY_LA_l0_f15[7]  ),
        .PROPA(PROP_LA_l0_f15[0]),
        .PROPB(PROP_LA_l0_f15[1]),
        .PROPC(PROP_LA_l0_f15[2]),
        .PROPD(PROP_LA_l0_f15[3]),
        .PROPE(PROP_LA_l0_f15[4]),
        .PROPF(PROP_LA_l0_f15[5]),
        .PROPG(PROP_LA_l0_f15[6]),
        .PROPH(PROP_LA_l0_f15[7]));

    assign CLA_c517_451_l0_f15[0] = COUT_LA_l0_f15[0];
    assign CLA_c517_451_l0_f15[1] = COUT_LA_l0_f15[2];
    assign CIN_LA_l0_f15          = C0_c517_451_l0_f15[8];
    assign CY_LA_l0_f15[3:0]      = CY0_c517_451_l0_f15;
    assign CY_LA_l0_f15[7:4]      = CY1_c517_451_l0_f15;
    assign PROP_LA_l0_f15[3:0]    = PROP0_c517_451_l0_f15;
    assign PROP_LA_l0_f15[7:4]    = PROP1_c517_451_l0_f15;
    
    // GPC16 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f16(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f16   ),
        .C1   (C1_c517_451_l0_f16   ),
        .CLA  (CLA_c517_451_l0_f16  ),
        .O0   (O0_c517_451_l0_f16   ),
        .O1   (O1_c517_451_l0_f16   ),
        .O2   (O2_c517_451_l0_f16   ),
        .CY0  (CY0_c517_451_l0_f16  ),
        .PROP0(PROP0_c517_451_l0_f16),
        .CY1  (CY1_c517_451_l0_f16  ),
        .PROP1(PROP1_c517_451_l0_f16));
    
    assign C0_c517_451_l0_f16 = layer0_col0[84:68];
    assign C1_c517_451_l0_f16 = layer0_col1[132:128];
    
    assign layer1_col0[4]     = O0_c517_451_l0_f16;
    assign layer1_col1[36:32] = O1_c517_451_l0_f16;
    assign layer1_col2[67:64] = O2_c517_451_l0_f16;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f16_inst0 (
        .COUTB(COUT_LA_l0_f16[0]),
        .COUTD(COUT_LA_l0_f16[1]),
        .COUTF(COUT_LA_l0_f16[2]),
        .COUTH(COUT_LA_l0_f16[3]),
        .CIN  (CIN_LA_l0_f16    ),
        .CYA  (CY_LA_l0_f16[0]  ),
        .CYB  (CY_LA_l0_f16[1]  ),
        .CYC  (CY_LA_l0_f16[2]  ),
        .CYD  (CY_LA_l0_f16[3]  ),
        .CYE  (CY_LA_l0_f16[4]  ),
        .CYF  (CY_LA_l0_f16[5]  ),
        .CYG  (CY_LA_l0_f16[6]  ),
        .CYH  (CY_LA_l0_f16[7]  ),
        .PROPA(PROP_LA_l0_f16[0]),
        .PROPB(PROP_LA_l0_f16[1]),
        .PROPC(PROP_LA_l0_f16[2]),
        .PROPD(PROP_LA_l0_f16[3]),
        .PROPE(PROP_LA_l0_f16[4]),
        .PROPF(PROP_LA_l0_f16[5]),
        .PROPG(PROP_LA_l0_f16[6]),
        .PROPH(PROP_LA_l0_f16[7]));

    assign CLA_c517_451_l0_f16[0] = COUT_LA_l0_f16[0];
    assign CLA_c517_451_l0_f16[1] = COUT_LA_l0_f16[2];
    assign CIN_LA_l0_f16          = C0_c517_451_l0_f16[8];
    assign CY_LA_l0_f16[3:0]      = CY0_c517_451_l0_f16;
    assign CY_LA_l0_f16[7:4]      = CY1_c517_451_l0_f16;
    assign PROP_LA_l0_f16[3:0]    = PROP0_c517_451_l0_f16;
    assign PROP_LA_l0_f16[7:4]    = PROP1_c517_451_l0_f16;
    
    // GPC17 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f17(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f17   ),
        .C1   (C1_c517_451_l0_f17   ),
        .CLA  (CLA_c517_451_l0_f17  ),
        .O0   (O0_c517_451_l0_f17   ),
        .O1   (O1_c517_451_l0_f17   ),
        .O2   (O2_c517_451_l0_f17   ),
        .CY0  (CY0_c517_451_l0_f17  ),
        .PROP0(PROP0_c517_451_l0_f17),
        .CY1  (CY1_c517_451_l0_f17  ),
        .PROP1(PROP1_c517_451_l0_f17));
    
    assign C0_c517_451_l0_f17 = layer0_col0[101:85];
    assign C1_c517_451_l0_f17 = layer0_col1[137:133];
    
    assign layer1_col0[5]     = O0_c517_451_l0_f17;
    assign layer1_col1[41:37] = O1_c517_451_l0_f17;
    assign layer1_col2[71:68] = O2_c517_451_l0_f17;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f17_inst0 (
        .COUTB(COUT_LA_l0_f17[0]),
        .COUTD(COUT_LA_l0_f17[1]),
        .COUTF(COUT_LA_l0_f17[2]),
        .COUTH(COUT_LA_l0_f17[3]),
        .CIN  (CIN_LA_l0_f17    ),
        .CYA  (CY_LA_l0_f17[0]  ),
        .CYB  (CY_LA_l0_f17[1]  ),
        .CYC  (CY_LA_l0_f17[2]  ),
        .CYD  (CY_LA_l0_f17[3]  ),
        .CYE  (CY_LA_l0_f17[4]  ),
        .CYF  (CY_LA_l0_f17[5]  ),
        .CYG  (CY_LA_l0_f17[6]  ),
        .CYH  (CY_LA_l0_f17[7]  ),
        .PROPA(PROP_LA_l0_f17[0]),
        .PROPB(PROP_LA_l0_f17[1]),
        .PROPC(PROP_LA_l0_f17[2]),
        .PROPD(PROP_LA_l0_f17[3]),
        .PROPE(PROP_LA_l0_f17[4]),
        .PROPF(PROP_LA_l0_f17[5]),
        .PROPG(PROP_LA_l0_f17[6]),
        .PROPH(PROP_LA_l0_f17[7]));

    assign CLA_c517_451_l0_f17[0] = COUT_LA_l0_f17[0];
    assign CLA_c517_451_l0_f17[1] = COUT_LA_l0_f17[2];
    assign CIN_LA_l0_f17          = C0_c517_451_l0_f17[8];
    assign CY_LA_l0_f17[3:0]      = CY0_c517_451_l0_f17;
    assign CY_LA_l0_f17[7:4]      = CY1_c517_451_l0_f17;
    assign PROP_LA_l0_f17[3:0]    = PROP0_c517_451_l0_f17;
    assign PROP_LA_l0_f17[7:4]    = PROP1_c517_451_l0_f17;
    
    // GPC18 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f18(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f18   ),
        .C1   (C1_c517_451_l0_f18   ),
        .CLA  (CLA_c517_451_l0_f18  ),
        .O0   (O0_c517_451_l0_f18   ),
        .O1   (O1_c517_451_l0_f18   ),
        .O2   (O2_c517_451_l0_f18   ),
        .CY0  (CY0_c517_451_l0_f18  ),
        .PROP0(PROP0_c517_451_l0_f18),
        .CY1  (CY1_c517_451_l0_f18  ),
        .PROP1(PROP1_c517_451_l0_f18));
    
    assign C0_c517_451_l0_f18 = layer0_col0[118:102];
    assign C1_c517_451_l0_f18 = layer0_col1[142:138];
    
    assign layer1_col0[6]     = O0_c517_451_l0_f18;
    assign layer1_col1[46:42] = O1_c517_451_l0_f18;
    assign layer1_col2[75:72] = O2_c517_451_l0_f18;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f18_inst0 (
        .COUTB(COUT_LA_l0_f18[0]),
        .COUTD(COUT_LA_l0_f18[1]),
        .COUTF(COUT_LA_l0_f18[2]),
        .COUTH(COUT_LA_l0_f18[3]),
        .CIN  (CIN_LA_l0_f18    ),
        .CYA  (CY_LA_l0_f18[0]  ),
        .CYB  (CY_LA_l0_f18[1]  ),
        .CYC  (CY_LA_l0_f18[2]  ),
        .CYD  (CY_LA_l0_f18[3]  ),
        .CYE  (CY_LA_l0_f18[4]  ),
        .CYF  (CY_LA_l0_f18[5]  ),
        .CYG  (CY_LA_l0_f18[6]  ),
        .CYH  (CY_LA_l0_f18[7]  ),
        .PROPA(PROP_LA_l0_f18[0]),
        .PROPB(PROP_LA_l0_f18[1]),
        .PROPC(PROP_LA_l0_f18[2]),
        .PROPD(PROP_LA_l0_f18[3]),
        .PROPE(PROP_LA_l0_f18[4]),
        .PROPF(PROP_LA_l0_f18[5]),
        .PROPG(PROP_LA_l0_f18[6]),
        .PROPH(PROP_LA_l0_f18[7]));

    assign CLA_c517_451_l0_f18[0] = COUT_LA_l0_f18[0];
    assign CLA_c517_451_l0_f18[1] = COUT_LA_l0_f18[2];
    assign CIN_LA_l0_f18          = C0_c517_451_l0_f18[8];
    assign CY_LA_l0_f18[3:0]      = CY0_c517_451_l0_f18;
    assign CY_LA_l0_f18[7:4]      = CY1_c517_451_l0_f18;
    assign PROP_LA_l0_f18[3:0]    = PROP0_c517_451_l0_f18;
    assign PROP_LA_l0_f18[7:4]    = PROP1_c517_451_l0_f18;
    
    // GPC19 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f19(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f19   ),
        .C1   (C1_c517_451_l0_f19   ),
        .CLA  (CLA_c517_451_l0_f19  ),
        .O0   (O0_c517_451_l0_f19   ),
        .O1   (O1_c517_451_l0_f19   ),
        .O2   (O2_c517_451_l0_f19   ),
        .CY0  (CY0_c517_451_l0_f19  ),
        .PROP0(PROP0_c517_451_l0_f19),
        .CY1  (CY1_c517_451_l0_f19  ),
        .PROP1(PROP1_c517_451_l0_f19));
    
    assign C0_c517_451_l0_f19 = layer0_col0[135:119];
    assign C1_c517_451_l0_f19 = layer0_col1[147:143];
    
    assign layer1_col0[7]     = O0_c517_451_l0_f19;
    assign layer1_col1[51:47] = O1_c517_451_l0_f19;
    assign layer1_col2[79:76] = O2_c517_451_l0_f19;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f19_inst0 (
        .COUTB(COUT_LA_l0_f19[0]),
        .COUTD(COUT_LA_l0_f19[1]),
        .COUTF(COUT_LA_l0_f19[2]),
        .COUTH(COUT_LA_l0_f19[3]),
        .CIN  (CIN_LA_l0_f19    ),
        .CYA  (CY_LA_l0_f19[0]  ),
        .CYB  (CY_LA_l0_f19[1]  ),
        .CYC  (CY_LA_l0_f19[2]  ),
        .CYD  (CY_LA_l0_f19[3]  ),
        .CYE  (CY_LA_l0_f19[4]  ),
        .CYF  (CY_LA_l0_f19[5]  ),
        .CYG  (CY_LA_l0_f19[6]  ),
        .CYH  (CY_LA_l0_f19[7]  ),
        .PROPA(PROP_LA_l0_f19[0]),
        .PROPB(PROP_LA_l0_f19[1]),
        .PROPC(PROP_LA_l0_f19[2]),
        .PROPD(PROP_LA_l0_f19[3]),
        .PROPE(PROP_LA_l0_f19[4]),
        .PROPF(PROP_LA_l0_f19[5]),
        .PROPG(PROP_LA_l0_f19[6]),
        .PROPH(PROP_LA_l0_f19[7]));

    assign CLA_c517_451_l0_f19[0] = COUT_LA_l0_f19[0];
    assign CLA_c517_451_l0_f19[1] = COUT_LA_l0_f19[2];
    assign CIN_LA_l0_f19          = C0_c517_451_l0_f19[8];
    assign CY_LA_l0_f19[3:0]      = CY0_c517_451_l0_f19;
    assign CY_LA_l0_f19[7:4]      = CY1_c517_451_l0_f19;
    assign PROP_LA_l0_f19[3:0]    = PROP0_c517_451_l0_f19;
    assign PROP_LA_l0_f19[7:4]    = PROP1_c517_451_l0_f19;
    
    // GPC20 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f20(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f20   ),
        .C1   (C1_c517_451_l0_f20   ),
        .CLA  (CLA_c517_451_l0_f20  ),
        .O0   (O0_c517_451_l0_f20   ),
        .O1   (O1_c517_451_l0_f20   ),
        .O2   (O2_c517_451_l0_f20   ),
        .CY0  (CY0_c517_451_l0_f20  ),
        .PROP0(PROP0_c517_451_l0_f20),
        .CY1  (CY1_c517_451_l0_f20  ),
        .PROP1(PROP1_c517_451_l0_f20));
    
    assign C0_c517_451_l0_f20 = layer0_col0[152:136];
    assign C1_c517_451_l0_f20 = layer0_col1[152:148];
    
    assign layer1_col0[8]     = O0_c517_451_l0_f20;
    assign layer1_col1[56:52] = O1_c517_451_l0_f20;
    assign layer1_col2[83:80] = O2_c517_451_l0_f20;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f20_inst0 (
        .COUTB(COUT_LA_l0_f20[0]),
        .COUTD(COUT_LA_l0_f20[1]),
        .COUTF(COUT_LA_l0_f20[2]),
        .COUTH(COUT_LA_l0_f20[3]),
        .CIN  (CIN_LA_l0_f20    ),
        .CYA  (CY_LA_l0_f20[0]  ),
        .CYB  (CY_LA_l0_f20[1]  ),
        .CYC  (CY_LA_l0_f20[2]  ),
        .CYD  (CY_LA_l0_f20[3]  ),
        .CYE  (CY_LA_l0_f20[4]  ),
        .CYF  (CY_LA_l0_f20[5]  ),
        .CYG  (CY_LA_l0_f20[6]  ),
        .CYH  (CY_LA_l0_f20[7]  ),
        .PROPA(PROP_LA_l0_f20[0]),
        .PROPB(PROP_LA_l0_f20[1]),
        .PROPC(PROP_LA_l0_f20[2]),
        .PROPD(PROP_LA_l0_f20[3]),
        .PROPE(PROP_LA_l0_f20[4]),
        .PROPF(PROP_LA_l0_f20[5]),
        .PROPG(PROP_LA_l0_f20[6]),
        .PROPH(PROP_LA_l0_f20[7]));

    assign CLA_c517_451_l0_f20[0] = COUT_LA_l0_f20[0];
    assign CLA_c517_451_l0_f20[1] = COUT_LA_l0_f20[2];
    assign CIN_LA_l0_f20          = C0_c517_451_l0_f20[8];
    assign CY_LA_l0_f20[3:0]      = CY0_c517_451_l0_f20;
    assign CY_LA_l0_f20[7:4]      = CY1_c517_451_l0_f20;
    assign PROP_LA_l0_f20[3:0]    = PROP0_c517_451_l0_f20;
    assign PROP_LA_l0_f20[7:4]    = PROP1_c517_451_l0_f20;
    
    // GPC21 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f21(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f21   ),
        .C1   (C1_c517_451_l0_f21   ),
        .CLA  (CLA_c517_451_l0_f21  ),
        .O0   (O0_c517_451_l0_f21   ),
        .O1   (O1_c517_451_l0_f21   ),
        .O2   (O2_c517_451_l0_f21   ),
        .CY0  (CY0_c517_451_l0_f21  ),
        .PROP0(PROP0_c517_451_l0_f21),
        .CY1  (CY1_c517_451_l0_f21  ),
        .PROP1(PROP1_c517_451_l0_f21));
    
    assign C0_c517_451_l0_f21 = layer0_col0[169:153];
    assign C1_c517_451_l0_f21 = layer0_col1[157:153];
    
    assign layer1_col0[9]     = O0_c517_451_l0_f21;
    assign layer1_col1[61:57] = O1_c517_451_l0_f21;
    assign layer1_col2[87:84] = O2_c517_451_l0_f21;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f21_inst0 (
        .COUTB(COUT_LA_l0_f21[0]),
        .COUTD(COUT_LA_l0_f21[1]),
        .COUTF(COUT_LA_l0_f21[2]),
        .COUTH(COUT_LA_l0_f21[3]),
        .CIN  (CIN_LA_l0_f21    ),
        .CYA  (CY_LA_l0_f21[0]  ),
        .CYB  (CY_LA_l0_f21[1]  ),
        .CYC  (CY_LA_l0_f21[2]  ),
        .CYD  (CY_LA_l0_f21[3]  ),
        .CYE  (CY_LA_l0_f21[4]  ),
        .CYF  (CY_LA_l0_f21[5]  ),
        .CYG  (CY_LA_l0_f21[6]  ),
        .CYH  (CY_LA_l0_f21[7]  ),
        .PROPA(PROP_LA_l0_f21[0]),
        .PROPB(PROP_LA_l0_f21[1]),
        .PROPC(PROP_LA_l0_f21[2]),
        .PROPD(PROP_LA_l0_f21[3]),
        .PROPE(PROP_LA_l0_f21[4]),
        .PROPF(PROP_LA_l0_f21[5]),
        .PROPG(PROP_LA_l0_f21[6]),
        .PROPH(PROP_LA_l0_f21[7]));

    assign CLA_c517_451_l0_f21[0] = COUT_LA_l0_f21[0];
    assign CLA_c517_451_l0_f21[1] = COUT_LA_l0_f21[2];
    assign CIN_LA_l0_f21          = C0_c517_451_l0_f21[8];
    assign CY_LA_l0_f21[3:0]      = CY0_c517_451_l0_f21;
    assign CY_LA_l0_f21[7:4]      = CY1_c517_451_l0_f21;
    assign PROP_LA_l0_f21[3:0]    = PROP0_c517_451_l0_f21;
    assign PROP_LA_l0_f21[7:4]    = PROP1_c517_451_l0_f21;
    
    // GPC22 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f22(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f22   ),
        .C1   (C1_c517_451_l0_f22   ),
        .CLA  (CLA_c517_451_l0_f22  ),
        .O0   (O0_c517_451_l0_f22   ),
        .O1   (O1_c517_451_l0_f22   ),
        .O2   (O2_c517_451_l0_f22   ),
        .CY0  (CY0_c517_451_l0_f22  ),
        .PROP0(PROP0_c517_451_l0_f22),
        .CY1  (CY1_c517_451_l0_f22  ),
        .PROP1(PROP1_c517_451_l0_f22));
    
    assign C0_c517_451_l0_f22 = layer0_col0[186:170];
    assign C1_c517_451_l0_f22 = layer0_col1[162:158];
    
    assign layer1_col0[10]    = O0_c517_451_l0_f22;
    assign layer1_col1[66:62] = O1_c517_451_l0_f22;
    assign layer1_col2[91:88] = O2_c517_451_l0_f22;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f22_inst0 (
        .COUTB(COUT_LA_l0_f22[0]),
        .COUTD(COUT_LA_l0_f22[1]),
        .COUTF(COUT_LA_l0_f22[2]),
        .COUTH(COUT_LA_l0_f22[3]),
        .CIN  (CIN_LA_l0_f22    ),
        .CYA  (CY_LA_l0_f22[0]  ),
        .CYB  (CY_LA_l0_f22[1]  ),
        .CYC  (CY_LA_l0_f22[2]  ),
        .CYD  (CY_LA_l0_f22[3]  ),
        .CYE  (CY_LA_l0_f22[4]  ),
        .CYF  (CY_LA_l0_f22[5]  ),
        .CYG  (CY_LA_l0_f22[6]  ),
        .CYH  (CY_LA_l0_f22[7]  ),
        .PROPA(PROP_LA_l0_f22[0]),
        .PROPB(PROP_LA_l0_f22[1]),
        .PROPC(PROP_LA_l0_f22[2]),
        .PROPD(PROP_LA_l0_f22[3]),
        .PROPE(PROP_LA_l0_f22[4]),
        .PROPF(PROP_LA_l0_f22[5]),
        .PROPG(PROP_LA_l0_f22[6]),
        .PROPH(PROP_LA_l0_f22[7]));

    assign CLA_c517_451_l0_f22[0] = COUT_LA_l0_f22[0];
    assign CLA_c517_451_l0_f22[1] = COUT_LA_l0_f22[2];
    assign CIN_LA_l0_f22          = C0_c517_451_l0_f22[8];
    assign CY_LA_l0_f22[3:0]      = CY0_c517_451_l0_f22;
    assign CY_LA_l0_f22[7:4]      = CY1_c517_451_l0_f22;
    assign PROP_LA_l0_f22[3:0]    = PROP0_c517_451_l0_f22;
    assign PROP_LA_l0_f22[7:4]    = PROP1_c517_451_l0_f22;
    
    // GPC23 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f23(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f23   ),
        .C1   (C1_c517_451_l0_f23   ),
        .CLA  (CLA_c517_451_l0_f23  ),
        .O0   (O0_c517_451_l0_f23   ),
        .O1   (O1_c517_451_l0_f23   ),
        .O2   (O2_c517_451_l0_f23   ),
        .CY0  (CY0_c517_451_l0_f23  ),
        .PROP0(PROP0_c517_451_l0_f23),
        .CY1  (CY1_c517_451_l0_f23  ),
        .PROP1(PROP1_c517_451_l0_f23));
    
    assign C0_c517_451_l0_f23 = layer0_col0[203:187];
    assign C1_c517_451_l0_f23 = layer0_col1[167:163];
    
    assign layer1_col0[11]    = O0_c517_451_l0_f23;
    assign layer1_col1[71:67] = O1_c517_451_l0_f23;
    assign layer1_col2[95:92] = O2_c517_451_l0_f23;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f23_inst0 (
        .COUTB(COUT_LA_l0_f23[0]),
        .COUTD(COUT_LA_l0_f23[1]),
        .COUTF(COUT_LA_l0_f23[2]),
        .COUTH(COUT_LA_l0_f23[3]),
        .CIN  (CIN_LA_l0_f23    ),
        .CYA  (CY_LA_l0_f23[0]  ),
        .CYB  (CY_LA_l0_f23[1]  ),
        .CYC  (CY_LA_l0_f23[2]  ),
        .CYD  (CY_LA_l0_f23[3]  ),
        .CYE  (CY_LA_l0_f23[4]  ),
        .CYF  (CY_LA_l0_f23[5]  ),
        .CYG  (CY_LA_l0_f23[6]  ),
        .CYH  (CY_LA_l0_f23[7]  ),
        .PROPA(PROP_LA_l0_f23[0]),
        .PROPB(PROP_LA_l0_f23[1]),
        .PROPC(PROP_LA_l0_f23[2]),
        .PROPD(PROP_LA_l0_f23[3]),
        .PROPE(PROP_LA_l0_f23[4]),
        .PROPF(PROP_LA_l0_f23[5]),
        .PROPG(PROP_LA_l0_f23[6]),
        .PROPH(PROP_LA_l0_f23[7]));

    assign CLA_c517_451_l0_f23[0] = COUT_LA_l0_f23[0];
    assign CLA_c517_451_l0_f23[1] = COUT_LA_l0_f23[2];
    assign CIN_LA_l0_f23          = C0_c517_451_l0_f23[8];
    assign CY_LA_l0_f23[3:0]      = CY0_c517_451_l0_f23;
    assign CY_LA_l0_f23[7:4]      = CY1_c517_451_l0_f23;
    assign PROP_LA_l0_f23[3:0]    = PROP0_c517_451_l0_f23;
    assign PROP_LA_l0_f23[7:4]    = PROP1_c517_451_l0_f23;
    
    // GPC24 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f24(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f24   ),
        .C1   (C1_c517_451_l0_f24   ),
        .CLA  (CLA_c517_451_l0_f24  ),
        .O0   (O0_c517_451_l0_f24   ),
        .O1   (O1_c517_451_l0_f24   ),
        .O2   (O2_c517_451_l0_f24   ),
        .CY0  (CY0_c517_451_l0_f24  ),
        .PROP0(PROP0_c517_451_l0_f24),
        .CY1  (CY1_c517_451_l0_f24  ),
        .PROP1(PROP1_c517_451_l0_f24));
    
    assign C0_c517_451_l0_f24 = layer0_col0[220:204];
    assign C1_c517_451_l0_f24 = layer0_col1[172:168];
    
    assign layer1_col0[12]    = O0_c517_451_l0_f24;
    assign layer1_col1[76:72] = O1_c517_451_l0_f24;
    assign layer1_col2[99:96] = O2_c517_451_l0_f24;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f24_inst0 (
        .COUTB(COUT_LA_l0_f24[0]),
        .COUTD(COUT_LA_l0_f24[1]),
        .COUTF(COUT_LA_l0_f24[2]),
        .COUTH(COUT_LA_l0_f24[3]),
        .CIN  (CIN_LA_l0_f24    ),
        .CYA  (CY_LA_l0_f24[0]  ),
        .CYB  (CY_LA_l0_f24[1]  ),
        .CYC  (CY_LA_l0_f24[2]  ),
        .CYD  (CY_LA_l0_f24[3]  ),
        .CYE  (CY_LA_l0_f24[4]  ),
        .CYF  (CY_LA_l0_f24[5]  ),
        .CYG  (CY_LA_l0_f24[6]  ),
        .CYH  (CY_LA_l0_f24[7]  ),
        .PROPA(PROP_LA_l0_f24[0]),
        .PROPB(PROP_LA_l0_f24[1]),
        .PROPC(PROP_LA_l0_f24[2]),
        .PROPD(PROP_LA_l0_f24[3]),
        .PROPE(PROP_LA_l0_f24[4]),
        .PROPF(PROP_LA_l0_f24[5]),
        .PROPG(PROP_LA_l0_f24[6]),
        .PROPH(PROP_LA_l0_f24[7]));

    assign CLA_c517_451_l0_f24[0] = COUT_LA_l0_f24[0];
    assign CLA_c517_451_l0_f24[1] = COUT_LA_l0_f24[2];
    assign CIN_LA_l0_f24          = C0_c517_451_l0_f24[8];
    assign CY_LA_l0_f24[3:0]      = CY0_c517_451_l0_f24;
    assign CY_LA_l0_f24[7:4]      = CY1_c517_451_l0_f24;
    assign PROP_LA_l0_f24[3:0]    = PROP0_c517_451_l0_f24;
    assign PROP_LA_l0_f24[7:4]    = PROP1_c517_451_l0_f24;
    
    // GPC25 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f25(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f25   ),
        .C1   (C1_c517_451_l0_f25   ),
        .CLA  (CLA_c517_451_l0_f25  ),
        .O0   (O0_c517_451_l0_f25   ),
        .O1   (O1_c517_451_l0_f25   ),
        .O2   (O2_c517_451_l0_f25   ),
        .CY0  (CY0_c517_451_l0_f25  ),
        .PROP0(PROP0_c517_451_l0_f25),
        .CY1  (CY1_c517_451_l0_f25  ),
        .PROP1(PROP1_c517_451_l0_f25));
    
    assign C0_c517_451_l0_f25 = layer0_col0[237:221];
    assign C1_c517_451_l0_f25 = layer0_col1[177:173];
    
    assign layer1_col0[13]      = O0_c517_451_l0_f25;
    assign layer1_col1[81:77]   = O1_c517_451_l0_f25;
    assign layer1_col2[103:100] = O2_c517_451_l0_f25;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f25_inst0 (
        .COUTB(COUT_LA_l0_f25[0]),
        .COUTD(COUT_LA_l0_f25[1]),
        .COUTF(COUT_LA_l0_f25[2]),
        .COUTH(COUT_LA_l0_f25[3]),
        .CIN  (CIN_LA_l0_f25    ),
        .CYA  (CY_LA_l0_f25[0]  ),
        .CYB  (CY_LA_l0_f25[1]  ),
        .CYC  (CY_LA_l0_f25[2]  ),
        .CYD  (CY_LA_l0_f25[3]  ),
        .CYE  (CY_LA_l0_f25[4]  ),
        .CYF  (CY_LA_l0_f25[5]  ),
        .CYG  (CY_LA_l0_f25[6]  ),
        .CYH  (CY_LA_l0_f25[7]  ),
        .PROPA(PROP_LA_l0_f25[0]),
        .PROPB(PROP_LA_l0_f25[1]),
        .PROPC(PROP_LA_l0_f25[2]),
        .PROPD(PROP_LA_l0_f25[3]),
        .PROPE(PROP_LA_l0_f25[4]),
        .PROPF(PROP_LA_l0_f25[5]),
        .PROPG(PROP_LA_l0_f25[6]),
        .PROPH(PROP_LA_l0_f25[7]));

    assign CLA_c517_451_l0_f25[0] = COUT_LA_l0_f25[0];
    assign CLA_c517_451_l0_f25[1] = COUT_LA_l0_f25[2];
    assign CIN_LA_l0_f25          = C0_c517_451_l0_f25[8];
    assign CY_LA_l0_f25[3:0]      = CY0_c517_451_l0_f25;
    assign CY_LA_l0_f25[7:4]      = CY1_c517_451_l0_f25;
    assign PROP_LA_l0_f25[3:0]    = PROP0_c517_451_l0_f25;
    assign PROP_LA_l0_f25[7:4]    = PROP1_c517_451_l0_f25;
    
    // GPC26 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f26(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f26   ),
        .C1   (C1_c517_451_l0_f26   ),
        .CLA  (CLA_c517_451_l0_f26  ),
        .O0   (O0_c517_451_l0_f26   ),
        .O1   (O1_c517_451_l0_f26   ),
        .O2   (O2_c517_451_l0_f26   ),
        .CY0  (CY0_c517_451_l0_f26  ),
        .PROP0(PROP0_c517_451_l0_f26),
        .CY1  (CY1_c517_451_l0_f26  ),
        .PROP1(PROP1_c517_451_l0_f26));
    
    assign C0_c517_451_l0_f26 = layer0_col0[254:238];
    assign C1_c517_451_l0_f26 = layer0_col1[182:178];
    
    assign layer1_col0[14]      = O0_c517_451_l0_f26;
    assign layer1_col1[86:82]   = O1_c517_451_l0_f26;
    assign layer1_col2[107:104] = O2_c517_451_l0_f26;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f26_inst0 (
        .COUTB(COUT_LA_l0_f26[0]),
        .COUTD(COUT_LA_l0_f26[1]),
        .COUTF(COUT_LA_l0_f26[2]),
        .COUTH(COUT_LA_l0_f26[3]),
        .CIN  (CIN_LA_l0_f26    ),
        .CYA  (CY_LA_l0_f26[0]  ),
        .CYB  (CY_LA_l0_f26[1]  ),
        .CYC  (CY_LA_l0_f26[2]  ),
        .CYD  (CY_LA_l0_f26[3]  ),
        .CYE  (CY_LA_l0_f26[4]  ),
        .CYF  (CY_LA_l0_f26[5]  ),
        .CYG  (CY_LA_l0_f26[6]  ),
        .CYH  (CY_LA_l0_f26[7]  ),
        .PROPA(PROP_LA_l0_f26[0]),
        .PROPB(PROP_LA_l0_f26[1]),
        .PROPC(PROP_LA_l0_f26[2]),
        .PROPD(PROP_LA_l0_f26[3]),
        .PROPE(PROP_LA_l0_f26[4]),
        .PROPF(PROP_LA_l0_f26[5]),
        .PROPG(PROP_LA_l0_f26[6]),
        .PROPH(PROP_LA_l0_f26[7]));

    assign CLA_c517_451_l0_f26[0] = COUT_LA_l0_f26[0];
    assign CLA_c517_451_l0_f26[1] = COUT_LA_l0_f26[2];
    assign CIN_LA_l0_f26          = C0_c517_451_l0_f26[8];
    assign CY_LA_l0_f26[3:0]      = CY0_c517_451_l0_f26;
    assign CY_LA_l0_f26[7:4]      = CY1_c517_451_l0_f26;
    assign PROP_LA_l0_f26[3:0]    = PROP0_c517_451_l0_f26;
    assign PROP_LA_l0_f26[7:4]    = PROP1_c517_451_l0_f26;
    
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
    
    assign CY_LA_l0_floating_placement[13:12]   = CY_c9_41_l0_f7;
    assign PROP_LA_l0_floating_placement[13:12] = PROP_c9_41_l0_f7;
    
    assign CY_LA_l0_floating_placement[15:14]   = CY_c9_41_l0_f8;
    assign PROP_LA_l0_floating_placement[15:14] = PROP_c9_41_l0_f8;
    
    assign CY_LA_l0_floating_placement[17:16]   = CY_c9_41_l0_f9;
    assign PROP_LA_l0_floating_placement[17:16] = PROP_c9_41_l0_f9;
    assign CIN_LA_l0_floating_placement[2] = C0_c9_41_l0_f9[8];
    
    assign CY_LA_l0_floating_placement[19:18]   = CY_c9_41_l0_f10;
    assign PROP_LA_l0_floating_placement[19:18] = PROP_c9_41_l0_f10;
    
    assign CY_LA_l0_floating_placement[21:20]   = CY_c9_41_l0_f11;
    assign PROP_LA_l0_floating_placement[21:20] = PROP_c9_41_l0_f11;
    
    assign CY_LA_l0_floating_placement[23:22]   = CY_c9_41_l0_f12;
    assign PROP_LA_l0_floating_placement[23:22] = PROP_c9_41_l0_f12;
    
    assign layer1_col0[15] = layer0_col0[255];
    assign layer1_col1[87] = layer0_col1[183];
    assign layer1_col1[88] = layer0_col1[184];
    assign layer1_col1[89] = layer0_col1[185];
    assign layer1_col1[90] = layer0_col1[186];
    assign layer1_col1[91] = layer0_col1[187];
    assign layer1_col1[92] = layer0_col1[188];
    assign layer1_col1[93] = layer0_col1[189];
    assign layer1_col1[94] = layer0_col1[190];
    assign layer1_col1[95] = layer0_col1[191];
    assign layer1_col1[96] = layer0_col1[192];
    assign layer1_col1[97] = layer0_col1[193];
    assign layer1_col1[98] = layer0_col1[194];
    assign layer1_col1[99] = layer0_col1[195];
    assign layer1_col1[100] = layer0_col1[196];
    assign layer1_col1[101] = layer0_col1[197];
    assign layer1_col1[102] = layer0_col1[198];
    assign layer1_col1[103] = layer0_col1[199];
    assign layer1_col1[104] = layer0_col1[200];
    assign layer1_col1[105] = layer0_col1[201];
    assign layer1_col1[106] = layer0_col1[202];
    assign layer1_col1[107] = layer0_col1[203];
    assign layer1_col1[108] = layer0_col1[204];
    assign layer1_col1[109] = layer0_col1[205];
    assign layer1_col1[110] = layer0_col1[206];
    assign layer1_col1[111] = layer0_col1[207];
    assign layer1_col1[112] = layer0_col1[208];
    assign layer1_col1[113] = layer0_col1[209];
    assign layer1_col1[114] = layer0_col1[210];
    assign layer1_col1[115] = layer0_col1[211];
    assign layer1_col1[116] = layer0_col1[212];
    assign layer1_col1[117] = layer0_col1[213];
    assign layer1_col1[118] = layer0_col1[214];
    assign layer1_col1[119] = layer0_col1[215];
    assign layer1_col1[120] = layer0_col1[216];
    assign layer1_col1[121] = layer0_col1[217];
    assign layer1_col1[122] = layer0_col1[218];
    assign layer1_col1[123] = layer0_col1[219];
    assign layer1_col1[124] = layer0_col1[220];
    assign layer1_col1[125] = layer0_col1[221];
    assign layer1_col1[126] = layer0_col1[222];
    assign layer1_col1[127] = layer0_col1[223];
    assign layer1_col1[128] = layer0_col1[224];
    assign layer1_col1[129] = layer0_col1[225];
    assign layer1_col1[130] = layer0_col1[226];
    assign layer1_col1[131] = layer0_col1[227];
    assign layer1_col1[132] = layer0_col1[228];
    assign layer1_col1[133] = layer0_col1[229];
    assign layer1_col1[134] = layer0_col1[230];
    assign layer1_col1[135] = layer0_col1[231];
    assign layer1_col1[136] = layer0_col1[232];
    assign layer1_col1[137] = layer0_col1[233];
    assign layer1_col1[138] = layer0_col1[234];
    assign layer1_col1[139] = layer0_col1[235];
    assign layer1_col1[140] = layer0_col1[236];
    assign layer1_col1[141] = layer0_col1[237];
    assign layer1_col1[142] = layer0_col1[238];
    assign layer1_col1[143] = layer0_col1[239];
    assign layer1_col1[144] = layer0_col1[240];
    assign layer1_col1[145] = layer0_col1[241];
    assign layer1_col1[146] = layer0_col1[242];
    assign layer1_col1[147] = layer0_col1[243];
    assign layer1_col1[148] = layer0_col1[244];
    assign layer1_col1[149] = layer0_col1[245];
    assign layer1_col1[150] = layer0_col1[246];
    assign layer1_col1[151] = layer0_col1[247];
    assign layer1_col1[152] = layer0_col1[248];
    assign layer1_col1[153] = layer0_col1[249];
    assign layer1_col1[154] = layer0_col1[250];
    assign layer1_col1[155] = layer0_col1[251];
    assign layer1_col1[156] = layer0_col1[252];
    assign layer1_col1[157] = layer0_col1[253];
    assign layer1_col1[158] = layer0_col1[254];
    assign layer1_col1[159] = layer0_col1[255];
    // ------------------------------ LAYER 1 ------------------------------
    // GPC0 in layer1: (4,13 : 3,4,1) at column 0
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l1_f0(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l1_f0   ),
        .C1   (C1_c413_341_l1_f0   ),
        .CLA  (CLA_c413_341_l1_f0  ),
        .O0   (O0_c413_341_l1_f0   ),
        .O1   (O1_c413_341_l1_f0   ),
        .O2   (O2_c413_341_l1_f0   ),
        .CY0  (CY0_c413_341_l1_f0  ),
        .PROP0(PROP0_c413_341_l1_f0),
        .CY1  (CY1_c413_341_l1_f0  ),
        .PROP1(PROP1_c413_341_l1_f0));
    
    assign C0_c413_341_l1_f0 = layer1_col0[12:0];
    assign C1_c413_341_l1_f0 = layer1_col1[3:0];
    
    assign layer2_col0[0]   = O0_c413_341_l1_f0;
    assign layer2_col1[3:0] = O1_c413_341_l1_f0;
    assign layer2_col2[2:0] = O2_c413_341_l1_f0;
    
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

    assign CLA_c413_341_l1_f0[0] = COUT_LA_l1_f0[0];
    assign CLA_c413_341_l1_f0[1] = COUT_LA_l1_f0[2];
    assign CIN_LA_l1_f0          = C0_c413_341_l1_f0[8];
    assign CY_LA_l1_f0[2:0]      = CY0_c413_341_l1_f0;
    assign CY_LA_l1_f0[6:4]      = CY1_c413_341_l1_f0;
    assign PROP_LA_l1_f0[2:0]    = PROP0_c413_341_l1_f0;
    assign PROP_LA_l1_f0[6:4]    = PROP1_c413_341_l1_f0;
    assign PROP_LA_l1_f0[3]      = 1'b0;
    assign CY_LA_l1_f0[3]        = 1'b0;
    
    // GPC1 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f1(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l1_f1   ),
        .C1   (C1_c517_451_l1_f1   ),
        .CLA  (CLA_c517_451_l1_f1  ),
        .O0   (O0_c517_451_l1_f1   ),
        .O1   (O1_c517_451_l1_f1   ),
        .O2   (O2_c517_451_l1_f1   ),
        .CY0  (CY0_c517_451_l1_f1  ),
        .PROP0(PROP0_c517_451_l1_f1),
        .CY1  (CY1_c517_451_l1_f1  ),
        .PROP1(PROP1_c517_451_l1_f1));
    
    assign C0_c517_451_l1_f1 = layer1_col1[20:4];
    assign C1_c517_451_l1_f1 = layer1_col2[4:0];
    
    assign layer2_col1[4]   = O0_c517_451_l1_f1;
    assign layer2_col2[7:3] = O1_c517_451_l1_f1;
    assign layer2_col3[3:0] = O2_c517_451_l1_f1;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f1_inst0 (
        .COUTB(COUT_LA_l1_f1[0]),
        .COUTD(COUT_LA_l1_f1[1]),
        .COUTF(COUT_LA_l1_f1[2]),
        .COUTH(COUT_LA_l1_f1[3]),
        .CIN  (CIN_LA_l1_f1    ),
        .CYA  (CY_LA_l1_f1[0]  ),
        .CYB  (CY_LA_l1_f1[1]  ),
        .CYC  (CY_LA_l1_f1[2]  ),
        .CYD  (CY_LA_l1_f1[3]  ),
        .CYE  (CY_LA_l1_f1[4]  ),
        .CYF  (CY_LA_l1_f1[5]  ),
        .CYG  (CY_LA_l1_f1[6]  ),
        .CYH  (CY_LA_l1_f1[7]  ),
        .PROPA(PROP_LA_l1_f1[0]),
        .PROPB(PROP_LA_l1_f1[1]),
        .PROPC(PROP_LA_l1_f1[2]),
        .PROPD(PROP_LA_l1_f1[3]),
        .PROPE(PROP_LA_l1_f1[4]),
        .PROPF(PROP_LA_l1_f1[5]),
        .PROPG(PROP_LA_l1_f1[6]),
        .PROPH(PROP_LA_l1_f1[7]));

    assign CLA_c517_451_l1_f1[0] = COUT_LA_l1_f1[0];
    assign CLA_c517_451_l1_f1[1] = COUT_LA_l1_f1[2];
    assign CIN_LA_l1_f1          = C0_c517_451_l1_f1[8];
    assign CY_LA_l1_f1[3:0]      = CY0_c517_451_l1_f1;
    assign CY_LA_l1_f1[7:4]      = CY1_c517_451_l1_f1;
    assign PROP_LA_l1_f1[3:0]    = PROP0_c517_451_l1_f1;
    assign PROP_LA_l1_f1[7:4]    = PROP1_c517_451_l1_f1;
    
    // GPC2 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l1_f2 = layer1_col2[13:5];
    
    assign layer2_col2[8]   = O0_c9_41_l1_f2;
    assign layer2_col3[7:4] = O1_c9_41_l1_f2;
    
    // GPC3 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l1_f3 = layer1_col2[22:14];
    
    assign layer2_col2[9]    = O0_c9_41_l1_f3;
    assign layer2_col3[11:8] = O1_c9_41_l1_f3;
    
    // GPC4 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l1_f4 = layer1_col2[31:23];
    
    assign layer2_col2[10]    = O0_c9_41_l1_f4;
    assign layer2_col3[15:12] = O1_c9_41_l1_f4;
    
    // GPC5 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f5(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f5  ),
        .CLA (CLA_c9_41_l1_f5 ),
        .O0  (O0_c9_41_l1_f5  ),
        .O1  (O1_c9_41_l1_f5  ),
        .CY  (CY_c9_41_l1_f5  ),
        .PROP(PROP_c9_41_l1_f5));
    
    assign C0_c9_41_l1_f5 = layer1_col2[40:32];
    
    assign layer2_col2[11]    = O0_c9_41_l1_f5;
    assign layer2_col3[19:16] = O1_c9_41_l1_f5;
    
    // GPC6 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f6(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f6  ),
        .CLA (CLA_c9_41_l1_f6 ),
        .O0  (O0_c9_41_l1_f6  ),
        .O1  (O1_c9_41_l1_f6  ),
        .CY  (CY_c9_41_l1_f6  ),
        .PROP(PROP_c9_41_l1_f6));
    
    assign C0_c9_41_l1_f6 = layer1_col2[49:41];
    
    assign layer2_col2[12]    = O0_c9_41_l1_f6;
    assign layer2_col3[23:20] = O1_c9_41_l1_f6;
    
    // GPC7 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f7 = layer1_col1[37:21];
    assign C1_c517_451_l1_f7 = layer1_col2[54:50];
    
    assign layer2_col1[5]     = O0_c517_451_l1_f7;
    assign layer2_col2[17:13] = O1_c517_451_l1_f7;
    assign layer2_col3[27:24] = O2_c517_451_l1_f7;
    
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
    
    // GPC8 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f8 = layer1_col1[54:38];
    assign C1_c517_451_l1_f8 = layer1_col2[59:55];
    
    assign layer2_col1[6]     = O0_c517_451_l1_f8;
    assign layer2_col2[22:18] = O1_c517_451_l1_f8;
    assign layer2_col3[31:28] = O2_c517_451_l1_f8;
    
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
    
    // GPC9 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f9 = layer1_col1[71:55];
    assign C1_c517_451_l1_f9 = layer1_col2[64:60];
    
    assign layer2_col1[7]     = O0_c517_451_l1_f9;
    assign layer2_col2[27:23] = O1_c517_451_l1_f9;
    assign layer2_col3[35:32] = O2_c517_451_l1_f9;
    
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
    
    // GPC10 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f10 = layer1_col1[88:72];
    assign C1_c517_451_l1_f10 = layer1_col2[69:65];
    
    assign layer2_col1[8]     = O0_c517_451_l1_f10;
    assign layer2_col2[32:28] = O1_c517_451_l1_f10;
    assign layer2_col3[39:36] = O2_c517_451_l1_f10;
    
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
    
    // GPC11 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f11 = layer1_col1[105:89];
    assign C1_c517_451_l1_f11 = layer1_col2[74:70];
    
    assign layer2_col1[9]     = O0_c517_451_l1_f11;
    assign layer2_col2[37:33] = O1_c517_451_l1_f11;
    assign layer2_col3[43:40] = O2_c517_451_l1_f11;
    
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
    
    // GPC12 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f12 = layer1_col1[122:106];
    assign C1_c517_451_l1_f12 = layer1_col2[79:75];
    
    assign layer2_col1[10]    = O0_c517_451_l1_f12;
    assign layer2_col2[42:38] = O1_c517_451_l1_f12;
    assign layer2_col3[47:44] = O2_c517_451_l1_f12;
    
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
    
    // GPC13 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f13 = layer1_col1[139:123];
    assign C1_c517_451_l1_f13 = layer1_col2[84:80];
    
    assign layer2_col1[11]    = O0_c517_451_l1_f13;
    assign layer2_col2[47:43] = O1_c517_451_l1_f13;
    assign layer2_col3[51:48] = O2_c517_451_l1_f13;
    
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
    
    // GPC14 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f14 = layer1_col1[156:140];
    assign C1_c517_451_l1_f14 = layer1_col2[89:85];
    
    assign layer2_col1[12]    = O0_c517_451_l1_f14;
    assign layer2_col2[52:48] = O1_c517_451_l1_f14;
    assign layer2_col3[55:52] = O2_c517_451_l1_f14;
    
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
        .CIN  (CIN_LA_l1_floating_placement[0] ),
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

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_floating_placement_inst1 (
        .COUTB(COUT_LA_l1_floating_placement[4] ),
        .COUTD(COUT_LA_l1_floating_placement[5] ),
        .COUTF(COUT_LA_l1_floating_placement[6] ),
        .COUTH(COUT_LA_l1_floating_placement[7] ),
        .CIN  (CIN_LA_l1_floating_placement[1]  ),
        .CYA  (CY_LA_l1_floating_placement[8]   ),
        .CYB  (CY_LA_l1_floating_placement[9]   ),
        .CYC  (CY_LA_l1_floating_placement[10]  ),
        .CYD  (CY_LA_l1_floating_placement[11]  ),
        .CYE  (CY_LA_l1_floating_placement[12]  ),
        .CYF  (CY_LA_l1_floating_placement[13]  ),
        .CYG  (CY_LA_l1_floating_placement[14]  ),
        .CYH  (CY_LA_l1_floating_placement[15]  ),
        .PROPA(PROP_LA_l1_floating_placement[8] ),
        .PROPB(PROP_LA_l1_floating_placement[9] ),
        .PROPC(PROP_LA_l1_floating_placement[10]),
        .PROPD(PROP_LA_l1_floating_placement[11]),
        .PROPE(PROP_LA_l1_floating_placement[12]),
        .PROPF(PROP_LA_l1_floating_placement[13]),
        .PROPG(PROP_LA_l1_floating_placement[14]),
        .PROPH(PROP_LA_l1_floating_placement[15]));

    assign CY_LA_l1_floating_placement[1:0]   = CY_c9_41_l1_f2;
    assign PROP_LA_l1_floating_placement[1:0] = PROP_c9_41_l1_f2;
    assign CIN_LA_l1_floating_placement[0] = C0_c9_41_l1_f2[8];
    
    assign CY_LA_l1_floating_placement[3:2]   = CY_c9_41_l1_f3;
    assign PROP_LA_l1_floating_placement[3:2] = PROP_c9_41_l1_f3;
    
    assign CY_LA_l1_floating_placement[5:4]   = CY_c9_41_l1_f4;
    assign PROP_LA_l1_floating_placement[5:4] = PROP_c9_41_l1_f4;
    
    assign CY_LA_l1_floating_placement[7:6]   = CY_c9_41_l1_f5;
    assign PROP_LA_l1_floating_placement[7:6] = PROP_c9_41_l1_f5;
    
    assign CY_LA_l1_floating_placement[9:8]   = CY_c9_41_l1_f6;
    assign PROP_LA_l1_floating_placement[9:8] = PROP_c9_41_l1_f6;
    assign CIN_LA_l1_floating_placement[1] = C0_c9_41_l1_f6[8];
    
    assign layer2_col0[1] = layer1_col0[13];
    assign layer2_col0[2] = layer1_col0[14];
    assign layer2_col0[3] = layer1_col0[15];
    assign layer2_col1[13] = layer1_col1[157];
    assign layer2_col1[14] = layer1_col1[158];
    assign layer2_col1[15] = layer1_col1[159];
    assign layer2_col2[53] = layer1_col2[90];
    assign layer2_col2[54] = layer1_col2[91];
    assign layer2_col2[55] = layer1_col2[92];
    assign layer2_col2[56] = layer1_col2[93];
    assign layer2_col2[57] = layer1_col2[94];
    assign layer2_col2[58] = layer1_col2[95];
    assign layer2_col2[59] = layer1_col2[96];
    assign layer2_col2[60] = layer1_col2[97];
    assign layer2_col2[61] = layer1_col2[98];
    assign layer2_col2[62] = layer1_col2[99];
    assign layer2_col2[63] = layer1_col2[100];
    assign layer2_col2[64] = layer1_col2[101];
    assign layer2_col2[65] = layer1_col2[102];
    assign layer2_col2[66] = layer1_col2[103];
    assign layer2_col2[67] = layer1_col2[104];
    assign layer2_col2[68] = layer1_col2[105];
    assign layer2_col2[69] = layer1_col2[106];
    assign layer2_col2[70] = layer1_col2[107];
    // ------------------------------ LAYER 2 ------------------------------
    // GPC0 in layer2: (4,13 : 3,4,1) at column 1
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l2_f0(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l2_f0   ),
        .C1   (C1_c413_341_l2_f0   ),
        .CLA  (CLA_c413_341_l2_f0  ),
        .O0   (O0_c413_341_l2_f0   ),
        .O1   (O1_c413_341_l2_f0   ),
        .O2   (O2_c413_341_l2_f0   ),
        .CY0  (CY0_c413_341_l2_f0  ),
        .PROP0(PROP0_c413_341_l2_f0),
        .CY1  (CY1_c413_341_l2_f0  ),
        .PROP1(PROP1_c413_341_l2_f0));
    
    assign C0_c413_341_l2_f0 = layer2_col1[12:0];
    assign C1_c413_341_l2_f0 = layer2_col2[3:0];
    
    assign layer3_col1[0]   = O0_c413_341_l2_f0;
    assign layer3_col2[3:0] = O1_c413_341_l2_f0;
    assign layer3_col3[2:0] = O2_c413_341_l2_f0;
    
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

    assign CLA_c413_341_l2_f0[0] = COUT_LA_l2_f0[0];
    assign CLA_c413_341_l2_f0[1] = COUT_LA_l2_f0[2];
    assign CIN_LA_l2_f0          = C0_c413_341_l2_f0[8];
    assign CY_LA_l2_f0[2:0]      = CY0_c413_341_l2_f0;
    assign CY_LA_l2_f0[6:4]      = CY1_c413_341_l2_f0;
    assign PROP_LA_l2_f0[2:0]    = PROP0_c413_341_l2_f0;
    assign PROP_LA_l2_f0[6:4]    = PROP1_c413_341_l2_f0;
    assign PROP_LA_l2_f0[3]      = 1'b0;
    assign CY_LA_l2_f0[3]        = 1'b0;
    
    // GPC1 in layer2: (5,17 : 4,5,1) at column 2
    
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
    
    assign C0_c517_451_l2_f1 = layer2_col2[20:4];
    assign C1_c517_451_l2_f1 = layer2_col3[4:0];
    
    assign layer3_col2[4]   = O0_c517_451_l2_f1;
    assign layer3_col3[7:3] = O1_c517_451_l2_f1;
    assign layer3_col4[3:0] = O2_c517_451_l2_f1;
    
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
    
    // GPC2 in layer2: (9 : 4,1) at column 3
    
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
    
    assign C0_c9_41_l2_f2 = layer2_col3[13:5];
    
    assign layer3_col3[8]   = O0_c9_41_l2_f2;
    assign layer3_col4[7:4] = O1_c9_41_l2_f2;
    
    // GPC3 in layer2: (9 : 4,1) at column 3
    
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
    
    assign C0_c9_41_l2_f3 = layer2_col3[22:14];
    
    assign layer3_col3[9]    = O0_c9_41_l2_f3;
    assign layer3_col4[11:8] = O1_c9_41_l2_f3;
    
    // GPC4 in layer2: (9 : 4,1) at column 3
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l2_f4 = layer2_col3[31:23];
    
    assign layer3_col3[10]    = O0_c9_41_l2_f4;
    assign layer3_col4[15:12] = O1_c9_41_l2_f4;
    
    // GPC5 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l2_f5 = layer2_col2[37:21];
    assign C1_c517_451_l2_f5 = layer2_col3[36:32];
    
    assign layer3_col2[5]     = O0_c517_451_l2_f5;
    assign layer3_col3[15:11] = O1_c517_451_l2_f5;
    assign layer3_col4[19:16] = O2_c517_451_l2_f5;
    
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
    
    // GPC6 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l2_f6 = layer2_col2[54:38];
    assign C1_c517_451_l2_f6 = layer2_col3[41:37];
    
    assign layer3_col2[6]     = O0_c517_451_l2_f6;
    assign layer3_col3[20:16] = O1_c517_451_l2_f6;
    assign layer3_col4[23:20] = O2_c517_451_l2_f6;
    
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
    
    // GPC7 in layer2: (4,13 : 3,4,1) at column 2
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l2_f7(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l2_f7   ),
        .C1   (C1_c413_341_l2_f7   ),
        .CLA  (CLA_c413_341_l2_f7  ),
        .O0   (O0_c413_341_l2_f7   ),
        .O1   (O1_c413_341_l2_f7   ),
        .O2   (O2_c413_341_l2_f7   ),
        .CY0  (CY0_c413_341_l2_f7  ),
        .PROP0(PROP0_c413_341_l2_f7),
        .CY1  (CY1_c413_341_l2_f7  ),
        .PROP1(PROP1_c413_341_l2_f7));
    
    assign C0_c413_341_l2_f7 = layer2_col2[67:55];
    assign C1_c413_341_l2_f7 = layer2_col3[45:42];
    
    assign layer3_col2[7]     = O0_c413_341_l2_f7;
    assign layer3_col3[24:21] = O1_c413_341_l2_f7;
    assign layer3_col4[26:24] = O2_c413_341_l2_f7;
    
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

    assign CLA_c413_341_l2_f7[0] = COUT_LA_l2_f7[0];
    assign CLA_c413_341_l2_f7[1] = COUT_LA_l2_f7[2];
    assign CIN_LA_l2_f7          = C0_c413_341_l2_f7[8];
    assign CY_LA_l2_f7[2:0]      = CY0_c413_341_l2_f7;
    assign CY_LA_l2_f7[6:4]      = CY1_c413_341_l2_f7;
    assign PROP_LA_l2_f7[2:0]    = PROP0_c413_341_l2_f7;
    assign PROP_LA_l2_f7[6:4]    = PROP1_c413_341_l2_f7;
    assign PROP_LA_l2_f7[3]      = 1'b0;
    assign CY_LA_l2_f7[3]        = 1'b0;
    
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
    
    assign CY_LA_l2_floating_placement[5:4]   = CY_c9_41_l2_f4;
    assign PROP_LA_l2_floating_placement[5:4] = PROP_c9_41_l2_f4;
    
    assign layer3_col0[0] = layer2_col0[0];
    assign layer3_col0[1] = layer2_col0[1];
    assign layer3_col0[2] = layer2_col0[2];
    assign layer3_col0[3] = layer2_col0[3];
    assign layer3_col1[1] = layer2_col1[13];
    assign layer3_col1[2] = layer2_col1[14];
    assign layer3_col1[3] = layer2_col1[15];
    assign layer3_col2[8] = layer2_col2[68];
    assign layer3_col2[9] = layer2_col2[69];
    assign layer3_col2[10] = layer2_col2[70];
    assign layer3_col3[25] = layer2_col3[46];
    assign layer3_col3[26] = layer2_col3[47];
    assign layer3_col3[27] = layer2_col3[48];
    assign layer3_col3[28] = layer2_col3[49];
    assign layer3_col3[29] = layer2_col3[50];
    assign layer3_col3[30] = layer2_col3[51];
    assign layer3_col3[31] = layer2_col3[52];
    assign layer3_col3[32] = layer2_col3[53];
    assign layer3_col3[33] = layer2_col3[54];
    assign layer3_col3[34] = layer2_col3[55];
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
    
    assign C0_c15_3_l3_c0_i0 = layer3_col2[4:0];
    assign C1_c15_3_l3_c0_i0 = layer3_col3[0];
    
    assign layer4_col2[0] = O_c15_3_l3_c0_i0[0];
    assign layer4_col3[0] = O_c15_3_l3_c0_i0[1];
    
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
    
    assign C0_c9_41_l3_c0_i1 = {l3_c0_i0, layer3_col4[7:0]};
    
    assign layer4_col4[0]   = O0_c9_41_l3_c0_i1;
    assign layer4_col5[3:0] = O1_c9_41_l3_c0_i1;
    
    assign l3_c0_i1              = COUT_LA_l3_c0_s0[1];
    assign CY_LA_l3_c0_s0[3:2]   = CY_c9_41_l3_c0_i1;
    assign PROP_LA_l3_c0_s0[3:2] = PROP_c9_41_l3_c0_i1;
    
    // GPC0 in layer3: (9 : 4,1) at column 4
    
    c9_41 #(.OUTREG("TRUE" ),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l3_f0(
        .clk (clk             ),
        .C0  (C0_c9_41_l3_f0  ),
        .CLA (CLA_c9_41_l3_f0 ),
        .O0  (O0_c9_41_l3_f0  ),
        .O1  (O1_c9_41_l3_f0  ),
        .CY  (CY_c9_41_l3_f0  ),
        .PROP(PROP_c9_41_l3_f0));
    
    assign C0_c9_41_l3_f0 = layer3_col4[16:8];
    
    assign layer4_col4[1]   = O0_c9_41_l3_f0;
    assign layer4_col5[7:4] = O1_c9_41_l3_f0;
    
    // GPC1 in layer3: (1,5 : 3] at column 2
    
    c15_3 #(.OUTREG("TRUE" ),
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
    
    assign C0_c15_3_l3_f1 = layer3_col2[9:5];
    assign C1_c15_3_l3_f1 = layer3_col3[1];
    
    assign layer4_col2[1] = O_c15_3_l3_f1[0];
    assign layer4_col3[1] = O_c15_3_l3_f1[1];
    assign layer4_col4[2] = O_c15_3_l3_f1[2];
    
    // GPC2 in layer3: (5,17 : 4,5,1) at column 3
    
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
    
    assign C0_c517_451_l3_f2 = layer3_col3[18:2];
    assign C1_c517_451_l3_f2 = layer3_col4[21:17];
    
    assign layer4_col3[2]    = O0_c517_451_l3_f2;
    assign layer4_col4[7:3]  = O1_c517_451_l3_f2;
    assign layer4_col5[11:8] = O2_c517_451_l3_f2;
    
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
    
    // GPC3 in layer3: (4,13 : 3,4,1) at column 3
    
    c413_341 #(.OUTREG("TRUE" ),
               .LEAVEC("FALSE"))
    c413_341_l3_f3(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l3_f3   ),
        .C1   (C1_c413_341_l3_f3   ),
        .CLA  (CLA_c413_341_l3_f3  ),
        .O0   (O0_c413_341_l3_f3   ),
        .O1   (O1_c413_341_l3_f3   ),
        .O2   (O2_c413_341_l3_f3   ),
        .CY0  (CY0_c413_341_l3_f3  ),
        .PROP0(PROP0_c413_341_l3_f3),
        .CY1  (CY1_c413_341_l3_f3  ),
        .PROP1(PROP1_c413_341_l3_f3));
    
    assign C0_c413_341_l3_f3 = layer3_col3[31:19];
    assign C1_c413_341_l3_f3 = layer3_col4[25:22];
    
    assign layer4_col3[3]     = O0_c413_341_l3_f3;
    assign layer4_col4[11:8]  = O1_c413_341_l3_f3;
    assign layer4_col5[14:12] = O2_c413_341_l3_f3;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f3_inst0 (
        .COUTB(COUT_LA_l3_f3[0]),
        .COUTD(COUT_LA_l3_f3[1]),
        .COUTF(COUT_LA_l3_f3[2]),
        .COUTH(COUT_LA_l3_f3[3]),
        .CIN  (CIN_LA_l3_f3    ),
        .CYA  (CY_LA_l3_f3[0]  ),
        .CYB  (CY_LA_l3_f3[1]  ),
        .CYC  (CY_LA_l3_f3[2]  ),
        .CYD  (CY_LA_l3_f3[3]  ),
        .CYE  (CY_LA_l3_f3[4]  ),
        .CYF  (CY_LA_l3_f3[5]  ),
        .CYG  (CY_LA_l3_f3[6]  ),
        .CYH  (CY_LA_l3_f3[7]  ),
        .PROPA(PROP_LA_l3_f3[0]),
        .PROPB(PROP_LA_l3_f3[1]),
        .PROPC(PROP_LA_l3_f3[2]),
        .PROPD(PROP_LA_l3_f3[3]),
        .PROPE(PROP_LA_l3_f3[4]),
        .PROPF(PROP_LA_l3_f3[5]),
        .PROPG(PROP_LA_l3_f3[6]),
        .PROPH(PROP_LA_l3_f3[7]));

    assign CLA_c413_341_l3_f3[0] = COUT_LA_l3_f3[0];
    assign CLA_c413_341_l3_f3[1] = COUT_LA_l3_f3[2];
    assign CIN_LA_l3_f3          = C0_c413_341_l3_f3[8];
    assign CY_LA_l3_f3[2:0]      = CY0_c413_341_l3_f3;
    assign CY_LA_l3_f3[6:4]      = CY1_c413_341_l3_f3;
    assign PROP_LA_l3_f3[2:0]    = PROP0_c413_341_l3_f3;
    assign PROP_LA_l3_f3[6:4]    = PROP1_c413_341_l3_f3;
    assign PROP_LA_l3_f3[3]      = 1'b0;
    assign CY_LA_l3_f3[3]        = 1'b0;
    
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

    assign CY_LA_l3_floating_placement[1:0]   = CY_c9_41_l3_f0;
    assign PROP_LA_l3_floating_placement[1:0] = PROP_c9_41_l3_f0;
    assign CIN_LA_l3_floating_placement    = C0_c9_41_l3_f0[8];
    
    assign CY_LA_l3_floating_placement[3:2]   = CY_c15_3_l3_f1;
    assign PROP_LA_l3_floating_placement[3:2] = PROP_c15_3_l3_f1;
    
    always_ff @(posedge clk) begin
        layer4_col0[0] <= layer3_col0[0];
        layer4_col0[1] <= layer3_col0[1];
        layer4_col0[2] <= layer3_col0[2];
        layer4_col0[3] <= layer3_col0[3];
        layer4_col1[0] <= layer3_col1[0];
        layer4_col1[1] <= layer3_col1[1];
        layer4_col1[2] <= layer3_col1[2];
        layer4_col1[3] <= layer3_col1[3];
        layer4_col2[2] <= layer3_col2[10];
        layer4_col3[4] <= layer3_col3[32];
        layer4_col3[5] <= layer3_col3[33];
        layer4_col3[6] <= layer3_col3[34];
        layer4_col4[12] <= layer3_col4[26];
    end
    
    // ------------------------------ LAYER 4 ------------------------------
    // GPC chain0 in layer4:
    // -- (1,5 : 3] at column 3
    // -- (9 : 4,1) at column 5
    
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
    
    assign C0_c15_3_l4_c0_i0 = layer4_col3[4:0];
    assign C1_c15_3_l4_c0_i0 = layer4_col4[0];
    
    assign layer5_col3[0] = O_c15_3_l4_c0_i0[0];
    assign layer5_col4[0] = O_c15_3_l4_c0_i0[1];
    
    assign l4_c0_i0              = COUT_LA_l4_c0_s0[0];
    assign CY_LA_l4_c0_s0[1:0]   = CY_c15_3_l4_c0_i0;
    assign PROP_LA_l4_c0_s0[1:0] = PROP_c15_3_l4_c0_i0;
    
    assign CIN_LA_l4_c0_s0    = C0_c15_3_l4_c0_i0[4];
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l4_c0_i1 = {l4_c0_i0, layer4_col5[7:0]};
    
    assign layer5_col5[0]   = O0_c9_41_l4_c0_i1;
    assign layer5_col6[3:0] = O1_c9_41_l4_c0_i1;
    
    assign l4_c0_i1              = COUT_LA_l4_c0_s0[1];
    assign CY_LA_l4_c0_s0[3:2]   = CY_c9_41_l4_c0_i1;
    assign PROP_LA_l4_c0_s0[3:2] = PROP_c9_41_l4_c0_i1;
    
    // GPC0 in layer4: (3,9 : 2,3,1) at column 4
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l4_f0(
        .clk  (clk                ),
        .C0   (C0_c39_231_l4_f0   ),
        .C1   (C1_c39_231_l4_f0   ),
        .CLA  (CLA_c39_231_l4_f0  ),
        .O0   (O0_c39_231_l4_f0   ),
        .O1   (O1_c39_231_l4_f0   ),
        .O2   (O2_c39_231_l4_f0   ),
        .CY0  (CY0_c39_231_l4_f0  ),
        .CY1  (CY1_c39_231_l4_f0  ),
        .PROP0(PROP0_c39_231_l4_f0),
        .PROP1(PROP1_c39_231_l4_f0));
    
    assign C0_c39_231_l4_f0 = layer4_col4[9:1];
    assign C1_c39_231_l4_f0 = layer4_col5[10:8];
    
    assign layer5_col4[1]   = O0_c39_231_l4_f0;
    assign layer5_col5[3:1] = O1_c39_231_l4_f0;
    assign layer5_col6[5:4] = O2_c39_231_l4_f0;
    
    // GPC1 in layer4: (3 : 2] at column 4
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l4_f1(
        .clk (clk            ),
        .C0  (C0_c3_2_l4_f1  ),
        .O   (O_c3_2_l4_i1   ),
        .CY  (CY_c3_2_l4_f1  ),
        .PROP(PROP_c3_2_l4_f1));
    
    assign C0_c3_2_l4_f1 = layer4_col4[12:10];
    
    assign layer5_col4[2] = O_c3_2_l4_i1[0];
    assign layer5_col5[4] = O_c3_2_l4_i1[1];
    
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

    assign CY_LA_l4_floating_placement[1:0]   = CY0_c39_231_l4_f0;
    assign PROP_LA_l4_floating_placement[1:0] = PROP0_c39_231_l4_f0;
    assign CY_LA_l4_floating_placement[3:2]   = CY1_c39_231_l4_f0;
    assign PROP_LA_l4_floating_placement[3:2] = PROP1_c39_231_l4_f0;
    assign CIN_LA_l4_floating_placement    = C0_c39_231_l4_f0[8];
    
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
    assign layer5_col5[5] = layer4_col5[11];
    assign layer5_col5[6] = layer4_col5[12];
    assign layer5_col5[7] = layer4_col5[13];
    assign layer5_col5[8] = layer4_col5[14];
    // ------------------------------ LAYER 5 ------------------------------
    // GPC0 in layer5: (1,5 : 3] at column 5
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l5_f0(
        .clk (clk             ),
        .C0  (C0_c15_3_l5_f0  ),
        .C1  (C1_c15_3_l5_f0  ),
        .CLA (CLA_c15_3_l5_f0 ),
        .O   (O_c15_3_l5_f0   ),
        .CY  (CY_c15_3_l5_f0  ),
        .PROP(PROP_c15_3_l5_f0));
    
    assign C0_c15_3_l5_f0 = layer5_col5[4:0];
    assign C1_c15_3_l5_f0 = layer5_col6[0];
    
    assign layer6_col5[0] = O_c15_3_l5_f0[0];
    assign layer6_col6[0] = O_c15_3_l5_f0[1];
    assign layer6_col7[0] = O_c15_3_l5_f0[2];
    
    // GPC1 in layer5: (3 : 2] at column 5
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l5_f1(
        .clk (clk            ),
        .C0  (C0_c3_2_l5_f1  ),
        .O   (O_c3_2_l5_i1   ),
        .CY  (CY_c3_2_l5_f1  ),
        .PROP(PROP_c3_2_l5_f1));
    
    assign C0_c3_2_l5_f1 = layer5_col5[7:5];
    
    assign layer6_col5[1] = O_c3_2_l5_i1[0];
    assign layer6_col6[1] = O_c3_2_l5_i1[1];
    
    // GPC2 in layer5: (1,5 : 3] at column 6
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l5_f2(
        .clk (clk             ),
        .C0  (C0_c15_3_l5_f2  ),
        .C1  (C1_c15_3_l5_f2  ),
        .CLA (CLA_c15_3_l5_f2 ),
        .O   (O_c15_3_l5_f2   ),
        .CY  (CY_c15_3_l5_f2  ),
        .PROP(PROP_c15_3_l5_f2));
    
    assign C0_c15_3_l5_f2 = layer5_col6[5:1];
    assign C1_c15_3_l5_f2 = 1'b0;
    
    assign layer6_col6[2] = O_c15_3_l5_f2[0];
    assign layer6_col7[1] = O_c15_3_l5_f2[1];
    assign layer6_col8    = O_c15_3_l5_f2[2];
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l5_floating_placement_inst0 (
        .COUTB(COUT_LA_l5_floating_placement[0]),
        .COUTD(COUT_LA_l5_floating_placement[1]),
        .COUTF(COUT_LA_l5_floating_placement[2]),
        .COUTH(COUT_LA_l5_floating_placement[3]),
        .CIN  (CIN_LA_l5_floating_placement    ),
        .CYA  (CY_LA_l5_floating_placement[0]  ),
        .CYB  (CY_LA_l5_floating_placement[1]  ),
        .CYC  (CY_LA_l5_floating_placement[2]  ),
        .CYD  (CY_LA_l5_floating_placement[3]  ),
        .CYE  (CY_LA_l5_floating_placement[4]  ),
        .CYF  (CY_LA_l5_floating_placement[5]  ),
        .CYG  (CY_LA_l5_floating_placement[6]  ),
        .CYH  (CY_LA_l5_floating_placement[7]  ),
        .PROPA(PROP_LA_l5_floating_placement[0]),
        .PROPB(PROP_LA_l5_floating_placement[1]),
        .PROPC(PROP_LA_l5_floating_placement[2]),
        .PROPD(PROP_LA_l5_floating_placement[3]),
        .PROPE(PROP_LA_l5_floating_placement[4]),
        .PROPF(PROP_LA_l5_floating_placement[5]),
        .PROPG(PROP_LA_l5_floating_placement[6]),
        .PROPH(PROP_LA_l5_floating_placement[7]));

    assign CY_LA_l5_floating_placement[1:0]   = CY_c15_3_l5_f0;
    assign PROP_LA_l5_floating_placement[1:0] = PROP_c15_3_l5_f0;
    assign CIN_LA_l5_floating_placement    = C0_c15_3_l5_f0[4];
    
    assign CY_LA_l5_floating_placement[3:2]   = CY_c15_3_l5_f2;
    assign PROP_LA_l5_floating_placement[3:2] = PROP_c15_3_l5_f2;
    
    assign layer6_col0[0] = layer5_col0[0];
    assign layer6_col0[1] = layer5_col0[1];
    assign layer6_col0[2] = layer5_col0[2];
    assign layer6_col0[3] = layer5_col0[3];
    assign layer6_col1[0] = layer5_col1[0];
    assign layer6_col1[1] = layer5_col1[1];
    assign layer6_col1[2] = layer5_col1[2];
    assign layer6_col1[3] = layer5_col1[3];
    assign layer6_col2[0] = layer5_col2[0];
    assign layer6_col2[1] = layer5_col2[1];
    assign layer6_col2[2] = layer5_col2[2];
    assign layer6_col3[0] = layer5_col3[0];
    assign layer6_col3[1] = layer5_col3[1];
    assign layer6_col3[2] = layer5_col3[2];
    assign layer6_col4[0] = layer5_col4[0];
    assign layer6_col4[1] = layer5_col4[1];
    assign layer6_col4[2] = layer5_col4[2];
    assign layer6_col5[2] = layer5_col5[8];
    
    
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer6_col5[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer6_col5[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer6_col5[2];
    assign C1_c15_3_terminal_chain1_i2    = layer6_col6[0];
    
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
    assign C0_c3_2_terminal_chain1_i3[0] = layer6_col7[0];
    assign C0_c3_2_terminal_chain1_i3[1] = layer6_col7[1];
    
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
    assign C0_c15_3_terminal_chain2_i2[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i2[1] = layer6_col4[1];
    assign C0_c15_3_terminal_chain2_i2[2] = layer6_col4[2];
    assign C1_c15_3_terminal_chain2_i2    = terminal_chain1_out[4];
    
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
    assign C0_c15_3_terminal_chain2_i3[3] = terminal_chain1_out[5];
    assign C0_c15_3_terminal_chain2_i3[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i3[1] = layer6_col6[1];
    assign C0_c15_3_terminal_chain2_i3[2] = layer6_col6[2];
    assign C1_c15_3_terminal_chain2_i3    = terminal_chain1_out[6];
    
    assign terminal_chain2_out[6] = O_c15_3_terminal_chain2_i3[0];
    assign terminal_chain2_out[7] = O_c15_3_terminal_chain2_i3[1];
    
    assign terminal_chain2_i3           = COUT_LA_terminal_chain2[3];
    assign CY_LA_terminal_chain2[7:6]   = CY_c15_3_terminal_chain2_i3;
    assign PROP_LA_terminal_chain2[7:6] = PROP_c15_3_terminal_chain2_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i4(
        .clk (clk                         ),
        .C0  (C0_c3_2_terminal_chain2_i4  ),
        .O   (O_c3_2_terminal_chain2_i4   ),
        .CY  (CY_c3_2_terminal_chain2_i4  ),
        .PROP(PROP_c3_2_terminal_chain2_i4));
    
    assign C0_c3_2_terminal_chain2_i4[2] = terminal_chain2_i3;
    assign C0_c3_2_terminal_chain2_i4[0] = terminal_chain1_out[7];
    assign C0_c3_2_terminal_chain2_i4[1] = layer6_col8;
    
    assign terminal_chain2_out[8] = O_c3_2_terminal_chain2_i4[0];
    assign terminal_chain2_out[9] = O_c3_2_terminal_chain2_i4[1];
    
    assign terminal_chain2_i4         = O_c3_2_terminal_chain2_i4[1];
    assign CY_LA_terminal_chain2[8]   = CY_c3_2_terminal_chain2_i4;
    assign PROP_LA_terminal_chain2[8] = PROP_c3_2_terminal_chain2_i4;
    
    assign CIN_LA_terminal_chain2[1] = COUT_LA_terminal_chain2[3];
    
    always_ff @(posedge clk) begin
        comp_out[9:0] <= terminal_chain2_out[9:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = in_col0;
    assign layer0_col1    = in_col1;
    
endmodule