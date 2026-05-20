`timescale 1ns / 1ps

module Bmult30x30_bitheap_cmp (
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
    input  logic [6  : 0] col10,
    input  logic [5  : 0] col11,
    input  logic [7  : 0] col12,
    input  logic [6  : 0] col13,
    input  logic [8  : 0] col14,
    input  logic [7  : 0] col15,
    input  logic [9  : 0] col16,
    input  logic [8  : 0] col17,
    input  logic [10 : 0] col18,
    input  logic [9  : 0] col19,
    input  logic [11 : 0] col20,
    input  logic [10 : 0] col21,
    input  logic [12 : 0] col22,
    input  logic [11 : 0] col23,
    input  logic [13 : 0] col24,
    input  logic [12 : 0] col25,
    input  logic [14 : 0] col26,
    input  logic [13 : 0] col27,
    input  logic [15 : 0] col28,
    input  logic [14 : 0] col29,
    input  logic [15 : 0] col30,
    input  logic [14 : 0] col31,
    input  logic [13 : 0] col32,
    input  logic [13 : 0] col33,
    input  logic [12 : 0] col34,
    input  logic [12 : 0] col35,
    input  logic [11 : 0] col36,
    input  logic [11 : 0] col37,
    input  logic [10 : 0] col38,
    input  logic [10 : 0] col39,
    input  logic [9  : 0] col40,
    input  logic [9  : 0] col41,
    input  logic [8  : 0] col42,
    input  logic [8  : 0] col43,
    input  logic [7  : 0] col44,
    input  logic [7  : 0] col45,
    input  logic [6  : 0] col46,
    input  logic [6  : 0] col47,
    input  logic [5  : 0] col48,
    input  logic [5  : 0] col49,
    input  logic [4  : 0] col50,
    input  logic [4  : 0] col51,
    input  logic [3  : 0] col52,
    input  logic [3  : 0] col53,
    input  logic [2  : 0] col54,
    input  logic [2  : 0] col55,
    input  logic [1  : 0] col56,
    input  logic [1  : 0] col57,
    input  logic          col58,
    input  logic          col59,
    output logic [60 : 0] comp_out
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
    logic [6  : 0] layer0_col10;
    logic [5  : 0] layer0_col11;
    logic [7  : 0] layer0_col12;
    logic [6  : 0] layer0_col13;
    logic [8  : 0] layer0_col14;
    logic [7  : 0] layer0_col15;
    logic [9  : 0] layer0_col16;
    logic [8  : 0] layer0_col17;
    logic [10 : 0] layer0_col18;
    logic [9  : 0] layer0_col19;
    logic [11 : 0] layer0_col20;
    logic [10 : 0] layer0_col21;
    logic [12 : 0] layer0_col22;
    logic [11 : 0] layer0_col23;
    logic [13 : 0] layer0_col24;
    logic [12 : 0] layer0_col25;
    logic [14 : 0] layer0_col26;
    logic [13 : 0] layer0_col27;
    logic [15 : 0] layer0_col28;
    logic [14 : 0] layer0_col29;
    logic [15 : 0] layer0_col30;
    logic [14 : 0] layer0_col31;
    logic [13 : 0] layer0_col32;
    logic [13 : 0] layer0_col33;
    logic [12 : 0] layer0_col34;
    logic [12 : 0] layer0_col35;
    logic [11 : 0] layer0_col36;
    logic [11 : 0] layer0_col37;
    logic [10 : 0] layer0_col38;
    logic [10 : 0] layer0_col39;
    logic [9  : 0] layer0_col40;
    logic [9  : 0] layer0_col41;
    logic [8  : 0] layer0_col42;
    logic [8  : 0] layer0_col43;
    logic [7  : 0] layer0_col44;
    logic [7  : 0] layer0_col45;
    logic [6  : 0] layer0_col46;
    logic [6  : 0] layer0_col47;
    logic [5  : 0] layer0_col48;
    logic [5  : 0] layer0_col49;
    logic [4  : 0] layer0_col50;
    logic [4  : 0] layer0_col51;
    logic [3  : 0] layer0_col52;
    logic [3  : 0] layer0_col53;
    logic [2  : 0] layer0_col54;
    logic [2  : 0] layer0_col55;
    logic [1  : 0] layer0_col56;
    logic [1  : 0] layer0_col57;
    logic          layer0_col58;
    logic          layer0_col59;
    
    logic [7  : 0] COUT_LA_l0_c0_s0;
    logic [1  : 0] CIN_LA_l0_c0_s0;
    logic [15 : 0] CY_LA_l0_c0_s0;
    logic [15 : 0] PROP_LA_l0_c0_s0;
    
    logic [3 : 0] COUT_LA_l0_c0_s1;
    logic         CIN_LA_l0_c0_s1;
    logic [7 : 0] CY_LA_l0_c0_s1;
    logic [7 : 0] PROP_LA_l0_c0_s1;
    
    logic [3 : 0] COUT_LA_l0_c0_s2;
    logic         CIN_LA_l0_c0_s2;
    logic [7 : 0] CY_LA_l0_c0_s2;
    logic [7 : 0] PROP_LA_l0_c0_s2;
    
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
    
    logic [4 : 0] C0_c15_3_l0_c0_i4;
    logic         C1_c15_3_l0_c0_i4;
    logic         CLA_c15_3_l0_c0_i4;
    logic [2 : 0] O_c15_3_l0_c0_i4;
    logic [1 : 0] CY_c15_3_l0_c0_i4;
    logic [1 : 0] PROP_c15_3_l0_c0_i4;
    logic         l0_c0_i4;
    
    logic [4 : 0] C0_c15_3_l0_c0_i5;
    logic         C1_c15_3_l0_c0_i5;
    logic         CLA_c15_3_l0_c0_i5;
    logic [2 : 0] O_c15_3_l0_c0_i5;
    logic [1 : 0] CY_c15_3_l0_c0_i5;
    logic [1 : 0] PROP_c15_3_l0_c0_i5;
    logic         l0_c0_i5;
    
    logic [4 : 0] C0_c15_3_l0_c0_i6;
    logic         C1_c15_3_l0_c0_i6;
    logic         CLA_c15_3_l0_c0_i6;
    logic [2 : 0] O_c15_3_l0_c0_i6;
    logic [1 : 0] CY_c15_3_l0_c0_i6;
    logic [1 : 0] PROP_c15_3_l0_c0_i6;
    logic         l0_c0_i6;
    
    logic [8 : 0] C0_c39_231_l0_c0_i7;
    logic [2 : 0] C1_c39_231_l0_c0_i7;
    logic         CLA_c39_231_l0_c0_i7;
    logic         O0_c39_231_l0_c0_i7;
    logic [2 : 0] O1_c39_231_l0_c0_i7;
    logic [1 : 0] O2_c39_231_l0_c0_i7;
    logic [1 : 0] CY0_c39_231_l0_c0_i7;
    logic [1 : 0] CY1_c39_231_l0_c0_i7;
    logic [1 : 0] PROP0_c39_231_l0_c0_i7;
    logic [1 : 0] PROP1_c39_231_l0_c0_i7;
    logic         l0_c0_i7;
    
    logic [8 : 0] C0_c39_231_l0_c0_i8;
    logic [2 : 0] C1_c39_231_l0_c0_i8;
    logic         CLA_c39_231_l0_c0_i8;
    logic         O0_c39_231_l0_c0_i8;
    logic [2 : 0] O1_c39_231_l0_c0_i8;
    logic [1 : 0] O2_c39_231_l0_c0_i8;
    logic [1 : 0] CY0_c39_231_l0_c0_i8;
    logic [1 : 0] CY1_c39_231_l0_c0_i8;
    logic [1 : 0] PROP0_c39_231_l0_c0_i8;
    logic [1 : 0] PROP1_c39_231_l0_c0_i8;
    logic         l0_c0_i8;
    
    logic [8 : 0] C0_c39_231_l0_c0_i9;
    logic [2 : 0] C1_c39_231_l0_c0_i9;
    logic         CLA_c39_231_l0_c0_i9;
    logic         O0_c39_231_l0_c0_i9;
    logic [2 : 0] O1_c39_231_l0_c0_i9;
    logic [1 : 0] O2_c39_231_l0_c0_i9;
    logic [1 : 0] CY0_c39_231_l0_c0_i9;
    logic [1 : 0] CY1_c39_231_l0_c0_i9;
    logic [1 : 0] PROP0_c39_231_l0_c0_i9;
    logic [1 : 0] PROP1_c39_231_l0_c0_i9;
    logic         l0_c0_i9;
    
    logic [12 : 0] C0_c413_341_l0_f0;
    logic [3  : 0] C1_c413_341_l0_f0;
    logic [1  : 0] CLA_c413_341_l0_f0;
    logic          O0_c413_341_l0_f0;
    logic [3  : 0] O1_c413_341_l0_f0;
    logic [2  : 0] O2_c413_341_l0_f0;
    logic [2  : 0] CY0_c413_341_l0_f0;
    logic [2  : 0] PROP0_c413_341_l0_f0;
    logic [2  : 0] CY1_c413_341_l0_f0;
    logic [2  : 0] PROP1_c413_341_l0_f0;
    
    logic [3 : 0] COUT_LA_l0_f0;
    logic         CIN_LA_l0_f0;
    logic [7 : 0] CY_LA_l0_f0;
    logic [7 : 0] PROP_LA_l0_f0;
    
    logic [8 : 0] C0_c39_231_l0_f1;
    logic [2 : 0] C1_c39_231_l0_f1;
    logic         CLA_c39_231_l0_f1;
    logic         O0_c39_231_l0_f1;
    logic [2 : 0] O1_c39_231_l0_f1;
    logic [1 : 0] O2_c39_231_l0_f1;
    logic [1 : 0] CY0_c39_231_l0_f1;
    logic [1 : 0] CY1_c39_231_l0_f1;
    logic [1 : 0] PROP0_c39_231_l0_f1;
    logic [1 : 0] PROP1_c39_231_l0_f1;
    
    logic [12 : 0] C0_c413_341_l0_f2;
    logic [3  : 0] C1_c413_341_l0_f2;
    logic [1  : 0] CLA_c413_341_l0_f2;
    logic          O0_c413_341_l0_f2;
    logic [3  : 0] O1_c413_341_l0_f2;
    logic [2  : 0] O2_c413_341_l0_f2;
    logic [2  : 0] CY0_c413_341_l0_f2;
    logic [2  : 0] PROP0_c413_341_l0_f2;
    logic [2  : 0] CY1_c413_341_l0_f2;
    logic [2  : 0] PROP1_c413_341_l0_f2;
    
    logic [3 : 0] COUT_LA_l0_f2;
    logic         CIN_LA_l0_f2;
    logic [7 : 0] CY_LA_l0_f2;
    logic [7 : 0] PROP_LA_l0_f2;
    
    logic [8 : 0] C0_c39_231_l0_f3;
    logic [2 : 0] C1_c39_231_l0_f3;
    logic         CLA_c39_231_l0_f3;
    logic         O0_c39_231_l0_f3;
    logic [2 : 0] O1_c39_231_l0_f3;
    logic [1 : 0] O2_c39_231_l0_f3;
    logic [1 : 0] CY0_c39_231_l0_f3;
    logic [1 : 0] CY1_c39_231_l0_f3;
    logic [1 : 0] PROP0_c39_231_l0_f3;
    logic [1 : 0] PROP1_c39_231_l0_f3;
    
    logic [12 : 0] C0_c413_341_l0_f4;
    logic [3  : 0] C1_c413_341_l0_f4;
    logic [1  : 0] CLA_c413_341_l0_f4;
    logic          O0_c413_341_l0_f4;
    logic [3  : 0] O1_c413_341_l0_f4;
    logic [2  : 0] O2_c413_341_l0_f4;
    logic [2  : 0] CY0_c413_341_l0_f4;
    logic [2  : 0] PROP0_c413_341_l0_f4;
    logic [2  : 0] CY1_c413_341_l0_f4;
    logic [2  : 0] PROP1_c413_341_l0_f4;
    
    logic [3 : 0] COUT_LA_l0_f4;
    logic         CIN_LA_l0_f4;
    logic [7 : 0] CY_LA_l0_f4;
    logic [7 : 0] PROP_LA_l0_f4;
    
    logic [8 : 0] C0_c39_231_l0_f5;
    logic [2 : 0] C1_c39_231_l0_f5;
    logic         CLA_c39_231_l0_f5;
    logic         O0_c39_231_l0_f5;
    logic [2 : 0] O1_c39_231_l0_f5;
    logic [1 : 0] O2_c39_231_l0_f5;
    logic [1 : 0] CY0_c39_231_l0_f5;
    logic [1 : 0] CY1_c39_231_l0_f5;
    logic [1 : 0] PROP0_c39_231_l0_f5;
    logic [1 : 0] PROP1_c39_231_l0_f5;
    
    logic [12 : 0] C0_c413_341_l0_f6;
    logic [3  : 0] C1_c413_341_l0_f6;
    logic [1  : 0] CLA_c413_341_l0_f6;
    logic          O0_c413_341_l0_f6;
    logic [3  : 0] O1_c413_341_l0_f6;
    logic [2  : 0] O2_c413_341_l0_f6;
    logic [2  : 0] CY0_c413_341_l0_f6;
    logic [2  : 0] PROP0_c413_341_l0_f6;
    logic [2  : 0] CY1_c413_341_l0_f6;
    logic [2  : 0] PROP1_c413_341_l0_f6;
    
    logic [3 : 0] COUT_LA_l0_f6;
    logic         CIN_LA_l0_f6;
    logic [7 : 0] CY_LA_l0_f6;
    logic [7 : 0] PROP_LA_l0_f6;
    
    logic [3 : 0] COUT_LA_l0_c1_s0;
    logic         CIN_LA_l0_c1_s0;
    logic [7 : 0] CY_LA_l0_c1_s0;
    logic [7 : 0] PROP_LA_l0_c1_s0;
    
    logic [3 : 0] COUT_LA_l0_c1_s1;
    logic         CIN_LA_l0_c1_s1;
    logic [7 : 0] CY_LA_l0_c1_s1;
    logic [7 : 0] PROP_LA_l0_c1_s1;
    
    logic [3 : 0] COUT_LA_l0_c1_s2;
    logic         CIN_LA_l0_c1_s2;
    logic [7 : 0] CY_LA_l0_c1_s2;
    logic [7 : 0] PROP_LA_l0_c1_s2;
    
    logic [3 : 0] COUT_LA_l0_c1_s3;
    logic         CIN_LA_l0_c1_s3;
    logic [7 : 0] CY_LA_l0_c1_s3;
    logic [7 : 0] PROP_LA_l0_c1_s3;
    
    logic [3 : 0] COUT_LA_l0_c1_s4;
    logic         CIN_LA_l0_c1_s4;
    logic [7 : 0] CY_LA_l0_c1_s4;
    logic [7 : 0] PROP_LA_l0_c1_s4;
    
    logic [8 : 0] C0_c39_231_l0_c1_i0;
    logic [2 : 0] C1_c39_231_l0_c1_i0;
    logic         CLA_c39_231_l0_c1_i0;
    logic         O0_c39_231_l0_c1_i0;
    logic [2 : 0] O1_c39_231_l0_c1_i0;
    logic [1 : 0] O2_c39_231_l0_c1_i0;
    logic [1 : 0] CY0_c39_231_l0_c1_i0;
    logic [1 : 0] CY1_c39_231_l0_c1_i0;
    logic [1 : 0] PROP0_c39_231_l0_c1_i0;
    logic [1 : 0] PROP1_c39_231_l0_c1_i0;
    logic         l0_c1_i0;
    
    logic [8 : 0] C0_c39_231_l0_c1_i1;
    logic [2 : 0] C1_c39_231_l0_c1_i1;
    logic         CLA_c39_231_l0_c1_i1;
    logic         O0_c39_231_l0_c1_i1;
    logic [2 : 0] O1_c39_231_l0_c1_i1;
    logic [1 : 0] O2_c39_231_l0_c1_i1;
    logic [1 : 0] CY0_c39_231_l0_c1_i1;
    logic [1 : 0] CY1_c39_231_l0_c1_i1;
    logic [1 : 0] PROP0_c39_231_l0_c1_i1;
    logic [1 : 0] PROP1_c39_231_l0_c1_i1;
    logic         l0_c1_i1;
    
    logic [8 : 0] C0_c39_231_l0_c1_i2;
    logic [2 : 0] C1_c39_231_l0_c1_i2;
    logic         CLA_c39_231_l0_c1_i2;
    logic         O0_c39_231_l0_c1_i2;
    logic [2 : 0] O1_c39_231_l0_c1_i2;
    logic [1 : 0] O2_c39_231_l0_c1_i2;
    logic [1 : 0] CY0_c39_231_l0_c1_i2;
    logic [1 : 0] CY1_c39_231_l0_c1_i2;
    logic [1 : 0] PROP0_c39_231_l0_c1_i2;
    logic [1 : 0] PROP1_c39_231_l0_c1_i2;
    logic         l0_c1_i2;
    
    logic [8 : 0] C0_c39_231_l0_c1_i3;
    logic [2 : 0] C1_c39_231_l0_c1_i3;
    logic         CLA_c39_231_l0_c1_i3;
    logic         O0_c39_231_l0_c1_i3;
    logic [2 : 0] O1_c39_231_l0_c1_i3;
    logic [1 : 0] O2_c39_231_l0_c1_i3;
    logic [1 : 0] CY0_c39_231_l0_c1_i3;
    logic [1 : 0] CY1_c39_231_l0_c1_i3;
    logic [1 : 0] PROP0_c39_231_l0_c1_i3;
    logic [1 : 0] PROP1_c39_231_l0_c1_i3;
    logic         l0_c1_i3;
    
    logic [4 : 0] C0_c15_3_l0_c1_i4;
    logic         C1_c15_3_l0_c1_i4;
    logic         CLA_c15_3_l0_c1_i4;
    logic [2 : 0] O_c15_3_l0_c1_i4;
    logic [1 : 0] CY_c15_3_l0_c1_i4;
    logic [1 : 0] PROP_c15_3_l0_c1_i4;
    logic         l0_c1_i4;
    
    logic [4 : 0] C0_c15_3_l0_c1_i5;
    logic         C1_c15_3_l0_c1_i5;
    logic         CLA_c15_3_l0_c1_i5;
    logic [2 : 0] O_c15_3_l0_c1_i5;
    logic [1 : 0] CY_c15_3_l0_c1_i5;
    logic [1 : 0] PROP_c15_3_l0_c1_i5;
    logic         l0_c1_i5;
    
    logic [4 : 0] C0_c15_3_l0_c1_i6;
    logic         C1_c15_3_l0_c1_i6;
    logic         CLA_c15_3_l0_c1_i6;
    logic [2 : 0] O_c15_3_l0_c1_i6;
    logic [1 : 0] CY_c15_3_l0_c1_i6;
    logic [1 : 0] PROP_c15_3_l0_c1_i6;
    logic         l0_c1_i6;
    
    logic [3 : 0] COUT_LA_l0_c2_s0;
    logic         CIN_LA_l0_c2_s0;
    logic [7 : 0] CY_LA_l0_c2_s0;
    logic [7 : 0] PROP_LA_l0_c2_s0;
    
    logic [4 : 0] C0_c15_3_l0_c2_i0;
    logic         C1_c15_3_l0_c2_i0;
    logic         CLA_c15_3_l0_c2_i0;
    logic [2 : 0] O_c15_3_l0_c2_i0;
    logic [1 : 0] CY_c15_3_l0_c2_i0;
    logic [1 : 0] PROP_c15_3_l0_c2_i0;
    logic         l0_c2_i0;
    
    logic [2 : 0] C0_c3_2_l0_c2_i1;
    logic [1 : 0] O_c3_2_l0_c2_i1;
    logic         CY_c3_2_l0_c2_i1;
    logic         PROP_c3_2_l0_c2_i1;
    logic         l0_c2_i1;
    
    logic [2 : 0] C0_c3_2_l0_c2_i2;
    logic [1 : 0] O_c3_2_l0_c2_i2;
    logic         CY_c3_2_l0_c2_i2;
    logic         PROP_c3_2_l0_c2_i2;
    logic         l0_c2_i2;
    
    logic [2 : 0] C0_c3_2_l0_c2_i3;
    logic [1 : 0] O_c3_2_l0_c2_i3;
    logic         CY_c3_2_l0_c2_i3;
    logic         PROP_c3_2_l0_c2_i3;
    logic         l0_c2_i3;
    
    logic [2 : 0] C0_c3_2_l0_c2_i4;
    logic [1 : 0] O_c3_2_l0_c2_i4;
    logic         CY_c3_2_l0_c2_i4;
    logic         PROP_c3_2_l0_c2_i4;
    logic         l0_c2_i4;
    
    logic [7  : 0] COUT_LA_l0_c3_s0;
    logic [1  : 0] CIN_LA_l0_c3_s0;
    logic [15 : 0] CY_LA_l0_c3_s0;
    logic [15 : 0] PROP_LA_l0_c3_s0;
    
    logic [3 : 0] COUT_LA_l0_c3_s1;
    logic         CIN_LA_l0_c3_s1;
    logic [7 : 0] CY_LA_l0_c3_s1;
    logic [7 : 0] PROP_LA_l0_c3_s1;
    
    logic [2 : 0] C0_c3_2_l0_c3_i0;
    logic [1 : 0] O_c3_2_l0_c3_i0;
    logic         CY_c3_2_l0_c3_i0;
    logic         PROP_c3_2_l0_c3_i0;
    logic         l0_c3_i0;
    
    logic [2 : 0] C0_c3_2_l0_c3_i1;
    logic [1 : 0] O_c3_2_l0_c3_i1;
    logic         CY_c3_2_l0_c3_i1;
    logic         PROP_c3_2_l0_c3_i1;
    logic         l0_c3_i1;
    
    logic [4 : 0] C0_c15_3_l0_c3_i2;
    logic         C1_c15_3_l0_c3_i2;
    logic         CLA_c15_3_l0_c3_i2;
    logic [2 : 0] O_c15_3_l0_c3_i2;
    logic [1 : 0] CY_c15_3_l0_c3_i2;
    logic [1 : 0] PROP_c15_3_l0_c3_i2;
    logic         l0_c3_i2;
    
    logic [4 : 0] C0_c15_3_l0_c3_i3;
    logic         C1_c15_3_l0_c3_i3;
    logic         CLA_c15_3_l0_c3_i3;
    logic [2 : 0] O_c15_3_l0_c3_i3;
    logic [1 : 0] CY_c15_3_l0_c3_i3;
    logic [1 : 0] PROP_c15_3_l0_c3_i3;
    logic         l0_c3_i3;
    
    logic [4 : 0] C0_c15_3_l0_c3_i4;
    logic         C1_c15_3_l0_c3_i4;
    logic         CLA_c15_3_l0_c3_i4;
    logic [2 : 0] O_c15_3_l0_c3_i4;
    logic [1 : 0] CY_c15_3_l0_c3_i4;
    logic [1 : 0] PROP_c15_3_l0_c3_i4;
    logic         l0_c3_i4;
    
    logic [4 : 0] C0_c15_3_l0_c3_i5;
    logic         C1_c15_3_l0_c3_i5;
    logic         CLA_c15_3_l0_c3_i5;
    logic [2 : 0] O_c15_3_l0_c3_i5;
    logic [1 : 0] CY_c15_3_l0_c3_i5;
    logic [1 : 0] PROP_c15_3_l0_c3_i5;
    logic         l0_c3_i5;
    
    logic [4 : 0] C0_c15_3_l0_c3_i6;
    logic         C1_c15_3_l0_c3_i6;
    logic         CLA_c15_3_l0_c3_i6;
    logic [2 : 0] O_c15_3_l0_c3_i6;
    logic [1 : 0] CY_c15_3_l0_c3_i6;
    logic [1 : 0] PROP_c15_3_l0_c3_i6;
    logic         l0_c3_i6;
    
    logic [8 : 0] C0_c39_231_l0_c3_i7;
    logic [2 : 0] C1_c39_231_l0_c3_i7;
    logic         CLA_c39_231_l0_c3_i7;
    logic         O0_c39_231_l0_c3_i7;
    logic [2 : 0] O1_c39_231_l0_c3_i7;
    logic [1 : 0] O2_c39_231_l0_c3_i7;
    logic [1 : 0] CY0_c39_231_l0_c3_i7;
    logic [1 : 0] CY1_c39_231_l0_c3_i7;
    logic [1 : 0] PROP0_c39_231_l0_c3_i7;
    logic [1 : 0] PROP1_c39_231_l0_c3_i7;
    logic         l0_c3_i7;
    
    logic [8 : 0] C0_c9_41_l0_c3_i8;
    logic         CLA_c9_41_l0_c3_i8;
    logic         O0_c9_41_l0_c3_i8;
    logic [3 : 0] O1_c9_41_l0_c3_i8;
    logic [1 : 0] CY_c9_41_l0_c3_i8;
    logic [1 : 0] PROP_c9_41_l0_c3_i8;
    logic         l0_c3_i8;
    
    logic [8 : 0] C0_c9_41_l0_f7;
    logic         CLA_c9_41_l0_f7;
    logic         O0_c9_41_l0_f7;
    logic [3 : 0] O1_c9_41_l0_f7;
    logic [1 : 0] CY_c9_41_l0_f7;
    logic [1 : 0] PROP_c9_41_l0_f7;
    
    logic [8 : 0] C0_c39_231_l0_f8;
    logic [2 : 0] C1_c39_231_l0_f8;
    logic         CLA_c39_231_l0_f8;
    logic         O0_c39_231_l0_f8;
    logic [2 : 0] O1_c39_231_l0_f8;
    logic [1 : 0] O2_c39_231_l0_f8;
    logic [1 : 0] CY0_c39_231_l0_f8;
    logic [1 : 0] CY1_c39_231_l0_f8;
    logic [1 : 0] PROP0_c39_231_l0_f8;
    logic [1 : 0] PROP1_c39_231_l0_f8;
    
    logic [8 : 0] C0_c9_41_l0_f9;
    logic         CLA_c9_41_l0_f9;
    logic         O0_c9_41_l0_f9;
    logic [3 : 0] O1_c9_41_l0_f9;
    logic [1 : 0] CY_c9_41_l0_f9;
    logic [1 : 0] PROP_c9_41_l0_f9;
    
    logic [3 : 0] COUT_LA_l0_c4_s0;
    logic         CIN_LA_l0_c4_s0;
    logic [7 : 0] CY_LA_l0_c4_s0;
    logic [7 : 0] PROP_LA_l0_c4_s0;
    
    logic [3 : 0] COUT_LA_l0_c4_s1;
    logic         CIN_LA_l0_c4_s1;
    logic [7 : 0] CY_LA_l0_c4_s1;
    logic [7 : 0] PROP_LA_l0_c4_s1;
    
    logic [3 : 0] COUT_LA_l0_c4_s2;
    logic         CIN_LA_l0_c4_s2;
    logic [7 : 0] CY_LA_l0_c4_s2;
    logic [7 : 0] PROP_LA_l0_c4_s2;
    
    logic [8 : 0] C0_c39_231_l0_c4_i0;
    logic [2 : 0] C1_c39_231_l0_c4_i0;
    logic         CLA_c39_231_l0_c4_i0;
    logic         O0_c39_231_l0_c4_i0;
    logic [2 : 0] O1_c39_231_l0_c4_i0;
    logic [1 : 0] O2_c39_231_l0_c4_i0;
    logic [1 : 0] CY0_c39_231_l0_c4_i0;
    logic [1 : 0] CY1_c39_231_l0_c4_i0;
    logic [1 : 0] PROP0_c39_231_l0_c4_i0;
    logic [1 : 0] PROP1_c39_231_l0_c4_i0;
    logic         l0_c4_i0;
    
    logic [8 : 0] C0_c39_231_l0_c4_i1;
    logic [2 : 0] C1_c39_231_l0_c4_i1;
    logic         CLA_c39_231_l0_c4_i1;
    logic         O0_c39_231_l0_c4_i1;
    logic [2 : 0] O1_c39_231_l0_c4_i1;
    logic [1 : 0] O2_c39_231_l0_c4_i1;
    logic [1 : 0] CY0_c39_231_l0_c4_i1;
    logic [1 : 0] CY1_c39_231_l0_c4_i1;
    logic [1 : 0] PROP0_c39_231_l0_c4_i1;
    logic [1 : 0] PROP1_c39_231_l0_c4_i1;
    logic         l0_c4_i1;
    
    logic [4 : 0] C0_c15_3_l0_c4_i2;
    logic         C1_c15_3_l0_c4_i2;
    logic         CLA_c15_3_l0_c4_i2;
    logic [2 : 0] O_c15_3_l0_c4_i2;
    logic [1 : 0] CY_c15_3_l0_c4_i2;
    logic [1 : 0] PROP_c15_3_l0_c4_i2;
    logic         l0_c4_i2;
    
    logic [4 : 0] C0_c15_3_l0_c4_i3;
    logic         C1_c15_3_l0_c4_i3;
    logic         CLA_c15_3_l0_c4_i3;
    logic [2 : 0] O_c15_3_l0_c4_i3;
    logic [1 : 0] CY_c15_3_l0_c4_i3;
    logic [1 : 0] PROP_c15_3_l0_c4_i3;
    logic         l0_c4_i3;
    
    logic [4 : 0] C0_c15_3_l0_c4_i4;
    logic         C1_c15_3_l0_c4_i4;
    logic         CLA_c15_3_l0_c4_i4;
    logic [2 : 0] O_c15_3_l0_c4_i4;
    logic [1 : 0] CY_c15_3_l0_c4_i4;
    logic [1 : 0] PROP_c15_3_l0_c4_i4;
    logic         l0_c4_i4;
    
    logic [3 : 0] COUT_LA_l0_c5_s0;
    logic         CIN_LA_l0_c5_s0;
    logic [7 : 0] CY_LA_l0_c5_s0;
    logic [7 : 0] PROP_LA_l0_c5_s0;
    
    logic [4 : 0] C0_c15_3_l0_c5_i0;
    logic         C1_c15_3_l0_c5_i0;
    logic         CLA_c15_3_l0_c5_i0;
    logic [2 : 0] O_c15_3_l0_c5_i0;
    logic [1 : 0] CY_c15_3_l0_c5_i0;
    logic [1 : 0] PROP_c15_3_l0_c5_i0;
    logic         l0_c5_i0;
    
    logic [4 : 0] C0_c15_3_l0_c5_i1;
    logic         C1_c15_3_l0_c5_i1;
    logic         CLA_c15_3_l0_c5_i1;
    logic [2 : 0] O_c15_3_l0_c5_i1;
    logic [1 : 0] CY_c15_3_l0_c5_i1;
    logic [1 : 0] PROP_c15_3_l0_c5_i1;
    logic         l0_c5_i1;
    
    logic [4 : 0] C0_c15_3_l0_c5_i2;
    logic         C1_c15_3_l0_c5_i2;
    logic         CLA_c15_3_l0_c5_i2;
    logic [2 : 0] O_c15_3_l0_c5_i2;
    logic [1 : 0] CY_c15_3_l0_c5_i2;
    logic [1 : 0] PROP_c15_3_l0_c5_i2;
    logic         l0_c5_i2;
    
    logic [2 : 0] C0_c3_2_l0_c5_i3;
    logic [1 : 0] O_c3_2_l0_c5_i3;
    logic         CY_c3_2_l0_c5_i3;
    logic         PROP_c3_2_l0_c5_i3;
    logic         l0_c5_i3;
    
    logic [3 : 0] COUT_LA_l0_c6_s0;
    logic         CIN_LA_l0_c6_s0;
    logic [7 : 0] CY_LA_l0_c6_s0;
    logic [7 : 0] PROP_LA_l0_c6_s0;
    
    logic [2 : 0] C0_c3_2_l0_c6_i0;
    logic [1 : 0] O_c3_2_l0_c6_i0;
    logic         CY_c3_2_l0_c6_i0;
    logic         PROP_c3_2_l0_c6_i0;
    logic         l0_c6_i0;
    
    logic [2 : 0] C0_c3_2_l0_c6_i1;
    logic [1 : 0] O_c3_2_l0_c6_i1;
    logic         CY_c3_2_l0_c6_i1;
    logic         PROP_c3_2_l0_c6_i1;
    logic         l0_c6_i1;
    
    logic [4 : 0] C0_c15_3_l0_c6_i2;
    logic         C1_c15_3_l0_c6_i2;
    logic         CLA_c15_3_l0_c6_i2;
    logic [2 : 0] O_c15_3_l0_c6_i2;
    logic [1 : 0] CY_c15_3_l0_c6_i2;
    logic [1 : 0] PROP_c15_3_l0_c6_i2;
    logic         l0_c6_i2;
    
    logic [4 : 0] C0_c15_3_l0_c6_i3;
    logic         C1_c15_3_l0_c6_i3;
    logic         CLA_c15_3_l0_c6_i3;
    logic [2 : 0] O_c15_3_l0_c6_i3;
    logic [1 : 0] CY_c15_3_l0_c6_i3;
    logic [1 : 0] PROP_c15_3_l0_c6_i3;
    logic         l0_c6_i3;
    
    logic [2 : 0] C0_c3_2_l0_c6_i4;
    logic [1 : 0] O_c3_2_l0_c6_i4;
    logic         CY_c3_2_l0_c6_i4;
    logic         PROP_c3_2_l0_c6_i4;
    logic         l0_c6_i4;
    
    logic [2 : 0] C0_c3_2_l0_f10;
    logic [1 : 0] O_c3_2_l0_i10;
    logic         CY_c3_2_l0_f10;
    logic         PROP_c3_2_l0_f10;
    
    logic [3 : 0] COUT_LA_l0_c7_s0;
    logic         CIN_LA_l0_c7_s0;
    logic [7 : 0] CY_LA_l0_c7_s0;
    logic [7 : 0] PROP_LA_l0_c7_s0;
    
    logic [2 : 0] C0_c223_4_l0_c7_i0;
    logic [1 : 0] C1_c223_4_l0_c7_i0;
    logic [1 : 0] C2_c223_4_l0_c7_i0;
    logic         CLA_c223_4_l0_c7_i0;
    logic [3 : 0] O_c223_4_l0_c7_i0;
    logic [1 : 0] CY_c223_4_l0_c7_i0;
    logic [1 : 0] PROP_c223_4_l0_c7_i0;
    logic         l0_c7_i0;
    
    logic [2 : 0] C0_c3_2_l0_c7_i1;
    logic [1 : 0] O_c3_2_l0_c7_i1;
    logic         CY_c3_2_l0_c7_i1;
    logic         PROP_c3_2_l0_c7_i1;
    logic         l0_c7_i1;
    
    logic [2 : 0] C0_c3_2_l0_c7_i2;
    logic [1 : 0] O_c3_2_l0_c7_i2;
    logic         CY_c3_2_l0_c7_i2;
    logic         PROP_c3_2_l0_c7_i2;
    logic         l0_c7_i2;
    
    logic [2 : 0] C0_c3_2_l0_f11;
    logic [1 : 0] O_c3_2_l0_i11;
    logic         CY_c3_2_l0_f11;
    logic         PROP_c3_2_l0_f11;
    
    logic [11 : 0] COUT_LA_l0_floating_placement;
    logic [2  : 0] CIN_LA_l0_floating_placement;
    logic [23 : 0] CY_LA_l0_floating_placement;
    logic [23 : 0] PROP_LA_l0_floating_placement;
    
    // ------------------------------ LAYER 1 ------------------------------
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
    logic [2  : 0] layer1_col10;
    logic [2  : 0] layer1_col11;
    logic [2  : 0] layer1_col12;
    logic [2  : 0] layer1_col13;
    logic [2  : 0] layer1_col14;
    logic [4  : 0] layer1_col15;
    logic [3  : 0] layer1_col16;
    logic [3  : 0] layer1_col17;
    logic [3  : 0] layer1_col18;
    logic [7  : 0] layer1_col19;
    logic [3  : 0] layer1_col20;
    logic [4  : 0] layer1_col21;
    logic [6  : 0] layer1_col22;
    logic [5  : 0] layer1_col23;
    logic [7  : 0] layer1_col24;
    logic [4  : 0] layer1_col25;
    logic [9  : 0] layer1_col26;
    logic [7  : 0] layer1_col27;
    logic [7  : 0] layer1_col28;
    logic [9  : 0] layer1_col29;
    logic [5  : 0] layer1_col30;
    logic [8  : 0] layer1_col31;
    logic [8  : 0] layer1_col32;
    logic [7  : 0] layer1_col33;
    logic [4  : 0] layer1_col34;
    logic [7  : 0] layer1_col35;
    logic [5  : 0] layer1_col36;
    logic [5  : 0] layer1_col37;
    logic [4  : 0] layer1_col38;
    logic [8  : 0] layer1_col39;
    logic [3  : 0] layer1_col40;
    logic [6  : 0] layer1_col41;
    logic [6  : 0] layer1_col42;
    logic [3  : 0] layer1_col43;
    logic [3  : 0] layer1_col44;
    logic [3  : 0] layer1_col45;
    logic [2  : 0] layer1_col46;
    logic [2  : 0] layer1_col47;
    logic [3  : 0] layer1_col48;
    logic [2  : 0] layer1_col49;
    logic [3  : 0] layer1_col50;
    logic [2  : 0] layer1_col51;
    logic [3  : 0] layer1_col52;
    logic [2  : 0] layer1_col53;
    logic [3  : 0] layer1_col54;
    logic [2  : 0] layer1_col55;
    logic [1  : 0] layer1_col56;
    logic [1  : 0] layer1_col57;
    logic          layer1_col58;
    logic          layer1_col59;
    
    logic [3 : 0] COUT_LA_l1_c0_s0;
    logic         CIN_LA_l1_c0_s0;
    logic [7 : 0] CY_LA_l1_c0_s0;
    logic [7 : 0] PROP_LA_l1_c0_s0;
    
    logic [2 : 0] C0_c223_4_l1_c0_i0;
    logic [1 : 0] C1_c223_4_l1_c0_i0;
    logic [1 : 0] C2_c223_4_l1_c0_i0;
    logic         CLA_c223_4_l1_c0_i0;
    logic [3 : 0] O_c223_4_l1_c0_i0;
    logic [1 : 0] CY_c223_4_l1_c0_i0;
    logic [1 : 0] PROP_c223_4_l1_c0_i0;
    logic         l1_c0_i0;
    
    logic [2 : 0] C0_c3_2_l1_c0_i1;
    logic [1 : 0] O_c3_2_l1_c0_i1;
    logic         CY_c3_2_l1_c0_i1;
    logic         PROP_c3_2_l1_c0_i1;
    logic         l1_c0_i1;
    
    logic [4 : 0] C0_c15_3_l1_c0_i2;
    logic         C1_c15_3_l1_c0_i2;
    logic         CLA_c15_3_l1_c0_i2;
    logic [2 : 0] O_c15_3_l1_c0_i2;
    logic [1 : 0] CY_c15_3_l1_c0_i2;
    logic [1 : 0] PROP_c15_3_l1_c0_i2;
    logic         l1_c0_i2;
    
    logic [2 : 0] C0_c3_2_l1_c0_i3;
    logic [1 : 0] O_c3_2_l1_c0_i3;
    logic         CY_c3_2_l1_c0_i3;
    logic         PROP_c3_2_l1_c0_i3;
    logic         l1_c0_i3;
    
    logic [4 : 0] C0_c15_3_l1_c0_i4;
    logic         C1_c15_3_l1_c0_i4;
    logic         CLA_c15_3_l1_c0_i4;
    logic [2 : 0] O_c15_3_l1_c0_i4;
    logic [1 : 0] CY_c15_3_l1_c0_i4;
    logic [1 : 0] PROP_c15_3_l1_c0_i4;
    logic         l1_c0_i4;
    
    logic [11 : 0] COUT_LA_l1_c1_s0;
    logic [2  : 0] CIN_LA_l1_c1_s0;
    logic [23 : 0] CY_LA_l1_c1_s0;
    logic [23 : 0] PROP_LA_l1_c1_s0;
    
    logic [4 : 0] C0_c15_3_l1_c1_i0;
    logic         C1_c15_3_l1_c1_i0;
    logic         CLA_c15_3_l1_c1_i0;
    logic [2 : 0] O_c15_3_l1_c1_i0;
    logic [1 : 0] CY_c15_3_l1_c1_i0;
    logic [1 : 0] PROP_c15_3_l1_c1_i0;
    logic         l1_c1_i0;
    
    logic [4 : 0] C0_c15_3_l1_c1_i1;
    logic         C1_c15_3_l1_c1_i1;
    logic         CLA_c15_3_l1_c1_i1;
    logic [2 : 0] O_c15_3_l1_c1_i1;
    logic [1 : 0] CY_c15_3_l1_c1_i1;
    logic [1 : 0] PROP_c15_3_l1_c1_i1;
    logic         l1_c1_i1;
    
    logic [4 : 0] C0_c15_3_l1_c1_i2;
    logic         C1_c15_3_l1_c1_i2;
    logic         CLA_c15_3_l1_c1_i2;
    logic [2 : 0] O_c15_3_l1_c1_i2;
    logic [1 : 0] CY_c15_3_l1_c1_i2;
    logic [1 : 0] PROP_c15_3_l1_c1_i2;
    logic         l1_c1_i2;
    
    logic [4 : 0] C0_c15_3_l1_c1_i3;
    logic         C1_c15_3_l1_c1_i3;
    logic         CLA_c15_3_l1_c1_i3;
    logic [2 : 0] O_c15_3_l1_c1_i3;
    logic [1 : 0] CY_c15_3_l1_c1_i3;
    logic [1 : 0] PROP_c15_3_l1_c1_i3;
    logic         l1_c1_i3;
    
    logic [4 : 0] C0_c15_3_l1_c1_i4;
    logic         C1_c15_3_l1_c1_i4;
    logic         CLA_c15_3_l1_c1_i4;
    logic [2 : 0] O_c15_3_l1_c1_i4;
    logic [1 : 0] CY_c15_3_l1_c1_i4;
    logic [1 : 0] PROP_c15_3_l1_c1_i4;
    logic         l1_c1_i4;
    
    logic [2 : 0] C0_c3_2_l1_c1_i5;
    logic [1 : 0] O_c3_2_l1_c1_i5;
    logic         CY_c3_2_l1_c1_i5;
    logic         PROP_c3_2_l1_c1_i5;
    logic         l1_c1_i5;
    
    logic [4 : 0] C0_c15_3_l1_c1_i6;
    logic         C1_c15_3_l1_c1_i6;
    logic         CLA_c15_3_l1_c1_i6;
    logic [2 : 0] O_c15_3_l1_c1_i6;
    logic [1 : 0] CY_c15_3_l1_c1_i6;
    logic [1 : 0] PROP_c15_3_l1_c1_i6;
    logic         l1_c1_i6;
    
    logic [4 : 0] C0_c15_3_l1_c1_i7;
    logic         C1_c15_3_l1_c1_i7;
    logic         CLA_c15_3_l1_c1_i7;
    logic [2 : 0] O_c15_3_l1_c1_i7;
    logic [1 : 0] CY_c15_3_l1_c1_i7;
    logic [1 : 0] PROP_c15_3_l1_c1_i7;
    logic         l1_c1_i7;
    
    logic [4 : 0] C0_c15_3_l1_c1_i8;
    logic         C1_c15_3_l1_c1_i8;
    logic         CLA_c15_3_l1_c1_i8;
    logic [2 : 0] O_c15_3_l1_c1_i8;
    logic [1 : 0] CY_c15_3_l1_c1_i8;
    logic [1 : 0] PROP_c15_3_l1_c1_i8;
    logic         l1_c1_i8;
    
    logic [4 : 0] C0_c15_3_l1_c1_i9;
    logic         C1_c15_3_l1_c1_i9;
    logic         CLA_c15_3_l1_c1_i9;
    logic [2 : 0] O_c15_3_l1_c1_i9;
    logic [1 : 0] CY_c15_3_l1_c1_i9;
    logic [1 : 0] PROP_c15_3_l1_c1_i9;
    logic         l1_c1_i9;
    
    logic [2 : 0] C0_c3_2_l1_c1_i10;
    logic [1 : 0] O_c3_2_l1_c1_i10;
    logic         CY_c3_2_l1_c1_i10;
    logic         PROP_c3_2_l1_c1_i10;
    logic         l1_c1_i10;
    
    logic [2 : 0] C0_c3_2_l1_c1_i11;
    logic [1 : 0] O_c3_2_l1_c1_i11;
    logic         CY_c3_2_l1_c1_i11;
    logic         PROP_c3_2_l1_c1_i11;
    logic         l1_c1_i11;
    
    logic [2 : 0] C0_c3_2_l1_c1_i12;
    logic [1 : 0] O_c3_2_l1_c1_i12;
    logic         CY_c3_2_l1_c1_i12;
    logic         PROP_c3_2_l1_c1_i12;
    logic         l1_c1_i12;
    
    logic [3 : 0] COUT_LA_l1_c2_s0;
    logic         CIN_LA_l1_c2_s0;
    logic [7 : 0] CY_LA_l1_c2_s0;
    logic [7 : 0] PROP_LA_l1_c2_s0;
    
    logic [2 : 0] C0_c223_4_l1_c2_i0;
    logic [1 : 0] C1_c223_4_l1_c2_i0;
    logic [1 : 0] C2_c223_4_l1_c2_i0;
    logic         CLA_c223_4_l1_c2_i0;
    logic [3 : 0] O_c223_4_l1_c2_i0;
    logic [1 : 0] CY_c223_4_l1_c2_i0;
    logic [1 : 0] PROP_c223_4_l1_c2_i0;
    logic         l1_c2_i0;
    
    logic [2 : 0] C0_c3_2_l1_c2_i1;
    logic [1 : 0] O_c3_2_l1_c2_i1;
    logic         CY_c3_2_l1_c2_i1;
    logic         PROP_c3_2_l1_c2_i1;
    logic         l1_c2_i1;
    
    logic [4 : 0] C0_c15_3_l1_c2_i2;
    logic         C1_c15_3_l1_c2_i2;
    logic         CLA_c15_3_l1_c2_i2;
    logic [2 : 0] O_c15_3_l1_c2_i2;
    logic [1 : 0] CY_c15_3_l1_c2_i2;
    logic [1 : 0] PROP_c15_3_l1_c2_i2;
    logic         l1_c2_i2;
    
    logic [2 : 0] C0_c3_2_l1_c2_i3;
    logic [1 : 0] O_c3_2_l1_c2_i3;
    logic         CY_c3_2_l1_c2_i3;
    logic         PROP_c3_2_l1_c2_i3;
    logic         l1_c2_i3;
    
    logic [4 : 0] C0_c15_3_l1_c2_i4;
    logic         C1_c15_3_l1_c2_i4;
    logic         CLA_c15_3_l1_c2_i4;
    logic [2 : 0] O_c15_3_l1_c2_i4;
    logic [1 : 0] CY_c15_3_l1_c2_i4;
    logic [1 : 0] PROP_c15_3_l1_c2_i4;
    logic         l1_c2_i4;
    
    logic [7  : 0] COUT_LA_l1_c3_s0;
    logic [1  : 0] CIN_LA_l1_c3_s0;
    logic [15 : 0] CY_LA_l1_c3_s0;
    logic [15 : 0] PROP_LA_l1_c3_s0;
    
    logic [2 : 0] C0_c3_2_l1_c3_i0;
    logic [1 : 0] O_c3_2_l1_c3_i0;
    logic         CY_c3_2_l1_c3_i0;
    logic         PROP_c3_2_l1_c3_i0;
    logic         l1_c3_i0;
    
    logic [4 : 0] C0_c15_3_l1_c3_i1;
    logic         C1_c15_3_l1_c3_i1;
    logic         CLA_c15_3_l1_c3_i1;
    logic [2 : 0] O_c15_3_l1_c3_i1;
    logic [1 : 0] CY_c15_3_l1_c3_i1;
    logic [1 : 0] PROP_c15_3_l1_c3_i1;
    logic         l1_c3_i1;
    
    logic [4 : 0] C0_c15_3_l1_c3_i2;
    logic         C1_c15_3_l1_c3_i2;
    logic         CLA_c15_3_l1_c3_i2;
    logic [2 : 0] O_c15_3_l1_c3_i2;
    logic [1 : 0] CY_c15_3_l1_c3_i2;
    logic [1 : 0] PROP_c15_3_l1_c3_i2;
    logic         l1_c3_i2;
    
    logic [4 : 0] C0_c15_3_l1_c3_i3;
    logic         C1_c15_3_l1_c3_i3;
    logic         CLA_c15_3_l1_c3_i3;
    logic [2 : 0] O_c15_3_l1_c3_i3;
    logic [1 : 0] CY_c15_3_l1_c3_i3;
    logic [1 : 0] PROP_c15_3_l1_c3_i3;
    logic         l1_c3_i3;
    
    logic [2 : 0] C0_c3_2_l1_c3_i4;
    logic [1 : 0] O_c3_2_l1_c3_i4;
    logic         CY_c3_2_l1_c3_i4;
    logic         PROP_c3_2_l1_c3_i4;
    logic         l1_c3_i4;
    
    logic [4 : 0] C0_c15_3_l1_c3_i5;
    logic         C1_c15_3_l1_c3_i5;
    logic         CLA_c15_3_l1_c3_i5;
    logic [2 : 0] O_c15_3_l1_c3_i5;
    logic [1 : 0] CY_c15_3_l1_c3_i5;
    logic [1 : 0] PROP_c15_3_l1_c3_i5;
    logic         l1_c3_i5;
    
    logic [2 : 0] C0_c3_2_l1_c3_i6;
    logic [1 : 0] O_c3_2_l1_c3_i6;
    logic         CY_c3_2_l1_c3_i6;
    logic         PROP_c3_2_l1_c3_i6;
    logic         l1_c3_i6;
    
    logic [4 : 0] C0_c15_3_l1_c3_i7;
    logic         C1_c15_3_l1_c3_i7;
    logic         CLA_c15_3_l1_c3_i7;
    logic [2 : 0] O_c15_3_l1_c3_i7;
    logic [1 : 0] CY_c15_3_l1_c3_i7;
    logic [1 : 0] PROP_c15_3_l1_c3_i7;
    logic         l1_c3_i7;
    
    logic [2 : 0] C0_c3_2_l1_c3_i8;
    logic [1 : 0] O_c3_2_l1_c3_i8;
    logic         CY_c3_2_l1_c3_i8;
    logic         PROP_c3_2_l1_c3_i8;
    logic         l1_c3_i8;
    
    logic [4 : 0] C0_c15_3_l1_c3_i9;
    logic         C1_c15_3_l1_c3_i9;
    logic         CLA_c15_3_l1_c3_i9;
    logic [2 : 0] O_c15_3_l1_c3_i9;
    logic [1 : 0] CY_c15_3_l1_c3_i9;
    logic [1 : 0] PROP_c15_3_l1_c3_i9;
    logic         l1_c3_i9;
    
    logic [7  : 0] COUT_LA_l1_c4_s0;
    logic [1  : 0] CIN_LA_l1_c4_s0;
    logic [15 : 0] CY_LA_l1_c4_s0;
    logic [15 : 0] PROP_LA_l1_c4_s0;
    
    logic [4 : 0] C0_c15_3_l1_c4_i0;
    logic         C1_c15_3_l1_c4_i0;
    logic         CLA_c15_3_l1_c4_i0;
    logic [2 : 0] O_c15_3_l1_c4_i0;
    logic [1 : 0] CY_c15_3_l1_c4_i0;
    logic [1 : 0] PROP_c15_3_l1_c4_i0;
    logic         l1_c4_i0;
    
    logic [4 : 0] C0_c15_3_l1_c4_i1;
    logic         C1_c15_3_l1_c4_i1;
    logic         CLA_c15_3_l1_c4_i1;
    logic [2 : 0] O_c15_3_l1_c4_i1;
    logic [1 : 0] CY_c15_3_l1_c4_i1;
    logic [1 : 0] PROP_c15_3_l1_c4_i1;
    logic         l1_c4_i1;
    
    logic [4 : 0] C0_c15_3_l1_c4_i2;
    logic         C1_c15_3_l1_c4_i2;
    logic         CLA_c15_3_l1_c4_i2;
    logic [2 : 0] O_c15_3_l1_c4_i2;
    logic [1 : 0] CY_c15_3_l1_c4_i2;
    logic [1 : 0] PROP_c15_3_l1_c4_i2;
    logic         l1_c4_i2;
    
    logic [2 : 0] C0_c3_2_l1_c4_i3;
    logic [1 : 0] O_c3_2_l1_c4_i3;
    logic         CY_c3_2_l1_c4_i3;
    logic         PROP_c3_2_l1_c4_i3;
    logic         l1_c4_i3;
    
    logic [2 : 0] C0_c3_2_l1_c4_i4;
    logic [1 : 0] O_c3_2_l1_c4_i4;
    logic         CY_c3_2_l1_c4_i4;
    logic         PROP_c3_2_l1_c4_i4;
    logic         l1_c4_i4;
    
    logic [2 : 0] C0_c3_2_l1_c4_i5;
    logic [1 : 0] O_c3_2_l1_c4_i5;
    logic         CY_c3_2_l1_c4_i5;
    logic         PROP_c3_2_l1_c4_i5;
    logic         l1_c4_i5;
    
    logic [2 : 0] C0_c3_2_l1_f0;
    logic [1 : 0] O_c3_2_l1_i0;
    logic         CY_c3_2_l1_f0;
    logic         PROP_c3_2_l1_f0;
    
    logic    COUT_LA_l1_floating_placement;
    logic    CIN_LA_l1_floating_placement;
    logic    CY_LA_l1_floating_placement;
    logic    PROP_LA_l1_floating_placement;
    
    // ------------------------------ LAYER 2 ------------------------------
    logic [1  : 0] layer2_col0;
    logic          layer2_col1;
    logic [2  : 0] layer2_col2;
    logic [1  : 0] layer2_col3;
    logic [3  : 0] layer2_col4;
    logic [2  : 0] layer2_col5;
    logic [2  : 0] layer2_col6;
    logic [2  : 0] layer2_col7;
    logic [2  : 0] layer2_col8;
    logic [2  : 0] layer2_col9;
    logic [2  : 0] layer2_col10;
    logic [2  : 0] layer2_col11;
    logic [2  : 0] layer2_col12;
    logic [2  : 0] layer2_col13;
    logic [2  : 0] layer2_col14;
    logic [2  : 0] layer2_col15;
    logic [2  : 0] layer2_col16;
    logic [2  : 0] layer2_col17;
    logic [2  : 0] layer2_col18;
    logic [2  : 0] layer2_col19;
    logic [2  : 0] layer2_col20;
    logic [2  : 0] layer2_col21;
    logic [2  : 0] layer2_col22;
    logic [2  : 0] layer2_col23;
    logic [4  : 0] layer2_col24;
    logic [3  : 0] layer2_col25;
    logic [3  : 0] layer2_col26;
    logic [3  : 0] layer2_col27;
    logic [3  : 0] layer2_col28;
    logic [3  : 0] layer2_col29;
    logic [2  : 0] layer2_col30;
    logic [2  : 0] layer2_col31;
    logic [3  : 0] layer2_col32;
    logic [4  : 0] layer2_col33;
    logic [2  : 0] layer2_col34;
    logic [2  : 0] layer2_col35;
    logic [3  : 0] layer2_col36;
    logic [2  : 0] layer2_col37;
    logic [3  : 0] layer2_col38;
    logic [2  : 0] layer2_col39;
    logic [3  : 0] layer2_col40;
    logic [2  : 0] layer2_col41;
    logic [3  : 0] layer2_col42;
    logic [2  : 0] layer2_col43;
    logic [3  : 0] layer2_col44;
    logic [2  : 0] layer2_col45;
    logic [3  : 0] layer2_col46;
    logic [2  : 0] layer2_col47;
    logic [3  : 0] layer2_col48;
    logic [2  : 0] layer2_col49;
    logic [3  : 0] layer2_col50;
    logic [2  : 0] layer2_col51;
    logic [3  : 0] layer2_col52;
    logic [2  : 0] layer2_col53;
    logic [3  : 0] layer2_col54;
    logic [2  : 0] layer2_col55;
    logic [1  : 0] layer2_col56;
    logic [1  : 0] layer2_col57;
    logic          layer2_col58;
    logic          layer2_col59;
    
    logic [3 : 0] COUT_LA_l2_c0_s0;
    logic         CIN_LA_l2_c0_s0;
    logic [7 : 0] CY_LA_l2_c0_s0;
    logic [7 : 0] PROP_LA_l2_c0_s0;
    
    logic [2 : 0] C0_c223_4_l2_c0_i0;
    logic [1 : 0] C1_c223_4_l2_c0_i0;
    logic [1 : 0] C2_c223_4_l2_c0_i0;
    logic         CLA_c223_4_l2_c0_i0;
    logic [3 : 0] O_c223_4_l2_c0_i0;
    logic [1 : 0] CY_c223_4_l2_c0_i0;
    logic [1 : 0] PROP_c223_4_l2_c0_i0;
    logic         l2_c0_i0;
    
    logic [2 : 0] C0_c223_4_l2_c0_i1;
    logic [1 : 0] C1_c223_4_l2_c0_i1;
    logic [1 : 0] C2_c223_4_l2_c0_i1;
    logic         CLA_c223_4_l2_c0_i1;
    logic [3 : 0] O_c223_4_l2_c0_i1;
    logic [1 : 0] CY_c223_4_l2_c0_i1;
    logic [1 : 0] PROP_c223_4_l2_c0_i1;
    logic         l2_c0_i1;
    
    logic [2 : 0] C0_c3_2_l2_f0;
    logic [1 : 0] O_c3_2_l2_i0;
    logic         CY_c3_2_l2_f0;
    logic         PROP_c3_2_l2_f0;
    
    logic    COUT_LA_l2_floating_placement;
    logic    CIN_LA_l2_floating_placement;
    logic    CY_LA_l2_floating_placement;
    logic    PROP_LA_l2_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
    logic [1  : 0] layer3_col0;
    logic          layer3_col1;
    logic [2  : 0] layer3_col2;
    logic [1  : 0] layer3_col3;
    logic [3  : 0] layer3_col4;
    logic [2  : 0] layer3_col5;
    logic [2  : 0] layer3_col6;
    logic [2  : 0] layer3_col7;
    logic [2  : 0] layer3_col8;
    logic [2  : 0] layer3_col9;
    logic [2  : 0] layer3_col10;
    logic [2  : 0] layer3_col11;
    logic [2  : 0] layer3_col12;
    logic [2  : 0] layer3_col13;
    logic [2  : 0] layer3_col14;
    logic [2  : 0] layer3_col15;
    logic [2  : 0] layer3_col16;
    logic [2  : 0] layer3_col17;
    logic [2  : 0] layer3_col18;
    logic [2  : 0] layer3_col19;
    logic [2  : 0] layer3_col20;
    logic [2  : 0] layer3_col21;
    logic [2  : 0] layer3_col22;
    logic [2  : 0] layer3_col23;
    logic [2  : 0] layer3_col24;
    logic [2  : 0] layer3_col25;
    logic [2  : 0] layer3_col26;
    logic [2  : 0] layer3_col27;
    logic [2  : 0] layer3_col28;
    logic [2  : 0] layer3_col29;
    logic [3  : 0] layer3_col30;
    logic [2  : 0] layer3_col31;
    logic [3  : 0] layer3_col32;
    logic [2  : 0] layer3_col33;
    logic [3  : 0] layer3_col34;
    logic [2  : 0] layer3_col35;
    logic [3  : 0] layer3_col36;
    logic [2  : 0] layer3_col37;
    logic [3  : 0] layer3_col38;
    logic [2  : 0] layer3_col39;
    logic [3  : 0] layer3_col40;
    logic [2  : 0] layer3_col41;
    logic [3  : 0] layer3_col42;
    logic [2  : 0] layer3_col43;
    logic [3  : 0] layer3_col44;
    logic [2  : 0] layer3_col45;
    logic [3  : 0] layer3_col46;
    logic [2  : 0] layer3_col47;
    logic [3  : 0] layer3_col48;
    logic [2  : 0] layer3_col49;
    logic [3  : 0] layer3_col50;
    logic [2  : 0] layer3_col51;
    logic [3  : 0] layer3_col52;
    logic [2  : 0] layer3_col53;
    logic [3  : 0] layer3_col54;
    logic [2  : 0] layer3_col55;
    logic [1  : 0] layer3_col56;
    logic [1  : 0] layer3_col57;
    logic          layer3_col58;
    logic          layer3_col59;
    
    logic [58 : 0] terminal_chain1_out;
    
    logic [31 : 0] COUT_LA_terminal_chain1;
    logic [7  : 0] CIN_LA_terminal_chain1;
    logic [63 : 0] CY_LA_terminal_chain1;
    logic [63 : 0] PROP_LA_terminal_chain1;
    
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
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i9;
    logic         C1_c15_3_terminal_chain1_i9;
    logic         CLA_c15_3_terminal_chain1_i9;
    logic [2 : 0] O_c15_3_terminal_chain1_i9;
    logic [1 : 0] CY_c15_3_terminal_chain1_i9;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i9;
    logic         terminal_chain1_i9;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i10;
    logic         C1_c15_3_terminal_chain1_i10;
    logic         CLA_c15_3_terminal_chain1_i10;
    logic [2 : 0] O_c15_3_terminal_chain1_i10;
    logic [1 : 0] CY_c15_3_terminal_chain1_i10;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i10;
    logic         terminal_chain1_i10;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i11;
    logic         C1_c15_3_terminal_chain1_i11;
    logic         CLA_c15_3_terminal_chain1_i11;
    logic [2 : 0] O_c15_3_terminal_chain1_i11;
    logic [1 : 0] CY_c15_3_terminal_chain1_i11;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i11;
    logic         terminal_chain1_i11;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i12;
    logic         C1_c15_3_terminal_chain1_i12;
    logic         CLA_c15_3_terminal_chain1_i12;
    logic [2 : 0] O_c15_3_terminal_chain1_i12;
    logic [1 : 0] CY_c15_3_terminal_chain1_i12;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i12;
    logic         terminal_chain1_i12;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i13;
    logic         C1_c15_3_terminal_chain1_i13;
    logic         CLA_c15_3_terminal_chain1_i13;
    logic [2 : 0] O_c15_3_terminal_chain1_i13;
    logic [1 : 0] CY_c15_3_terminal_chain1_i13;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i13;
    logic         terminal_chain1_i13;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i14;
    logic         C1_c15_3_terminal_chain1_i14;
    logic         CLA_c15_3_terminal_chain1_i14;
    logic [2 : 0] O_c15_3_terminal_chain1_i14;
    logic [1 : 0] CY_c15_3_terminal_chain1_i14;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i14;
    logic         terminal_chain1_i14;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i15;
    logic         C1_c15_3_terminal_chain1_i15;
    logic         CLA_c15_3_terminal_chain1_i15;
    logic [2 : 0] O_c15_3_terminal_chain1_i15;
    logic [1 : 0] CY_c15_3_terminal_chain1_i15;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i15;
    logic         terminal_chain1_i15;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i16;
    logic         C1_c15_3_terminal_chain1_i16;
    logic         CLA_c15_3_terminal_chain1_i16;
    logic [2 : 0] O_c15_3_terminal_chain1_i16;
    logic [1 : 0] CY_c15_3_terminal_chain1_i16;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i16;
    logic         terminal_chain1_i16;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i17;
    logic         C1_c15_3_terminal_chain1_i17;
    logic         CLA_c15_3_terminal_chain1_i17;
    logic [2 : 0] O_c15_3_terminal_chain1_i17;
    logic [1 : 0] CY_c15_3_terminal_chain1_i17;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i17;
    logic         terminal_chain1_i17;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i18;
    logic         C1_c15_3_terminal_chain1_i18;
    logic         CLA_c15_3_terminal_chain1_i18;
    logic [2 : 0] O_c15_3_terminal_chain1_i18;
    logic [1 : 0] CY_c15_3_terminal_chain1_i18;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i18;
    logic         terminal_chain1_i18;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i19;
    logic         C1_c15_3_terminal_chain1_i19;
    logic         CLA_c15_3_terminal_chain1_i19;
    logic [2 : 0] O_c15_3_terminal_chain1_i19;
    logic [1 : 0] CY_c15_3_terminal_chain1_i19;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i19;
    logic         terminal_chain1_i19;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i20;
    logic         C1_c15_3_terminal_chain1_i20;
    logic         CLA_c15_3_terminal_chain1_i20;
    logic [2 : 0] O_c15_3_terminal_chain1_i20;
    logic [1 : 0] CY_c15_3_terminal_chain1_i20;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i20;
    logic         terminal_chain1_i20;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i21;
    logic         C1_c15_3_terminal_chain1_i21;
    logic         CLA_c15_3_terminal_chain1_i21;
    logic [2 : 0] O_c15_3_terminal_chain1_i21;
    logic [1 : 0] CY_c15_3_terminal_chain1_i21;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i21;
    logic         terminal_chain1_i21;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i22;
    logic         C1_c15_3_terminal_chain1_i22;
    logic         CLA_c15_3_terminal_chain1_i22;
    logic [2 : 0] O_c15_3_terminal_chain1_i22;
    logic [1 : 0] CY_c15_3_terminal_chain1_i22;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i22;
    logic         terminal_chain1_i22;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i23;
    logic         C1_c15_3_terminal_chain1_i23;
    logic         CLA_c15_3_terminal_chain1_i23;
    logic [2 : 0] O_c15_3_terminal_chain1_i23;
    logic [1 : 0] CY_c15_3_terminal_chain1_i23;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i23;
    logic         terminal_chain1_i23;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i24;
    logic         C1_c15_3_terminal_chain1_i24;
    logic         CLA_c15_3_terminal_chain1_i24;
    logic [2 : 0] O_c15_3_terminal_chain1_i24;
    logic [1 : 0] CY_c15_3_terminal_chain1_i24;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i24;
    logic         terminal_chain1_i24;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i25;
    logic         C1_c15_3_terminal_chain1_i25;
    logic         CLA_c15_3_terminal_chain1_i25;
    logic [2 : 0] O_c15_3_terminal_chain1_i25;
    logic [1 : 0] CY_c15_3_terminal_chain1_i25;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i25;
    logic         terminal_chain1_i25;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i26;
    logic         C1_c15_3_terminal_chain1_i26;
    logic         CLA_c15_3_terminal_chain1_i26;
    logic [2 : 0] O_c15_3_terminal_chain1_i26;
    logic [1 : 0] CY_c15_3_terminal_chain1_i26;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i26;
    logic         terminal_chain1_i26;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i27;
    logic         C1_c15_3_terminal_chain1_i27;
    logic         CLA_c15_3_terminal_chain1_i27;
    logic [2 : 0] O_c15_3_terminal_chain1_i27;
    logic [1 : 0] CY_c15_3_terminal_chain1_i27;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i27;
    logic         terminal_chain1_i27;
    
    logic [4 : 0] C0_c15_3_terminal_chain1_i28;
    logic         C1_c15_3_terminal_chain1_i28;
    logic         CLA_c15_3_terminal_chain1_i28;
    logic [2 : 0] O_c15_3_terminal_chain1_i28;
    logic [1 : 0] CY_c15_3_terminal_chain1_i28;
    logic [1 : 0] PROP_c15_3_terminal_chain1_i28;
    logic         terminal_chain1_i28;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i29;
    logic [1 : 0] O_c3_2_terminal_chain1_i29;
    logic         CY_c3_2_terminal_chain1_i29;
    logic         PROP_c3_2_terminal_chain1_i29;
    logic         terminal_chain1_i29;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i30;
    logic [1 : 0] O_c3_2_terminal_chain1_i30;
    logic         CY_c3_2_terminal_chain1_i30;
    logic         PROP_c3_2_terminal_chain1_i30;
    logic         terminal_chain1_i30;
    
    logic [57 : 0] terminal_chain2_out;
    
    logic [31 : 0] COUT_LA_terminal_chain2;
    logic [7  : 0] CIN_LA_terminal_chain2;
    logic [63 : 0] CY_LA_terminal_chain2;
    logic [63 : 0] PROP_LA_terminal_chain2;
    
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
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i7;
    logic         C1_c15_3_terminal_chain2_i7;
    logic         CLA_c15_3_terminal_chain2_i7;
    logic [2 : 0] O_c15_3_terminal_chain2_i7;
    logic [1 : 0] CY_c15_3_terminal_chain2_i7;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i7;
    logic         terminal_chain2_i7;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i8;
    logic         C1_c15_3_terminal_chain2_i8;
    logic         CLA_c15_3_terminal_chain2_i8;
    logic [2 : 0] O_c15_3_terminal_chain2_i8;
    logic [1 : 0] CY_c15_3_terminal_chain2_i8;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i8;
    logic         terminal_chain2_i8;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i9;
    logic         C1_c15_3_terminal_chain2_i9;
    logic         CLA_c15_3_terminal_chain2_i9;
    logic [2 : 0] O_c15_3_terminal_chain2_i9;
    logic [1 : 0] CY_c15_3_terminal_chain2_i9;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i9;
    logic         terminal_chain2_i9;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i10;
    logic         C1_c15_3_terminal_chain2_i10;
    logic         CLA_c15_3_terminal_chain2_i10;
    logic [2 : 0] O_c15_3_terminal_chain2_i10;
    logic [1 : 0] CY_c15_3_terminal_chain2_i10;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i10;
    logic         terminal_chain2_i10;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i11;
    logic         C1_c15_3_terminal_chain2_i11;
    logic         CLA_c15_3_terminal_chain2_i11;
    logic [2 : 0] O_c15_3_terminal_chain2_i11;
    logic [1 : 0] CY_c15_3_terminal_chain2_i11;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i11;
    logic         terminal_chain2_i11;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i12;
    logic         C1_c15_3_terminal_chain2_i12;
    logic         CLA_c15_3_terminal_chain2_i12;
    logic [2 : 0] O_c15_3_terminal_chain2_i12;
    logic [1 : 0] CY_c15_3_terminal_chain2_i12;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i12;
    logic         terminal_chain2_i12;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i13;
    logic         C1_c15_3_terminal_chain2_i13;
    logic         CLA_c15_3_terminal_chain2_i13;
    logic [2 : 0] O_c15_3_terminal_chain2_i13;
    logic [1 : 0] CY_c15_3_terminal_chain2_i13;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i13;
    logic         terminal_chain2_i13;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i14;
    logic         C1_c15_3_terminal_chain2_i14;
    logic         CLA_c15_3_terminal_chain2_i14;
    logic [2 : 0] O_c15_3_terminal_chain2_i14;
    logic [1 : 0] CY_c15_3_terminal_chain2_i14;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i14;
    logic         terminal_chain2_i14;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i15;
    logic         C1_c15_3_terminal_chain2_i15;
    logic         CLA_c15_3_terminal_chain2_i15;
    logic [2 : 0] O_c15_3_terminal_chain2_i15;
    logic [1 : 0] CY_c15_3_terminal_chain2_i15;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i15;
    logic         terminal_chain2_i15;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i16;
    logic         C1_c15_3_terminal_chain2_i16;
    logic         CLA_c15_3_terminal_chain2_i16;
    logic [2 : 0] O_c15_3_terminal_chain2_i16;
    logic [1 : 0] CY_c15_3_terminal_chain2_i16;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i16;
    logic         terminal_chain2_i16;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i17;
    logic         C1_c15_3_terminal_chain2_i17;
    logic         CLA_c15_3_terminal_chain2_i17;
    logic [2 : 0] O_c15_3_terminal_chain2_i17;
    logic [1 : 0] CY_c15_3_terminal_chain2_i17;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i17;
    logic         terminal_chain2_i17;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i18;
    logic         C1_c15_3_terminal_chain2_i18;
    logic         CLA_c15_3_terminal_chain2_i18;
    logic [2 : 0] O_c15_3_terminal_chain2_i18;
    logic [1 : 0] CY_c15_3_terminal_chain2_i18;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i18;
    logic         terminal_chain2_i18;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i19;
    logic         C1_c15_3_terminal_chain2_i19;
    logic         CLA_c15_3_terminal_chain2_i19;
    logic [2 : 0] O_c15_3_terminal_chain2_i19;
    logic [1 : 0] CY_c15_3_terminal_chain2_i19;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i19;
    logic         terminal_chain2_i19;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i20;
    logic         C1_c15_3_terminal_chain2_i20;
    logic         CLA_c15_3_terminal_chain2_i20;
    logic [2 : 0] O_c15_3_terminal_chain2_i20;
    logic [1 : 0] CY_c15_3_terminal_chain2_i20;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i20;
    logic         terminal_chain2_i20;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i21;
    logic         C1_c15_3_terminal_chain2_i21;
    logic         CLA_c15_3_terminal_chain2_i21;
    logic [2 : 0] O_c15_3_terminal_chain2_i21;
    logic [1 : 0] CY_c15_3_terminal_chain2_i21;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i21;
    logic         terminal_chain2_i21;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i22;
    logic         C1_c15_3_terminal_chain2_i22;
    logic         CLA_c15_3_terminal_chain2_i22;
    logic [2 : 0] O_c15_3_terminal_chain2_i22;
    logic [1 : 0] CY_c15_3_terminal_chain2_i22;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i22;
    logic         terminal_chain2_i22;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i23;
    logic         C1_c15_3_terminal_chain2_i23;
    logic         CLA_c15_3_terminal_chain2_i23;
    logic [2 : 0] O_c15_3_terminal_chain2_i23;
    logic [1 : 0] CY_c15_3_terminal_chain2_i23;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i23;
    logic         terminal_chain2_i23;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i24;
    logic         C1_c15_3_terminal_chain2_i24;
    logic         CLA_c15_3_terminal_chain2_i24;
    logic [2 : 0] O_c15_3_terminal_chain2_i24;
    logic [1 : 0] CY_c15_3_terminal_chain2_i24;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i24;
    logic         terminal_chain2_i24;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i25;
    logic         C1_c15_3_terminal_chain2_i25;
    logic         CLA_c15_3_terminal_chain2_i25;
    logic [2 : 0] O_c15_3_terminal_chain2_i25;
    logic [1 : 0] CY_c15_3_terminal_chain2_i25;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i25;
    logic         terminal_chain2_i25;
    
    logic [4 : 0] C0_c15_3_terminal_chain2_i26;
    logic         C1_c15_3_terminal_chain2_i26;
    logic         CLA_c15_3_terminal_chain2_i26;
    logic [2 : 0] O_c15_3_terminal_chain2_i26;
    logic [1 : 0] CY_c15_3_terminal_chain2_i26;
    logic [1 : 0] PROP_c15_3_terminal_chain2_i26;
    logic         terminal_chain2_i26;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i27;
    logic [1 : 0] O_c3_2_terminal_chain2_i27;
    logic         CY_c3_2_terminal_chain2_i27;
    logic         PROP_c3_2_terminal_chain2_i27;
    logic         terminal_chain2_i27;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i28;
    logic [1 : 0] O_c3_2_terminal_chain2_i28;
    logic         CY_c3_2_terminal_chain2_i28;
    logic         PROP_c3_2_terminal_chain2_i28;
    logic         terminal_chain2_i28;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i29;
    logic [1 : 0] O_c3_2_terminal_chain2_i29;
    logic         CY_c3_2_terminal_chain2_i29;
    logic         PROP_c3_2_terminal_chain2_i29;
    logic         terminal_chain2_i29;
    
    // ------------------------------ LAYER 0 ------------------------------
    // GPC chain0 in layer0:
    // -- (3 : 2] at column 6
    // -- (3 : 2] at column 7
    // -- (1,5 : 3] at column 8
    // -- (1,5 : 3] at column 10
    // -- (1,5 : 3] at column 12
    // -- (1,5 : 3] at column 14
    // -- (1,5 : 3] at column 16
    // -- (3,9 : 2,3,1) at column 18
    // -- (3,9 : 2,3,1) at column 20
    // -- (3,9 : 2,3,1) at column 22
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l0_c0_s0_inst0 (
        .COUTB(COUT_LA_l0_c0_s0[0]),
        .COUTD(COUT_LA_l0_c0_s0[1]),
        .COUTF(COUT_LA_l0_c0_s0[2]),
        .COUTH(COUT_LA_l0_c0_s0[3]),
        .CIN  (CIN_LA_l0_c0_s0[0] ),
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

    LOOKAHEAD8 #(
        .LOOKB("TRUE" ),
        .LOOKD("TRUE" ),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c0_s0_inst1 (
        .COUTB(COUT_LA_l0_c0_s0[4] ),
        .COUTD(COUT_LA_l0_c0_s0[5] ),
        .COUTF(COUT_LA_l0_c0_s0[6] ),
        .COUTH(COUT_LA_l0_c0_s0[7] ),
        .CIN  (CIN_LA_l0_c0_s0[1]  ),
        .CYA  (CY_LA_l0_c0_s0[8]   ),
        .CYB  (CY_LA_l0_c0_s0[9]   ),
        .CYC  (CY_LA_l0_c0_s0[10]  ),
        .CYD  (CY_LA_l0_c0_s0[11]  ),
        .CYE  (CY_LA_l0_c0_s0[12]  ),
        .CYF  (CY_LA_l0_c0_s0[13]  ),
        .CYG  (CY_LA_l0_c0_s0[14]  ),
        .CYH  (CY_LA_l0_c0_s0[15]  ),
        .PROPA(PROP_LA_l0_c0_s0[8] ),
        .PROPB(PROP_LA_l0_c0_s0[9] ),
        .PROPC(PROP_LA_l0_c0_s0[10]),
        .PROPD(PROP_LA_l0_c0_s0[11]),
        .PROPE(PROP_LA_l0_c0_s0[12]),
        .PROPF(PROP_LA_l0_c0_s0[13]),
        .PROPG(PROP_LA_l0_c0_s0[14]),
        .PROPH(PROP_LA_l0_c0_s0[15]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c0_s1_inst0 (
        .COUTB(COUT_LA_l0_c0_s1[0]),
        .COUTD(COUT_LA_l0_c0_s1[1]),
        .COUTF(COUT_LA_l0_c0_s1[2]),
        .COUTH(COUT_LA_l0_c0_s1[3]),
        .CIN  (CIN_LA_l0_c0_s1    ),
        .CYA  (CY_LA_l0_c0_s1[0]  ),
        .CYB  (CY_LA_l0_c0_s1[1]  ),
        .CYC  (CY_LA_l0_c0_s1[2]  ),
        .CYD  (CY_LA_l0_c0_s1[3]  ),
        .CYE  (CY_LA_l0_c0_s1[4]  ),
        .CYF  (CY_LA_l0_c0_s1[5]  ),
        .CYG  (CY_LA_l0_c0_s1[6]  ),
        .CYH  (CY_LA_l0_c0_s1[7]  ),
        .PROPA(PROP_LA_l0_c0_s1[0]),
        .PROPB(PROP_LA_l0_c0_s1[1]),
        .PROPC(PROP_LA_l0_c0_s1[2]),
        .PROPD(PROP_LA_l0_c0_s1[3]),
        .PROPE(PROP_LA_l0_c0_s1[4]),
        .PROPF(PROP_LA_l0_c0_s1[5]),
        .PROPG(PROP_LA_l0_c0_s1[6]),
        .PROPH(PROP_LA_l0_c0_s1[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c0_s2_inst0 (
        .COUTB(COUT_LA_l0_c0_s2[0]),
        .COUTD(COUT_LA_l0_c0_s2[1]),
        .COUTF(COUT_LA_l0_c0_s2[2]),
        .COUTH(COUT_LA_l0_c0_s2[3]),
        .CIN  (CIN_LA_l0_c0_s2    ),
        .CYA  (CY_LA_l0_c0_s2[0]  ),
        .CYB  (CY_LA_l0_c0_s2[1]  ),
        .CYC  (CY_LA_l0_c0_s2[2]  ),
        .CYD  (CY_LA_l0_c0_s2[3]  ),
        .CYE  (CY_LA_l0_c0_s2[4]  ),
        .CYF  (CY_LA_l0_c0_s2[5]  ),
        .CYG  (CY_LA_l0_c0_s2[6]  ),
        .CYH  (CY_LA_l0_c0_s2[7]  ),
        .PROPA(PROP_LA_l0_c0_s2[0]),
        .PROPB(PROP_LA_l0_c0_s2[1]),
        .PROPC(PROP_LA_l0_c0_s2[2]),
        .PROPD(PROP_LA_l0_c0_s2[3]),
        .PROPE(PROP_LA_l0_c0_s2[4]),
        .PROPF(PROP_LA_l0_c0_s2[5]),
        .PROPG(PROP_LA_l0_c0_s2[6]),
        .PROPH(PROP_LA_l0_c0_s2[7]));

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
    
    assign CIN_LA_l0_c0_s0[0] = C0_c3_2_l0_c0_i0[2];
    
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
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i4  ),
        .C1  (C1_c15_3_l0_c0_i4  ),
        .CLA (CLA_c15_3_l0_c0_i4 ),
        .O   (O_c15_3_l0_c0_i4   ),
        .CY  (CY_c15_3_l0_c0_i4  ),
        .PROP(PROP_c15_3_l0_c0_i4));
    
    assign C0_c15_3_l0_c0_i4 = {l0_c0_i3, layer0_col12[3:0]};
    assign C1_c15_3_l0_c0_i4 = layer0_col13[0];
    
    assign layer1_col12[0] = O_c15_3_l0_c0_i4[0];
    assign layer1_col13[0] = O_c15_3_l0_c0_i4[1];
    
    assign l0_c0_i4              = COUT_LA_l0_c0_s0[3];
    assign CY_LA_l0_c0_s0[7:6]   = CY_c15_3_l0_c0_i4;
    assign PROP_LA_l0_c0_s0[7:6] = PROP_c15_3_l0_c0_i4;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i5(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i5  ),
        .C1  (C1_c15_3_l0_c0_i5  ),
        .CLA (CLA_c15_3_l0_c0_i5 ),
        .O   (O_c15_3_l0_c0_i5   ),
        .CY  (CY_c15_3_l0_c0_i5  ),
        .PROP(PROP_c15_3_l0_c0_i5));
    
    assign C0_c15_3_l0_c0_i5 = {l0_c0_i4, layer0_col14[3:0]};
    assign C1_c15_3_l0_c0_i5 = layer0_col15[0];
    
    assign layer1_col14[0] = O_c15_3_l0_c0_i5[0];
    assign layer1_col15[0] = O_c15_3_l0_c0_i5[1];
    
    assign l0_c0_i5              = COUT_LA_l0_c0_s0[4];
    assign CY_LA_l0_c0_s0[9:8]   = CY_c15_3_l0_c0_i5;
    assign PROP_LA_l0_c0_s0[9:8] = PROP_c15_3_l0_c0_i5;
    
    assign CIN_LA_l0_c0_s0[1] = COUT_LA_l0_c0_s0[3];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i6(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i6  ),
        .C1  (C1_c15_3_l0_c0_i6  ),
        .CLA (CLA_c15_3_l0_c0_i6 ),
        .O   (O_c15_3_l0_c0_i6   ),
        .CY  (CY_c15_3_l0_c0_i6  ),
        .PROP(PROP_c15_3_l0_c0_i6));
    
    assign C0_c15_3_l0_c0_i6 = {l0_c0_i5, layer0_col16[3:0]};
    assign C1_c15_3_l0_c0_i6 = layer0_col17[0];
    
    assign layer1_col16[0] = O_c15_3_l0_c0_i6[0];
    assign layer1_col17[0] = O_c15_3_l0_c0_i6[1];
    
    assign l0_c0_i6                = COUT_LA_l0_c0_s0[5];
    assign CY_LA_l0_c0_s0[11:10]   = CY_c15_3_l0_c0_i6;
    assign PROP_LA_l0_c0_s0[11:10] = PROP_c15_3_l0_c0_i6;
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c0_i7(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c0_i7   ),
        .C1   (C1_c39_231_l0_c0_i7   ),
        .CLA  (CLA_c39_231_l0_c0_i7  ),
        .O0   (O0_c39_231_l0_c0_i7   ),
        .O1   (O1_c39_231_l0_c0_i7   ),
        .O2   (O2_c39_231_l0_c0_i7   ),
        .CY0  (CY0_c39_231_l0_c0_i7  ),
        .CY1  (CY1_c39_231_l0_c0_i7  ),
        .PROP0(PROP0_c39_231_l0_c0_i7),
        .PROP1(PROP1_c39_231_l0_c0_i7));
    
    assign C0_c39_231_l0_c0_i7 = {l0_c0_i6, layer0_col18[7:0]};
    assign C1_c39_231_l0_c0_i7 = layer0_col19[2:0];
    
    assign layer1_col18[0]   = O0_c39_231_l0_c0_i7;
    assign layer1_col19[2:0] = O1_c39_231_l0_c0_i7;
    assign layer1_col20[1]   = O2_c39_231_l0_c0_i7[0];
    
    assign CLA_c39_231_l0_c0_i7    = COUT_LA_l0_c0_s0[5];
    assign l0_c0_i7                = COUT_LA_l0_c0_s1[0];
    assign CY_LA_l0_c0_s0[13:12]   = CY0_c39_231_l0_c0_i7;
    assign PROP_LA_l0_c0_s0[13:12] = PROP0_c39_231_l0_c0_i7;
    assign CY_LA_l0_c0_s1[1:0]     = CY1_c39_231_l0_c0_i7;
    assign PROP_LA_l0_c0_s1[1:0]   = PROP1_c39_231_l0_c0_i7;
    assign CIN_LA_l0_c0_s1         = layer0_col19[1];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c0_i8(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c0_i8   ),
        .C1   (C1_c39_231_l0_c0_i8   ),
        .CLA  (CLA_c39_231_l0_c0_i8  ),
        .O0   (O0_c39_231_l0_c0_i8   ),
        .O1   (O1_c39_231_l0_c0_i8   ),
        .O2   (O2_c39_231_l0_c0_i8   ),
        .CY0  (CY0_c39_231_l0_c0_i8  ),
        .CY1  (CY1_c39_231_l0_c0_i8  ),
        .PROP0(PROP0_c39_231_l0_c0_i8),
        .PROP1(PROP1_c39_231_l0_c0_i8));
    
    assign C0_c39_231_l0_c0_i8 = {l0_c0_i7, layer0_col20[7:0]};
    assign C1_c39_231_l0_c0_i8 = layer0_col21[2:0];
    
    assign layer1_col20[0]   = O0_c39_231_l0_c0_i8;
    assign layer1_col21[2:0] = O1_c39_231_l0_c0_i8;
    assign layer1_col22[1]   = O2_c39_231_l0_c0_i8[0];
    
    assign CLA_c39_231_l0_c0_i8  = COUT_LA_l0_c0_s1[0];
    assign l0_c0_i8              = COUT_LA_l0_c0_s2[0];
    assign CY_LA_l0_c0_s1[3:2]   = CY0_c39_231_l0_c0_i8;
    assign PROP_LA_l0_c0_s1[3:2] = PROP0_c39_231_l0_c0_i8;
    assign CY_LA_l0_c0_s2[1:0]   = CY1_c39_231_l0_c0_i8;
    assign PROP_LA_l0_c0_s2[1:0] = PROP1_c39_231_l0_c0_i8;
    assign CIN_LA_l0_c0_s2       = layer0_col21[1];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l0_c0_i9(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c0_i9   ),
        .C1   (C1_c39_231_l0_c0_i9   ),
        .CLA  (CLA_c39_231_l0_c0_i9  ),
        .O0   (O0_c39_231_l0_c0_i9   ),
        .O1   (O1_c39_231_l0_c0_i9   ),
        .O2   (O2_c39_231_l0_c0_i9   ),
        .CY0  (CY0_c39_231_l0_c0_i9  ),
        .CY1  (CY1_c39_231_l0_c0_i9  ),
        .PROP0(PROP0_c39_231_l0_c0_i9),
        .PROP1(PROP1_c39_231_l0_c0_i9));
    
    assign C0_c39_231_l0_c0_i9 = {l0_c0_i8, layer0_col22[7:0]};
    assign C1_c39_231_l0_c0_i9 = layer0_col23[2:0];
    
    assign layer1_col22[0]   = O0_c39_231_l0_c0_i9;
    assign layer1_col23[2:0] = O1_c39_231_l0_c0_i9;
    assign layer1_col24[1:0] = O2_c39_231_l0_c0_i9;
    
    assign CLA_c39_231_l0_c0_i9  = COUT_LA_l0_c0_s2[0];
    assign CY_LA_l0_c0_s2[3:2]   = CY0_c39_231_l0_c0_i9;
    assign PROP_LA_l0_c0_s2[3:2] = PROP0_c39_231_l0_c0_i9;
    
    // GPC0 in layer0: (4,13 : 3,4,1) at column 24
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l0_f0(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l0_f0   ),
        .C1   (C1_c413_341_l0_f0   ),
        .CLA  (CLA_c413_341_l0_f0  ),
        .O0   (O0_c413_341_l0_f0   ),
        .O1   (O1_c413_341_l0_f0   ),
        .O2   (O2_c413_341_l0_f0   ),
        .CY0  (CY0_c413_341_l0_f0  ),
        .PROP0(PROP0_c413_341_l0_f0),
        .CY1  (CY1_c413_341_l0_f0  ),
        .PROP1(PROP1_c413_341_l0_f0));
    
    assign C0_c413_341_l0_f0 = layer0_col24[12:0];
    assign C1_c413_341_l0_f0 = layer0_col25[3:0];
    
    assign layer1_col24[2]   = O0_c413_341_l0_f0;
    assign layer1_col25[3:0] = O1_c413_341_l0_f0;
    assign layer1_col26[2:0] = O2_c413_341_l0_f0;
    
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

    assign CLA_c413_341_l0_f0[0] = COUT_LA_l0_f0[0];
    assign CLA_c413_341_l0_f0[1] = COUT_LA_l0_f0[2];
    assign CIN_LA_l0_f0          = C0_c413_341_l0_f0[8];
    assign CY_LA_l0_f0[2:0]      = CY0_c413_341_l0_f0;
    assign CY_LA_l0_f0[6:4]      = CY1_c413_341_l0_f0;
    assign PROP_LA_l0_f0[2:0]    = PROP0_c413_341_l0_f0;
    assign PROP_LA_l0_f0[6:4]    = PROP1_c413_341_l0_f0;
    assign PROP_LA_l0_f0[3]      = 1'b0;
    assign CY_LA_l0_f0[3]        = 1'b0;
    
    // GPC1 in layer0: (3,9 : 2,3,1) at column 25
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l0_f1(
        .clk  (clk                ),
        .C0   (C0_c39_231_l0_f1   ),
        .C1   (C1_c39_231_l0_f1   ),
        .CLA  (CLA_c39_231_l0_f1  ),
        .O0   (O0_c39_231_l0_f1   ),
        .O1   (O1_c39_231_l0_f1   ),
        .O2   (O2_c39_231_l0_f1   ),
        .CY0  (CY0_c39_231_l0_f1  ),
        .CY1  (CY1_c39_231_l0_f1  ),
        .PROP0(PROP0_c39_231_l0_f1),
        .PROP1(PROP1_c39_231_l0_f1));
    
    assign C0_c39_231_l0_f1 = layer0_col25[12:4];
    assign C1_c39_231_l0_f1 = layer0_col26[2:0];
    
    assign layer1_col25[4]   = O0_c39_231_l0_f1;
    assign layer1_col26[5:3] = O1_c39_231_l0_f1;
    assign layer1_col27[1:0] = O2_c39_231_l0_f1;
    
    // GPC2 in layer0: (4,13 : 3,4,1) at column 27
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l0_f2(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l0_f2   ),
        .C1   (C1_c413_341_l0_f2   ),
        .CLA  (CLA_c413_341_l0_f2  ),
        .O0   (O0_c413_341_l0_f2   ),
        .O1   (O1_c413_341_l0_f2   ),
        .O2   (O2_c413_341_l0_f2   ),
        .CY0  (CY0_c413_341_l0_f2  ),
        .PROP0(PROP0_c413_341_l0_f2),
        .CY1  (CY1_c413_341_l0_f2  ),
        .PROP1(PROP1_c413_341_l0_f2));
    
    assign C0_c413_341_l0_f2 = layer0_col27[12:0];
    assign C1_c413_341_l0_f2 = layer0_col28[3:0];
    
    assign layer1_col27[2]   = O0_c413_341_l0_f2;
    assign layer1_col28[3:0] = O1_c413_341_l0_f2;
    assign layer1_col29[2:0] = O2_c413_341_l0_f2;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f2_inst0 (
        .COUTB(COUT_LA_l0_f2[0]),
        .COUTD(COUT_LA_l0_f2[1]),
        .COUTF(COUT_LA_l0_f2[2]),
        .COUTH(COUT_LA_l0_f2[3]),
        .CIN  (CIN_LA_l0_f2    ),
        .CYA  (CY_LA_l0_f2[0]  ),
        .CYB  (CY_LA_l0_f2[1]  ),
        .CYC  (CY_LA_l0_f2[2]  ),
        .CYD  (CY_LA_l0_f2[3]  ),
        .CYE  (CY_LA_l0_f2[4]  ),
        .CYF  (CY_LA_l0_f2[5]  ),
        .CYG  (CY_LA_l0_f2[6]  ),
        .CYH  (CY_LA_l0_f2[7]  ),
        .PROPA(PROP_LA_l0_f2[0]),
        .PROPB(PROP_LA_l0_f2[1]),
        .PROPC(PROP_LA_l0_f2[2]),
        .PROPD(PROP_LA_l0_f2[3]),
        .PROPE(PROP_LA_l0_f2[4]),
        .PROPF(PROP_LA_l0_f2[5]),
        .PROPG(PROP_LA_l0_f2[6]),
        .PROPH(PROP_LA_l0_f2[7]));

    assign CLA_c413_341_l0_f2[0] = COUT_LA_l0_f2[0];
    assign CLA_c413_341_l0_f2[1] = COUT_LA_l0_f2[2];
    assign CIN_LA_l0_f2          = C0_c413_341_l0_f2[8];
    assign CY_LA_l0_f2[2:0]      = CY0_c413_341_l0_f2;
    assign CY_LA_l0_f2[6:4]      = CY1_c413_341_l0_f2;
    assign PROP_LA_l0_f2[2:0]    = PROP0_c413_341_l0_f2;
    assign PROP_LA_l0_f2[6:4]    = PROP1_c413_341_l0_f2;
    assign PROP_LA_l0_f2[3]      = 1'b0;
    assign CY_LA_l0_f2[3]        = 1'b0;
    
    // GPC3 in layer0: (3,9 : 2,3,1) at column 28
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l0_f3(
        .clk  (clk                ),
        .C0   (C0_c39_231_l0_f3   ),
        .C1   (C1_c39_231_l0_f3   ),
        .CLA  (CLA_c39_231_l0_f3  ),
        .O0   (O0_c39_231_l0_f3   ),
        .O1   (O1_c39_231_l0_f3   ),
        .O2   (O2_c39_231_l0_f3   ),
        .CY0  (CY0_c39_231_l0_f3  ),
        .CY1  (CY1_c39_231_l0_f3  ),
        .PROP0(PROP0_c39_231_l0_f3),
        .PROP1(PROP1_c39_231_l0_f3));
    
    assign C0_c39_231_l0_f3 = layer0_col28[12:4];
    assign C1_c39_231_l0_f3 = layer0_col29[2:0];
    
    assign layer1_col28[4]   = O0_c39_231_l0_f3;
    assign layer1_col29[5:3] = O1_c39_231_l0_f3;
    assign layer1_col30[1:0] = O2_c39_231_l0_f3;
    
    // GPC4 in layer0: (4,13 : 3,4,1) at column 30
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l0_f4(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l0_f4   ),
        .C1   (C1_c413_341_l0_f4   ),
        .CLA  (CLA_c413_341_l0_f4  ),
        .O0   (O0_c413_341_l0_f4   ),
        .O1   (O1_c413_341_l0_f4   ),
        .O2   (O2_c413_341_l0_f4   ),
        .CY0  (CY0_c413_341_l0_f4  ),
        .PROP0(PROP0_c413_341_l0_f4),
        .CY1  (CY1_c413_341_l0_f4  ),
        .PROP1(PROP1_c413_341_l0_f4));
    
    assign C0_c413_341_l0_f4 = layer0_col30[12:0];
    assign C1_c413_341_l0_f4 = layer0_col31[3:0];
    
    assign layer1_col30[2]   = O0_c413_341_l0_f4;
    assign layer1_col31[3:0] = O1_c413_341_l0_f4;
    assign layer1_col32[2:0] = O2_c413_341_l0_f4;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f4_inst0 (
        .COUTB(COUT_LA_l0_f4[0]),
        .COUTD(COUT_LA_l0_f4[1]),
        .COUTF(COUT_LA_l0_f4[2]),
        .COUTH(COUT_LA_l0_f4[3]),
        .CIN  (CIN_LA_l0_f4    ),
        .CYA  (CY_LA_l0_f4[0]  ),
        .CYB  (CY_LA_l0_f4[1]  ),
        .CYC  (CY_LA_l0_f4[2]  ),
        .CYD  (CY_LA_l0_f4[3]  ),
        .CYE  (CY_LA_l0_f4[4]  ),
        .CYF  (CY_LA_l0_f4[5]  ),
        .CYG  (CY_LA_l0_f4[6]  ),
        .CYH  (CY_LA_l0_f4[7]  ),
        .PROPA(PROP_LA_l0_f4[0]),
        .PROPB(PROP_LA_l0_f4[1]),
        .PROPC(PROP_LA_l0_f4[2]),
        .PROPD(PROP_LA_l0_f4[3]),
        .PROPE(PROP_LA_l0_f4[4]),
        .PROPF(PROP_LA_l0_f4[5]),
        .PROPG(PROP_LA_l0_f4[6]),
        .PROPH(PROP_LA_l0_f4[7]));

    assign CLA_c413_341_l0_f4[0] = COUT_LA_l0_f4[0];
    assign CLA_c413_341_l0_f4[1] = COUT_LA_l0_f4[2];
    assign CIN_LA_l0_f4          = C0_c413_341_l0_f4[8];
    assign CY_LA_l0_f4[2:0]      = CY0_c413_341_l0_f4;
    assign CY_LA_l0_f4[6:4]      = CY1_c413_341_l0_f4;
    assign PROP_LA_l0_f4[2:0]    = PROP0_c413_341_l0_f4;
    assign PROP_LA_l0_f4[6:4]    = PROP1_c413_341_l0_f4;
    assign PROP_LA_l0_f4[3]      = 1'b0;
    assign CY_LA_l0_f4[3]        = 1'b0;
    
    // GPC5 in layer0: (3,9 : 2,3,1) at column 31
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l0_f5(
        .clk  (clk                ),
        .C0   (C0_c39_231_l0_f5   ),
        .C1   (C1_c39_231_l0_f5   ),
        .CLA  (CLA_c39_231_l0_f5  ),
        .O0   (O0_c39_231_l0_f5   ),
        .O1   (O1_c39_231_l0_f5   ),
        .O2   (O2_c39_231_l0_f5   ),
        .CY0  (CY0_c39_231_l0_f5  ),
        .CY1  (CY1_c39_231_l0_f5  ),
        .PROP0(PROP0_c39_231_l0_f5),
        .PROP1(PROP1_c39_231_l0_f5));
    
    assign C0_c39_231_l0_f5 = layer0_col31[12:4];
    assign C1_c39_231_l0_f5 = layer0_col32[2:0];
    
    assign layer1_col31[4]   = O0_c39_231_l0_f5;
    assign layer1_col32[5:3] = O1_c39_231_l0_f5;
    assign layer1_col33[1:0] = O2_c39_231_l0_f5;
    
    // GPC6 in layer0: (4,13 : 3,4,1) at column 33
    
    c413_341 #(.OUTREG("FALSE"),
               .LEAVEC("FALSE"))
    c413_341_l0_f6(
        .clk  (clk                 ),
        .C0   (C0_c413_341_l0_f6   ),
        .C1   (C1_c413_341_l0_f6   ),
        .CLA  (CLA_c413_341_l0_f6  ),
        .O0   (O0_c413_341_l0_f6   ),
        .O1   (O1_c413_341_l0_f6   ),
        .O2   (O2_c413_341_l0_f6   ),
        .CY0  (CY0_c413_341_l0_f6  ),
        .PROP0(PROP0_c413_341_l0_f6),
        .CY1  (CY1_c413_341_l0_f6  ),
        .PROP1(PROP1_c413_341_l0_f6));
    
    assign C0_c413_341_l0_f6 = layer0_col33[12:0];
    assign C1_c413_341_l0_f6 = layer0_col34[3:0];
    
    assign layer1_col33[2]   = O0_c413_341_l0_f6;
    assign layer1_col34[3:0] = O1_c413_341_l0_f6;
    assign layer1_col35[2:0] = O2_c413_341_l0_f6;
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_f6_inst0 (
        .COUTB(COUT_LA_l0_f6[0]),
        .COUTD(COUT_LA_l0_f6[1]),
        .COUTF(COUT_LA_l0_f6[2]),
        .COUTH(COUT_LA_l0_f6[3]),
        .CIN  (CIN_LA_l0_f6    ),
        .CYA  (CY_LA_l0_f6[0]  ),
        .CYB  (CY_LA_l0_f6[1]  ),
        .CYC  (CY_LA_l0_f6[2]  ),
        .CYD  (CY_LA_l0_f6[3]  ),
        .CYE  (CY_LA_l0_f6[4]  ),
        .CYF  (CY_LA_l0_f6[5]  ),
        .CYG  (CY_LA_l0_f6[6]  ),
        .CYH  (CY_LA_l0_f6[7]  ),
        .PROPA(PROP_LA_l0_f6[0]),
        .PROPB(PROP_LA_l0_f6[1]),
        .PROPC(PROP_LA_l0_f6[2]),
        .PROPD(PROP_LA_l0_f6[3]),
        .PROPE(PROP_LA_l0_f6[4]),
        .PROPF(PROP_LA_l0_f6[5]),
        .PROPG(PROP_LA_l0_f6[6]),
        .PROPH(PROP_LA_l0_f6[7]));

    assign CLA_c413_341_l0_f6[0] = COUT_LA_l0_f6[0];
    assign CLA_c413_341_l0_f6[1] = COUT_LA_l0_f6[2];
    assign CIN_LA_l0_f6          = C0_c413_341_l0_f6[8];
    assign CY_LA_l0_f6[2:0]      = CY0_c413_341_l0_f6;
    assign CY_LA_l0_f6[6:4]      = CY1_c413_341_l0_f6;
    assign PROP_LA_l0_f6[2:0]    = PROP0_c413_341_l0_f6;
    assign PROP_LA_l0_f6[6:4]    = PROP1_c413_341_l0_f6;
    assign PROP_LA_l0_f6[3]      = 1'b0;
    assign CY_LA_l0_f6[3]        = 1'b0;
    
    // GPC chain1 in layer0:
    // -- (3,9 : 2,3,1) at column 34
    // -- (3,9 : 2,3,1) at column 36
    // -- (3,9 : 2,3,1) at column 38
    // -- (3,9 : 2,3,1) at column 40
    // -- (1,5 : 3] at column 42
    // -- (1,5 : 3] at column 44
    // -- (1,5 : 3] at column 46
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c1_s0_inst0 (
        .COUTB(COUT_LA_l0_c1_s0[0]),
        .COUTD(COUT_LA_l0_c1_s0[1]),
        .COUTF(COUT_LA_l0_c1_s0[2]),
        .COUTH(COUT_LA_l0_c1_s0[3]),
        .CIN  (CIN_LA_l0_c1_s0    ),
        .CYA  (CY_LA_l0_c1_s0[0]  ),
        .CYB  (CY_LA_l0_c1_s0[1]  ),
        .CYC  (CY_LA_l0_c1_s0[2]  ),
        .CYD  (CY_LA_l0_c1_s0[3]  ),
        .CYE  (CY_LA_l0_c1_s0[4]  ),
        .CYF  (CY_LA_l0_c1_s0[5]  ),
        .CYG  (CY_LA_l0_c1_s0[6]  ),
        .CYH  (CY_LA_l0_c1_s0[7]  ),
        .PROPA(PROP_LA_l0_c1_s0[0]),
        .PROPB(PROP_LA_l0_c1_s0[1]),
        .PROPC(PROP_LA_l0_c1_s0[2]),
        .PROPD(PROP_LA_l0_c1_s0[3]),
        .PROPE(PROP_LA_l0_c1_s0[4]),
        .PROPF(PROP_LA_l0_c1_s0[5]),
        .PROPG(PROP_LA_l0_c1_s0[6]),
        .PROPH(PROP_LA_l0_c1_s0[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c1_s1_inst0 (
        .COUTB(COUT_LA_l0_c1_s1[0]),
        .COUTD(COUT_LA_l0_c1_s1[1]),
        .COUTF(COUT_LA_l0_c1_s1[2]),
        .COUTH(COUT_LA_l0_c1_s1[3]),
        .CIN  (CIN_LA_l0_c1_s1    ),
        .CYA  (CY_LA_l0_c1_s1[0]  ),
        .CYB  (CY_LA_l0_c1_s1[1]  ),
        .CYC  (CY_LA_l0_c1_s1[2]  ),
        .CYD  (CY_LA_l0_c1_s1[3]  ),
        .CYE  (CY_LA_l0_c1_s1[4]  ),
        .CYF  (CY_LA_l0_c1_s1[5]  ),
        .CYG  (CY_LA_l0_c1_s1[6]  ),
        .CYH  (CY_LA_l0_c1_s1[7]  ),
        .PROPA(PROP_LA_l0_c1_s1[0]),
        .PROPB(PROP_LA_l0_c1_s1[1]),
        .PROPC(PROP_LA_l0_c1_s1[2]),
        .PROPD(PROP_LA_l0_c1_s1[3]),
        .PROPE(PROP_LA_l0_c1_s1[4]),
        .PROPF(PROP_LA_l0_c1_s1[5]),
        .PROPG(PROP_LA_l0_c1_s1[6]),
        .PROPH(PROP_LA_l0_c1_s1[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c1_s2_inst0 (
        .COUTB(COUT_LA_l0_c1_s2[0]),
        .COUTD(COUT_LA_l0_c1_s2[1]),
        .COUTF(COUT_LA_l0_c1_s2[2]),
        .COUTH(COUT_LA_l0_c1_s2[3]),
        .CIN  (CIN_LA_l0_c1_s2    ),
        .CYA  (CY_LA_l0_c1_s2[0]  ),
        .CYB  (CY_LA_l0_c1_s2[1]  ),
        .CYC  (CY_LA_l0_c1_s2[2]  ),
        .CYD  (CY_LA_l0_c1_s2[3]  ),
        .CYE  (CY_LA_l0_c1_s2[4]  ),
        .CYF  (CY_LA_l0_c1_s2[5]  ),
        .CYG  (CY_LA_l0_c1_s2[6]  ),
        .CYH  (CY_LA_l0_c1_s2[7]  ),
        .PROPA(PROP_LA_l0_c1_s2[0]),
        .PROPB(PROP_LA_l0_c1_s2[1]),
        .PROPC(PROP_LA_l0_c1_s2[2]),
        .PROPD(PROP_LA_l0_c1_s2[3]),
        .PROPE(PROP_LA_l0_c1_s2[4]),
        .PROPF(PROP_LA_l0_c1_s2[5]),
        .PROPG(PROP_LA_l0_c1_s2[6]),
        .PROPH(PROP_LA_l0_c1_s2[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c1_s3_inst0 (
        .COUTB(COUT_LA_l0_c1_s3[0]),
        .COUTD(COUT_LA_l0_c1_s3[1]),
        .COUTF(COUT_LA_l0_c1_s3[2]),
        .COUTH(COUT_LA_l0_c1_s3[3]),
        .CIN  (CIN_LA_l0_c1_s3    ),
        .CYA  (CY_LA_l0_c1_s3[0]  ),
        .CYB  (CY_LA_l0_c1_s3[1]  ),
        .CYC  (CY_LA_l0_c1_s3[2]  ),
        .CYD  (CY_LA_l0_c1_s3[3]  ),
        .CYE  (CY_LA_l0_c1_s3[4]  ),
        .CYF  (CY_LA_l0_c1_s3[5]  ),
        .CYG  (CY_LA_l0_c1_s3[6]  ),
        .CYH  (CY_LA_l0_c1_s3[7]  ),
        .PROPA(PROP_LA_l0_c1_s3[0]),
        .PROPB(PROP_LA_l0_c1_s3[1]),
        .PROPC(PROP_LA_l0_c1_s3[2]),
        .PROPD(PROP_LA_l0_c1_s3[3]),
        .PROPE(PROP_LA_l0_c1_s3[4]),
        .PROPF(PROP_LA_l0_c1_s3[5]),
        .PROPG(PROP_LA_l0_c1_s3[6]),
        .PROPH(PROP_LA_l0_c1_s3[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c1_s4_inst0 (
        .COUTB(COUT_LA_l0_c1_s4[0]),
        .COUTD(COUT_LA_l0_c1_s4[1]),
        .COUTF(COUT_LA_l0_c1_s4[2]),
        .COUTH(COUT_LA_l0_c1_s4[3]),
        .CIN  (CIN_LA_l0_c1_s4    ),
        .CYA  (CY_LA_l0_c1_s4[0]  ),
        .CYB  (CY_LA_l0_c1_s4[1]  ),
        .CYC  (CY_LA_l0_c1_s4[2]  ),
        .CYD  (CY_LA_l0_c1_s4[3]  ),
        .CYE  (CY_LA_l0_c1_s4[4]  ),
        .CYF  (CY_LA_l0_c1_s4[5]  ),
        .CYG  (CY_LA_l0_c1_s4[6]  ),
        .CYH  (CY_LA_l0_c1_s4[7]  ),
        .PROPA(PROP_LA_l0_c1_s4[0]),
        .PROPB(PROP_LA_l0_c1_s4[1]),
        .PROPC(PROP_LA_l0_c1_s4[2]),
        .PROPD(PROP_LA_l0_c1_s4[3]),
        .PROPE(PROP_LA_l0_c1_s4[4]),
        .PROPF(PROP_LA_l0_c1_s4[5]),
        .PROPG(PROP_LA_l0_c1_s4[6]),
        .PROPH(PROP_LA_l0_c1_s4[7]));

    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c1_i0(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c1_i0   ),
        .C1   (C1_c39_231_l0_c1_i0   ),
        .CLA  (CLA_c39_231_l0_c1_i0  ),
        .O0   (O0_c39_231_l0_c1_i0   ),
        .O1   (O1_c39_231_l0_c1_i0   ),
        .O2   (O2_c39_231_l0_c1_i0   ),
        .CY0  (CY0_c39_231_l0_c1_i0  ),
        .CY1  (CY1_c39_231_l0_c1_i0  ),
        .PROP0(PROP0_c39_231_l0_c1_i0),
        .PROP1(PROP1_c39_231_l0_c1_i0));
    
    assign C0_c39_231_l0_c1_i0 = layer0_col34[12:4];
    assign C1_c39_231_l0_c1_i0 = layer0_col35[2:0];
    
    assign layer1_col34[4]   = O0_c39_231_l0_c1_i0;
    assign layer1_col35[5:3] = O1_c39_231_l0_c1_i0;
    assign layer1_col36[1]   = O2_c39_231_l0_c1_i0[0];
    
    assign CLA_c39_231_l0_c1_i0  = COUT_LA_l0_c1_s0[0];
    assign l0_c1_i0              = COUT_LA_l0_c1_s1[0];
    assign CY_LA_l0_c1_s0[1:0]   = CY0_c39_231_l0_c1_i0;
    assign PROP_LA_l0_c1_s0[1:0] = PROP0_c39_231_l0_c1_i0;
    assign CY_LA_l0_c1_s1[1:0]   = CY1_c39_231_l0_c1_i0;
    assign PROP_LA_l0_c1_s1[1:0] = PROP1_c39_231_l0_c1_i0;
    assign CIN_LA_l0_c1_s1       = layer0_col35[1];
    
    assign CIN_LA_l0_c1_s0    = C0_c39_231_l0_c1_i0[8];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c1_i1(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c1_i1   ),
        .C1   (C1_c39_231_l0_c1_i1   ),
        .CLA  (CLA_c39_231_l0_c1_i1  ),
        .O0   (O0_c39_231_l0_c1_i1   ),
        .O1   (O1_c39_231_l0_c1_i1   ),
        .O2   (O2_c39_231_l0_c1_i1   ),
        .CY0  (CY0_c39_231_l0_c1_i1  ),
        .CY1  (CY1_c39_231_l0_c1_i1  ),
        .PROP0(PROP0_c39_231_l0_c1_i1),
        .PROP1(PROP1_c39_231_l0_c1_i1));
    
    assign C0_c39_231_l0_c1_i1 = {l0_c1_i0, layer0_col36[7:0]};
    assign C1_c39_231_l0_c1_i1 = layer0_col37[2:0];
    
    assign layer1_col36[0]   = O0_c39_231_l0_c1_i1;
    assign layer1_col37[2:0] = O1_c39_231_l0_c1_i1;
    assign layer1_col38[1]   = O2_c39_231_l0_c1_i1[0];
    
    assign CLA_c39_231_l0_c1_i1  = COUT_LA_l0_c1_s1[0];
    assign l0_c1_i1              = COUT_LA_l0_c1_s2[0];
    assign CY_LA_l0_c1_s1[3:2]   = CY0_c39_231_l0_c1_i1;
    assign PROP_LA_l0_c1_s1[3:2] = PROP0_c39_231_l0_c1_i1;
    assign CY_LA_l0_c1_s2[1:0]   = CY1_c39_231_l0_c1_i1;
    assign PROP_LA_l0_c1_s2[1:0] = PROP1_c39_231_l0_c1_i1;
    assign CIN_LA_l0_c1_s2       = layer0_col37[1];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c1_i2(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c1_i2   ),
        .C1   (C1_c39_231_l0_c1_i2   ),
        .CLA  (CLA_c39_231_l0_c1_i2  ),
        .O0   (O0_c39_231_l0_c1_i2   ),
        .O1   (O1_c39_231_l0_c1_i2   ),
        .O2   (O2_c39_231_l0_c1_i2   ),
        .CY0  (CY0_c39_231_l0_c1_i2  ),
        .CY1  (CY1_c39_231_l0_c1_i2  ),
        .PROP0(PROP0_c39_231_l0_c1_i2),
        .PROP1(PROP1_c39_231_l0_c1_i2));
    
    assign C0_c39_231_l0_c1_i2 = {l0_c1_i1, layer0_col38[7:0]};
    assign C1_c39_231_l0_c1_i2 = layer0_col39[2:0];
    
    assign layer1_col38[0]   = O0_c39_231_l0_c1_i2;
    assign layer1_col39[2:0] = O1_c39_231_l0_c1_i2;
    assign layer1_col40[1]   = O2_c39_231_l0_c1_i2[0];
    
    assign CLA_c39_231_l0_c1_i2  = COUT_LA_l0_c1_s2[0];
    assign l0_c1_i2              = COUT_LA_l0_c1_s3[0];
    assign CY_LA_l0_c1_s2[3:2]   = CY0_c39_231_l0_c1_i2;
    assign PROP_LA_l0_c1_s2[3:2] = PROP0_c39_231_l0_c1_i2;
    assign CY_LA_l0_c1_s3[1:0]   = CY1_c39_231_l0_c1_i2;
    assign PROP_LA_l0_c1_s3[1:0] = PROP1_c39_231_l0_c1_i2;
    assign CIN_LA_l0_c1_s3       = layer0_col39[1];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c1_i3(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c1_i3   ),
        .C1   (C1_c39_231_l0_c1_i3   ),
        .CLA  (CLA_c39_231_l0_c1_i3  ),
        .O0   (O0_c39_231_l0_c1_i3   ),
        .O1   (O1_c39_231_l0_c1_i3   ),
        .O2   (O2_c39_231_l0_c1_i3   ),
        .CY0  (CY0_c39_231_l0_c1_i3  ),
        .CY1  (CY1_c39_231_l0_c1_i3  ),
        .PROP0(PROP0_c39_231_l0_c1_i3),
        .PROP1(PROP1_c39_231_l0_c1_i3));
    
    assign C0_c39_231_l0_c1_i3 = {l0_c1_i2, layer0_col40[7:0]};
    assign C1_c39_231_l0_c1_i3 = layer0_col41[2:0];
    
    assign layer1_col40[0]   = O0_c39_231_l0_c1_i3;
    assign layer1_col41[2:0] = O1_c39_231_l0_c1_i3;
    assign layer1_col42[1]   = O2_c39_231_l0_c1_i3[0];
    
    assign CLA_c39_231_l0_c1_i3  = COUT_LA_l0_c1_s3[0];
    assign l0_c1_i3              = COUT_LA_l0_c1_s4[0];
    assign CY_LA_l0_c1_s3[3:2]   = CY0_c39_231_l0_c1_i3;
    assign PROP_LA_l0_c1_s3[3:2] = PROP0_c39_231_l0_c1_i3;
    assign CY_LA_l0_c1_s4[1:0]   = CY1_c39_231_l0_c1_i3;
    assign PROP_LA_l0_c1_s4[1:0] = PROP1_c39_231_l0_c1_i3;
    assign CIN_LA_l0_c1_s4       = layer0_col41[1];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i4  ),
        .C1  (C1_c15_3_l0_c1_i4  ),
        .CLA (CLA_c15_3_l0_c1_i4 ),
        .O   (O_c15_3_l0_c1_i4   ),
        .CY  (CY_c15_3_l0_c1_i4  ),
        .PROP(PROP_c15_3_l0_c1_i4));
    
    assign C0_c15_3_l0_c1_i4 = {l0_c1_i3, layer0_col42[3:0]};
    assign C1_c15_3_l0_c1_i4 = layer0_col43[0];
    
    assign layer1_col42[0] = O_c15_3_l0_c1_i4[0];
    assign layer1_col43[0] = O_c15_3_l0_c1_i4[1];
    
    assign l0_c1_i4              = COUT_LA_l0_c1_s4[1];
    assign CY_LA_l0_c1_s4[3:2]   = CY_c15_3_l0_c1_i4;
    assign PROP_LA_l0_c1_s4[3:2] = PROP_c15_3_l0_c1_i4;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i5(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i5  ),
        .C1  (C1_c15_3_l0_c1_i5  ),
        .CLA (CLA_c15_3_l0_c1_i5 ),
        .O   (O_c15_3_l0_c1_i5   ),
        .CY  (CY_c15_3_l0_c1_i5  ),
        .PROP(PROP_c15_3_l0_c1_i5));
    
    assign C0_c15_3_l0_c1_i5 = {l0_c1_i4, layer0_col44[3:0]};
    assign C1_c15_3_l0_c1_i5 = layer0_col45[0];
    
    assign layer1_col44[0] = O_c15_3_l0_c1_i5[0];
    assign layer1_col45[0] = O_c15_3_l0_c1_i5[1];
    
    assign l0_c1_i5              = COUT_LA_l0_c1_s4[2];
    assign CY_LA_l0_c1_s4[5:4]   = CY_c15_3_l0_c1_i5;
    assign PROP_LA_l0_c1_s4[5:4] = PROP_c15_3_l0_c1_i5;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l0_c1_i6(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i6  ),
        .C1  (C1_c15_3_l0_c1_i6  ),
        .CLA (CLA_c15_3_l0_c1_i6 ),
        .O   (O_c15_3_l0_c1_i6   ),
        .CY  (CY_c15_3_l0_c1_i6  ),
        .PROP(PROP_c15_3_l0_c1_i6));
    
    assign C0_c15_3_l0_c1_i6 = {l0_c1_i5, layer0_col46[3:0]};
    assign C1_c15_3_l0_c1_i6 = layer0_col47[0];
    
    assign layer1_col46[0] = O_c15_3_l0_c1_i6[0];
    assign layer1_col47[0] = O_c15_3_l0_c1_i6[1];
    assign layer1_col48[0] = O_c15_3_l0_c1_i6[2];
    
    assign l0_c1_i6              = COUT_LA_l0_c1_s4[3];
    assign CY_LA_l0_c1_s4[7:6]   = CY_c15_3_l0_c1_i6;
    assign PROP_LA_l0_c1_s4[7:6] = PROP_c15_3_l0_c1_i6;
    
    // GPC chain2 in layer0:
    // -- (1,5 : 3] at column 48
    // -- (3 : 2] at column 50
    // -- (3 : 2] at column 51
    // -- (3 : 2] at column 52
    // -- (3 : 2] at column 53
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c2_s0_inst0 (
        .COUTB(COUT_LA_l0_c2_s0[0]),
        .COUTD(COUT_LA_l0_c2_s0[1]),
        .COUTF(COUT_LA_l0_c2_s0[2]),
        .COUTH(COUT_LA_l0_c2_s0[3]),
        .CIN  (CIN_LA_l0_c2_s0    ),
        .CYA  (CY_LA_l0_c2_s0[0]  ),
        .CYB  (CY_LA_l0_c2_s0[1]  ),
        .CYC  (CY_LA_l0_c2_s0[2]  ),
        .CYD  (CY_LA_l0_c2_s0[3]  ),
        .CYE  (CY_LA_l0_c2_s0[4]  ),
        .CYF  (CY_LA_l0_c2_s0[5]  ),
        .CYG  (CY_LA_l0_c2_s0[6]  ),
        .CYH  (CY_LA_l0_c2_s0[7]  ),
        .PROPA(PROP_LA_l0_c2_s0[0]),
        .PROPB(PROP_LA_l0_c2_s0[1]),
        .PROPC(PROP_LA_l0_c2_s0[2]),
        .PROPD(PROP_LA_l0_c2_s0[3]),
        .PROPE(PROP_LA_l0_c2_s0[4]),
        .PROPF(PROP_LA_l0_c2_s0[5]),
        .PROPG(PROP_LA_l0_c2_s0[6]),
        .PROPH(PROP_LA_l0_c2_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l0_c2_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c2_i0  ),
        .C1  (C1_c15_3_l0_c2_i0  ),
        .CLA (CLA_c15_3_l0_c2_i0 ),
        .O   (O_c15_3_l0_c2_i0   ),
        .CY  (CY_c15_3_l0_c2_i0  ),
        .PROP(PROP_c15_3_l0_c2_i0));
    
    assign C0_c15_3_l0_c2_i0 = layer0_col48[4:0];
    assign C1_c15_3_l0_c2_i0 = layer0_col49[0];
    
    assign layer1_col48[1] = O_c15_3_l0_c2_i0[0];
    assign layer1_col49[0] = O_c15_3_l0_c2_i0[1];
    
    assign l0_c2_i0              = COUT_LA_l0_c2_s0[0];
    assign CY_LA_l0_c2_s0[1:0]   = CY_c15_3_l0_c2_i0;
    assign PROP_LA_l0_c2_s0[1:0] = PROP_c15_3_l0_c2_i0;
    
    assign CIN_LA_l0_c2_s0    = C0_c15_3_l0_c2_i0[4];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i1  ),
        .O   (O_c3_2_l0_c2_i1   ),
        .CY  (CY_c3_2_l0_c2_i1  ),
        .PROP(PROP_c3_2_l0_c2_i1));
    
    assign C0_c3_2_l0_c2_i1 = {l0_c2_i0, layer0_col50[1:0]};
    
    assign layer1_col50[0] = O_c3_2_l0_c2_i1[0];
    
    assign l0_c2_i1            = O_c3_2_l0_c2_i1[1];
    assign CY_LA_l0_c2_s0[2]   = CY_c3_2_l0_c2_i1;
    assign PROP_LA_l0_c2_s0[2] = PROP_c3_2_l0_c2_i1;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i2(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i2  ),
        .O   (O_c3_2_l0_c2_i2   ),
        .CY  (CY_c3_2_l0_c2_i2  ),
        .PROP(PROP_c3_2_l0_c2_i2));
    
    assign C0_c3_2_l0_c2_i2 = {l0_c2_i1, layer0_col51[1:0]};
    
    assign layer1_col51[0] = O_c3_2_l0_c2_i2[0];
    
    assign l0_c2_i2            = COUT_LA_l0_c2_s0[1];
    assign CY_LA_l0_c2_s0[3]   = CY_c3_2_l0_c2_i2;
    assign PROP_LA_l0_c2_s0[3] = PROP_c3_2_l0_c2_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i3(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i3  ),
        .O   (O_c3_2_l0_c2_i3   ),
        .CY  (CY_c3_2_l0_c2_i3  ),
        .PROP(PROP_c3_2_l0_c2_i3));
    
    assign C0_c3_2_l0_c2_i3 = {l0_c2_i2, layer0_col52[1:0]};
    
    assign layer1_col52[0] = O_c3_2_l0_c2_i3[0];
    
    assign l0_c2_i3            = O_c3_2_l0_c2_i3[1];
    assign CY_LA_l0_c2_s0[4]   = CY_c3_2_l0_c2_i3;
    assign PROP_LA_l0_c2_s0[4] = PROP_c3_2_l0_c2_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c2_i4(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i4  ),
        .O   (O_c3_2_l0_c2_i4   ),
        .CY  (CY_c3_2_l0_c2_i4  ),
        .PROP(PROP_c3_2_l0_c2_i4));
    
    assign C0_c3_2_l0_c2_i4 = {l0_c2_i3, layer0_col53[1:0]};
    
    assign layer1_col53[0] = O_c3_2_l0_c2_i4[0];
    assign layer1_col54[0] = O_c3_2_l0_c2_i4[1];
    
    assign l0_c2_i4            = COUT_LA_l0_c2_s0[2];
    assign CY_LA_l0_c2_s0[5]   = CY_c3_2_l0_c2_i4;
    assign PROP_LA_l0_c2_s0[5] = PROP_c3_2_l0_c2_i4;
    
    // GPC chain3 in layer0:
    // -- (3 : 2] at column 9
    // -- (3 : 2] at column 10
    // -- (1,5 : 3] at column 11
    // -- (1,5 : 3] at column 13
    // -- (1,5 : 3] at column 15
    // -- (1,5 : 3] at column 17
    // -- (1,5 : 3] at column 19
    // -- (3,9 : 2,3,1) at column 21
    // -- (9 : 4,1) at column 23
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l0_c3_s0_inst0 (
        .COUTB(COUT_LA_l0_c3_s0[0]),
        .COUTD(COUT_LA_l0_c3_s0[1]),
        .COUTF(COUT_LA_l0_c3_s0[2]),
        .COUTH(COUT_LA_l0_c3_s0[3]),
        .CIN  (CIN_LA_l0_c3_s0[0] ),
        .CYA  (CY_LA_l0_c3_s0[0]  ),
        .CYB  (CY_LA_l0_c3_s0[1]  ),
        .CYC  (CY_LA_l0_c3_s0[2]  ),
        .CYD  (CY_LA_l0_c3_s0[3]  ),
        .CYE  (CY_LA_l0_c3_s0[4]  ),
        .CYF  (CY_LA_l0_c3_s0[5]  ),
        .CYG  (CY_LA_l0_c3_s0[6]  ),
        .CYH  (CY_LA_l0_c3_s0[7]  ),
        .PROPA(PROP_LA_l0_c3_s0[0]),
        .PROPB(PROP_LA_l0_c3_s0[1]),
        .PROPC(PROP_LA_l0_c3_s0[2]),
        .PROPD(PROP_LA_l0_c3_s0[3]),
        .PROPE(PROP_LA_l0_c3_s0[4]),
        .PROPF(PROP_LA_l0_c3_s0[5]),
        .PROPG(PROP_LA_l0_c3_s0[6]),
        .PROPH(PROP_LA_l0_c3_s0[7]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE" ),
        .LOOKD("TRUE" ),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c3_s0_inst1 (
        .COUTB(COUT_LA_l0_c3_s0[4] ),
        .COUTD(COUT_LA_l0_c3_s0[5] ),
        .COUTF(COUT_LA_l0_c3_s0[6] ),
        .COUTH(COUT_LA_l0_c3_s0[7] ),
        .CIN  (CIN_LA_l0_c3_s0[1]  ),
        .CYA  (CY_LA_l0_c3_s0[8]   ),
        .CYB  (CY_LA_l0_c3_s0[9]   ),
        .CYC  (CY_LA_l0_c3_s0[10]  ),
        .CYD  (CY_LA_l0_c3_s0[11]  ),
        .CYE  (CY_LA_l0_c3_s0[12]  ),
        .CYF  (CY_LA_l0_c3_s0[13]  ),
        .CYG  (CY_LA_l0_c3_s0[14]  ),
        .CYH  (CY_LA_l0_c3_s0[15]  ),
        .PROPA(PROP_LA_l0_c3_s0[8] ),
        .PROPB(PROP_LA_l0_c3_s0[9] ),
        .PROPC(PROP_LA_l0_c3_s0[10]),
        .PROPD(PROP_LA_l0_c3_s0[11]),
        .PROPE(PROP_LA_l0_c3_s0[12]),
        .PROPF(PROP_LA_l0_c3_s0[13]),
        .PROPG(PROP_LA_l0_c3_s0[14]),
        .PROPH(PROP_LA_l0_c3_s0[15]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c3_s1_inst0 (
        .COUTB(COUT_LA_l0_c3_s1[0]),
        .COUTD(COUT_LA_l0_c3_s1[1]),
        .COUTF(COUT_LA_l0_c3_s1[2]),
        .COUTH(COUT_LA_l0_c3_s1[3]),
        .CIN  (CIN_LA_l0_c3_s1    ),
        .CYA  (CY_LA_l0_c3_s1[0]  ),
        .CYB  (CY_LA_l0_c3_s1[1]  ),
        .CYC  (CY_LA_l0_c3_s1[2]  ),
        .CYD  (CY_LA_l0_c3_s1[3]  ),
        .CYE  (CY_LA_l0_c3_s1[4]  ),
        .CYF  (CY_LA_l0_c3_s1[5]  ),
        .CYG  (CY_LA_l0_c3_s1[6]  ),
        .CYH  (CY_LA_l0_c3_s1[7]  ),
        .PROPA(PROP_LA_l0_c3_s1[0]),
        .PROPB(PROP_LA_l0_c3_s1[1]),
        .PROPC(PROP_LA_l0_c3_s1[2]),
        .PROPD(PROP_LA_l0_c3_s1[3]),
        .PROPE(PROP_LA_l0_c3_s1[4]),
        .PROPF(PROP_LA_l0_c3_s1[5]),
        .PROPG(PROP_LA_l0_c3_s1[6]),
        .PROPH(PROP_LA_l0_c3_s1[7]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c3_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c3_i0  ),
        .O   (O_c3_2_l0_c3_i0   ),
        .CY  (CY_c3_2_l0_c3_i0  ),
        .PROP(PROP_c3_2_l0_c3_i0));
    
    assign C0_c3_2_l0_c3_i0 = layer0_col9[3:1];
    
    assign layer1_col9[1]  = O_c3_2_l0_c3_i0[0];
    
    assign l0_c3_i0            = O_c3_2_l0_c3_i0[1];
    assign CY_LA_l0_c3_s0[0]   = CY_c3_2_l0_c3_i0;
    assign PROP_LA_l0_c3_s0[0] = PROP_c3_2_l0_c3_i0;
    
    assign CIN_LA_l0_c3_s0[0] = C0_c3_2_l0_c3_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c3_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c3_i1  ),
        .O   (O_c3_2_l0_c3_i1   ),
        .CY  (CY_c3_2_l0_c3_i1  ),
        .PROP(PROP_c3_2_l0_c3_i1));
    
    assign C0_c3_2_l0_c3_i1 = {l0_c3_i0, layer0_col10[5:4]};
    
    assign layer1_col10[1] = O_c3_2_l0_c3_i1[0];
    
    assign l0_c3_i1            = COUT_LA_l0_c3_s0[0];
    assign CY_LA_l0_c3_s0[1]   = CY_c3_2_l0_c3_i1;
    assign PROP_LA_l0_c3_s0[1] = PROP_c3_2_l0_c3_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c3_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c3_i2  ),
        .C1  (C1_c15_3_l0_c3_i2  ),
        .CLA (CLA_c15_3_l0_c3_i2 ),
        .O   (O_c15_3_l0_c3_i2   ),
        .CY  (CY_c15_3_l0_c3_i2  ),
        .PROP(PROP_c15_3_l0_c3_i2));
    
    assign C0_c15_3_l0_c3_i2 = {l0_c3_i1, layer0_col11[4:1]};
    assign C1_c15_3_l0_c3_i2 = layer0_col12[4];
    
    assign layer1_col11[1] = O_c15_3_l0_c3_i2[0];
    assign layer1_col12[1] = O_c15_3_l0_c3_i2[1];
    
    assign l0_c3_i2              = COUT_LA_l0_c3_s0[1];
    assign CY_LA_l0_c3_s0[3:2]   = CY_c15_3_l0_c3_i2;
    assign PROP_LA_l0_c3_s0[3:2] = PROP_c15_3_l0_c3_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c3_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c3_i3  ),
        .C1  (C1_c15_3_l0_c3_i3  ),
        .CLA (CLA_c15_3_l0_c3_i3 ),
        .O   (O_c15_3_l0_c3_i3   ),
        .CY  (CY_c15_3_l0_c3_i3  ),
        .PROP(PROP_c15_3_l0_c3_i3));
    
    assign C0_c15_3_l0_c3_i3 = {l0_c3_i2, layer0_col13[4:1]};
    assign C1_c15_3_l0_c3_i3 = layer0_col14[4];
    
    assign layer1_col13[1] = O_c15_3_l0_c3_i3[0];
    assign layer1_col14[1] = O_c15_3_l0_c3_i3[1];
    
    assign l0_c3_i3              = COUT_LA_l0_c3_s0[2];
    assign CY_LA_l0_c3_s0[5:4]   = CY_c15_3_l0_c3_i3;
    assign PROP_LA_l0_c3_s0[5:4] = PROP_c15_3_l0_c3_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c3_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c3_i4  ),
        .C1  (C1_c15_3_l0_c3_i4  ),
        .CLA (CLA_c15_3_l0_c3_i4 ),
        .O   (O_c15_3_l0_c3_i4   ),
        .CY  (CY_c15_3_l0_c3_i4  ),
        .PROP(PROP_c15_3_l0_c3_i4));
    
    assign C0_c15_3_l0_c3_i4 = {l0_c3_i3, layer0_col15[4:1]};
    assign C1_c15_3_l0_c3_i4 = layer0_col16[4];
    
    assign layer1_col15[1] = O_c15_3_l0_c3_i4[0];
    assign layer1_col16[1] = O_c15_3_l0_c3_i4[1];
    
    assign l0_c3_i4              = COUT_LA_l0_c3_s0[3];
    assign CY_LA_l0_c3_s0[7:6]   = CY_c15_3_l0_c3_i4;
    assign PROP_LA_l0_c3_s0[7:6] = PROP_c15_3_l0_c3_i4;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c3_i5(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c3_i5  ),
        .C1  (C1_c15_3_l0_c3_i5  ),
        .CLA (CLA_c15_3_l0_c3_i5 ),
        .O   (O_c15_3_l0_c3_i5   ),
        .CY  (CY_c15_3_l0_c3_i5  ),
        .PROP(PROP_c15_3_l0_c3_i5));
    
    assign C0_c15_3_l0_c3_i5 = {l0_c3_i4, layer0_col17[4:1]};
    assign C1_c15_3_l0_c3_i5 = layer0_col18[8];
    
    assign layer1_col17[1] = O_c15_3_l0_c3_i5[0];
    assign layer1_col18[1] = O_c15_3_l0_c3_i5[1];
    
    assign l0_c3_i5              = COUT_LA_l0_c3_s0[4];
    assign CY_LA_l0_c3_s0[9:8]   = CY_c15_3_l0_c3_i5;
    assign PROP_LA_l0_c3_s0[9:8] = PROP_c15_3_l0_c3_i5;
    
    assign CIN_LA_l0_c3_s0[1] = COUT_LA_l0_c3_s0[3];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c3_i6(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c3_i6  ),
        .C1  (C1_c15_3_l0_c3_i6  ),
        .CLA (CLA_c15_3_l0_c3_i6 ),
        .O   (O_c15_3_l0_c3_i6   ),
        .CY  (CY_c15_3_l0_c3_i6  ),
        .PROP(PROP_c15_3_l0_c3_i6));
    
    assign C0_c15_3_l0_c3_i6 = {l0_c3_i5, layer0_col19[6:3]};
    assign C1_c15_3_l0_c3_i6 = layer0_col20[8];
    
    assign layer1_col19[3] = O_c15_3_l0_c3_i6[0];
    assign layer1_col20[2] = O_c15_3_l0_c3_i6[1];
    
    assign l0_c3_i6                = COUT_LA_l0_c3_s0[5];
    assign CY_LA_l0_c3_s0[11:10]   = CY_c15_3_l0_c3_i6;
    assign PROP_LA_l0_c3_s0[11:10] = PROP_c15_3_l0_c3_i6;
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c3_i7(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c3_i7   ),
        .C1   (C1_c39_231_l0_c3_i7   ),
        .CLA  (CLA_c39_231_l0_c3_i7  ),
        .O0   (O0_c39_231_l0_c3_i7   ),
        .O1   (O1_c39_231_l0_c3_i7   ),
        .O2   (O2_c39_231_l0_c3_i7   ),
        .CY0  (CY0_c39_231_l0_c3_i7  ),
        .CY1  (CY1_c39_231_l0_c3_i7  ),
        .PROP0(PROP0_c39_231_l0_c3_i7),
        .PROP1(PROP1_c39_231_l0_c3_i7));
    
    assign C0_c39_231_l0_c3_i7 = {l0_c3_i6, layer0_col21[10:3]};
    assign C1_c39_231_l0_c3_i7 = layer0_col22[10:8];
    
    assign layer1_col21[3]   = O0_c39_231_l0_c3_i7;
    assign layer1_col22[4:2] = O1_c39_231_l0_c3_i7;
    assign layer1_col23[4]   = O2_c39_231_l0_c3_i7[0];
    
    assign CLA_c39_231_l0_c3_i7    = COUT_LA_l0_c3_s0[5];
    assign l0_c3_i7                = COUT_LA_l0_c3_s1[0];
    assign CY_LA_l0_c3_s0[13:12]   = CY0_c39_231_l0_c3_i7;
    assign PROP_LA_l0_c3_s0[13:12] = PROP0_c39_231_l0_c3_i7;
    assign CY_LA_l0_c3_s1[1:0]     = CY1_c39_231_l0_c3_i7;
    assign PROP_LA_l0_c3_s1[1:0]   = PROP1_c39_231_l0_c3_i7;
    assign CIN_LA_l0_c3_s1         = layer0_col22[9];
    
    c9_41 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"))
    c9_41_l0_c3_i8(
        .clk (clk                ),
        .C0  (C0_c9_41_l0_c3_i8  ),
        .CLA (CLA_c9_41_l0_c3_i8 ),
        .O0  (O0_c9_41_l0_c3_i8  ),
        .O1  (O1_c9_41_l0_c3_i8  ),
        .CY  (CY_c9_41_l0_c3_i8  ),
        .PROP(PROP_c9_41_l0_c3_i8));
    
    assign C0_c9_41_l0_c3_i8 = {l0_c3_i7, layer0_col23[10:3]};
    
    assign layer1_col23[3]   = O0_c9_41_l0_c3_i8;
    assign layer1_col24[6:3] = O1_c9_41_l0_c3_i8;
    
    assign l0_c3_i8              = COUT_LA_l0_c3_s1[1];
    assign CY_LA_l0_c3_s1[3:2]   = CY_c9_41_l0_c3_i8;
    assign PROP_LA_l0_c3_s1[3:2] = PROP_c9_41_l0_c3_i8;
    
    // GPC7 in layer0: (9 : 4,1) at column 26
    
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
    
    assign C0_c9_41_l0_f7 = layer0_col26[11:3];
    
    assign layer1_col26[6]   = O0_c9_41_l0_f7;
    assign layer1_col27[6:3] = O1_c9_41_l0_f7;
    
    // GPC8 in layer0: (3,9 : 2,3,1) at column 29
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("FALSE"),
              .POSODD("FALSE"))
    c39_231_l0_f8(
        .clk  (clk                ),
        .C0   (C0_c39_231_l0_f8   ),
        .C1   (C1_c39_231_l0_f8   ),
        .CLA  (CLA_c39_231_l0_f8  ),
        .O0   (O0_c39_231_l0_f8   ),
        .O1   (O1_c39_231_l0_f8   ),
        .O2   (O2_c39_231_l0_f8   ),
        .CY0  (CY0_c39_231_l0_f8  ),
        .CY1  (CY1_c39_231_l0_f8  ),
        .PROP0(PROP0_c39_231_l0_f8),
        .PROP1(PROP1_c39_231_l0_f8));
    
    assign C0_c39_231_l0_f8 = layer0_col29[11:3];
    assign C1_c39_231_l0_f8 = layer0_col30[15:13];
    
    assign layer1_col29[6]   = O0_c39_231_l0_f8;
    assign layer1_col30[5:3] = O1_c39_231_l0_f8;
    assign layer1_col31[6:5] = O2_c39_231_l0_f8;
    
    // GPC9 in layer0: (9 : 4,1) at column 32
    
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
    
    assign C0_c9_41_l0_f9 = layer0_col32[11:3];
    
    assign layer1_col32[6]   = O0_c9_41_l0_f9;
    assign layer1_col33[6:3] = O1_c9_41_l0_f9;
    
    // GPC chain4 in layer0:
    // -- (3,9 : 2,3,1) at column 35
    // -- (3,9 : 2,3,1) at column 37
    // -- (1,5 : 3] at column 39
    // -- (1,5 : 3] at column 41
    // -- (1,5 : 3] at column 43
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c4_s0_inst0 (
        .COUTB(COUT_LA_l0_c4_s0[0]),
        .COUTD(COUT_LA_l0_c4_s0[1]),
        .COUTF(COUT_LA_l0_c4_s0[2]),
        .COUTH(COUT_LA_l0_c4_s0[3]),
        .CIN  (CIN_LA_l0_c4_s0    ),
        .CYA  (CY_LA_l0_c4_s0[0]  ),
        .CYB  (CY_LA_l0_c4_s0[1]  ),
        .CYC  (CY_LA_l0_c4_s0[2]  ),
        .CYD  (CY_LA_l0_c4_s0[3]  ),
        .CYE  (CY_LA_l0_c4_s0[4]  ),
        .CYF  (CY_LA_l0_c4_s0[5]  ),
        .CYG  (CY_LA_l0_c4_s0[6]  ),
        .CYH  (CY_LA_l0_c4_s0[7]  ),
        .PROPA(PROP_LA_l0_c4_s0[0]),
        .PROPB(PROP_LA_l0_c4_s0[1]),
        .PROPC(PROP_LA_l0_c4_s0[2]),
        .PROPD(PROP_LA_l0_c4_s0[3]),
        .PROPE(PROP_LA_l0_c4_s0[4]),
        .PROPF(PROP_LA_l0_c4_s0[5]),
        .PROPG(PROP_LA_l0_c4_s0[6]),
        .PROPH(PROP_LA_l0_c4_s0[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c4_s1_inst0 (
        .COUTB(COUT_LA_l0_c4_s1[0]),
        .COUTD(COUT_LA_l0_c4_s1[1]),
        .COUTF(COUT_LA_l0_c4_s1[2]),
        .COUTH(COUT_LA_l0_c4_s1[3]),
        .CIN  (CIN_LA_l0_c4_s1    ),
        .CYA  (CY_LA_l0_c4_s1[0]  ),
        .CYB  (CY_LA_l0_c4_s1[1]  ),
        .CYC  (CY_LA_l0_c4_s1[2]  ),
        .CYD  (CY_LA_l0_c4_s1[3]  ),
        .CYE  (CY_LA_l0_c4_s1[4]  ),
        .CYF  (CY_LA_l0_c4_s1[5]  ),
        .CYG  (CY_LA_l0_c4_s1[6]  ),
        .CYH  (CY_LA_l0_c4_s1[7]  ),
        .PROPA(PROP_LA_l0_c4_s1[0]),
        .PROPB(PROP_LA_l0_c4_s1[1]),
        .PROPC(PROP_LA_l0_c4_s1[2]),
        .PROPD(PROP_LA_l0_c4_s1[3]),
        .PROPE(PROP_LA_l0_c4_s1[4]),
        .PROPF(PROP_LA_l0_c4_s1[5]),
        .PROPG(PROP_LA_l0_c4_s1[6]),
        .PROPH(PROP_LA_l0_c4_s1[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c4_s2_inst0 (
        .COUTB(COUT_LA_l0_c4_s2[0]),
        .COUTD(COUT_LA_l0_c4_s2[1]),
        .COUTF(COUT_LA_l0_c4_s2[2]),
        .COUTH(COUT_LA_l0_c4_s2[3]),
        .CIN  (CIN_LA_l0_c4_s2    ),
        .CYA  (CY_LA_l0_c4_s2[0]  ),
        .CYB  (CY_LA_l0_c4_s2[1]  ),
        .CYC  (CY_LA_l0_c4_s2[2]  ),
        .CYD  (CY_LA_l0_c4_s2[3]  ),
        .CYE  (CY_LA_l0_c4_s2[4]  ),
        .CYF  (CY_LA_l0_c4_s2[5]  ),
        .CYG  (CY_LA_l0_c4_s2[6]  ),
        .CYH  (CY_LA_l0_c4_s2[7]  ),
        .PROPA(PROP_LA_l0_c4_s2[0]),
        .PROPB(PROP_LA_l0_c4_s2[1]),
        .PROPC(PROP_LA_l0_c4_s2[2]),
        .PROPD(PROP_LA_l0_c4_s2[3]),
        .PROPE(PROP_LA_l0_c4_s2[4]),
        .PROPF(PROP_LA_l0_c4_s2[5]),
        .PROPG(PROP_LA_l0_c4_s2[6]),
        .PROPH(PROP_LA_l0_c4_s2[7]));

    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c4_i0(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c4_i0   ),
        .C1   (C1_c39_231_l0_c4_i0   ),
        .CLA  (CLA_c39_231_l0_c4_i0  ),
        .O0   (O0_c39_231_l0_c4_i0   ),
        .O1   (O1_c39_231_l0_c4_i0   ),
        .O2   (O2_c39_231_l0_c4_i0   ),
        .CY0  (CY0_c39_231_l0_c4_i0  ),
        .CY1  (CY1_c39_231_l0_c4_i0  ),
        .PROP0(PROP0_c39_231_l0_c4_i0),
        .PROP1(PROP1_c39_231_l0_c4_i0));
    
    assign C0_c39_231_l0_c4_i0 = layer0_col35[11:3];
    assign C1_c39_231_l0_c4_i0 = layer0_col36[10:8];
    
    assign layer1_col35[6]   = O0_c39_231_l0_c4_i0;
    assign layer1_col36[4:2] = O1_c39_231_l0_c4_i0;
    assign layer1_col37[4]   = O2_c39_231_l0_c4_i0[0];
    
    assign CLA_c39_231_l0_c4_i0  = COUT_LA_l0_c4_s0[0];
    assign l0_c4_i0              = COUT_LA_l0_c4_s1[0];
    assign CY_LA_l0_c4_s0[1:0]   = CY0_c39_231_l0_c4_i0;
    assign PROP_LA_l0_c4_s0[1:0] = PROP0_c39_231_l0_c4_i0;
    assign CY_LA_l0_c4_s1[1:0]   = CY1_c39_231_l0_c4_i0;
    assign PROP_LA_l0_c4_s1[1:0] = PROP1_c39_231_l0_c4_i0;
    assign CIN_LA_l0_c4_s1       = layer0_col36[9];
    
    assign CIN_LA_l0_c4_s0    = C0_c39_231_l0_c4_i0[8];
    
    c39_231 #(.OUTREG("FALSE"),
              .LEAVEC("TRUE" ),
              .POSODD("FALSE"))
    c39_231_l0_c4_i1(
        .clk  (clk                   ),
        .C0   (C0_c39_231_l0_c4_i1   ),
        .C1   (C1_c39_231_l0_c4_i1   ),
        .CLA  (CLA_c39_231_l0_c4_i1  ),
        .O0   (O0_c39_231_l0_c4_i1   ),
        .O1   (O1_c39_231_l0_c4_i1   ),
        .O2   (O2_c39_231_l0_c4_i1   ),
        .CY0  (CY0_c39_231_l0_c4_i1  ),
        .CY1  (CY1_c39_231_l0_c4_i1  ),
        .PROP0(PROP0_c39_231_l0_c4_i1),
        .PROP1(PROP1_c39_231_l0_c4_i1));
    
    assign C0_c39_231_l0_c4_i1 = {l0_c4_i0, layer0_col37[10:3]};
    assign C1_c39_231_l0_c4_i1 = layer0_col38[10:8];
    
    assign layer1_col37[3]   = O0_c39_231_l0_c4_i1;
    assign layer1_col38[4:2] = O1_c39_231_l0_c4_i1;
    assign layer1_col39[4]   = O2_c39_231_l0_c4_i1[0];
    
    assign CLA_c39_231_l0_c4_i1  = COUT_LA_l0_c4_s1[0];
    assign l0_c4_i1              = COUT_LA_l0_c4_s2[0];
    assign CY_LA_l0_c4_s1[3:2]   = CY0_c39_231_l0_c4_i1;
    assign PROP_LA_l0_c4_s1[3:2] = PROP0_c39_231_l0_c4_i1;
    assign CY_LA_l0_c4_s2[1:0]   = CY1_c39_231_l0_c4_i1;
    assign PROP_LA_l0_c4_s2[1:0] = PROP1_c39_231_l0_c4_i1;
    assign CIN_LA_l0_c4_s2       = layer0_col38[9];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c4_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c4_i2  ),
        .C1  (C1_c15_3_l0_c4_i2  ),
        .CLA (CLA_c15_3_l0_c4_i2 ),
        .O   (O_c15_3_l0_c4_i2   ),
        .CY  (CY_c15_3_l0_c4_i2  ),
        .PROP(PROP_c15_3_l0_c4_i2));
    
    assign C0_c15_3_l0_c4_i2 = {l0_c4_i1, layer0_col39[6:3]};
    assign C1_c15_3_l0_c4_i2 = layer0_col40[8];
    
    assign layer1_col39[3] = O_c15_3_l0_c4_i2[0];
    assign layer1_col40[2] = O_c15_3_l0_c4_i2[1];
    
    assign l0_c4_i2              = COUT_LA_l0_c4_s2[1];
    assign CY_LA_l0_c4_s2[3:2]   = CY_c15_3_l0_c4_i2;
    assign PROP_LA_l0_c4_s2[3:2] = PROP_c15_3_l0_c4_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c4_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c4_i3  ),
        .C1  (C1_c15_3_l0_c4_i3  ),
        .CLA (CLA_c15_3_l0_c4_i3 ),
        .O   (O_c15_3_l0_c4_i3   ),
        .CY  (CY_c15_3_l0_c4_i3  ),
        .PROP(PROP_c15_3_l0_c4_i3));
    
    assign C0_c15_3_l0_c4_i3 = {l0_c4_i2, layer0_col41[6:3]};
    assign C1_c15_3_l0_c4_i3 = layer0_col42[4];
    
    assign layer1_col41[3] = O_c15_3_l0_c4_i3[0];
    assign layer1_col42[2] = O_c15_3_l0_c4_i3[1];
    
    assign l0_c4_i3              = COUT_LA_l0_c4_s2[2];
    assign CY_LA_l0_c4_s2[5:4]   = CY_c15_3_l0_c4_i3;
    assign PROP_LA_l0_c4_s2[5:4] = PROP_c15_3_l0_c4_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l0_c4_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c4_i4  ),
        .C1  (C1_c15_3_l0_c4_i4  ),
        .CLA (CLA_c15_3_l0_c4_i4 ),
        .O   (O_c15_3_l0_c4_i4   ),
        .CY  (CY_c15_3_l0_c4_i4  ),
        .PROP(PROP_c15_3_l0_c4_i4));
    
    assign C0_c15_3_l0_c4_i4 = {l0_c4_i3, layer0_col43[4:1]};
    assign C1_c15_3_l0_c4_i4 = layer0_col44[4];
    
    assign layer1_col43[1] = O_c15_3_l0_c4_i4[0];
    assign layer1_col44[1] = O_c15_3_l0_c4_i4[1];
    assign layer1_col45[1] = O_c15_3_l0_c4_i4[2];
    
    assign l0_c4_i4              = COUT_LA_l0_c4_s2[3];
    assign CY_LA_l0_c4_s2[7:6]   = CY_c15_3_l0_c4_i4;
    assign PROP_LA_l0_c4_s2[7:6] = PROP_c15_3_l0_c4_i4;
    
    // GPC chain5 in layer0:
    // -- (1,5 : 3] at column 45
    // -- (1,5 : 3] at column 47
    // -- (1,5 : 3] at column 49
    // -- (3 : 2] at column 51
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c5_s0_inst0 (
        .COUTB(COUT_LA_l0_c5_s0[0]),
        .COUTD(COUT_LA_l0_c5_s0[1]),
        .COUTF(COUT_LA_l0_c5_s0[2]),
        .COUTH(COUT_LA_l0_c5_s0[3]),
        .CIN  (CIN_LA_l0_c5_s0    ),
        .CYA  (CY_LA_l0_c5_s0[0]  ),
        .CYB  (CY_LA_l0_c5_s0[1]  ),
        .CYC  (CY_LA_l0_c5_s0[2]  ),
        .CYD  (CY_LA_l0_c5_s0[3]  ),
        .CYE  (CY_LA_l0_c5_s0[4]  ),
        .CYF  (CY_LA_l0_c5_s0[5]  ),
        .CYG  (CY_LA_l0_c5_s0[6]  ),
        .CYH  (CY_LA_l0_c5_s0[7]  ),
        .PROPA(PROP_LA_l0_c5_s0[0]),
        .PROPB(PROP_LA_l0_c5_s0[1]),
        .PROPC(PROP_LA_l0_c5_s0[2]),
        .PROPD(PROP_LA_l0_c5_s0[3]),
        .PROPE(PROP_LA_l0_c5_s0[4]),
        .PROPF(PROP_LA_l0_c5_s0[5]),
        .PROPG(PROP_LA_l0_c5_s0[6]),
        .PROPH(PROP_LA_l0_c5_s0[7]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l0_c5_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c5_i0  ),
        .C1  (C1_c15_3_l0_c5_i0  ),
        .CLA (CLA_c15_3_l0_c5_i0 ),
        .O   (O_c15_3_l0_c5_i0   ),
        .CY  (CY_c15_3_l0_c5_i0  ),
        .PROP(PROP_c15_3_l0_c5_i0));
    
    assign C0_c15_3_l0_c5_i0 = layer0_col45[5:1];
    assign C1_c15_3_l0_c5_i0 = layer0_col46[4];
    
    assign layer1_col45[2] = O_c15_3_l0_c5_i0[0];
    assign layer1_col46[1] = O_c15_3_l0_c5_i0[1];
    
    assign l0_c5_i0              = COUT_LA_l0_c5_s0[0];
    assign CY_LA_l0_c5_s0[1:0]   = CY_c15_3_l0_c5_i0;
    assign PROP_LA_l0_c5_s0[1:0] = PROP_c15_3_l0_c5_i0;
    
    assign CIN_LA_l0_c5_s0    = C0_c15_3_l0_c5_i0[4];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c5_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c5_i1  ),
        .C1  (C1_c15_3_l0_c5_i1  ),
        .CLA (CLA_c15_3_l0_c5_i1 ),
        .O   (O_c15_3_l0_c5_i1   ),
        .CY  (CY_c15_3_l0_c5_i1  ),
        .PROP(PROP_c15_3_l0_c5_i1));
    
    assign C0_c15_3_l0_c5_i1 = {l0_c5_i0, layer0_col47[4:1]};
    assign C1_c15_3_l0_c5_i1 = layer0_col48[5];
    
    assign layer1_col47[1] = O_c15_3_l0_c5_i1[0];
    assign layer1_col48[2] = O_c15_3_l0_c5_i1[1];
    
    assign l0_c5_i1              = COUT_LA_l0_c5_s0[1];
    assign CY_LA_l0_c5_s0[3:2]   = CY_c15_3_l0_c5_i1;
    assign PROP_LA_l0_c5_s0[3:2] = PROP_c15_3_l0_c5_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c5_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c5_i2  ),
        .C1  (C1_c15_3_l0_c5_i2  ),
        .CLA (CLA_c15_3_l0_c5_i2 ),
        .O   (O_c15_3_l0_c5_i2   ),
        .CY  (CY_c15_3_l0_c5_i2  ),
        .PROP(PROP_c15_3_l0_c5_i2));
    
    assign C0_c15_3_l0_c5_i2 = {l0_c5_i1, layer0_col49[4:1]};
    assign C1_c15_3_l0_c5_i2 = layer0_col50[2];
    
    assign layer1_col49[1] = O_c15_3_l0_c5_i2[0];
    assign layer1_col50[1] = O_c15_3_l0_c5_i2[1];
    
    assign l0_c5_i2              = COUT_LA_l0_c5_s0[2];
    assign CY_LA_l0_c5_s0[5:4]   = CY_c15_3_l0_c5_i2;
    assign PROP_LA_l0_c5_s0[5:4] = PROP_c15_3_l0_c5_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c5_i3(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c5_i3  ),
        .O   (O_c3_2_l0_c5_i3   ),
        .CY  (CY_c3_2_l0_c5_i3  ),
        .PROP(PROP_c3_2_l0_c5_i3));
    
    assign C0_c3_2_l0_c5_i3 = {l0_c5_i2, layer0_col51[3:2]};
    
    assign layer1_col51[1] = O_c3_2_l0_c5_i3[0];
    assign layer1_col52[1] = O_c3_2_l0_c5_i3[1];
    
    assign l0_c5_i3            = O_c3_2_l0_c5_i3[1];
    assign CY_LA_l0_c5_s0[6]   = CY_c3_2_l0_c5_i3;
    assign PROP_LA_l0_c5_s0[6] = PROP_c3_2_l0_c5_i3;
    
    // GPC chain6 in layer0:
    // -- (3 : 2] at column 12
    // -- (3 : 2] at column 13
    // -- (1,5 : 3] at column 14
    // -- (1,5 : 3] at column 16
    // -- (3 : 2] at column 18
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c6_s0_inst0 (
        .COUTB(COUT_LA_l0_c6_s0[0]),
        .COUTD(COUT_LA_l0_c6_s0[1]),
        .COUTF(COUT_LA_l0_c6_s0[2]),
        .COUTH(COUT_LA_l0_c6_s0[3]),
        .CIN  (CIN_LA_l0_c6_s0    ),
        .CYA  (CY_LA_l0_c6_s0[0]  ),
        .CYB  (CY_LA_l0_c6_s0[1]  ),
        .CYC  (CY_LA_l0_c6_s0[2]  ),
        .CYD  (CY_LA_l0_c6_s0[3]  ),
        .CYE  (CY_LA_l0_c6_s0[4]  ),
        .CYF  (CY_LA_l0_c6_s0[5]  ),
        .CYG  (CY_LA_l0_c6_s0[6]  ),
        .CYH  (CY_LA_l0_c6_s0[7]  ),
        .PROPA(PROP_LA_l0_c6_s0[0]),
        .PROPB(PROP_LA_l0_c6_s0[1]),
        .PROPC(PROP_LA_l0_c6_s0[2]),
        .PROPD(PROP_LA_l0_c6_s0[3]),
        .PROPE(PROP_LA_l0_c6_s0[4]),
        .PROPF(PROP_LA_l0_c6_s0[5]),
        .PROPG(PROP_LA_l0_c6_s0[6]),
        .PROPH(PROP_LA_l0_c6_s0[7]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c6_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c6_i0  ),
        .O   (O_c3_2_l0_c6_i0   ),
        .CY  (CY_c3_2_l0_c6_i0  ),
        .PROP(PROP_c3_2_l0_c6_i0));
    
    assign C0_c3_2_l0_c6_i0 = layer0_col12[7:5];
    
    assign layer1_col12[2] = O_c3_2_l0_c6_i0[0];
    
    assign l0_c6_i0            = O_c3_2_l0_c6_i0[1];
    assign CY_LA_l0_c6_s0[0]   = CY_c3_2_l0_c6_i0;
    assign PROP_LA_l0_c6_s0[0] = PROP_c3_2_l0_c6_i0;
    
    assign CIN_LA_l0_c6_s0    = C0_c3_2_l0_c6_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c6_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c6_i1  ),
        .O   (O_c3_2_l0_c6_i1   ),
        .CY  (CY_c3_2_l0_c6_i1  ),
        .PROP(PROP_c3_2_l0_c6_i1));
    
    assign C0_c3_2_l0_c6_i1 = {l0_c6_i0, layer0_col13[6:5]};
    
    assign layer1_col13[2] = O_c3_2_l0_c6_i1[0];
    
    assign l0_c6_i1            = COUT_LA_l0_c6_s0[0];
    assign CY_LA_l0_c6_s0[1]   = CY_c3_2_l0_c6_i1;
    assign PROP_LA_l0_c6_s0[1] = PROP_c3_2_l0_c6_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c6_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c6_i2  ),
        .C1  (C1_c15_3_l0_c6_i2  ),
        .CLA (CLA_c15_3_l0_c6_i2 ),
        .O   (O_c15_3_l0_c6_i2   ),
        .CY  (CY_c15_3_l0_c6_i2  ),
        .PROP(PROP_c15_3_l0_c6_i2));
    
    assign C0_c15_3_l0_c6_i2 = {l0_c6_i1, layer0_col14[8:5]};
    assign C1_c15_3_l0_c6_i2 = layer0_col15[5];
    
    assign layer1_col14[2] = O_c15_3_l0_c6_i2[0];
    assign layer1_col15[2] = O_c15_3_l0_c6_i2[1];
    
    assign l0_c6_i2              = COUT_LA_l0_c6_s0[1];
    assign CY_LA_l0_c6_s0[3:2]   = CY_c15_3_l0_c6_i2;
    assign PROP_LA_l0_c6_s0[3:2] = PROP_c15_3_l0_c6_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c6_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c6_i3  ),
        .C1  (C1_c15_3_l0_c6_i3  ),
        .CLA (CLA_c15_3_l0_c6_i3 ),
        .O   (O_c15_3_l0_c6_i3   ),
        .CY  (CY_c15_3_l0_c6_i3  ),
        .PROP(PROP_c15_3_l0_c6_i3));
    
    assign C0_c15_3_l0_c6_i3 = {l0_c6_i2, layer0_col16[8:5]};
    assign C1_c15_3_l0_c6_i3 = layer0_col17[5];
    
    assign layer1_col16[2] = O_c15_3_l0_c6_i3[0];
    assign layer1_col17[2] = O_c15_3_l0_c6_i3[1];
    
    assign l0_c6_i3              = COUT_LA_l0_c6_s0[2];
    assign CY_LA_l0_c6_s0[5:4]   = CY_c15_3_l0_c6_i3;
    assign PROP_LA_l0_c6_s0[5:4] = PROP_c15_3_l0_c6_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c6_i4(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c6_i4  ),
        .O   (O_c3_2_l0_c6_i4   ),
        .CY  (CY_c3_2_l0_c6_i4  ),
        .PROP(PROP_c3_2_l0_c6_i4));
    
    assign C0_c3_2_l0_c6_i4 = {l0_c6_i3, layer0_col18[10:9]};
    
    assign layer1_col18[2] = O_c3_2_l0_c6_i4[0];
    assign layer1_col19[4] = O_c3_2_l0_c6_i4[1];
    
    assign l0_c6_i4            = O_c3_2_l0_c6_i4[1];
    assign CY_LA_l0_c6_s0[6]   = CY_c3_2_l0_c6_i4;
    assign PROP_LA_l0_c6_s0[6] = PROP_c3_2_l0_c6_i4;
    
    // GPC10 in layer0: (3 : 2] at column 20
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_f10(
        .clk (clk             ),
        .C0  (C0_c3_2_l0_f10  ),
        .O   (O_c3_2_l0_i10   ),
        .CY  (CY_c3_2_l0_f10  ),
        .PROP(PROP_c3_2_l0_f10));
    
    assign C0_c3_2_l0_f10 = layer0_col20[11:9];
    
    assign layer1_col20[3] = O_c3_2_l0_i10[0];
    assign layer1_col21[4] = O_c3_2_l0_i10[1];
    
    // GPC chain7 in layer0:
    // -- (2,2,3 : 4] at column 43
    // -- (3 : 2] at column 46
    // -- (3 : 2] at column 47
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c7_s0_inst0 (
        .COUTB(COUT_LA_l0_c7_s0[0]),
        .COUTD(COUT_LA_l0_c7_s0[1]),
        .COUTF(COUT_LA_l0_c7_s0[2]),
        .COUTH(COUT_LA_l0_c7_s0[3]),
        .CIN  (CIN_LA_l0_c7_s0    ),
        .CYA  (CY_LA_l0_c7_s0[0]  ),
        .CYB  (CY_LA_l0_c7_s0[1]  ),
        .CYC  (CY_LA_l0_c7_s0[2]  ),
        .CYD  (CY_LA_l0_c7_s0[3]  ),
        .CYE  (CY_LA_l0_c7_s0[4]  ),
        .CYF  (CY_LA_l0_c7_s0[5]  ),
        .CYG  (CY_LA_l0_c7_s0[6]  ),
        .CYH  (CY_LA_l0_c7_s0[7]  ),
        .PROPA(PROP_LA_l0_c7_s0[0]),
        .PROPB(PROP_LA_l0_c7_s0[1]),
        .PROPC(PROP_LA_l0_c7_s0[2]),
        .PROPD(PROP_LA_l0_c7_s0[3]),
        .PROPE(PROP_LA_l0_c7_s0[4]),
        .PROPF(PROP_LA_l0_c7_s0[5]),
        .PROPG(PROP_LA_l0_c7_s0[6]),
        .PROPH(PROP_LA_l0_c7_s0[7]));

    c223_4 #(.OUTREG("FALSE"),
             .LEAVEC("TRUE" ),
             .POSODD("FALSE"))
    c223_4_l0_c7_i0(
        .clk (clk                 ),
        .C0  (C0_c223_4_l0_c7_i0  ),
        .C1  (C1_c223_4_l0_c7_i0  ),
        .C2  (C2_c223_4_l0_c7_i0  ),
        .CLA (CLA_c223_4_l0_c7_i0 ),
        .O   (O_c223_4_l0_c7_i0   ),
        .CY  (CY_c223_4_l0_c7_i0  ),
        .PROP(PROP_c223_4_l0_c7_i0));
    
    assign C0_c223_4_l0_c7_i0 = layer0_col43[7:5];
    assign C1_c223_4_l0_c7_i0 = layer0_col44[6:5];
    assign C2_c223_4_l0_c7_i0 = layer0_col45[7:6];
    
    assign layer1_col43[2] = O_c223_4_l0_c7_i0[0];
    assign layer1_col44[2] = O_c223_4_l0_c7_i0[1];
    assign layer1_col45[3] = O_c223_4_l0_c7_i0[2];
    
    assign l0_c7_i0              = COUT_LA_l0_c7_s0[0];
    assign CY_LA_l0_c7_s0[1:0]   = CY_c223_4_l0_c7_i0;
    assign PROP_LA_l0_c7_s0[1:0] = PROP_c223_4_l0_c7_i0;
    
    assign CIN_LA_l0_c7_s0    = C0_c223_4_l0_c7_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c7_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c7_i1  ),
        .O   (O_c3_2_l0_c7_i1   ),
        .CY  (CY_c3_2_l0_c7_i1  ),
        .PROP(PROP_c3_2_l0_c7_i1));
    
    assign C0_c3_2_l0_c7_i1 = {l0_c7_i0, layer0_col46[6:5]};
    
    assign layer1_col46[2] = O_c3_2_l0_c7_i1[0];
    
    assign l0_c7_i1            = O_c3_2_l0_c7_i1[1];
    assign CY_LA_l0_c7_s0[2]   = CY_c3_2_l0_c7_i1;
    assign PROP_LA_l0_c7_s0[2] = PROP_c3_2_l0_c7_i1;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c7_i2(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c7_i2  ),
        .O   (O_c3_2_l0_c7_i2   ),
        .CY  (CY_c3_2_l0_c7_i2  ),
        .PROP(PROP_c3_2_l0_c7_i2));
    
    assign C0_c3_2_l0_c7_i2 = {l0_c7_i1, layer0_col47[6:5]};
    
    assign layer1_col47[2] = O_c3_2_l0_c7_i2[0];
    assign layer1_col48[3] = O_c3_2_l0_c7_i2[1];
    
    assign l0_c7_i2            = COUT_LA_l0_c7_s0[1];
    assign CY_LA_l0_c7_s0[3]   = CY_c3_2_l0_c7_i2;
    assign PROP_LA_l0_c7_s0[3] = PROP_c3_2_l0_c7_i2;
    
    // GPC11 in layer0: (3 : 2] at column 17
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_f11(
        .clk (clk             ),
        .C0  (C0_c3_2_l0_f11  ),
        .O   (O_c3_2_l0_i11   ),
        .CY  (CY_c3_2_l0_f11  ),
        .PROP(PROP_c3_2_l0_f11));
    
    assign C0_c3_2_l0_f11 = layer0_col17[8:6];
    
    assign layer1_col17[3] = O_c3_2_l0_i11[0];
    assign layer1_col18[3] = O_c3_2_l0_i11[1];
    
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

    assign CY_LA_l0_floating_placement[1:0]   = CY0_c39_231_l0_f1;
    assign PROP_LA_l0_floating_placement[1:0] = PROP0_c39_231_l0_f1;
    assign CY_LA_l0_floating_placement[3:2]   = CY1_c39_231_l0_f1;
    assign PROP_LA_l0_floating_placement[3:2] = PROP1_c39_231_l0_f1;
    assign CIN_LA_l0_floating_placement[0] = C0_c39_231_l0_f1[8];
    
    assign CY_LA_l0_floating_placement[5:4]   = CY0_c39_231_l0_f3;
    assign PROP_LA_l0_floating_placement[5:4] = PROP0_c39_231_l0_f3;
    assign CY_LA_l0_floating_placement[7:6]   = CY1_c39_231_l0_f3;
    assign PROP_LA_l0_floating_placement[7:6] = PROP1_c39_231_l0_f3;
    
    assign CY_LA_l0_floating_placement[9:8]   = CY0_c39_231_l0_f5;
    assign PROP_LA_l0_floating_placement[9:8] = PROP0_c39_231_l0_f5;
    assign CY_LA_l0_floating_placement[11:10]   = CY1_c39_231_l0_f5;
    assign PROP_LA_l0_floating_placement[11:10] = PROP1_c39_231_l0_f5;
    assign CIN_LA_l0_floating_placement[1] = C0_c39_231_l0_f5[8];
    
    assign CY_LA_l0_floating_placement[13:12]   = CY_c9_41_l0_f7;
    assign PROP_LA_l0_floating_placement[13:12] = PROP_c9_41_l0_f7;
    
    assign CY_LA_l0_floating_placement[15:14]   = CY0_c39_231_l0_f8;
    assign PROP_LA_l0_floating_placement[15:14] = PROP0_c39_231_l0_f8;
    assign CY_LA_l0_floating_placement[17:16]   = CY1_c39_231_l0_f8;
    assign PROP_LA_l0_floating_placement[17:16] = PROP1_c39_231_l0_f8;
    assign CIN_LA_l0_floating_placement[2] = C1_c39_231_l0_f8[1];
    
    assign CY_LA_l0_floating_placement[19:18]   = CY_c9_41_l0_f9;
    assign PROP_LA_l0_floating_placement[19:18] = PROP_c9_41_l0_f9;
    
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
    assign layer1_col10[2] = layer0_col10[6];
    assign layer1_col11[2] = layer0_col11[5];
    assign layer1_col15[3] = layer0_col15[6];
    assign layer1_col15[4] = layer0_col15[7];
    assign layer1_col16[3] = layer0_col16[9];
    assign layer1_col19[5] = layer0_col19[7];
    assign layer1_col19[6] = layer0_col19[8];
    assign layer1_col19[7] = layer0_col19[9];
    assign layer1_col22[5] = layer0_col22[11];
    assign layer1_col22[6] = layer0_col22[12];
    assign layer1_col23[5] = layer0_col23[11];
    assign layer1_col24[7] = layer0_col24[13];
    assign layer1_col26[7] = layer0_col26[12];
    assign layer1_col26[8] = layer0_col26[13];
    assign layer1_col26[9] = layer0_col26[14];
    assign layer1_col27[7] = layer0_col27[13];
    assign layer1_col28[5] = layer0_col28[13];
    assign layer1_col28[6] = layer0_col28[14];
    assign layer1_col28[7] = layer0_col28[15];
    assign layer1_col29[7] = layer0_col29[12];
    assign layer1_col29[8] = layer0_col29[13];
    assign layer1_col29[9] = layer0_col29[14];
    assign layer1_col31[7] = layer0_col31[13];
    assign layer1_col31[8] = layer0_col31[14];
    assign layer1_col32[7] = layer0_col32[12];
    assign layer1_col32[8] = layer0_col32[13];
    assign layer1_col33[7] = layer0_col33[13];
    assign layer1_col35[7] = layer0_col35[12];
    assign layer1_col36[5] = layer0_col36[11];
    assign layer1_col37[5] = layer0_col37[11];
    assign layer1_col39[5] = layer0_col39[7];
    assign layer1_col39[6] = layer0_col39[8];
    assign layer1_col39[7] = layer0_col39[9];
    assign layer1_col39[8] = layer0_col39[10];
    assign layer1_col40[3] = layer0_col40[9];
    assign layer1_col41[4] = layer0_col41[7];
    assign layer1_col41[5] = layer0_col41[8];
    assign layer1_col41[6] = layer0_col41[9];
    assign layer1_col42[3] = layer0_col42[5];
    assign layer1_col42[4] = layer0_col42[6];
    assign layer1_col42[5] = layer0_col42[7];
    assign layer1_col42[6] = layer0_col42[8];
    assign layer1_col43[3] = layer0_col43[8];
    assign layer1_col44[3] = layer0_col44[7];
    assign layer1_col49[2] = layer0_col49[5];
    assign layer1_col50[2] = layer0_col50[3];
    assign layer1_col50[3] = layer0_col50[4];
    assign layer1_col51[2] = layer0_col51[4];
    assign layer1_col52[2] = layer0_col52[2];
    assign layer1_col52[3] = layer0_col52[3];
    assign layer1_col53[1] = layer0_col53[2];
    assign layer1_col53[2] = layer0_col53[3];
    assign layer1_col54[1] = layer0_col54[0];
    assign layer1_col54[2] = layer0_col54[1];
    assign layer1_col54[3] = layer0_col54[2];
    assign layer1_col55[0] = layer0_col55[0];
    assign layer1_col55[1] = layer0_col55[1];
    assign layer1_col55[2] = layer0_col55[2];
    assign layer1_col56[0] = layer0_col56[0];
    assign layer1_col56[1] = layer0_col56[1];
    assign layer1_col57[0] = layer0_col57[0];
    assign layer1_col57[1] = layer0_col57[1];
    assign layer1_col58    = layer0_col58;
    assign layer1_col59    = layer0_col59;
    // ------------------------------ LAYER 1 ------------------------------
    // GPC chain0 in layer1:
    // -- (2,2,3 : 4] at column 15
    // -- (3 : 2] at column 18
    // -- (1,5 : 3] at column 19
    // -- (3 : 2] at column 21
    // -- (1,5 : 3] at column 22
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
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

    c223_4 #(.OUTREG("FALSE"),
             .LEAVEC("TRUE" ),
             .POSODD("FALSE"))
    c223_4_l1_c0_i0(
        .clk (clk                 ),
        .C0  (C0_c223_4_l1_c0_i0  ),
        .C1  (C1_c223_4_l1_c0_i0  ),
        .C2  (C2_c223_4_l1_c0_i0  ),
        .CLA (CLA_c223_4_l1_c0_i0 ),
        .O   (O_c223_4_l1_c0_i0   ),
        .CY  (CY_c223_4_l1_c0_i0  ),
        .PROP(PROP_c223_4_l1_c0_i0));
    
    assign C0_c223_4_l1_c0_i0 = layer1_col15[2:0];
    assign C1_c223_4_l1_c0_i0 = layer1_col16[1:0];
    assign C2_c223_4_l1_c0_i0 = layer1_col17[1:0];
    
    assign layer2_col15[0] = O_c223_4_l1_c0_i0[0];
    assign layer2_col16[0] = O_c223_4_l1_c0_i0[1];
    assign layer2_col17[0] = O_c223_4_l1_c0_i0[2];
    
    assign l1_c0_i0              = COUT_LA_l1_c0_s0[0];
    assign CY_LA_l1_c0_s0[1:0]   = CY_c223_4_l1_c0_i0;
    assign PROP_LA_l1_c0_s0[1:0] = PROP_c223_4_l1_c0_i0;
    
    assign CIN_LA_l1_c0_s0    = C0_c223_4_l1_c0_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c0_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c0_i1  ),
        .O   (O_c3_2_l1_c0_i1   ),
        .CY  (CY_c3_2_l1_c0_i1  ),
        .PROP(PROP_c3_2_l1_c0_i1));
    
    assign C0_c3_2_l1_c0_i1 = {l1_c0_i0, layer1_col18[1:0]};
    
    assign layer2_col18[0] = O_c3_2_l1_c0_i1[0];
    
    assign l1_c0_i1            = O_c3_2_l1_c0_i1[1];
    assign CY_LA_l1_c0_s0[2]   = CY_c3_2_l1_c0_i1;
    assign PROP_LA_l1_c0_s0[2] = PROP_c3_2_l1_c0_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c0_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c0_i2  ),
        .C1  (C1_c15_3_l1_c0_i2  ),
        .CLA (CLA_c15_3_l1_c0_i2 ),
        .O   (O_c15_3_l1_c0_i2   ),
        .CY  (CY_c15_3_l1_c0_i2  ),
        .PROP(PROP_c15_3_l1_c0_i2));
    
    assign C0_c15_3_l1_c0_i2 = {l1_c0_i1, layer1_col19[3:0]};
    assign C1_c15_3_l1_c0_i2 = layer1_col20[0];
    
    assign layer2_col19[0] = O_c15_3_l1_c0_i2[0];
    assign layer2_col20[0] = O_c15_3_l1_c0_i2[1];
    
    assign CLA_c15_3_l1_c0_i2    = COUT_LA_l1_c0_s0[1];
    assign l1_c0_i2              = O_c15_3_l1_c0_i2[2];
    assign CY_LA_l1_c0_s0[4:3]   = CY_c15_3_l1_c0_i2;
    assign PROP_LA_l1_c0_s0[4:3] = PROP_c15_3_l1_c0_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c0_i3(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c0_i3  ),
        .O   (O_c3_2_l1_c0_i3   ),
        .CY  (CY_c3_2_l1_c0_i3  ),
        .PROP(PROP_c3_2_l1_c0_i3));
    
    assign C0_c3_2_l1_c0_i3 = {l1_c0_i2, layer1_col21[1:0]};
    
    assign layer2_col21[0] = O_c3_2_l1_c0_i3[0];
    
    assign l1_c0_i3            = COUT_LA_l1_c0_s0[2];
    assign CY_LA_l1_c0_s0[5]   = CY_c3_2_l1_c0_i3;
    assign PROP_LA_l1_c0_s0[5] = PROP_c3_2_l1_c0_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l1_c0_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c0_i4  ),
        .C1  (C1_c15_3_l1_c0_i4  ),
        .CLA (CLA_c15_3_l1_c0_i4 ),
        .O   (O_c15_3_l1_c0_i4   ),
        .CY  (CY_c15_3_l1_c0_i4  ),
        .PROP(PROP_c15_3_l1_c0_i4));
    
    assign C0_c15_3_l1_c0_i4 = {l1_c0_i3, layer1_col22[3:0]};
    assign C1_c15_3_l1_c0_i4 = layer1_col23[0];
    
    assign layer2_col22[0] = O_c15_3_l1_c0_i4[0];
    assign layer2_col23[0] = O_c15_3_l1_c0_i4[1];
    assign layer2_col24[0] = O_c15_3_l1_c0_i4[2];
    
    assign l1_c0_i4              = COUT_LA_l1_c0_s0[3];
    assign CY_LA_l1_c0_s0[7:6]   = CY_c15_3_l1_c0_i4;
    assign PROP_LA_l1_c0_s0[7:6] = PROP_c15_3_l1_c0_i4;
    
    // GPC chain1 in layer1:
    // -- (1,5 : 3] at column 24
    // -- (1,5 : 3] at column 26
    // -- (1,5 : 3] at column 28
    // -- (1,5 : 3] at column 30
    // -- (1,5 : 3] at column 32
    // -- (3 : 2] at column 34
    // -- (1,5 : 3] at column 35
    // -- (1,5 : 3] at column 37
    // -- (1,5 : 3] at column 39
    // -- (1,5 : 3] at column 41
    // -- (3 : 2] at column 43
    // -- (3 : 2] at column 44
    // -- (3 : 2] at column 45
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l1_c1_s0_inst0 (
        .COUTB(COUT_LA_l1_c1_s0[0]),
        .COUTD(COUT_LA_l1_c1_s0[1]),
        .COUTF(COUT_LA_l1_c1_s0[2]),
        .COUTH(COUT_LA_l1_c1_s0[3]),
        .CIN  (CIN_LA_l1_c1_s0[0] ),
        .CYA  (CY_LA_l1_c1_s0[0]  ),
        .CYB  (CY_LA_l1_c1_s0[1]  ),
        .CYC  (CY_LA_l1_c1_s0[2]  ),
        .CYD  (CY_LA_l1_c1_s0[3]  ),
        .CYE  (CY_LA_l1_c1_s0[4]  ),
        .CYF  (CY_LA_l1_c1_s0[5]  ),
        .CYG  (CY_LA_l1_c1_s0[6]  ),
        .CYH  (CY_LA_l1_c1_s0[7]  ),
        .PROPA(PROP_LA_l1_c1_s0[0]),
        .PROPB(PROP_LA_l1_c1_s0[1]),
        .PROPC(PROP_LA_l1_c1_s0[2]),
        .PROPD(PROP_LA_l1_c1_s0[3]),
        .PROPE(PROP_LA_l1_c1_s0[4]),
        .PROPF(PROP_LA_l1_c1_s0[5]),
        .PROPG(PROP_LA_l1_c1_s0[6]),
        .PROPH(PROP_LA_l1_c1_s0[7]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_l1_c1_s0_inst1 (
        .COUTB(COUT_LA_l1_c1_s0[4] ),
        .COUTD(COUT_LA_l1_c1_s0[5] ),
        .COUTF(COUT_LA_l1_c1_s0[6] ),
        .COUTH(COUT_LA_l1_c1_s0[7] ),
        .CIN  (CIN_LA_l1_c1_s0[1]  ),
        .CYA  (CY_LA_l1_c1_s0[8]   ),
        .CYB  (CY_LA_l1_c1_s0[9]   ),
        .CYC  (CY_LA_l1_c1_s0[10]  ),
        .CYD  (CY_LA_l1_c1_s0[11]  ),
        .CYE  (CY_LA_l1_c1_s0[12]  ),
        .CYF  (CY_LA_l1_c1_s0[13]  ),
        .CYG  (CY_LA_l1_c1_s0[14]  ),
        .CYH  (CY_LA_l1_c1_s0[15]  ),
        .PROPA(PROP_LA_l1_c1_s0[8] ),
        .PROPB(PROP_LA_l1_c1_s0[9] ),
        .PROPC(PROP_LA_l1_c1_s0[10]),
        .PROPD(PROP_LA_l1_c1_s0[11]),
        .PROPE(PROP_LA_l1_c1_s0[12]),
        .PROPF(PROP_LA_l1_c1_s0[13]),
        .PROPG(PROP_LA_l1_c1_s0[14]),
        .PROPH(PROP_LA_l1_c1_s0[15]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE" ),
        .LOOKD("TRUE" ),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_c1_s0_inst2 (
        .COUTB(COUT_LA_l1_c1_s0[8] ),
        .COUTD(COUT_LA_l1_c1_s0[9] ),
        .COUTF(COUT_LA_l1_c1_s0[10]),
        .COUTH(COUT_LA_l1_c1_s0[11]),
        .CIN  (CIN_LA_l1_c1_s0[2]  ),
        .CYA  (CY_LA_l1_c1_s0[16]  ),
        .CYB  (CY_LA_l1_c1_s0[17]  ),
        .CYC  (CY_LA_l1_c1_s0[18]  ),
        .CYD  (CY_LA_l1_c1_s0[19]  ),
        .CYE  (CY_LA_l1_c1_s0[20]  ),
        .CYF  (CY_LA_l1_c1_s0[21]  ),
        .CYG  (CY_LA_l1_c1_s0[22]  ),
        .CYH  (CY_LA_l1_c1_s0[23]  ),
        .PROPA(PROP_LA_l1_c1_s0[16]),
        .PROPB(PROP_LA_l1_c1_s0[17]),
        .PROPC(PROP_LA_l1_c1_s0[18]),
        .PROPD(PROP_LA_l1_c1_s0[19]),
        .PROPE(PROP_LA_l1_c1_s0[20]),
        .PROPF(PROP_LA_l1_c1_s0[21]),
        .PROPG(PROP_LA_l1_c1_s0[22]),
        .PROPH(PROP_LA_l1_c1_s0[23]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i0  ),
        .C1  (C1_c15_3_l1_c1_i0  ),
        .CLA (CLA_c15_3_l1_c1_i0 ),
        .O   (O_c15_3_l1_c1_i0   ),
        .CY  (CY_c15_3_l1_c1_i0  ),
        .PROP(PROP_c15_3_l1_c1_i0));
    
    assign C0_c15_3_l1_c1_i0 = layer1_col24[4:0];
    assign C1_c15_3_l1_c1_i0 = layer1_col25[0];
    
    assign layer2_col24[1] = O_c15_3_l1_c1_i0[0];
    assign layer2_col25[0] = O_c15_3_l1_c1_i0[1];
    
    assign l1_c1_i0              = COUT_LA_l1_c1_s0[0];
    assign CY_LA_l1_c1_s0[1:0]   = CY_c15_3_l1_c1_i0;
    assign PROP_LA_l1_c1_s0[1:0] = PROP_c15_3_l1_c1_i0;
    
    assign CIN_LA_l1_c1_s0[0] = C0_c15_3_l1_c1_i0[4];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i1  ),
        .C1  (C1_c15_3_l1_c1_i1  ),
        .CLA (CLA_c15_3_l1_c1_i1 ),
        .O   (O_c15_3_l1_c1_i1   ),
        .CY  (CY_c15_3_l1_c1_i1  ),
        .PROP(PROP_c15_3_l1_c1_i1));
    
    assign C0_c15_3_l1_c1_i1 = {l1_c1_i0, layer1_col26[3:0]};
    assign C1_c15_3_l1_c1_i1 = layer1_col27[0];
    
    assign layer2_col26[0] = O_c15_3_l1_c1_i1[0];
    assign layer2_col27[0] = O_c15_3_l1_c1_i1[1];
    
    assign l1_c1_i1              = COUT_LA_l1_c1_s0[1];
    assign CY_LA_l1_c1_s0[3:2]   = CY_c15_3_l1_c1_i1;
    assign PROP_LA_l1_c1_s0[3:2] = PROP_c15_3_l1_c1_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i2  ),
        .C1  (C1_c15_3_l1_c1_i2  ),
        .CLA (CLA_c15_3_l1_c1_i2 ),
        .O   (O_c15_3_l1_c1_i2   ),
        .CY  (CY_c15_3_l1_c1_i2  ),
        .PROP(PROP_c15_3_l1_c1_i2));
    
    assign C0_c15_3_l1_c1_i2 = {l1_c1_i1, layer1_col28[3:0]};
    assign C1_c15_3_l1_c1_i2 = layer1_col29[0];
    
    assign layer2_col28[0] = O_c15_3_l1_c1_i2[0];
    assign layer2_col29[0] = O_c15_3_l1_c1_i2[1];
    
    assign l1_c1_i2              = COUT_LA_l1_c1_s0[2];
    assign CY_LA_l1_c1_s0[5:4]   = CY_c15_3_l1_c1_i2;
    assign PROP_LA_l1_c1_s0[5:4] = PROP_c15_3_l1_c1_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i3  ),
        .C1  (C1_c15_3_l1_c1_i3  ),
        .CLA (CLA_c15_3_l1_c1_i3 ),
        .O   (O_c15_3_l1_c1_i3   ),
        .CY  (CY_c15_3_l1_c1_i3  ),
        .PROP(PROP_c15_3_l1_c1_i3));
    
    assign C0_c15_3_l1_c1_i3 = {l1_c1_i2, layer1_col30[3:0]};
    assign C1_c15_3_l1_c1_i3 = layer1_col31[0];
    
    assign layer2_col30[0] = O_c15_3_l1_c1_i3[0];
    assign layer2_col31[0] = O_c15_3_l1_c1_i3[1];
    
    assign l1_c1_i3              = COUT_LA_l1_c1_s0[3];
    assign CY_LA_l1_c1_s0[7:6]   = CY_c15_3_l1_c1_i3;
    assign PROP_LA_l1_c1_s0[7:6] = PROP_c15_3_l1_c1_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i4  ),
        .C1  (C1_c15_3_l1_c1_i4  ),
        .CLA (CLA_c15_3_l1_c1_i4 ),
        .O   (O_c15_3_l1_c1_i4   ),
        .CY  (CY_c15_3_l1_c1_i4  ),
        .PROP(PROP_c15_3_l1_c1_i4));
    
    assign C0_c15_3_l1_c1_i4 = {l1_c1_i3, layer1_col32[3:0]};
    assign C1_c15_3_l1_c1_i4 = layer1_col33[0];
    
    assign layer2_col32[0] = O_c15_3_l1_c1_i4[0];
    assign layer2_col33[0] = O_c15_3_l1_c1_i4[1];
    
    assign l1_c1_i4              = COUT_LA_l1_c1_s0[4];
    assign CY_LA_l1_c1_s0[9:8]   = CY_c15_3_l1_c1_i4;
    assign PROP_LA_l1_c1_s0[9:8] = PROP_c15_3_l1_c1_i4;
    
    assign CIN_LA_l1_c1_s0[1] = COUT_LA_l1_c1_s0[3];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c1_i5(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c1_i5  ),
        .O   (O_c3_2_l1_c1_i5   ),
        .CY  (CY_c3_2_l1_c1_i5  ),
        .PROP(PROP_c3_2_l1_c1_i5));
    
    assign C0_c3_2_l1_c1_i5 = {l1_c1_i4, layer1_col34[1:0]};
    
    assign layer2_col34[0] = O_c3_2_l1_c1_i5[0];
    
    assign l1_c1_i5             = O_c3_2_l1_c1_i5[1];
    assign CY_LA_l1_c1_s0[10]   = CY_c3_2_l1_c1_i5;
    assign PROP_LA_l1_c1_s0[10] = PROP_c3_2_l1_c1_i5;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i6(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i6  ),
        .C1  (C1_c15_3_l1_c1_i6  ),
        .CLA (CLA_c15_3_l1_c1_i6 ),
        .O   (O_c15_3_l1_c1_i6   ),
        .CY  (CY_c15_3_l1_c1_i6  ),
        .PROP(PROP_c15_3_l1_c1_i6));
    
    assign C0_c15_3_l1_c1_i6 = {l1_c1_i5, layer1_col35[3:0]};
    assign C1_c15_3_l1_c1_i6 = layer1_col36[0];
    
    assign layer2_col35[0] = O_c15_3_l1_c1_i6[0];
    assign layer2_col36[0] = O_c15_3_l1_c1_i6[1];
    
    assign CLA_c15_3_l1_c1_i6      = COUT_LA_l1_c1_s0[5];
    assign l1_c1_i6                = O_c15_3_l1_c1_i6[2];
    assign CY_LA_l1_c1_s0[12:11]   = CY_c15_3_l1_c1_i6;
    assign PROP_LA_l1_c1_s0[12:11] = PROP_c15_3_l1_c1_i6;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i7(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i7  ),
        .C1  (C1_c15_3_l1_c1_i7  ),
        .CLA (CLA_c15_3_l1_c1_i7 ),
        .O   (O_c15_3_l1_c1_i7   ),
        .CY  (CY_c15_3_l1_c1_i7  ),
        .PROP(PROP_c15_3_l1_c1_i7));
    
    assign C0_c15_3_l1_c1_i7 = {l1_c1_i6, layer1_col37[3:0]};
    assign C1_c15_3_l1_c1_i7 = layer1_col38[0];
    
    assign layer2_col37[0] = O_c15_3_l1_c1_i7[0];
    assign layer2_col38[0] = O_c15_3_l1_c1_i7[1];
    
    assign CLA_c15_3_l1_c1_i7      = COUT_LA_l1_c1_s0[6];
    assign l1_c1_i7                = O_c15_3_l1_c1_i7[2];
    assign CY_LA_l1_c1_s0[14:13]   = CY_c15_3_l1_c1_i7;
    assign PROP_LA_l1_c1_s0[14:13] = PROP_c15_3_l1_c1_i7;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i8(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i8  ),
        .C1  (C1_c15_3_l1_c1_i8  ),
        .CLA (CLA_c15_3_l1_c1_i8 ),
        .O   (O_c15_3_l1_c1_i8   ),
        .CY  (CY_c15_3_l1_c1_i8  ),
        .PROP(PROP_c15_3_l1_c1_i8));
    
    assign C0_c15_3_l1_c1_i8 = {l1_c1_i7, layer1_col39[3:0]};
    assign C1_c15_3_l1_c1_i8 = layer1_col40[0];
    
    assign layer2_col39[0] = O_c15_3_l1_c1_i8[0];
    assign layer2_col40[0] = O_c15_3_l1_c1_i8[1];
    
    assign CLA_c15_3_l1_c1_i8      = COUT_LA_l1_c1_s0[7];
    assign l1_c1_i8                = O_c15_3_l1_c1_i8[2];
    assign CY_LA_l1_c1_s0[16:15]   = CY_c15_3_l1_c1_i8;
    assign PROP_LA_l1_c1_s0[16:15] = PROP_c15_3_l1_c1_i8;
    
    assign CIN_LA_l1_c1_s0[2] = COUT_LA_l1_c1_s0[7];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c1_i9(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c1_i9  ),
        .C1  (C1_c15_3_l1_c1_i9  ),
        .CLA (CLA_c15_3_l1_c1_i9 ),
        .O   (O_c15_3_l1_c1_i9   ),
        .CY  (CY_c15_3_l1_c1_i9  ),
        .PROP(PROP_c15_3_l1_c1_i9));
    
    assign C0_c15_3_l1_c1_i9 = {l1_c1_i8, layer1_col41[3:0]};
    assign C1_c15_3_l1_c1_i9 = layer1_col42[0];
    
    assign layer2_col41[0] = O_c15_3_l1_c1_i9[0];
    assign layer2_col42[0] = O_c15_3_l1_c1_i9[1];
    
    assign CLA_c15_3_l1_c1_i9      = COUT_LA_l1_c1_s0[8];
    assign l1_c1_i9                = O_c15_3_l1_c1_i9[2];
    assign CY_LA_l1_c1_s0[18:17]   = CY_c15_3_l1_c1_i9;
    assign PROP_LA_l1_c1_s0[18:17] = PROP_c15_3_l1_c1_i9;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c1_i10(
        .clk (clk                ),
        .C0  (C0_c3_2_l1_c1_i10  ),
        .O   (O_c3_2_l1_c1_i10   ),
        .CY  (CY_c3_2_l1_c1_i10  ),
        .PROP(PROP_c3_2_l1_c1_i10));
    
    assign C0_c3_2_l1_c1_i10 = {l1_c1_i9, layer1_col43[1:0]};
    
    assign layer2_col43[0] = O_c3_2_l1_c1_i10[0];
    
    assign l1_c1_i10            = COUT_LA_l1_c1_s0[9];
    assign CY_LA_l1_c1_s0[19]   = CY_c3_2_l1_c1_i10;
    assign PROP_LA_l1_c1_s0[19] = PROP_c3_2_l1_c1_i10;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c1_i11(
        .clk (clk                ),
        .C0  (C0_c3_2_l1_c1_i11  ),
        .O   (O_c3_2_l1_c1_i11   ),
        .CY  (CY_c3_2_l1_c1_i11  ),
        .PROP(PROP_c3_2_l1_c1_i11));
    
    assign C0_c3_2_l1_c1_i11 = {l1_c1_i10, layer1_col44[1:0]};
    
    assign layer2_col44[0] = O_c3_2_l1_c1_i11[0];
    
    assign l1_c1_i11            = O_c3_2_l1_c1_i11[1];
    assign CY_LA_l1_c1_s0[20]   = CY_c3_2_l1_c1_i11;
    assign PROP_LA_l1_c1_s0[20] = PROP_c3_2_l1_c1_i11;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l1_c1_i12(
        .clk (clk                ),
        .C0  (C0_c3_2_l1_c1_i12  ),
        .O   (O_c3_2_l1_c1_i12   ),
        .CY  (CY_c3_2_l1_c1_i12  ),
        .PROP(PROP_c3_2_l1_c1_i12));
    
    assign C0_c3_2_l1_c1_i12 = {l1_c1_i11, layer1_col45[1:0]};
    
    assign layer2_col45[0] = O_c3_2_l1_c1_i12[0];
    assign layer2_col46[0] = O_c3_2_l1_c1_i12[1];
    
    assign l1_c1_i12            = COUT_LA_l1_c1_s0[10];
    assign CY_LA_l1_c1_s0[21]   = CY_c3_2_l1_c1_i12;
    assign PROP_LA_l1_c1_s0[21] = PROP_c3_2_l1_c1_i12;
    
    // GPC chain2 in layer1:
    // -- (2,2,3 : 4] at column 19
    // -- (3 : 2] at column 22
    // -- (1,5 : 3] at column 23
    // -- (3 : 2] at column 25
    // -- (1,5 : 3] at column 26
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_c2_s0_inst0 (
        .COUTB(COUT_LA_l1_c2_s0[0]),
        .COUTD(COUT_LA_l1_c2_s0[1]),
        .COUTF(COUT_LA_l1_c2_s0[2]),
        .COUTH(COUT_LA_l1_c2_s0[3]),
        .CIN  (CIN_LA_l1_c2_s0    ),
        .CYA  (CY_LA_l1_c2_s0[0]  ),
        .CYB  (CY_LA_l1_c2_s0[1]  ),
        .CYC  (CY_LA_l1_c2_s0[2]  ),
        .CYD  (CY_LA_l1_c2_s0[3]  ),
        .CYE  (CY_LA_l1_c2_s0[4]  ),
        .CYF  (CY_LA_l1_c2_s0[5]  ),
        .CYG  (CY_LA_l1_c2_s0[6]  ),
        .CYH  (CY_LA_l1_c2_s0[7]  ),
        .PROPA(PROP_LA_l1_c2_s0[0]),
        .PROPB(PROP_LA_l1_c2_s0[1]),
        .PROPC(PROP_LA_l1_c2_s0[2]),
        .PROPD(PROP_LA_l1_c2_s0[3]),
        .PROPE(PROP_LA_l1_c2_s0[4]),
        .PROPF(PROP_LA_l1_c2_s0[5]),
        .PROPG(PROP_LA_l1_c2_s0[6]),
        .PROPH(PROP_LA_l1_c2_s0[7]));

    c223_4 #(.OUTREG("FALSE"),
             .LEAVEC("TRUE" ),
             .POSODD("FALSE"))
    c223_4_l1_c2_i0(
        .clk (clk                 ),
        .C0  (C0_c223_4_l1_c2_i0  ),
        .C1  (C1_c223_4_l1_c2_i0  ),
        .C2  (C2_c223_4_l1_c2_i0  ),
        .CLA (CLA_c223_4_l1_c2_i0 ),
        .O   (O_c223_4_l1_c2_i0   ),
        .CY  (CY_c223_4_l1_c2_i0  ),
        .PROP(PROP_c223_4_l1_c2_i0));
    
    assign C0_c223_4_l1_c2_i0 = layer1_col19[6:4];
    assign C1_c223_4_l1_c2_i0 = layer1_col20[2:1];
    assign C2_c223_4_l1_c2_i0 = layer1_col21[3:2];
    
    assign layer2_col19[1] = O_c223_4_l1_c2_i0[0];
    assign layer2_col20[1] = O_c223_4_l1_c2_i0[1];
    assign layer2_col21[1] = O_c223_4_l1_c2_i0[2];
    
    assign l1_c2_i0              = COUT_LA_l1_c2_s0[0];
    assign CY_LA_l1_c2_s0[1:0]   = CY_c223_4_l1_c2_i0;
    assign PROP_LA_l1_c2_s0[1:0] = PROP_c223_4_l1_c2_i0;
    
    assign CIN_LA_l1_c2_s0    = C0_c223_4_l1_c2_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c2_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c2_i1  ),
        .O   (O_c3_2_l1_c2_i1   ),
        .CY  (CY_c3_2_l1_c2_i1  ),
        .PROP(PROP_c3_2_l1_c2_i1));
    
    assign C0_c3_2_l1_c2_i1 = {l1_c2_i0, layer1_col22[5:4]};
    
    assign layer2_col22[1] = O_c3_2_l1_c2_i1[0];
    
    assign l1_c2_i1            = O_c3_2_l1_c2_i1[1];
    assign CY_LA_l1_c2_s0[2]   = CY_c3_2_l1_c2_i1;
    assign PROP_LA_l1_c2_s0[2] = PROP_c3_2_l1_c2_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c2_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c2_i2  ),
        .C1  (C1_c15_3_l1_c2_i2  ),
        .CLA (CLA_c15_3_l1_c2_i2 ),
        .O   (O_c15_3_l1_c2_i2   ),
        .CY  (CY_c15_3_l1_c2_i2  ),
        .PROP(PROP_c15_3_l1_c2_i2));
    
    assign C0_c15_3_l1_c2_i2 = {l1_c2_i1, layer1_col23[4:1]};
    assign C1_c15_3_l1_c2_i2 = layer1_col24[5];
    
    assign layer2_col23[1] = O_c15_3_l1_c2_i2[0];
    assign layer2_col24[2] = O_c15_3_l1_c2_i2[1];
    
    assign CLA_c15_3_l1_c2_i2    = COUT_LA_l1_c2_s0[1];
    assign l1_c2_i2              = O_c15_3_l1_c2_i2[2];
    assign CY_LA_l1_c2_s0[4:3]   = CY_c15_3_l1_c2_i2;
    assign PROP_LA_l1_c2_s0[4:3] = PROP_c15_3_l1_c2_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c2_i3(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c2_i3  ),
        .O   (O_c3_2_l1_c2_i3   ),
        .CY  (CY_c3_2_l1_c2_i3  ),
        .PROP(PROP_c3_2_l1_c2_i3));
    
    assign C0_c3_2_l1_c2_i3 = {l1_c2_i2, layer1_col25[2:1]};
    
    assign layer2_col25[1] = O_c3_2_l1_c2_i3[0];
    
    assign l1_c2_i3            = COUT_LA_l1_c2_s0[2];
    assign CY_LA_l1_c2_s0[5]   = CY_c3_2_l1_c2_i3;
    assign PROP_LA_l1_c2_s0[5] = PROP_c3_2_l1_c2_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l1_c2_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c2_i4  ),
        .C1  (C1_c15_3_l1_c2_i4  ),
        .CLA (CLA_c15_3_l1_c2_i4 ),
        .O   (O_c15_3_l1_c2_i4   ),
        .CY  (CY_c15_3_l1_c2_i4  ),
        .PROP(PROP_c15_3_l1_c2_i4));
    
    assign C0_c15_3_l1_c2_i4 = {l1_c2_i3, layer1_col26[7:4]};
    assign C1_c15_3_l1_c2_i4 = layer1_col27[1];
    
    assign layer2_col26[1] = O_c15_3_l1_c2_i4[0];
    assign layer2_col27[1] = O_c15_3_l1_c2_i4[1];
    assign layer2_col28[1] = O_c15_3_l1_c2_i4[2];
    
    assign l1_c2_i4              = COUT_LA_l1_c2_s0[3];
    assign CY_LA_l1_c2_s0[7:6]   = CY_c15_3_l1_c2_i4;
    assign PROP_LA_l1_c2_s0[7:6] = PROP_c15_3_l1_c2_i4;
    
    // GPC chain3 in layer1:
    // -- (3 : 2] at column 28
    // -- (1,5 : 3] at column 29
    // -- (1,5 : 3] at column 31
    // -- (1,5 : 3] at column 33
    // -- (3 : 2] at column 35
    // -- (1,5 : 3] at column 36
    // -- (3 : 2] at column 38
    // -- (1,5 : 3] at column 39
    // -- (3 : 2] at column 41
    // -- (1,5 : 3] at column 42
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l1_c3_s0_inst0 (
        .COUTB(COUT_LA_l1_c3_s0[0]),
        .COUTD(COUT_LA_l1_c3_s0[1]),
        .COUTF(COUT_LA_l1_c3_s0[2]),
        .COUTH(COUT_LA_l1_c3_s0[3]),
        .CIN  (CIN_LA_l1_c3_s0[0] ),
        .CYA  (CY_LA_l1_c3_s0[0]  ),
        .CYB  (CY_LA_l1_c3_s0[1]  ),
        .CYC  (CY_LA_l1_c3_s0[2]  ),
        .CYD  (CY_LA_l1_c3_s0[3]  ),
        .CYE  (CY_LA_l1_c3_s0[4]  ),
        .CYF  (CY_LA_l1_c3_s0[5]  ),
        .CYG  (CY_LA_l1_c3_s0[6]  ),
        .CYH  (CY_LA_l1_c3_s0[7]  ),
        .PROPA(PROP_LA_l1_c3_s0[0]),
        .PROPB(PROP_LA_l1_c3_s0[1]),
        .PROPC(PROP_LA_l1_c3_s0[2]),
        .PROPD(PROP_LA_l1_c3_s0[3]),
        .PROPE(PROP_LA_l1_c3_s0[4]),
        .PROPF(PROP_LA_l1_c3_s0[5]),
        .PROPG(PROP_LA_l1_c3_s0[6]),
        .PROPH(PROP_LA_l1_c3_s0[7]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE" ),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_c3_s0_inst1 (
        .COUTB(COUT_LA_l1_c3_s0[4] ),
        .COUTD(COUT_LA_l1_c3_s0[5] ),
        .COUTF(COUT_LA_l1_c3_s0[6] ),
        .COUTH(COUT_LA_l1_c3_s0[7] ),
        .CIN  (CIN_LA_l1_c3_s0[1]  ),
        .CYA  (CY_LA_l1_c3_s0[8]   ),
        .CYB  (CY_LA_l1_c3_s0[9]   ),
        .CYC  (CY_LA_l1_c3_s0[10]  ),
        .CYD  (CY_LA_l1_c3_s0[11]  ),
        .CYE  (CY_LA_l1_c3_s0[12]  ),
        .CYF  (CY_LA_l1_c3_s0[13]  ),
        .CYG  (CY_LA_l1_c3_s0[14]  ),
        .CYH  (CY_LA_l1_c3_s0[15]  ),
        .PROPA(PROP_LA_l1_c3_s0[8] ),
        .PROPB(PROP_LA_l1_c3_s0[9] ),
        .PROPC(PROP_LA_l1_c3_s0[10]),
        .PROPD(PROP_LA_l1_c3_s0[11]),
        .PROPE(PROP_LA_l1_c3_s0[12]),
        .PROPF(PROP_LA_l1_c3_s0[13]),
        .PROPG(PROP_LA_l1_c3_s0[14]),
        .PROPH(PROP_LA_l1_c3_s0[15]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l1_c3_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c3_i0  ),
        .O   (O_c3_2_l1_c3_i0   ),
        .CY  (CY_c3_2_l1_c3_i0  ),
        .PROP(PROP_c3_2_l1_c3_i0));
    
    assign C0_c3_2_l1_c3_i0 = layer1_col28[6:4];
    
    assign layer2_col28[2] = O_c3_2_l1_c3_i0[0];
    
    assign l1_c3_i0            = O_c3_2_l1_c3_i0[1];
    assign CY_LA_l1_c3_s0[0]   = CY_c3_2_l1_c3_i0;
    assign PROP_LA_l1_c3_s0[0] = PROP_c3_2_l1_c3_i0;
    
    assign CIN_LA_l1_c3_s0[0] = C0_c3_2_l1_c3_i0[2];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l1_c3_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c3_i1  ),
        .C1  (C1_c15_3_l1_c3_i1  ),
        .CLA (CLA_c15_3_l1_c3_i1 ),
        .O   (O_c15_3_l1_c3_i1   ),
        .CY  (CY_c15_3_l1_c3_i1  ),
        .PROP(PROP_c15_3_l1_c3_i1));
    
    assign C0_c15_3_l1_c3_i1 = {l1_c3_i0, layer1_col29[4:1]};
    assign C1_c15_3_l1_c3_i1 = layer1_col30[4];
    
    assign layer2_col29[1] = O_c15_3_l1_c3_i1[0];
    assign layer2_col30[1] = O_c15_3_l1_c3_i1[1];
    
    assign CLA_c15_3_l1_c3_i1    = COUT_LA_l1_c3_s0[0];
    assign l1_c3_i1              = O_c15_3_l1_c3_i1[2];
    assign CY_LA_l1_c3_s0[2:1]   = CY_c15_3_l1_c3_i1;
    assign PROP_LA_l1_c3_s0[2:1] = PROP_c15_3_l1_c3_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c3_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c3_i2  ),
        .C1  (C1_c15_3_l1_c3_i2  ),
        .CLA (CLA_c15_3_l1_c3_i2 ),
        .O   (O_c15_3_l1_c3_i2   ),
        .CY  (CY_c15_3_l1_c3_i2  ),
        .PROP(PROP_c15_3_l1_c3_i2));
    
    assign C0_c15_3_l1_c3_i2 = {l1_c3_i1, layer1_col31[4:1]};
    assign C1_c15_3_l1_c3_i2 = layer1_col32[4];
    
    assign layer2_col31[1] = O_c15_3_l1_c3_i2[0];
    assign layer2_col32[1] = O_c15_3_l1_c3_i2[1];
    
    assign CLA_c15_3_l1_c3_i2    = COUT_LA_l1_c3_s0[1];
    assign l1_c3_i2              = O_c15_3_l1_c3_i2[2];
    assign CY_LA_l1_c3_s0[4:3]   = CY_c15_3_l1_c3_i2;
    assign PROP_LA_l1_c3_s0[4:3] = PROP_c15_3_l1_c3_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c3_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c3_i3  ),
        .C1  (C1_c15_3_l1_c3_i3  ),
        .CLA (CLA_c15_3_l1_c3_i3 ),
        .O   (O_c15_3_l1_c3_i3   ),
        .CY  (CY_c15_3_l1_c3_i3  ),
        .PROP(PROP_c15_3_l1_c3_i3));
    
    assign C0_c15_3_l1_c3_i3 = {l1_c3_i2, layer1_col33[4:1]};
    assign C1_c15_3_l1_c3_i3 = layer1_col34[2];
    
    assign layer2_col33[1] = O_c15_3_l1_c3_i3[0];
    assign layer2_col34[1] = O_c15_3_l1_c3_i3[1];
    
    assign CLA_c15_3_l1_c3_i3    = COUT_LA_l1_c3_s0[2];
    assign l1_c3_i3              = O_c15_3_l1_c3_i3[2];
    assign CY_LA_l1_c3_s0[6:5]   = CY_c15_3_l1_c3_i3;
    assign PROP_LA_l1_c3_s0[6:5] = PROP_c15_3_l1_c3_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c3_i4(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c3_i4  ),
        .O   (O_c3_2_l1_c3_i4   ),
        .CY  (CY_c3_2_l1_c3_i4  ),
        .PROP(PROP_c3_2_l1_c3_i4));
    
    assign C0_c3_2_l1_c3_i4 = {l1_c3_i3, layer1_col35[5:4]};
    
    assign layer2_col35[1] = O_c3_2_l1_c3_i4[0];
    
    assign l1_c3_i4            = COUT_LA_l1_c3_s0[3];
    assign CY_LA_l1_c3_s0[7]   = CY_c3_2_l1_c3_i4;
    assign PROP_LA_l1_c3_s0[7] = PROP_c3_2_l1_c3_i4;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c3_i5(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c3_i5  ),
        .C1  (C1_c15_3_l1_c3_i5  ),
        .CLA (CLA_c15_3_l1_c3_i5 ),
        .O   (O_c15_3_l1_c3_i5   ),
        .CY  (CY_c15_3_l1_c3_i5  ),
        .PROP(PROP_c15_3_l1_c3_i5));
    
    assign C0_c15_3_l1_c3_i5 = {l1_c3_i4, layer1_col36[4:1]};
    assign C1_c15_3_l1_c3_i5 = layer1_col37[4];
    
    assign layer2_col36[1] = O_c15_3_l1_c3_i5[0];
    assign layer2_col37[1] = O_c15_3_l1_c3_i5[1];
    
    assign l1_c3_i5              = COUT_LA_l1_c3_s0[4];
    assign CY_LA_l1_c3_s0[9:8]   = CY_c15_3_l1_c3_i5;
    assign PROP_LA_l1_c3_s0[9:8] = PROP_c15_3_l1_c3_i5;
    
    assign CIN_LA_l1_c3_s0[1] = COUT_LA_l1_c3_s0[3];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c3_i6(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c3_i6  ),
        .O   (O_c3_2_l1_c3_i6   ),
        .CY  (CY_c3_2_l1_c3_i6  ),
        .PROP(PROP_c3_2_l1_c3_i6));
    
    assign C0_c3_2_l1_c3_i6 = {l1_c3_i5, layer1_col38[2:1]};
    
    assign layer2_col38[1] = O_c3_2_l1_c3_i6[0];
    
    assign l1_c3_i6             = O_c3_2_l1_c3_i6[1];
    assign CY_LA_l1_c3_s0[10]   = CY_c3_2_l1_c3_i6;
    assign PROP_LA_l1_c3_s0[10] = PROP_c3_2_l1_c3_i6;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("TRUE" ),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c3_i7(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c3_i7  ),
        .C1  (C1_c15_3_l1_c3_i7  ),
        .CLA (CLA_c15_3_l1_c3_i7 ),
        .O   (O_c15_3_l1_c3_i7   ),
        .CY  (CY_c15_3_l1_c3_i7  ),
        .PROP(PROP_c15_3_l1_c3_i7));
    
    assign C0_c15_3_l1_c3_i7 = {l1_c3_i6, layer1_col39[7:4]};
    assign C1_c15_3_l1_c3_i7 = layer1_col40[1];
    
    assign layer2_col39[1] = O_c15_3_l1_c3_i7[0];
    assign layer2_col40[1] = O_c15_3_l1_c3_i7[1];
    
    assign CLA_c15_3_l1_c3_i7      = COUT_LA_l1_c3_s0[5];
    assign l1_c3_i7                = O_c15_3_l1_c3_i7[2];
    assign CY_LA_l1_c3_s0[12:11]   = CY_c15_3_l1_c3_i7;
    assign PROP_LA_l1_c3_s0[12:11] = PROP_c15_3_l1_c3_i7;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c3_i8(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c3_i8  ),
        .O   (O_c3_2_l1_c3_i8   ),
        .CY  (CY_c3_2_l1_c3_i8  ),
        .PROP(PROP_c3_2_l1_c3_i8));
    
    assign C0_c3_2_l1_c3_i8 = {l1_c3_i7, layer1_col41[5:4]};
    
    assign layer2_col41[1] = O_c3_2_l1_c3_i8[0];
    
    assign l1_c3_i8             = COUT_LA_l1_c3_s0[6];
    assign CY_LA_l1_c3_s0[13]   = CY_c3_2_l1_c3_i8;
    assign PROP_LA_l1_c3_s0[13] = PROP_c3_2_l1_c3_i8;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("FALSE"),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("TRUE" ))
    c15_3_l1_c3_i9(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c3_i9  ),
        .C1  (C1_c15_3_l1_c3_i9  ),
        .CLA (CLA_c15_3_l1_c3_i9 ),
        .O   (O_c15_3_l1_c3_i9   ),
        .CY  (CY_c15_3_l1_c3_i9  ),
        .PROP(PROP_c15_3_l1_c3_i9));
    
    assign C0_c15_3_l1_c3_i9 = {l1_c3_i8, layer1_col42[4:1]};
    assign C1_c15_3_l1_c3_i9 = layer1_col43[2];
    
    assign layer2_col42[1] = O_c15_3_l1_c3_i9[0];
    assign layer2_col43[1] = O_c15_3_l1_c3_i9[1];
    assign layer2_col44[1] = O_c15_3_l1_c3_i9[2];
    
    assign l1_c3_i9                = COUT_LA_l1_c3_s0[7];
    assign CY_LA_l1_c3_s0[15:14]   = CY_c15_3_l1_c3_i9;
    assign PROP_LA_l1_c3_s0[15:14] = PROP_c15_3_l1_c3_i9;
    
    // GPC chain4 in layer1:
    // -- (1,5 : 3] at column 27
    // -- (1,5 : 3] at column 29
    // -- (1,5 : 3] at column 31
    // -- (3 : 2] at column 33
    // -- (3 : 2] at column 34
    // -- (3 : 2] at column 35
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l1_c4_s0_inst0 (
        .COUTB(COUT_LA_l1_c4_s0[0]),
        .COUTD(COUT_LA_l1_c4_s0[1]),
        .COUTF(COUT_LA_l1_c4_s0[2]),
        .COUTH(COUT_LA_l1_c4_s0[3]),
        .CIN  (CIN_LA_l1_c4_s0[0] ),
        .CYA  (CY_LA_l1_c4_s0[0]  ),
        .CYB  (CY_LA_l1_c4_s0[1]  ),
        .CYC  (CY_LA_l1_c4_s0[2]  ),
        .CYD  (CY_LA_l1_c4_s0[3]  ),
        .CYE  (CY_LA_l1_c4_s0[4]  ),
        .CYF  (CY_LA_l1_c4_s0[5]  ),
        .CYG  (CY_LA_l1_c4_s0[6]  ),
        .CYH  (CY_LA_l1_c4_s0[7]  ),
        .PROPA(PROP_LA_l1_c4_s0[0]),
        .PROPB(PROP_LA_l1_c4_s0[1]),
        .PROPC(PROP_LA_l1_c4_s0[2]),
        .PROPD(PROP_LA_l1_c4_s0[3]),
        .PROPE(PROP_LA_l1_c4_s0[4]),
        .PROPF(PROP_LA_l1_c4_s0[5]),
        .PROPG(PROP_LA_l1_c4_s0[6]),
        .PROPH(PROP_LA_l1_c4_s0[7]));

    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l1_c4_s0_inst1 (
        .COUTB(COUT_LA_l1_c4_s0[4] ),
        .COUTD(COUT_LA_l1_c4_s0[5] ),
        .COUTF(COUT_LA_l1_c4_s0[6] ),
        .COUTH(COUT_LA_l1_c4_s0[7] ),
        .CIN  (CIN_LA_l1_c4_s0[1]  ),
        .CYA  (CY_LA_l1_c4_s0[8]   ),
        .CYB  (CY_LA_l1_c4_s0[9]   ),
        .CYC  (CY_LA_l1_c4_s0[10]  ),
        .CYD  (CY_LA_l1_c4_s0[11]  ),
        .CYE  (CY_LA_l1_c4_s0[12]  ),
        .CYF  (CY_LA_l1_c4_s0[13]  ),
        .CYG  (CY_LA_l1_c4_s0[14]  ),
        .CYH  (CY_LA_l1_c4_s0[15]  ),
        .PROPA(PROP_LA_l1_c4_s0[8] ),
        .PROPB(PROP_LA_l1_c4_s0[9] ),
        .PROPC(PROP_LA_l1_c4_s0[10]),
        .PROPD(PROP_LA_l1_c4_s0[11]),
        .PROPE(PROP_LA_l1_c4_s0[12]),
        .PROPF(PROP_LA_l1_c4_s0[13]),
        .PROPG(PROP_LA_l1_c4_s0[14]),
        .PROPH(PROP_LA_l1_c4_s0[15]));

    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("TRUE" ),
            .LASTS ("FALSE"))
    c15_3_l1_c4_i0(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c4_i0  ),
        .C1  (C1_c15_3_l1_c4_i0  ),
        .CLA (CLA_c15_3_l1_c4_i0 ),
        .O   (O_c15_3_l1_c4_i0   ),
        .CY  (CY_c15_3_l1_c4_i0  ),
        .PROP(PROP_c15_3_l1_c4_i0));
    
    assign C0_c15_3_l1_c4_i0 = layer1_col27[6:2];
    assign C1_c15_3_l1_c4_i0 = layer1_col28[7];
    
    assign layer2_col27[2] = O_c15_3_l1_c4_i0[0];
    assign layer2_col28[3] = O_c15_3_l1_c4_i0[1];
    
    assign l1_c4_i0              = COUT_LA_l1_c4_s0[0];
    assign CY_LA_l1_c4_s0[1:0]   = CY_c15_3_l1_c4_i0;
    assign PROP_LA_l1_c4_s0[1:0] = PROP_c15_3_l1_c4_i0;
    
    assign CIN_LA_l1_c4_s0[0] = C0_c15_3_l1_c4_i0[4];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c4_i1(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c4_i1  ),
        .C1  (C1_c15_3_l1_c4_i1  ),
        .CLA (CLA_c15_3_l1_c4_i1 ),
        .O   (O_c15_3_l1_c4_i1   ),
        .CY  (CY_c15_3_l1_c4_i1  ),
        .PROP(PROP_c15_3_l1_c4_i1));
    
    assign C0_c15_3_l1_c4_i1 = {l1_c4_i0, layer1_col29[8:5]};
    assign C1_c15_3_l1_c4_i1 = layer1_col30[5];
    
    assign layer2_col29[2] = O_c15_3_l1_c4_i1[0];
    assign layer2_col30[2] = O_c15_3_l1_c4_i1[1];
    
    assign l1_c4_i1              = COUT_LA_l1_c4_s0[1];
    assign CY_LA_l1_c4_s0[3:2]   = CY_c15_3_l1_c4_i1;
    assign PROP_LA_l1_c4_s0[3:2] = PROP_c15_3_l1_c4_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l1_c4_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l1_c4_i2  ),
        .C1  (C1_c15_3_l1_c4_i2  ),
        .CLA (CLA_c15_3_l1_c4_i2 ),
        .O   (O_c15_3_l1_c4_i2   ),
        .CY  (CY_c15_3_l1_c4_i2  ),
        .PROP(PROP_c15_3_l1_c4_i2));
    
    assign C0_c15_3_l1_c4_i2 = {l1_c4_i1, layer1_col31[8:5]};
    assign C1_c15_3_l1_c4_i2 = layer1_col32[5];
    
    assign layer2_col31[2] = O_c15_3_l1_c4_i2[0];
    assign layer2_col32[2] = O_c15_3_l1_c4_i2[1];
    
    assign l1_c4_i2              = COUT_LA_l1_c4_s0[2];
    assign CY_LA_l1_c4_s0[5:4]   = CY_c15_3_l1_c4_i2;
    assign PROP_LA_l1_c4_s0[5:4] = PROP_c15_3_l1_c4_i2;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c4_i3(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c4_i3  ),
        .O   (O_c3_2_l1_c4_i3   ),
        .CY  (CY_c3_2_l1_c4_i3  ),
        .PROP(PROP_c3_2_l1_c4_i3));
    
    assign C0_c3_2_l1_c4_i3 = {l1_c4_i2, layer1_col33[6:5]};
    
    assign layer2_col33[2] = O_c3_2_l1_c4_i3[0];
    
    assign l1_c4_i3            = O_c3_2_l1_c4_i3[1];
    assign CY_LA_l1_c4_s0[6]   = CY_c3_2_l1_c4_i3;
    assign PROP_LA_l1_c4_s0[6] = PROP_c3_2_l1_c4_i3;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_c4_i4(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c4_i4  ),
        .O   (O_c3_2_l1_c4_i4   ),
        .CY  (CY_c3_2_l1_c4_i4  ),
        .PROP(PROP_c3_2_l1_c4_i4));
    
    assign C0_c3_2_l1_c4_i4 = {l1_c4_i3, layer1_col34[4:3]};
    
    assign layer2_col34[2] = O_c3_2_l1_c4_i4[0];
    
    assign l1_c4_i4            = COUT_LA_l1_c4_s0[3];
    assign CY_LA_l1_c4_s0[7]   = CY_c3_2_l1_c4_i4;
    assign PROP_LA_l1_c4_s0[7] = PROP_c3_2_l1_c4_i4;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l1_c4_i5(
        .clk (clk               ),
        .C0  (C0_c3_2_l1_c4_i5  ),
        .O   (O_c3_2_l1_c4_i5   ),
        .CY  (CY_c3_2_l1_c4_i5  ),
        .PROP(PROP_c3_2_l1_c4_i5));
    
    assign C0_c3_2_l1_c4_i5 = {l1_c4_i4, layer1_col35[7:6]};
    
    assign layer2_col35[2] = O_c3_2_l1_c4_i5[0];
    assign layer2_col36[2] = O_c3_2_l1_c4_i5[1];
    
    assign l1_c4_i5            = O_c3_2_l1_c4_i5[1];
    assign CY_LA_l1_c4_s0[8]   = CY_c3_2_l1_c4_i5;
    assign PROP_LA_l1_c4_s0[8] = PROP_c3_2_l1_c4_i5;
    
    assign CIN_LA_l1_c4_s0[1] = COUT_LA_l1_c4_s0[3];
    
    // GPC0 in layer1: (3 : 2] at column 32
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l1_f0(
        .clk (clk            ),
        .C0  (C0_c3_2_l1_f0  ),
        .O   (O_c3_2_l1_i0   ),
        .CY  (CY_c3_2_l1_f0  ),
        .PROP(PROP_c3_2_l1_f0));
    
    assign C0_c3_2_l1_f0 = layer1_col32[8:6];
    
    assign layer2_col32[3] = O_c3_2_l1_i0[0];
    assign layer2_col33[3] = O_c3_2_l1_i0[1];
    
    assign layer2_col0[0] = layer1_col0[0];
    assign layer2_col0[1] = layer1_col0[1];
    assign layer2_col1    = layer1_col1;
    assign layer2_col2[0] = layer1_col2[0];
    assign layer2_col2[1] = layer1_col2[1];
    assign layer2_col2[2] = layer1_col2[2];
    assign layer2_col3[0] = layer1_col3[0];
    assign layer2_col3[1] = layer1_col3[1];
    assign layer2_col4[0] = layer1_col4[0];
    assign layer2_col4[1] = layer1_col4[1];
    assign layer2_col4[2] = layer1_col4[2];
    assign layer2_col4[3] = layer1_col4[3];
    assign layer2_col5[0] = layer1_col5[0];
    assign layer2_col5[1] = layer1_col5[1];
    assign layer2_col5[2] = layer1_col5[2];
    assign layer2_col6[0] = layer1_col6[0];
    assign layer2_col6[1] = layer1_col6[1];
    assign layer2_col6[2] = layer1_col6[2];
    assign layer2_col7[0] = layer1_col7[0];
    assign layer2_col7[1] = layer1_col7[1];
    assign layer2_col7[2] = layer1_col7[2];
    assign layer2_col8[0] = layer1_col8[0];
    assign layer2_col8[1] = layer1_col8[1];
    assign layer2_col8[2] = layer1_col8[2];
    assign layer2_col9[0] = layer1_col9[0];
    assign layer2_col9[1] = layer1_col9[1];
    assign layer2_col9[2] = layer1_col9[2];
    assign layer2_col10[0] = layer1_col10[0];
    assign layer2_col10[1] = layer1_col10[1];
    assign layer2_col10[2] = layer1_col10[2];
    assign layer2_col11[0] = layer1_col11[0];
    assign layer2_col11[1] = layer1_col11[1];
    assign layer2_col11[2] = layer1_col11[2];
    assign layer2_col12[0] = layer1_col12[0];
    assign layer2_col12[1] = layer1_col12[1];
    assign layer2_col12[2] = layer1_col12[2];
    assign layer2_col13[0] = layer1_col13[0];
    assign layer2_col13[1] = layer1_col13[1];
    assign layer2_col13[2] = layer1_col13[2];
    assign layer2_col14[0] = layer1_col14[0];
    assign layer2_col14[1] = layer1_col14[1];
    assign layer2_col14[2] = layer1_col14[2];
    assign layer2_col15[1] = layer1_col15[3];
    assign layer2_col15[2] = layer1_col15[4];
    assign layer2_col16[1] = layer1_col16[2];
    assign layer2_col16[2] = layer1_col16[3];
    assign layer2_col17[1] = layer1_col17[2];
    assign layer2_col17[2] = layer1_col17[3];
    assign layer2_col18[1] = layer1_col18[2];
    assign layer2_col18[2] = layer1_col18[3];
    assign layer2_col19[2] = layer1_col19[7];
    assign layer2_col20[2] = layer1_col20[3];
    assign layer2_col21[2] = layer1_col21[4];
    assign layer2_col22[2] = layer1_col22[6];
    assign layer2_col23[2] = layer1_col23[5];
    assign layer2_col24[3] = layer1_col24[6];
    assign layer2_col24[4] = layer1_col24[7];
    assign layer2_col25[2] = layer1_col25[3];
    assign layer2_col25[3] = layer1_col25[4];
    assign layer2_col26[2] = layer1_col26[8];
    assign layer2_col26[3] = layer1_col26[9];
    assign layer2_col27[3] = layer1_col27[7];
    assign layer2_col29[3] = layer1_col29[9];
    assign layer2_col33[4] = layer1_col33[7];
    assign layer2_col36[3] = layer1_col36[5];
    assign layer2_col37[2] = layer1_col37[5];
    assign layer2_col38[2] = layer1_col38[3];
    assign layer2_col38[3] = layer1_col38[4];
    assign layer2_col39[2] = layer1_col39[8];
    assign layer2_col40[2] = layer1_col40[2];
    assign layer2_col40[3] = layer1_col40[3];
    assign layer2_col41[2] = layer1_col41[6];
    assign layer2_col42[2] = layer1_col42[5];
    assign layer2_col42[3] = layer1_col42[6];
    assign layer2_col43[2] = layer1_col43[3];
    assign layer2_col44[2] = layer1_col44[2];
    assign layer2_col44[3] = layer1_col44[3];
    assign layer2_col45[1] = layer1_col45[2];
    assign layer2_col45[2] = layer1_col45[3];
    assign layer2_col46[1] = layer1_col46[0];
    assign layer2_col46[2] = layer1_col46[1];
    assign layer2_col46[3] = layer1_col46[2];
    assign layer2_col47[0] = layer1_col47[0];
    assign layer2_col47[1] = layer1_col47[1];
    assign layer2_col47[2] = layer1_col47[2];
    assign layer2_col48[0] = layer1_col48[0];
    assign layer2_col48[1] = layer1_col48[1];
    assign layer2_col48[2] = layer1_col48[2];
    assign layer2_col48[3] = layer1_col48[3];
    assign layer2_col49[0] = layer1_col49[0];
    assign layer2_col49[1] = layer1_col49[1];
    assign layer2_col49[2] = layer1_col49[2];
    assign layer2_col50[0] = layer1_col50[0];
    assign layer2_col50[1] = layer1_col50[1];
    assign layer2_col50[2] = layer1_col50[2];
    assign layer2_col50[3] = layer1_col50[3];
    assign layer2_col51[0] = layer1_col51[0];
    assign layer2_col51[1] = layer1_col51[1];
    assign layer2_col51[2] = layer1_col51[2];
    assign layer2_col52[0] = layer1_col52[0];
    assign layer2_col52[1] = layer1_col52[1];
    assign layer2_col52[2] = layer1_col52[2];
    assign layer2_col52[3] = layer1_col52[3];
    assign layer2_col53[0] = layer1_col53[0];
    assign layer2_col53[1] = layer1_col53[1];
    assign layer2_col53[2] = layer1_col53[2];
    assign layer2_col54[0] = layer1_col54[0];
    assign layer2_col54[1] = layer1_col54[1];
    assign layer2_col54[2] = layer1_col54[2];
    assign layer2_col54[3] = layer1_col54[3];
    assign layer2_col55[0] = layer1_col55[0];
    assign layer2_col55[1] = layer1_col55[1];
    assign layer2_col55[2] = layer1_col55[2];
    assign layer2_col56[0] = layer1_col56[0];
    assign layer2_col56[1] = layer1_col56[1];
    assign layer2_col57[0] = layer1_col57[0];
    assign layer2_col57[1] = layer1_col57[1];
    assign layer2_col58    = layer1_col58;
    assign layer2_col59    = layer1_col59;
    // ------------------------------ LAYER 2 ------------------------------
    // GPC chain0 in layer2:
    // -- (2,2,3 : 4] at column 24
    // -- (2,2,3 : 4] at column 27
    
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

    c223_4 #(.OUTREG("FALSE"),
             .LEAVEC("TRUE" ),
             .POSODD("FALSE"))
    c223_4_l2_c0_i0(
        .clk (clk                 ),
        .C0  (C0_c223_4_l2_c0_i0  ),
        .C1  (C1_c223_4_l2_c0_i0  ),
        .C2  (C2_c223_4_l2_c0_i0  ),
        .CLA (CLA_c223_4_l2_c0_i0 ),
        .O   (O_c223_4_l2_c0_i0   ),
        .CY  (CY_c223_4_l2_c0_i0  ),
        .PROP(PROP_c223_4_l2_c0_i0));
    
    assign C0_c223_4_l2_c0_i0 = layer2_col24[2:0];
    assign C1_c223_4_l2_c0_i0 = layer2_col25[1:0];
    assign C2_c223_4_l2_c0_i0 = layer2_col26[1:0];
    
    assign layer3_col24[0] = O_c223_4_l2_c0_i0[0];
    assign layer3_col25[0] = O_c223_4_l2_c0_i0[1];
    assign layer3_col26[0] = O_c223_4_l2_c0_i0[2];
    
    assign l2_c0_i0              = COUT_LA_l2_c0_s0[0];
    assign CY_LA_l2_c0_s0[1:0]   = CY_c223_4_l2_c0_i0;
    assign PROP_LA_l2_c0_s0[1:0] = PROP_c223_4_l2_c0_i0;
    
    assign CIN_LA_l2_c0_s0    = C0_c223_4_l2_c0_i0[2];
    
    c223_4 #(.OUTREG("FALSE"),
             .LEAVEC("FALSE"),
             .POSODD("FALSE"))
    c223_4_l2_c0_i1(
        .clk (clk                 ),
        .C0  (C0_c223_4_l2_c0_i1  ),
        .C1  (C1_c223_4_l2_c0_i1  ),
        .C2  (C2_c223_4_l2_c0_i1  ),
        .CLA (CLA_c223_4_l2_c0_i1 ),
        .O   (O_c223_4_l2_c0_i1   ),
        .CY  (CY_c223_4_l2_c0_i1  ),
        .PROP(PROP_c223_4_l2_c0_i1));
    
    assign C0_c223_4_l2_c0_i1 = {l2_c0_i0, layer2_col27[1:0]};
    assign C1_c223_4_l2_c0_i1 = layer2_col28[1:0];
    assign C2_c223_4_l2_c0_i1 = layer2_col29[1:0];
    
    assign layer3_col27[0] = O_c223_4_l2_c0_i1[0];
    assign layer3_col28[0] = O_c223_4_l2_c0_i1[1];
    assign layer3_col29[0] = O_c223_4_l2_c0_i1[2];
    assign layer3_col30[0] = O_c223_4_l2_c0_i1[3];
    
    assign l2_c0_i1              = COUT_LA_l2_c0_s0[1];
    assign CY_LA_l2_c0_s0[3:2]   = CY_c223_4_l2_c0_i1;
    assign PROP_LA_l2_c0_s0[3:2] = PROP_c223_4_l2_c0_i1;
    
    // GPC0 in layer2: (3 : 2] at column 33
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l2_f0(
        .clk (clk            ),
        .C0  (C0_c3_2_l2_f0  ),
        .O   (O_c3_2_l2_i0   ),
        .CY  (CY_c3_2_l2_f0  ),
        .PROP(PROP_c3_2_l2_f0));
    
    assign C0_c3_2_l2_f0 = layer2_col33[2:0];
    
    assign layer3_col33[0] = O_c3_2_l2_i0[0];
    assign layer3_col34[0] = O_c3_2_l2_i0[1];
    
    assign layer3_col0[0] = layer2_col0[0];
    assign layer3_col0[1] = layer2_col0[1];
    assign layer3_col1    = layer2_col1;
    assign layer3_col2[0] = layer2_col2[0];
    assign layer3_col2[1] = layer2_col2[1];
    assign layer3_col2[2] = layer2_col2[2];
    assign layer3_col3[0] = layer2_col3[0];
    assign layer3_col3[1] = layer2_col3[1];
    assign layer3_col4[0] = layer2_col4[0];
    assign layer3_col4[1] = layer2_col4[1];
    assign layer3_col4[2] = layer2_col4[2];
    assign layer3_col4[3] = layer2_col4[3];
    assign layer3_col5[0] = layer2_col5[0];
    assign layer3_col5[1] = layer2_col5[1];
    assign layer3_col5[2] = layer2_col5[2];
    assign layer3_col6[0] = layer2_col6[0];
    assign layer3_col6[1] = layer2_col6[1];
    assign layer3_col6[2] = layer2_col6[2];
    assign layer3_col7[0] = layer2_col7[0];
    assign layer3_col7[1] = layer2_col7[1];
    assign layer3_col7[2] = layer2_col7[2];
    assign layer3_col8[0] = layer2_col8[0];
    assign layer3_col8[1] = layer2_col8[1];
    assign layer3_col8[2] = layer2_col8[2];
    assign layer3_col9[0] = layer2_col9[0];
    assign layer3_col9[1] = layer2_col9[1];
    assign layer3_col9[2] = layer2_col9[2];
    assign layer3_col10[0] = layer2_col10[0];
    assign layer3_col10[1] = layer2_col10[1];
    assign layer3_col10[2] = layer2_col10[2];
    assign layer3_col11[0] = layer2_col11[0];
    assign layer3_col11[1] = layer2_col11[1];
    assign layer3_col11[2] = layer2_col11[2];
    assign layer3_col12[0] = layer2_col12[0];
    assign layer3_col12[1] = layer2_col12[1];
    assign layer3_col12[2] = layer2_col12[2];
    assign layer3_col13[0] = layer2_col13[0];
    assign layer3_col13[1] = layer2_col13[1];
    assign layer3_col13[2] = layer2_col13[2];
    assign layer3_col14[0] = layer2_col14[0];
    assign layer3_col14[1] = layer2_col14[1];
    assign layer3_col14[2] = layer2_col14[2];
    assign layer3_col15[0] = layer2_col15[0];
    assign layer3_col15[1] = layer2_col15[1];
    assign layer3_col15[2] = layer2_col15[2];
    assign layer3_col16[0] = layer2_col16[0];
    assign layer3_col16[1] = layer2_col16[1];
    assign layer3_col16[2] = layer2_col16[2];
    assign layer3_col17[0] = layer2_col17[0];
    assign layer3_col17[1] = layer2_col17[1];
    assign layer3_col17[2] = layer2_col17[2];
    assign layer3_col18[0] = layer2_col18[0];
    assign layer3_col18[1] = layer2_col18[1];
    assign layer3_col18[2] = layer2_col18[2];
    assign layer3_col19[0] = layer2_col19[0];
    assign layer3_col19[1] = layer2_col19[1];
    assign layer3_col19[2] = layer2_col19[2];
    assign layer3_col20[0] = layer2_col20[0];
    assign layer3_col20[1] = layer2_col20[1];
    assign layer3_col20[2] = layer2_col20[2];
    assign layer3_col21[0] = layer2_col21[0];
    assign layer3_col21[1] = layer2_col21[1];
    assign layer3_col21[2] = layer2_col21[2];
    assign layer3_col22[0] = layer2_col22[0];
    assign layer3_col22[1] = layer2_col22[1];
    assign layer3_col22[2] = layer2_col22[2];
    assign layer3_col23[0] = layer2_col23[0];
    assign layer3_col23[1] = layer2_col23[1];
    assign layer3_col23[2] = layer2_col23[2];
    assign layer3_col24[1] = layer2_col24[3];
    assign layer3_col24[2] = layer2_col24[4];
    assign layer3_col25[1] = layer2_col25[2];
    assign layer3_col25[2] = layer2_col25[3];
    assign layer3_col26[1] = layer2_col26[2];
    assign layer3_col26[2] = layer2_col26[3];
    assign layer3_col27[1] = layer2_col27[2];
    assign layer3_col27[2] = layer2_col27[3];
    assign layer3_col28[1] = layer2_col28[2];
    assign layer3_col28[2] = layer2_col28[3];
    assign layer3_col29[1] = layer2_col29[2];
    assign layer3_col29[2] = layer2_col29[3];
    assign layer3_col30[1] = layer2_col30[0];
    assign layer3_col30[2] = layer2_col30[1];
    assign layer3_col30[3] = layer2_col30[2];
    assign layer3_col31[0] = layer2_col31[0];
    assign layer3_col31[1] = layer2_col31[1];
    assign layer3_col31[2] = layer2_col31[2];
    assign layer3_col32[0] = layer2_col32[0];
    assign layer3_col32[1] = layer2_col32[1];
    assign layer3_col32[2] = layer2_col32[2];
    assign layer3_col32[3] = layer2_col32[3];
    assign layer3_col33[1] = layer2_col33[3];
    assign layer3_col33[2] = layer2_col33[4];
    assign layer3_col34[1] = layer2_col34[0];
    assign layer3_col34[2] = layer2_col34[1];
    assign layer3_col34[3] = layer2_col34[2];
    assign layer3_col35[0] = layer2_col35[0];
    assign layer3_col35[1] = layer2_col35[1];
    assign layer3_col35[2] = layer2_col35[2];
    assign layer3_col36[0] = layer2_col36[0];
    assign layer3_col36[1] = layer2_col36[1];
    assign layer3_col36[2] = layer2_col36[2];
    assign layer3_col36[3] = layer2_col36[3];
    assign layer3_col37[0] = layer2_col37[0];
    assign layer3_col37[1] = layer2_col37[1];
    assign layer3_col37[2] = layer2_col37[2];
    assign layer3_col38[0] = layer2_col38[0];
    assign layer3_col38[1] = layer2_col38[1];
    assign layer3_col38[2] = layer2_col38[2];
    assign layer3_col38[3] = layer2_col38[3];
    assign layer3_col39[0] = layer2_col39[0];
    assign layer3_col39[1] = layer2_col39[1];
    assign layer3_col39[2] = layer2_col39[2];
    assign layer3_col40[0] = layer2_col40[0];
    assign layer3_col40[1] = layer2_col40[1];
    assign layer3_col40[2] = layer2_col40[2];
    assign layer3_col40[3] = layer2_col40[3];
    assign layer3_col41[0] = layer2_col41[0];
    assign layer3_col41[1] = layer2_col41[1];
    assign layer3_col41[2] = layer2_col41[2];
    assign layer3_col42[0] = layer2_col42[0];
    assign layer3_col42[1] = layer2_col42[1];
    assign layer3_col42[2] = layer2_col42[2];
    assign layer3_col42[3] = layer2_col42[3];
    assign layer3_col43[0] = layer2_col43[0];
    assign layer3_col43[1] = layer2_col43[1];
    assign layer3_col43[2] = layer2_col43[2];
    assign layer3_col44[0] = layer2_col44[0];
    assign layer3_col44[1] = layer2_col44[1];
    assign layer3_col44[2] = layer2_col44[2];
    assign layer3_col44[3] = layer2_col44[3];
    assign layer3_col45[0] = layer2_col45[0];
    assign layer3_col45[1] = layer2_col45[1];
    assign layer3_col45[2] = layer2_col45[2];
    assign layer3_col46[0] = layer2_col46[0];
    assign layer3_col46[1] = layer2_col46[1];
    assign layer3_col46[2] = layer2_col46[2];
    assign layer3_col46[3] = layer2_col46[3];
    assign layer3_col47[0] = layer2_col47[0];
    assign layer3_col47[1] = layer2_col47[1];
    assign layer3_col47[2] = layer2_col47[2];
    assign layer3_col48[0] = layer2_col48[0];
    assign layer3_col48[1] = layer2_col48[1];
    assign layer3_col48[2] = layer2_col48[2];
    assign layer3_col48[3] = layer2_col48[3];
    assign layer3_col49[0] = layer2_col49[0];
    assign layer3_col49[1] = layer2_col49[1];
    assign layer3_col49[2] = layer2_col49[2];
    assign layer3_col50[0] = layer2_col50[0];
    assign layer3_col50[1] = layer2_col50[1];
    assign layer3_col50[2] = layer2_col50[2];
    assign layer3_col50[3] = layer2_col50[3];
    assign layer3_col51[0] = layer2_col51[0];
    assign layer3_col51[1] = layer2_col51[1];
    assign layer3_col51[2] = layer2_col51[2];
    assign layer3_col52[0] = layer2_col52[0];
    assign layer3_col52[1] = layer2_col52[1];
    assign layer3_col52[2] = layer2_col52[2];
    assign layer3_col52[3] = layer2_col52[3];
    assign layer3_col53[0] = layer2_col53[0];
    assign layer3_col53[1] = layer2_col53[1];
    assign layer3_col53[2] = layer2_col53[2];
    assign layer3_col54[0] = layer2_col54[0];
    assign layer3_col54[1] = layer2_col54[1];
    assign layer3_col54[2] = layer2_col54[2];
    assign layer3_col54[3] = layer2_col54[3];
    assign layer3_col55[0] = layer2_col55[0];
    assign layer3_col55[1] = layer2_col55[1];
    assign layer3_col55[2] = layer2_col55[2];
    assign layer3_col56[0] = layer2_col56[0];
    assign layer3_col56[1] = layer2_col56[1];
    assign layer3_col57[0] = layer2_col57[0];
    assign layer3_col57[1] = layer2_col57[1];
    assign layer3_col58    = layer2_col58;
    assign layer3_col59    = layer2_col59;
    
    
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

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst3 (
        .COUTB(COUT_LA_terminal_chain1[12]),
        .COUTD(COUT_LA_terminal_chain1[13]),
        .COUTF(COUT_LA_terminal_chain1[14]),
        .COUTH(COUT_LA_terminal_chain1[15]),
        .CIN  (CIN_LA_terminal_chain1[3]  ),
        .CYA  (CY_LA_terminal_chain1[24]  ),
        .CYB  (CY_LA_terminal_chain1[25]  ),
        .CYC  (CY_LA_terminal_chain1[26]  ),
        .CYD  (CY_LA_terminal_chain1[27]  ),
        .CYE  (CY_LA_terminal_chain1[28]  ),
        .CYF  (CY_LA_terminal_chain1[29]  ),
        .CYG  (CY_LA_terminal_chain1[30]  ),
        .CYH  (CY_LA_terminal_chain1[31]  ),
        .PROPA(PROP_LA_terminal_chain1[24]),
        .PROPB(PROP_LA_terminal_chain1[25]),
        .PROPC(PROP_LA_terminal_chain1[26]),
        .PROPD(PROP_LA_terminal_chain1[27]),
        .PROPE(PROP_LA_terminal_chain1[28]),
        .PROPF(PROP_LA_terminal_chain1[29]),
        .PROPG(PROP_LA_terminal_chain1[30]),
        .PROPH(PROP_LA_terminal_chain1[31]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst4 (
        .COUTB(COUT_LA_terminal_chain1[16]),
        .COUTD(COUT_LA_terminal_chain1[17]),
        .COUTF(COUT_LA_terminal_chain1[18]),
        .COUTH(COUT_LA_terminal_chain1[19]),
        .CIN  (CIN_LA_terminal_chain1[4]  ),
        .CYA  (CY_LA_terminal_chain1[32]  ),
        .CYB  (CY_LA_terminal_chain1[33]  ),
        .CYC  (CY_LA_terminal_chain1[34]  ),
        .CYD  (CY_LA_terminal_chain1[35]  ),
        .CYE  (CY_LA_terminal_chain1[36]  ),
        .CYF  (CY_LA_terminal_chain1[37]  ),
        .CYG  (CY_LA_terminal_chain1[38]  ),
        .CYH  (CY_LA_terminal_chain1[39]  ),
        .PROPA(PROP_LA_terminal_chain1[32]),
        .PROPB(PROP_LA_terminal_chain1[33]),
        .PROPC(PROP_LA_terminal_chain1[34]),
        .PROPD(PROP_LA_terminal_chain1[35]),
        .PROPE(PROP_LA_terminal_chain1[36]),
        .PROPF(PROP_LA_terminal_chain1[37]),
        .PROPG(PROP_LA_terminal_chain1[38]),
        .PROPH(PROP_LA_terminal_chain1[39]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst5 (
        .COUTB(COUT_LA_terminal_chain1[20]),
        .COUTD(COUT_LA_terminal_chain1[21]),
        .COUTF(COUT_LA_terminal_chain1[22]),
        .COUTH(COUT_LA_terminal_chain1[23]),
        .CIN  (CIN_LA_terminal_chain1[5]  ),
        .CYA  (CY_LA_terminal_chain1[40]  ),
        .CYB  (CY_LA_terminal_chain1[41]  ),
        .CYC  (CY_LA_terminal_chain1[42]  ),
        .CYD  (CY_LA_terminal_chain1[43]  ),
        .CYE  (CY_LA_terminal_chain1[44]  ),
        .CYF  (CY_LA_terminal_chain1[45]  ),
        .CYG  (CY_LA_terminal_chain1[46]  ),
        .CYH  (CY_LA_terminal_chain1[47]  ),
        .PROPA(PROP_LA_terminal_chain1[40]),
        .PROPB(PROP_LA_terminal_chain1[41]),
        .PROPC(PROP_LA_terminal_chain1[42]),
        .PROPD(PROP_LA_terminal_chain1[43]),
        .PROPE(PROP_LA_terminal_chain1[44]),
        .PROPF(PROP_LA_terminal_chain1[45]),
        .PROPG(PROP_LA_terminal_chain1[46]),
        .PROPH(PROP_LA_terminal_chain1[47]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst6 (
        .COUTB(COUT_LA_terminal_chain1[24]),
        .COUTD(COUT_LA_terminal_chain1[25]),
        .COUTF(COUT_LA_terminal_chain1[26]),
        .COUTH(COUT_LA_terminal_chain1[27]),
        .CIN  (CIN_LA_terminal_chain1[6]  ),
        .CYA  (CY_LA_terminal_chain1[48]  ),
        .CYB  (CY_LA_terminal_chain1[49]  ),
        .CYC  (CY_LA_terminal_chain1[50]  ),
        .CYD  (CY_LA_terminal_chain1[51]  ),
        .CYE  (CY_LA_terminal_chain1[52]  ),
        .CYF  (CY_LA_terminal_chain1[53]  ),
        .CYG  (CY_LA_terminal_chain1[54]  ),
        .CYH  (CY_LA_terminal_chain1[55]  ),
        .PROPA(PROP_LA_terminal_chain1[48]),
        .PROPB(PROP_LA_terminal_chain1[49]),
        .PROPC(PROP_LA_terminal_chain1[50]),
        .PROPD(PROP_LA_terminal_chain1[51]),
        .PROPE(PROP_LA_terminal_chain1[52]),
        .PROPF(PROP_LA_terminal_chain1[53]),
        .PROPG(PROP_LA_terminal_chain1[54]),
        .PROPH(PROP_LA_terminal_chain1[55]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain1_inst7 (
        .COUTB(COUT_LA_terminal_chain1[28]),
        .COUTD(COUT_LA_terminal_chain1[29]),
        .COUTF(COUT_LA_terminal_chain1[30]),
        .COUTH(COUT_LA_terminal_chain1[31]),
        .CIN  (CIN_LA_terminal_chain1[7]  ),
        .CYA  (CY_LA_terminal_chain1[56]  ),
        .CYB  (CY_LA_terminal_chain1[57]  ),
        .CYC  (CY_LA_terminal_chain1[58]  ),
        .CYD  (CY_LA_terminal_chain1[59]  ),
        .CYE  (CY_LA_terminal_chain1[60]  ),
        .CYF  (CY_LA_terminal_chain1[61]  ),
        .CYG  (CY_LA_terminal_chain1[62]  ),
        .CYH  (CY_LA_terminal_chain1[63]  ),
        .PROPA(PROP_LA_terminal_chain1[56]),
        .PROPB(PROP_LA_terminal_chain1[57]),
        .PROPC(PROP_LA_terminal_chain1[58]),
        .PROPD(PROP_LA_terminal_chain1[59]),
        .PROPE(PROP_LA_terminal_chain1[60]),
        .PROPF(PROP_LA_terminal_chain1[61]),
        .PROPG(PROP_LA_terminal_chain1[62]),
        .PROPH(PROP_LA_terminal_chain1[63]));

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
    
    assign C0_c3_2_terminal_chain1_i0[0] = layer3_col0[0];
    assign C0_c3_2_terminal_chain1_i0[1] = layer3_col0[1];
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
    assign C0_c3_2_terminal_chain1_i1[0] = layer3_col1;
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer3_col2[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer3_col2[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer3_col2[2];
    assign C1_c15_3_terminal_chain1_i2    = layer3_col3[0];
    
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
    assign C0_c15_3_terminal_chain1_i3[0] = layer3_col4[0];
    assign C0_c15_3_terminal_chain1_i3[1] = layer3_col4[1];
    assign C0_c15_3_terminal_chain1_i3[2] = layer3_col4[2];
    assign C0_c15_3_terminal_chain1_i3[3] = layer3_col4[3];
    assign C1_c15_3_terminal_chain1_i3    = layer3_col5[0];
    
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
    assign C0_c15_3_terminal_chain1_i4[1] = layer3_col6[0];
    assign C0_c15_3_terminal_chain1_i4[2] = layer3_col6[1];
    assign C0_c15_3_terminal_chain1_i4[3] = layer3_col6[2];
    assign C1_c15_3_terminal_chain1_i4    = layer3_col7[0];
    
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
    assign C0_c15_3_terminal_chain1_i5[1] = layer3_col8[0];
    assign C0_c15_3_terminal_chain1_i5[2] = layer3_col8[1];
    assign C0_c15_3_terminal_chain1_i5[3] = layer3_col8[2];
    assign C1_c15_3_terminal_chain1_i5    = layer3_col9[0];
    
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
    assign C0_c15_3_terminal_chain1_i6[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i6[1] = layer3_col10[0];
    assign C0_c15_3_terminal_chain1_i6[2] = layer3_col10[1];
    assign C0_c15_3_terminal_chain1_i6[3] = layer3_col10[2];
    assign C1_c15_3_terminal_chain1_i6    = layer3_col11[0];
    
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
    assign C0_c15_3_terminal_chain1_i7[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i7[1] = layer3_col12[0];
    assign C0_c15_3_terminal_chain1_i7[2] = layer3_col12[1];
    assign C0_c15_3_terminal_chain1_i7[3] = layer3_col12[2];
    assign C1_c15_3_terminal_chain1_i7    = layer3_col13[0];
    
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
    assign C0_c15_3_terminal_chain1_i8[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i8[1] = layer3_col14[0];
    assign C0_c15_3_terminal_chain1_i8[2] = layer3_col14[1];
    assign C0_c15_3_terminal_chain1_i8[3] = layer3_col14[2];
    assign C1_c15_3_terminal_chain1_i8    = layer3_col15[0];
    
    assign terminal_chain1_out[14] = O_c15_3_terminal_chain1_i8[0];
    assign terminal_chain1_out[15] = O_c15_3_terminal_chain1_i8[1];
    
    assign terminal_chain1_i8             = COUT_LA_terminal_chain1[7];
    assign CY_LA_terminal_chain1[15:14]   = CY_c15_3_terminal_chain1_i8;
    assign PROP_LA_terminal_chain1[15:14] = PROP_c15_3_terminal_chain1_i8;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i9(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain1_i9  ),
        .C1  (C1_c15_3_terminal_chain1_i9  ),
        .CLA (CLA_c15_3_terminal_chain1_i9 ),
        .O   (O_c15_3_terminal_chain1_i9   ),
        .CY  (CY_c15_3_terminal_chain1_i9  ),
        .PROP(PROP_c15_3_terminal_chain1_i9));
    
    assign C0_c15_3_terminal_chain1_i9[4] = terminal_chain1_i8;
    assign C0_c15_3_terminal_chain1_i9[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i9[1] = layer3_col16[0];
    assign C0_c15_3_terminal_chain1_i9[2] = layer3_col16[1];
    assign C0_c15_3_terminal_chain1_i9[3] = layer3_col16[2];
    assign C1_c15_3_terminal_chain1_i9    = layer3_col17[0];
    
    assign terminal_chain1_out[16] = O_c15_3_terminal_chain1_i9[0];
    assign terminal_chain1_out[17] = O_c15_3_terminal_chain1_i9[1];
    
    assign terminal_chain1_i9             = COUT_LA_terminal_chain1[8];
    assign CY_LA_terminal_chain1[17:16]   = CY_c15_3_terminal_chain1_i9;
    assign PROP_LA_terminal_chain1[17:16] = PROP_c15_3_terminal_chain1_i9;
    
    assign CIN_LA_terminal_chain1[2] = COUT_LA_terminal_chain1[7];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i10(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i10  ),
        .C1  (C1_c15_3_terminal_chain1_i10  ),
        .CLA (CLA_c15_3_terminal_chain1_i10 ),
        .O   (O_c15_3_terminal_chain1_i10   ),
        .CY  (CY_c15_3_terminal_chain1_i10  ),
        .PROP(PROP_c15_3_terminal_chain1_i10));
    
    assign C0_c15_3_terminal_chain1_i10[4] = terminal_chain1_i9;
    assign C0_c15_3_terminal_chain1_i10[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i10[1] = layer3_col18[0];
    assign C0_c15_3_terminal_chain1_i10[2] = layer3_col18[1];
    assign C0_c15_3_terminal_chain1_i10[3] = layer3_col18[2];
    assign C1_c15_3_terminal_chain1_i10    = layer3_col19[0];
    
    assign terminal_chain1_out[18] = O_c15_3_terminal_chain1_i10[0];
    assign terminal_chain1_out[19] = O_c15_3_terminal_chain1_i10[1];
    
    assign terminal_chain1_i10            = COUT_LA_terminal_chain1[9];
    assign CY_LA_terminal_chain1[19:18]   = CY_c15_3_terminal_chain1_i10;
    assign PROP_LA_terminal_chain1[19:18] = PROP_c15_3_terminal_chain1_i10;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i11(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i11  ),
        .C1  (C1_c15_3_terminal_chain1_i11  ),
        .CLA (CLA_c15_3_terminal_chain1_i11 ),
        .O   (O_c15_3_terminal_chain1_i11   ),
        .CY  (CY_c15_3_terminal_chain1_i11  ),
        .PROP(PROP_c15_3_terminal_chain1_i11));
    
    assign C0_c15_3_terminal_chain1_i11[4] = terminal_chain1_i10;
    assign C0_c15_3_terminal_chain1_i11[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i11[1] = layer3_col20[0];
    assign C0_c15_3_terminal_chain1_i11[2] = layer3_col20[1];
    assign C0_c15_3_terminal_chain1_i11[3] = layer3_col20[2];
    assign C1_c15_3_terminal_chain1_i11    = layer3_col21[0];
    
    assign terminal_chain1_out[20] = O_c15_3_terminal_chain1_i11[0];
    assign terminal_chain1_out[21] = O_c15_3_terminal_chain1_i11[1];
    
    assign terminal_chain1_i11            = COUT_LA_terminal_chain1[10];
    assign CY_LA_terminal_chain1[21:20]   = CY_c15_3_terminal_chain1_i11;
    assign PROP_LA_terminal_chain1[21:20] = PROP_c15_3_terminal_chain1_i11;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i12(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i12  ),
        .C1  (C1_c15_3_terminal_chain1_i12  ),
        .CLA (CLA_c15_3_terminal_chain1_i12 ),
        .O   (O_c15_3_terminal_chain1_i12   ),
        .CY  (CY_c15_3_terminal_chain1_i12  ),
        .PROP(PROP_c15_3_terminal_chain1_i12));
    
    assign C0_c15_3_terminal_chain1_i12[4] = terminal_chain1_i11;
    assign C0_c15_3_terminal_chain1_i12[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i12[1] = layer3_col22[0];
    assign C0_c15_3_terminal_chain1_i12[2] = layer3_col22[1];
    assign C0_c15_3_terminal_chain1_i12[3] = layer3_col22[2];
    assign C1_c15_3_terminal_chain1_i12    = layer3_col23[0];
    
    assign terminal_chain1_out[22] = O_c15_3_terminal_chain1_i12[0];
    assign terminal_chain1_out[23] = O_c15_3_terminal_chain1_i12[1];
    
    assign terminal_chain1_i12            = COUT_LA_terminal_chain1[11];
    assign CY_LA_terminal_chain1[23:22]   = CY_c15_3_terminal_chain1_i12;
    assign PROP_LA_terminal_chain1[23:22] = PROP_c15_3_terminal_chain1_i12;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i13(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i13  ),
        .C1  (C1_c15_3_terminal_chain1_i13  ),
        .CLA (CLA_c15_3_terminal_chain1_i13 ),
        .O   (O_c15_3_terminal_chain1_i13   ),
        .CY  (CY_c15_3_terminal_chain1_i13  ),
        .PROP(PROP_c15_3_terminal_chain1_i13));
    
    assign C0_c15_3_terminal_chain1_i13[4] = terminal_chain1_i12;
    assign C0_c15_3_terminal_chain1_i13[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i13[1] = layer3_col24[0];
    assign C0_c15_3_terminal_chain1_i13[2] = layer3_col24[1];
    assign C0_c15_3_terminal_chain1_i13[3] = layer3_col24[2];
    assign C1_c15_3_terminal_chain1_i13    = layer3_col25[0];
    
    assign terminal_chain1_out[24] = O_c15_3_terminal_chain1_i13[0];
    assign terminal_chain1_out[25] = O_c15_3_terminal_chain1_i13[1];
    
    assign terminal_chain1_i13            = COUT_LA_terminal_chain1[12];
    assign CY_LA_terminal_chain1[25:24]   = CY_c15_3_terminal_chain1_i13;
    assign PROP_LA_terminal_chain1[25:24] = PROP_c15_3_terminal_chain1_i13;
    
    assign CIN_LA_terminal_chain1[3] = COUT_LA_terminal_chain1[11];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i14(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i14  ),
        .C1  (C1_c15_3_terminal_chain1_i14  ),
        .CLA (CLA_c15_3_terminal_chain1_i14 ),
        .O   (O_c15_3_terminal_chain1_i14   ),
        .CY  (CY_c15_3_terminal_chain1_i14  ),
        .PROP(PROP_c15_3_terminal_chain1_i14));
    
    assign C0_c15_3_terminal_chain1_i14[4] = terminal_chain1_i13;
    assign C0_c15_3_terminal_chain1_i14[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i14[1] = layer3_col26[0];
    assign C0_c15_3_terminal_chain1_i14[2] = layer3_col26[1];
    assign C0_c15_3_terminal_chain1_i14[3] = layer3_col26[2];
    assign C1_c15_3_terminal_chain1_i14    = layer3_col27[0];
    
    assign terminal_chain1_out[26] = O_c15_3_terminal_chain1_i14[0];
    assign terminal_chain1_out[27] = O_c15_3_terminal_chain1_i14[1];
    
    assign terminal_chain1_i14            = COUT_LA_terminal_chain1[13];
    assign CY_LA_terminal_chain1[27:26]   = CY_c15_3_terminal_chain1_i14;
    assign PROP_LA_terminal_chain1[27:26] = PROP_c15_3_terminal_chain1_i14;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i15(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i15  ),
        .C1  (C1_c15_3_terminal_chain1_i15  ),
        .CLA (CLA_c15_3_terminal_chain1_i15 ),
        .O   (O_c15_3_terminal_chain1_i15   ),
        .CY  (CY_c15_3_terminal_chain1_i15  ),
        .PROP(PROP_c15_3_terminal_chain1_i15));
    
    assign C0_c15_3_terminal_chain1_i15[4] = terminal_chain1_i14;
    assign C0_c15_3_terminal_chain1_i15[0] = 1'b0;
    assign C0_c15_3_terminal_chain1_i15[1] = layer3_col28[0];
    assign C0_c15_3_terminal_chain1_i15[2] = layer3_col28[1];
    assign C0_c15_3_terminal_chain1_i15[3] = layer3_col28[2];
    assign C1_c15_3_terminal_chain1_i15    = layer3_col29[0];
    
    assign terminal_chain1_out[28] = O_c15_3_terminal_chain1_i15[0];
    assign terminal_chain1_out[29] = O_c15_3_terminal_chain1_i15[1];
    
    assign terminal_chain1_i15            = COUT_LA_terminal_chain1[14];
    assign CY_LA_terminal_chain1[29:28]   = CY_c15_3_terminal_chain1_i15;
    assign PROP_LA_terminal_chain1[29:28] = PROP_c15_3_terminal_chain1_i15;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i16(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i16  ),
        .C1  (C1_c15_3_terminal_chain1_i16  ),
        .CLA (CLA_c15_3_terminal_chain1_i16 ),
        .O   (O_c15_3_terminal_chain1_i16   ),
        .CY  (CY_c15_3_terminal_chain1_i16  ),
        .PROP(PROP_c15_3_terminal_chain1_i16));
    
    assign C0_c15_3_terminal_chain1_i16[4] = terminal_chain1_i15;
    assign C0_c15_3_terminal_chain1_i16[0] = layer3_col30[0];
    assign C0_c15_3_terminal_chain1_i16[1] = layer3_col30[1];
    assign C0_c15_3_terminal_chain1_i16[2] = layer3_col30[2];
    assign C0_c15_3_terminal_chain1_i16[3] = layer3_col30[3];
    assign C1_c15_3_terminal_chain1_i16    = layer3_col31[0];
    
    assign terminal_chain1_out[30] = O_c15_3_terminal_chain1_i16[0];
    assign terminal_chain1_out[31] = O_c15_3_terminal_chain1_i16[1];
    
    assign terminal_chain1_i16            = COUT_LA_terminal_chain1[15];
    assign CY_LA_terminal_chain1[31:30]   = CY_c15_3_terminal_chain1_i16;
    assign PROP_LA_terminal_chain1[31:30] = PROP_c15_3_terminal_chain1_i16;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i17(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i17  ),
        .C1  (C1_c15_3_terminal_chain1_i17  ),
        .CLA (CLA_c15_3_terminal_chain1_i17 ),
        .O   (O_c15_3_terminal_chain1_i17   ),
        .CY  (CY_c15_3_terminal_chain1_i17  ),
        .PROP(PROP_c15_3_terminal_chain1_i17));
    
    assign C0_c15_3_terminal_chain1_i17[4] = terminal_chain1_i16;
    assign C0_c15_3_terminal_chain1_i17[0] = layer3_col32[0];
    assign C0_c15_3_terminal_chain1_i17[1] = layer3_col32[1];
    assign C0_c15_3_terminal_chain1_i17[2] = layer3_col32[2];
    assign C0_c15_3_terminal_chain1_i17[3] = layer3_col32[3];
    assign C1_c15_3_terminal_chain1_i17    = layer3_col33[0];
    
    assign terminal_chain1_out[32] = O_c15_3_terminal_chain1_i17[0];
    assign terminal_chain1_out[33] = O_c15_3_terminal_chain1_i17[1];
    
    assign terminal_chain1_i17            = COUT_LA_terminal_chain1[16];
    assign CY_LA_terminal_chain1[33:32]   = CY_c15_3_terminal_chain1_i17;
    assign PROP_LA_terminal_chain1[33:32] = PROP_c15_3_terminal_chain1_i17;
    
    assign CIN_LA_terminal_chain1[4] = COUT_LA_terminal_chain1[15];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i18(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i18  ),
        .C1  (C1_c15_3_terminal_chain1_i18  ),
        .CLA (CLA_c15_3_terminal_chain1_i18 ),
        .O   (O_c15_3_terminal_chain1_i18   ),
        .CY  (CY_c15_3_terminal_chain1_i18  ),
        .PROP(PROP_c15_3_terminal_chain1_i18));
    
    assign C0_c15_3_terminal_chain1_i18[4] = terminal_chain1_i17;
    assign C0_c15_3_terminal_chain1_i18[0] = layer3_col34[0];
    assign C0_c15_3_terminal_chain1_i18[1] = layer3_col34[1];
    assign C0_c15_3_terminal_chain1_i18[2] = layer3_col34[2];
    assign C0_c15_3_terminal_chain1_i18[3] = layer3_col34[3];
    assign C1_c15_3_terminal_chain1_i18    = layer3_col35[0];
    
    assign terminal_chain1_out[34] = O_c15_3_terminal_chain1_i18[0];
    assign terminal_chain1_out[35] = O_c15_3_terminal_chain1_i18[1];
    
    assign terminal_chain1_i18            = COUT_LA_terminal_chain1[17];
    assign CY_LA_terminal_chain1[35:34]   = CY_c15_3_terminal_chain1_i18;
    assign PROP_LA_terminal_chain1[35:34] = PROP_c15_3_terminal_chain1_i18;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i19(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i19  ),
        .C1  (C1_c15_3_terminal_chain1_i19  ),
        .CLA (CLA_c15_3_terminal_chain1_i19 ),
        .O   (O_c15_3_terminal_chain1_i19   ),
        .CY  (CY_c15_3_terminal_chain1_i19  ),
        .PROP(PROP_c15_3_terminal_chain1_i19));
    
    assign C0_c15_3_terminal_chain1_i19[4] = terminal_chain1_i18;
    assign C0_c15_3_terminal_chain1_i19[0] = layer3_col36[0];
    assign C0_c15_3_terminal_chain1_i19[1] = layer3_col36[1];
    assign C0_c15_3_terminal_chain1_i19[2] = layer3_col36[2];
    assign C0_c15_3_terminal_chain1_i19[3] = layer3_col36[3];
    assign C1_c15_3_terminal_chain1_i19    = layer3_col37[0];
    
    assign terminal_chain1_out[36] = O_c15_3_terminal_chain1_i19[0];
    assign terminal_chain1_out[37] = O_c15_3_terminal_chain1_i19[1];
    
    assign terminal_chain1_i19            = COUT_LA_terminal_chain1[18];
    assign CY_LA_terminal_chain1[37:36]   = CY_c15_3_terminal_chain1_i19;
    assign PROP_LA_terminal_chain1[37:36] = PROP_c15_3_terminal_chain1_i19;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i20(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i20  ),
        .C1  (C1_c15_3_terminal_chain1_i20  ),
        .CLA (CLA_c15_3_terminal_chain1_i20 ),
        .O   (O_c15_3_terminal_chain1_i20   ),
        .CY  (CY_c15_3_terminal_chain1_i20  ),
        .PROP(PROP_c15_3_terminal_chain1_i20));
    
    assign C0_c15_3_terminal_chain1_i20[4] = terminal_chain1_i19;
    assign C0_c15_3_terminal_chain1_i20[0] = layer3_col38[0];
    assign C0_c15_3_terminal_chain1_i20[1] = layer3_col38[1];
    assign C0_c15_3_terminal_chain1_i20[2] = layer3_col38[2];
    assign C0_c15_3_terminal_chain1_i20[3] = layer3_col38[3];
    assign C1_c15_3_terminal_chain1_i20    = layer3_col39[0];
    
    assign terminal_chain1_out[38] = O_c15_3_terminal_chain1_i20[0];
    assign terminal_chain1_out[39] = O_c15_3_terminal_chain1_i20[1];
    
    assign terminal_chain1_i20            = COUT_LA_terminal_chain1[19];
    assign CY_LA_terminal_chain1[39:38]   = CY_c15_3_terminal_chain1_i20;
    assign PROP_LA_terminal_chain1[39:38] = PROP_c15_3_terminal_chain1_i20;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i21(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i21  ),
        .C1  (C1_c15_3_terminal_chain1_i21  ),
        .CLA (CLA_c15_3_terminal_chain1_i21 ),
        .O   (O_c15_3_terminal_chain1_i21   ),
        .CY  (CY_c15_3_terminal_chain1_i21  ),
        .PROP(PROP_c15_3_terminal_chain1_i21));
    
    assign C0_c15_3_terminal_chain1_i21[4] = terminal_chain1_i20;
    assign C0_c15_3_terminal_chain1_i21[0] = layer3_col40[0];
    assign C0_c15_3_terminal_chain1_i21[1] = layer3_col40[1];
    assign C0_c15_3_terminal_chain1_i21[2] = layer3_col40[2];
    assign C0_c15_3_terminal_chain1_i21[3] = layer3_col40[3];
    assign C1_c15_3_terminal_chain1_i21    = layer3_col41[0];
    
    assign terminal_chain1_out[40] = O_c15_3_terminal_chain1_i21[0];
    assign terminal_chain1_out[41] = O_c15_3_terminal_chain1_i21[1];
    
    assign terminal_chain1_i21            = COUT_LA_terminal_chain1[20];
    assign CY_LA_terminal_chain1[41:40]   = CY_c15_3_terminal_chain1_i21;
    assign PROP_LA_terminal_chain1[41:40] = PROP_c15_3_terminal_chain1_i21;
    
    assign CIN_LA_terminal_chain1[5] = COUT_LA_terminal_chain1[19];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i22(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i22  ),
        .C1  (C1_c15_3_terminal_chain1_i22  ),
        .CLA (CLA_c15_3_terminal_chain1_i22 ),
        .O   (O_c15_3_terminal_chain1_i22   ),
        .CY  (CY_c15_3_terminal_chain1_i22  ),
        .PROP(PROP_c15_3_terminal_chain1_i22));
    
    assign C0_c15_3_terminal_chain1_i22[4] = terminal_chain1_i21;
    assign C0_c15_3_terminal_chain1_i22[0] = layer3_col42[0];
    assign C0_c15_3_terminal_chain1_i22[1] = layer3_col42[1];
    assign C0_c15_3_terminal_chain1_i22[2] = layer3_col42[2];
    assign C0_c15_3_terminal_chain1_i22[3] = layer3_col42[3];
    assign C1_c15_3_terminal_chain1_i22    = layer3_col43[0];
    
    assign terminal_chain1_out[42] = O_c15_3_terminal_chain1_i22[0];
    assign terminal_chain1_out[43] = O_c15_3_terminal_chain1_i22[1];
    
    assign terminal_chain1_i22            = COUT_LA_terminal_chain1[21];
    assign CY_LA_terminal_chain1[43:42]   = CY_c15_3_terminal_chain1_i22;
    assign PROP_LA_terminal_chain1[43:42] = PROP_c15_3_terminal_chain1_i22;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i23(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i23  ),
        .C1  (C1_c15_3_terminal_chain1_i23  ),
        .CLA (CLA_c15_3_terminal_chain1_i23 ),
        .O   (O_c15_3_terminal_chain1_i23   ),
        .CY  (CY_c15_3_terminal_chain1_i23  ),
        .PROP(PROP_c15_3_terminal_chain1_i23));
    
    assign C0_c15_3_terminal_chain1_i23[4] = terminal_chain1_i22;
    assign C0_c15_3_terminal_chain1_i23[0] = layer3_col44[0];
    assign C0_c15_3_terminal_chain1_i23[1] = layer3_col44[1];
    assign C0_c15_3_terminal_chain1_i23[2] = layer3_col44[2];
    assign C0_c15_3_terminal_chain1_i23[3] = layer3_col44[3];
    assign C1_c15_3_terminal_chain1_i23    = layer3_col45[0];
    
    assign terminal_chain1_out[44] = O_c15_3_terminal_chain1_i23[0];
    assign terminal_chain1_out[45] = O_c15_3_terminal_chain1_i23[1];
    
    assign terminal_chain1_i23            = COUT_LA_terminal_chain1[22];
    assign CY_LA_terminal_chain1[45:44]   = CY_c15_3_terminal_chain1_i23;
    assign PROP_LA_terminal_chain1[45:44] = PROP_c15_3_terminal_chain1_i23;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i24(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i24  ),
        .C1  (C1_c15_3_terminal_chain1_i24  ),
        .CLA (CLA_c15_3_terminal_chain1_i24 ),
        .O   (O_c15_3_terminal_chain1_i24   ),
        .CY  (CY_c15_3_terminal_chain1_i24  ),
        .PROP(PROP_c15_3_terminal_chain1_i24));
    
    assign C0_c15_3_terminal_chain1_i24[4] = terminal_chain1_i23;
    assign C0_c15_3_terminal_chain1_i24[0] = layer3_col46[0];
    assign C0_c15_3_terminal_chain1_i24[1] = layer3_col46[1];
    assign C0_c15_3_terminal_chain1_i24[2] = layer3_col46[2];
    assign C0_c15_3_terminal_chain1_i24[3] = layer3_col46[3];
    assign C1_c15_3_terminal_chain1_i24    = layer3_col47[0];
    
    assign terminal_chain1_out[46] = O_c15_3_terminal_chain1_i24[0];
    assign terminal_chain1_out[47] = O_c15_3_terminal_chain1_i24[1];
    
    assign terminal_chain1_i24            = COUT_LA_terminal_chain1[23];
    assign CY_LA_terminal_chain1[47:46]   = CY_c15_3_terminal_chain1_i24;
    assign PROP_LA_terminal_chain1[47:46] = PROP_c15_3_terminal_chain1_i24;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i25(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i25  ),
        .C1  (C1_c15_3_terminal_chain1_i25  ),
        .CLA (CLA_c15_3_terminal_chain1_i25 ),
        .O   (O_c15_3_terminal_chain1_i25   ),
        .CY  (CY_c15_3_terminal_chain1_i25  ),
        .PROP(PROP_c15_3_terminal_chain1_i25));
    
    assign C0_c15_3_terminal_chain1_i25[4] = terminal_chain1_i24;
    assign C0_c15_3_terminal_chain1_i25[0] = layer3_col48[0];
    assign C0_c15_3_terminal_chain1_i25[1] = layer3_col48[1];
    assign C0_c15_3_terminal_chain1_i25[2] = layer3_col48[2];
    assign C0_c15_3_terminal_chain1_i25[3] = layer3_col48[3];
    assign C1_c15_3_terminal_chain1_i25    = layer3_col49[0];
    
    assign terminal_chain1_out[48] = O_c15_3_terminal_chain1_i25[0];
    assign terminal_chain1_out[49] = O_c15_3_terminal_chain1_i25[1];
    
    assign terminal_chain1_i25            = COUT_LA_terminal_chain1[24];
    assign CY_LA_terminal_chain1[49:48]   = CY_c15_3_terminal_chain1_i25;
    assign PROP_LA_terminal_chain1[49:48] = PROP_c15_3_terminal_chain1_i25;
    
    assign CIN_LA_terminal_chain1[6] = COUT_LA_terminal_chain1[23];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i26(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i26  ),
        .C1  (C1_c15_3_terminal_chain1_i26  ),
        .CLA (CLA_c15_3_terminal_chain1_i26 ),
        .O   (O_c15_3_terminal_chain1_i26   ),
        .CY  (CY_c15_3_terminal_chain1_i26  ),
        .PROP(PROP_c15_3_terminal_chain1_i26));
    
    assign C0_c15_3_terminal_chain1_i26[4] = terminal_chain1_i25;
    assign C0_c15_3_terminal_chain1_i26[0] = layer3_col50[0];
    assign C0_c15_3_terminal_chain1_i26[1] = layer3_col50[1];
    assign C0_c15_3_terminal_chain1_i26[2] = layer3_col50[2];
    assign C0_c15_3_terminal_chain1_i26[3] = layer3_col50[3];
    assign C1_c15_3_terminal_chain1_i26    = layer3_col51[0];
    
    assign terminal_chain1_out[50] = O_c15_3_terminal_chain1_i26[0];
    assign terminal_chain1_out[51] = O_c15_3_terminal_chain1_i26[1];
    
    assign terminal_chain1_i26            = COUT_LA_terminal_chain1[25];
    assign CY_LA_terminal_chain1[51:50]   = CY_c15_3_terminal_chain1_i26;
    assign PROP_LA_terminal_chain1[51:50] = PROP_c15_3_terminal_chain1_i26;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i27(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i27  ),
        .C1  (C1_c15_3_terminal_chain1_i27  ),
        .CLA (CLA_c15_3_terminal_chain1_i27 ),
        .O   (O_c15_3_terminal_chain1_i27   ),
        .CY  (CY_c15_3_terminal_chain1_i27  ),
        .PROP(PROP_c15_3_terminal_chain1_i27));
    
    assign C0_c15_3_terminal_chain1_i27[4] = terminal_chain1_i26;
    assign C0_c15_3_terminal_chain1_i27[0] = layer3_col52[0];
    assign C0_c15_3_terminal_chain1_i27[1] = layer3_col52[1];
    assign C0_c15_3_terminal_chain1_i27[2] = layer3_col52[2];
    assign C0_c15_3_terminal_chain1_i27[3] = layer3_col52[3];
    assign C1_c15_3_terminal_chain1_i27    = layer3_col53[0];
    
    assign terminal_chain1_out[52] = O_c15_3_terminal_chain1_i27[0];
    assign terminal_chain1_out[53] = O_c15_3_terminal_chain1_i27[1];
    
    assign terminal_chain1_i27            = COUT_LA_terminal_chain1[26];
    assign CY_LA_terminal_chain1[53:52]   = CY_c15_3_terminal_chain1_i27;
    assign PROP_LA_terminal_chain1[53:52] = PROP_c15_3_terminal_chain1_i27;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain1_i28(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain1_i28  ),
        .C1  (C1_c15_3_terminal_chain1_i28  ),
        .CLA (CLA_c15_3_terminal_chain1_i28 ),
        .O   (O_c15_3_terminal_chain1_i28   ),
        .CY  (CY_c15_3_terminal_chain1_i28  ),
        .PROP(PROP_c15_3_terminal_chain1_i28));
    
    assign C0_c15_3_terminal_chain1_i28[4] = terminal_chain1_i27;
    assign C0_c15_3_terminal_chain1_i28[0] = layer3_col54[0];
    assign C0_c15_3_terminal_chain1_i28[1] = layer3_col54[1];
    assign C0_c15_3_terminal_chain1_i28[2] = layer3_col54[2];
    assign C0_c15_3_terminal_chain1_i28[3] = layer3_col54[3];
    assign C1_c15_3_terminal_chain1_i28    = layer3_col55[0];
    
    assign terminal_chain1_out[54] = O_c15_3_terminal_chain1_i28[0];
    assign terminal_chain1_out[55] = O_c15_3_terminal_chain1_i28[1];
    
    assign terminal_chain1_i28            = COUT_LA_terminal_chain1[27];
    assign CY_LA_terminal_chain1[55:54]   = CY_c15_3_terminal_chain1_i28;
    assign PROP_LA_terminal_chain1[55:54] = PROP_c15_3_terminal_chain1_i28;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain1_i29(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain1_i29  ),
        .O   (O_c3_2_terminal_chain1_i29   ),
        .CY  (CY_c3_2_terminal_chain1_i29  ),
        .PROP(PROP_c3_2_terminal_chain1_i29));
    
    assign C0_c3_2_terminal_chain1_i29[2] = terminal_chain1_i28;
    assign C0_c3_2_terminal_chain1_i29[0] = layer3_col56[0];
    assign C0_c3_2_terminal_chain1_i29[1] = layer3_col56[1];
    
    assign terminal_chain1_out[56] = O_c3_2_terminal_chain1_i29[0];
    
    assign terminal_chain1_i29         = O_c3_2_terminal_chain1_i29[1];
    assign CY_LA_terminal_chain1[56]   = CY_c3_2_terminal_chain1_i29;
    assign PROP_LA_terminal_chain1[56] = PROP_c3_2_terminal_chain1_i29;
    
    assign CIN_LA_terminal_chain1[7] = COUT_LA_terminal_chain1[27];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain1_i30(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain1_i30  ),
        .O   (O_c3_2_terminal_chain1_i30   ),
        .CY  (CY_c3_2_terminal_chain1_i30  ),
        .PROP(PROP_c3_2_terminal_chain1_i30));
    
    assign C0_c3_2_terminal_chain1_i30[2] = terminal_chain1_i29;
    assign C0_c3_2_terminal_chain1_i30[0] = layer3_col57[0];
    assign C0_c3_2_terminal_chain1_i30[1] = layer3_col57[1];
    
    assign terminal_chain1_out[57] = O_c3_2_terminal_chain1_i30[0];
    assign terminal_chain1_out[58] = O_c3_2_terminal_chain1_i30[1];
    
    assign terminal_chain1_i30         = COUT_LA_terminal_chain1[28];
    assign CY_LA_terminal_chain1[57]   = CY_c3_2_terminal_chain1_i30;
    assign PROP_LA_terminal_chain1[57] = PROP_c3_2_terminal_chain1_i30;
    
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

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst3 (
        .COUTB(COUT_LA_terminal_chain2[12]),
        .COUTD(COUT_LA_terminal_chain2[13]),
        .COUTF(COUT_LA_terminal_chain2[14]),
        .COUTH(COUT_LA_terminal_chain2[15]),
        .CIN  (CIN_LA_terminal_chain2[3]  ),
        .CYA  (CY_LA_terminal_chain2[24]  ),
        .CYB  (CY_LA_terminal_chain2[25]  ),
        .CYC  (CY_LA_terminal_chain2[26]  ),
        .CYD  (CY_LA_terminal_chain2[27]  ),
        .CYE  (CY_LA_terminal_chain2[28]  ),
        .CYF  (CY_LA_terminal_chain2[29]  ),
        .CYG  (CY_LA_terminal_chain2[30]  ),
        .CYH  (CY_LA_terminal_chain2[31]  ),
        .PROPA(PROP_LA_terminal_chain2[24]),
        .PROPB(PROP_LA_terminal_chain2[25]),
        .PROPC(PROP_LA_terminal_chain2[26]),
        .PROPD(PROP_LA_terminal_chain2[27]),
        .PROPE(PROP_LA_terminal_chain2[28]),
        .PROPF(PROP_LA_terminal_chain2[29]),
        .PROPG(PROP_LA_terminal_chain2[30]),
        .PROPH(PROP_LA_terminal_chain2[31]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst4 (
        .COUTB(COUT_LA_terminal_chain2[16]),
        .COUTD(COUT_LA_terminal_chain2[17]),
        .COUTF(COUT_LA_terminal_chain2[18]),
        .COUTH(COUT_LA_terminal_chain2[19]),
        .CIN  (CIN_LA_terminal_chain2[4]  ),
        .CYA  (CY_LA_terminal_chain2[32]  ),
        .CYB  (CY_LA_terminal_chain2[33]  ),
        .CYC  (CY_LA_terminal_chain2[34]  ),
        .CYD  (CY_LA_terminal_chain2[35]  ),
        .CYE  (CY_LA_terminal_chain2[36]  ),
        .CYF  (CY_LA_terminal_chain2[37]  ),
        .CYG  (CY_LA_terminal_chain2[38]  ),
        .CYH  (CY_LA_terminal_chain2[39]  ),
        .PROPA(PROP_LA_terminal_chain2[32]),
        .PROPB(PROP_LA_terminal_chain2[33]),
        .PROPC(PROP_LA_terminal_chain2[34]),
        .PROPD(PROP_LA_terminal_chain2[35]),
        .PROPE(PROP_LA_terminal_chain2[36]),
        .PROPF(PROP_LA_terminal_chain2[37]),
        .PROPG(PROP_LA_terminal_chain2[38]),
        .PROPH(PROP_LA_terminal_chain2[39]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst5 (
        .COUTB(COUT_LA_terminal_chain2[20]),
        .COUTD(COUT_LA_terminal_chain2[21]),
        .COUTF(COUT_LA_terminal_chain2[22]),
        .COUTH(COUT_LA_terminal_chain2[23]),
        .CIN  (CIN_LA_terminal_chain2[5]  ),
        .CYA  (CY_LA_terminal_chain2[40]  ),
        .CYB  (CY_LA_terminal_chain2[41]  ),
        .CYC  (CY_LA_terminal_chain2[42]  ),
        .CYD  (CY_LA_terminal_chain2[43]  ),
        .CYE  (CY_LA_terminal_chain2[44]  ),
        .CYF  (CY_LA_terminal_chain2[45]  ),
        .CYG  (CY_LA_terminal_chain2[46]  ),
        .CYH  (CY_LA_terminal_chain2[47]  ),
        .PROPA(PROP_LA_terminal_chain2[40]),
        .PROPB(PROP_LA_terminal_chain2[41]),
        .PROPC(PROP_LA_terminal_chain2[42]),
        .PROPD(PROP_LA_terminal_chain2[43]),
        .PROPE(PROP_LA_terminal_chain2[44]),
        .PROPF(PROP_LA_terminal_chain2[45]),
        .PROPG(PROP_LA_terminal_chain2[46]),
        .PROPH(PROP_LA_terminal_chain2[47]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst6 (
        .COUTB(COUT_LA_terminal_chain2[24]),
        .COUTD(COUT_LA_terminal_chain2[25]),
        .COUTF(COUT_LA_terminal_chain2[26]),
        .COUTH(COUT_LA_terminal_chain2[27]),
        .CIN  (CIN_LA_terminal_chain2[6]  ),
        .CYA  (CY_LA_terminal_chain2[48]  ),
        .CYB  (CY_LA_terminal_chain2[49]  ),
        .CYC  (CY_LA_terminal_chain2[50]  ),
        .CYD  (CY_LA_terminal_chain2[51]  ),
        .CYE  (CY_LA_terminal_chain2[52]  ),
        .CYF  (CY_LA_terminal_chain2[53]  ),
        .CYG  (CY_LA_terminal_chain2[54]  ),
        .CYH  (CY_LA_terminal_chain2[55]  ),
        .PROPA(PROP_LA_terminal_chain2[48]),
        .PROPB(PROP_LA_terminal_chain2[49]),
        .PROPC(PROP_LA_terminal_chain2[50]),
        .PROPD(PROP_LA_terminal_chain2[51]),
        .PROPE(PROP_LA_terminal_chain2[52]),
        .PROPF(PROP_LA_terminal_chain2[53]),
        .PROPG(PROP_LA_terminal_chain2[54]),
        .PROPH(PROP_LA_terminal_chain2[55]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_terminal_chain2_inst7 (
        .COUTB(COUT_LA_terminal_chain2[28]),
        .COUTD(COUT_LA_terminal_chain2[29]),
        .COUTF(COUT_LA_terminal_chain2[30]),
        .COUTH(COUT_LA_terminal_chain2[31]),
        .CIN  (CIN_LA_terminal_chain2[7]  ),
        .CYA  (CY_LA_terminal_chain2[56]  ),
        .CYB  (CY_LA_terminal_chain2[57]  ),
        .CYC  (CY_LA_terminal_chain2[58]  ),
        .CYD  (CY_LA_terminal_chain2[59]  ),
        .CYE  (CY_LA_terminal_chain2[60]  ),
        .CYF  (CY_LA_terminal_chain2[61]  ),
        .CYG  (CY_LA_terminal_chain2[62]  ),
        .CYH  (CY_LA_terminal_chain2[63]  ),
        .PROPA(PROP_LA_terminal_chain2[56]),
        .PROPB(PROP_LA_terminal_chain2[57]),
        .PROPC(PROP_LA_terminal_chain2[58]),
        .PROPD(PROP_LA_terminal_chain2[59]),
        .PROPE(PROP_LA_terminal_chain2[60]),
        .PROPF(PROP_LA_terminal_chain2[61]),
        .PROPG(PROP_LA_terminal_chain2[62]),
        .PROPH(PROP_LA_terminal_chain2[63]));

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
    assign C0_c15_3_terminal_chain2_i0[2] = layer3_col3[1];
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
    assign C0_c15_3_terminal_chain2_i1[1] = layer3_col5[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer3_col5[2];
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
    assign C0_c15_3_terminal_chain2_i2[1] = layer3_col7[1];
    assign C0_c15_3_terminal_chain2_i2[2] = layer3_col7[2];
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
    assign C0_c15_3_terminal_chain2_i3[1] = layer3_col9[1];
    assign C0_c15_3_terminal_chain2_i3[2] = layer3_col9[2];
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
    assign C0_c15_3_terminal_chain2_i4[1] = layer3_col11[1];
    assign C0_c15_3_terminal_chain2_i4[2] = layer3_col11[2];
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
    assign C0_c15_3_terminal_chain2_i5[1] = layer3_col13[1];
    assign C0_c15_3_terminal_chain2_i5[2] = layer3_col13[2];
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
    assign C0_c15_3_terminal_chain2_i6[1] = layer3_col15[1];
    assign C0_c15_3_terminal_chain2_i6[2] = layer3_col15[2];
    assign C1_c15_3_terminal_chain2_i6    = terminal_chain1_out[16];
    
    assign terminal_chain2_out[12] = O_c15_3_terminal_chain2_i6[0];
    assign terminal_chain2_out[13] = O_c15_3_terminal_chain2_i6[1];
    
    assign terminal_chain2_i6             = COUT_LA_terminal_chain2[6];
    assign CY_LA_terminal_chain2[13:12]   = CY_c15_3_terminal_chain2_i6;
    assign PROP_LA_terminal_chain2[13:12] = PROP_c15_3_terminal_chain2_i6;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i7(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i7  ),
        .C1  (C1_c15_3_terminal_chain2_i7  ),
        .CLA (CLA_c15_3_terminal_chain2_i7 ),
        .O   (O_c15_3_terminal_chain2_i7   ),
        .CY  (CY_c15_3_terminal_chain2_i7  ),
        .PROP(PROP_c15_3_terminal_chain2_i7));
    
    assign C0_c15_3_terminal_chain2_i7[4] = terminal_chain2_i6;
    assign C0_c15_3_terminal_chain2_i7[3] = terminal_chain1_out[17];
    assign C0_c15_3_terminal_chain2_i7[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i7[1] = layer3_col17[1];
    assign C0_c15_3_terminal_chain2_i7[2] = layer3_col17[2];
    assign C1_c15_3_terminal_chain2_i7    = terminal_chain1_out[18];
    
    assign terminal_chain2_out[14] = O_c15_3_terminal_chain2_i7[0];
    assign terminal_chain2_out[15] = O_c15_3_terminal_chain2_i7[1];
    
    assign terminal_chain2_i7             = COUT_LA_terminal_chain2[7];
    assign CY_LA_terminal_chain2[15:14]   = CY_c15_3_terminal_chain2_i7;
    assign PROP_LA_terminal_chain2[15:14] = PROP_c15_3_terminal_chain2_i7;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i8(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i8  ),
        .C1  (C1_c15_3_terminal_chain2_i8  ),
        .CLA (CLA_c15_3_terminal_chain2_i8 ),
        .O   (O_c15_3_terminal_chain2_i8   ),
        .CY  (CY_c15_3_terminal_chain2_i8  ),
        .PROP(PROP_c15_3_terminal_chain2_i8));
    
    assign C0_c15_3_terminal_chain2_i8[4] = terminal_chain2_i7;
    assign C0_c15_3_terminal_chain2_i8[3] = terminal_chain1_out[19];
    assign C0_c15_3_terminal_chain2_i8[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i8[1] = layer3_col19[1];
    assign C0_c15_3_terminal_chain2_i8[2] = layer3_col19[2];
    assign C1_c15_3_terminal_chain2_i8    = terminal_chain1_out[20];
    
    assign terminal_chain2_out[16] = O_c15_3_terminal_chain2_i8[0];
    assign terminal_chain2_out[17] = O_c15_3_terminal_chain2_i8[1];
    
    assign terminal_chain2_i8             = COUT_LA_terminal_chain2[8];
    assign CY_LA_terminal_chain2[17:16]   = CY_c15_3_terminal_chain2_i8;
    assign PROP_LA_terminal_chain2[17:16] = PROP_c15_3_terminal_chain2_i8;
    
    assign CIN_LA_terminal_chain2[2] = COUT_LA_terminal_chain2[7];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i9(
        .clk (clk                          ),
        .C0  (C0_c15_3_terminal_chain2_i9  ),
        .C1  (C1_c15_3_terminal_chain2_i9  ),
        .CLA (CLA_c15_3_terminal_chain2_i9 ),
        .O   (O_c15_3_terminal_chain2_i9   ),
        .CY  (CY_c15_3_terminal_chain2_i9  ),
        .PROP(PROP_c15_3_terminal_chain2_i9));
    
    assign C0_c15_3_terminal_chain2_i9[4] = terminal_chain2_i8;
    assign C0_c15_3_terminal_chain2_i9[3] = terminal_chain1_out[21];
    assign C0_c15_3_terminal_chain2_i9[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i9[1] = layer3_col21[1];
    assign C0_c15_3_terminal_chain2_i9[2] = layer3_col21[2];
    assign C1_c15_3_terminal_chain2_i9    = terminal_chain1_out[22];
    
    assign terminal_chain2_out[18] = O_c15_3_terminal_chain2_i9[0];
    assign terminal_chain2_out[19] = O_c15_3_terminal_chain2_i9[1];
    
    assign terminal_chain2_i9             = COUT_LA_terminal_chain2[9];
    assign CY_LA_terminal_chain2[19:18]   = CY_c15_3_terminal_chain2_i9;
    assign PROP_LA_terminal_chain2[19:18] = PROP_c15_3_terminal_chain2_i9;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i10(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i10  ),
        .C1  (C1_c15_3_terminal_chain2_i10  ),
        .CLA (CLA_c15_3_terminal_chain2_i10 ),
        .O   (O_c15_3_terminal_chain2_i10   ),
        .CY  (CY_c15_3_terminal_chain2_i10  ),
        .PROP(PROP_c15_3_terminal_chain2_i10));
    
    assign C0_c15_3_terminal_chain2_i10[4] = terminal_chain2_i9;
    assign C0_c15_3_terminal_chain2_i10[3] = terminal_chain1_out[23];
    assign C0_c15_3_terminal_chain2_i10[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i10[1] = layer3_col23[1];
    assign C0_c15_3_terminal_chain2_i10[2] = layer3_col23[2];
    assign C1_c15_3_terminal_chain2_i10    = terminal_chain1_out[24];
    
    assign terminal_chain2_out[20] = O_c15_3_terminal_chain2_i10[0];
    assign terminal_chain2_out[21] = O_c15_3_terminal_chain2_i10[1];
    
    assign terminal_chain2_i10            = COUT_LA_terminal_chain2[10];
    assign CY_LA_terminal_chain2[21:20]   = CY_c15_3_terminal_chain2_i10;
    assign PROP_LA_terminal_chain2[21:20] = PROP_c15_3_terminal_chain2_i10;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i11(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i11  ),
        .C1  (C1_c15_3_terminal_chain2_i11  ),
        .CLA (CLA_c15_3_terminal_chain2_i11 ),
        .O   (O_c15_3_terminal_chain2_i11   ),
        .CY  (CY_c15_3_terminal_chain2_i11  ),
        .PROP(PROP_c15_3_terminal_chain2_i11));
    
    assign C0_c15_3_terminal_chain2_i11[4] = terminal_chain2_i10;
    assign C0_c15_3_terminal_chain2_i11[3] = terminal_chain1_out[25];
    assign C0_c15_3_terminal_chain2_i11[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i11[1] = layer3_col25[1];
    assign C0_c15_3_terminal_chain2_i11[2] = layer3_col25[2];
    assign C1_c15_3_terminal_chain2_i11    = terminal_chain1_out[26];
    
    assign terminal_chain2_out[22] = O_c15_3_terminal_chain2_i11[0];
    assign terminal_chain2_out[23] = O_c15_3_terminal_chain2_i11[1];
    
    assign terminal_chain2_i11            = COUT_LA_terminal_chain2[11];
    assign CY_LA_terminal_chain2[23:22]   = CY_c15_3_terminal_chain2_i11;
    assign PROP_LA_terminal_chain2[23:22] = PROP_c15_3_terminal_chain2_i11;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i12(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i12  ),
        .C1  (C1_c15_3_terminal_chain2_i12  ),
        .CLA (CLA_c15_3_terminal_chain2_i12 ),
        .O   (O_c15_3_terminal_chain2_i12   ),
        .CY  (CY_c15_3_terminal_chain2_i12  ),
        .PROP(PROP_c15_3_terminal_chain2_i12));
    
    assign C0_c15_3_terminal_chain2_i12[4] = terminal_chain2_i11;
    assign C0_c15_3_terminal_chain2_i12[3] = terminal_chain1_out[27];
    assign C0_c15_3_terminal_chain2_i12[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i12[1] = layer3_col27[1];
    assign C0_c15_3_terminal_chain2_i12[2] = layer3_col27[2];
    assign C1_c15_3_terminal_chain2_i12    = terminal_chain1_out[28];
    
    assign terminal_chain2_out[24] = O_c15_3_terminal_chain2_i12[0];
    assign terminal_chain2_out[25] = O_c15_3_terminal_chain2_i12[1];
    
    assign terminal_chain2_i12            = COUT_LA_terminal_chain2[12];
    assign CY_LA_terminal_chain2[25:24]   = CY_c15_3_terminal_chain2_i12;
    assign PROP_LA_terminal_chain2[25:24] = PROP_c15_3_terminal_chain2_i12;
    
    assign CIN_LA_terminal_chain2[3] = COUT_LA_terminal_chain2[11];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i13(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i13  ),
        .C1  (C1_c15_3_terminal_chain2_i13  ),
        .CLA (CLA_c15_3_terminal_chain2_i13 ),
        .O   (O_c15_3_terminal_chain2_i13   ),
        .CY  (CY_c15_3_terminal_chain2_i13  ),
        .PROP(PROP_c15_3_terminal_chain2_i13));
    
    assign C0_c15_3_terminal_chain2_i13[4] = terminal_chain2_i12;
    assign C0_c15_3_terminal_chain2_i13[3] = terminal_chain1_out[29];
    assign C0_c15_3_terminal_chain2_i13[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i13[1] = layer3_col29[1];
    assign C0_c15_3_terminal_chain2_i13[2] = layer3_col29[2];
    assign C1_c15_3_terminal_chain2_i13    = terminal_chain1_out[30];
    
    assign terminal_chain2_out[26] = O_c15_3_terminal_chain2_i13[0];
    assign terminal_chain2_out[27] = O_c15_3_terminal_chain2_i13[1];
    
    assign terminal_chain2_i13            = COUT_LA_terminal_chain2[13];
    assign CY_LA_terminal_chain2[27:26]   = CY_c15_3_terminal_chain2_i13;
    assign PROP_LA_terminal_chain2[27:26] = PROP_c15_3_terminal_chain2_i13;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i14(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i14  ),
        .C1  (C1_c15_3_terminal_chain2_i14  ),
        .CLA (CLA_c15_3_terminal_chain2_i14 ),
        .O   (O_c15_3_terminal_chain2_i14   ),
        .CY  (CY_c15_3_terminal_chain2_i14  ),
        .PROP(PROP_c15_3_terminal_chain2_i14));
    
    assign C0_c15_3_terminal_chain2_i14[4] = terminal_chain2_i13;
    assign C0_c15_3_terminal_chain2_i14[3] = terminal_chain1_out[31];
    assign C0_c15_3_terminal_chain2_i14[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i14[1] = layer3_col31[1];
    assign C0_c15_3_terminal_chain2_i14[2] = layer3_col31[2];
    assign C1_c15_3_terminal_chain2_i14    = terminal_chain1_out[32];
    
    assign terminal_chain2_out[28] = O_c15_3_terminal_chain2_i14[0];
    assign terminal_chain2_out[29] = O_c15_3_terminal_chain2_i14[1];
    
    assign terminal_chain2_i14            = COUT_LA_terminal_chain2[14];
    assign CY_LA_terminal_chain2[29:28]   = CY_c15_3_terminal_chain2_i14;
    assign PROP_LA_terminal_chain2[29:28] = PROP_c15_3_terminal_chain2_i14;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i15(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i15  ),
        .C1  (C1_c15_3_terminal_chain2_i15  ),
        .CLA (CLA_c15_3_terminal_chain2_i15 ),
        .O   (O_c15_3_terminal_chain2_i15   ),
        .CY  (CY_c15_3_terminal_chain2_i15  ),
        .PROP(PROP_c15_3_terminal_chain2_i15));
    
    assign C0_c15_3_terminal_chain2_i15[4] = terminal_chain2_i14;
    assign C0_c15_3_terminal_chain2_i15[3] = terminal_chain1_out[33];
    assign C0_c15_3_terminal_chain2_i15[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i15[1] = layer3_col33[1];
    assign C0_c15_3_terminal_chain2_i15[2] = layer3_col33[2];
    assign C1_c15_3_terminal_chain2_i15    = terminal_chain1_out[34];
    
    assign terminal_chain2_out[30] = O_c15_3_terminal_chain2_i15[0];
    assign terminal_chain2_out[31] = O_c15_3_terminal_chain2_i15[1];
    
    assign terminal_chain2_i15            = COUT_LA_terminal_chain2[15];
    assign CY_LA_terminal_chain2[31:30]   = CY_c15_3_terminal_chain2_i15;
    assign PROP_LA_terminal_chain2[31:30] = PROP_c15_3_terminal_chain2_i15;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i16(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i16  ),
        .C1  (C1_c15_3_terminal_chain2_i16  ),
        .CLA (CLA_c15_3_terminal_chain2_i16 ),
        .O   (O_c15_3_terminal_chain2_i16   ),
        .CY  (CY_c15_3_terminal_chain2_i16  ),
        .PROP(PROP_c15_3_terminal_chain2_i16));
    
    assign C0_c15_3_terminal_chain2_i16[4] = terminal_chain2_i15;
    assign C0_c15_3_terminal_chain2_i16[3] = terminal_chain1_out[35];
    assign C0_c15_3_terminal_chain2_i16[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i16[1] = layer3_col35[1];
    assign C0_c15_3_terminal_chain2_i16[2] = layer3_col35[2];
    assign C1_c15_3_terminal_chain2_i16    = terminal_chain1_out[36];
    
    assign terminal_chain2_out[32] = O_c15_3_terminal_chain2_i16[0];
    assign terminal_chain2_out[33] = O_c15_3_terminal_chain2_i16[1];
    
    assign terminal_chain2_i16            = COUT_LA_terminal_chain2[16];
    assign CY_LA_terminal_chain2[33:32]   = CY_c15_3_terminal_chain2_i16;
    assign PROP_LA_terminal_chain2[33:32] = PROP_c15_3_terminal_chain2_i16;
    
    assign CIN_LA_terminal_chain2[4] = COUT_LA_terminal_chain2[15];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i17(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i17  ),
        .C1  (C1_c15_3_terminal_chain2_i17  ),
        .CLA (CLA_c15_3_terminal_chain2_i17 ),
        .O   (O_c15_3_terminal_chain2_i17   ),
        .CY  (CY_c15_3_terminal_chain2_i17  ),
        .PROP(PROP_c15_3_terminal_chain2_i17));
    
    assign C0_c15_3_terminal_chain2_i17[4] = terminal_chain2_i16;
    assign C0_c15_3_terminal_chain2_i17[3] = terminal_chain1_out[37];
    assign C0_c15_3_terminal_chain2_i17[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i17[1] = layer3_col37[1];
    assign C0_c15_3_terminal_chain2_i17[2] = layer3_col37[2];
    assign C1_c15_3_terminal_chain2_i17    = terminal_chain1_out[38];
    
    assign terminal_chain2_out[34] = O_c15_3_terminal_chain2_i17[0];
    assign terminal_chain2_out[35] = O_c15_3_terminal_chain2_i17[1];
    
    assign terminal_chain2_i17            = COUT_LA_terminal_chain2[17];
    assign CY_LA_terminal_chain2[35:34]   = CY_c15_3_terminal_chain2_i17;
    assign PROP_LA_terminal_chain2[35:34] = PROP_c15_3_terminal_chain2_i17;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i18(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i18  ),
        .C1  (C1_c15_3_terminal_chain2_i18  ),
        .CLA (CLA_c15_3_terminal_chain2_i18 ),
        .O   (O_c15_3_terminal_chain2_i18   ),
        .CY  (CY_c15_3_terminal_chain2_i18  ),
        .PROP(PROP_c15_3_terminal_chain2_i18));
    
    assign C0_c15_3_terminal_chain2_i18[4] = terminal_chain2_i17;
    assign C0_c15_3_terminal_chain2_i18[3] = terminal_chain1_out[39];
    assign C0_c15_3_terminal_chain2_i18[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i18[1] = layer3_col39[1];
    assign C0_c15_3_terminal_chain2_i18[2] = layer3_col39[2];
    assign C1_c15_3_terminal_chain2_i18    = terminal_chain1_out[40];
    
    assign terminal_chain2_out[36] = O_c15_3_terminal_chain2_i18[0];
    assign terminal_chain2_out[37] = O_c15_3_terminal_chain2_i18[1];
    
    assign terminal_chain2_i18            = COUT_LA_terminal_chain2[18];
    assign CY_LA_terminal_chain2[37:36]   = CY_c15_3_terminal_chain2_i18;
    assign PROP_LA_terminal_chain2[37:36] = PROP_c15_3_terminal_chain2_i18;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i19(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i19  ),
        .C1  (C1_c15_3_terminal_chain2_i19  ),
        .CLA (CLA_c15_3_terminal_chain2_i19 ),
        .O   (O_c15_3_terminal_chain2_i19   ),
        .CY  (CY_c15_3_terminal_chain2_i19  ),
        .PROP(PROP_c15_3_terminal_chain2_i19));
    
    assign C0_c15_3_terminal_chain2_i19[4] = terminal_chain2_i18;
    assign C0_c15_3_terminal_chain2_i19[3] = terminal_chain1_out[41];
    assign C0_c15_3_terminal_chain2_i19[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i19[1] = layer3_col41[1];
    assign C0_c15_3_terminal_chain2_i19[2] = layer3_col41[2];
    assign C1_c15_3_terminal_chain2_i19    = terminal_chain1_out[42];
    
    assign terminal_chain2_out[38] = O_c15_3_terminal_chain2_i19[0];
    assign terminal_chain2_out[39] = O_c15_3_terminal_chain2_i19[1];
    
    assign terminal_chain2_i19            = COUT_LA_terminal_chain2[19];
    assign CY_LA_terminal_chain2[39:38]   = CY_c15_3_terminal_chain2_i19;
    assign PROP_LA_terminal_chain2[39:38] = PROP_c15_3_terminal_chain2_i19;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i20(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i20  ),
        .C1  (C1_c15_3_terminal_chain2_i20  ),
        .CLA (CLA_c15_3_terminal_chain2_i20 ),
        .O   (O_c15_3_terminal_chain2_i20   ),
        .CY  (CY_c15_3_terminal_chain2_i20  ),
        .PROP(PROP_c15_3_terminal_chain2_i20));
    
    assign C0_c15_3_terminal_chain2_i20[4] = terminal_chain2_i19;
    assign C0_c15_3_terminal_chain2_i20[3] = terminal_chain1_out[43];
    assign C0_c15_3_terminal_chain2_i20[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i20[1] = layer3_col43[1];
    assign C0_c15_3_terminal_chain2_i20[2] = layer3_col43[2];
    assign C1_c15_3_terminal_chain2_i20    = terminal_chain1_out[44];
    
    assign terminal_chain2_out[40] = O_c15_3_terminal_chain2_i20[0];
    assign terminal_chain2_out[41] = O_c15_3_terminal_chain2_i20[1];
    
    assign terminal_chain2_i20            = COUT_LA_terminal_chain2[20];
    assign CY_LA_terminal_chain2[41:40]   = CY_c15_3_terminal_chain2_i20;
    assign PROP_LA_terminal_chain2[41:40] = PROP_c15_3_terminal_chain2_i20;
    
    assign CIN_LA_terminal_chain2[5] = COUT_LA_terminal_chain2[19];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i21(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i21  ),
        .C1  (C1_c15_3_terminal_chain2_i21  ),
        .CLA (CLA_c15_3_terminal_chain2_i21 ),
        .O   (O_c15_3_terminal_chain2_i21   ),
        .CY  (CY_c15_3_terminal_chain2_i21  ),
        .PROP(PROP_c15_3_terminal_chain2_i21));
    
    assign C0_c15_3_terminal_chain2_i21[4] = terminal_chain2_i20;
    assign C0_c15_3_terminal_chain2_i21[3] = terminal_chain1_out[45];
    assign C0_c15_3_terminal_chain2_i21[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i21[1] = layer3_col45[1];
    assign C0_c15_3_terminal_chain2_i21[2] = layer3_col45[2];
    assign C1_c15_3_terminal_chain2_i21    = terminal_chain1_out[46];
    
    assign terminal_chain2_out[42] = O_c15_3_terminal_chain2_i21[0];
    assign terminal_chain2_out[43] = O_c15_3_terminal_chain2_i21[1];
    
    assign terminal_chain2_i21            = COUT_LA_terminal_chain2[21];
    assign CY_LA_terminal_chain2[43:42]   = CY_c15_3_terminal_chain2_i21;
    assign PROP_LA_terminal_chain2[43:42] = PROP_c15_3_terminal_chain2_i21;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i22(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i22  ),
        .C1  (C1_c15_3_terminal_chain2_i22  ),
        .CLA (CLA_c15_3_terminal_chain2_i22 ),
        .O   (O_c15_3_terminal_chain2_i22   ),
        .CY  (CY_c15_3_terminal_chain2_i22  ),
        .PROP(PROP_c15_3_terminal_chain2_i22));
    
    assign C0_c15_3_terminal_chain2_i22[4] = terminal_chain2_i21;
    assign C0_c15_3_terminal_chain2_i22[3] = terminal_chain1_out[47];
    assign C0_c15_3_terminal_chain2_i22[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i22[1] = layer3_col47[1];
    assign C0_c15_3_terminal_chain2_i22[2] = layer3_col47[2];
    assign C1_c15_3_terminal_chain2_i22    = terminal_chain1_out[48];
    
    assign terminal_chain2_out[44] = O_c15_3_terminal_chain2_i22[0];
    assign terminal_chain2_out[45] = O_c15_3_terminal_chain2_i22[1];
    
    assign terminal_chain2_i22            = COUT_LA_terminal_chain2[22];
    assign CY_LA_terminal_chain2[45:44]   = CY_c15_3_terminal_chain2_i22;
    assign PROP_LA_terminal_chain2[45:44] = PROP_c15_3_terminal_chain2_i22;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i23(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i23  ),
        .C1  (C1_c15_3_terminal_chain2_i23  ),
        .CLA (CLA_c15_3_terminal_chain2_i23 ),
        .O   (O_c15_3_terminal_chain2_i23   ),
        .CY  (CY_c15_3_terminal_chain2_i23  ),
        .PROP(PROP_c15_3_terminal_chain2_i23));
    
    assign C0_c15_3_terminal_chain2_i23[4] = terminal_chain2_i22;
    assign C0_c15_3_terminal_chain2_i23[3] = terminal_chain1_out[49];
    assign C0_c15_3_terminal_chain2_i23[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i23[1] = layer3_col49[1];
    assign C0_c15_3_terminal_chain2_i23[2] = layer3_col49[2];
    assign C1_c15_3_terminal_chain2_i23    = terminal_chain1_out[50];
    
    assign terminal_chain2_out[46] = O_c15_3_terminal_chain2_i23[0];
    assign terminal_chain2_out[47] = O_c15_3_terminal_chain2_i23[1];
    
    assign terminal_chain2_i23            = COUT_LA_terminal_chain2[23];
    assign CY_LA_terminal_chain2[47:46]   = CY_c15_3_terminal_chain2_i23;
    assign PROP_LA_terminal_chain2[47:46] = PROP_c15_3_terminal_chain2_i23;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i24(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i24  ),
        .C1  (C1_c15_3_terminal_chain2_i24  ),
        .CLA (CLA_c15_3_terminal_chain2_i24 ),
        .O   (O_c15_3_terminal_chain2_i24   ),
        .CY  (CY_c15_3_terminal_chain2_i24  ),
        .PROP(PROP_c15_3_terminal_chain2_i24));
    
    assign C0_c15_3_terminal_chain2_i24[4] = terminal_chain2_i23;
    assign C0_c15_3_terminal_chain2_i24[3] = terminal_chain1_out[51];
    assign C0_c15_3_terminal_chain2_i24[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i24[1] = layer3_col51[1];
    assign C0_c15_3_terminal_chain2_i24[2] = layer3_col51[2];
    assign C1_c15_3_terminal_chain2_i24    = terminal_chain1_out[52];
    
    assign terminal_chain2_out[48] = O_c15_3_terminal_chain2_i24[0];
    assign terminal_chain2_out[49] = O_c15_3_terminal_chain2_i24[1];
    
    assign terminal_chain2_i24            = COUT_LA_terminal_chain2[24];
    assign CY_LA_terminal_chain2[49:48]   = CY_c15_3_terminal_chain2_i24;
    assign PROP_LA_terminal_chain2[49:48] = PROP_c15_3_terminal_chain2_i24;
    
    assign CIN_LA_terminal_chain2[6] = COUT_LA_terminal_chain2[23];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i25(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i25  ),
        .C1  (C1_c15_3_terminal_chain2_i25  ),
        .CLA (CLA_c15_3_terminal_chain2_i25 ),
        .O   (O_c15_3_terminal_chain2_i25   ),
        .CY  (CY_c15_3_terminal_chain2_i25  ),
        .PROP(PROP_c15_3_terminal_chain2_i25));
    
    assign C0_c15_3_terminal_chain2_i25[4] = terminal_chain2_i24;
    assign C0_c15_3_terminal_chain2_i25[3] = terminal_chain1_out[53];
    assign C0_c15_3_terminal_chain2_i25[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i25[1] = layer3_col53[1];
    assign C0_c15_3_terminal_chain2_i25[2] = layer3_col53[2];
    assign C1_c15_3_terminal_chain2_i25    = terminal_chain1_out[54];
    
    assign terminal_chain2_out[50] = O_c15_3_terminal_chain2_i25[0];
    assign terminal_chain2_out[51] = O_c15_3_terminal_chain2_i25[1];
    
    assign terminal_chain2_i25            = COUT_LA_terminal_chain2[25];
    assign CY_LA_terminal_chain2[51:50]   = CY_c15_3_terminal_chain2_i25;
    assign PROP_LA_terminal_chain2[51:50] = PROP_c15_3_terminal_chain2_i25;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_terminal_chain2_i26(
        .clk (clk                           ),
        .C0  (C0_c15_3_terminal_chain2_i26  ),
        .C1  (C1_c15_3_terminal_chain2_i26  ),
        .CLA (CLA_c15_3_terminal_chain2_i26 ),
        .O   (O_c15_3_terminal_chain2_i26   ),
        .CY  (CY_c15_3_terminal_chain2_i26  ),
        .PROP(PROP_c15_3_terminal_chain2_i26));
    
    assign C0_c15_3_terminal_chain2_i26[4] = terminal_chain2_i25;
    assign C0_c15_3_terminal_chain2_i26[3] = terminal_chain1_out[55];
    assign C0_c15_3_terminal_chain2_i26[0] = 1'b0;
    assign C0_c15_3_terminal_chain2_i26[1] = layer3_col55[1];
    assign C0_c15_3_terminal_chain2_i26[2] = layer3_col55[2];
    assign C1_c15_3_terminal_chain2_i26    = terminal_chain1_out[56];
    
    assign terminal_chain2_out[52] = O_c15_3_terminal_chain2_i26[0];
    assign terminal_chain2_out[53] = O_c15_3_terminal_chain2_i26[1];
    
    assign terminal_chain2_i26            = COUT_LA_terminal_chain2[26];
    assign CY_LA_terminal_chain2[53:52]   = CY_c15_3_terminal_chain2_i26;
    assign PROP_LA_terminal_chain2[53:52] = PROP_c15_3_terminal_chain2_i26;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i27(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain2_i27  ),
        .O   (O_c3_2_terminal_chain2_i27   ),
        .CY  (CY_c3_2_terminal_chain2_i27  ),
        .PROP(PROP_c3_2_terminal_chain2_i27));
    
    assign C0_c3_2_terminal_chain2_i27[2] = terminal_chain2_i26;
    assign C0_c3_2_terminal_chain2_i27[0] = terminal_chain1_out[57];
    assign C0_c3_2_terminal_chain2_i27[1] = 1'b0;
    
    assign terminal_chain2_out[54] = O_c3_2_terminal_chain2_i27[0];
    
    assign terminal_chain2_i27         = O_c3_2_terminal_chain2_i27[1];
    assign CY_LA_terminal_chain2[54]   = CY_c3_2_terminal_chain2_i27;
    assign PROP_LA_terminal_chain2[54] = PROP_c3_2_terminal_chain2_i27;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i28(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain2_i28  ),
        .O   (O_c3_2_terminal_chain2_i28   ),
        .CY  (CY_c3_2_terminal_chain2_i28  ),
        .PROP(PROP_c3_2_terminal_chain2_i28));
    
    assign C0_c3_2_terminal_chain2_i28[2] = terminal_chain2_i27;
    assign C0_c3_2_terminal_chain2_i28[0] = terminal_chain1_out[58];
    assign C0_c3_2_terminal_chain2_i28[1] = layer3_col58;
    
    assign terminal_chain2_out[55] = O_c3_2_terminal_chain2_i28[0];
    
    assign terminal_chain2_i28         = COUT_LA_terminal_chain2[27];
    assign CY_LA_terminal_chain2[55]   = CY_c3_2_terminal_chain2_i28;
    assign PROP_LA_terminal_chain2[55] = PROP_c3_2_terminal_chain2_i28;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i29(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain2_i29  ),
        .O   (O_c3_2_terminal_chain2_i29   ),
        .CY  (CY_c3_2_terminal_chain2_i29  ),
        .PROP(PROP_c3_2_terminal_chain2_i29));
    
    assign C0_c3_2_terminal_chain2_i29[2] = terminal_chain2_i28;
    assign C0_c3_2_terminal_chain2_i29[0] = 1'b0;
    assign C0_c3_2_terminal_chain2_i29[1] = layer3_col59;
    
    assign terminal_chain2_out[56] = O_c3_2_terminal_chain2_i29[0];
    assign terminal_chain2_out[57] = O_c3_2_terminal_chain2_i29[1];
    
    assign terminal_chain2_i29         = O_c3_2_terminal_chain2_i29[1];
    assign CY_LA_terminal_chain2[56]   = CY_c3_2_terminal_chain2_i29;
    assign PROP_LA_terminal_chain2[56] = PROP_c3_2_terminal_chain2_i29;
    
    assign CIN_LA_terminal_chain2[7] = COUT_LA_terminal_chain2[27];
    
    always_ff @(posedge clk) begin
        comp_out[2:0] <= terminal_chain1_out[2:0];
    
        comp_out[60:3] <= terminal_chain2_out[57:0];
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
    assign layer0_col20   = col20;
    assign layer0_col21   = col21;
    assign layer0_col22   = col22;
    assign layer0_col23   = col23;
    assign layer0_col24   = col24;
    assign layer0_col25   = col25;
    assign layer0_col26   = col26;
    assign layer0_col27   = col27;
    assign layer0_col28   = col28;
    assign layer0_col29   = col29;
    assign layer0_col30   = col30;
    assign layer0_col31   = col31;
    assign layer0_col32   = col32;
    assign layer0_col33   = col33;
    assign layer0_col34   = col34;
    assign layer0_col35   = col35;
    assign layer0_col36   = col36;
    assign layer0_col37   = col37;
    assign layer0_col38   = col38;
    assign layer0_col39   = col39;
    assign layer0_col40   = col40;
    assign layer0_col41   = col41;
    assign layer0_col42   = col42;
    assign layer0_col43   = col43;
    assign layer0_col44   = col44;
    assign layer0_col45   = col45;
    assign layer0_col46   = col46;
    assign layer0_col47   = col47;
    assign layer0_col48   = col48;
    assign layer0_col49   = col49;
    assign layer0_col50   = col50;
    assign layer0_col51   = col51;
    assign layer0_col52   = col52;
    assign layer0_col53   = col53;
    assign layer0_col54   = col54;
    assign layer0_col55   = col55;
    assign layer0_col56   = col56;
    assign layer0_col57   = col57;
    assign layer0_col58   = col58;
    assign layer0_col59   = col59;
    
endmodule