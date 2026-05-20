`timescale 1ns / 1ps

module Comp_double512_1 (
    input  logic           clk,
    input  logic [511 : 0] in_col0,
    input  logic [511 : 0] in_col1,
    output logic [10  : 0] comp_out
    );

    
    // ------------------------------ LAYER 0 ------------------------------
    logic [511 : 0] layer0_col0;
    logic [511 : 0] layer0_col1;
    
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
    
    logic [8 : 0] C0_c9_41_l0_f24;
    logic         CLA_c9_41_l0_f24;
    logic         O0_c9_41_l0_f24;
    logic [3 : 0] O1_c9_41_l0_f24;
    logic [1 : 0] CY_c9_41_l0_f24;
    logic [1 : 0] PROP_c9_41_l0_f24;
    
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
    
    logic [16 : 0] C0_c517_451_l0_f27;
    logic [4  : 0] C1_c517_451_l0_f27;
    logic [1  : 0] CLA_c517_451_l0_f27;
    logic          O0_c517_451_l0_f27;
    logic [4  : 0] O1_c517_451_l0_f27;
    logic [3  : 0] O2_c517_451_l0_f27;
    logic [3  : 0] CY0_c517_451_l0_f27;
    logic [3  : 0] PROP0_c517_451_l0_f27;
    logic [3  : 0] CY1_c517_451_l0_f27;
    logic [3  : 0] PROP1_c517_451_l0_f27;
    
    logic [3 : 0] COUT_LA_l0_f27;
    logic         CIN_LA_l0_f27;
    logic [7 : 0] CY_LA_l0_f27;
    logic [7 : 0] PROP_LA_l0_f27;
    
    logic [16 : 0] C0_c517_451_l0_f28;
    logic [4  : 0] C1_c517_451_l0_f28;
    logic [1  : 0] CLA_c517_451_l0_f28;
    logic          O0_c517_451_l0_f28;
    logic [4  : 0] O1_c517_451_l0_f28;
    logic [3  : 0] O2_c517_451_l0_f28;
    logic [3  : 0] CY0_c517_451_l0_f28;
    logic [3  : 0] PROP0_c517_451_l0_f28;
    logic [3  : 0] CY1_c517_451_l0_f28;
    logic [3  : 0] PROP1_c517_451_l0_f28;
    
    logic [3 : 0] COUT_LA_l0_f28;
    logic         CIN_LA_l0_f28;
    logic [7 : 0] CY_LA_l0_f28;
    logic [7 : 0] PROP_LA_l0_f28;
    
    logic [16 : 0] C0_c517_451_l0_f29;
    logic [4  : 0] C1_c517_451_l0_f29;
    logic [1  : 0] CLA_c517_451_l0_f29;
    logic          O0_c517_451_l0_f29;
    logic [4  : 0] O1_c517_451_l0_f29;
    logic [3  : 0] O2_c517_451_l0_f29;
    logic [3  : 0] CY0_c517_451_l0_f29;
    logic [3  : 0] PROP0_c517_451_l0_f29;
    logic [3  : 0] CY1_c517_451_l0_f29;
    logic [3  : 0] PROP1_c517_451_l0_f29;
    
    logic [3 : 0] COUT_LA_l0_f29;
    logic         CIN_LA_l0_f29;
    logic [7 : 0] CY_LA_l0_f29;
    logic [7 : 0] PROP_LA_l0_f29;
    
    logic [16 : 0] C0_c517_451_l0_f30;
    logic [4  : 0] C1_c517_451_l0_f30;
    logic [1  : 0] CLA_c517_451_l0_f30;
    logic          O0_c517_451_l0_f30;
    logic [4  : 0] O1_c517_451_l0_f30;
    logic [3  : 0] O2_c517_451_l0_f30;
    logic [3  : 0] CY0_c517_451_l0_f30;
    logic [3  : 0] PROP0_c517_451_l0_f30;
    logic [3  : 0] CY1_c517_451_l0_f30;
    logic [3  : 0] PROP1_c517_451_l0_f30;
    
    logic [3 : 0] COUT_LA_l0_f30;
    logic         CIN_LA_l0_f30;
    logic [7 : 0] CY_LA_l0_f30;
    logic [7 : 0] PROP_LA_l0_f30;
    
    logic [16 : 0] C0_c517_451_l0_f31;
    logic [4  : 0] C1_c517_451_l0_f31;
    logic [1  : 0] CLA_c517_451_l0_f31;
    logic          O0_c517_451_l0_f31;
    logic [4  : 0] O1_c517_451_l0_f31;
    logic [3  : 0] O2_c517_451_l0_f31;
    logic [3  : 0] CY0_c517_451_l0_f31;
    logic [3  : 0] PROP0_c517_451_l0_f31;
    logic [3  : 0] CY1_c517_451_l0_f31;
    logic [3  : 0] PROP1_c517_451_l0_f31;
    
    logic [3 : 0] COUT_LA_l0_f31;
    logic         CIN_LA_l0_f31;
    logic [7 : 0] CY_LA_l0_f31;
    logic [7 : 0] PROP_LA_l0_f31;
    
    logic [16 : 0] C0_c517_451_l0_f32;
    logic [4  : 0] C1_c517_451_l0_f32;
    logic [1  : 0] CLA_c517_451_l0_f32;
    logic          O0_c517_451_l0_f32;
    logic [4  : 0] O1_c517_451_l0_f32;
    logic [3  : 0] O2_c517_451_l0_f32;
    logic [3  : 0] CY0_c517_451_l0_f32;
    logic [3  : 0] PROP0_c517_451_l0_f32;
    logic [3  : 0] CY1_c517_451_l0_f32;
    logic [3  : 0] PROP1_c517_451_l0_f32;
    
    logic [3 : 0] COUT_LA_l0_f32;
    logic         CIN_LA_l0_f32;
    logic [7 : 0] CY_LA_l0_f32;
    logic [7 : 0] PROP_LA_l0_f32;
    
    logic [16 : 0] C0_c517_451_l0_f33;
    logic [4  : 0] C1_c517_451_l0_f33;
    logic [1  : 0] CLA_c517_451_l0_f33;
    logic          O0_c517_451_l0_f33;
    logic [4  : 0] O1_c517_451_l0_f33;
    logic [3  : 0] O2_c517_451_l0_f33;
    logic [3  : 0] CY0_c517_451_l0_f33;
    logic [3  : 0] PROP0_c517_451_l0_f33;
    logic [3  : 0] CY1_c517_451_l0_f33;
    logic [3  : 0] PROP1_c517_451_l0_f33;
    
    logic [3 : 0] COUT_LA_l0_f33;
    logic         CIN_LA_l0_f33;
    logic [7 : 0] CY_LA_l0_f33;
    logic [7 : 0] PROP_LA_l0_f33;
    
    logic [16 : 0] C0_c517_451_l0_f34;
    logic [4  : 0] C1_c517_451_l0_f34;
    logic [1  : 0] CLA_c517_451_l0_f34;
    logic          O0_c517_451_l0_f34;
    logic [4  : 0] O1_c517_451_l0_f34;
    logic [3  : 0] O2_c517_451_l0_f34;
    logic [3  : 0] CY0_c517_451_l0_f34;
    logic [3  : 0] PROP0_c517_451_l0_f34;
    logic [3  : 0] CY1_c517_451_l0_f34;
    logic [3  : 0] PROP1_c517_451_l0_f34;
    
    logic [3 : 0] COUT_LA_l0_f34;
    logic         CIN_LA_l0_f34;
    logic [7 : 0] CY_LA_l0_f34;
    logic [7 : 0] PROP_LA_l0_f34;
    
    logic [16 : 0] C0_c517_451_l0_f35;
    logic [4  : 0] C1_c517_451_l0_f35;
    logic [1  : 0] CLA_c517_451_l0_f35;
    logic          O0_c517_451_l0_f35;
    logic [4  : 0] O1_c517_451_l0_f35;
    logic [3  : 0] O2_c517_451_l0_f35;
    logic [3  : 0] CY0_c517_451_l0_f35;
    logic [3  : 0] PROP0_c517_451_l0_f35;
    logic [3  : 0] CY1_c517_451_l0_f35;
    logic [3  : 0] PROP1_c517_451_l0_f35;
    
    logic [3 : 0] COUT_LA_l0_f35;
    logic         CIN_LA_l0_f35;
    logic [7 : 0] CY_LA_l0_f35;
    logic [7 : 0] PROP_LA_l0_f35;
    
    logic [16 : 0] C0_c517_451_l0_f36;
    logic [4  : 0] C1_c517_451_l0_f36;
    logic [1  : 0] CLA_c517_451_l0_f36;
    logic          O0_c517_451_l0_f36;
    logic [4  : 0] O1_c517_451_l0_f36;
    logic [3  : 0] O2_c517_451_l0_f36;
    logic [3  : 0] CY0_c517_451_l0_f36;
    logic [3  : 0] PROP0_c517_451_l0_f36;
    logic [3  : 0] CY1_c517_451_l0_f36;
    logic [3  : 0] PROP1_c517_451_l0_f36;
    
    logic [3 : 0] COUT_LA_l0_f36;
    logic         CIN_LA_l0_f36;
    logic [7 : 0] CY_LA_l0_f36;
    logic [7 : 0] PROP_LA_l0_f36;
    
    logic [16 : 0] C0_c517_451_l0_f37;
    logic [4  : 0] C1_c517_451_l0_f37;
    logic [1  : 0] CLA_c517_451_l0_f37;
    logic          O0_c517_451_l0_f37;
    logic [4  : 0] O1_c517_451_l0_f37;
    logic [3  : 0] O2_c517_451_l0_f37;
    logic [3  : 0] CY0_c517_451_l0_f37;
    logic [3  : 0] PROP0_c517_451_l0_f37;
    logic [3  : 0] CY1_c517_451_l0_f37;
    logic [3  : 0] PROP1_c517_451_l0_f37;
    
    logic [3 : 0] COUT_LA_l0_f37;
    logic         CIN_LA_l0_f37;
    logic [7 : 0] CY_LA_l0_f37;
    logic [7 : 0] PROP_LA_l0_f37;
    
    logic [16 : 0] C0_c517_451_l0_f38;
    logic [4  : 0] C1_c517_451_l0_f38;
    logic [1  : 0] CLA_c517_451_l0_f38;
    logic          O0_c517_451_l0_f38;
    logic [4  : 0] O1_c517_451_l0_f38;
    logic [3  : 0] O2_c517_451_l0_f38;
    logic [3  : 0] CY0_c517_451_l0_f38;
    logic [3  : 0] PROP0_c517_451_l0_f38;
    logic [3  : 0] CY1_c517_451_l0_f38;
    logic [3  : 0] PROP1_c517_451_l0_f38;
    
    logic [3 : 0] COUT_LA_l0_f38;
    logic         CIN_LA_l0_f38;
    logic [7 : 0] CY_LA_l0_f38;
    logic [7 : 0] PROP_LA_l0_f38;
    
    logic [16 : 0] C0_c517_451_l0_f39;
    logic [4  : 0] C1_c517_451_l0_f39;
    logic [1  : 0] CLA_c517_451_l0_f39;
    logic          O0_c517_451_l0_f39;
    logic [4  : 0] O1_c517_451_l0_f39;
    logic [3  : 0] O2_c517_451_l0_f39;
    logic [3  : 0] CY0_c517_451_l0_f39;
    logic [3  : 0] PROP0_c517_451_l0_f39;
    logic [3  : 0] CY1_c517_451_l0_f39;
    logic [3  : 0] PROP1_c517_451_l0_f39;
    
    logic [3 : 0] COUT_LA_l0_f39;
    logic         CIN_LA_l0_f39;
    logic [7 : 0] CY_LA_l0_f39;
    logic [7 : 0] PROP_LA_l0_f39;
    
    logic [16 : 0] C0_c517_451_l0_f40;
    logic [4  : 0] C1_c517_451_l0_f40;
    logic [1  : 0] CLA_c517_451_l0_f40;
    logic          O0_c517_451_l0_f40;
    logic [4  : 0] O1_c517_451_l0_f40;
    logic [3  : 0] O2_c517_451_l0_f40;
    logic [3  : 0] CY0_c517_451_l0_f40;
    logic [3  : 0] PROP0_c517_451_l0_f40;
    logic [3  : 0] CY1_c517_451_l0_f40;
    logic [3  : 0] PROP1_c517_451_l0_f40;
    
    logic [3 : 0] COUT_LA_l0_f40;
    logic         CIN_LA_l0_f40;
    logic [7 : 0] CY_LA_l0_f40;
    logic [7 : 0] PROP_LA_l0_f40;
    
    logic [16 : 0] C0_c517_451_l0_f41;
    logic [4  : 0] C1_c517_451_l0_f41;
    logic [1  : 0] CLA_c517_451_l0_f41;
    logic          O0_c517_451_l0_f41;
    logic [4  : 0] O1_c517_451_l0_f41;
    logic [3  : 0] O2_c517_451_l0_f41;
    logic [3  : 0] CY0_c517_451_l0_f41;
    logic [3  : 0] PROP0_c517_451_l0_f41;
    logic [3  : 0] CY1_c517_451_l0_f41;
    logic [3  : 0] PROP1_c517_451_l0_f41;
    
    logic [3 : 0] COUT_LA_l0_f41;
    logic         CIN_LA_l0_f41;
    logic [7 : 0] CY_LA_l0_f41;
    logic [7 : 0] PROP_LA_l0_f41;
    
    logic [16 : 0] C0_c517_451_l0_f42;
    logic [4  : 0] C1_c517_451_l0_f42;
    logic [1  : 0] CLA_c517_451_l0_f42;
    logic          O0_c517_451_l0_f42;
    logic [4  : 0] O1_c517_451_l0_f42;
    logic [3  : 0] O2_c517_451_l0_f42;
    logic [3  : 0] CY0_c517_451_l0_f42;
    logic [3  : 0] PROP0_c517_451_l0_f42;
    logic [3  : 0] CY1_c517_451_l0_f42;
    logic [3  : 0] PROP1_c517_451_l0_f42;
    
    logic [3 : 0] COUT_LA_l0_f42;
    logic         CIN_LA_l0_f42;
    logic [7 : 0] CY_LA_l0_f42;
    logic [7 : 0] PROP_LA_l0_f42;
    
    logic [16 : 0] C0_c517_451_l0_f43;
    logic [4  : 0] C1_c517_451_l0_f43;
    logic [1  : 0] CLA_c517_451_l0_f43;
    logic          O0_c517_451_l0_f43;
    logic [4  : 0] O1_c517_451_l0_f43;
    logic [3  : 0] O2_c517_451_l0_f43;
    logic [3  : 0] CY0_c517_451_l0_f43;
    logic [3  : 0] PROP0_c517_451_l0_f43;
    logic [3  : 0] CY1_c517_451_l0_f43;
    logic [3  : 0] PROP1_c517_451_l0_f43;
    
    logic [3 : 0] COUT_LA_l0_f43;
    logic         CIN_LA_l0_f43;
    logic [7 : 0] CY_LA_l0_f43;
    logic [7 : 0] PROP_LA_l0_f43;
    
    logic [16 : 0] C0_c517_451_l0_f44;
    logic [4  : 0] C1_c517_451_l0_f44;
    logic [1  : 0] CLA_c517_451_l0_f44;
    logic          O0_c517_451_l0_f44;
    logic [4  : 0] O1_c517_451_l0_f44;
    logic [3  : 0] O2_c517_451_l0_f44;
    logic [3  : 0] CY0_c517_451_l0_f44;
    logic [3  : 0] PROP0_c517_451_l0_f44;
    logic [3  : 0] CY1_c517_451_l0_f44;
    logic [3  : 0] PROP1_c517_451_l0_f44;
    
    logic [3 : 0] COUT_LA_l0_f44;
    logic         CIN_LA_l0_f44;
    logic [7 : 0] CY_LA_l0_f44;
    logic [7 : 0] PROP_LA_l0_f44;
    
    logic [16 : 0] C0_c517_451_l0_f45;
    logic [4  : 0] C1_c517_451_l0_f45;
    logic [1  : 0] CLA_c517_451_l0_f45;
    logic          O0_c517_451_l0_f45;
    logic [4  : 0] O1_c517_451_l0_f45;
    logic [3  : 0] O2_c517_451_l0_f45;
    logic [3  : 0] CY0_c517_451_l0_f45;
    logic [3  : 0] PROP0_c517_451_l0_f45;
    logic [3  : 0] CY1_c517_451_l0_f45;
    logic [3  : 0] PROP1_c517_451_l0_f45;
    
    logic [3 : 0] COUT_LA_l0_f45;
    logic         CIN_LA_l0_f45;
    logic [7 : 0] CY_LA_l0_f45;
    logic [7 : 0] PROP_LA_l0_f45;
    
    logic [16 : 0] C0_c517_451_l0_f46;
    logic [4  : 0] C1_c517_451_l0_f46;
    logic [1  : 0] CLA_c517_451_l0_f46;
    logic          O0_c517_451_l0_f46;
    logic [4  : 0] O1_c517_451_l0_f46;
    logic [3  : 0] O2_c517_451_l0_f46;
    logic [3  : 0] CY0_c517_451_l0_f46;
    logic [3  : 0] PROP0_c517_451_l0_f46;
    logic [3  : 0] CY1_c517_451_l0_f46;
    logic [3  : 0] PROP1_c517_451_l0_f46;
    
    logic [3 : 0] COUT_LA_l0_f46;
    logic         CIN_LA_l0_f46;
    logic [7 : 0] CY_LA_l0_f46;
    logic [7 : 0] PROP_LA_l0_f46;
    
    logic [16 : 0] C0_c517_451_l0_f47;
    logic [4  : 0] C1_c517_451_l0_f47;
    logic [1  : 0] CLA_c517_451_l0_f47;
    logic          O0_c517_451_l0_f47;
    logic [4  : 0] O1_c517_451_l0_f47;
    logic [3  : 0] O2_c517_451_l0_f47;
    logic [3  : 0] CY0_c517_451_l0_f47;
    logic [3  : 0] PROP0_c517_451_l0_f47;
    logic [3  : 0] CY1_c517_451_l0_f47;
    logic [3  : 0] PROP1_c517_451_l0_f47;
    
    logic [3 : 0] COUT_LA_l0_f47;
    logic         CIN_LA_l0_f47;
    logic [7 : 0] CY_LA_l0_f47;
    logic [7 : 0] PROP_LA_l0_f47;
    
    logic [16 : 0] C0_c517_451_l0_f48;
    logic [4  : 0] C1_c517_451_l0_f48;
    logic [1  : 0] CLA_c517_451_l0_f48;
    logic          O0_c517_451_l0_f48;
    logic [4  : 0] O1_c517_451_l0_f48;
    logic [3  : 0] O2_c517_451_l0_f48;
    logic [3  : 0] CY0_c517_451_l0_f48;
    logic [3  : 0] PROP0_c517_451_l0_f48;
    logic [3  : 0] CY1_c517_451_l0_f48;
    logic [3  : 0] PROP1_c517_451_l0_f48;
    
    logic [3 : 0] COUT_LA_l0_f48;
    logic         CIN_LA_l0_f48;
    logic [7 : 0] CY_LA_l0_f48;
    logic [7 : 0] PROP_LA_l0_f48;
    
    logic [16 : 0] C0_c517_451_l0_f49;
    logic [4  : 0] C1_c517_451_l0_f49;
    logic [1  : 0] CLA_c517_451_l0_f49;
    logic          O0_c517_451_l0_f49;
    logic [4  : 0] O1_c517_451_l0_f49;
    logic [3  : 0] O2_c517_451_l0_f49;
    logic [3  : 0] CY0_c517_451_l0_f49;
    logic [3  : 0] PROP0_c517_451_l0_f49;
    logic [3  : 0] CY1_c517_451_l0_f49;
    logic [3  : 0] PROP1_c517_451_l0_f49;
    
    logic [3 : 0] COUT_LA_l0_f49;
    logic         CIN_LA_l0_f49;
    logic [7 : 0] CY_LA_l0_f49;
    logic [7 : 0] PROP_LA_l0_f49;
    
    logic [16 : 0] C0_c517_451_l0_f50;
    logic [4  : 0] C1_c517_451_l0_f50;
    logic [1  : 0] CLA_c517_451_l0_f50;
    logic          O0_c517_451_l0_f50;
    logic [4  : 0] O1_c517_451_l0_f50;
    logic [3  : 0] O2_c517_451_l0_f50;
    logic [3  : 0] CY0_c517_451_l0_f50;
    logic [3  : 0] PROP0_c517_451_l0_f50;
    logic [3  : 0] CY1_c517_451_l0_f50;
    logic [3  : 0] PROP1_c517_451_l0_f50;
    
    logic [3 : 0] COUT_LA_l0_f50;
    logic         CIN_LA_l0_f50;
    logic [7 : 0] CY_LA_l0_f50;
    logic [7 : 0] PROP_LA_l0_f50;
    
    logic [16 : 0] C0_c517_451_l0_f51;
    logic [4  : 0] C1_c517_451_l0_f51;
    logic [1  : 0] CLA_c517_451_l0_f51;
    logic          O0_c517_451_l0_f51;
    logic [4  : 0] O1_c517_451_l0_f51;
    logic [3  : 0] O2_c517_451_l0_f51;
    logic [3  : 0] CY0_c517_451_l0_f51;
    logic [3  : 0] PROP0_c517_451_l0_f51;
    logic [3  : 0] CY1_c517_451_l0_f51;
    logic [3  : 0] PROP1_c517_451_l0_f51;
    
    logic [3 : 0] COUT_LA_l0_f51;
    logic         CIN_LA_l0_f51;
    logic [7 : 0] CY_LA_l0_f51;
    logic [7 : 0] PROP_LA_l0_f51;
    
    logic [16 : 0] C0_c517_451_l0_f52;
    logic [4  : 0] C1_c517_451_l0_f52;
    logic [1  : 0] CLA_c517_451_l0_f52;
    logic          O0_c517_451_l0_f52;
    logic [4  : 0] O1_c517_451_l0_f52;
    logic [3  : 0] O2_c517_451_l0_f52;
    logic [3  : 0] CY0_c517_451_l0_f52;
    logic [3  : 0] PROP0_c517_451_l0_f52;
    logic [3  : 0] CY1_c517_451_l0_f52;
    logic [3  : 0] PROP1_c517_451_l0_f52;
    
    logic [3 : 0] COUT_LA_l0_f52;
    logic         CIN_LA_l0_f52;
    logic [7 : 0] CY_LA_l0_f52;
    logic [7 : 0] PROP_LA_l0_f52;
    
    logic [16 : 0] C0_c517_451_l0_f53;
    logic [4  : 0] C1_c517_451_l0_f53;
    logic [1  : 0] CLA_c517_451_l0_f53;
    logic          O0_c517_451_l0_f53;
    logic [4  : 0] O1_c517_451_l0_f53;
    logic [3  : 0] O2_c517_451_l0_f53;
    logic [3  : 0] CY0_c517_451_l0_f53;
    logic [3  : 0] PROP0_c517_451_l0_f53;
    logic [3  : 0] CY1_c517_451_l0_f53;
    logic [3  : 0] PROP1_c517_451_l0_f53;
    
    logic [3 : 0] COUT_LA_l0_f53;
    logic         CIN_LA_l0_f53;
    logic [7 : 0] CY_LA_l0_f53;
    logic [7 : 0] PROP_LA_l0_f53;
    
    logic [23 : 0] COUT_LA_l0_floating_placement;
    logic [5  : 0] CIN_LA_l0_floating_placement;
    logic [47 : 0] CY_LA_l0_floating_placement;
    logic [47 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
    logic [31  : 0] layer1_col0;
    logic [319 : 0] layer1_col1;
    logic [215 : 0] layer1_col2;
    
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
    
    logic [8 : 0] C0_c9_41_l1_f7;
    logic         CLA_c9_41_l1_f7;
    logic         O0_c9_41_l1_f7;
    logic [3 : 0] O1_c9_41_l1_f7;
    logic [1 : 0] CY_c9_41_l1_f7;
    logic [1 : 0] PROP_c9_41_l1_f7;
    
    logic [8 : 0] C0_c9_41_l1_f8;
    logic         CLA_c9_41_l1_f8;
    logic         O0_c9_41_l1_f8;
    logic [3 : 0] O1_c9_41_l1_f8;
    logic [1 : 0] CY_c9_41_l1_f8;
    logic [1 : 0] PROP_c9_41_l1_f8;
    
    logic [8 : 0] C0_c9_41_l1_f9;
    logic         CLA_c9_41_l1_f9;
    logic         O0_c9_41_l1_f9;
    logic [3 : 0] O1_c9_41_l1_f9;
    logic [1 : 0] CY_c9_41_l1_f9;
    logic [1 : 0] PROP_c9_41_l1_f9;
    
    logic [8 : 0] C0_c9_41_l1_f10;
    logic         CLA_c9_41_l1_f10;
    logic         O0_c9_41_l1_f10;
    logic [3 : 0] O1_c9_41_l1_f10;
    logic [1 : 0] CY_c9_41_l1_f10;
    logic [1 : 0] PROP_c9_41_l1_f10;
    
    logic [8 : 0] C0_c9_41_l1_f11;
    logic         CLA_c9_41_l1_f11;
    logic         O0_c9_41_l1_f11;
    logic [3 : 0] O1_c9_41_l1_f11;
    logic [1 : 0] CY_c9_41_l1_f11;
    logic [1 : 0] PROP_c9_41_l1_f11;
    
    logic [12 : 0] C0_c413_341_l1_f12;
    logic [3  : 0] C1_c413_341_l1_f12;
    logic [1  : 0] CLA_c413_341_l1_f12;
    logic          O0_c413_341_l1_f12;
    logic [3  : 0] O1_c413_341_l1_f12;
    logic [2  : 0] O2_c413_341_l1_f12;
    logic [2  : 0] CY0_c413_341_l1_f12;
    logic [2  : 0] PROP0_c413_341_l1_f12;
    logic [2  : 0] CY1_c413_341_l1_f12;
    logic [2  : 0] PROP1_c413_341_l1_f12;
    
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
    
    logic [16 : 0] C0_c517_451_l1_f16;
    logic [4  : 0] C1_c517_451_l1_f16;
    logic [1  : 0] CLA_c517_451_l1_f16;
    logic          O0_c517_451_l1_f16;
    logic [4  : 0] O1_c517_451_l1_f16;
    logic [3  : 0] O2_c517_451_l1_f16;
    logic [3  : 0] CY0_c517_451_l1_f16;
    logic [3  : 0] PROP0_c517_451_l1_f16;
    logic [3  : 0] CY1_c517_451_l1_f16;
    logic [3  : 0] PROP1_c517_451_l1_f16;
    
    logic [3 : 0] COUT_LA_l1_f16;
    logic         CIN_LA_l1_f16;
    logic [7 : 0] CY_LA_l1_f16;
    logic [7 : 0] PROP_LA_l1_f16;
    
    logic [16 : 0] C0_c517_451_l1_f17;
    logic [4  : 0] C1_c517_451_l1_f17;
    logic [1  : 0] CLA_c517_451_l1_f17;
    logic          O0_c517_451_l1_f17;
    logic [4  : 0] O1_c517_451_l1_f17;
    logic [3  : 0] O2_c517_451_l1_f17;
    logic [3  : 0] CY0_c517_451_l1_f17;
    logic [3  : 0] PROP0_c517_451_l1_f17;
    logic [3  : 0] CY1_c517_451_l1_f17;
    logic [3  : 0] PROP1_c517_451_l1_f17;
    
    logic [3 : 0] COUT_LA_l1_f17;
    logic         CIN_LA_l1_f17;
    logic [7 : 0] CY_LA_l1_f17;
    logic [7 : 0] PROP_LA_l1_f17;
    
    logic [16 : 0] C0_c517_451_l1_f18;
    logic [4  : 0] C1_c517_451_l1_f18;
    logic [1  : 0] CLA_c517_451_l1_f18;
    logic          O0_c517_451_l1_f18;
    logic [4  : 0] O1_c517_451_l1_f18;
    logic [3  : 0] O2_c517_451_l1_f18;
    logic [3  : 0] CY0_c517_451_l1_f18;
    logic [3  : 0] PROP0_c517_451_l1_f18;
    logic [3  : 0] CY1_c517_451_l1_f18;
    logic [3  : 0] PROP1_c517_451_l1_f18;
    
    logic [3 : 0] COUT_LA_l1_f18;
    logic         CIN_LA_l1_f18;
    logic [7 : 0] CY_LA_l1_f18;
    logic [7 : 0] PROP_LA_l1_f18;
    
    logic [16 : 0] C0_c517_451_l1_f19;
    logic [4  : 0] C1_c517_451_l1_f19;
    logic [1  : 0] CLA_c517_451_l1_f19;
    logic          O0_c517_451_l1_f19;
    logic [4  : 0] O1_c517_451_l1_f19;
    logic [3  : 0] O2_c517_451_l1_f19;
    logic [3  : 0] CY0_c517_451_l1_f19;
    logic [3  : 0] PROP0_c517_451_l1_f19;
    logic [3  : 0] CY1_c517_451_l1_f19;
    logic [3  : 0] PROP1_c517_451_l1_f19;
    
    logic [3 : 0] COUT_LA_l1_f19;
    logic         CIN_LA_l1_f19;
    logic [7 : 0] CY_LA_l1_f19;
    logic [7 : 0] PROP_LA_l1_f19;
    
    logic [16 : 0] C0_c517_451_l1_f20;
    logic [4  : 0] C1_c517_451_l1_f20;
    logic [1  : 0] CLA_c517_451_l1_f20;
    logic          O0_c517_451_l1_f20;
    logic [4  : 0] O1_c517_451_l1_f20;
    logic [3  : 0] O2_c517_451_l1_f20;
    logic [3  : 0] CY0_c517_451_l1_f20;
    logic [3  : 0] PROP0_c517_451_l1_f20;
    logic [3  : 0] CY1_c517_451_l1_f20;
    logic [3  : 0] PROP1_c517_451_l1_f20;
    
    logic [3 : 0] COUT_LA_l1_f20;
    logic         CIN_LA_l1_f20;
    logic [7 : 0] CY_LA_l1_f20;
    logic [7 : 0] PROP_LA_l1_f20;
    
    logic [16 : 0] C0_c517_451_l1_f21;
    logic [4  : 0] C1_c517_451_l1_f21;
    logic [1  : 0] CLA_c517_451_l1_f21;
    logic          O0_c517_451_l1_f21;
    logic [4  : 0] O1_c517_451_l1_f21;
    logic [3  : 0] O2_c517_451_l1_f21;
    logic [3  : 0] CY0_c517_451_l1_f21;
    logic [3  : 0] PROP0_c517_451_l1_f21;
    logic [3  : 0] CY1_c517_451_l1_f21;
    logic [3  : 0] PROP1_c517_451_l1_f21;
    
    logic [3 : 0] COUT_LA_l1_f21;
    logic         CIN_LA_l1_f21;
    logic [7 : 0] CY_LA_l1_f21;
    logic [7 : 0] PROP_LA_l1_f21;
    
    logic [16 : 0] C0_c517_451_l1_f22;
    logic [4  : 0] C1_c517_451_l1_f22;
    logic [1  : 0] CLA_c517_451_l1_f22;
    logic          O0_c517_451_l1_f22;
    logic [4  : 0] O1_c517_451_l1_f22;
    logic [3  : 0] O2_c517_451_l1_f22;
    logic [3  : 0] CY0_c517_451_l1_f22;
    logic [3  : 0] PROP0_c517_451_l1_f22;
    logic [3  : 0] CY1_c517_451_l1_f22;
    logic [3  : 0] PROP1_c517_451_l1_f22;
    
    logic [3 : 0] COUT_LA_l1_f22;
    logic         CIN_LA_l1_f22;
    logic [7 : 0] CY_LA_l1_f22;
    logic [7 : 0] PROP_LA_l1_f22;
    
    logic [16 : 0] C0_c517_451_l1_f23;
    logic [4  : 0] C1_c517_451_l1_f23;
    logic [1  : 0] CLA_c517_451_l1_f23;
    logic          O0_c517_451_l1_f23;
    logic [4  : 0] O1_c517_451_l1_f23;
    logic [3  : 0] O2_c517_451_l1_f23;
    logic [3  : 0] CY0_c517_451_l1_f23;
    logic [3  : 0] PROP0_c517_451_l1_f23;
    logic [3  : 0] CY1_c517_451_l1_f23;
    logic [3  : 0] PROP1_c517_451_l1_f23;
    
    logic [3 : 0] COUT_LA_l1_f23;
    logic         CIN_LA_l1_f23;
    logic [7 : 0] CY_LA_l1_f23;
    logic [7 : 0] PROP_LA_l1_f23;
    
    logic [16 : 0] C0_c517_451_l1_f24;
    logic [4  : 0] C1_c517_451_l1_f24;
    logic [1  : 0] CLA_c517_451_l1_f24;
    logic          O0_c517_451_l1_f24;
    logic [4  : 0] O1_c517_451_l1_f24;
    logic [3  : 0] O2_c517_451_l1_f24;
    logic [3  : 0] CY0_c517_451_l1_f24;
    logic [3  : 0] PROP0_c517_451_l1_f24;
    logic [3  : 0] CY1_c517_451_l1_f24;
    logic [3  : 0] PROP1_c517_451_l1_f24;
    
    logic [3 : 0] COUT_LA_l1_f24;
    logic         CIN_LA_l1_f24;
    logic [7 : 0] CY_LA_l1_f24;
    logic [7 : 0] PROP_LA_l1_f24;
    
    logic [16 : 0] C0_c517_451_l1_f25;
    logic [4  : 0] C1_c517_451_l1_f25;
    logic [1  : 0] CLA_c517_451_l1_f25;
    logic          O0_c517_451_l1_f25;
    logic [4  : 0] O1_c517_451_l1_f25;
    logic [3  : 0] O2_c517_451_l1_f25;
    logic [3  : 0] CY0_c517_451_l1_f25;
    logic [3  : 0] PROP0_c517_451_l1_f25;
    logic [3  : 0] CY1_c517_451_l1_f25;
    logic [3  : 0] PROP1_c517_451_l1_f25;
    
    logic [3 : 0] COUT_LA_l1_f25;
    logic         CIN_LA_l1_f25;
    logic [7 : 0] CY_LA_l1_f25;
    logic [7 : 0] PROP_LA_l1_f25;
    
    logic [16 : 0] C0_c517_451_l1_f26;
    logic [4  : 0] C1_c517_451_l1_f26;
    logic [1  : 0] CLA_c517_451_l1_f26;
    logic          O0_c517_451_l1_f26;
    logic [4  : 0] O1_c517_451_l1_f26;
    logic [3  : 0] O2_c517_451_l1_f26;
    logic [3  : 0] CY0_c517_451_l1_f26;
    logic [3  : 0] PROP0_c517_451_l1_f26;
    logic [3  : 0] CY1_c517_451_l1_f26;
    logic [3  : 0] PROP1_c517_451_l1_f26;
    
    logic [3 : 0] COUT_LA_l1_f26;
    logic         CIN_LA_l1_f26;
    logic [7 : 0] CY_LA_l1_f26;
    logic [7 : 0] PROP_LA_l1_f26;
    
    logic [16 : 0] C0_c517_451_l1_f27;
    logic [4  : 0] C1_c517_451_l1_f27;
    logic [1  : 0] CLA_c517_451_l1_f27;
    logic          O0_c517_451_l1_f27;
    logic [4  : 0] O1_c517_451_l1_f27;
    logic [3  : 0] O2_c517_451_l1_f27;
    logic [3  : 0] CY0_c517_451_l1_f27;
    logic [3  : 0] PROP0_c517_451_l1_f27;
    logic [3  : 0] CY1_c517_451_l1_f27;
    logic [3  : 0] PROP1_c517_451_l1_f27;
    
    logic [3 : 0] COUT_LA_l1_f27;
    logic         CIN_LA_l1_f27;
    logic [7 : 0] CY_LA_l1_f27;
    logic [7 : 0] PROP_LA_l1_f27;
    
    logic [16 : 0] C0_c517_451_l1_f28;
    logic [4  : 0] C1_c517_451_l1_f28;
    logic [1  : 0] CLA_c517_451_l1_f28;
    logic          O0_c517_451_l1_f28;
    logic [4  : 0] O1_c517_451_l1_f28;
    logic [3  : 0] O2_c517_451_l1_f28;
    logic [3  : 0] CY0_c517_451_l1_f28;
    logic [3  : 0] PROP0_c517_451_l1_f28;
    logic [3  : 0] CY1_c517_451_l1_f28;
    logic [3  : 0] PROP1_c517_451_l1_f28;
    
    logic [3 : 0] COUT_LA_l1_f28;
    logic         CIN_LA_l1_f28;
    logic [7 : 0] CY_LA_l1_f28;
    logic [7 : 0] PROP_LA_l1_f28;
    
    logic [16 : 0] C0_c517_451_l1_f29;
    logic [4  : 0] C1_c517_451_l1_f29;
    logic [1  : 0] CLA_c517_451_l1_f29;
    logic          O0_c517_451_l1_f29;
    logic [4  : 0] O1_c517_451_l1_f29;
    logic [3  : 0] O2_c517_451_l1_f29;
    logic [3  : 0] CY0_c517_451_l1_f29;
    logic [3  : 0] PROP0_c517_451_l1_f29;
    logic [3  : 0] CY1_c517_451_l1_f29;
    logic [3  : 0] PROP1_c517_451_l1_f29;
    
    logic [3 : 0] COUT_LA_l1_f29;
    logic         CIN_LA_l1_f29;
    logic [7 : 0] CY_LA_l1_f29;
    logic [7 : 0] PROP_LA_l1_f29;
    
    logic [4 : 0] C0_c15_3_l1_f30;
    logic         C1_c15_3_l1_f30;
    logic         CLA_c15_3_l1_f30;
    logic [2 : 0] O_c15_3_l1_f30;
    logic [1 : 0] CY_c15_3_l1_f30;
    logic [1 : 0] PROP_c15_3_l1_f30;
    
    logic [11 : 0] COUT_LA_l1_floating_placement;
    logic [2  : 0] CIN_LA_l1_floating_placement;
    logic [23 : 0] CY_LA_l1_floating_placement;
    logic [23 : 0] PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [3   : 0] layer2_col0;
    logic [27  : 0] layer2_col1;
    logic [142 : 0] layer2_col2;
    logic [112 : 0] layer2_col3;
    
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
    
    logic [8 : 0] C0_c9_41_l2_f5;
    logic         CLA_c9_41_l2_f5;
    logic         O0_c9_41_l2_f5;
    logic [3 : 0] O1_c9_41_l2_f5;
    logic [1 : 0] CY_c9_41_l2_f5;
    logic [1 : 0] PROP_c9_41_l2_f5;
    
    logic [8 : 0] C0_c9_41_l2_f6;
    logic         CLA_c9_41_l2_f6;
    logic         O0_c9_41_l2_f6;
    logic [3 : 0] O1_c9_41_l2_f6;
    logic [1 : 0] CY_c9_41_l2_f6;
    logic [1 : 0] PROP_c9_41_l2_f6;
    
    logic [8 : 0] C0_c39_231_l2_f7;
    logic [2 : 0] C1_c39_231_l2_f7;
    logic         CLA_c39_231_l2_f7;
    logic         O0_c39_231_l2_f7;
    logic [2 : 0] O1_c39_231_l2_f7;
    logic [1 : 0] O2_c39_231_l2_f7;
    logic [1 : 0] CY0_c39_231_l2_f7;
    logic [1 : 0] CY1_c39_231_l2_f7;
    logic [1 : 0] PROP0_c39_231_l2_f7;
    logic [1 : 0] PROP1_c39_231_l2_f7;
    
    logic [16 : 0] C0_c517_451_l2_f8;
    logic [4  : 0] C1_c517_451_l2_f8;
    logic [1  : 0] CLA_c517_451_l2_f8;
    logic          O0_c517_451_l2_f8;
    logic [4  : 0] O1_c517_451_l2_f8;
    logic [3  : 0] O2_c517_451_l2_f8;
    logic [3  : 0] CY0_c517_451_l2_f8;
    logic [3  : 0] PROP0_c517_451_l2_f8;
    logic [3  : 0] CY1_c517_451_l2_f8;
    logic [3  : 0] PROP1_c517_451_l2_f8;
    
    logic [3 : 0] COUT_LA_l2_f8;
    logic         CIN_LA_l2_f8;
    logic [7 : 0] CY_LA_l2_f8;
    logic [7 : 0] PROP_LA_l2_f8;
    
    logic [16 : 0] C0_c517_451_l2_f9;
    logic [4  : 0] C1_c517_451_l2_f9;
    logic [1  : 0] CLA_c517_451_l2_f9;
    logic          O0_c517_451_l2_f9;
    logic [4  : 0] O1_c517_451_l2_f9;
    logic [3  : 0] O2_c517_451_l2_f9;
    logic [3  : 0] CY0_c517_451_l2_f9;
    logic [3  : 0] PROP0_c517_451_l2_f9;
    logic [3  : 0] CY1_c517_451_l2_f9;
    logic [3  : 0] PROP1_c517_451_l2_f9;
    
    logic [3 : 0] COUT_LA_l2_f9;
    logic         CIN_LA_l2_f9;
    logic [7 : 0] CY_LA_l2_f9;
    logic [7 : 0] PROP_LA_l2_f9;
    
    logic [16 : 0] C0_c517_451_l2_f10;
    logic [4  : 0] C1_c517_451_l2_f10;
    logic [1  : 0] CLA_c517_451_l2_f10;
    logic          O0_c517_451_l2_f10;
    logic [4  : 0] O1_c517_451_l2_f10;
    logic [3  : 0] O2_c517_451_l2_f10;
    logic [3  : 0] CY0_c517_451_l2_f10;
    logic [3  : 0] PROP0_c517_451_l2_f10;
    logic [3  : 0] CY1_c517_451_l2_f10;
    logic [3  : 0] PROP1_c517_451_l2_f10;
    
    logic [3 : 0] COUT_LA_l2_f10;
    logic         CIN_LA_l2_f10;
    logic [7 : 0] CY_LA_l2_f10;
    logic [7 : 0] PROP_LA_l2_f10;
    
    logic [16 : 0] C0_c517_451_l2_f11;
    logic [4  : 0] C1_c517_451_l2_f11;
    logic [1  : 0] CLA_c517_451_l2_f11;
    logic          O0_c517_451_l2_f11;
    logic [4  : 0] O1_c517_451_l2_f11;
    logic [3  : 0] O2_c517_451_l2_f11;
    logic [3  : 0] CY0_c517_451_l2_f11;
    logic [3  : 0] PROP0_c517_451_l2_f11;
    logic [3  : 0] CY1_c517_451_l2_f11;
    logic [3  : 0] PROP1_c517_451_l2_f11;
    
    logic [3 : 0] COUT_LA_l2_f11;
    logic         CIN_LA_l2_f11;
    logic [7 : 0] CY_LA_l2_f11;
    logic [7 : 0] PROP_LA_l2_f11;
    
    logic [16 : 0] C0_c517_451_l2_f12;
    logic [4  : 0] C1_c517_451_l2_f12;
    logic [1  : 0] CLA_c517_451_l2_f12;
    logic          O0_c517_451_l2_f12;
    logic [4  : 0] O1_c517_451_l2_f12;
    logic [3  : 0] O2_c517_451_l2_f12;
    logic [3  : 0] CY0_c517_451_l2_f12;
    logic [3  : 0] PROP0_c517_451_l2_f12;
    logic [3  : 0] CY1_c517_451_l2_f12;
    logic [3  : 0] PROP1_c517_451_l2_f12;
    
    logic [3 : 0] COUT_LA_l2_f12;
    logic         CIN_LA_l2_f12;
    logic [7 : 0] CY_LA_l2_f12;
    logic [7 : 0] PROP_LA_l2_f12;
    
    logic [16 : 0] C0_c517_451_l2_f13;
    logic [4  : 0] C1_c517_451_l2_f13;
    logic [1  : 0] CLA_c517_451_l2_f13;
    logic          O0_c517_451_l2_f13;
    logic [4  : 0] O1_c517_451_l2_f13;
    logic [3  : 0] O2_c517_451_l2_f13;
    logic [3  : 0] CY0_c517_451_l2_f13;
    logic [3  : 0] PROP0_c517_451_l2_f13;
    logic [3  : 0] CY1_c517_451_l2_f13;
    logic [3  : 0] PROP1_c517_451_l2_f13;
    
    logic [3 : 0] COUT_LA_l2_f13;
    logic         CIN_LA_l2_f13;
    logic [7 : 0] CY_LA_l2_f13;
    logic [7 : 0] PROP_LA_l2_f13;
    
    logic [12 : 0] C0_c413_341_l2_f14;
    logic [3  : 0] C1_c413_341_l2_f14;
    logic [1  : 0] CLA_c413_341_l2_f14;
    logic          O0_c413_341_l2_f14;
    logic [3  : 0] O1_c413_341_l2_f14;
    logic [2  : 0] O2_c413_341_l2_f14;
    logic [2  : 0] CY0_c413_341_l2_f14;
    logic [2  : 0] PROP0_c413_341_l2_f14;
    logic [2  : 0] CY1_c413_341_l2_f14;
    logic [2  : 0] PROP1_c413_341_l2_f14;
    
    logic [3 : 0] COUT_LA_l2_f14;
    logic         CIN_LA_l2_f14;
    logic [7 : 0] CY_LA_l2_f14;
    logic [7 : 0] PROP_LA_l2_f14;
    
    logic [7  : 0] COUT_LA_l2_floating_placement;
    logic [1  : 0] CIN_LA_l2_floating_placement;
    logic [15 : 0] CY_LA_l2_floating_placement;
    logic [15 : 0] PROP_LA_l2_floating_placement;
    
    // ------------------------------ LAYER 3 ------------------------------
    logic [3  : 0] layer3_col0;
    logic [3  : 0] layer3_col1;
    logic [18 : 0] layer3_col2;
    logic [78 : 0] layer3_col3;
    logic [50 : 0] layer3_col4;
    
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
    
    logic [8 : 0] C0_c9_41_l3_f2;
    logic         CLA_c9_41_l3_f2;
    logic         O0_c9_41_l3_f2;
    logic [3 : 0] O1_c9_41_l3_f2;
    logic [1 : 0] CY_c9_41_l3_f2;
    logic [1 : 0] PROP_c9_41_l3_f2;
    
    logic [8 : 0] C0_c9_41_l3_f3;
    logic         CLA_c9_41_l3_f3;
    logic         O0_c9_41_l3_f3;
    logic [3 : 0] O1_c9_41_l3_f3;
    logic [1 : 0] CY_c9_41_l3_f3;
    logic [1 : 0] PROP_c9_41_l3_f3;
    
    logic [16 : 0] C0_c517_451_l3_f4;
    logic [4  : 0] C1_c517_451_l3_f4;
    logic [1  : 0] CLA_c517_451_l3_f4;
    logic          O0_c517_451_l3_f4;
    logic [4  : 0] O1_c517_451_l3_f4;
    logic [3  : 0] O2_c517_451_l3_f4;
    logic [3  : 0] CY0_c517_451_l3_f4;
    logic [3  : 0] PROP0_c517_451_l3_f4;
    logic [3  : 0] CY1_c517_451_l3_f4;
    logic [3  : 0] PROP1_c517_451_l3_f4;
    
    logic [3 : 0] COUT_LA_l3_f4;
    logic         CIN_LA_l3_f4;
    logic [7 : 0] CY_LA_l3_f4;
    logic [7 : 0] PROP_LA_l3_f4;
    
    logic [16 : 0] C0_c517_451_l3_f5;
    logic [4  : 0] C1_c517_451_l3_f5;
    logic [1  : 0] CLA_c517_451_l3_f5;
    logic          O0_c517_451_l3_f5;
    logic [4  : 0] O1_c517_451_l3_f5;
    logic [3  : 0] O2_c517_451_l3_f5;
    logic [3  : 0] CY0_c517_451_l3_f5;
    logic [3  : 0] PROP0_c517_451_l3_f5;
    logic [3  : 0] CY1_c517_451_l3_f5;
    logic [3  : 0] PROP1_c517_451_l3_f5;
    
    logic [3 : 0] COUT_LA_l3_f5;
    logic         CIN_LA_l3_f5;
    logic [7 : 0] CY_LA_l3_f5;
    logic [7 : 0] PROP_LA_l3_f5;
    
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
    
    logic [3 : 0] COUT_LA_l3_floating_placement;
    logic         CIN_LA_l3_floating_placement;
    logic [7 : 0] CY_LA_l3_floating_placement;
    logic [7 : 0] PROP_LA_l3_floating_placement;
    
    // ------------------------------ LAYER 4 ------------------------------
    logic [3  : 0] layer4_col0;
    logic [3  : 0] layer4_col1;
    logic [2  : 0] layer4_col2;
    logic [10 : 0] layer4_col3;
    logic [38 : 0] layer4_col4;
    logic [24 : 0] layer4_col5;
    
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
    
    logic [8 : 0] C0_c9_41_l4_f0;
    logic         CLA_c9_41_l4_f0;
    logic         O0_c9_41_l4_f0;
    logic [3 : 0] O1_c9_41_l4_f0;
    logic [1 : 0] CY_c9_41_l4_f0;
    logic [1 : 0] PROP_c9_41_l4_f0;
    
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
    
    logic [8 : 0] C0_c39_231_l4_f3;
    logic [2 : 0] C1_c39_231_l4_f3;
    logic         CLA_c39_231_l4_f3;
    logic         O0_c39_231_l4_f3;
    logic [2 : 0] O1_c39_231_l4_f3;
    logic [1 : 0] O2_c39_231_l4_f3;
    logic [1 : 0] CY0_c39_231_l4_f3;
    logic [1 : 0] CY1_c39_231_l4_f3;
    logic [1 : 0] PROP0_c39_231_l4_f3;
    logic [1 : 0] PROP1_c39_231_l4_f3;
    
    logic [3 : 0] COUT_LA_l4_floating_placement;
    logic         CIN_LA_l4_floating_placement;
    logic [7 : 0] CY_LA_l4_floating_placement;
    logic [7 : 0] PROP_LA_l4_floating_placement;
    
    // ------------------------------ LAYER 5 ------------------------------
    logic [3  : 0] layer5_col0;
    logic [3  : 0] layer5_col1;
    logic [2  : 0] layer5_col2;
    logic [2  : 0] layer5_col3;
    logic [14 : 0] layer5_col4;
    logic [10 : 0] layer5_col5;
    logic [13 : 0] layer5_col6;
    
    logic [3 : 0] COUT_LA_l5_c0_s0;
    logic         CIN_LA_l5_c0_s0;
    logic [7 : 0] CY_LA_l5_c0_s0;
    logic [7 : 0] PROP_LA_l5_c0_s0;
    
    logic [3 : 0] COUT_LA_l5_c0_s1;
    logic         CIN_LA_l5_c0_s1;
    logic [7 : 0] CY_LA_l5_c0_s1;
    logic [7 : 0] PROP_LA_l5_c0_s1;
    
    logic [8 : 0] C0_c39_231_l5_c0_i0;
    logic [2 : 0] C1_c39_231_l5_c0_i0;
    logic         CLA_c39_231_l5_c0_i0;
    logic         O0_c39_231_l5_c0_i0;
    logic [2 : 0] O1_c39_231_l5_c0_i0;
    logic [1 : 0] O2_c39_231_l5_c0_i0;
    logic [1 : 0] CY0_c39_231_l5_c0_i0;
    logic [1 : 0] CY1_c39_231_l5_c0_i0;
    logic [1 : 0] PROP0_c39_231_l5_c0_i0;
    logic [1 : 0] PROP1_c39_231_l5_c0_i0;
    logic         l5_c0_i0;
    
    logic [8 : 0] C0_c9_41_l5_c0_i1;
    logic         CLA_c9_41_l5_c0_i1;
    logic         O0_c9_41_l5_c0_i1;
    logic [3 : 0] O1_c9_41_l5_c0_i1;
    logic [1 : 0] CY_c9_41_l5_c0_i1;
    logic [1 : 0] PROP_c9_41_l5_c0_i1;
    logic         l5_c0_i1;
    
    logic [4 : 0] C0_c15_3_l5_f0;
    logic         C1_c15_3_l5_f0;
    logic         CLA_c15_3_l5_f0;
    logic [2 : 0] O_c15_3_l5_f0;
    logic [1 : 0] CY_c15_3_l5_f0;
    logic [1 : 0] PROP_c15_3_l5_f0;
    
    logic [4 : 0] C0_c15_3_l5_f1;
    logic         C1_c15_3_l5_f1;
    logic         CLA_c15_3_l5_f1;
    logic [2 : 0] O_c15_3_l5_f1;
    logic [1 : 0] CY_c15_3_l5_f1;
    logic [1 : 0] PROP_c15_3_l5_f1;
    
    logic [3 : 0] COUT_LA_l5_floating_placement;
    logic         CIN_LA_l5_floating_placement;
    logic [7 : 0] CY_LA_l5_floating_placement;
    logic [7 : 0] PROP_LA_l5_floating_placement;
    
    // ------------------------------ LAYER 6 ------------------------------
    logic [3  : 0] layer6_col0;
    logic [3  : 0] layer6_col1;
    logic [2  : 0] layer6_col2;
    logic [2  : 0] layer6_col3;
    logic [2  : 0] layer6_col4;
    logic [6  : 0] layer6_col5;
    logic [8  : 0] layer6_col6;
    logic [4  : 0] layer6_col7;
    
    logic [3 : 0] COUT_LA_l6_c0_s0;
    logic         CIN_LA_l6_c0_s0;
    logic [7 : 0] CY_LA_l6_c0_s0;
    logic [7 : 0] PROP_LA_l6_c0_s0;
    
    logic [4 : 0] C0_c15_3_l6_c0_i0;
    logic         C1_c15_3_l6_c0_i0;
    logic         CLA_c15_3_l6_c0_i0;
    logic [2 : 0] O_c15_3_l6_c0_i0;
    logic [1 : 0] CY_c15_3_l6_c0_i0;
    logic [1 : 0] PROP_c15_3_l6_c0_i0;
    logic         l6_c0_i0;
    
    logic [2 : 0] C0_c3_2_l6_c0_i1;
    logic [1 : 0] O_c3_2_l6_c0_i1;
    logic         CY_c3_2_l6_c0_i1;
    logic         PROP_c3_2_l6_c0_i1;
    logic         l6_c0_i1;
    
    logic [4 : 0] C0_c15_3_l6_f0;
    logic         C1_c15_3_l6_f0;
    logic         CLA_c15_3_l6_f0;
    logic [2 : 0] O_c15_3_l6_f0;
    logic [1 : 0] CY_c15_3_l6_f0;
    logic [1 : 0] PROP_c15_3_l6_f0;
    
    logic [3 : 0] COUT_LA_l6_c1_s0;
    logic         CIN_LA_l6_c1_s0;
    logic [7 : 0] CY_LA_l6_c1_s0;
    logic [7 : 0] PROP_LA_l6_c1_s0;
    
    logic [2 : 0] C0_c3_2_l6_c1_i0;
    logic [1 : 0] O_c3_2_l6_c1_i0;
    logic         CY_c3_2_l6_c1_i0;
    logic         PROP_c3_2_l6_c1_i0;
    logic         l6_c1_i0;
    
    logic [2 : 0] C0_c3_2_l6_c1_i1;
    logic [1 : 0] O_c3_2_l6_c1_i1;
    logic         CY_c3_2_l6_c1_i1;
    logic         PROP_c3_2_l6_c1_i1;
    logic         l6_c1_i1;
    
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
    logic [2  : 0] layer7_col5;
    logic [2  : 0] layer7_col6;
    logic [2  : 0] layer7_col7;
    logic [2  : 0] layer7_col8;
    
    logic [9 : 0] terminal_chain1_out;
    
    logic [7  : 0] COUT_LA_terminal_chain1;
    logic [1  : 0] CIN_LA_terminal_chain1;
    logic [15 : 0] CY_LA_terminal_chain1;
    logic [15 : 0] PROP_LA_terminal_chain1;
    
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
    
    logic [10 : 0] terminal_chain2_out;
    
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
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i4;
    logic         C1_c15_3_terminal_chain2_i4;
    logic         CLA_c15_3_terminal_chain2_i4;
    logic [2 : 0] O_c15_3_terminal_chain2_i4;
    logic [1 : 0] CY_c15_3_terminal_chain2_i4;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i4;
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
    
    // GPC13 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f13 = layer0_col1[121:113];
    
    assign layer1_col1[17]    = O0_c9_41_l0_f13;
    assign layer1_col2[55:52] = O1_c9_41_l0_f13;
    
    // GPC14 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f14 = layer0_col1[130:122];
    
    assign layer1_col1[18]    = O0_c9_41_l0_f14;
    assign layer1_col2[59:56] = O1_c9_41_l0_f14;
    
    // GPC15 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f15 = layer0_col1[139:131];
    
    assign layer1_col1[19]    = O0_c9_41_l0_f15;
    assign layer1_col2[63:60] = O1_c9_41_l0_f15;
    
    // GPC16 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f16 = layer0_col1[148:140];
    
    assign layer1_col1[20]    = O0_c9_41_l0_f16;
    assign layer1_col2[67:64] = O1_c9_41_l0_f16;
    
    // GPC17 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f17 = layer0_col1[157:149];
    
    assign layer1_col1[21]    = O0_c9_41_l0_f17;
    assign layer1_col2[71:68] = O1_c9_41_l0_f17;
    
    // GPC18 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f18 = layer0_col1[166:158];
    
    assign layer1_col1[22]    = O0_c9_41_l0_f18;
    assign layer1_col2[75:72] = O1_c9_41_l0_f18;
    
    // GPC19 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f19 = layer0_col1[175:167];
    
    assign layer1_col1[23]    = O0_c9_41_l0_f19;
    assign layer1_col2[79:76] = O1_c9_41_l0_f19;
    
    // GPC20 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f20 = layer0_col1[184:176];
    
    assign layer1_col1[24]    = O0_c9_41_l0_f20;
    assign layer1_col2[83:80] = O1_c9_41_l0_f20;
    
    // GPC21 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f21 = layer0_col1[193:185];
    
    assign layer1_col1[25]    = O0_c9_41_l0_f21;
    assign layer1_col2[87:84] = O1_c9_41_l0_f21;
    
    // GPC22 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f22 = layer0_col1[202:194];
    
    assign layer1_col1[26]    = O0_c9_41_l0_f22;
    assign layer1_col2[91:88] = O1_c9_41_l0_f22;
    
    // GPC23 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l0_f23 = layer0_col1[211:203];
    
    assign layer1_col1[27]    = O0_c9_41_l0_f23;
    assign layer1_col2[95:92] = O1_c9_41_l0_f23;
    
    // GPC24 in layer0: (9 : 4,1) at column 1
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_f24(
        .clk (clk              ),
        .C0  (C0_c9_41_l0_f24  ),
        .CLA (CLA_c9_41_l0_f24 ),
        .O0  (O0_c9_41_l0_f24  ),
        .O1  (O1_c9_41_l0_f24  ),
        .CY  (CY_c9_41_l0_f24  ),
        .PROP(PROP_c9_41_l0_f24));
    
    assign C0_c9_41_l0_f24 = layer0_col1[220:212];
    
    assign layer1_col1[28]    = O0_c9_41_l0_f24;
    assign layer1_col2[99:96] = O1_c9_41_l0_f24;
    
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
    
    assign C0_c517_451_l0_f25 = layer0_col0[33:17];
    assign C1_c517_451_l0_f25 = layer0_col1[225:221];
    
    assign layer1_col0[1]       = O0_c517_451_l0_f25;
    assign layer1_col1[33:29]   = O1_c517_451_l0_f25;
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
    
    assign C0_c517_451_l0_f26 = layer0_col0[50:34];
    assign C1_c517_451_l0_f26 = layer0_col1[230:226];
    
    assign layer1_col0[2]       = O0_c517_451_l0_f26;
    assign layer1_col1[38:34]   = O1_c517_451_l0_f26;
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
    
    // GPC27 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f27(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f27   ),
        .C1   (C1_c517_451_l0_f27   ),
        .CLA  (CLA_c517_451_l0_f27  ),
        .O0   (O0_c517_451_l0_f27   ),
        .O1   (O1_c517_451_l0_f27   ),
        .O2   (O2_c517_451_l0_f27   ),
        .CY0  (CY0_c517_451_l0_f27  ),
        .PROP0(PROP0_c517_451_l0_f27),
        .CY1  (CY1_c517_451_l0_f27  ),
        .PROP1(PROP1_c517_451_l0_f27));
    
    assign C0_c517_451_l0_f27 = layer0_col0[67:51];
    assign C1_c517_451_l0_f27 = layer0_col1[235:231];
    
    assign layer1_col0[3]       = O0_c517_451_l0_f27;
    assign layer1_col1[43:39]   = O1_c517_451_l0_f27;
    assign layer1_col2[111:108] = O2_c517_451_l0_f27;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f27_inst0 (
        .COUTB(COUT_LA_l0_f27[0]),
        .COUTD(COUT_LA_l0_f27[1]),
        .COUTF(COUT_LA_l0_f27[2]),
        .COUTH(COUT_LA_l0_f27[3]),
        .CIN  (CIN_LA_l0_f27    ),
        .CYA  (CY_LA_l0_f27[0]  ),
        .CYB  (CY_LA_l0_f27[1]  ),
        .CYC  (CY_LA_l0_f27[2]  ),
        .CYD  (CY_LA_l0_f27[3]  ),
        .CYE  (CY_LA_l0_f27[4]  ),
        .CYF  (CY_LA_l0_f27[5]  ),
        .CYG  (CY_LA_l0_f27[6]  ),
        .CYH  (CY_LA_l0_f27[7]  ),
        .PROPA(PROP_LA_l0_f27[0]),
        .PROPB(PROP_LA_l0_f27[1]),
        .PROPC(PROP_LA_l0_f27[2]),
        .PROPD(PROP_LA_l0_f27[3]),
        .PROPE(PROP_LA_l0_f27[4]),
        .PROPF(PROP_LA_l0_f27[5]),
        .PROPG(PROP_LA_l0_f27[6]),
        .PROPH(PROP_LA_l0_f27[7]));

    assign CLA_c517_451_l0_f27[0] = COUT_LA_l0_f27[0];
    assign CLA_c517_451_l0_f27[1] = COUT_LA_l0_f27[2];
    assign CIN_LA_l0_f27          = C0_c517_451_l0_f27[8];
    assign CY_LA_l0_f27[3:0]      = CY0_c517_451_l0_f27;
    assign CY_LA_l0_f27[7:4]      = CY1_c517_451_l0_f27;
    assign PROP_LA_l0_f27[3:0]    = PROP0_c517_451_l0_f27;
    assign PROP_LA_l0_f27[7:4]    = PROP1_c517_451_l0_f27;
    
    // GPC28 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f28(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f28   ),
        .C1   (C1_c517_451_l0_f28   ),
        .CLA  (CLA_c517_451_l0_f28  ),
        .O0   (O0_c517_451_l0_f28   ),
        .O1   (O1_c517_451_l0_f28   ),
        .O2   (O2_c517_451_l0_f28   ),
        .CY0  (CY0_c517_451_l0_f28  ),
        .PROP0(PROP0_c517_451_l0_f28),
        .CY1  (CY1_c517_451_l0_f28  ),
        .PROP1(PROP1_c517_451_l0_f28));
    
    assign C0_c517_451_l0_f28 = layer0_col0[84:68];
    assign C1_c517_451_l0_f28 = layer0_col1[240:236];
    
    assign layer1_col0[4]       = O0_c517_451_l0_f28;
    assign layer1_col1[48:44]   = O1_c517_451_l0_f28;
    assign layer1_col2[115:112] = O2_c517_451_l0_f28;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f28_inst0 (
        .COUTB(COUT_LA_l0_f28[0]),
        .COUTD(COUT_LA_l0_f28[1]),
        .COUTF(COUT_LA_l0_f28[2]),
        .COUTH(COUT_LA_l0_f28[3]),
        .CIN  (CIN_LA_l0_f28    ),
        .CYA  (CY_LA_l0_f28[0]  ),
        .CYB  (CY_LA_l0_f28[1]  ),
        .CYC  (CY_LA_l0_f28[2]  ),
        .CYD  (CY_LA_l0_f28[3]  ),
        .CYE  (CY_LA_l0_f28[4]  ),
        .CYF  (CY_LA_l0_f28[5]  ),
        .CYG  (CY_LA_l0_f28[6]  ),
        .CYH  (CY_LA_l0_f28[7]  ),
        .PROPA(PROP_LA_l0_f28[0]),
        .PROPB(PROP_LA_l0_f28[1]),
        .PROPC(PROP_LA_l0_f28[2]),
        .PROPD(PROP_LA_l0_f28[3]),
        .PROPE(PROP_LA_l0_f28[4]),
        .PROPF(PROP_LA_l0_f28[5]),
        .PROPG(PROP_LA_l0_f28[6]),
        .PROPH(PROP_LA_l0_f28[7]));

    assign CLA_c517_451_l0_f28[0] = COUT_LA_l0_f28[0];
    assign CLA_c517_451_l0_f28[1] = COUT_LA_l0_f28[2];
    assign CIN_LA_l0_f28          = C0_c517_451_l0_f28[8];
    assign CY_LA_l0_f28[3:0]      = CY0_c517_451_l0_f28;
    assign CY_LA_l0_f28[7:4]      = CY1_c517_451_l0_f28;
    assign PROP_LA_l0_f28[3:0]    = PROP0_c517_451_l0_f28;
    assign PROP_LA_l0_f28[7:4]    = PROP1_c517_451_l0_f28;
    
    // GPC29 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f29(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f29   ),
        .C1   (C1_c517_451_l0_f29   ),
        .CLA  (CLA_c517_451_l0_f29  ),
        .O0   (O0_c517_451_l0_f29   ),
        .O1   (O1_c517_451_l0_f29   ),
        .O2   (O2_c517_451_l0_f29   ),
        .CY0  (CY0_c517_451_l0_f29  ),
        .PROP0(PROP0_c517_451_l0_f29),
        .CY1  (CY1_c517_451_l0_f29  ),
        .PROP1(PROP1_c517_451_l0_f29));
    
    assign C0_c517_451_l0_f29 = layer0_col0[101:85];
    assign C1_c517_451_l0_f29 = layer0_col1[245:241];
    
    assign layer1_col0[5]       = O0_c517_451_l0_f29;
    assign layer1_col1[53:49]   = O1_c517_451_l0_f29;
    assign layer1_col2[119:116] = O2_c517_451_l0_f29;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f29_inst0 (
        .COUTB(COUT_LA_l0_f29[0]),
        .COUTD(COUT_LA_l0_f29[1]),
        .COUTF(COUT_LA_l0_f29[2]),
        .COUTH(COUT_LA_l0_f29[3]),
        .CIN  (CIN_LA_l0_f29    ),
        .CYA  (CY_LA_l0_f29[0]  ),
        .CYB  (CY_LA_l0_f29[1]  ),
        .CYC  (CY_LA_l0_f29[2]  ),
        .CYD  (CY_LA_l0_f29[3]  ),
        .CYE  (CY_LA_l0_f29[4]  ),
        .CYF  (CY_LA_l0_f29[5]  ),
        .CYG  (CY_LA_l0_f29[6]  ),
        .CYH  (CY_LA_l0_f29[7]  ),
        .PROPA(PROP_LA_l0_f29[0]),
        .PROPB(PROP_LA_l0_f29[1]),
        .PROPC(PROP_LA_l0_f29[2]),
        .PROPD(PROP_LA_l0_f29[3]),
        .PROPE(PROP_LA_l0_f29[4]),
        .PROPF(PROP_LA_l0_f29[5]),
        .PROPG(PROP_LA_l0_f29[6]),
        .PROPH(PROP_LA_l0_f29[7]));

    assign CLA_c517_451_l0_f29[0] = COUT_LA_l0_f29[0];
    assign CLA_c517_451_l0_f29[1] = COUT_LA_l0_f29[2];
    assign CIN_LA_l0_f29          = C0_c517_451_l0_f29[8];
    assign CY_LA_l0_f29[3:0]      = CY0_c517_451_l0_f29;
    assign CY_LA_l0_f29[7:4]      = CY1_c517_451_l0_f29;
    assign PROP_LA_l0_f29[3:0]    = PROP0_c517_451_l0_f29;
    assign PROP_LA_l0_f29[7:4]    = PROP1_c517_451_l0_f29;
    
    // GPC30 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f30(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f30   ),
        .C1   (C1_c517_451_l0_f30   ),
        .CLA  (CLA_c517_451_l0_f30  ),
        .O0   (O0_c517_451_l0_f30   ),
        .O1   (O1_c517_451_l0_f30   ),
        .O2   (O2_c517_451_l0_f30   ),
        .CY0  (CY0_c517_451_l0_f30  ),
        .PROP0(PROP0_c517_451_l0_f30),
        .CY1  (CY1_c517_451_l0_f30  ),
        .PROP1(PROP1_c517_451_l0_f30));
    
    assign C0_c517_451_l0_f30 = layer0_col0[118:102];
    assign C1_c517_451_l0_f30 = layer0_col1[250:246];
    
    assign layer1_col0[6]       = O0_c517_451_l0_f30;
    assign layer1_col1[58:54]   = O1_c517_451_l0_f30;
    assign layer1_col2[123:120] = O2_c517_451_l0_f30;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f30_inst0 (
        .COUTB(COUT_LA_l0_f30[0]),
        .COUTD(COUT_LA_l0_f30[1]),
        .COUTF(COUT_LA_l0_f30[2]),
        .COUTH(COUT_LA_l0_f30[3]),
        .CIN  (CIN_LA_l0_f30    ),
        .CYA  (CY_LA_l0_f30[0]  ),
        .CYB  (CY_LA_l0_f30[1]  ),
        .CYC  (CY_LA_l0_f30[2]  ),
        .CYD  (CY_LA_l0_f30[3]  ),
        .CYE  (CY_LA_l0_f30[4]  ),
        .CYF  (CY_LA_l0_f30[5]  ),
        .CYG  (CY_LA_l0_f30[6]  ),
        .CYH  (CY_LA_l0_f30[7]  ),
        .PROPA(PROP_LA_l0_f30[0]),
        .PROPB(PROP_LA_l0_f30[1]),
        .PROPC(PROP_LA_l0_f30[2]),
        .PROPD(PROP_LA_l0_f30[3]),
        .PROPE(PROP_LA_l0_f30[4]),
        .PROPF(PROP_LA_l0_f30[5]),
        .PROPG(PROP_LA_l0_f30[6]),
        .PROPH(PROP_LA_l0_f30[7]));

    assign CLA_c517_451_l0_f30[0] = COUT_LA_l0_f30[0];
    assign CLA_c517_451_l0_f30[1] = COUT_LA_l0_f30[2];
    assign CIN_LA_l0_f30          = C0_c517_451_l0_f30[8];
    assign CY_LA_l0_f30[3:0]      = CY0_c517_451_l0_f30;
    assign CY_LA_l0_f30[7:4]      = CY1_c517_451_l0_f30;
    assign PROP_LA_l0_f30[3:0]    = PROP0_c517_451_l0_f30;
    assign PROP_LA_l0_f30[7:4]    = PROP1_c517_451_l0_f30;
    
    // GPC31 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f31(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f31   ),
        .C1   (C1_c517_451_l0_f31   ),
        .CLA  (CLA_c517_451_l0_f31  ),
        .O0   (O0_c517_451_l0_f31   ),
        .O1   (O1_c517_451_l0_f31   ),
        .O2   (O2_c517_451_l0_f31   ),
        .CY0  (CY0_c517_451_l0_f31  ),
        .PROP0(PROP0_c517_451_l0_f31),
        .CY1  (CY1_c517_451_l0_f31  ),
        .PROP1(PROP1_c517_451_l0_f31));
    
    assign C0_c517_451_l0_f31 = layer0_col0[135:119];
    assign C1_c517_451_l0_f31 = layer0_col1[255:251];
    
    assign layer1_col0[7]       = O0_c517_451_l0_f31;
    assign layer1_col1[63:59]   = O1_c517_451_l0_f31;
    assign layer1_col2[127:124] = O2_c517_451_l0_f31;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f31_inst0 (
        .COUTB(COUT_LA_l0_f31[0]),
        .COUTD(COUT_LA_l0_f31[1]),
        .COUTF(COUT_LA_l0_f31[2]),
        .COUTH(COUT_LA_l0_f31[3]),
        .CIN  (CIN_LA_l0_f31    ),
        .CYA  (CY_LA_l0_f31[0]  ),
        .CYB  (CY_LA_l0_f31[1]  ),
        .CYC  (CY_LA_l0_f31[2]  ),
        .CYD  (CY_LA_l0_f31[3]  ),
        .CYE  (CY_LA_l0_f31[4]  ),
        .CYF  (CY_LA_l0_f31[5]  ),
        .CYG  (CY_LA_l0_f31[6]  ),
        .CYH  (CY_LA_l0_f31[7]  ),
        .PROPA(PROP_LA_l0_f31[0]),
        .PROPB(PROP_LA_l0_f31[1]),
        .PROPC(PROP_LA_l0_f31[2]),
        .PROPD(PROP_LA_l0_f31[3]),
        .PROPE(PROP_LA_l0_f31[4]),
        .PROPF(PROP_LA_l0_f31[5]),
        .PROPG(PROP_LA_l0_f31[6]),
        .PROPH(PROP_LA_l0_f31[7]));

    assign CLA_c517_451_l0_f31[0] = COUT_LA_l0_f31[0];
    assign CLA_c517_451_l0_f31[1] = COUT_LA_l0_f31[2];
    assign CIN_LA_l0_f31          = C0_c517_451_l0_f31[8];
    assign CY_LA_l0_f31[3:0]      = CY0_c517_451_l0_f31;
    assign CY_LA_l0_f31[7:4]      = CY1_c517_451_l0_f31;
    assign PROP_LA_l0_f31[3:0]    = PROP0_c517_451_l0_f31;
    assign PROP_LA_l0_f31[7:4]    = PROP1_c517_451_l0_f31;
    
    // GPC32 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f32(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f32   ),
        .C1   (C1_c517_451_l0_f32   ),
        .CLA  (CLA_c517_451_l0_f32  ),
        .O0   (O0_c517_451_l0_f32   ),
        .O1   (O1_c517_451_l0_f32   ),
        .O2   (O2_c517_451_l0_f32   ),
        .CY0  (CY0_c517_451_l0_f32  ),
        .PROP0(PROP0_c517_451_l0_f32),
        .CY1  (CY1_c517_451_l0_f32  ),
        .PROP1(PROP1_c517_451_l0_f32));
    
    assign C0_c517_451_l0_f32 = layer0_col0[152:136];
    assign C1_c517_451_l0_f32 = layer0_col1[260:256];
    
    assign layer1_col0[8]       = O0_c517_451_l0_f32;
    assign layer1_col1[68:64]   = O1_c517_451_l0_f32;
    assign layer1_col2[131:128] = O2_c517_451_l0_f32;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f32_inst0 (
        .COUTB(COUT_LA_l0_f32[0]),
        .COUTD(COUT_LA_l0_f32[1]),
        .COUTF(COUT_LA_l0_f32[2]),
        .COUTH(COUT_LA_l0_f32[3]),
        .CIN  (CIN_LA_l0_f32    ),
        .CYA  (CY_LA_l0_f32[0]  ),
        .CYB  (CY_LA_l0_f32[1]  ),
        .CYC  (CY_LA_l0_f32[2]  ),
        .CYD  (CY_LA_l0_f32[3]  ),
        .CYE  (CY_LA_l0_f32[4]  ),
        .CYF  (CY_LA_l0_f32[5]  ),
        .CYG  (CY_LA_l0_f32[6]  ),
        .CYH  (CY_LA_l0_f32[7]  ),
        .PROPA(PROP_LA_l0_f32[0]),
        .PROPB(PROP_LA_l0_f32[1]),
        .PROPC(PROP_LA_l0_f32[2]),
        .PROPD(PROP_LA_l0_f32[3]),
        .PROPE(PROP_LA_l0_f32[4]),
        .PROPF(PROP_LA_l0_f32[5]),
        .PROPG(PROP_LA_l0_f32[6]),
        .PROPH(PROP_LA_l0_f32[7]));

    assign CLA_c517_451_l0_f32[0] = COUT_LA_l0_f32[0];
    assign CLA_c517_451_l0_f32[1] = COUT_LA_l0_f32[2];
    assign CIN_LA_l0_f32          = C0_c517_451_l0_f32[8];
    assign CY_LA_l0_f32[3:0]      = CY0_c517_451_l0_f32;
    assign CY_LA_l0_f32[7:4]      = CY1_c517_451_l0_f32;
    assign PROP_LA_l0_f32[3:0]    = PROP0_c517_451_l0_f32;
    assign PROP_LA_l0_f32[7:4]    = PROP1_c517_451_l0_f32;
    
    // GPC33 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f33(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f33   ),
        .C1   (C1_c517_451_l0_f33   ),
        .CLA  (CLA_c517_451_l0_f33  ),
        .O0   (O0_c517_451_l0_f33   ),
        .O1   (O1_c517_451_l0_f33   ),
        .O2   (O2_c517_451_l0_f33   ),
        .CY0  (CY0_c517_451_l0_f33  ),
        .PROP0(PROP0_c517_451_l0_f33),
        .CY1  (CY1_c517_451_l0_f33  ),
        .PROP1(PROP1_c517_451_l0_f33));
    
    assign C0_c517_451_l0_f33 = layer0_col0[169:153];
    assign C1_c517_451_l0_f33 = layer0_col1[265:261];
    
    assign layer1_col0[9]       = O0_c517_451_l0_f33;
    assign layer1_col1[73:69]   = O1_c517_451_l0_f33;
    assign layer1_col2[135:132] = O2_c517_451_l0_f33;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f33_inst0 (
        .COUTB(COUT_LA_l0_f33[0]),
        .COUTD(COUT_LA_l0_f33[1]),
        .COUTF(COUT_LA_l0_f33[2]),
        .COUTH(COUT_LA_l0_f33[3]),
        .CIN  (CIN_LA_l0_f33    ),
        .CYA  (CY_LA_l0_f33[0]  ),
        .CYB  (CY_LA_l0_f33[1]  ),
        .CYC  (CY_LA_l0_f33[2]  ),
        .CYD  (CY_LA_l0_f33[3]  ),
        .CYE  (CY_LA_l0_f33[4]  ),
        .CYF  (CY_LA_l0_f33[5]  ),
        .CYG  (CY_LA_l0_f33[6]  ),
        .CYH  (CY_LA_l0_f33[7]  ),
        .PROPA(PROP_LA_l0_f33[0]),
        .PROPB(PROP_LA_l0_f33[1]),
        .PROPC(PROP_LA_l0_f33[2]),
        .PROPD(PROP_LA_l0_f33[3]),
        .PROPE(PROP_LA_l0_f33[4]),
        .PROPF(PROP_LA_l0_f33[5]),
        .PROPG(PROP_LA_l0_f33[6]),
        .PROPH(PROP_LA_l0_f33[7]));

    assign CLA_c517_451_l0_f33[0] = COUT_LA_l0_f33[0];
    assign CLA_c517_451_l0_f33[1] = COUT_LA_l0_f33[2];
    assign CIN_LA_l0_f33          = C0_c517_451_l0_f33[8];
    assign CY_LA_l0_f33[3:0]      = CY0_c517_451_l0_f33;
    assign CY_LA_l0_f33[7:4]      = CY1_c517_451_l0_f33;
    assign PROP_LA_l0_f33[3:0]    = PROP0_c517_451_l0_f33;
    assign PROP_LA_l0_f33[7:4]    = PROP1_c517_451_l0_f33;
    
    // GPC34 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f34(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f34   ),
        .C1   (C1_c517_451_l0_f34   ),
        .CLA  (CLA_c517_451_l0_f34  ),
        .O0   (O0_c517_451_l0_f34   ),
        .O1   (O1_c517_451_l0_f34   ),
        .O2   (O2_c517_451_l0_f34   ),
        .CY0  (CY0_c517_451_l0_f34  ),
        .PROP0(PROP0_c517_451_l0_f34),
        .CY1  (CY1_c517_451_l0_f34  ),
        .PROP1(PROP1_c517_451_l0_f34));
    
    assign C0_c517_451_l0_f34 = layer0_col0[186:170];
    assign C1_c517_451_l0_f34 = layer0_col1[270:266];
    
    assign layer1_col0[10]      = O0_c517_451_l0_f34;
    assign layer1_col1[78:74]   = O1_c517_451_l0_f34;
    assign layer1_col2[139:136] = O2_c517_451_l0_f34;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f34_inst0 (
        .COUTB(COUT_LA_l0_f34[0]),
        .COUTD(COUT_LA_l0_f34[1]),
        .COUTF(COUT_LA_l0_f34[2]),
        .COUTH(COUT_LA_l0_f34[3]),
        .CIN  (CIN_LA_l0_f34    ),
        .CYA  (CY_LA_l0_f34[0]  ),
        .CYB  (CY_LA_l0_f34[1]  ),
        .CYC  (CY_LA_l0_f34[2]  ),
        .CYD  (CY_LA_l0_f34[3]  ),
        .CYE  (CY_LA_l0_f34[4]  ),
        .CYF  (CY_LA_l0_f34[5]  ),
        .CYG  (CY_LA_l0_f34[6]  ),
        .CYH  (CY_LA_l0_f34[7]  ),
        .PROPA(PROP_LA_l0_f34[0]),
        .PROPB(PROP_LA_l0_f34[1]),
        .PROPC(PROP_LA_l0_f34[2]),
        .PROPD(PROP_LA_l0_f34[3]),
        .PROPE(PROP_LA_l0_f34[4]),
        .PROPF(PROP_LA_l0_f34[5]),
        .PROPG(PROP_LA_l0_f34[6]),
        .PROPH(PROP_LA_l0_f34[7]));

    assign CLA_c517_451_l0_f34[0] = COUT_LA_l0_f34[0];
    assign CLA_c517_451_l0_f34[1] = COUT_LA_l0_f34[2];
    assign CIN_LA_l0_f34          = C0_c517_451_l0_f34[8];
    assign CY_LA_l0_f34[3:0]      = CY0_c517_451_l0_f34;
    assign CY_LA_l0_f34[7:4]      = CY1_c517_451_l0_f34;
    assign PROP_LA_l0_f34[3:0]    = PROP0_c517_451_l0_f34;
    assign PROP_LA_l0_f34[7:4]    = PROP1_c517_451_l0_f34;
    
    // GPC35 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f35(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f35   ),
        .C1   (C1_c517_451_l0_f35   ),
        .CLA  (CLA_c517_451_l0_f35  ),
        .O0   (O0_c517_451_l0_f35   ),
        .O1   (O1_c517_451_l0_f35   ),
        .O2   (O2_c517_451_l0_f35   ),
        .CY0  (CY0_c517_451_l0_f35  ),
        .PROP0(PROP0_c517_451_l0_f35),
        .CY1  (CY1_c517_451_l0_f35  ),
        .PROP1(PROP1_c517_451_l0_f35));
    
    assign C0_c517_451_l0_f35 = layer0_col0[203:187];
    assign C1_c517_451_l0_f35 = layer0_col1[275:271];
    
    assign layer1_col0[11]      = O0_c517_451_l0_f35;
    assign layer1_col1[83:79]   = O1_c517_451_l0_f35;
    assign layer1_col2[143:140] = O2_c517_451_l0_f35;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f35_inst0 (
        .COUTB(COUT_LA_l0_f35[0]),
        .COUTD(COUT_LA_l0_f35[1]),
        .COUTF(COUT_LA_l0_f35[2]),
        .COUTH(COUT_LA_l0_f35[3]),
        .CIN  (CIN_LA_l0_f35    ),
        .CYA  (CY_LA_l0_f35[0]  ),
        .CYB  (CY_LA_l0_f35[1]  ),
        .CYC  (CY_LA_l0_f35[2]  ),
        .CYD  (CY_LA_l0_f35[3]  ),
        .CYE  (CY_LA_l0_f35[4]  ),
        .CYF  (CY_LA_l0_f35[5]  ),
        .CYG  (CY_LA_l0_f35[6]  ),
        .CYH  (CY_LA_l0_f35[7]  ),
        .PROPA(PROP_LA_l0_f35[0]),
        .PROPB(PROP_LA_l0_f35[1]),
        .PROPC(PROP_LA_l0_f35[2]),
        .PROPD(PROP_LA_l0_f35[3]),
        .PROPE(PROP_LA_l0_f35[4]),
        .PROPF(PROP_LA_l0_f35[5]),
        .PROPG(PROP_LA_l0_f35[6]),
        .PROPH(PROP_LA_l0_f35[7]));

    assign CLA_c517_451_l0_f35[0] = COUT_LA_l0_f35[0];
    assign CLA_c517_451_l0_f35[1] = COUT_LA_l0_f35[2];
    assign CIN_LA_l0_f35          = C0_c517_451_l0_f35[8];
    assign CY_LA_l0_f35[3:0]      = CY0_c517_451_l0_f35;
    assign CY_LA_l0_f35[7:4]      = CY1_c517_451_l0_f35;
    assign PROP_LA_l0_f35[3:0]    = PROP0_c517_451_l0_f35;
    assign PROP_LA_l0_f35[7:4]    = PROP1_c517_451_l0_f35;
    
    // GPC36 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f36(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f36   ),
        .C1   (C1_c517_451_l0_f36   ),
        .CLA  (CLA_c517_451_l0_f36  ),
        .O0   (O0_c517_451_l0_f36   ),
        .O1   (O1_c517_451_l0_f36   ),
        .O2   (O2_c517_451_l0_f36   ),
        .CY0  (CY0_c517_451_l0_f36  ),
        .PROP0(PROP0_c517_451_l0_f36),
        .CY1  (CY1_c517_451_l0_f36  ),
        .PROP1(PROP1_c517_451_l0_f36));
    
    assign C0_c517_451_l0_f36 = layer0_col0[220:204];
    assign C1_c517_451_l0_f36 = layer0_col1[280:276];
    
    assign layer1_col0[12]      = O0_c517_451_l0_f36;
    assign layer1_col1[88:84]   = O1_c517_451_l0_f36;
    assign layer1_col2[147:144] = O2_c517_451_l0_f36;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f36_inst0 (
        .COUTB(COUT_LA_l0_f36[0]),
        .COUTD(COUT_LA_l0_f36[1]),
        .COUTF(COUT_LA_l0_f36[2]),
        .COUTH(COUT_LA_l0_f36[3]),
        .CIN  (CIN_LA_l0_f36    ),
        .CYA  (CY_LA_l0_f36[0]  ),
        .CYB  (CY_LA_l0_f36[1]  ),
        .CYC  (CY_LA_l0_f36[2]  ),
        .CYD  (CY_LA_l0_f36[3]  ),
        .CYE  (CY_LA_l0_f36[4]  ),
        .CYF  (CY_LA_l0_f36[5]  ),
        .CYG  (CY_LA_l0_f36[6]  ),
        .CYH  (CY_LA_l0_f36[7]  ),
        .PROPA(PROP_LA_l0_f36[0]),
        .PROPB(PROP_LA_l0_f36[1]),
        .PROPC(PROP_LA_l0_f36[2]),
        .PROPD(PROP_LA_l0_f36[3]),
        .PROPE(PROP_LA_l0_f36[4]),
        .PROPF(PROP_LA_l0_f36[5]),
        .PROPG(PROP_LA_l0_f36[6]),
        .PROPH(PROP_LA_l0_f36[7]));

    assign CLA_c517_451_l0_f36[0] = COUT_LA_l0_f36[0];
    assign CLA_c517_451_l0_f36[1] = COUT_LA_l0_f36[2];
    assign CIN_LA_l0_f36          = C0_c517_451_l0_f36[8];
    assign CY_LA_l0_f36[3:0]      = CY0_c517_451_l0_f36;
    assign CY_LA_l0_f36[7:4]      = CY1_c517_451_l0_f36;
    assign PROP_LA_l0_f36[3:0]    = PROP0_c517_451_l0_f36;
    assign PROP_LA_l0_f36[7:4]    = PROP1_c517_451_l0_f36;
    
    // GPC37 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f37(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f37   ),
        .C1   (C1_c517_451_l0_f37   ),
        .CLA  (CLA_c517_451_l0_f37  ),
        .O0   (O0_c517_451_l0_f37   ),
        .O1   (O1_c517_451_l0_f37   ),
        .O2   (O2_c517_451_l0_f37   ),
        .CY0  (CY0_c517_451_l0_f37  ),
        .PROP0(PROP0_c517_451_l0_f37),
        .CY1  (CY1_c517_451_l0_f37  ),
        .PROP1(PROP1_c517_451_l0_f37));
    
    assign C0_c517_451_l0_f37 = layer0_col0[237:221];
    assign C1_c517_451_l0_f37 = layer0_col1[285:281];
    
    assign layer1_col0[13]      = O0_c517_451_l0_f37;
    assign layer1_col1[93:89]   = O1_c517_451_l0_f37;
    assign layer1_col2[151:148] = O2_c517_451_l0_f37;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f37_inst0 (
        .COUTB(COUT_LA_l0_f37[0]),
        .COUTD(COUT_LA_l0_f37[1]),
        .COUTF(COUT_LA_l0_f37[2]),
        .COUTH(COUT_LA_l0_f37[3]),
        .CIN  (CIN_LA_l0_f37    ),
        .CYA  (CY_LA_l0_f37[0]  ),
        .CYB  (CY_LA_l0_f37[1]  ),
        .CYC  (CY_LA_l0_f37[2]  ),
        .CYD  (CY_LA_l0_f37[3]  ),
        .CYE  (CY_LA_l0_f37[4]  ),
        .CYF  (CY_LA_l0_f37[5]  ),
        .CYG  (CY_LA_l0_f37[6]  ),
        .CYH  (CY_LA_l0_f37[7]  ),
        .PROPA(PROP_LA_l0_f37[0]),
        .PROPB(PROP_LA_l0_f37[1]),
        .PROPC(PROP_LA_l0_f37[2]),
        .PROPD(PROP_LA_l0_f37[3]),
        .PROPE(PROP_LA_l0_f37[4]),
        .PROPF(PROP_LA_l0_f37[5]),
        .PROPG(PROP_LA_l0_f37[6]),
        .PROPH(PROP_LA_l0_f37[7]));

    assign CLA_c517_451_l0_f37[0] = COUT_LA_l0_f37[0];
    assign CLA_c517_451_l0_f37[1] = COUT_LA_l0_f37[2];
    assign CIN_LA_l0_f37          = C0_c517_451_l0_f37[8];
    assign CY_LA_l0_f37[3:0]      = CY0_c517_451_l0_f37;
    assign CY_LA_l0_f37[7:4]      = CY1_c517_451_l0_f37;
    assign PROP_LA_l0_f37[3:0]    = PROP0_c517_451_l0_f37;
    assign PROP_LA_l0_f37[7:4]    = PROP1_c517_451_l0_f37;
    
    // GPC38 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f38(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f38   ),
        .C1   (C1_c517_451_l0_f38   ),
        .CLA  (CLA_c517_451_l0_f38  ),
        .O0   (O0_c517_451_l0_f38   ),
        .O1   (O1_c517_451_l0_f38   ),
        .O2   (O2_c517_451_l0_f38   ),
        .CY0  (CY0_c517_451_l0_f38  ),
        .PROP0(PROP0_c517_451_l0_f38),
        .CY1  (CY1_c517_451_l0_f38  ),
        .PROP1(PROP1_c517_451_l0_f38));
    
    assign C0_c517_451_l0_f38 = layer0_col0[254:238];
    assign C1_c517_451_l0_f38 = layer0_col1[290:286];
    
    assign layer1_col0[14]      = O0_c517_451_l0_f38;
    assign layer1_col1[98:94]   = O1_c517_451_l0_f38;
    assign layer1_col2[155:152] = O2_c517_451_l0_f38;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f38_inst0 (
        .COUTB(COUT_LA_l0_f38[0]),
        .COUTD(COUT_LA_l0_f38[1]),
        .COUTF(COUT_LA_l0_f38[2]),
        .COUTH(COUT_LA_l0_f38[3]),
        .CIN  (CIN_LA_l0_f38    ),
        .CYA  (CY_LA_l0_f38[0]  ),
        .CYB  (CY_LA_l0_f38[1]  ),
        .CYC  (CY_LA_l0_f38[2]  ),
        .CYD  (CY_LA_l0_f38[3]  ),
        .CYE  (CY_LA_l0_f38[4]  ),
        .CYF  (CY_LA_l0_f38[5]  ),
        .CYG  (CY_LA_l0_f38[6]  ),
        .CYH  (CY_LA_l0_f38[7]  ),
        .PROPA(PROP_LA_l0_f38[0]),
        .PROPB(PROP_LA_l0_f38[1]),
        .PROPC(PROP_LA_l0_f38[2]),
        .PROPD(PROP_LA_l0_f38[3]),
        .PROPE(PROP_LA_l0_f38[4]),
        .PROPF(PROP_LA_l0_f38[5]),
        .PROPG(PROP_LA_l0_f38[6]),
        .PROPH(PROP_LA_l0_f38[7]));

    assign CLA_c517_451_l0_f38[0] = COUT_LA_l0_f38[0];
    assign CLA_c517_451_l0_f38[1] = COUT_LA_l0_f38[2];
    assign CIN_LA_l0_f38          = C0_c517_451_l0_f38[8];
    assign CY_LA_l0_f38[3:0]      = CY0_c517_451_l0_f38;
    assign CY_LA_l0_f38[7:4]      = CY1_c517_451_l0_f38;
    assign PROP_LA_l0_f38[3:0]    = PROP0_c517_451_l0_f38;
    assign PROP_LA_l0_f38[7:4]    = PROP1_c517_451_l0_f38;
    
    // GPC39 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f39(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f39   ),
        .C1   (C1_c517_451_l0_f39   ),
        .CLA  (CLA_c517_451_l0_f39  ),
        .O0   (O0_c517_451_l0_f39   ),
        .O1   (O1_c517_451_l0_f39   ),
        .O2   (O2_c517_451_l0_f39   ),
        .CY0  (CY0_c517_451_l0_f39  ),
        .PROP0(PROP0_c517_451_l0_f39),
        .CY1  (CY1_c517_451_l0_f39  ),
        .PROP1(PROP1_c517_451_l0_f39));
    
    assign C0_c517_451_l0_f39 = layer0_col0[271:255];
    assign C1_c517_451_l0_f39 = layer0_col1[295:291];
    
    assign layer1_col0[15]      = O0_c517_451_l0_f39;
    assign layer1_col1[103:99]  = O1_c517_451_l0_f39;
    assign layer1_col2[159:156] = O2_c517_451_l0_f39;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f39_inst0 (
        .COUTB(COUT_LA_l0_f39[0]),
        .COUTD(COUT_LA_l0_f39[1]),
        .COUTF(COUT_LA_l0_f39[2]),
        .COUTH(COUT_LA_l0_f39[3]),
        .CIN  (CIN_LA_l0_f39    ),
        .CYA  (CY_LA_l0_f39[0]  ),
        .CYB  (CY_LA_l0_f39[1]  ),
        .CYC  (CY_LA_l0_f39[2]  ),
        .CYD  (CY_LA_l0_f39[3]  ),
        .CYE  (CY_LA_l0_f39[4]  ),
        .CYF  (CY_LA_l0_f39[5]  ),
        .CYG  (CY_LA_l0_f39[6]  ),
        .CYH  (CY_LA_l0_f39[7]  ),
        .PROPA(PROP_LA_l0_f39[0]),
        .PROPB(PROP_LA_l0_f39[1]),
        .PROPC(PROP_LA_l0_f39[2]),
        .PROPD(PROP_LA_l0_f39[3]),
        .PROPE(PROP_LA_l0_f39[4]),
        .PROPF(PROP_LA_l0_f39[5]),
        .PROPG(PROP_LA_l0_f39[6]),
        .PROPH(PROP_LA_l0_f39[7]));

    assign CLA_c517_451_l0_f39[0] = COUT_LA_l0_f39[0];
    assign CLA_c517_451_l0_f39[1] = COUT_LA_l0_f39[2];
    assign CIN_LA_l0_f39          = C0_c517_451_l0_f39[8];
    assign CY_LA_l0_f39[3:0]      = CY0_c517_451_l0_f39;
    assign CY_LA_l0_f39[7:4]      = CY1_c517_451_l0_f39;
    assign PROP_LA_l0_f39[3:0]    = PROP0_c517_451_l0_f39;
    assign PROP_LA_l0_f39[7:4]    = PROP1_c517_451_l0_f39;
    
    // GPC40 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f40(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f40   ),
        .C1   (C1_c517_451_l0_f40   ),
        .CLA  (CLA_c517_451_l0_f40  ),
        .O0   (O0_c517_451_l0_f40   ),
        .O1   (O1_c517_451_l0_f40   ),
        .O2   (O2_c517_451_l0_f40   ),
        .CY0  (CY0_c517_451_l0_f40  ),
        .PROP0(PROP0_c517_451_l0_f40),
        .CY1  (CY1_c517_451_l0_f40  ),
        .PROP1(PROP1_c517_451_l0_f40));
    
    assign C0_c517_451_l0_f40 = layer0_col0[288:272];
    assign C1_c517_451_l0_f40 = layer0_col1[300:296];
    
    assign layer1_col0[16]      = O0_c517_451_l0_f40;
    assign layer1_col1[108:104] = O1_c517_451_l0_f40;
    assign layer1_col2[163:160] = O2_c517_451_l0_f40;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f40_inst0 (
        .COUTB(COUT_LA_l0_f40[0]),
        .COUTD(COUT_LA_l0_f40[1]),
        .COUTF(COUT_LA_l0_f40[2]),
        .COUTH(COUT_LA_l0_f40[3]),
        .CIN  (CIN_LA_l0_f40    ),
        .CYA  (CY_LA_l0_f40[0]  ),
        .CYB  (CY_LA_l0_f40[1]  ),
        .CYC  (CY_LA_l0_f40[2]  ),
        .CYD  (CY_LA_l0_f40[3]  ),
        .CYE  (CY_LA_l0_f40[4]  ),
        .CYF  (CY_LA_l0_f40[5]  ),
        .CYG  (CY_LA_l0_f40[6]  ),
        .CYH  (CY_LA_l0_f40[7]  ),
        .PROPA(PROP_LA_l0_f40[0]),
        .PROPB(PROP_LA_l0_f40[1]),
        .PROPC(PROP_LA_l0_f40[2]),
        .PROPD(PROP_LA_l0_f40[3]),
        .PROPE(PROP_LA_l0_f40[4]),
        .PROPF(PROP_LA_l0_f40[5]),
        .PROPG(PROP_LA_l0_f40[6]),
        .PROPH(PROP_LA_l0_f40[7]));

    assign CLA_c517_451_l0_f40[0] = COUT_LA_l0_f40[0];
    assign CLA_c517_451_l0_f40[1] = COUT_LA_l0_f40[2];
    assign CIN_LA_l0_f40          = C0_c517_451_l0_f40[8];
    assign CY_LA_l0_f40[3:0]      = CY0_c517_451_l0_f40;
    assign CY_LA_l0_f40[7:4]      = CY1_c517_451_l0_f40;
    assign PROP_LA_l0_f40[3:0]    = PROP0_c517_451_l0_f40;
    assign PROP_LA_l0_f40[7:4]    = PROP1_c517_451_l0_f40;
    
    // GPC41 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f41(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f41   ),
        .C1   (C1_c517_451_l0_f41   ),
        .CLA  (CLA_c517_451_l0_f41  ),
        .O0   (O0_c517_451_l0_f41   ),
        .O1   (O1_c517_451_l0_f41   ),
        .O2   (O2_c517_451_l0_f41   ),
        .CY0  (CY0_c517_451_l0_f41  ),
        .PROP0(PROP0_c517_451_l0_f41),
        .CY1  (CY1_c517_451_l0_f41  ),
        .PROP1(PROP1_c517_451_l0_f41));
    
    assign C0_c517_451_l0_f41 = layer0_col0[305:289];
    assign C1_c517_451_l0_f41 = layer0_col1[305:301];
    
    assign layer1_col0[17]      = O0_c517_451_l0_f41;
    assign layer1_col1[113:109] = O1_c517_451_l0_f41;
    assign layer1_col2[167:164] = O2_c517_451_l0_f41;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f41_inst0 (
        .COUTB(COUT_LA_l0_f41[0]),
        .COUTD(COUT_LA_l0_f41[1]),
        .COUTF(COUT_LA_l0_f41[2]),
        .COUTH(COUT_LA_l0_f41[3]),
        .CIN  (CIN_LA_l0_f41    ),
        .CYA  (CY_LA_l0_f41[0]  ),
        .CYB  (CY_LA_l0_f41[1]  ),
        .CYC  (CY_LA_l0_f41[2]  ),
        .CYD  (CY_LA_l0_f41[3]  ),
        .CYE  (CY_LA_l0_f41[4]  ),
        .CYF  (CY_LA_l0_f41[5]  ),
        .CYG  (CY_LA_l0_f41[6]  ),
        .CYH  (CY_LA_l0_f41[7]  ),
        .PROPA(PROP_LA_l0_f41[0]),
        .PROPB(PROP_LA_l0_f41[1]),
        .PROPC(PROP_LA_l0_f41[2]),
        .PROPD(PROP_LA_l0_f41[3]),
        .PROPE(PROP_LA_l0_f41[4]),
        .PROPF(PROP_LA_l0_f41[5]),
        .PROPG(PROP_LA_l0_f41[6]),
        .PROPH(PROP_LA_l0_f41[7]));

    assign CLA_c517_451_l0_f41[0] = COUT_LA_l0_f41[0];
    assign CLA_c517_451_l0_f41[1] = COUT_LA_l0_f41[2];
    assign CIN_LA_l0_f41          = C0_c517_451_l0_f41[8];
    assign CY_LA_l0_f41[3:0]      = CY0_c517_451_l0_f41;
    assign CY_LA_l0_f41[7:4]      = CY1_c517_451_l0_f41;
    assign PROP_LA_l0_f41[3:0]    = PROP0_c517_451_l0_f41;
    assign PROP_LA_l0_f41[7:4]    = PROP1_c517_451_l0_f41;
    
    // GPC42 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f42(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f42   ),
        .C1   (C1_c517_451_l0_f42   ),
        .CLA  (CLA_c517_451_l0_f42  ),
        .O0   (O0_c517_451_l0_f42   ),
        .O1   (O1_c517_451_l0_f42   ),
        .O2   (O2_c517_451_l0_f42   ),
        .CY0  (CY0_c517_451_l0_f42  ),
        .PROP0(PROP0_c517_451_l0_f42),
        .CY1  (CY1_c517_451_l0_f42  ),
        .PROP1(PROP1_c517_451_l0_f42));
    
    assign C0_c517_451_l0_f42 = layer0_col0[322:306];
    assign C1_c517_451_l0_f42 = layer0_col1[310:306];
    
    assign layer1_col0[18]      = O0_c517_451_l0_f42;
    assign layer1_col1[118:114] = O1_c517_451_l0_f42;
    assign layer1_col2[171:168] = O2_c517_451_l0_f42;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f42_inst0 (
        .COUTB(COUT_LA_l0_f42[0]),
        .COUTD(COUT_LA_l0_f42[1]),
        .COUTF(COUT_LA_l0_f42[2]),
        .COUTH(COUT_LA_l0_f42[3]),
        .CIN  (CIN_LA_l0_f42    ),
        .CYA  (CY_LA_l0_f42[0]  ),
        .CYB  (CY_LA_l0_f42[1]  ),
        .CYC  (CY_LA_l0_f42[2]  ),
        .CYD  (CY_LA_l0_f42[3]  ),
        .CYE  (CY_LA_l0_f42[4]  ),
        .CYF  (CY_LA_l0_f42[5]  ),
        .CYG  (CY_LA_l0_f42[6]  ),
        .CYH  (CY_LA_l0_f42[7]  ),
        .PROPA(PROP_LA_l0_f42[0]),
        .PROPB(PROP_LA_l0_f42[1]),
        .PROPC(PROP_LA_l0_f42[2]),
        .PROPD(PROP_LA_l0_f42[3]),
        .PROPE(PROP_LA_l0_f42[4]),
        .PROPF(PROP_LA_l0_f42[5]),
        .PROPG(PROP_LA_l0_f42[6]),
        .PROPH(PROP_LA_l0_f42[7]));

    assign CLA_c517_451_l0_f42[0] = COUT_LA_l0_f42[0];
    assign CLA_c517_451_l0_f42[1] = COUT_LA_l0_f42[2];
    assign CIN_LA_l0_f42          = C0_c517_451_l0_f42[8];
    assign CY_LA_l0_f42[3:0]      = CY0_c517_451_l0_f42;
    assign CY_LA_l0_f42[7:4]      = CY1_c517_451_l0_f42;
    assign PROP_LA_l0_f42[3:0]    = PROP0_c517_451_l0_f42;
    assign PROP_LA_l0_f42[7:4]    = PROP1_c517_451_l0_f42;
    
    // GPC43 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f43(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f43   ),
        .C1   (C1_c517_451_l0_f43   ),
        .CLA  (CLA_c517_451_l0_f43  ),
        .O0   (O0_c517_451_l0_f43   ),
        .O1   (O1_c517_451_l0_f43   ),
        .O2   (O2_c517_451_l0_f43   ),
        .CY0  (CY0_c517_451_l0_f43  ),
        .PROP0(PROP0_c517_451_l0_f43),
        .CY1  (CY1_c517_451_l0_f43  ),
        .PROP1(PROP1_c517_451_l0_f43));
    
    assign C0_c517_451_l0_f43 = layer0_col0[339:323];
    assign C1_c517_451_l0_f43 = layer0_col1[315:311];
    
    assign layer1_col0[19]      = O0_c517_451_l0_f43;
    assign layer1_col1[123:119] = O1_c517_451_l0_f43;
    assign layer1_col2[175:172] = O2_c517_451_l0_f43;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f43_inst0 (
        .COUTB(COUT_LA_l0_f43[0]),
        .COUTD(COUT_LA_l0_f43[1]),
        .COUTF(COUT_LA_l0_f43[2]),
        .COUTH(COUT_LA_l0_f43[3]),
        .CIN  (CIN_LA_l0_f43    ),
        .CYA  (CY_LA_l0_f43[0]  ),
        .CYB  (CY_LA_l0_f43[1]  ),
        .CYC  (CY_LA_l0_f43[2]  ),
        .CYD  (CY_LA_l0_f43[3]  ),
        .CYE  (CY_LA_l0_f43[4]  ),
        .CYF  (CY_LA_l0_f43[5]  ),
        .CYG  (CY_LA_l0_f43[6]  ),
        .CYH  (CY_LA_l0_f43[7]  ),
        .PROPA(PROP_LA_l0_f43[0]),
        .PROPB(PROP_LA_l0_f43[1]),
        .PROPC(PROP_LA_l0_f43[2]),
        .PROPD(PROP_LA_l0_f43[3]),
        .PROPE(PROP_LA_l0_f43[4]),
        .PROPF(PROP_LA_l0_f43[5]),
        .PROPG(PROP_LA_l0_f43[6]),
        .PROPH(PROP_LA_l0_f43[7]));

    assign CLA_c517_451_l0_f43[0] = COUT_LA_l0_f43[0];
    assign CLA_c517_451_l0_f43[1] = COUT_LA_l0_f43[2];
    assign CIN_LA_l0_f43          = C0_c517_451_l0_f43[8];
    assign CY_LA_l0_f43[3:0]      = CY0_c517_451_l0_f43;
    assign CY_LA_l0_f43[7:4]      = CY1_c517_451_l0_f43;
    assign PROP_LA_l0_f43[3:0]    = PROP0_c517_451_l0_f43;
    assign PROP_LA_l0_f43[7:4]    = PROP1_c517_451_l0_f43;
    
    // GPC44 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f44(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f44   ),
        .C1   (C1_c517_451_l0_f44   ),
        .CLA  (CLA_c517_451_l0_f44  ),
        .O0   (O0_c517_451_l0_f44   ),
        .O1   (O1_c517_451_l0_f44   ),
        .O2   (O2_c517_451_l0_f44   ),
        .CY0  (CY0_c517_451_l0_f44  ),
        .PROP0(PROP0_c517_451_l0_f44),
        .CY1  (CY1_c517_451_l0_f44  ),
        .PROP1(PROP1_c517_451_l0_f44));
    
    assign C0_c517_451_l0_f44 = layer0_col0[356:340];
    assign C1_c517_451_l0_f44 = layer0_col1[320:316];
    
    assign layer1_col0[20]      = O0_c517_451_l0_f44;
    assign layer1_col1[128:124] = O1_c517_451_l0_f44;
    assign layer1_col2[179:176] = O2_c517_451_l0_f44;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f44_inst0 (
        .COUTB(COUT_LA_l0_f44[0]),
        .COUTD(COUT_LA_l0_f44[1]),
        .COUTF(COUT_LA_l0_f44[2]),
        .COUTH(COUT_LA_l0_f44[3]),
        .CIN  (CIN_LA_l0_f44    ),
        .CYA  (CY_LA_l0_f44[0]  ),
        .CYB  (CY_LA_l0_f44[1]  ),
        .CYC  (CY_LA_l0_f44[2]  ),
        .CYD  (CY_LA_l0_f44[3]  ),
        .CYE  (CY_LA_l0_f44[4]  ),
        .CYF  (CY_LA_l0_f44[5]  ),
        .CYG  (CY_LA_l0_f44[6]  ),
        .CYH  (CY_LA_l0_f44[7]  ),
        .PROPA(PROP_LA_l0_f44[0]),
        .PROPB(PROP_LA_l0_f44[1]),
        .PROPC(PROP_LA_l0_f44[2]),
        .PROPD(PROP_LA_l0_f44[3]),
        .PROPE(PROP_LA_l0_f44[4]),
        .PROPF(PROP_LA_l0_f44[5]),
        .PROPG(PROP_LA_l0_f44[6]),
        .PROPH(PROP_LA_l0_f44[7]));

    assign CLA_c517_451_l0_f44[0] = COUT_LA_l0_f44[0];
    assign CLA_c517_451_l0_f44[1] = COUT_LA_l0_f44[2];
    assign CIN_LA_l0_f44          = C0_c517_451_l0_f44[8];
    assign CY_LA_l0_f44[3:0]      = CY0_c517_451_l0_f44;
    assign CY_LA_l0_f44[7:4]      = CY1_c517_451_l0_f44;
    assign PROP_LA_l0_f44[3:0]    = PROP0_c517_451_l0_f44;
    assign PROP_LA_l0_f44[7:4]    = PROP1_c517_451_l0_f44;
    
    // GPC45 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f45(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f45   ),
        .C1   (C1_c517_451_l0_f45   ),
        .CLA  (CLA_c517_451_l0_f45  ),
        .O0   (O0_c517_451_l0_f45   ),
        .O1   (O1_c517_451_l0_f45   ),
        .O2   (O2_c517_451_l0_f45   ),
        .CY0  (CY0_c517_451_l0_f45  ),
        .PROP0(PROP0_c517_451_l0_f45),
        .CY1  (CY1_c517_451_l0_f45  ),
        .PROP1(PROP1_c517_451_l0_f45));
    
    assign C0_c517_451_l0_f45 = layer0_col0[373:357];
    assign C1_c517_451_l0_f45 = layer0_col1[325:321];
    
    assign layer1_col0[21]      = O0_c517_451_l0_f45;
    assign layer1_col1[133:129] = O1_c517_451_l0_f45;
    assign layer1_col2[183:180] = O2_c517_451_l0_f45;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f45_inst0 (
        .COUTB(COUT_LA_l0_f45[0]),
        .COUTD(COUT_LA_l0_f45[1]),
        .COUTF(COUT_LA_l0_f45[2]),
        .COUTH(COUT_LA_l0_f45[3]),
        .CIN  (CIN_LA_l0_f45    ),
        .CYA  (CY_LA_l0_f45[0]  ),
        .CYB  (CY_LA_l0_f45[1]  ),
        .CYC  (CY_LA_l0_f45[2]  ),
        .CYD  (CY_LA_l0_f45[3]  ),
        .CYE  (CY_LA_l0_f45[4]  ),
        .CYF  (CY_LA_l0_f45[5]  ),
        .CYG  (CY_LA_l0_f45[6]  ),
        .CYH  (CY_LA_l0_f45[7]  ),
        .PROPA(PROP_LA_l0_f45[0]),
        .PROPB(PROP_LA_l0_f45[1]),
        .PROPC(PROP_LA_l0_f45[2]),
        .PROPD(PROP_LA_l0_f45[3]),
        .PROPE(PROP_LA_l0_f45[4]),
        .PROPF(PROP_LA_l0_f45[5]),
        .PROPG(PROP_LA_l0_f45[6]),
        .PROPH(PROP_LA_l0_f45[7]));

    assign CLA_c517_451_l0_f45[0] = COUT_LA_l0_f45[0];
    assign CLA_c517_451_l0_f45[1] = COUT_LA_l0_f45[2];
    assign CIN_LA_l0_f45          = C0_c517_451_l0_f45[8];
    assign CY_LA_l0_f45[3:0]      = CY0_c517_451_l0_f45;
    assign CY_LA_l0_f45[7:4]      = CY1_c517_451_l0_f45;
    assign PROP_LA_l0_f45[3:0]    = PROP0_c517_451_l0_f45;
    assign PROP_LA_l0_f45[7:4]    = PROP1_c517_451_l0_f45;
    
    // GPC46 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f46(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f46   ),
        .C1   (C1_c517_451_l0_f46   ),
        .CLA  (CLA_c517_451_l0_f46  ),
        .O0   (O0_c517_451_l0_f46   ),
        .O1   (O1_c517_451_l0_f46   ),
        .O2   (O2_c517_451_l0_f46   ),
        .CY0  (CY0_c517_451_l0_f46  ),
        .PROP0(PROP0_c517_451_l0_f46),
        .CY1  (CY1_c517_451_l0_f46  ),
        .PROP1(PROP1_c517_451_l0_f46));
    
    assign C0_c517_451_l0_f46 = layer0_col0[390:374];
    assign C1_c517_451_l0_f46 = layer0_col1[330:326];
    
    assign layer1_col0[22]      = O0_c517_451_l0_f46;
    assign layer1_col1[138:134] = O1_c517_451_l0_f46;
    assign layer1_col2[187:184] = O2_c517_451_l0_f46;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f46_inst0 (
        .COUTB(COUT_LA_l0_f46[0]),
        .COUTD(COUT_LA_l0_f46[1]),
        .COUTF(COUT_LA_l0_f46[2]),
        .COUTH(COUT_LA_l0_f46[3]),
        .CIN  (CIN_LA_l0_f46    ),
        .CYA  (CY_LA_l0_f46[0]  ),
        .CYB  (CY_LA_l0_f46[1]  ),
        .CYC  (CY_LA_l0_f46[2]  ),
        .CYD  (CY_LA_l0_f46[3]  ),
        .CYE  (CY_LA_l0_f46[4]  ),
        .CYF  (CY_LA_l0_f46[5]  ),
        .CYG  (CY_LA_l0_f46[6]  ),
        .CYH  (CY_LA_l0_f46[7]  ),
        .PROPA(PROP_LA_l0_f46[0]),
        .PROPB(PROP_LA_l0_f46[1]),
        .PROPC(PROP_LA_l0_f46[2]),
        .PROPD(PROP_LA_l0_f46[3]),
        .PROPE(PROP_LA_l0_f46[4]),
        .PROPF(PROP_LA_l0_f46[5]),
        .PROPG(PROP_LA_l0_f46[6]),
        .PROPH(PROP_LA_l0_f46[7]));

    assign CLA_c517_451_l0_f46[0] = COUT_LA_l0_f46[0];
    assign CLA_c517_451_l0_f46[1] = COUT_LA_l0_f46[2];
    assign CIN_LA_l0_f46          = C0_c517_451_l0_f46[8];
    assign CY_LA_l0_f46[3:0]      = CY0_c517_451_l0_f46;
    assign CY_LA_l0_f46[7:4]      = CY1_c517_451_l0_f46;
    assign PROP_LA_l0_f46[3:0]    = PROP0_c517_451_l0_f46;
    assign PROP_LA_l0_f46[7:4]    = PROP1_c517_451_l0_f46;
    
    // GPC47 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f47(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f47   ),
        .C1   (C1_c517_451_l0_f47   ),
        .CLA  (CLA_c517_451_l0_f47  ),
        .O0   (O0_c517_451_l0_f47   ),
        .O1   (O1_c517_451_l0_f47   ),
        .O2   (O2_c517_451_l0_f47   ),
        .CY0  (CY0_c517_451_l0_f47  ),
        .PROP0(PROP0_c517_451_l0_f47),
        .CY1  (CY1_c517_451_l0_f47  ),
        .PROP1(PROP1_c517_451_l0_f47));
    
    assign C0_c517_451_l0_f47 = layer0_col0[407:391];
    assign C1_c517_451_l0_f47 = layer0_col1[335:331];
    
    assign layer1_col0[23]      = O0_c517_451_l0_f47;
    assign layer1_col1[143:139] = O1_c517_451_l0_f47;
    assign layer1_col2[191:188] = O2_c517_451_l0_f47;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f47_inst0 (
        .COUTB(COUT_LA_l0_f47[0]),
        .COUTD(COUT_LA_l0_f47[1]),
        .COUTF(COUT_LA_l0_f47[2]),
        .COUTH(COUT_LA_l0_f47[3]),
        .CIN  (CIN_LA_l0_f47    ),
        .CYA  (CY_LA_l0_f47[0]  ),
        .CYB  (CY_LA_l0_f47[1]  ),
        .CYC  (CY_LA_l0_f47[2]  ),
        .CYD  (CY_LA_l0_f47[3]  ),
        .CYE  (CY_LA_l0_f47[4]  ),
        .CYF  (CY_LA_l0_f47[5]  ),
        .CYG  (CY_LA_l0_f47[6]  ),
        .CYH  (CY_LA_l0_f47[7]  ),
        .PROPA(PROP_LA_l0_f47[0]),
        .PROPB(PROP_LA_l0_f47[1]),
        .PROPC(PROP_LA_l0_f47[2]),
        .PROPD(PROP_LA_l0_f47[3]),
        .PROPE(PROP_LA_l0_f47[4]),
        .PROPF(PROP_LA_l0_f47[5]),
        .PROPG(PROP_LA_l0_f47[6]),
        .PROPH(PROP_LA_l0_f47[7]));

    assign CLA_c517_451_l0_f47[0] = COUT_LA_l0_f47[0];
    assign CLA_c517_451_l0_f47[1] = COUT_LA_l0_f47[2];
    assign CIN_LA_l0_f47          = C0_c517_451_l0_f47[8];
    assign CY_LA_l0_f47[3:0]      = CY0_c517_451_l0_f47;
    assign CY_LA_l0_f47[7:4]      = CY1_c517_451_l0_f47;
    assign PROP_LA_l0_f47[3:0]    = PROP0_c517_451_l0_f47;
    assign PROP_LA_l0_f47[7:4]    = PROP1_c517_451_l0_f47;
    
    // GPC48 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f48(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f48   ),
        .C1   (C1_c517_451_l0_f48   ),
        .CLA  (CLA_c517_451_l0_f48  ),
        .O0   (O0_c517_451_l0_f48   ),
        .O1   (O1_c517_451_l0_f48   ),
        .O2   (O2_c517_451_l0_f48   ),
        .CY0  (CY0_c517_451_l0_f48  ),
        .PROP0(PROP0_c517_451_l0_f48),
        .CY1  (CY1_c517_451_l0_f48  ),
        .PROP1(PROP1_c517_451_l0_f48));
    
    assign C0_c517_451_l0_f48 = layer0_col0[424:408];
    assign C1_c517_451_l0_f48 = layer0_col1[340:336];
    
    assign layer1_col0[24]      = O0_c517_451_l0_f48;
    assign layer1_col1[148:144] = O1_c517_451_l0_f48;
    assign layer1_col2[195:192] = O2_c517_451_l0_f48;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f48_inst0 (
        .COUTB(COUT_LA_l0_f48[0]),
        .COUTD(COUT_LA_l0_f48[1]),
        .COUTF(COUT_LA_l0_f48[2]),
        .COUTH(COUT_LA_l0_f48[3]),
        .CIN  (CIN_LA_l0_f48    ),
        .CYA  (CY_LA_l0_f48[0]  ),
        .CYB  (CY_LA_l0_f48[1]  ),
        .CYC  (CY_LA_l0_f48[2]  ),
        .CYD  (CY_LA_l0_f48[3]  ),
        .CYE  (CY_LA_l0_f48[4]  ),
        .CYF  (CY_LA_l0_f48[5]  ),
        .CYG  (CY_LA_l0_f48[6]  ),
        .CYH  (CY_LA_l0_f48[7]  ),
        .PROPA(PROP_LA_l0_f48[0]),
        .PROPB(PROP_LA_l0_f48[1]),
        .PROPC(PROP_LA_l0_f48[2]),
        .PROPD(PROP_LA_l0_f48[3]),
        .PROPE(PROP_LA_l0_f48[4]),
        .PROPF(PROP_LA_l0_f48[5]),
        .PROPG(PROP_LA_l0_f48[6]),
        .PROPH(PROP_LA_l0_f48[7]));

    assign CLA_c517_451_l0_f48[0] = COUT_LA_l0_f48[0];
    assign CLA_c517_451_l0_f48[1] = COUT_LA_l0_f48[2];
    assign CIN_LA_l0_f48          = C0_c517_451_l0_f48[8];
    assign CY_LA_l0_f48[3:0]      = CY0_c517_451_l0_f48;
    assign CY_LA_l0_f48[7:4]      = CY1_c517_451_l0_f48;
    assign PROP_LA_l0_f48[3:0]    = PROP0_c517_451_l0_f48;
    assign PROP_LA_l0_f48[7:4]    = PROP1_c517_451_l0_f48;
    
    // GPC49 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f49(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f49   ),
        .C1   (C1_c517_451_l0_f49   ),
        .CLA  (CLA_c517_451_l0_f49  ),
        .O0   (O0_c517_451_l0_f49   ),
        .O1   (O1_c517_451_l0_f49   ),
        .O2   (O2_c517_451_l0_f49   ),
        .CY0  (CY0_c517_451_l0_f49  ),
        .PROP0(PROP0_c517_451_l0_f49),
        .CY1  (CY1_c517_451_l0_f49  ),
        .PROP1(PROP1_c517_451_l0_f49));
    
    assign C0_c517_451_l0_f49 = layer0_col0[441:425];
    assign C1_c517_451_l0_f49 = layer0_col1[345:341];
    
    assign layer1_col0[25]      = O0_c517_451_l0_f49;
    assign layer1_col1[153:149] = O1_c517_451_l0_f49;
    assign layer1_col2[199:196] = O2_c517_451_l0_f49;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f49_inst0 (
        .COUTB(COUT_LA_l0_f49[0]),
        .COUTD(COUT_LA_l0_f49[1]),
        .COUTF(COUT_LA_l0_f49[2]),
        .COUTH(COUT_LA_l0_f49[3]),
        .CIN  (CIN_LA_l0_f49    ),
        .CYA  (CY_LA_l0_f49[0]  ),
        .CYB  (CY_LA_l0_f49[1]  ),
        .CYC  (CY_LA_l0_f49[2]  ),
        .CYD  (CY_LA_l0_f49[3]  ),
        .CYE  (CY_LA_l0_f49[4]  ),
        .CYF  (CY_LA_l0_f49[5]  ),
        .CYG  (CY_LA_l0_f49[6]  ),
        .CYH  (CY_LA_l0_f49[7]  ),
        .PROPA(PROP_LA_l0_f49[0]),
        .PROPB(PROP_LA_l0_f49[1]),
        .PROPC(PROP_LA_l0_f49[2]),
        .PROPD(PROP_LA_l0_f49[3]),
        .PROPE(PROP_LA_l0_f49[4]),
        .PROPF(PROP_LA_l0_f49[5]),
        .PROPG(PROP_LA_l0_f49[6]),
        .PROPH(PROP_LA_l0_f49[7]));

    assign CLA_c517_451_l0_f49[0] = COUT_LA_l0_f49[0];
    assign CLA_c517_451_l0_f49[1] = COUT_LA_l0_f49[2];
    assign CIN_LA_l0_f49          = C0_c517_451_l0_f49[8];
    assign CY_LA_l0_f49[3:0]      = CY0_c517_451_l0_f49;
    assign CY_LA_l0_f49[7:4]      = CY1_c517_451_l0_f49;
    assign PROP_LA_l0_f49[3:0]    = PROP0_c517_451_l0_f49;
    assign PROP_LA_l0_f49[7:4]    = PROP1_c517_451_l0_f49;
    
    // GPC50 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f50(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f50   ),
        .C1   (C1_c517_451_l0_f50   ),
        .CLA  (CLA_c517_451_l0_f50  ),
        .O0   (O0_c517_451_l0_f50   ),
        .O1   (O1_c517_451_l0_f50   ),
        .O2   (O2_c517_451_l0_f50   ),
        .CY0  (CY0_c517_451_l0_f50  ),
        .PROP0(PROP0_c517_451_l0_f50),
        .CY1  (CY1_c517_451_l0_f50  ),
        .PROP1(PROP1_c517_451_l0_f50));
    
    assign C0_c517_451_l0_f50 = layer0_col0[458:442];
    assign C1_c517_451_l0_f50 = layer0_col1[350:346];
    
    assign layer1_col0[26]      = O0_c517_451_l0_f50;
    assign layer1_col1[158:154] = O1_c517_451_l0_f50;
    assign layer1_col2[203:200] = O2_c517_451_l0_f50;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f50_inst0 (
        .COUTB(COUT_LA_l0_f50[0]),
        .COUTD(COUT_LA_l0_f50[1]),
        .COUTF(COUT_LA_l0_f50[2]),
        .COUTH(COUT_LA_l0_f50[3]),
        .CIN  (CIN_LA_l0_f50    ),
        .CYA  (CY_LA_l0_f50[0]  ),
        .CYB  (CY_LA_l0_f50[1]  ),
        .CYC  (CY_LA_l0_f50[2]  ),
        .CYD  (CY_LA_l0_f50[3]  ),
        .CYE  (CY_LA_l0_f50[4]  ),
        .CYF  (CY_LA_l0_f50[5]  ),
        .CYG  (CY_LA_l0_f50[6]  ),
        .CYH  (CY_LA_l0_f50[7]  ),
        .PROPA(PROP_LA_l0_f50[0]),
        .PROPB(PROP_LA_l0_f50[1]),
        .PROPC(PROP_LA_l0_f50[2]),
        .PROPD(PROP_LA_l0_f50[3]),
        .PROPE(PROP_LA_l0_f50[4]),
        .PROPF(PROP_LA_l0_f50[5]),
        .PROPG(PROP_LA_l0_f50[6]),
        .PROPH(PROP_LA_l0_f50[7]));

    assign CLA_c517_451_l0_f50[0] = COUT_LA_l0_f50[0];
    assign CLA_c517_451_l0_f50[1] = COUT_LA_l0_f50[2];
    assign CIN_LA_l0_f50          = C0_c517_451_l0_f50[8];
    assign CY_LA_l0_f50[3:0]      = CY0_c517_451_l0_f50;
    assign CY_LA_l0_f50[7:4]      = CY1_c517_451_l0_f50;
    assign PROP_LA_l0_f50[3:0]    = PROP0_c517_451_l0_f50;
    assign PROP_LA_l0_f50[7:4]    = PROP1_c517_451_l0_f50;
    
    // GPC51 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f51(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f51   ),
        .C1   (C1_c517_451_l0_f51   ),
        .CLA  (CLA_c517_451_l0_f51  ),
        .O0   (O0_c517_451_l0_f51   ),
        .O1   (O1_c517_451_l0_f51   ),
        .O2   (O2_c517_451_l0_f51   ),
        .CY0  (CY0_c517_451_l0_f51  ),
        .PROP0(PROP0_c517_451_l0_f51),
        .CY1  (CY1_c517_451_l0_f51  ),
        .PROP1(PROP1_c517_451_l0_f51));
    
    assign C0_c517_451_l0_f51 = layer0_col0[475:459];
    assign C1_c517_451_l0_f51 = layer0_col1[355:351];
    
    assign layer1_col0[27]      = O0_c517_451_l0_f51;
    assign layer1_col1[163:159] = O1_c517_451_l0_f51;
    assign layer1_col2[207:204] = O2_c517_451_l0_f51;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f51_inst0 (
        .COUTB(COUT_LA_l0_f51[0]),
        .COUTD(COUT_LA_l0_f51[1]),
        .COUTF(COUT_LA_l0_f51[2]),
        .COUTH(COUT_LA_l0_f51[3]),
        .CIN  (CIN_LA_l0_f51    ),
        .CYA  (CY_LA_l0_f51[0]  ),
        .CYB  (CY_LA_l0_f51[1]  ),
        .CYC  (CY_LA_l0_f51[2]  ),
        .CYD  (CY_LA_l0_f51[3]  ),
        .CYE  (CY_LA_l0_f51[4]  ),
        .CYF  (CY_LA_l0_f51[5]  ),
        .CYG  (CY_LA_l0_f51[6]  ),
        .CYH  (CY_LA_l0_f51[7]  ),
        .PROPA(PROP_LA_l0_f51[0]),
        .PROPB(PROP_LA_l0_f51[1]),
        .PROPC(PROP_LA_l0_f51[2]),
        .PROPD(PROP_LA_l0_f51[3]),
        .PROPE(PROP_LA_l0_f51[4]),
        .PROPF(PROP_LA_l0_f51[5]),
        .PROPG(PROP_LA_l0_f51[6]),
        .PROPH(PROP_LA_l0_f51[7]));

    assign CLA_c517_451_l0_f51[0] = COUT_LA_l0_f51[0];
    assign CLA_c517_451_l0_f51[1] = COUT_LA_l0_f51[2];
    assign CIN_LA_l0_f51          = C0_c517_451_l0_f51[8];
    assign CY_LA_l0_f51[3:0]      = CY0_c517_451_l0_f51;
    assign CY_LA_l0_f51[7:4]      = CY1_c517_451_l0_f51;
    assign PROP_LA_l0_f51[3:0]    = PROP0_c517_451_l0_f51;
    assign PROP_LA_l0_f51[7:4]    = PROP1_c517_451_l0_f51;
    
    // GPC52 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f52(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f52   ),
        .C1   (C1_c517_451_l0_f52   ),
        .CLA  (CLA_c517_451_l0_f52  ),
        .O0   (O0_c517_451_l0_f52   ),
        .O1   (O1_c517_451_l0_f52   ),
        .O2   (O2_c517_451_l0_f52   ),
        .CY0  (CY0_c517_451_l0_f52  ),
        .PROP0(PROP0_c517_451_l0_f52),
        .CY1  (CY1_c517_451_l0_f52  ),
        .PROP1(PROP1_c517_451_l0_f52));
    
    assign C0_c517_451_l0_f52 = layer0_col0[492:476];
    assign C1_c517_451_l0_f52 = layer0_col1[360:356];
    
    assign layer1_col0[28]      = O0_c517_451_l0_f52;
    assign layer1_col1[168:164] = O1_c517_451_l0_f52;
    assign layer1_col2[211:208] = O2_c517_451_l0_f52;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f52_inst0 (
        .COUTB(COUT_LA_l0_f52[0]),
        .COUTD(COUT_LA_l0_f52[1]),
        .COUTF(COUT_LA_l0_f52[2]),
        .COUTH(COUT_LA_l0_f52[3]),
        .CIN  (CIN_LA_l0_f52    ),
        .CYA  (CY_LA_l0_f52[0]  ),
        .CYB  (CY_LA_l0_f52[1]  ),
        .CYC  (CY_LA_l0_f52[2]  ),
        .CYD  (CY_LA_l0_f52[3]  ),
        .CYE  (CY_LA_l0_f52[4]  ),
        .CYF  (CY_LA_l0_f52[5]  ),
        .CYG  (CY_LA_l0_f52[6]  ),
        .CYH  (CY_LA_l0_f52[7]  ),
        .PROPA(PROP_LA_l0_f52[0]),
        .PROPB(PROP_LA_l0_f52[1]),
        .PROPC(PROP_LA_l0_f52[2]),
        .PROPD(PROP_LA_l0_f52[3]),
        .PROPE(PROP_LA_l0_f52[4]),
        .PROPF(PROP_LA_l0_f52[5]),
        .PROPG(PROP_LA_l0_f52[6]),
        .PROPH(PROP_LA_l0_f52[7]));

    assign CLA_c517_451_l0_f52[0] = COUT_LA_l0_f52[0];
    assign CLA_c517_451_l0_f52[1] = COUT_LA_l0_f52[2];
    assign CIN_LA_l0_f52          = C0_c517_451_l0_f52[8];
    assign CY_LA_l0_f52[3:0]      = CY0_c517_451_l0_f52;
    assign CY_LA_l0_f52[7:4]      = CY1_c517_451_l0_f52;
    assign PROP_LA_l0_f52[3:0]    = PROP0_c517_451_l0_f52;
    assign PROP_LA_l0_f52[7:4]    = PROP1_c517_451_l0_f52;
    
    // GPC53 in layer0: (5,17 : 4,5,1) at column 0
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l0_f53(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l0_f53   ),
        .C1   (C1_c517_451_l0_f53   ),
        .CLA  (CLA_c517_451_l0_f53  ),
        .O0   (O0_c517_451_l0_f53   ),
        .O1   (O1_c517_451_l0_f53   ),
        .O2   (O2_c517_451_l0_f53   ),
        .CY0  (CY0_c517_451_l0_f53  ),
        .PROP0(PROP0_c517_451_l0_f53),
        .CY1  (CY1_c517_451_l0_f53  ),
        .PROP1(PROP1_c517_451_l0_f53));
    
    assign C0_c517_451_l0_f53 = layer0_col0[509:493];
    assign C1_c517_451_l0_f53 = layer0_col1[365:361];
    
    assign layer1_col0[29]      = O0_c517_451_l0_f53;
    assign layer1_col1[173:169] = O1_c517_451_l0_f53;
    assign layer1_col2[215:212] = O2_c517_451_l0_f53;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f53_inst0 (
        .COUTB(COUT_LA_l0_f53[0]),
        .COUTD(COUT_LA_l0_f53[1]),
        .COUTF(COUT_LA_l0_f53[2]),
        .COUTH(COUT_LA_l0_f53[3]),
        .CIN  (CIN_LA_l0_f53    ),
        .CYA  (CY_LA_l0_f53[0]  ),
        .CYB  (CY_LA_l0_f53[1]  ),
        .CYC  (CY_LA_l0_f53[2]  ),
        .CYD  (CY_LA_l0_f53[3]  ),
        .CYE  (CY_LA_l0_f53[4]  ),
        .CYF  (CY_LA_l0_f53[5]  ),
        .CYG  (CY_LA_l0_f53[6]  ),
        .CYH  (CY_LA_l0_f53[7]  ),
        .PROPA(PROP_LA_l0_f53[0]),
        .PROPB(PROP_LA_l0_f53[1]),
        .PROPC(PROP_LA_l0_f53[2]),
        .PROPD(PROP_LA_l0_f53[3]),
        .PROPE(PROP_LA_l0_f53[4]),
        .PROPF(PROP_LA_l0_f53[5]),
        .PROPG(PROP_LA_l0_f53[6]),
        .PROPH(PROP_LA_l0_f53[7]));

    assign CLA_c517_451_l0_f53[0] = COUT_LA_l0_f53[0];
    assign CLA_c517_451_l0_f53[1] = COUT_LA_l0_f53[2];
    assign CIN_LA_l0_f53          = C0_c517_451_l0_f53[8];
    assign CY_LA_l0_f53[3:0]      = CY0_c517_451_l0_f53;
    assign CY_LA_l0_f53[7:4]      = CY1_c517_451_l0_f53;
    assign PROP_LA_l0_f53[3:0]    = PROP0_c517_451_l0_f53;
    assign PROP_LA_l0_f53[7:4]    = PROP1_c517_451_l0_f53;
    
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
    
    assign CY_LA_l0_floating_placement[25:24]   = CY_c9_41_l0_f13;
    assign PROP_LA_l0_floating_placement[25:24] = PROP_c9_41_l0_f13;
    assign CIN_LA_l0_floating_placement[3] = C0_c9_41_l0_f13[8];
    
    assign CY_LA_l0_floating_placement[27:26]   = CY_c9_41_l0_f14;
    assign PROP_LA_l0_floating_placement[27:26] = PROP_c9_41_l0_f14;
    
    assign CY_LA_l0_floating_placement[29:28]   = CY_c9_41_l0_f15;
    assign PROP_LA_l0_floating_placement[29:28] = PROP_c9_41_l0_f15;
    
    assign CY_LA_l0_floating_placement[31:30]   = CY_c9_41_l0_f16;
    assign PROP_LA_l0_floating_placement[31:30] = PROP_c9_41_l0_f16;
    
    assign CY_LA_l0_floating_placement[33:32]   = CY_c9_41_l0_f17;
    assign PROP_LA_l0_floating_placement[33:32] = PROP_c9_41_l0_f17;
    assign CIN_LA_l0_floating_placement[4] = C0_c9_41_l0_f17[8];
    
    assign CY_LA_l0_floating_placement[35:34]   = CY_c9_41_l0_f18;
    assign PROP_LA_l0_floating_placement[35:34] = PROP_c9_41_l0_f18;
    
    assign CY_LA_l0_floating_placement[37:36]   = CY_c9_41_l0_f19;
    assign PROP_LA_l0_floating_placement[37:36] = PROP_c9_41_l0_f19;
    
    assign CY_LA_l0_floating_placement[39:38]   = CY_c9_41_l0_f20;
    assign PROP_LA_l0_floating_placement[39:38] = PROP_c9_41_l0_f20;
    
    assign CY_LA_l0_floating_placement[41:40]   = CY_c9_41_l0_f21;
    assign PROP_LA_l0_floating_placement[41:40] = PROP_c9_41_l0_f21;
    assign CIN_LA_l0_floating_placement[5] = C0_c9_41_l0_f21[8];
    
    assign CY_LA_l0_floating_placement[43:42]   = CY_c9_41_l0_f22;
    assign PROP_LA_l0_floating_placement[43:42] = PROP_c9_41_l0_f22;
    
    assign CY_LA_l0_floating_placement[45:44]   = CY_c9_41_l0_f23;
    assign PROP_LA_l0_floating_placement[45:44] = PROP_c9_41_l0_f23;
    
    assign CY_LA_l0_floating_placement[47:46]   = CY_c9_41_l0_f24;
    assign PROP_LA_l0_floating_placement[47:46] = PROP_c9_41_l0_f24;
    
    assign layer1_col0[30] = layer0_col0[510];
    assign layer1_col0[31] = layer0_col0[511];
    assign layer1_col1[174] = layer0_col1[366];
    assign layer1_col1[175] = layer0_col1[367];
    assign layer1_col1[176] = layer0_col1[368];
    assign layer1_col1[177] = layer0_col1[369];
    assign layer1_col1[178] = layer0_col1[370];
    assign layer1_col1[179] = layer0_col1[371];
    assign layer1_col1[180] = layer0_col1[372];
    assign layer1_col1[181] = layer0_col1[373];
    assign layer1_col1[182] = layer0_col1[374];
    assign layer1_col1[183] = layer0_col1[375];
    assign layer1_col1[184] = layer0_col1[376];
    assign layer1_col1[185] = layer0_col1[377];
    assign layer1_col1[186] = layer0_col1[378];
    assign layer1_col1[187] = layer0_col1[379];
    assign layer1_col1[188] = layer0_col1[380];
    assign layer1_col1[189] = layer0_col1[381];
    assign layer1_col1[190] = layer0_col1[382];
    assign layer1_col1[191] = layer0_col1[383];
    assign layer1_col1[192] = layer0_col1[384];
    assign layer1_col1[193] = layer0_col1[385];
    assign layer1_col1[194] = layer0_col1[386];
    assign layer1_col1[195] = layer0_col1[387];
    assign layer1_col1[196] = layer0_col1[388];
    assign layer1_col1[197] = layer0_col1[389];
    assign layer1_col1[198] = layer0_col1[390];
    assign layer1_col1[199] = layer0_col1[391];
    assign layer1_col1[200] = layer0_col1[392];
    assign layer1_col1[201] = layer0_col1[393];
    assign layer1_col1[202] = layer0_col1[394];
    assign layer1_col1[203] = layer0_col1[395];
    assign layer1_col1[204] = layer0_col1[396];
    assign layer1_col1[205] = layer0_col1[397];
    assign layer1_col1[206] = layer0_col1[398];
    assign layer1_col1[207] = layer0_col1[399];
    assign layer1_col1[208] = layer0_col1[400];
    assign layer1_col1[209] = layer0_col1[401];
    assign layer1_col1[210] = layer0_col1[402];
    assign layer1_col1[211] = layer0_col1[403];
    assign layer1_col1[212] = layer0_col1[404];
    assign layer1_col1[213] = layer0_col1[405];
    assign layer1_col1[214] = layer0_col1[406];
    assign layer1_col1[215] = layer0_col1[407];
    assign layer1_col1[216] = layer0_col1[408];
    assign layer1_col1[217] = layer0_col1[409];
    assign layer1_col1[218] = layer0_col1[410];
    assign layer1_col1[219] = layer0_col1[411];
    assign layer1_col1[220] = layer0_col1[412];
    assign layer1_col1[221] = layer0_col1[413];
    assign layer1_col1[222] = layer0_col1[414];
    assign layer1_col1[223] = layer0_col1[415];
    assign layer1_col1[224] = layer0_col1[416];
    assign layer1_col1[225] = layer0_col1[417];
    assign layer1_col1[226] = layer0_col1[418];
    assign layer1_col1[227] = layer0_col1[419];
    assign layer1_col1[228] = layer0_col1[420];
    assign layer1_col1[229] = layer0_col1[421];
    assign layer1_col1[230] = layer0_col1[422];
    assign layer1_col1[231] = layer0_col1[423];
    assign layer1_col1[232] = layer0_col1[424];
    assign layer1_col1[233] = layer0_col1[425];
    assign layer1_col1[234] = layer0_col1[426];
    assign layer1_col1[235] = layer0_col1[427];
    assign layer1_col1[236] = layer0_col1[428];
    assign layer1_col1[237] = layer0_col1[429];
    assign layer1_col1[238] = layer0_col1[430];
    assign layer1_col1[239] = layer0_col1[431];
    assign layer1_col1[240] = layer0_col1[432];
    assign layer1_col1[241] = layer0_col1[433];
    assign layer1_col1[242] = layer0_col1[434];
    assign layer1_col1[243] = layer0_col1[435];
    assign layer1_col1[244] = layer0_col1[436];
    assign layer1_col1[245] = layer0_col1[437];
    assign layer1_col1[246] = layer0_col1[438];
    assign layer1_col1[247] = layer0_col1[439];
    assign layer1_col1[248] = layer0_col1[440];
    assign layer1_col1[249] = layer0_col1[441];
    assign layer1_col1[250] = layer0_col1[442];
    assign layer1_col1[251] = layer0_col1[443];
    assign layer1_col1[252] = layer0_col1[444];
    assign layer1_col1[253] = layer0_col1[445];
    assign layer1_col1[254] = layer0_col1[446];
    assign layer1_col1[255] = layer0_col1[447];
    assign layer1_col1[256] = layer0_col1[448];
    assign layer1_col1[257] = layer0_col1[449];
    assign layer1_col1[258] = layer0_col1[450];
    assign layer1_col1[259] = layer0_col1[451];
    assign layer1_col1[260] = layer0_col1[452];
    assign layer1_col1[261] = layer0_col1[453];
    assign layer1_col1[262] = layer0_col1[454];
    assign layer1_col1[263] = layer0_col1[455];
    assign layer1_col1[264] = layer0_col1[456];
    assign layer1_col1[265] = layer0_col1[457];
    assign layer1_col1[266] = layer0_col1[458];
    assign layer1_col1[267] = layer0_col1[459];
    assign layer1_col1[268] = layer0_col1[460];
    assign layer1_col1[269] = layer0_col1[461];
    assign layer1_col1[270] = layer0_col1[462];
    assign layer1_col1[271] = layer0_col1[463];
    assign layer1_col1[272] = layer0_col1[464];
    assign layer1_col1[273] = layer0_col1[465];
    assign layer1_col1[274] = layer0_col1[466];
    assign layer1_col1[275] = layer0_col1[467];
    assign layer1_col1[276] = layer0_col1[468];
    assign layer1_col1[277] = layer0_col1[469];
    assign layer1_col1[278] = layer0_col1[470];
    assign layer1_col1[279] = layer0_col1[471];
    assign layer1_col1[280] = layer0_col1[472];
    assign layer1_col1[281] = layer0_col1[473];
    assign layer1_col1[282] = layer0_col1[474];
    assign layer1_col1[283] = layer0_col1[475];
    assign layer1_col1[284] = layer0_col1[476];
    assign layer1_col1[285] = layer0_col1[477];
    assign layer1_col1[286] = layer0_col1[478];
    assign layer1_col1[287] = layer0_col1[479];
    assign layer1_col1[288] = layer0_col1[480];
    assign layer1_col1[289] = layer0_col1[481];
    assign layer1_col1[290] = layer0_col1[482];
    assign layer1_col1[291] = layer0_col1[483];
    assign layer1_col1[292] = layer0_col1[484];
    assign layer1_col1[293] = layer0_col1[485];
    assign layer1_col1[294] = layer0_col1[486];
    assign layer1_col1[295] = layer0_col1[487];
    assign layer1_col1[296] = layer0_col1[488];
    assign layer1_col1[297] = layer0_col1[489];
    assign layer1_col1[298] = layer0_col1[490];
    assign layer1_col1[299] = layer0_col1[491];
    assign layer1_col1[300] = layer0_col1[492];
    assign layer1_col1[301] = layer0_col1[493];
    assign layer1_col1[302] = layer0_col1[494];
    assign layer1_col1[303] = layer0_col1[495];
    assign layer1_col1[304] = layer0_col1[496];
    assign layer1_col1[305] = layer0_col1[497];
    assign layer1_col1[306] = layer0_col1[498];
    assign layer1_col1[307] = layer0_col1[499];
    assign layer1_col1[308] = layer0_col1[500];
    assign layer1_col1[309] = layer0_col1[501];
    assign layer1_col1[310] = layer0_col1[502];
    assign layer1_col1[311] = layer0_col1[503];
    assign layer1_col1[312] = layer0_col1[504];
    assign layer1_col1[313] = layer0_col1[505];
    assign layer1_col1[314] = layer0_col1[506];
    assign layer1_col1[315] = layer0_col1[507];
    assign layer1_col1[316] = layer0_col1[508];
    assign layer1_col1[317] = layer0_col1[509];
    assign layer1_col1[318] = layer0_col1[510];
    assign layer1_col1[319] = layer0_col1[511];
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
    
    assign C0_c517_451_l1_f1 = layer1_col1[21:5];
    assign C1_c517_451_l1_f1 = layer1_col2[4:0];
    
    assign layer2_col1[5]   = O0_c517_451_l1_f1;
    assign layer2_col2[8:4] = O1_c517_451_l1_f1;
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
    
    assign layer2_col2[9]   = O0_c9_41_l1_f2;
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
    
    assign layer2_col2[10]   = O0_c9_41_l1_f3;
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
    
    assign layer2_col2[11]    = O0_c9_41_l1_f4;
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
    
    assign layer2_col2[12]    = O0_c9_41_l1_f5;
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
    
    assign layer2_col2[13]    = O0_c9_41_l1_f6;
    assign layer2_col3[23:20] = O1_c9_41_l1_f6;
    
    // GPC7 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f7(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f7  ),
        .CLA (CLA_c9_41_l1_f7 ),
        .O0  (O0_c9_41_l1_f7  ),
        .O1  (O1_c9_41_l1_f7  ),
        .CY  (CY_c9_41_l1_f7  ),
        .PROP(PROP_c9_41_l1_f7));
    
    assign C0_c9_41_l1_f7 = layer1_col2[58:50];
    
    assign layer2_col2[14]    = O0_c9_41_l1_f7;
    assign layer2_col3[27:24] = O1_c9_41_l1_f7;
    
    // GPC8 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f8(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f8  ),
        .CLA (CLA_c9_41_l1_f8 ),
        .O0  (O0_c9_41_l1_f8  ),
        .O1  (O1_c9_41_l1_f8  ),
        .CY  (CY_c9_41_l1_f8  ),
        .PROP(PROP_c9_41_l1_f8));
    
    assign C0_c9_41_l1_f8 = layer1_col2[67:59];
    
    assign layer2_col2[15]    = O0_c9_41_l1_f8;
    assign layer2_col3[31:28] = O1_c9_41_l1_f8;
    
    // GPC9 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f9(
        .clk (clk             ),
        .C0  (C0_c9_41_l1_f9  ),
        .CLA (CLA_c9_41_l1_f9 ),
        .O0  (O0_c9_41_l1_f9  ),
        .O1  (O1_c9_41_l1_f9  ),
        .CY  (CY_c9_41_l1_f9  ),
        .PROP(PROP_c9_41_l1_f9));
    
    assign C0_c9_41_l1_f9 = layer1_col2[76:68];
    
    assign layer2_col2[16]    = O0_c9_41_l1_f9;
    assign layer2_col3[35:32] = O1_c9_41_l1_f9;
    
    // GPC10 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f10(
        .clk (clk              ),
        .C0  (C0_c9_41_l1_f10  ),
        .CLA (CLA_c9_41_l1_f10 ),
        .O0  (O0_c9_41_l1_f10  ),
        .O1  (O1_c9_41_l1_f10  ),
        .CY  (CY_c9_41_l1_f10  ),
        .PROP(PROP_c9_41_l1_f10));
    
    assign C0_c9_41_l1_f10 = layer1_col2[85:77];
    
    assign layer2_col2[17]    = O0_c9_41_l1_f10;
    assign layer2_col3[39:36] = O1_c9_41_l1_f10;
    
    // GPC11 in layer1: (9 : 4,1) at column 2
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l1_f11(
        .clk (clk              ),
        .C0  (C0_c9_41_l1_f11  ),
        .CLA (CLA_c9_41_l1_f11 ),
        .O0  (O0_c9_41_l1_f11  ),
        .O1  (O1_c9_41_l1_f11  ),
        .CY  (CY_c9_41_l1_f11  ),
        .PROP(PROP_c9_41_l1_f11));
    
    assign C0_c9_41_l1_f11 = layer1_col2[94:86];
    
    assign layer2_col2[18]    = O0_c9_41_l1_f11;
    assign layer2_col3[43:40] = O1_c9_41_l1_f11;
    
    // GPC12 in layer1: (4,13 : 3,4,1) at column 0
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l1_f12(
        .clk  (clk                  ),
        .C0   (C0_c413_341_l1_f12   ),
        .C1   (C1_c413_341_l1_f12   ),
        .CLA  (CLA_c413_341_l1_f12  ),
        .O0   (O0_c413_341_l1_f12   ),
        .O1   (O1_c413_341_l1_f12   ),
        .O2   (O2_c413_341_l1_f12   ),
        .CY0  (CY0_c413_341_l1_f12  ),
        .PROP0(PROP0_c413_341_l1_f12),
        .CY1  (CY1_c413_341_l1_f12  ),
        .PROP1(PROP1_c413_341_l1_f12));
    
    assign C0_c413_341_l1_f12 = layer1_col0[29:17];
    assign C1_c413_341_l1_f12 = layer1_col1[25:22];
    
    assign layer2_col0[1]     = O0_c413_341_l1_f12;
    assign layer2_col1[9:6]   = O1_c413_341_l1_f12;
    assign layer2_col2[21:19] = O2_c413_341_l1_f12;
    
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

    assign CLA_c413_341_l1_f12[0] = COUT_LA_l1_f12[0];
    assign CLA_c413_341_l1_f12[1] = COUT_LA_l1_f12[2];
    assign CIN_LA_l1_f12          = C0_c413_341_l1_f12[8];
    assign CY_LA_l1_f12[2:0]      = CY0_c413_341_l1_f12;
    assign CY_LA_l1_f12[6:4]      = CY1_c413_341_l1_f12;
    assign PROP_LA_l1_f12[2:0]    = PROP0_c413_341_l1_f12;
    assign PROP_LA_l1_f12[6:4]    = PROP1_c413_341_l1_f12;
    assign PROP_LA_l1_f12[3]      = 1'b0;
    assign CY_LA_l1_f12[3]        = 1'b0;
    
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
    
    assign C0_c517_451_l1_f13 = layer1_col1[42:26];
    assign C1_c517_451_l1_f13 = layer1_col2[99:95];
    
    assign layer2_col1[10]    = O0_c517_451_l1_f13;
    assign layer2_col2[26:22] = O1_c517_451_l1_f13;
    assign layer2_col3[47:44] = O2_c517_451_l1_f13;
    
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
    
    assign C0_c517_451_l1_f14 = layer1_col1[59:43];
    assign C1_c517_451_l1_f14 = layer1_col2[104:100];
    
    assign layer2_col1[11]    = O0_c517_451_l1_f14;
    assign layer2_col2[31:27] = O1_c517_451_l1_f14;
    assign layer2_col3[51:48] = O2_c517_451_l1_f14;
    
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
    
    // GPC15 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l1_f15 = layer1_col1[76:60];
    assign C1_c517_451_l1_f15 = layer1_col2[109:105];
    
    assign layer2_col1[12]    = O0_c517_451_l1_f15;
    assign layer2_col2[36:32] = O1_c517_451_l1_f15;
    assign layer2_col3[55:52] = O2_c517_451_l1_f15;
    
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
    
    // GPC16 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f16(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f16   ),
        .C1   (C1_c517_451_l1_f16   ),
        .CLA  (CLA_c517_451_l1_f16  ),
        .O0   (O0_c517_451_l1_f16   ),
        .O1   (O1_c517_451_l1_f16   ),
        .O2   (O2_c517_451_l1_f16   ),
        .CY0  (CY0_c517_451_l1_f16  ),
        .PROP0(PROP0_c517_451_l1_f16),
        .CY1  (CY1_c517_451_l1_f16  ),
        .PROP1(PROP1_c517_451_l1_f16));
    
    assign C0_c517_451_l1_f16 = layer1_col1[93:77];
    assign C1_c517_451_l1_f16 = layer1_col2[114:110];
    
    assign layer2_col1[13]    = O0_c517_451_l1_f16;
    assign layer2_col2[41:37] = O1_c517_451_l1_f16;
    assign layer2_col3[59:56] = O2_c517_451_l1_f16;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f16_inst0 (
        .COUTB(COUT_LA_l1_f16[0]),
        .COUTD(COUT_LA_l1_f16[1]),
        .COUTF(COUT_LA_l1_f16[2]),
        .COUTH(COUT_LA_l1_f16[3]),
        .CIN  (CIN_LA_l1_f16    ),
        .CYA  (CY_LA_l1_f16[0]  ),
        .CYB  (CY_LA_l1_f16[1]  ),
        .CYC  (CY_LA_l1_f16[2]  ),
        .CYD  (CY_LA_l1_f16[3]  ),
        .CYE  (CY_LA_l1_f16[4]  ),
        .CYF  (CY_LA_l1_f16[5]  ),
        .CYG  (CY_LA_l1_f16[6]  ),
        .CYH  (CY_LA_l1_f16[7]  ),
        .PROPA(PROP_LA_l1_f16[0]),
        .PROPB(PROP_LA_l1_f16[1]),
        .PROPC(PROP_LA_l1_f16[2]),
        .PROPD(PROP_LA_l1_f16[3]),
        .PROPE(PROP_LA_l1_f16[4]),
        .PROPF(PROP_LA_l1_f16[5]),
        .PROPG(PROP_LA_l1_f16[6]),
        .PROPH(PROP_LA_l1_f16[7]));

    assign CLA_c517_451_l1_f16[0] = COUT_LA_l1_f16[0];
    assign CLA_c517_451_l1_f16[1] = COUT_LA_l1_f16[2];
    assign CIN_LA_l1_f16          = C0_c517_451_l1_f16[8];
    assign CY_LA_l1_f16[3:0]      = CY0_c517_451_l1_f16;
    assign CY_LA_l1_f16[7:4]      = CY1_c517_451_l1_f16;
    assign PROP_LA_l1_f16[3:0]    = PROP0_c517_451_l1_f16;
    assign PROP_LA_l1_f16[7:4]    = PROP1_c517_451_l1_f16;
    
    // GPC17 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f17(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f17   ),
        .C1   (C1_c517_451_l1_f17   ),
        .CLA  (CLA_c517_451_l1_f17  ),
        .O0   (O0_c517_451_l1_f17   ),
        .O1   (O1_c517_451_l1_f17   ),
        .O2   (O2_c517_451_l1_f17   ),
        .CY0  (CY0_c517_451_l1_f17  ),
        .PROP0(PROP0_c517_451_l1_f17),
        .CY1  (CY1_c517_451_l1_f17  ),
        .PROP1(PROP1_c517_451_l1_f17));
    
    assign C0_c517_451_l1_f17 = layer1_col1[110:94];
    assign C1_c517_451_l1_f17 = layer1_col2[119:115];
    
    assign layer2_col1[14]    = O0_c517_451_l1_f17;
    assign layer2_col2[46:42] = O1_c517_451_l1_f17;
    assign layer2_col3[63:60] = O2_c517_451_l1_f17;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f17_inst0 (
        .COUTB(COUT_LA_l1_f17[0]),
        .COUTD(COUT_LA_l1_f17[1]),
        .COUTF(COUT_LA_l1_f17[2]),
        .COUTH(COUT_LA_l1_f17[3]),
        .CIN  (CIN_LA_l1_f17    ),
        .CYA  (CY_LA_l1_f17[0]  ),
        .CYB  (CY_LA_l1_f17[1]  ),
        .CYC  (CY_LA_l1_f17[2]  ),
        .CYD  (CY_LA_l1_f17[3]  ),
        .CYE  (CY_LA_l1_f17[4]  ),
        .CYF  (CY_LA_l1_f17[5]  ),
        .CYG  (CY_LA_l1_f17[6]  ),
        .CYH  (CY_LA_l1_f17[7]  ),
        .PROPA(PROP_LA_l1_f17[0]),
        .PROPB(PROP_LA_l1_f17[1]),
        .PROPC(PROP_LA_l1_f17[2]),
        .PROPD(PROP_LA_l1_f17[3]),
        .PROPE(PROP_LA_l1_f17[4]),
        .PROPF(PROP_LA_l1_f17[5]),
        .PROPG(PROP_LA_l1_f17[6]),
        .PROPH(PROP_LA_l1_f17[7]));

    assign CLA_c517_451_l1_f17[0] = COUT_LA_l1_f17[0];
    assign CLA_c517_451_l1_f17[1] = COUT_LA_l1_f17[2];
    assign CIN_LA_l1_f17          = C0_c517_451_l1_f17[8];
    assign CY_LA_l1_f17[3:0]      = CY0_c517_451_l1_f17;
    assign CY_LA_l1_f17[7:4]      = CY1_c517_451_l1_f17;
    assign PROP_LA_l1_f17[3:0]    = PROP0_c517_451_l1_f17;
    assign PROP_LA_l1_f17[7:4]    = PROP1_c517_451_l1_f17;
    
    // GPC18 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f18(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f18   ),
        .C1   (C1_c517_451_l1_f18   ),
        .CLA  (CLA_c517_451_l1_f18  ),
        .O0   (O0_c517_451_l1_f18   ),
        .O1   (O1_c517_451_l1_f18   ),
        .O2   (O2_c517_451_l1_f18   ),
        .CY0  (CY0_c517_451_l1_f18  ),
        .PROP0(PROP0_c517_451_l1_f18),
        .CY1  (CY1_c517_451_l1_f18  ),
        .PROP1(PROP1_c517_451_l1_f18));
    
    assign C0_c517_451_l1_f18 = layer1_col1[127:111];
    assign C1_c517_451_l1_f18 = layer1_col2[124:120];
    
    assign layer2_col1[15]    = O0_c517_451_l1_f18;
    assign layer2_col2[51:47] = O1_c517_451_l1_f18;
    assign layer2_col3[67:64] = O2_c517_451_l1_f18;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f18_inst0 (
        .COUTB(COUT_LA_l1_f18[0]),
        .COUTD(COUT_LA_l1_f18[1]),
        .COUTF(COUT_LA_l1_f18[2]),
        .COUTH(COUT_LA_l1_f18[3]),
        .CIN  (CIN_LA_l1_f18    ),
        .CYA  (CY_LA_l1_f18[0]  ),
        .CYB  (CY_LA_l1_f18[1]  ),
        .CYC  (CY_LA_l1_f18[2]  ),
        .CYD  (CY_LA_l1_f18[3]  ),
        .CYE  (CY_LA_l1_f18[4]  ),
        .CYF  (CY_LA_l1_f18[5]  ),
        .CYG  (CY_LA_l1_f18[6]  ),
        .CYH  (CY_LA_l1_f18[7]  ),
        .PROPA(PROP_LA_l1_f18[0]),
        .PROPB(PROP_LA_l1_f18[1]),
        .PROPC(PROP_LA_l1_f18[2]),
        .PROPD(PROP_LA_l1_f18[3]),
        .PROPE(PROP_LA_l1_f18[4]),
        .PROPF(PROP_LA_l1_f18[5]),
        .PROPG(PROP_LA_l1_f18[6]),
        .PROPH(PROP_LA_l1_f18[7]));

    assign CLA_c517_451_l1_f18[0] = COUT_LA_l1_f18[0];
    assign CLA_c517_451_l1_f18[1] = COUT_LA_l1_f18[2];
    assign CIN_LA_l1_f18          = C0_c517_451_l1_f18[8];
    assign CY_LA_l1_f18[3:0]      = CY0_c517_451_l1_f18;
    assign CY_LA_l1_f18[7:4]      = CY1_c517_451_l1_f18;
    assign PROP_LA_l1_f18[3:0]    = PROP0_c517_451_l1_f18;
    assign PROP_LA_l1_f18[7:4]    = PROP1_c517_451_l1_f18;
    
    // GPC19 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f19(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f19   ),
        .C1   (C1_c517_451_l1_f19   ),
        .CLA  (CLA_c517_451_l1_f19  ),
        .O0   (O0_c517_451_l1_f19   ),
        .O1   (O1_c517_451_l1_f19   ),
        .O2   (O2_c517_451_l1_f19   ),
        .CY0  (CY0_c517_451_l1_f19  ),
        .PROP0(PROP0_c517_451_l1_f19),
        .CY1  (CY1_c517_451_l1_f19  ),
        .PROP1(PROP1_c517_451_l1_f19));
    
    assign C0_c517_451_l1_f19 = layer1_col1[144:128];
    assign C1_c517_451_l1_f19 = layer1_col2[129:125];
    
    assign layer2_col1[16]    = O0_c517_451_l1_f19;
    assign layer2_col2[56:52] = O1_c517_451_l1_f19;
    assign layer2_col3[71:68] = O2_c517_451_l1_f19;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f19_inst0 (
        .COUTB(COUT_LA_l1_f19[0]),
        .COUTD(COUT_LA_l1_f19[1]),
        .COUTF(COUT_LA_l1_f19[2]),
        .COUTH(COUT_LA_l1_f19[3]),
        .CIN  (CIN_LA_l1_f19    ),
        .CYA  (CY_LA_l1_f19[0]  ),
        .CYB  (CY_LA_l1_f19[1]  ),
        .CYC  (CY_LA_l1_f19[2]  ),
        .CYD  (CY_LA_l1_f19[3]  ),
        .CYE  (CY_LA_l1_f19[4]  ),
        .CYF  (CY_LA_l1_f19[5]  ),
        .CYG  (CY_LA_l1_f19[6]  ),
        .CYH  (CY_LA_l1_f19[7]  ),
        .PROPA(PROP_LA_l1_f19[0]),
        .PROPB(PROP_LA_l1_f19[1]),
        .PROPC(PROP_LA_l1_f19[2]),
        .PROPD(PROP_LA_l1_f19[3]),
        .PROPE(PROP_LA_l1_f19[4]),
        .PROPF(PROP_LA_l1_f19[5]),
        .PROPG(PROP_LA_l1_f19[6]),
        .PROPH(PROP_LA_l1_f19[7]));

    assign CLA_c517_451_l1_f19[0] = COUT_LA_l1_f19[0];
    assign CLA_c517_451_l1_f19[1] = COUT_LA_l1_f19[2];
    assign CIN_LA_l1_f19          = C0_c517_451_l1_f19[8];
    assign CY_LA_l1_f19[3:0]      = CY0_c517_451_l1_f19;
    assign CY_LA_l1_f19[7:4]      = CY1_c517_451_l1_f19;
    assign PROP_LA_l1_f19[3:0]    = PROP0_c517_451_l1_f19;
    assign PROP_LA_l1_f19[7:4]    = PROP1_c517_451_l1_f19;
    
    // GPC20 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f20(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f20   ),
        .C1   (C1_c517_451_l1_f20   ),
        .CLA  (CLA_c517_451_l1_f20  ),
        .O0   (O0_c517_451_l1_f20   ),
        .O1   (O1_c517_451_l1_f20   ),
        .O2   (O2_c517_451_l1_f20   ),
        .CY0  (CY0_c517_451_l1_f20  ),
        .PROP0(PROP0_c517_451_l1_f20),
        .CY1  (CY1_c517_451_l1_f20  ),
        .PROP1(PROP1_c517_451_l1_f20));
    
    assign C0_c517_451_l1_f20 = layer1_col1[161:145];
    assign C1_c517_451_l1_f20 = layer1_col2[134:130];
    
    assign layer2_col1[17]    = O0_c517_451_l1_f20;
    assign layer2_col2[61:57] = O1_c517_451_l1_f20;
    assign layer2_col3[75:72] = O2_c517_451_l1_f20;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f20_inst0 (
        .COUTB(COUT_LA_l1_f20[0]),
        .COUTD(COUT_LA_l1_f20[1]),
        .COUTF(COUT_LA_l1_f20[2]),
        .COUTH(COUT_LA_l1_f20[3]),
        .CIN  (CIN_LA_l1_f20    ),
        .CYA  (CY_LA_l1_f20[0]  ),
        .CYB  (CY_LA_l1_f20[1]  ),
        .CYC  (CY_LA_l1_f20[2]  ),
        .CYD  (CY_LA_l1_f20[3]  ),
        .CYE  (CY_LA_l1_f20[4]  ),
        .CYF  (CY_LA_l1_f20[5]  ),
        .CYG  (CY_LA_l1_f20[6]  ),
        .CYH  (CY_LA_l1_f20[7]  ),
        .PROPA(PROP_LA_l1_f20[0]),
        .PROPB(PROP_LA_l1_f20[1]),
        .PROPC(PROP_LA_l1_f20[2]),
        .PROPD(PROP_LA_l1_f20[3]),
        .PROPE(PROP_LA_l1_f20[4]),
        .PROPF(PROP_LA_l1_f20[5]),
        .PROPG(PROP_LA_l1_f20[6]),
        .PROPH(PROP_LA_l1_f20[7]));

    assign CLA_c517_451_l1_f20[0] = COUT_LA_l1_f20[0];
    assign CLA_c517_451_l1_f20[1] = COUT_LA_l1_f20[2];
    assign CIN_LA_l1_f20          = C0_c517_451_l1_f20[8];
    assign CY_LA_l1_f20[3:0]      = CY0_c517_451_l1_f20;
    assign CY_LA_l1_f20[7:4]      = CY1_c517_451_l1_f20;
    assign PROP_LA_l1_f20[3:0]    = PROP0_c517_451_l1_f20;
    assign PROP_LA_l1_f20[7:4]    = PROP1_c517_451_l1_f20;
    
    // GPC21 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f21(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f21   ),
        .C1   (C1_c517_451_l1_f21   ),
        .CLA  (CLA_c517_451_l1_f21  ),
        .O0   (O0_c517_451_l1_f21   ),
        .O1   (O1_c517_451_l1_f21   ),
        .O2   (O2_c517_451_l1_f21   ),
        .CY0  (CY0_c517_451_l1_f21  ),
        .PROP0(PROP0_c517_451_l1_f21),
        .CY1  (CY1_c517_451_l1_f21  ),
        .PROP1(PROP1_c517_451_l1_f21));
    
    assign C0_c517_451_l1_f21 = layer1_col1[178:162];
    assign C1_c517_451_l1_f21 = layer1_col2[139:135];
    
    assign layer2_col1[18]    = O0_c517_451_l1_f21;
    assign layer2_col2[66:62] = O1_c517_451_l1_f21;
    assign layer2_col3[79:76] = O2_c517_451_l1_f21;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f21_inst0 (
        .COUTB(COUT_LA_l1_f21[0]),
        .COUTD(COUT_LA_l1_f21[1]),
        .COUTF(COUT_LA_l1_f21[2]),
        .COUTH(COUT_LA_l1_f21[3]),
        .CIN  (CIN_LA_l1_f21    ),
        .CYA  (CY_LA_l1_f21[0]  ),
        .CYB  (CY_LA_l1_f21[1]  ),
        .CYC  (CY_LA_l1_f21[2]  ),
        .CYD  (CY_LA_l1_f21[3]  ),
        .CYE  (CY_LA_l1_f21[4]  ),
        .CYF  (CY_LA_l1_f21[5]  ),
        .CYG  (CY_LA_l1_f21[6]  ),
        .CYH  (CY_LA_l1_f21[7]  ),
        .PROPA(PROP_LA_l1_f21[0]),
        .PROPB(PROP_LA_l1_f21[1]),
        .PROPC(PROP_LA_l1_f21[2]),
        .PROPD(PROP_LA_l1_f21[3]),
        .PROPE(PROP_LA_l1_f21[4]),
        .PROPF(PROP_LA_l1_f21[5]),
        .PROPG(PROP_LA_l1_f21[6]),
        .PROPH(PROP_LA_l1_f21[7]));

    assign CLA_c517_451_l1_f21[0] = COUT_LA_l1_f21[0];
    assign CLA_c517_451_l1_f21[1] = COUT_LA_l1_f21[2];
    assign CIN_LA_l1_f21          = C0_c517_451_l1_f21[8];
    assign CY_LA_l1_f21[3:0]      = CY0_c517_451_l1_f21;
    assign CY_LA_l1_f21[7:4]      = CY1_c517_451_l1_f21;
    assign PROP_LA_l1_f21[3:0]    = PROP0_c517_451_l1_f21;
    assign PROP_LA_l1_f21[7:4]    = PROP1_c517_451_l1_f21;
    
    // GPC22 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f22(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f22   ),
        .C1   (C1_c517_451_l1_f22   ),
        .CLA  (CLA_c517_451_l1_f22  ),
        .O0   (O0_c517_451_l1_f22   ),
        .O1   (O1_c517_451_l1_f22   ),
        .O2   (O2_c517_451_l1_f22   ),
        .CY0  (CY0_c517_451_l1_f22  ),
        .PROP0(PROP0_c517_451_l1_f22),
        .CY1  (CY1_c517_451_l1_f22  ),
        .PROP1(PROP1_c517_451_l1_f22));
    
    assign C0_c517_451_l1_f22 = layer1_col1[195:179];
    assign C1_c517_451_l1_f22 = layer1_col2[144:140];
    
    assign layer2_col1[19]    = O0_c517_451_l1_f22;
    assign layer2_col2[71:67] = O1_c517_451_l1_f22;
    assign layer2_col3[83:80] = O2_c517_451_l1_f22;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f22_inst0 (
        .COUTB(COUT_LA_l1_f22[0]),
        .COUTD(COUT_LA_l1_f22[1]),
        .COUTF(COUT_LA_l1_f22[2]),
        .COUTH(COUT_LA_l1_f22[3]),
        .CIN  (CIN_LA_l1_f22    ),
        .CYA  (CY_LA_l1_f22[0]  ),
        .CYB  (CY_LA_l1_f22[1]  ),
        .CYC  (CY_LA_l1_f22[2]  ),
        .CYD  (CY_LA_l1_f22[3]  ),
        .CYE  (CY_LA_l1_f22[4]  ),
        .CYF  (CY_LA_l1_f22[5]  ),
        .CYG  (CY_LA_l1_f22[6]  ),
        .CYH  (CY_LA_l1_f22[7]  ),
        .PROPA(PROP_LA_l1_f22[0]),
        .PROPB(PROP_LA_l1_f22[1]),
        .PROPC(PROP_LA_l1_f22[2]),
        .PROPD(PROP_LA_l1_f22[3]),
        .PROPE(PROP_LA_l1_f22[4]),
        .PROPF(PROP_LA_l1_f22[5]),
        .PROPG(PROP_LA_l1_f22[6]),
        .PROPH(PROP_LA_l1_f22[7]));

    assign CLA_c517_451_l1_f22[0] = COUT_LA_l1_f22[0];
    assign CLA_c517_451_l1_f22[1] = COUT_LA_l1_f22[2];
    assign CIN_LA_l1_f22          = C0_c517_451_l1_f22[8];
    assign CY_LA_l1_f22[3:0]      = CY0_c517_451_l1_f22;
    assign CY_LA_l1_f22[7:4]      = CY1_c517_451_l1_f22;
    assign PROP_LA_l1_f22[3:0]    = PROP0_c517_451_l1_f22;
    assign PROP_LA_l1_f22[7:4]    = PROP1_c517_451_l1_f22;
    
    // GPC23 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f23(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f23   ),
        .C1   (C1_c517_451_l1_f23   ),
        .CLA  (CLA_c517_451_l1_f23  ),
        .O0   (O0_c517_451_l1_f23   ),
        .O1   (O1_c517_451_l1_f23   ),
        .O2   (O2_c517_451_l1_f23   ),
        .CY0  (CY0_c517_451_l1_f23  ),
        .PROP0(PROP0_c517_451_l1_f23),
        .CY1  (CY1_c517_451_l1_f23  ),
        .PROP1(PROP1_c517_451_l1_f23));
    
    assign C0_c517_451_l1_f23 = layer1_col1[212:196];
    assign C1_c517_451_l1_f23 = layer1_col2[149:145];
    
    assign layer2_col1[20]    = O0_c517_451_l1_f23;
    assign layer2_col2[76:72] = O1_c517_451_l1_f23;
    assign layer2_col3[87:84] = O2_c517_451_l1_f23;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f23_inst0 (
        .COUTB(COUT_LA_l1_f23[0]),
        .COUTD(COUT_LA_l1_f23[1]),
        .COUTF(COUT_LA_l1_f23[2]),
        .COUTH(COUT_LA_l1_f23[3]),
        .CIN  (CIN_LA_l1_f23    ),
        .CYA  (CY_LA_l1_f23[0]  ),
        .CYB  (CY_LA_l1_f23[1]  ),
        .CYC  (CY_LA_l1_f23[2]  ),
        .CYD  (CY_LA_l1_f23[3]  ),
        .CYE  (CY_LA_l1_f23[4]  ),
        .CYF  (CY_LA_l1_f23[5]  ),
        .CYG  (CY_LA_l1_f23[6]  ),
        .CYH  (CY_LA_l1_f23[7]  ),
        .PROPA(PROP_LA_l1_f23[0]),
        .PROPB(PROP_LA_l1_f23[1]),
        .PROPC(PROP_LA_l1_f23[2]),
        .PROPD(PROP_LA_l1_f23[3]),
        .PROPE(PROP_LA_l1_f23[4]),
        .PROPF(PROP_LA_l1_f23[5]),
        .PROPG(PROP_LA_l1_f23[6]),
        .PROPH(PROP_LA_l1_f23[7]));

    assign CLA_c517_451_l1_f23[0] = COUT_LA_l1_f23[0];
    assign CLA_c517_451_l1_f23[1] = COUT_LA_l1_f23[2];
    assign CIN_LA_l1_f23          = C0_c517_451_l1_f23[8];
    assign CY_LA_l1_f23[3:0]      = CY0_c517_451_l1_f23;
    assign CY_LA_l1_f23[7:4]      = CY1_c517_451_l1_f23;
    assign PROP_LA_l1_f23[3:0]    = PROP0_c517_451_l1_f23;
    assign PROP_LA_l1_f23[7:4]    = PROP1_c517_451_l1_f23;
    
    // GPC24 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f24(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f24   ),
        .C1   (C1_c517_451_l1_f24   ),
        .CLA  (CLA_c517_451_l1_f24  ),
        .O0   (O0_c517_451_l1_f24   ),
        .O1   (O1_c517_451_l1_f24   ),
        .O2   (O2_c517_451_l1_f24   ),
        .CY0  (CY0_c517_451_l1_f24  ),
        .PROP0(PROP0_c517_451_l1_f24),
        .CY1  (CY1_c517_451_l1_f24  ),
        .PROP1(PROP1_c517_451_l1_f24));
    
    assign C0_c517_451_l1_f24 = layer1_col1[229:213];
    assign C1_c517_451_l1_f24 = layer1_col2[154:150];
    
    assign layer2_col1[21]    = O0_c517_451_l1_f24;
    assign layer2_col2[81:77] = O1_c517_451_l1_f24;
    assign layer2_col3[91:88] = O2_c517_451_l1_f24;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f24_inst0 (
        .COUTB(COUT_LA_l1_f24[0]),
        .COUTD(COUT_LA_l1_f24[1]),
        .COUTF(COUT_LA_l1_f24[2]),
        .COUTH(COUT_LA_l1_f24[3]),
        .CIN  (CIN_LA_l1_f24    ),
        .CYA  (CY_LA_l1_f24[0]  ),
        .CYB  (CY_LA_l1_f24[1]  ),
        .CYC  (CY_LA_l1_f24[2]  ),
        .CYD  (CY_LA_l1_f24[3]  ),
        .CYE  (CY_LA_l1_f24[4]  ),
        .CYF  (CY_LA_l1_f24[5]  ),
        .CYG  (CY_LA_l1_f24[6]  ),
        .CYH  (CY_LA_l1_f24[7]  ),
        .PROPA(PROP_LA_l1_f24[0]),
        .PROPB(PROP_LA_l1_f24[1]),
        .PROPC(PROP_LA_l1_f24[2]),
        .PROPD(PROP_LA_l1_f24[3]),
        .PROPE(PROP_LA_l1_f24[4]),
        .PROPF(PROP_LA_l1_f24[5]),
        .PROPG(PROP_LA_l1_f24[6]),
        .PROPH(PROP_LA_l1_f24[7]));

    assign CLA_c517_451_l1_f24[0] = COUT_LA_l1_f24[0];
    assign CLA_c517_451_l1_f24[1] = COUT_LA_l1_f24[2];
    assign CIN_LA_l1_f24          = C0_c517_451_l1_f24[8];
    assign CY_LA_l1_f24[3:0]      = CY0_c517_451_l1_f24;
    assign CY_LA_l1_f24[7:4]      = CY1_c517_451_l1_f24;
    assign PROP_LA_l1_f24[3:0]    = PROP0_c517_451_l1_f24;
    assign PROP_LA_l1_f24[7:4]    = PROP1_c517_451_l1_f24;
    
    // GPC25 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f25(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f25   ),
        .C1   (C1_c517_451_l1_f25   ),
        .CLA  (CLA_c517_451_l1_f25  ),
        .O0   (O0_c517_451_l1_f25   ),
        .O1   (O1_c517_451_l1_f25   ),
        .O2   (O2_c517_451_l1_f25   ),
        .CY0  (CY0_c517_451_l1_f25  ),
        .PROP0(PROP0_c517_451_l1_f25),
        .CY1  (CY1_c517_451_l1_f25  ),
        .PROP1(PROP1_c517_451_l1_f25));
    
    assign C0_c517_451_l1_f25 = layer1_col1[246:230];
    assign C1_c517_451_l1_f25 = layer1_col2[159:155];
    
    assign layer2_col1[22]    = O0_c517_451_l1_f25;
    assign layer2_col2[86:82] = O1_c517_451_l1_f25;
    assign layer2_col3[95:92] = O2_c517_451_l1_f25;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f25_inst0 (
        .COUTB(COUT_LA_l1_f25[0]),
        .COUTD(COUT_LA_l1_f25[1]),
        .COUTF(COUT_LA_l1_f25[2]),
        .COUTH(COUT_LA_l1_f25[3]),
        .CIN  (CIN_LA_l1_f25    ),
        .CYA  (CY_LA_l1_f25[0]  ),
        .CYB  (CY_LA_l1_f25[1]  ),
        .CYC  (CY_LA_l1_f25[2]  ),
        .CYD  (CY_LA_l1_f25[3]  ),
        .CYE  (CY_LA_l1_f25[4]  ),
        .CYF  (CY_LA_l1_f25[5]  ),
        .CYG  (CY_LA_l1_f25[6]  ),
        .CYH  (CY_LA_l1_f25[7]  ),
        .PROPA(PROP_LA_l1_f25[0]),
        .PROPB(PROP_LA_l1_f25[1]),
        .PROPC(PROP_LA_l1_f25[2]),
        .PROPD(PROP_LA_l1_f25[3]),
        .PROPE(PROP_LA_l1_f25[4]),
        .PROPF(PROP_LA_l1_f25[5]),
        .PROPG(PROP_LA_l1_f25[6]),
        .PROPH(PROP_LA_l1_f25[7]));

    assign CLA_c517_451_l1_f25[0] = COUT_LA_l1_f25[0];
    assign CLA_c517_451_l1_f25[1] = COUT_LA_l1_f25[2];
    assign CIN_LA_l1_f25          = C0_c517_451_l1_f25[8];
    assign CY_LA_l1_f25[3:0]      = CY0_c517_451_l1_f25;
    assign CY_LA_l1_f25[7:4]      = CY1_c517_451_l1_f25;
    assign PROP_LA_l1_f25[3:0]    = PROP0_c517_451_l1_f25;
    assign PROP_LA_l1_f25[7:4]    = PROP1_c517_451_l1_f25;
    
    // GPC26 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f26(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f26   ),
        .C1   (C1_c517_451_l1_f26   ),
        .CLA  (CLA_c517_451_l1_f26  ),
        .O0   (O0_c517_451_l1_f26   ),
        .O1   (O1_c517_451_l1_f26   ),
        .O2   (O2_c517_451_l1_f26   ),
        .CY0  (CY0_c517_451_l1_f26  ),
        .PROP0(PROP0_c517_451_l1_f26),
        .CY1  (CY1_c517_451_l1_f26  ),
        .PROP1(PROP1_c517_451_l1_f26));
    
    assign C0_c517_451_l1_f26 = layer1_col1[263:247];
    assign C1_c517_451_l1_f26 = layer1_col2[164:160];
    
    assign layer2_col1[23]    = O0_c517_451_l1_f26;
    assign layer2_col2[91:87] = O1_c517_451_l1_f26;
    assign layer2_col3[99:96] = O2_c517_451_l1_f26;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f26_inst0 (
        .COUTB(COUT_LA_l1_f26[0]),
        .COUTD(COUT_LA_l1_f26[1]),
        .COUTF(COUT_LA_l1_f26[2]),
        .COUTH(COUT_LA_l1_f26[3]),
        .CIN  (CIN_LA_l1_f26    ),
        .CYA  (CY_LA_l1_f26[0]  ),
        .CYB  (CY_LA_l1_f26[1]  ),
        .CYC  (CY_LA_l1_f26[2]  ),
        .CYD  (CY_LA_l1_f26[3]  ),
        .CYE  (CY_LA_l1_f26[4]  ),
        .CYF  (CY_LA_l1_f26[5]  ),
        .CYG  (CY_LA_l1_f26[6]  ),
        .CYH  (CY_LA_l1_f26[7]  ),
        .PROPA(PROP_LA_l1_f26[0]),
        .PROPB(PROP_LA_l1_f26[1]),
        .PROPC(PROP_LA_l1_f26[2]),
        .PROPD(PROP_LA_l1_f26[3]),
        .PROPE(PROP_LA_l1_f26[4]),
        .PROPF(PROP_LA_l1_f26[5]),
        .PROPG(PROP_LA_l1_f26[6]),
        .PROPH(PROP_LA_l1_f26[7]));

    assign CLA_c517_451_l1_f26[0] = COUT_LA_l1_f26[0];
    assign CLA_c517_451_l1_f26[1] = COUT_LA_l1_f26[2];
    assign CIN_LA_l1_f26          = C0_c517_451_l1_f26[8];
    assign CY_LA_l1_f26[3:0]      = CY0_c517_451_l1_f26;
    assign CY_LA_l1_f26[7:4]      = CY1_c517_451_l1_f26;
    assign PROP_LA_l1_f26[3:0]    = PROP0_c517_451_l1_f26;
    assign PROP_LA_l1_f26[7:4]    = PROP1_c517_451_l1_f26;
    
    // GPC27 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f27(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f27   ),
        .C1   (C1_c517_451_l1_f27   ),
        .CLA  (CLA_c517_451_l1_f27  ),
        .O0   (O0_c517_451_l1_f27   ),
        .O1   (O1_c517_451_l1_f27   ),
        .O2   (O2_c517_451_l1_f27   ),
        .CY0  (CY0_c517_451_l1_f27  ),
        .PROP0(PROP0_c517_451_l1_f27),
        .CY1  (CY1_c517_451_l1_f27  ),
        .PROP1(PROP1_c517_451_l1_f27));
    
    assign C0_c517_451_l1_f27 = layer1_col1[280:264];
    assign C1_c517_451_l1_f27 = layer1_col2[169:165];
    
    assign layer2_col1[24]      = O0_c517_451_l1_f27;
    assign layer2_col2[96:92]   = O1_c517_451_l1_f27;
    assign layer2_col3[103:100] = O2_c517_451_l1_f27;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f27_inst0 (
        .COUTB(COUT_LA_l1_f27[0]),
        .COUTD(COUT_LA_l1_f27[1]),
        .COUTF(COUT_LA_l1_f27[2]),
        .COUTH(COUT_LA_l1_f27[3]),
        .CIN  (CIN_LA_l1_f27    ),
        .CYA  (CY_LA_l1_f27[0]  ),
        .CYB  (CY_LA_l1_f27[1]  ),
        .CYC  (CY_LA_l1_f27[2]  ),
        .CYD  (CY_LA_l1_f27[3]  ),
        .CYE  (CY_LA_l1_f27[4]  ),
        .CYF  (CY_LA_l1_f27[5]  ),
        .CYG  (CY_LA_l1_f27[6]  ),
        .CYH  (CY_LA_l1_f27[7]  ),
        .PROPA(PROP_LA_l1_f27[0]),
        .PROPB(PROP_LA_l1_f27[1]),
        .PROPC(PROP_LA_l1_f27[2]),
        .PROPD(PROP_LA_l1_f27[3]),
        .PROPE(PROP_LA_l1_f27[4]),
        .PROPF(PROP_LA_l1_f27[5]),
        .PROPG(PROP_LA_l1_f27[6]),
        .PROPH(PROP_LA_l1_f27[7]));

    assign CLA_c517_451_l1_f27[0] = COUT_LA_l1_f27[0];
    assign CLA_c517_451_l1_f27[1] = COUT_LA_l1_f27[2];
    assign CIN_LA_l1_f27          = C0_c517_451_l1_f27[8];
    assign CY_LA_l1_f27[3:0]      = CY0_c517_451_l1_f27;
    assign CY_LA_l1_f27[7:4]      = CY1_c517_451_l1_f27;
    assign PROP_LA_l1_f27[3:0]    = PROP0_c517_451_l1_f27;
    assign PROP_LA_l1_f27[7:4]    = PROP1_c517_451_l1_f27;
    
    // GPC28 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f28(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f28   ),
        .C1   (C1_c517_451_l1_f28   ),
        .CLA  (CLA_c517_451_l1_f28  ),
        .O0   (O0_c517_451_l1_f28   ),
        .O1   (O1_c517_451_l1_f28   ),
        .O2   (O2_c517_451_l1_f28   ),
        .CY0  (CY0_c517_451_l1_f28  ),
        .PROP0(PROP0_c517_451_l1_f28),
        .CY1  (CY1_c517_451_l1_f28  ),
        .PROP1(PROP1_c517_451_l1_f28));
    
    assign C0_c517_451_l1_f28 = layer1_col1[297:281];
    assign C1_c517_451_l1_f28 = layer1_col2[174:170];
    
    assign layer2_col1[25]      = O0_c517_451_l1_f28;
    assign layer2_col2[101:97]  = O1_c517_451_l1_f28;
    assign layer2_col3[107:104] = O2_c517_451_l1_f28;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f28_inst0 (
        .COUTB(COUT_LA_l1_f28[0]),
        .COUTD(COUT_LA_l1_f28[1]),
        .COUTF(COUT_LA_l1_f28[2]),
        .COUTH(COUT_LA_l1_f28[3]),
        .CIN  (CIN_LA_l1_f28    ),
        .CYA  (CY_LA_l1_f28[0]  ),
        .CYB  (CY_LA_l1_f28[1]  ),
        .CYC  (CY_LA_l1_f28[2]  ),
        .CYD  (CY_LA_l1_f28[3]  ),
        .CYE  (CY_LA_l1_f28[4]  ),
        .CYF  (CY_LA_l1_f28[5]  ),
        .CYG  (CY_LA_l1_f28[6]  ),
        .CYH  (CY_LA_l1_f28[7]  ),
        .PROPA(PROP_LA_l1_f28[0]),
        .PROPB(PROP_LA_l1_f28[1]),
        .PROPC(PROP_LA_l1_f28[2]),
        .PROPD(PROP_LA_l1_f28[3]),
        .PROPE(PROP_LA_l1_f28[4]),
        .PROPF(PROP_LA_l1_f28[5]),
        .PROPG(PROP_LA_l1_f28[6]),
        .PROPH(PROP_LA_l1_f28[7]));

    assign CLA_c517_451_l1_f28[0] = COUT_LA_l1_f28[0];
    assign CLA_c517_451_l1_f28[1] = COUT_LA_l1_f28[2];
    assign CIN_LA_l1_f28          = C0_c517_451_l1_f28[8];
    assign CY_LA_l1_f28[3:0]      = CY0_c517_451_l1_f28;
    assign CY_LA_l1_f28[7:4]      = CY1_c517_451_l1_f28;
    assign PROP_LA_l1_f28[3:0]    = PROP0_c517_451_l1_f28;
    assign PROP_LA_l1_f28[7:4]    = PROP1_c517_451_l1_f28;
    
    // GPC29 in layer1: (5,17 : 4,5,1) at column 1
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l1_f29(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l1_f29   ),
        .C1   (C1_c517_451_l1_f29   ),
        .CLA  (CLA_c517_451_l1_f29  ),
        .O0   (O0_c517_451_l1_f29   ),
        .O1   (O1_c517_451_l1_f29   ),
        .O2   (O2_c517_451_l1_f29   ),
        .CY0  (CY0_c517_451_l1_f29  ),
        .PROP0(PROP0_c517_451_l1_f29),
        .CY1  (CY1_c517_451_l1_f29  ),
        .PROP1(PROP1_c517_451_l1_f29));
    
    assign C0_c517_451_l1_f29 = layer1_col1[314:298];
    assign C1_c517_451_l1_f29 = layer1_col2[179:175];
    
    assign layer2_col1[26]      = O0_c517_451_l1_f29;
    assign layer2_col2[106:102] = O1_c517_451_l1_f29;
    assign layer2_col3[111:108] = O2_c517_451_l1_f29;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_f29_inst0 (
        .COUTB(COUT_LA_l1_f29[0]),
        .COUTD(COUT_LA_l1_f29[1]),
        .COUTF(COUT_LA_l1_f29[2]),
        .COUTH(COUT_LA_l1_f29[3]),
        .CIN  (CIN_LA_l1_f29    ),
        .CYA  (CY_LA_l1_f29[0]  ),
        .CYB  (CY_LA_l1_f29[1]  ),
        .CYC  (CY_LA_l1_f29[2]  ),
        .CYD  (CY_LA_l1_f29[3]  ),
        .CYE  (CY_LA_l1_f29[4]  ),
        .CYF  (CY_LA_l1_f29[5]  ),
        .CYG  (CY_LA_l1_f29[6]  ),
        .CYH  (CY_LA_l1_f29[7]  ),
        .PROPA(PROP_LA_l1_f29[0]),
        .PROPB(PROP_LA_l1_f29[1]),
        .PROPC(PROP_LA_l1_f29[2]),
        .PROPD(PROP_LA_l1_f29[3]),
        .PROPE(PROP_LA_l1_f29[4]),
        .PROPF(PROP_LA_l1_f29[5]),
        .PROPG(PROP_LA_l1_f29[6]),
        .PROPH(PROP_LA_l1_f29[7]));

    assign CLA_c517_451_l1_f29[0] = COUT_LA_l1_f29[0];
    assign CLA_c517_451_l1_f29[1] = COUT_LA_l1_f29[2];
    assign CIN_LA_l1_f29          = C0_c517_451_l1_f29[8];
    assign CY_LA_l1_f29[3:0]      = CY0_c517_451_l1_f29;
    assign CY_LA_l1_f29[7:4]      = CY1_c517_451_l1_f29;
    assign PROP_LA_l1_f29[3:0]    = PROP0_c517_451_l1_f29;
    assign PROP_LA_l1_f29[7:4]    = PROP1_c517_451_l1_f29;
    
    // GPC30 in layer1: (1,5 : 3] at column 1
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l1_f30(
        .clk (clk              ),
        .C0  (C0_c15_3_l1_f30  ),
        .C1  (C1_c15_3_l1_f30  ),
        .CLA (CLA_c15_3_l1_f30 ),
        .O   (O_c15_3_l1_f30   ),
        .CY  (CY_c15_3_l1_f30  ),
        .PROP(PROP_c15_3_l1_f30));
    
    assign C0_c15_3_l1_f30 = layer1_col1[319:315];
    assign C1_c15_3_l1_f30 = layer1_col2[180];
    
    assign layer2_col1[27]  = O_c15_3_l1_f30[0];
    assign layer2_col2[107] = O_c15_3_l1_f30[1];
    assign layer2_col3[112] = O_c15_3_l1_f30[2];
    
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

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_floating_placement_inst2 (
        .COUTB(COUT_LA_l1_floating_placement[8] ),
        .COUTD(COUT_LA_l1_floating_placement[9] ),
        .COUTF(COUT_LA_l1_floating_placement[10]),
        .COUTH(COUT_LA_l1_floating_placement[11]),
        .CIN  (CIN_LA_l1_floating_placement[2]  ),
        .CYA  (CY_LA_l1_floating_placement[16]  ),
        .CYB  (CY_LA_l1_floating_placement[17]  ),
        .CYC  (CY_LA_l1_floating_placement[18]  ),
        .CYD  (CY_LA_l1_floating_placement[19]  ),
        .CYE  (CY_LA_l1_floating_placement[20]  ),
        .CYF  (CY_LA_l1_floating_placement[21]  ),
        .CYG  (CY_LA_l1_floating_placement[22]  ),
        .CYH  (CY_LA_l1_floating_placement[23]  ),
        .PROPA(PROP_LA_l1_floating_placement[16]),
        .PROPB(PROP_LA_l1_floating_placement[17]),
        .PROPC(PROP_LA_l1_floating_placement[18]),
        .PROPD(PROP_LA_l1_floating_placement[19]),
        .PROPE(PROP_LA_l1_floating_placement[20]),
        .PROPF(PROP_LA_l1_floating_placement[21]),
        .PROPG(PROP_LA_l1_floating_placement[22]),
        .PROPH(PROP_LA_l1_floating_placement[23]));

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
    
    assign CY_LA_l1_floating_placement[11:10]   = CY_c9_41_l1_f7;
    assign PROP_LA_l1_floating_placement[11:10] = PROP_c9_41_l1_f7;
    
    assign CY_LA_l1_floating_placement[13:12]   = CY_c9_41_l1_f8;
    assign PROP_LA_l1_floating_placement[13:12] = PROP_c9_41_l1_f8;
    
    assign CY_LA_l1_floating_placement[15:14]   = CY_c9_41_l1_f9;
    assign PROP_LA_l1_floating_placement[15:14] = PROP_c9_41_l1_f9;
    
    assign CY_LA_l1_floating_placement[17:16]   = CY_c9_41_l1_f10;
    assign PROP_LA_l1_floating_placement[17:16] = PROP_c9_41_l1_f10;
    assign CIN_LA_l1_floating_placement[2] = C0_c9_41_l1_f10[8];
    
    assign CY_LA_l1_floating_placement[19:18]   = CY_c9_41_l1_f11;
    assign PROP_LA_l1_floating_placement[19:18] = PROP_c9_41_l1_f11;
    
    assign CY_LA_l1_floating_placement[21:20]   = CY_c15_3_l1_f30;
    assign PROP_LA_l1_floating_placement[21:20] = PROP_c15_3_l1_f30;
    
    assign layer2_col0[2] = layer1_col0[30];
    assign layer2_col0[3] = layer1_col0[31];
    assign layer2_col2[108] = layer1_col2[181];
    assign layer2_col2[109] = layer1_col2[182];
    assign layer2_col2[110] = layer1_col2[183];
    assign layer2_col2[111] = layer1_col2[184];
    assign layer2_col2[112] = layer1_col2[185];
    assign layer2_col2[113] = layer1_col2[186];
    assign layer2_col2[114] = layer1_col2[187];
    assign layer2_col2[115] = layer1_col2[188];
    assign layer2_col2[116] = layer1_col2[189];
    assign layer2_col2[117] = layer1_col2[190];
    assign layer2_col2[118] = layer1_col2[191];
    assign layer2_col2[119] = layer1_col2[192];
    assign layer2_col2[120] = layer1_col2[193];
    assign layer2_col2[121] = layer1_col2[194];
    assign layer2_col2[122] = layer1_col2[195];
    assign layer2_col2[123] = layer1_col2[196];
    assign layer2_col2[124] = layer1_col2[197];
    assign layer2_col2[125] = layer1_col2[198];
    assign layer2_col2[126] = layer1_col2[199];
    assign layer2_col2[127] = layer1_col2[200];
    assign layer2_col2[128] = layer1_col2[201];
    assign layer2_col2[129] = layer1_col2[202];
    assign layer2_col2[130] = layer1_col2[203];
    assign layer2_col2[131] = layer1_col2[204];
    assign layer2_col2[132] = layer1_col2[205];
    assign layer2_col2[133] = layer1_col2[206];
    assign layer2_col2[134] = layer1_col2[207];
    assign layer2_col2[135] = layer1_col2[208];
    assign layer2_col2[136] = layer1_col2[209];
    assign layer2_col2[137] = layer1_col2[210];
    assign layer2_col2[138] = layer1_col2[211];
    assign layer2_col2[139] = layer1_col2[212];
    assign layer2_col2[140] = layer1_col2[213];
    assign layer2_col2[141] = layer1_col2[214];
    assign layer2_col2[142] = layer1_col2[215];
    // ------------------------------ LAYER 2 ------------------------------
    // GPC0 in layer2: (5,17 : 4,5,1) at column 1
    
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
    
    assign C0_c517_451_l2_f0 = layer2_col1[16:0];
    assign C1_c517_451_l2_f0 = layer2_col2[4:0];
    
    assign layer3_col1[0]   = O0_c517_451_l2_f0;
    assign layer3_col2[4:0] = O1_c517_451_l2_f0;
    assign layer3_col3[3:0] = O2_c517_451_l2_f0;
    
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
    
    assign C0_c517_451_l2_f1 = layer2_col2[21:5];
    assign C1_c517_451_l2_f1 = layer2_col3[4:0];
    
    assign layer3_col2[5]   = O0_c517_451_l2_f1;
    assign layer3_col3[8:4] = O1_c517_451_l2_f1;
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
    
    assign layer3_col3[9]   = O0_c9_41_l2_f2;
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
    
    assign layer3_col3[10]   = O0_c9_41_l2_f3;
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
    
    assign layer3_col3[11]    = O0_c9_41_l2_f4;
    assign layer3_col4[15:12] = O1_c9_41_l2_f4;
    
    // GPC5 in layer2: (9 : 4,1) at column 3
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f5(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f5  ),
        .CLA (CLA_c9_41_l2_f5 ),
        .O0  (O0_c9_41_l2_f5  ),
        .O1  (O1_c9_41_l2_f5  ),
        .CY  (CY_c9_41_l2_f5  ),
        .PROP(PROP_c9_41_l2_f5));
    
    assign C0_c9_41_l2_f5 = layer2_col3[40:32];
    
    assign layer3_col3[12]    = O0_c9_41_l2_f5;
    assign layer3_col4[19:16] = O1_c9_41_l2_f5;
    
    // GPC6 in layer2: (9 : 4,1) at column 3
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l2_f6(
        .clk (clk             ),
        .C0  (C0_c9_41_l2_f6  ),
        .CLA (CLA_c9_41_l2_f6 ),
        .O0  (O0_c9_41_l2_f6  ),
        .O1  (O1_c9_41_l2_f6  ),
        .CY  (CY_c9_41_l2_f6  ),
        .PROP(PROP_c9_41_l2_f6));
    
    assign C0_c9_41_l2_f6 = layer2_col3[49:41];
    
    assign layer3_col3[13]    = O0_c9_41_l2_f6;
    assign layer3_col4[23:20] = O1_c9_41_l2_f6;
    
    // GPC7 in layer2: (3,9 : 2,3,1) at column 1
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l2_f7(
        .clk  (clk                ),
        .C0   (C0_c39_231_l2_f7   ),
        .C1   (C1_c39_231_l2_f7   ),
        .CLA  (CLA_c39_231_l2_f7  ),
        .O0   (O0_c39_231_l2_f7   ),
        .O1   (O1_c39_231_l2_f7   ),
        .O2   (O2_c39_231_l2_f7   ),
        .CY0  (CY0_c39_231_l2_f7  ),
        .CY1  (CY1_c39_231_l2_f7  ),
        .PROP0(PROP0_c39_231_l2_f7),
        .PROP1(PROP1_c39_231_l2_f7));
    
    assign C0_c39_231_l2_f7 = layer2_col1[25:17];
    assign C1_c39_231_l2_f7 = layer2_col2[24:22];
    
    assign layer3_col1[1]     = O0_c39_231_l2_f7;
    assign layer3_col2[8:6]   = O1_c39_231_l2_f7;
    assign layer3_col3[15:14] = O2_c39_231_l2_f7;
    
    // GPC8 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f8(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f8   ),
        .C1   (C1_c517_451_l2_f8   ),
        .CLA  (CLA_c517_451_l2_f8  ),
        .O0   (O0_c517_451_l2_f8   ),
        .O1   (O1_c517_451_l2_f8   ),
        .O2   (O2_c517_451_l2_f8   ),
        .CY0  (CY0_c517_451_l2_f8  ),
        .PROP0(PROP0_c517_451_l2_f8),
        .CY1  (CY1_c517_451_l2_f8  ),
        .PROP1(PROP1_c517_451_l2_f8));
    
    assign C0_c517_451_l2_f8 = layer2_col2[41:25];
    assign C1_c517_451_l2_f8 = layer2_col3[54:50];
    
    assign layer3_col2[9]     = O0_c517_451_l2_f8;
    assign layer3_col3[20:16] = O1_c517_451_l2_f8;
    assign layer3_col4[27:24] = O2_c517_451_l2_f8;
    
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

    assign CLA_c517_451_l2_f8[0] = COUT_LA_l2_f8[0];
    assign CLA_c517_451_l2_f8[1] = COUT_LA_l2_f8[2];
    assign CIN_LA_l2_f8          = C0_c517_451_l2_f8[8];
    assign CY_LA_l2_f8[3:0]      = CY0_c517_451_l2_f8;
    assign CY_LA_l2_f8[7:4]      = CY1_c517_451_l2_f8;
    assign PROP_LA_l2_f8[3:0]    = PROP0_c517_451_l2_f8;
    assign PROP_LA_l2_f8[7:4]    = PROP1_c517_451_l2_f8;
    
    // GPC9 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f9(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l2_f9   ),
        .C1   (C1_c517_451_l2_f9   ),
        .CLA  (CLA_c517_451_l2_f9  ),
        .O0   (O0_c517_451_l2_f9   ),
        .O1   (O1_c517_451_l2_f9   ),
        .O2   (O2_c517_451_l2_f9   ),
        .CY0  (CY0_c517_451_l2_f9  ),
        .PROP0(PROP0_c517_451_l2_f9),
        .CY1  (CY1_c517_451_l2_f9  ),
        .PROP1(PROP1_c517_451_l2_f9));
    
    assign C0_c517_451_l2_f9 = layer2_col2[58:42];
    assign C1_c517_451_l2_f9 = layer2_col3[59:55];
    
    assign layer3_col2[10]    = O0_c517_451_l2_f9;
    assign layer3_col3[25:21] = O1_c517_451_l2_f9;
    assign layer3_col4[31:28] = O2_c517_451_l2_f9;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f9_inst0 (
        .COUTB(COUT_LA_l2_f9[0]),
        .COUTD(COUT_LA_l2_f9[1]),
        .COUTF(COUT_LA_l2_f9[2]),
        .COUTH(COUT_LA_l2_f9[3]),
        .CIN  (CIN_LA_l2_f9    ),
        .CYA  (CY_LA_l2_f9[0]  ),
        .CYB  (CY_LA_l2_f9[1]  ),
        .CYC  (CY_LA_l2_f9[2]  ),
        .CYD  (CY_LA_l2_f9[3]  ),
        .CYE  (CY_LA_l2_f9[4]  ),
        .CYF  (CY_LA_l2_f9[5]  ),
        .CYG  (CY_LA_l2_f9[6]  ),
        .CYH  (CY_LA_l2_f9[7]  ),
        .PROPA(PROP_LA_l2_f9[0]),
        .PROPB(PROP_LA_l2_f9[1]),
        .PROPC(PROP_LA_l2_f9[2]),
        .PROPD(PROP_LA_l2_f9[3]),
        .PROPE(PROP_LA_l2_f9[4]),
        .PROPF(PROP_LA_l2_f9[5]),
        .PROPG(PROP_LA_l2_f9[6]),
        .PROPH(PROP_LA_l2_f9[7]));

    assign CLA_c517_451_l2_f9[0] = COUT_LA_l2_f9[0];
    assign CLA_c517_451_l2_f9[1] = COUT_LA_l2_f9[2];
    assign CIN_LA_l2_f9          = C0_c517_451_l2_f9[8];
    assign CY_LA_l2_f9[3:0]      = CY0_c517_451_l2_f9;
    assign CY_LA_l2_f9[7:4]      = CY1_c517_451_l2_f9;
    assign PROP_LA_l2_f9[3:0]    = PROP0_c517_451_l2_f9;
    assign PROP_LA_l2_f9[7:4]    = PROP1_c517_451_l2_f9;
    
    // GPC10 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f10(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l2_f10   ),
        .C1   (C1_c517_451_l2_f10   ),
        .CLA  (CLA_c517_451_l2_f10  ),
        .O0   (O0_c517_451_l2_f10   ),
        .O1   (O1_c517_451_l2_f10   ),
        .O2   (O2_c517_451_l2_f10   ),
        .CY0  (CY0_c517_451_l2_f10  ),
        .PROP0(PROP0_c517_451_l2_f10),
        .CY1  (CY1_c517_451_l2_f10  ),
        .PROP1(PROP1_c517_451_l2_f10));
    
    assign C0_c517_451_l2_f10 = layer2_col2[75:59];
    assign C1_c517_451_l2_f10 = layer2_col3[64:60];
    
    assign layer3_col2[11]    = O0_c517_451_l2_f10;
    assign layer3_col3[30:26] = O1_c517_451_l2_f10;
    assign layer3_col4[35:32] = O2_c517_451_l2_f10;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f10_inst0 (
        .COUTB(COUT_LA_l2_f10[0]),
        .COUTD(COUT_LA_l2_f10[1]),
        .COUTF(COUT_LA_l2_f10[2]),
        .COUTH(COUT_LA_l2_f10[3]),
        .CIN  (CIN_LA_l2_f10    ),
        .CYA  (CY_LA_l2_f10[0]  ),
        .CYB  (CY_LA_l2_f10[1]  ),
        .CYC  (CY_LA_l2_f10[2]  ),
        .CYD  (CY_LA_l2_f10[3]  ),
        .CYE  (CY_LA_l2_f10[4]  ),
        .CYF  (CY_LA_l2_f10[5]  ),
        .CYG  (CY_LA_l2_f10[6]  ),
        .CYH  (CY_LA_l2_f10[7]  ),
        .PROPA(PROP_LA_l2_f10[0]),
        .PROPB(PROP_LA_l2_f10[1]),
        .PROPC(PROP_LA_l2_f10[2]),
        .PROPD(PROP_LA_l2_f10[3]),
        .PROPE(PROP_LA_l2_f10[4]),
        .PROPF(PROP_LA_l2_f10[5]),
        .PROPG(PROP_LA_l2_f10[6]),
        .PROPH(PROP_LA_l2_f10[7]));

    assign CLA_c517_451_l2_f10[0] = COUT_LA_l2_f10[0];
    assign CLA_c517_451_l2_f10[1] = COUT_LA_l2_f10[2];
    assign CIN_LA_l2_f10          = C0_c517_451_l2_f10[8];
    assign CY_LA_l2_f10[3:0]      = CY0_c517_451_l2_f10;
    assign CY_LA_l2_f10[7:4]      = CY1_c517_451_l2_f10;
    assign PROP_LA_l2_f10[3:0]    = PROP0_c517_451_l2_f10;
    assign PROP_LA_l2_f10[7:4]    = PROP1_c517_451_l2_f10;
    
    // GPC11 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f11(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l2_f11   ),
        .C1   (C1_c517_451_l2_f11   ),
        .CLA  (CLA_c517_451_l2_f11  ),
        .O0   (O0_c517_451_l2_f11   ),
        .O1   (O1_c517_451_l2_f11   ),
        .O2   (O2_c517_451_l2_f11   ),
        .CY0  (CY0_c517_451_l2_f11  ),
        .PROP0(PROP0_c517_451_l2_f11),
        .CY1  (CY1_c517_451_l2_f11  ),
        .PROP1(PROP1_c517_451_l2_f11));
    
    assign C0_c517_451_l2_f11 = layer2_col2[92:76];
    assign C1_c517_451_l2_f11 = layer2_col3[69:65];
    
    assign layer3_col2[12]    = O0_c517_451_l2_f11;
    assign layer3_col3[35:31] = O1_c517_451_l2_f11;
    assign layer3_col4[39:36] = O2_c517_451_l2_f11;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f11_inst0 (
        .COUTB(COUT_LA_l2_f11[0]),
        .COUTD(COUT_LA_l2_f11[1]),
        .COUTF(COUT_LA_l2_f11[2]),
        .COUTH(COUT_LA_l2_f11[3]),
        .CIN  (CIN_LA_l2_f11    ),
        .CYA  (CY_LA_l2_f11[0]  ),
        .CYB  (CY_LA_l2_f11[1]  ),
        .CYC  (CY_LA_l2_f11[2]  ),
        .CYD  (CY_LA_l2_f11[3]  ),
        .CYE  (CY_LA_l2_f11[4]  ),
        .CYF  (CY_LA_l2_f11[5]  ),
        .CYG  (CY_LA_l2_f11[6]  ),
        .CYH  (CY_LA_l2_f11[7]  ),
        .PROPA(PROP_LA_l2_f11[0]),
        .PROPB(PROP_LA_l2_f11[1]),
        .PROPC(PROP_LA_l2_f11[2]),
        .PROPD(PROP_LA_l2_f11[3]),
        .PROPE(PROP_LA_l2_f11[4]),
        .PROPF(PROP_LA_l2_f11[5]),
        .PROPG(PROP_LA_l2_f11[6]),
        .PROPH(PROP_LA_l2_f11[7]));

    assign CLA_c517_451_l2_f11[0] = COUT_LA_l2_f11[0];
    assign CLA_c517_451_l2_f11[1] = COUT_LA_l2_f11[2];
    assign CIN_LA_l2_f11          = C0_c517_451_l2_f11[8];
    assign CY_LA_l2_f11[3:0]      = CY0_c517_451_l2_f11;
    assign CY_LA_l2_f11[7:4]      = CY1_c517_451_l2_f11;
    assign PROP_LA_l2_f11[3:0]    = PROP0_c517_451_l2_f11;
    assign PROP_LA_l2_f11[7:4]    = PROP1_c517_451_l2_f11;
    
    // GPC12 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f12(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l2_f12   ),
        .C1   (C1_c517_451_l2_f12   ),
        .CLA  (CLA_c517_451_l2_f12  ),
        .O0   (O0_c517_451_l2_f12   ),
        .O1   (O1_c517_451_l2_f12   ),
        .O2   (O2_c517_451_l2_f12   ),
        .CY0  (CY0_c517_451_l2_f12  ),
        .PROP0(PROP0_c517_451_l2_f12),
        .CY1  (CY1_c517_451_l2_f12  ),
        .PROP1(PROP1_c517_451_l2_f12));
    
    assign C0_c517_451_l2_f12 = layer2_col2[109:93];
    assign C1_c517_451_l2_f12 = layer2_col3[74:70];
    
    assign layer3_col2[13]    = O0_c517_451_l2_f12;
    assign layer3_col3[40:36] = O1_c517_451_l2_f12;
    assign layer3_col4[43:40] = O2_c517_451_l2_f12;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f12_inst0 (
        .COUTB(COUT_LA_l2_f12[0]),
        .COUTD(COUT_LA_l2_f12[1]),
        .COUTF(COUT_LA_l2_f12[2]),
        .COUTH(COUT_LA_l2_f12[3]),
        .CIN  (CIN_LA_l2_f12    ),
        .CYA  (CY_LA_l2_f12[0]  ),
        .CYB  (CY_LA_l2_f12[1]  ),
        .CYC  (CY_LA_l2_f12[2]  ),
        .CYD  (CY_LA_l2_f12[3]  ),
        .CYE  (CY_LA_l2_f12[4]  ),
        .CYF  (CY_LA_l2_f12[5]  ),
        .CYG  (CY_LA_l2_f12[6]  ),
        .CYH  (CY_LA_l2_f12[7]  ),
        .PROPA(PROP_LA_l2_f12[0]),
        .PROPB(PROP_LA_l2_f12[1]),
        .PROPC(PROP_LA_l2_f12[2]),
        .PROPD(PROP_LA_l2_f12[3]),
        .PROPE(PROP_LA_l2_f12[4]),
        .PROPF(PROP_LA_l2_f12[5]),
        .PROPG(PROP_LA_l2_f12[6]),
        .PROPH(PROP_LA_l2_f12[7]));

    assign CLA_c517_451_l2_f12[0] = COUT_LA_l2_f12[0];
    assign CLA_c517_451_l2_f12[1] = COUT_LA_l2_f12[2];
    assign CIN_LA_l2_f12          = C0_c517_451_l2_f12[8];
    assign CY_LA_l2_f12[3:0]      = CY0_c517_451_l2_f12;
    assign CY_LA_l2_f12[7:4]      = CY1_c517_451_l2_f12;
    assign PROP_LA_l2_f12[3:0]    = PROP0_c517_451_l2_f12;
    assign PROP_LA_l2_f12[7:4]    = PROP1_c517_451_l2_f12;
    
    // GPC13 in layer2: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l2_f13(
        .clk  (clk                  ),
        .C0   (C0_c517_451_l2_f13   ),
        .C1   (C1_c517_451_l2_f13   ),
        .CLA  (CLA_c517_451_l2_f13  ),
        .O0   (O0_c517_451_l2_f13   ),
        .O1   (O1_c517_451_l2_f13   ),
        .O2   (O2_c517_451_l2_f13   ),
        .CY0  (CY0_c517_451_l2_f13  ),
        .PROP0(PROP0_c517_451_l2_f13),
        .CY1  (CY1_c517_451_l2_f13  ),
        .PROP1(PROP1_c517_451_l2_f13));
    
    assign C0_c517_451_l2_f13 = layer2_col2[126:110];
    assign C1_c517_451_l2_f13 = layer2_col3[79:75];
    
    assign layer3_col2[14]    = O0_c517_451_l2_f13;
    assign layer3_col3[45:41] = O1_c517_451_l2_f13;
    assign layer3_col4[47:44] = O2_c517_451_l2_f13;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f13_inst0 (
        .COUTB(COUT_LA_l2_f13[0]),
        .COUTD(COUT_LA_l2_f13[1]),
        .COUTF(COUT_LA_l2_f13[2]),
        .COUTH(COUT_LA_l2_f13[3]),
        .CIN  (CIN_LA_l2_f13    ),
        .CYA  (CY_LA_l2_f13[0]  ),
        .CYB  (CY_LA_l2_f13[1]  ),
        .CYC  (CY_LA_l2_f13[2]  ),
        .CYD  (CY_LA_l2_f13[3]  ),
        .CYE  (CY_LA_l2_f13[4]  ),
        .CYF  (CY_LA_l2_f13[5]  ),
        .CYG  (CY_LA_l2_f13[6]  ),
        .CYH  (CY_LA_l2_f13[7]  ),
        .PROPA(PROP_LA_l2_f13[0]),
        .PROPB(PROP_LA_l2_f13[1]),
        .PROPC(PROP_LA_l2_f13[2]),
        .PROPD(PROP_LA_l2_f13[3]),
        .PROPE(PROP_LA_l2_f13[4]),
        .PROPF(PROP_LA_l2_f13[5]),
        .PROPG(PROP_LA_l2_f13[6]),
        .PROPH(PROP_LA_l2_f13[7]));

    assign CLA_c517_451_l2_f13[0] = COUT_LA_l2_f13[0];
    assign CLA_c517_451_l2_f13[1] = COUT_LA_l2_f13[2];
    assign CIN_LA_l2_f13          = C0_c517_451_l2_f13[8];
    assign CY_LA_l2_f13[3:0]      = CY0_c517_451_l2_f13;
    assign CY_LA_l2_f13[7:4]      = CY1_c517_451_l2_f13;
    assign PROP_LA_l2_f13[3:0]    = PROP0_c517_451_l2_f13;
    assign PROP_LA_l2_f13[7:4]    = PROP1_c517_451_l2_f13;
    
    // GPC14 in layer2: (4,13 : 3,4,1) at column 2
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l2_f14(
        .clk  (clk                  ),
        .C0   (C0_c413_341_l2_f14   ),
        .C1   (C1_c413_341_l2_f14   ),
        .CLA  (CLA_c413_341_l2_f14  ),
        .O0   (O0_c413_341_l2_f14   ),
        .O1   (O1_c413_341_l2_f14   ),
        .O2   (O2_c413_341_l2_f14   ),
        .CY0  (CY0_c413_341_l2_f14  ),
        .PROP0(PROP0_c413_341_l2_f14),
        .CY1  (CY1_c413_341_l2_f14  ),
        .PROP1(PROP1_c413_341_l2_f14));
    
    assign C0_c413_341_l2_f14 = layer2_col2[139:127];
    assign C1_c413_341_l2_f14 = layer2_col3[83:80];
    
    assign layer3_col2[15]    = O0_c413_341_l2_f14;
    assign layer3_col3[49:46] = O1_c413_341_l2_f14;
    assign layer3_col4[50:48] = O2_c413_341_l2_f14;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l2_f14_inst0 (
        .COUTB(COUT_LA_l2_f14[0]),
        .COUTD(COUT_LA_l2_f14[1]),
        .COUTF(COUT_LA_l2_f14[2]),
        .COUTH(COUT_LA_l2_f14[3]),
        .CIN  (CIN_LA_l2_f14    ),
        .CYA  (CY_LA_l2_f14[0]  ),
        .CYB  (CY_LA_l2_f14[1]  ),
        .CYC  (CY_LA_l2_f14[2]  ),
        .CYD  (CY_LA_l2_f14[3]  ),
        .CYE  (CY_LA_l2_f14[4]  ),
        .CYF  (CY_LA_l2_f14[5]  ),
        .CYG  (CY_LA_l2_f14[6]  ),
        .CYH  (CY_LA_l2_f14[7]  ),
        .PROPA(PROP_LA_l2_f14[0]),
        .PROPB(PROP_LA_l2_f14[1]),
        .PROPC(PROP_LA_l2_f14[2]),
        .PROPD(PROP_LA_l2_f14[3]),
        .PROPE(PROP_LA_l2_f14[4]),
        .PROPF(PROP_LA_l2_f14[5]),
        .PROPG(PROP_LA_l2_f14[6]),
        .PROPH(PROP_LA_l2_f14[7]));

    assign CLA_c413_341_l2_f14[0] = COUT_LA_l2_f14[0];
    assign CLA_c413_341_l2_f14[1] = COUT_LA_l2_f14[2];
    assign CIN_LA_l2_f14          = C0_c413_341_l2_f14[8];
    assign CY_LA_l2_f14[2:0]      = CY0_c413_341_l2_f14;
    assign CY_LA_l2_f14[6:4]      = CY1_c413_341_l2_f14;
    assign PROP_LA_l2_f14[2:0]    = PROP0_c413_341_l2_f14;
    assign PROP_LA_l2_f14[6:4]    = PROP1_c413_341_l2_f14;
    assign PROP_LA_l2_f14[3]      = 1'b0;
    assign CY_LA_l2_f14[3]        = 1'b0;
    
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
    
    assign CY_LA_l2_floating_placement[7:6]   = CY_c9_41_l2_f5;
    assign PROP_LA_l2_floating_placement[7:6] = PROP_c9_41_l2_f5;
    
    assign CY_LA_l2_floating_placement[9:8]   = CY_c9_41_l2_f6;
    assign PROP_LA_l2_floating_placement[9:8] = PROP_c9_41_l2_f6;
    assign CIN_LA_l2_floating_placement[1] = C0_c9_41_l2_f6[8];
    
    assign CY_LA_l2_floating_placement[11:10]   = CY0_c39_231_l2_f7;
    assign PROP_LA_l2_floating_placement[11:10] = PROP0_c39_231_l2_f7;
    assign CY_LA_l2_floating_placement[13:12]   = CY1_c39_231_l2_f7;
    assign PROP_LA_l2_floating_placement[13:12] = PROP1_c39_231_l2_f7;
    
    assign layer3_col0[0] = layer2_col0[0];
    assign layer3_col0[1] = layer2_col0[1];
    assign layer3_col0[2] = layer2_col0[2];
    assign layer3_col0[3] = layer2_col0[3];
    assign layer3_col1[2] = layer2_col1[26];
    assign layer3_col1[3] = layer2_col1[27];
    assign layer3_col2[16] = layer2_col2[140];
    assign layer3_col2[17] = layer2_col2[141];
    assign layer3_col2[18] = layer2_col2[142];
    assign layer3_col3[50] = layer2_col3[84];
    assign layer3_col3[51] = layer2_col3[85];
    assign layer3_col3[52] = layer2_col3[86];
    assign layer3_col3[53] = layer2_col3[87];
    assign layer3_col3[54] = layer2_col3[88];
    assign layer3_col3[55] = layer2_col3[89];
    assign layer3_col3[56] = layer2_col3[90];
    assign layer3_col3[57] = layer2_col3[91];
    assign layer3_col3[58] = layer2_col3[92];
    assign layer3_col3[59] = layer2_col3[93];
    assign layer3_col3[60] = layer2_col3[94];
    assign layer3_col3[61] = layer2_col3[95];
    assign layer3_col3[62] = layer2_col3[96];
    assign layer3_col3[63] = layer2_col3[97];
    assign layer3_col3[64] = layer2_col3[98];
    assign layer3_col3[65] = layer2_col3[99];
    assign layer3_col3[66] = layer2_col3[100];
    assign layer3_col3[67] = layer2_col3[101];
    assign layer3_col3[68] = layer2_col3[102];
    assign layer3_col3[69] = layer2_col3[103];
    assign layer3_col3[70] = layer2_col3[104];
    assign layer3_col3[71] = layer2_col3[105];
    assign layer3_col3[72] = layer2_col3[106];
    assign layer3_col3[73] = layer2_col3[107];
    assign layer3_col3[74] = layer2_col3[108];
    assign layer3_col3[75] = layer2_col3[109];
    assign layer3_col3[76] = layer2_col3[110];
    assign layer3_col3[77] = layer2_col3[111];
    assign layer3_col3[78] = layer2_col3[112];
    // ------------------------------ LAYER 3 ------------------------------
    // GPC0 in layer3: (5,17 : 4,5,1) at column 2
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l3_f0 = layer3_col2[16:0];
    assign C1_c517_451_l3_f0 = layer3_col3[4:0];
    
    assign layer4_col2[0]   = O0_c517_451_l3_f0;
    assign layer4_col3[4:0] = O1_c517_451_l3_f0;
    assign layer4_col4[3:0] = O2_c517_451_l3_f0;
    
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
    
    // GPC1 in layer3: (5,17 : 4,5,1) at column 3
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l3_f1 = layer3_col3[21:5];
    assign C1_c517_451_l3_f1 = layer3_col4[4:0];
    
    assign layer4_col3[5]   = O0_c517_451_l3_f1;
    assign layer4_col4[8:4] = O1_c517_451_l3_f1;
    assign layer4_col5[3:0] = O2_c517_451_l3_f1;
    
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
    
    // GPC2 in layer3: (9 : 4,1) at column 4
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l3_f2(
        .clk (clk             ),
        .C0  (C0_c9_41_l3_f2  ),
        .CLA (CLA_c9_41_l3_f2 ),
        .O0  (O0_c9_41_l3_f2  ),
        .O1  (O1_c9_41_l3_f2  ),
        .CY  (CY_c9_41_l3_f2  ),
        .PROP(PROP_c9_41_l3_f2));
    
    assign C0_c9_41_l3_f2 = layer3_col4[13:5];
    
    assign layer4_col4[9]   = O0_c9_41_l3_f2;
    assign layer4_col5[7:4] = O1_c9_41_l3_f2;
    
    // GPC3 in layer3: (9 : 4,1) at column 4
    
    c9_41 #(.OUTREG("FALSE"),
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
    
    assign C0_c9_41_l3_f3 = layer3_col4[22:14];
    
    assign layer4_col4[10]   = O0_c9_41_l3_f3;
    assign layer4_col5[11:8] = O1_c9_41_l3_f3;
    
    // GPC4 in layer3: (5,17 : 4,5,1) at column 3
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l3_f4(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l3_f4   ),
        .C1   (C1_c517_451_l3_f4   ),
        .CLA  (CLA_c517_451_l3_f4  ),
        .O0   (O0_c517_451_l3_f4   ),
        .O1   (O1_c517_451_l3_f4   ),
        .O2   (O2_c517_451_l3_f4   ),
        .CY0  (CY0_c517_451_l3_f4  ),
        .PROP0(PROP0_c517_451_l3_f4),
        .CY1  (CY1_c517_451_l3_f4  ),
        .PROP1(PROP1_c517_451_l3_f4));
    
    assign C0_c517_451_l3_f4 = layer3_col3[38:22];
    assign C1_c517_451_l3_f4 = layer3_col4[27:23];
    
    assign layer4_col3[6]     = O0_c517_451_l3_f4;
    assign layer4_col4[15:11] = O1_c517_451_l3_f4;
    assign layer4_col5[15:12] = O2_c517_451_l3_f4;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f4_inst0 (
        .COUTB(COUT_LA_l3_f4[0]),
        .COUTD(COUT_LA_l3_f4[1]),
        .COUTF(COUT_LA_l3_f4[2]),
        .COUTH(COUT_LA_l3_f4[3]),
        .CIN  (CIN_LA_l3_f4    ),
        .CYA  (CY_LA_l3_f4[0]  ),
        .CYB  (CY_LA_l3_f4[1]  ),
        .CYC  (CY_LA_l3_f4[2]  ),
        .CYD  (CY_LA_l3_f4[3]  ),
        .CYE  (CY_LA_l3_f4[4]  ),
        .CYF  (CY_LA_l3_f4[5]  ),
        .CYG  (CY_LA_l3_f4[6]  ),
        .CYH  (CY_LA_l3_f4[7]  ),
        .PROPA(PROP_LA_l3_f4[0]),
        .PROPB(PROP_LA_l3_f4[1]),
        .PROPC(PROP_LA_l3_f4[2]),
        .PROPD(PROP_LA_l3_f4[3]),
        .PROPE(PROP_LA_l3_f4[4]),
        .PROPF(PROP_LA_l3_f4[5]),
        .PROPG(PROP_LA_l3_f4[6]),
        .PROPH(PROP_LA_l3_f4[7]));

    assign CLA_c517_451_l3_f4[0] = COUT_LA_l3_f4[0];
    assign CLA_c517_451_l3_f4[1] = COUT_LA_l3_f4[2];
    assign CIN_LA_l3_f4          = C0_c517_451_l3_f4[8];
    assign CY_LA_l3_f4[3:0]      = CY0_c517_451_l3_f4;
    assign CY_LA_l3_f4[7:4]      = CY1_c517_451_l3_f4;
    assign PROP_LA_l3_f4[3:0]    = PROP0_c517_451_l3_f4;
    assign PROP_LA_l3_f4[7:4]    = PROP1_c517_451_l3_f4;
    
    // GPC5 in layer3: (5,17 : 4,5,1) at column 3
    
    c517_451 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c517_451_l3_f5(
        .clk  (clk                 ),
        .C0   (C0_c517_451_l3_f5   ),
        .C1   (C1_c517_451_l3_f5   ),
        .CLA  (CLA_c517_451_l3_f5  ),
        .O0   (O0_c517_451_l3_f5   ),
        .O1   (O1_c517_451_l3_f5   ),
        .O2   (O2_c517_451_l3_f5   ),
        .CY0  (CY0_c517_451_l3_f5  ),
        .PROP0(PROP0_c517_451_l3_f5),
        .CY1  (CY1_c517_451_l3_f5  ),
        .PROP1(PROP1_c517_451_l3_f5));
    
    assign C0_c517_451_l3_f5 = layer3_col3[55:39];
    assign C1_c517_451_l3_f5 = layer3_col4[32:28];
    
    assign layer4_col3[7]     = O0_c517_451_l3_f5;
    assign layer4_col4[20:16] = O1_c517_451_l3_f5;
    assign layer4_col5[19:16] = O2_c517_451_l3_f5;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l3_f5_inst0 (
        .COUTB(COUT_LA_l3_f5[0]),
        .COUTD(COUT_LA_l3_f5[1]),
        .COUTF(COUT_LA_l3_f5[2]),
        .COUTH(COUT_LA_l3_f5[3]),
        .CIN  (CIN_LA_l3_f5    ),
        .CYA  (CY_LA_l3_f5[0]  ),
        .CYB  (CY_LA_l3_f5[1]  ),
        .CYC  (CY_LA_l3_f5[2]  ),
        .CYD  (CY_LA_l3_f5[3]  ),
        .CYE  (CY_LA_l3_f5[4]  ),
        .CYF  (CY_LA_l3_f5[5]  ),
        .CYG  (CY_LA_l3_f5[6]  ),
        .CYH  (CY_LA_l3_f5[7]  ),
        .PROPA(PROP_LA_l3_f5[0]),
        .PROPB(PROP_LA_l3_f5[1]),
        .PROPC(PROP_LA_l3_f5[2]),
        .PROPD(PROP_LA_l3_f5[3]),
        .PROPE(PROP_LA_l3_f5[4]),
        .PROPF(PROP_LA_l3_f5[5]),
        .PROPG(PROP_LA_l3_f5[6]),
        .PROPH(PROP_LA_l3_f5[7]));

    assign CLA_c517_451_l3_f5[0] = COUT_LA_l3_f5[0];
    assign CLA_c517_451_l3_f5[1] = COUT_LA_l3_f5[2];
    assign CIN_LA_l3_f5          = C0_c517_451_l3_f5[8];
    assign CY_LA_l3_f5[3:0]      = CY0_c517_451_l3_f5;
    assign CY_LA_l3_f5[7:4]      = CY1_c517_451_l3_f5;
    assign PROP_LA_l3_f5[3:0]    = PROP0_c517_451_l3_f5;
    assign PROP_LA_l3_f5[7:4]    = PROP1_c517_451_l3_f5;
    
    // GPC6 in layer3: (5,17 : 4,5,1) at column 3
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l3_f6 = layer3_col3[72:56];
    assign C1_c517_451_l3_f6 = layer3_col4[37:33];
    
    assign layer4_col3[8]     = O0_c517_451_l3_f6;
    assign layer4_col4[25:21] = O1_c517_451_l3_f6;
    assign layer4_col5[23:20] = O2_c517_451_l3_f6;
    
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
    
    // GPC7 in layer3: (1,5 : 3] at column 3
    
    c15_3 #(.OUTREG("FALSE"),
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
    
    assign C0_c15_3_l3_f7 = layer3_col3[77:73];
    assign C1_c15_3_l3_f7 = layer3_col4[38];
    
    assign layer4_col3[9]  = O_c15_3_l3_f7[0];
    assign layer4_col4[26] = O_c15_3_l3_f7[1];
    assign layer4_col5[24] = O_c15_3_l3_f7[2];
    
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

    assign CY_LA_l3_floating_placement[1:0]   = CY_c9_41_l3_f2;
    assign PROP_LA_l3_floating_placement[1:0] = PROP_c9_41_l3_f2;
    assign CIN_LA_l3_floating_placement    = C0_c9_41_l3_f2[8];
    
    assign CY_LA_l3_floating_placement[3:2]   = CY_c9_41_l3_f3;
    assign PROP_LA_l3_floating_placement[3:2] = PROP_c9_41_l3_f3;
    
    assign CY_LA_l3_floating_placement[5:4]   = CY_c15_3_l3_f7;
    assign PROP_LA_l3_floating_placement[5:4] = PROP_c15_3_l3_f7;
    
    assign layer4_col0[0] = layer3_col0[0];
    assign layer4_col0[1] = layer3_col0[1];
    assign layer4_col0[2] = layer3_col0[2];
    assign layer4_col0[3] = layer3_col0[3];
    assign layer4_col1[0] = layer3_col1[0];
    assign layer4_col1[1] = layer3_col1[1];
    assign layer4_col1[2] = layer3_col1[2];
    assign layer4_col1[3] = layer3_col1[3];
    assign layer4_col2[1] = layer3_col2[17];
    assign layer4_col2[2] = layer3_col2[18];
    assign layer4_col3[10] = layer3_col3[78];
    assign layer4_col4[27] = layer3_col4[39];
    assign layer4_col4[28] = layer3_col4[40];
    assign layer4_col4[29] = layer3_col4[41];
    assign layer4_col4[30] = layer3_col4[42];
    assign layer4_col4[31] = layer3_col4[43];
    assign layer4_col4[32] = layer3_col4[44];
    assign layer4_col4[33] = layer3_col4[45];
    assign layer4_col4[34] = layer3_col4[46];
    assign layer4_col4[35] = layer3_col4[47];
    assign layer4_col4[36] = layer3_col4[48];
    assign layer4_col4[37] = layer3_col4[49];
    assign layer4_col4[38] = layer3_col4[50];
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
    
    // GPC0 in layer4: (9 : 4,1) at column 5
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l4_f0(
        .clk (clk             ),
        .C0  (C0_c9_41_l4_f0  ),
        .CLA (CLA_c9_41_l4_f0 ),
        .O0  (O0_c9_41_l4_f0  ),
        .O1  (O1_c9_41_l4_f0  ),
        .CY  (CY_c9_41_l4_f0  ),
        .PROP(PROP_c9_41_l4_f0));
    
    assign C0_c9_41_l4_f0 = layer4_col5[16:8];
    
    assign layer5_col5[1]   = O0_c9_41_l4_f0;
    assign layer5_col6[7:4] = O1_c9_41_l4_f0;
    
    // GPC1 in layer4: (1,5 : 3] at column 3
    
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
    
    assign C0_c15_3_l4_f1 = layer4_col3[9:5];
    assign C1_c15_3_l4_f1 = layer4_col4[1];
    
    assign layer5_col3[1] = O_c15_3_l4_f1[0];
    assign layer5_col4[1] = O_c15_3_l4_f1[1];
    assign layer5_col5[2] = O_c15_3_l4_f1[2];
    
    // GPC2 in layer4: (5,17 : 4,5,1) at column 4
    
    c517_451 #(.OUTREG("FALSE"),
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
    
    assign C0_c517_451_l4_f2 = layer4_col4[18:2];
    assign C1_c517_451_l4_f2 = layer4_col5[21:17];
    
    assign layer5_col4[2]    = O0_c517_451_l4_f2;
    assign layer5_col5[7:3]  = O1_c517_451_l4_f2;
    assign layer5_col6[11:8] = O2_c517_451_l4_f2;
    
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
    
    // GPC3 in layer4: (3,9 : 2,3,1) at column 4
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l4_f3(
        .clk  (clk                ),
        .C0   (C0_c39_231_l4_f3   ),
        .C1   (C1_c39_231_l4_f3   ),
        .CLA  (CLA_c39_231_l4_f3  ),
        .O0   (O0_c39_231_l4_f3   ),
        .O1   (O1_c39_231_l4_f3   ),
        .O2   (O2_c39_231_l4_f3   ),
        .CY0  (CY0_c39_231_l4_f3  ),
        .CY1  (CY1_c39_231_l4_f3  ),
        .PROP0(PROP0_c39_231_l4_f3),
        .PROP1(PROP1_c39_231_l4_f3));
    
    assign C0_c39_231_l4_f3 = layer4_col4[27:19];
    assign C1_c39_231_l4_f3 = layer4_col5[24:22];
    
    assign layer5_col4[3]     = O0_c39_231_l4_f3;
    assign layer5_col5[10:8]  = O1_c39_231_l4_f3;
    assign layer5_col6[13:12] = O2_c39_231_l4_f3;
    
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

    assign CY_LA_l4_floating_placement[1:0]   = CY_c9_41_l4_f0;
    assign PROP_LA_l4_floating_placement[1:0] = PROP_c9_41_l4_f0;
    assign CIN_LA_l4_floating_placement    = C0_c9_41_l4_f0[8];
    
    assign CY_LA_l4_floating_placement[3:2]   = CY_c15_3_l4_f1;
    assign PROP_LA_l4_floating_placement[3:2] = PROP_c15_3_l4_f1;
    
    assign CY_LA_l4_floating_placement[5:4]   = CY0_c39_231_l4_f3;
    assign PROP_LA_l4_floating_placement[5:4] = PROP0_c39_231_l4_f3;
    assign CY_LA_l4_floating_placement[7:6]   = CY1_c39_231_l4_f3;
    assign PROP_LA_l4_floating_placement[7:6] = PROP1_c39_231_l4_f3;
    
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
    assign layer5_col3[2] = layer4_col3[10];
    assign layer5_col4[4] = layer4_col4[28];
    assign layer5_col4[5] = layer4_col4[29];
    assign layer5_col4[6] = layer4_col4[30];
    assign layer5_col4[7] = layer4_col4[31];
    assign layer5_col4[8] = layer4_col4[32];
    assign layer5_col4[9] = layer4_col4[33];
    assign layer5_col4[10] = layer4_col4[34];
    assign layer5_col4[11] = layer4_col4[35];
    assign layer5_col4[12] = layer4_col4[36];
    assign layer5_col4[13] = layer4_col4[37];
    assign layer5_col4[14] = layer4_col4[38];
    // ------------------------------ LAYER 5 ------------------------------
    // GPC chain0 in layer5:
    // -- (3,9 : 2,3,1) at column 4
    // -- (9 : 4,1) at column 6
    
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

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l5_c0_s1_inst0 (
        .COUTB(COUT_LA_l5_c0_s1[0]),
        .COUTD(COUT_LA_l5_c0_s1[1]),
        .COUTF(COUT_LA_l5_c0_s1[2]),
        .COUTH(COUT_LA_l5_c0_s1[3]),
        .CIN  (CIN_LA_l5_c0_s1    ),
        .CYA  (CY_LA_l5_c0_s1[0]  ),
        .CYB  (CY_LA_l5_c0_s1[1]  ),
        .CYC  (CY_LA_l5_c0_s1[2]  ),
        .CYD  (CY_LA_l5_c0_s1[3]  ),
        .CYE  (CY_LA_l5_c0_s1[4]  ),
        .CYF  (CY_LA_l5_c0_s1[5]  ),
        .CYG  (CY_LA_l5_c0_s1[6]  ),
        .CYH  (CY_LA_l5_c0_s1[7]  ),
        .PROPA(PROP_LA_l5_c0_s1[0]),
        .PROPB(PROP_LA_l5_c0_s1[1]),
        .PROPC(PROP_LA_l5_c0_s1[2]),
        .PROPD(PROP_LA_l5_c0_s1[3]),
        .PROPE(PROP_LA_l5_c0_s1[4]),
        .PROPF(PROP_LA_l5_c0_s1[5]),
        .PROPG(PROP_LA_l5_c0_s1[6]),
        .PROPH(PROP_LA_l5_c0_s1[7]));

    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l5_c0_i0(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l5_c0_i0   ),
        .C1   (C1_c39_231_l5_c0_i0   ),
        .CLA  (CLA_c39_231_l5_c0_i0  ),
        .O0   (O0_c39_231_l5_c0_i0   ),
        .O1   (O1_c39_231_l5_c0_i0   ),
        .O2   (O2_c39_231_l5_c0_i0   ),
        .CY0  (CY0_c39_231_l5_c0_i0  ),
        .CY1  (CY1_c39_231_l5_c0_i0  ),
        .PROP0(PROP0_c39_231_l5_c0_i0),
        .PROP1(PROP1_c39_231_l5_c0_i0));
    
    assign C0_c39_231_l5_c0_i0 = layer5_col4[8:0];
    assign C1_c39_231_l5_c0_i0 = layer5_col5[2:0];
    
    assign layer6_col4[0]   = O0_c39_231_l5_c0_i0;
    assign layer6_col5[2:0] = O1_c39_231_l5_c0_i0;
    assign layer6_col6[1]   = O2_c39_231_l5_c0_i0[0];
    
    assign CLA_c39_231_l5_c0_i0  = COUT_LA_l5_c0_s0[0];
    assign l5_c0_i0              = COUT_LA_l5_c0_s1[0];
    assign CY_LA_l5_c0_s0[1:0]   = CY0_c39_231_l5_c0_i0;
    assign PROP_LA_l5_c0_s0[1:0] = PROP0_c39_231_l5_c0_i0;
    assign CY_LA_l5_c0_s1[1:0]   = CY1_c39_231_l5_c0_i0;
    assign PROP_LA_l5_c0_s1[1:0] = PROP1_c39_231_l5_c0_i0;
    assign CIN_LA_l5_c0_s1       = layer5_col5[1];
    
    assign CIN_LA_l5_c0_s0    = C0_c39_231_l5_c0_i0[8];
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l5_c0_i1(
        .clk (clk                ),
        .C0  (C0_c9_41_l5_c0_i1  ),
        .CLA (CLA_c9_41_l5_c0_i1 ),
        .O0  (O0_c9_41_l5_c0_i1  ),
        .O1  (O1_c9_41_l5_c0_i1  ),
        .CY  (CY_c9_41_l5_c0_i1  ),
        .PROP(PROP_c9_41_l5_c0_i1));
    
    assign C0_c9_41_l5_c0_i1 = {l5_c0_i0, layer5_col6[7:0]};
    
    assign layer6_col6[0]   = O0_c9_41_l5_c0_i1;
    assign layer6_col7[3:0] = O1_c9_41_l5_c0_i1;
    
    assign l5_c0_i1              = COUT_LA_l5_c0_s1[1];
    assign CY_LA_l5_c0_s1[3:2]   = CY_c9_41_l5_c0_i1;
    assign PROP_LA_l5_c0_s1[3:2] = PROP_c9_41_l5_c0_i1;
    
    // GPC0 in layer5: (1,5 : 3] at column 4
    
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
    
    assign C0_c15_3_l5_f0 = layer5_col4[13:9];
    assign C1_c15_3_l5_f0 = layer5_col5[3];
    
    assign layer6_col4[1] = O_c15_3_l5_f0[0];
    assign layer6_col5[3] = O_c15_3_l5_f0[1];
    assign layer6_col6[2] = O_c15_3_l5_f0[2];
    
    // GPC1 in layer5: (1,5 : 3] at column 5
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l5_f1(
        .clk (clk             ),
        .C0  (C0_c15_3_l5_f1  ),
        .C1  (C1_c15_3_l5_f1  ),
        .CLA (CLA_c15_3_l5_f1 ),
        .O   (O_c15_3_l5_f1   ),
        .CY  (CY_c15_3_l5_f1  ),
        .PROP(PROP_c15_3_l5_f1));
    
    assign C0_c15_3_l5_f1 = layer5_col5[8:4];
    assign C1_c15_3_l5_f1 = layer5_col6[8];
    
    assign layer6_col5[4] = O_c15_3_l5_f1[0];
    assign layer6_col6[3] = O_c15_3_l5_f1[1];
    assign layer6_col7[4] = O_c15_3_l5_f1[2];
    
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
    
    assign CY_LA_l5_floating_placement[3:2]   = CY_c15_3_l5_f1;
    assign PROP_LA_l5_floating_placement[3:2] = PROP_c15_3_l5_f1;
    
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
    assign layer6_col4[2] = layer5_col4[14];
    assign layer6_col5[5] = layer5_col5[9];
    assign layer6_col5[6] = layer5_col5[10];
    assign layer6_col6[4] = layer5_col6[9];
    assign layer6_col6[5] = layer5_col6[10];
    assign layer6_col6[6] = layer5_col6[11];
    assign layer6_col6[7] = layer5_col6[12];
    assign layer6_col6[8] = layer5_col6[13];
    // ------------------------------ LAYER 6 ------------------------------
    // GPC chain0 in layer6:
    // -- (1,5 : 3] at column 5
    // -- (3 : 2] at column 7
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l6_c0_s0_inst0 (
        .COUTB(COUT_LA_l6_c0_s0[0]),
        .COUTD(COUT_LA_l6_c0_s0[1]),
        .COUTF(COUT_LA_l6_c0_s0[2]),
        .COUTH(COUT_LA_l6_c0_s0[3]),
        .CIN  (CIN_LA_l6_c0_s0    ),
        .CYA  (CY_LA_l6_c0_s0[0]  ),
        .CYB  (CY_LA_l6_c0_s0[1]  ),
        .CYC  (CY_LA_l6_c0_s0[2]  ),
        .CYD  (CY_LA_l6_c0_s0[3]  ),
        .CYE  (CY_LA_l6_c0_s0[4]  ),
        .CYF  (CY_LA_l6_c0_s0[5]  ),
        .CYG  (CY_LA_l6_c0_s0[6]  ),
        .CYH  (CY_LA_l6_c0_s0[7]  ),
        .PROPA(PROP_LA_l6_c0_s0[0]),
        .PROPB(PROP_LA_l6_c0_s0[1]),
        .PROPC(PROP_LA_l6_c0_s0[2]),
        .PROPD(PROP_LA_l6_c0_s0[3]),
        .PROPE(PROP_LA_l6_c0_s0[4]),
        .PROPF(PROP_LA_l6_c0_s0[5]),
        .PROPG(PROP_LA_l6_c0_s0[6]),
        .PROPH(PROP_LA_l6_c0_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l6_c0_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l6_c0_i0  ),
        .C1  (C1_c15_3_l6_c0_i0  ),
        .CLA (CLA_c15_3_l6_c0_i0 ),
        .O   (O_c15_3_l6_c0_i0   ),
        .CY  (CY_c15_3_l6_c0_i0  ),
        .PROP(PROP_c15_3_l6_c0_i0));
    
    assign C0_c15_3_l6_c0_i0 = layer6_col5[4:0];
    assign C1_c15_3_l6_c0_i0 = layer6_col6[0];
    
    assign layer7_col5[0] = O_c15_3_l6_c0_i0[0];
    assign layer7_col6[0] = O_c15_3_l6_c0_i0[1];
    
    assign l6_c0_i0              = COUT_LA_l6_c0_s0[0];
    assign CY_LA_l6_c0_s0[1:0]   = CY_c15_3_l6_c0_i0;
    assign PROP_LA_l6_c0_s0[1:0] = PROP_c15_3_l6_c0_i0;
    
    assign CIN_LA_l6_c0_s0    = C0_c15_3_l6_c0_i0[4];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l6_c0_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l6_c0_i1  ),
        .O   (O_c3_2_l6_c0_i1   ),
        .CY  (CY_c3_2_l6_c0_i1  ),
        .PROP(PROP_c3_2_l6_c0_i1));
    
    assign C0_c3_2_l6_c0_i1 = {l6_c0_i0, layer6_col7[1:0]};
    
    assign layer7_col7[0] = O_c3_2_l6_c0_i1[0];
    assign layer7_col8[0] = O_c3_2_l6_c0_i1[1];
    
    assign l6_c0_i1            = O_c3_2_l6_c0_i1[1];
    assign CY_LA_l6_c0_s0[2]   = CY_c3_2_l6_c0_i1;
    assign PROP_LA_l6_c0_s0[2] = PROP_c3_2_l6_c0_i1;
    
    // GPC0 in layer6: (1,5 : 3] at column 6
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l6_f0(
        .clk (clk             ),
        .C0  (C0_c15_3_l6_f0  ),
        .C1  (C1_c15_3_l6_f0  ),
        .CLA (CLA_c15_3_l6_f0 ),
        .O   (O_c15_3_l6_f0   ),
        .CY  (CY_c15_3_l6_f0  ),
        .PROP(PROP_c15_3_l6_f0));
    
    assign C0_c15_3_l6_f0 = layer6_col6[5:1];
    assign C1_c15_3_l6_f0 = layer6_col7[2];
    
    assign layer7_col6[1] = O_c15_3_l6_f0[0];
    assign layer7_col7[1] = O_c15_3_l6_f0[1];
    assign layer7_col8[1] = O_c15_3_l6_f0[2];
    
    // GPC chain1 in layer6:
    // -- (3 : 2] at column 6
    // -- (3 : 2] at column 7
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l6_c1_s0_inst0 (
        .COUTB(COUT_LA_l6_c1_s0[0]),
        .COUTD(COUT_LA_l6_c1_s0[1]),
        .COUTF(COUT_LA_l6_c1_s0[2]),
        .COUTH(COUT_LA_l6_c1_s0[3]),
        .CIN  (CIN_LA_l6_c1_s0    ),
        .CYA  (CY_LA_l6_c1_s0[0]  ),
        .CYB  (CY_LA_l6_c1_s0[1]  ),
        .CYC  (CY_LA_l6_c1_s0[2]  ),
        .CYD  (CY_LA_l6_c1_s0[3]  ),
        .CYE  (CY_LA_l6_c1_s0[4]  ),
        .CYF  (CY_LA_l6_c1_s0[5]  ),
        .CYG  (CY_LA_l6_c1_s0[6]  ),
        .CYH  (CY_LA_l6_c1_s0[7]  ),
        .PROPA(PROP_LA_l6_c1_s0[0]),
        .PROPB(PROP_LA_l6_c1_s0[1]),
        .PROPC(PROP_LA_l6_c1_s0[2]),
        .PROPD(PROP_LA_l6_c1_s0[3]),
        .PROPE(PROP_LA_l6_c1_s0[4]),
        .PROPF(PROP_LA_l6_c1_s0[5]),
        .PROPG(PROP_LA_l6_c1_s0[6]),
        .PROPH(PROP_LA_l6_c1_s0[7]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l6_c1_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l6_c1_i0  ),
        .O   (O_c3_2_l6_c1_i0   ),
        .CY  (CY_c3_2_l6_c1_i0  ),
        .PROP(PROP_c3_2_l6_c1_i0));
    
    assign C0_c3_2_l6_c1_i0 = layer6_col6[8:6];
    
    assign layer7_col6[2] = O_c3_2_l6_c1_i0[0];
    
    assign l6_c1_i0            = O_c3_2_l6_c1_i0[1];
    assign CY_LA_l6_c1_s0[0]   = CY_c3_2_l6_c1_i0;
    assign PROP_LA_l6_c1_s0[0] = PROP_c3_2_l6_c1_i0;
    
    assign CIN_LA_l6_c1_s0    = C0_c3_2_l6_c1_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("TRUE" ))
    c3_2_l6_c1_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l6_c1_i1  ),
        .O   (O_c3_2_l6_c1_i1   ),
        .CY  (CY_c3_2_l6_c1_i1  ),
        .PROP(PROP_c3_2_l6_c1_i1));
    
    assign C0_c3_2_l6_c1_i1 = {l6_c1_i0, layer6_col7[4:3]};
    
    assign layer7_col7[2] = O_c3_2_l6_c1_i1[0];
    assign layer7_col8[2] = O_c3_2_l6_c1_i1[1];
    
    assign l6_c1_i1            = COUT_LA_l6_c1_s0[0];
    assign CY_LA_l6_c1_s0[1]   = CY_c3_2_l6_c1_i1;
    assign PROP_LA_l6_c1_s0[1] = PROP_c3_2_l6_c1_i1;
    
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

    assign CY_LA_l6_floating_placement[1:0]   = CY_c15_3_l6_f0;
    assign PROP_LA_l6_floating_placement[1:0] = PROP_c15_3_l6_f0;
    assign CIN_LA_l6_floating_placement    = C0_c15_3_l6_f0[4];
    
    assign layer7_col0[0] = layer6_col0[0];
    assign layer7_col0[1] = layer6_col0[1];
    assign layer7_col0[2] = layer6_col0[2];
    assign layer7_col0[3] = layer6_col0[3];
    assign layer7_col1[0] = layer6_col1[0];
    assign layer7_col1[1] = layer6_col1[1];
    assign layer7_col1[2] = layer6_col1[2];
    assign layer7_col1[3] = layer6_col1[3];
    assign layer7_col2[0] = layer6_col2[0];
    assign layer7_col2[1] = layer6_col2[1];
    assign layer7_col2[2] = layer6_col2[2];
    assign layer7_col3[0] = layer6_col3[0];
    assign layer7_col3[1] = layer6_col3[1];
    assign layer7_col3[2] = layer6_col3[2];
    assign layer7_col4[0] = layer6_col4[0];
    assign layer7_col4[1] = layer6_col4[1];
    assign layer7_col4[2] = layer6_col4[2];
    assign layer7_col5[1] = layer6_col5[5];
    assign layer7_col5[2] = layer6_col5[6];
    
    
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
    assign C0_c15_3_terminal_chain1_i0[1] = layer7_col1[0];
    assign C0_c15_3_terminal_chain1_i0[2] = layer7_col1[1];
    assign C0_c15_3_terminal_chain1_i0[3] = layer7_col1[2];
    assign C0_c15_3_terminal_chain1_i0[4] = layer7_col1[3];
    assign C1_c15_3_terminal_chain1_i0    = layer7_col2[0];
    
    assign terminal_chain1_out[0] = O_c15_3_terminal_chain1_i0[0];
    assign terminal_chain1_out[1] = O_c15_3_terminal_chain1_i0[1];
    
    assign terminal_chain1_i0           = COUT_LA_terminal_chain1[0];
    assign CY_LA_terminal_chain1[1:0]   = CY_c15_3_terminal_chain1_i0;
    assign PROP_LA_terminal_chain1[1:0] = PROP_c15_3_terminal_chain1_i0;
    
    assign CIN_LA_terminal_chain1[0] = C0_c15_3_terminal_chain1_i0[4];
    
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
    assign C0_c15_3_terminal_chain1_i1[1] = layer7_col3[0];
    assign C0_c15_3_terminal_chain1_i1[2] = layer7_col3[1];
    assign C0_c15_3_terminal_chain1_i1[3] = layer7_col3[2];
    assign C1_c15_3_terminal_chain1_i1    = layer7_col4[0];
    
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer7_col5[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer7_col5[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer7_col5[2];
    assign C1_c15_3_terminal_chain1_i2    = layer7_col6[0];
    
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
    assign C0_c15_3_terminal_chain1_i3[1] = layer7_col7[0];
    assign C0_c15_3_terminal_chain1_i3[2] = layer7_col7[1];
    assign C0_c15_3_terminal_chain1_i3[3] = layer7_col7[2];
    assign C1_c15_3_terminal_chain1_i3    = layer7_col8[0];
    
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
    assign C0_c15_3_terminal_chain2_i0[4] = layer7_col0[3];
    assign C0_c15_3_terminal_chain2_i0[3] = layer7_col0[2];
    assign C0_c15_3_terminal_chain2_i0[2] = layer7_col0[1];
    assign C0_c15_3_terminal_chain2_i0[1] = layer7_col0[0];
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
    assign C0_c15_3_terminal_chain2_i1[1] = layer7_col2[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer7_col2[2];
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
    assign C0_c15_3_terminal_chain2_i2[1] = layer7_col4[1];
    assign C0_c15_3_terminal_chain2_i2[2] = layer7_col4[2];
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
    assign C0_c15_3_terminal_chain2_i3[1] = layer7_col6[1];
    assign C0_c15_3_terminal_chain2_i3[2] = layer7_col6[2];
    assign C1_c15_3_terminal_chain2_i3    = terminal_chain1_out[6];
    
    assign terminal_chain2_out[6] = O_c15_3_terminal_chain2_i3[0];
    assign terminal_chain2_out[7] = O_c15_3_terminal_chain2_i3[1];
    
    assign terminal_chain2_i3           = COUT_LA_terminal_chain2[3];
    assign CY_LA_terminal_chain2[7:6]   = CY_c15_3_terminal_chain2_i3;
    assign PROP_LA_terminal_chain2[7:6] = PROP_c15_3_terminal_chain2_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_terminal_chain2_i4(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i4  ),
        .C1  (C1_c15_3_terminal_chain2_i4  ),
        .CLA (CLA_c15_3_terminal_chain2_i4 ),
        .O   (O_c15_3_terminal_chain2_i4   ),
        .CY  (CY_c15_3_terminal_chain2_i4  ),
        .PROP(PROP_c15_3_terminal_chain2_i4));
    
    assign C0_c15_3_terminal_chain2_i4[4] = terminal_chain2_i3;
    assign C0_c15_3_terminal_chain2_i4[3] = terminal_chain1_out[7];
    assign C0_c15_3_terminal_chain2_i4[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i4[1] = layer7_col8[1];
    assign C0_c15_3_terminal_chain2_i4[2] = layer7_col8[2];
    assign C1_c15_3_terminal_chain2_i4    = terminal_chain1_out[8];
    
    assign terminal_chain2_out[8]  = O_c15_3_terminal_chain2_i4[0];
    assign terminal_chain2_out[9]  = O_c15_3_terminal_chain2_i4[1];
    assign terminal_chain2_out[10] = O_c15_3_terminal_chain2_i4[2];
    
    assign terminal_chain2_i4           = COUT_LA_terminal_chain2[4];
    assign CY_LA_terminal_chain2[9:8]   = CY_c15_3_terminal_chain2_i4;
    assign PROP_LA_terminal_chain2[9:8] = PROP_c15_3_terminal_chain2_i4;
    
    assign CIN_LA_terminal_chain2[1] = COUT_LA_terminal_chain2[3];
    
    always_ff @(posedge clk) begin
        comp_out[10:0] <= terminal_chain2_out[10:0];
    end
    
    // -------------------------------------- ASSIGNMENT OF MODULE INPUTS AND COMPRESSOR INPUTS --------------------------------------
    assign layer0_col0    = in_col0;
    assign layer0_col1    = in_col1;
    
endmodule