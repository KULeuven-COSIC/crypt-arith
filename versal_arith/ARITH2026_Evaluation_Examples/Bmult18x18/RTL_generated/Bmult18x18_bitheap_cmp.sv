`timescale 1ns / 1ps

module Bmult18x18_bitheap_cmp (
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
    input  logic [9  : 0] col18,
    input  logic [8  : 0] col19,
    input  logic [7  : 0] col20,
    input  logic [7  : 0] col21,
    input  logic [6  : 0] col22,
    input  logic [6  : 0] col23,
    input  logic [5  : 0] col24,
    input  logic [5  : 0] col25,
    input  logic [4  : 0] col26,
    input  logic [4  : 0] col27,
    input  logic [3  : 0] col28,
    input  logic [3  : 0] col29,
    input  logic [2  : 0] col30,
    input  logic [2  : 0] col31,
    input  logic [1  : 0] col32,
    input  logic [1  : 0] col33,
    input  logic          col34,
    input  logic          col35,
    output logic [36 : 0] comp_out
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
    logic [9  : 0] layer0_col18;
    logic [8  : 0] layer0_col19;
    logic [7  : 0] layer0_col20;
    logic [7  : 0] layer0_col21;
    logic [6  : 0] layer0_col22;
    logic [6  : 0] layer0_col23;
    logic [5  : 0] layer0_col24;
    logic [5  : 0] layer0_col25;
    logic [4  : 0] layer0_col26;
    logic [4  : 0] layer0_col27;
    logic [3  : 0] layer0_col28;
    logic [3  : 0] layer0_col29;
    logic [2  : 0] layer0_col30;
    logic [2  : 0] layer0_col31;
    logic [1  : 0] layer0_col32;
    logic [1  : 0] layer0_col33;
    logic          layer0_col34;
    logic          layer0_col35;
    
    logic [11 : 0] COUT_LA_l0_c0_s0;
    logic [2  : 0] CIN_LA_l0_c0_s0;
    logic [23 : 0] CY_LA_l0_c0_s0;
    logic [23 : 0] PROP_LA_l0_c0_s0;
    
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
    
    logic [4 : 0] C0_c15_3_l0_c0_i7;
    logic         C1_c15_3_l0_c0_i7;
    logic         CLA_c15_3_l0_c0_i7;
    logic [2 : 0] O_c15_3_l0_c0_i7;
    logic [1 : 0] CY_c15_3_l0_c0_i7;
    logic [1 : 0] PROP_c15_3_l0_c0_i7;
    logic         l0_c0_i7;
    
    logic [4 : 0] C0_c15_3_l0_c0_i8;
    logic         C1_c15_3_l0_c0_i8;
    logic         CLA_c15_3_l0_c0_i8;
    logic [2 : 0] O_c15_3_l0_c0_i8;
    logic [1 : 0] CY_c15_3_l0_c0_i8;
    logic [1 : 0] PROP_c15_3_l0_c0_i8;
    logic         l0_c0_i8;
    
    logic [4 : 0] C0_c15_3_l0_c0_i9;
    logic         C1_c15_3_l0_c0_i9;
    logic         CLA_c15_3_l0_c0_i9;
    logic [2 : 0] O_c15_3_l0_c0_i9;
    logic [1 : 0] CY_c15_3_l0_c0_i9;
    logic [1 : 0] PROP_c15_3_l0_c0_i9;
    logic         l0_c0_i9;
    
    logic [4 : 0] C0_c15_3_l0_c0_i10;
    logic         C1_c15_3_l0_c0_i10;
    logic         CLA_c15_3_l0_c0_i10;
    logic [2 : 0] O_c15_3_l0_c0_i10;
    logic [1 : 0] CY_c15_3_l0_c0_i10;
    logic [1 : 0] PROP_c15_3_l0_c0_i10;
    logic         l0_c0_i10;
    
    logic [2 : 0] C0_c3_2_l0_c0_i11;
    logic [1 : 0] O_c3_2_l0_c0_i11;
    logic         CY_c3_2_l0_c0_i11;
    logic         PROP_c3_2_l0_c0_i11;
    logic         l0_c0_i11;
    
    logic [2 : 0] C0_c3_2_l0_c0_i12;
    logic [1 : 0] O_c3_2_l0_c0_i12;
    logic         CY_c3_2_l0_c0_i12;
    logic         PROP_c3_2_l0_c0_i12;
    logic         l0_c0_i12;
    
    logic [2 : 0] C0_c3_2_l0_c0_i13;
    logic [1 : 0] O_c3_2_l0_c0_i13;
    logic         CY_c3_2_l0_c0_i13;
    logic         PROP_c3_2_l0_c0_i13;
    logic         l0_c0_i13;
    
    logic [2 : 0] C0_c3_2_l0_c0_i14;
    logic [1 : 0] O_c3_2_l0_c0_i14;
    logic         CY_c3_2_l0_c0_i14;
    logic         PROP_c3_2_l0_c0_i14;
    logic         l0_c0_i14;
    
    logic [11 : 0] COUT_LA_l0_c1_s0;
    logic [2  : 0] CIN_LA_l0_c1_s0;
    logic [23 : 0] CY_LA_l0_c1_s0;
    logic [23 : 0] PROP_LA_l0_c1_s0;
    
    logic [2 : 0] C0_c3_2_l0_c1_i0;
    logic [1 : 0] O_c3_2_l0_c1_i0;
    logic         CY_c3_2_l0_c1_i0;
    logic         PROP_c3_2_l0_c1_i0;
    logic         l0_c1_i0;
    
    logic [2 : 0] C0_c3_2_l0_c1_i1;
    logic [1 : 0] O_c3_2_l0_c1_i1;
    logic         CY_c3_2_l0_c1_i1;
    logic         PROP_c3_2_l0_c1_i1;
    logic         l0_c1_i1;
    
    logic [4 : 0] C0_c15_3_l0_c1_i2;
    logic         C1_c15_3_l0_c1_i2;
    logic         CLA_c15_3_l0_c1_i2;
    logic [2 : 0] O_c15_3_l0_c1_i2;
    logic [1 : 0] CY_c15_3_l0_c1_i2;
    logic [1 : 0] PROP_c15_3_l0_c1_i2;
    logic         l0_c1_i2;
    
    logic [4 : 0] C0_c15_3_l0_c1_i3;
    logic         C1_c15_3_l0_c1_i3;
    logic         CLA_c15_3_l0_c1_i3;
    logic [2 : 0] O_c15_3_l0_c1_i3;
    logic [1 : 0] CY_c15_3_l0_c1_i3;
    logic [1 : 0] PROP_c15_3_l0_c1_i3;
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
    
    logic [4 : 0] C0_c15_3_l0_c1_i7;
    logic         C1_c15_3_l0_c1_i7;
    logic         CLA_c15_3_l0_c1_i7;
    logic [2 : 0] O_c15_3_l0_c1_i7;
    logic [1 : 0] CY_c15_3_l0_c1_i7;
    logic [1 : 0] PROP_c15_3_l0_c1_i7;
    logic         l0_c1_i7;
    
    logic [4 : 0] C0_c15_3_l0_c1_i8;
    logic         C1_c15_3_l0_c1_i8;
    logic         CLA_c15_3_l0_c1_i8;
    logic [2 : 0] O_c15_3_l0_c1_i8;
    logic [1 : 0] CY_c15_3_l0_c1_i8;
    logic [1 : 0] PROP_c15_3_l0_c1_i8;
    logic         l0_c1_i8;
    
    logic [4 : 0] C0_c15_3_l0_c1_i9;
    logic         C1_c15_3_l0_c1_i9;
    logic         CLA_c15_3_l0_c1_i9;
    logic [2 : 0] O_c15_3_l0_c1_i9;
    logic [1 : 0] CY_c15_3_l0_c1_i9;
    logic [1 : 0] PROP_c15_3_l0_c1_i9;
    logic         l0_c1_i9;
    
    logic [2 : 0] C0_c3_2_l0_c1_i10;
    logic [1 : 0] O_c3_2_l0_c1_i10;
    logic         CY_c3_2_l0_c1_i10;
    logic         PROP_c3_2_l0_c1_i10;
    logic         l0_c1_i10;
    
    logic [7  : 0] COUT_LA_l0_c2_s0;
    logic [1  : 0] CIN_LA_l0_c2_s0;
    logic [15 : 0] CY_LA_l0_c2_s0;
    logic [15 : 0] PROP_LA_l0_c2_s0;
    
    logic [2 : 0] C0_c3_2_l0_c2_i0;
    logic [1 : 0] O_c3_2_l0_c2_i0;
    logic         CY_c3_2_l0_c2_i0;
    logic         PROP_c3_2_l0_c2_i0;
    logic         l0_c2_i0;
    
    logic [2 : 0] C0_c3_2_l0_c2_i1;
    logic [1 : 0] O_c3_2_l0_c2_i1;
    logic         CY_c3_2_l0_c2_i1;
    logic         PROP_c3_2_l0_c2_i1;
    logic         l0_c2_i1;
    
    logic [4 : 0] C0_c15_3_l0_c2_i2;
    logic         C1_c15_3_l0_c2_i2;
    logic         CLA_c15_3_l0_c2_i2;
    logic [2 : 0] O_c15_3_l0_c2_i2;
    logic [1 : 0] CY_c15_3_l0_c2_i2;
    logic [1 : 0] PROP_c15_3_l0_c2_i2;
    logic         l0_c2_i2;
    
    logic [4 : 0] C0_c15_3_l0_c2_i3;
    logic         C1_c15_3_l0_c2_i3;
    logic         CLA_c15_3_l0_c2_i3;
    logic [2 : 0] O_c15_3_l0_c2_i3;
    logic [1 : 0] CY_c15_3_l0_c2_i3;
    logic [1 : 0] PROP_c15_3_l0_c2_i3;
    logic         l0_c2_i3;
    
    logic [4 : 0] C0_c15_3_l0_c2_i4;
    logic         C1_c15_3_l0_c2_i4;
    logic         CLA_c15_3_l0_c2_i4;
    logic [2 : 0] O_c15_3_l0_c2_i4;
    logic [1 : 0] CY_c15_3_l0_c2_i4;
    logic [1 : 0] PROP_c15_3_l0_c2_i4;
    logic         l0_c2_i4;
    
    logic [2 : 0] C0_c3_2_l0_c2_i5;
    logic [1 : 0] O_c3_2_l0_c2_i5;
    logic         CY_c3_2_l0_c2_i5;
    logic         PROP_c3_2_l0_c2_i5;
    logic         l0_c2_i5;
    
    logic [2 : 0] C0_c3_2_l0_c2_i6;
    logic [1 : 0] O_c3_2_l0_c2_i6;
    logic         CY_c3_2_l0_c2_i6;
    logic         PROP_c3_2_l0_c2_i6;
    logic         l0_c2_i6;
    
    logic [2 : 0] C0_c3_2_l0_c2_i7;
    logic [1 : 0] O_c3_2_l0_c2_i7;
    logic         CY_c3_2_l0_c2_i7;
    logic         PROP_c3_2_l0_c2_i7;
    logic         l0_c2_i7;
    
    logic [2 : 0] C0_c3_2_l0_c2_i8;
    logic [1 : 0] O_c3_2_l0_c2_i8;
    logic         CY_c3_2_l0_c2_i8;
    logic         PROP_c3_2_l0_c2_i8;
    logic         l0_c2_i8;
    
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
    logic [4  : 0] layer1_col18;
    logic [3  : 0] layer1_col19;
    logic [4  : 0] layer1_col20;
    logic [3  : 0] layer1_col21;
    logic [2  : 0] layer1_col22;
    logic [2  : 0] layer1_col23;
    logic [3  : 0] layer1_col24;
    logic [2  : 0] layer1_col25;
    logic [3  : 0] layer1_col26;
    logic [2  : 0] layer1_col27;
    logic [3  : 0] layer1_col28;
    logic [2  : 0] layer1_col29;
    logic [3  : 0] layer1_col30;
    logic [2  : 0] layer1_col31;
    logic [1  : 0] layer1_col32;
    logic [1  : 0] layer1_col33;
    logic          layer1_col34;
    logic          layer1_col35;
    
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
    
    logic [2 : 0] C0_c223_4_l1_c0_i1;
    logic [1 : 0] C1_c223_4_l1_c0_i1;
    logic [1 : 0] C2_c223_4_l1_c0_i1;
    logic         CLA_c223_4_l1_c0_i1;
    logic [3 : 0] O_c223_4_l1_c0_i1;
    logic [1 : 0] CY_c223_4_l1_c0_i1;
    logic [1 : 0] PROP_c223_4_l1_c0_i1;
    logic         l1_c0_i1;
    
    logic [2 : 0] C0_c3_2_l1_f0;
    logic [1 : 0] O_c3_2_l1_i0;
    logic         CY_c3_2_l1_f0;
    logic         PROP_c3_2_l1_f0;
    
    logic    COUT_LA_l1_floating_placement;
    logic    CIN_LA_l1_floating_placement;
    logic    CY_LA_l1_floating_placement;
    logic    PROP_LA_l1_floating_placement;
    
    
    
    // -------------------------------------------------- TERMINAL ADDITION ------------------------------------------------
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
    logic [3  : 0] layer2_col18;
    logic [2  : 0] layer2_col19;
    logic [3  : 0] layer2_col20;
    logic [2  : 0] layer2_col21;
    logic [3  : 0] layer2_col22;
    logic [2  : 0] layer2_col23;
    logic [3  : 0] layer2_col24;
    logic [2  : 0] layer2_col25;
    logic [3  : 0] layer2_col26;
    logic [2  : 0] layer2_col27;
    logic [3  : 0] layer2_col28;
    logic [2  : 0] layer2_col29;
    logic [3  : 0] layer2_col30;
    logic [2  : 0] layer2_col31;
    logic [1  : 0] layer2_col32;
    logic [1  : 0] layer2_col33;
    logic          layer2_col34;
    logic          layer2_col35;
    
    logic [34 : 0] terminal_chain1_out;
    
    logic [19 : 0] COUT_LA_terminal_chain1;
    logic [4  : 0] CIN_LA_terminal_chain1;
    logic [39 : 0] CY_LA_terminal_chain1;
    logic [39 : 0] PROP_LA_terminal_chain1;
    
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
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i17;
    logic [1 : 0] O_c3_2_terminal_chain1_i17;
    logic         CY_c3_2_terminal_chain1_i17;
    logic         PROP_c3_2_terminal_chain1_i17;
    logic         terminal_chain1_i17;
    
    logic [2 : 0] C0_c3_2_terminal_chain1_i18;
    logic [1 : 0] O_c3_2_terminal_chain1_i18;
    logic         CY_c3_2_terminal_chain1_i18;
    logic         PROP_c3_2_terminal_chain1_i18;
    logic         terminal_chain1_i18;
    
    logic [33 : 0] terminal_chain2_out;
    
    logic [19 : 0] COUT_LA_terminal_chain2;
    logic [4  : 0] CIN_LA_terminal_chain2;
    logic [39 : 0] CY_LA_terminal_chain2;
    logic [39 : 0] PROP_LA_terminal_chain2;
    
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
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i15;
    logic [1 : 0] O_c3_2_terminal_chain2_i15;
    logic         CY_c3_2_terminal_chain2_i15;
    logic         PROP_c3_2_terminal_chain2_i15;
    logic         terminal_chain2_i15;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i16;
    logic [1 : 0] O_c3_2_terminal_chain2_i16;
    logic         CY_c3_2_terminal_chain2_i16;
    logic         PROP_c3_2_terminal_chain2_i16;
    logic         terminal_chain2_i16;
    
    logic [2 : 0] C0_c3_2_terminal_chain2_i17;
    logic [1 : 0] O_c3_2_terminal_chain2_i17;
    logic         CY_c3_2_terminal_chain2_i17;
    logic         PROP_c3_2_terminal_chain2_i17;
    logic         terminal_chain2_i17;
    
    // ------------------------------ LAYER 0 ------------------------------
    // GPC chain0 in layer0:
    // -- (3 : 2] at column 6
    // -- (3 : 2] at column 7
    // -- (1,5 : 3] at column 8
    // -- (1,5 : 3] at column 10
    // -- (1,5 : 3] at column 12
    // -- (1,5 : 3] at column 14
    // -- (1,5 : 3] at column 16
    // -- (1,5 : 3] at column 18
    // -- (1,5 : 3] at column 20
    // -- (1,5 : 3] at column 22
    // -- (1,5 : 3] at column 24
    // -- (3 : 2] at column 26
    // -- (3 : 2] at column 27
    // -- (3 : 2] at column 28
    // -- (3 : 2] at column 29
    
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
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
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
        .LOOKB("TRUE" ),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c0_s0_inst2 (
        .COUTB(COUT_LA_l0_c0_s0[8] ),
        .COUTD(COUT_LA_l0_c0_s0[9] ),
        .COUTF(COUT_LA_l0_c0_s0[10]),
        .COUTH(COUT_LA_l0_c0_s0[11]),
        .CIN  (CIN_LA_l0_c0_s0[2]  ),
        .CYA  (CY_LA_l0_c0_s0[16]  ),
        .CYB  (CY_LA_l0_c0_s0[17]  ),
        .CYC  (CY_LA_l0_c0_s0[18]  ),
        .CYD  (CY_LA_l0_c0_s0[19]  ),
        .CYE  (CY_LA_l0_c0_s0[20]  ),
        .CYF  (CY_LA_l0_c0_s0[21]  ),
        .CYG  (CY_LA_l0_c0_s0[22]  ),
        .CYH  (CY_LA_l0_c0_s0[23]  ),
        .PROPA(PROP_LA_l0_c0_s0[16]),
        .PROPB(PROP_LA_l0_c0_s0[17]),
        .PROPC(PROP_LA_l0_c0_s0[18]),
        .PROPD(PROP_LA_l0_c0_s0[19]),
        .PROPE(PROP_LA_l0_c0_s0[20]),
        .PROPF(PROP_LA_l0_c0_s0[21]),
        .PROPG(PROP_LA_l0_c0_s0[22]),
        .PROPH(PROP_LA_l0_c0_s0[23]));

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
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i7(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i7  ),
        .C1  (C1_c15_3_l0_c0_i7  ),
        .CLA (CLA_c15_3_l0_c0_i7 ),
        .O   (O_c15_3_l0_c0_i7   ),
        .CY  (CY_c15_3_l0_c0_i7  ),
        .PROP(PROP_c15_3_l0_c0_i7));
    
    assign C0_c15_3_l0_c0_i7 = {l0_c0_i6, layer0_col18[3:0]};
    assign C1_c15_3_l0_c0_i7 = layer0_col19[0];
    
    assign layer1_col18[0] = O_c15_3_l0_c0_i7[0];
    assign layer1_col19[0] = O_c15_3_l0_c0_i7[1];
    
    assign l0_c0_i7                = COUT_LA_l0_c0_s0[6];
    assign CY_LA_l0_c0_s0[13:12]   = CY_c15_3_l0_c0_i7;
    assign PROP_LA_l0_c0_s0[13:12] = PROP_c15_3_l0_c0_i7;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i8(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i8  ),
        .C1  (C1_c15_3_l0_c0_i8  ),
        .CLA (CLA_c15_3_l0_c0_i8 ),
        .O   (O_c15_3_l0_c0_i8   ),
        .CY  (CY_c15_3_l0_c0_i8  ),
        .PROP(PROP_c15_3_l0_c0_i8));
    
    assign C0_c15_3_l0_c0_i8 = {l0_c0_i7, layer0_col20[3:0]};
    assign C1_c15_3_l0_c0_i8 = layer0_col21[0];
    
    assign layer1_col20[0] = O_c15_3_l0_c0_i8[0];
    assign layer1_col21[0] = O_c15_3_l0_c0_i8[1];
    
    assign l0_c0_i8                = COUT_LA_l0_c0_s0[7];
    assign CY_LA_l0_c0_s0[15:14]   = CY_c15_3_l0_c0_i8;
    assign PROP_LA_l0_c0_s0[15:14] = PROP_c15_3_l0_c0_i8;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i9(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c0_i9  ),
        .C1  (C1_c15_3_l0_c0_i9  ),
        .CLA (CLA_c15_3_l0_c0_i9 ),
        .O   (O_c15_3_l0_c0_i9   ),
        .CY  (CY_c15_3_l0_c0_i9  ),
        .PROP(PROP_c15_3_l0_c0_i9));
    
    assign C0_c15_3_l0_c0_i9 = {l0_c0_i8, layer0_col22[3:0]};
    assign C1_c15_3_l0_c0_i9 = layer0_col23[0];
    
    assign layer1_col22[0] = O_c15_3_l0_c0_i9[0];
    assign layer1_col23[0] = O_c15_3_l0_c0_i9[1];
    
    assign l0_c0_i9                = COUT_LA_l0_c0_s0[8];
    assign CY_LA_l0_c0_s0[17:16]   = CY_c15_3_l0_c0_i9;
    assign PROP_LA_l0_c0_s0[17:16] = PROP_c15_3_l0_c0_i9;
    
    assign CIN_LA_l0_c0_s0[2] = COUT_LA_l0_c0_s0[7];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c0_i10(
        .clk (clk                 ),
        .C0  (C0_c15_3_l0_c0_i10  ),
        .C1  (C1_c15_3_l0_c0_i10  ),
        .CLA (CLA_c15_3_l0_c0_i10 ),
        .O   (O_c15_3_l0_c0_i10   ),
        .CY  (CY_c15_3_l0_c0_i10  ),
        .PROP(PROP_c15_3_l0_c0_i10));
    
    assign C0_c15_3_l0_c0_i10 = {l0_c0_i9, layer0_col24[3:0]};
    assign C1_c15_3_l0_c0_i10 = layer0_col25[0];
    
    assign layer1_col24[0] = O_c15_3_l0_c0_i10[0];
    assign layer1_col25[0] = O_c15_3_l0_c0_i10[1];
    
    assign l0_c0_i10               = COUT_LA_l0_c0_s0[9];
    assign CY_LA_l0_c0_s0[19:18]   = CY_c15_3_l0_c0_i10;
    assign PROP_LA_l0_c0_s0[19:18] = PROP_c15_3_l0_c0_i10;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c0_i11(
        .clk (clk                ),
        .C0  (C0_c3_2_l0_c0_i11  ),
        .O   (O_c3_2_l0_c0_i11   ),
        .CY  (CY_c3_2_l0_c0_i11  ),
        .PROP(PROP_c3_2_l0_c0_i11));
    
    assign C0_c3_2_l0_c0_i11 = {l0_c0_i10, layer0_col26[1:0]};
    
    assign layer1_col26[0] = O_c3_2_l0_c0_i11[0];
    
    assign l0_c0_i11            = O_c3_2_l0_c0_i11[1];
    assign CY_LA_l0_c0_s0[20]   = CY_c3_2_l0_c0_i11;
    assign PROP_LA_l0_c0_s0[20] = PROP_c3_2_l0_c0_i11;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c0_i12(
        .clk (clk                ),
        .C0  (C0_c3_2_l0_c0_i12  ),
        .O   (O_c3_2_l0_c0_i12   ),
        .CY  (CY_c3_2_l0_c0_i12  ),
        .PROP(PROP_c3_2_l0_c0_i12));
    
    assign C0_c3_2_l0_c0_i12 = {l0_c0_i11, layer0_col27[1:0]};
    
    assign layer1_col27[0] = O_c3_2_l0_c0_i12[0];
    
    assign l0_c0_i12            = COUT_LA_l0_c0_s0[10];
    assign CY_LA_l0_c0_s0[21]   = CY_c3_2_l0_c0_i12;
    assign PROP_LA_l0_c0_s0[21] = PROP_c3_2_l0_c0_i12;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c0_i13(
        .clk (clk                ),
        .C0  (C0_c3_2_l0_c0_i13  ),
        .O   (O_c3_2_l0_c0_i13   ),
        .CY  (CY_c3_2_l0_c0_i13  ),
        .PROP(PROP_c3_2_l0_c0_i13));
    
    assign C0_c3_2_l0_c0_i13 = {l0_c0_i12, layer0_col28[1:0]};
    
    assign layer1_col28[0] = O_c3_2_l0_c0_i13[0];
    
    assign l0_c0_i13            = O_c3_2_l0_c0_i13[1];
    assign CY_LA_l0_c0_s0[22]   = CY_c3_2_l0_c0_i13;
    assign PROP_LA_l0_c0_s0[22] = PROP_c3_2_l0_c0_i13;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c0_i14(
        .clk (clk                ),
        .C0  (C0_c3_2_l0_c0_i14  ),
        .O   (O_c3_2_l0_c0_i14   ),
        .CY  (CY_c3_2_l0_c0_i14  ),
        .PROP(PROP_c3_2_l0_c0_i14));
    
    assign C0_c3_2_l0_c0_i14 = {l0_c0_i13, layer0_col29[1:0]};
    
    assign layer1_col29[0] = O_c3_2_l0_c0_i14[0];
    assign layer1_col30[0] = O_c3_2_l0_c0_i14[1];
    
    assign l0_c0_i14            = COUT_LA_l0_c0_s0[11];
    assign CY_LA_l0_c0_s0[23]   = CY_c3_2_l0_c0_i14;
    assign PROP_LA_l0_c0_s0[23] = PROP_c3_2_l0_c0_i14;
    
    // GPC chain1 in layer0:
    // -- (3 : 2] at column 9
    // -- (3 : 2] at column 10
    // -- (1,5 : 3] at column 11
    // -- (1,5 : 3] at column 13
    // -- (1,5 : 3] at column 15
    // -- (1,5 : 3] at column 17
    // -- (1,5 : 3] at column 19
    // -- (1,5 : 3] at column 21
    // -- (1,5 : 3] at column 23
    // -- (1,5 : 3] at column 25
    // -- (3 : 2] at column 27
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l0_c1_s0_inst0 (
        .COUTB(COUT_LA_l0_c1_s0[0]),
        .COUTD(COUT_LA_l0_c1_s0[1]),
        .COUTF(COUT_LA_l0_c1_s0[2]),
        .COUTH(COUT_LA_l0_c1_s0[3]),
        .CIN  (CIN_LA_l0_c1_s0[0] ),
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
        .LOOKB("TRUE"),
        .LOOKD("TRUE"),
        .LOOKF("TRUE"),
        .LOOKH("TRUE"))
    LOOKAHEAD8_l0_c1_s0_inst1 (
        .COUTB(COUT_LA_l0_c1_s0[4] ),
        .COUTD(COUT_LA_l0_c1_s0[5] ),
        .COUTF(COUT_LA_l0_c1_s0[6] ),
        .COUTH(COUT_LA_l0_c1_s0[7] ),
        .CIN  (CIN_LA_l0_c1_s0[1]  ),
        .CYA  (CY_LA_l0_c1_s0[8]   ),
        .CYB  (CY_LA_l0_c1_s0[9]   ),
        .CYC  (CY_LA_l0_c1_s0[10]  ),
        .CYD  (CY_LA_l0_c1_s0[11]  ),
        .CYE  (CY_LA_l0_c1_s0[12]  ),
        .CYF  (CY_LA_l0_c1_s0[13]  ),
        .CYG  (CY_LA_l0_c1_s0[14]  ),
        .CYH  (CY_LA_l0_c1_s0[15]  ),
        .PROPA(PROP_LA_l0_c1_s0[8] ),
        .PROPB(PROP_LA_l0_c1_s0[9] ),
        .PROPC(PROP_LA_l0_c1_s0[10]),
        .PROPD(PROP_LA_l0_c1_s0[11]),
        .PROPE(PROP_LA_l0_c1_s0[12]),
        .PROPF(PROP_LA_l0_c1_s0[13]),
        .PROPG(PROP_LA_l0_c1_s0[14]),
        .PROPH(PROP_LA_l0_c1_s0[15]));

    LOOKAHEAD8 #(
        .LOOKB("TRUE" ),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c1_s0_inst2 (
        .COUTB(COUT_LA_l0_c1_s0[8] ),
        .COUTD(COUT_LA_l0_c1_s0[9] ),
        .COUTF(COUT_LA_l0_c1_s0[10]),
        .COUTH(COUT_LA_l0_c1_s0[11]),
        .CIN  (CIN_LA_l0_c1_s0[2]  ),
        .CYA  (CY_LA_l0_c1_s0[16]  ),
        .CYB  (CY_LA_l0_c1_s0[17]  ),
        .CYC  (CY_LA_l0_c1_s0[18]  ),
        .CYD  (CY_LA_l0_c1_s0[19]  ),
        .CYE  (CY_LA_l0_c1_s0[20]  ),
        .CYF  (CY_LA_l0_c1_s0[21]  ),
        .CYG  (CY_LA_l0_c1_s0[22]  ),
        .CYH  (CY_LA_l0_c1_s0[23]  ),
        .PROPA(PROP_LA_l0_c1_s0[16]),
        .PROPB(PROP_LA_l0_c1_s0[17]),
        .PROPC(PROP_LA_l0_c1_s0[18]),
        .PROPD(PROP_LA_l0_c1_s0[19]),
        .PROPE(PROP_LA_l0_c1_s0[20]),
        .PROPF(PROP_LA_l0_c1_s0[21]),
        .PROPG(PROP_LA_l0_c1_s0[22]),
        .PROPH(PROP_LA_l0_c1_s0[23]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c1_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c1_i0  ),
        .O   (O_c3_2_l0_c1_i0   ),
        .CY  (CY_c3_2_l0_c1_i0  ),
        .PROP(PROP_c3_2_l0_c1_i0));
    
    assign C0_c3_2_l0_c1_i0 = layer0_col9[3:1];
    
    assign layer1_col9[1]  = O_c3_2_l0_c1_i0[0];
    
    assign l0_c1_i0            = O_c3_2_l0_c1_i0[1];
    assign CY_LA_l0_c1_s0[0]   = CY_c3_2_l0_c1_i0;
    assign PROP_LA_l0_c1_s0[0] = PROP_c3_2_l0_c1_i0;
    
    assign CIN_LA_l0_c1_s0[0] = C0_c3_2_l0_c1_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c1_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c1_i1  ),
        .O   (O_c3_2_l0_c1_i1   ),
        .CY  (CY_c3_2_l0_c1_i1  ),
        .PROP(PROP_c3_2_l0_c1_i1));
    
    assign C0_c3_2_l0_c1_i1 = {l0_c1_i0, layer0_col10[5:4]};
    
    assign layer1_col10[1] = O_c3_2_l0_c1_i1[0];
    
    assign l0_c1_i1            = COUT_LA_l0_c1_s0[0];
    assign CY_LA_l0_c1_s0[1]   = CY_c3_2_l0_c1_i1;
    assign PROP_LA_l0_c1_s0[1] = PROP_c3_2_l0_c1_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i2  ),
        .C1  (C1_c15_3_l0_c1_i2  ),
        .CLA (CLA_c15_3_l0_c1_i2 ),
        .O   (O_c15_3_l0_c1_i2   ),
        .CY  (CY_c15_3_l0_c1_i2  ),
        .PROP(PROP_c15_3_l0_c1_i2));
    
    assign C0_c15_3_l0_c1_i2 = {l0_c1_i1, layer0_col11[4:1]};
    assign C1_c15_3_l0_c1_i2 = layer0_col12[4];
    
    assign layer1_col11[1] = O_c15_3_l0_c1_i2[0];
    assign layer1_col12[1] = O_c15_3_l0_c1_i2[1];
    
    assign l0_c1_i2              = COUT_LA_l0_c1_s0[1];
    assign CY_LA_l0_c1_s0[3:2]   = CY_c15_3_l0_c1_i2;
    assign PROP_LA_l0_c1_s0[3:2] = PROP_c15_3_l0_c1_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i3  ),
        .C1  (C1_c15_3_l0_c1_i3  ),
        .CLA (CLA_c15_3_l0_c1_i3 ),
        .O   (O_c15_3_l0_c1_i3   ),
        .CY  (CY_c15_3_l0_c1_i3  ),
        .PROP(PROP_c15_3_l0_c1_i3));
    
    assign C0_c15_3_l0_c1_i3 = {l0_c1_i2, layer0_col13[4:1]};
    assign C1_c15_3_l0_c1_i3 = layer0_col14[4];
    
    assign layer1_col13[1] = O_c15_3_l0_c1_i3[0];
    assign layer1_col14[1] = O_c15_3_l0_c1_i3[1];
    
    assign l0_c1_i3              = COUT_LA_l0_c1_s0[2];
    assign CY_LA_l0_c1_s0[5:4]   = CY_c15_3_l0_c1_i3;
    assign PROP_LA_l0_c1_s0[5:4] = PROP_c15_3_l0_c1_i3;
    
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
    
    assign C0_c15_3_l0_c1_i4 = {l0_c1_i3, layer0_col15[4:1]};
    assign C1_c15_3_l0_c1_i4 = layer0_col16[4];
    
    assign layer1_col15[1] = O_c15_3_l0_c1_i4[0];
    assign layer1_col16[1] = O_c15_3_l0_c1_i4[1];
    
    assign l0_c1_i4              = COUT_LA_l0_c1_s0[3];
    assign CY_LA_l0_c1_s0[7:6]   = CY_c15_3_l0_c1_i4;
    assign PROP_LA_l0_c1_s0[7:6] = PROP_c15_3_l0_c1_i4;
    
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
    
    assign C0_c15_3_l0_c1_i5 = {l0_c1_i4, layer0_col17[4:1]};
    assign C1_c15_3_l0_c1_i5 = layer0_col18[4];
    
    assign layer1_col17[1] = O_c15_3_l0_c1_i5[0];
    assign layer1_col18[1] = O_c15_3_l0_c1_i5[1];
    
    assign l0_c1_i5              = COUT_LA_l0_c1_s0[4];
    assign CY_LA_l0_c1_s0[9:8]   = CY_c15_3_l0_c1_i5;
    assign PROP_LA_l0_c1_s0[9:8] = PROP_c15_3_l0_c1_i5;
    
    assign CIN_LA_l0_c1_s0[1] = COUT_LA_l0_c1_s0[3];
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i6(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i6  ),
        .C1  (C1_c15_3_l0_c1_i6  ),
        .CLA (CLA_c15_3_l0_c1_i6 ),
        .O   (O_c15_3_l0_c1_i6   ),
        .CY  (CY_c15_3_l0_c1_i6  ),
        .PROP(PROP_c15_3_l0_c1_i6));
    
    assign C0_c15_3_l0_c1_i6 = {l0_c1_i5, layer0_col19[4:1]};
    assign C1_c15_3_l0_c1_i6 = layer0_col20[4];
    
    assign layer1_col19[1] = O_c15_3_l0_c1_i6[0];
    assign layer1_col20[1] = O_c15_3_l0_c1_i6[1];
    
    assign l0_c1_i6                = COUT_LA_l0_c1_s0[5];
    assign CY_LA_l0_c1_s0[11:10]   = CY_c15_3_l0_c1_i6;
    assign PROP_LA_l0_c1_s0[11:10] = PROP_c15_3_l0_c1_i6;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i7(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i7  ),
        .C1  (C1_c15_3_l0_c1_i7  ),
        .CLA (CLA_c15_3_l0_c1_i7 ),
        .O   (O_c15_3_l0_c1_i7   ),
        .CY  (CY_c15_3_l0_c1_i7  ),
        .PROP(PROP_c15_3_l0_c1_i7));
    
    assign C0_c15_3_l0_c1_i7 = {l0_c1_i6, layer0_col21[4:1]};
    assign C1_c15_3_l0_c1_i7 = layer0_col22[4];
    
    assign layer1_col21[1] = O_c15_3_l0_c1_i7[0];
    assign layer1_col22[1] = O_c15_3_l0_c1_i7[1];
    
    assign l0_c1_i7                = COUT_LA_l0_c1_s0[6];
    assign CY_LA_l0_c1_s0[13:12]   = CY_c15_3_l0_c1_i7;
    assign PROP_LA_l0_c1_s0[13:12] = PROP_c15_3_l0_c1_i7;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i8(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i8  ),
        .C1  (C1_c15_3_l0_c1_i8  ),
        .CLA (CLA_c15_3_l0_c1_i8 ),
        .O   (O_c15_3_l0_c1_i8   ),
        .CY  (CY_c15_3_l0_c1_i8  ),
        .PROP(PROP_c15_3_l0_c1_i8));
    
    assign C0_c15_3_l0_c1_i8 = {l0_c1_i7, layer0_col23[4:1]};
    assign C1_c15_3_l0_c1_i8 = layer0_col24[4];
    
    assign layer1_col23[1] = O_c15_3_l0_c1_i8[0];
    assign layer1_col24[1] = O_c15_3_l0_c1_i8[1];
    
    assign l0_c1_i8                = COUT_LA_l0_c1_s0[7];
    assign CY_LA_l0_c1_s0[15:14]   = CY_c15_3_l0_c1_i8;
    assign PROP_LA_l0_c1_s0[15:14] = PROP_c15_3_l0_c1_i8;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c1_i9(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c1_i9  ),
        .C1  (C1_c15_3_l0_c1_i9  ),
        .CLA (CLA_c15_3_l0_c1_i9 ),
        .O   (O_c15_3_l0_c1_i9   ),
        .CY  (CY_c15_3_l0_c1_i9  ),
        .PROP(PROP_c15_3_l0_c1_i9));
    
    assign C0_c15_3_l0_c1_i9 = {l0_c1_i8, layer0_col25[4:1]};
    assign C1_c15_3_l0_c1_i9 = layer0_col26[2];
    
    assign layer1_col25[1] = O_c15_3_l0_c1_i9[0];
    assign layer1_col26[1] = O_c15_3_l0_c1_i9[1];
    
    assign l0_c1_i9                = COUT_LA_l0_c1_s0[8];
    assign CY_LA_l0_c1_s0[17:16]   = CY_c15_3_l0_c1_i9;
    assign PROP_LA_l0_c1_s0[17:16] = PROP_c15_3_l0_c1_i9;
    
    assign CIN_LA_l0_c1_s0[2] = COUT_LA_l0_c1_s0[7];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c1_i10(
        .clk (clk                ),
        .C0  (C0_c3_2_l0_c1_i10  ),
        .O   (O_c3_2_l0_c1_i10   ),
        .CY  (CY_c3_2_l0_c1_i10  ),
        .PROP(PROP_c3_2_l0_c1_i10));
    
    assign C0_c3_2_l0_c1_i10 = {l0_c1_i9, layer0_col27[3:2]};
    
    assign layer1_col27[1] = O_c3_2_l0_c1_i10[0];
    assign layer1_col28[1] = O_c3_2_l0_c1_i10[1];
    
    assign l0_c1_i10            = O_c3_2_l0_c1_i10[1];
    assign CY_LA_l0_c1_s0[18]   = CY_c3_2_l0_c1_i10;
    assign PROP_LA_l0_c1_s0[18] = PROP_c3_2_l0_c1_i10;
    
    // GPC chain2 in layer0:
    // -- (3 : 2] at column 12
    // -- (3 : 2] at column 13
    // -- (1,5 : 3] at column 14
    // -- (1,5 : 3] at column 16
    // -- (1,5 : 3] at column 18
    // -- (3 : 2] at column 20
    // -- (3 : 2] at column 21
    // -- (3 : 2] at column 22
    // -- (3 : 2] at column 23
    
    LOOKAHEAD8 #(
        .LOOKB("FALSE"),
        .LOOKD("TRUE" ),
        .LOOKF("TRUE" ),
        .LOOKH("TRUE" ))
    LOOKAHEAD8_l0_c2_s0_inst0 (
        .COUTB(COUT_LA_l0_c2_s0[0]),
        .COUTD(COUT_LA_l0_c2_s0[1]),
        .COUTF(COUT_LA_l0_c2_s0[2]),
        .COUTH(COUT_LA_l0_c2_s0[3]),
        .CIN  (CIN_LA_l0_c2_s0[0] ),
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

    LOOKAHEAD8 #(
        .LOOKB("TRUE" ),
        .LOOKD("FALSE"),
        .LOOKF("FALSE"),
        .LOOKH("FALSE"))
    LOOKAHEAD8_l0_c2_s0_inst1 (
        .COUTB(COUT_LA_l0_c2_s0[4] ),
        .COUTD(COUT_LA_l0_c2_s0[5] ),
        .COUTF(COUT_LA_l0_c2_s0[6] ),
        .COUTH(COUT_LA_l0_c2_s0[7] ),
        .CIN  (CIN_LA_l0_c2_s0[1]  ),
        .CYA  (CY_LA_l0_c2_s0[8]   ),
        .CYB  (CY_LA_l0_c2_s0[9]   ),
        .CYC  (CY_LA_l0_c2_s0[10]  ),
        .CYD  (CY_LA_l0_c2_s0[11]  ),
        .CYE  (CY_LA_l0_c2_s0[12]  ),
        .CYF  (CY_LA_l0_c2_s0[13]  ),
        .CYG  (CY_LA_l0_c2_s0[14]  ),
        .CYH  (CY_LA_l0_c2_s0[15]  ),
        .PROPA(PROP_LA_l0_c2_s0[8] ),
        .PROPB(PROP_LA_l0_c2_s0[9] ),
        .PROPC(PROP_LA_l0_c2_s0[10]),
        .PROPD(PROP_LA_l0_c2_s0[11]),
        .PROPE(PROP_LA_l0_c2_s0[12]),
        .PROPF(PROP_LA_l0_c2_s0[13]),
        .PROPG(PROP_LA_l0_c2_s0[14]),
        .PROPH(PROP_LA_l0_c2_s0[15]));

    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i0(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i0  ),
        .O   (O_c3_2_l0_c2_i0   ),
        .CY  (CY_c3_2_l0_c2_i0  ),
        .PROP(PROP_c3_2_l0_c2_i0));
    
    assign C0_c3_2_l0_c2_i0 = layer0_col12[7:5];
    
    assign layer1_col12[2] = O_c3_2_l0_c2_i0[0];
    
    assign l0_c2_i0            = O_c3_2_l0_c2_i0[1];
    assign CY_LA_l0_c2_s0[0]   = CY_c3_2_l0_c2_i0;
    assign PROP_LA_l0_c2_s0[0] = PROP_c3_2_l0_c2_i0;
    
    assign CIN_LA_l0_c2_s0[0] = C0_c3_2_l0_c2_i0[2];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("TRUE" ),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i1(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i1  ),
        .O   (O_c3_2_l0_c2_i1   ),
        .CY  (CY_c3_2_l0_c2_i1  ),
        .PROP(PROP_c3_2_l0_c2_i1));
    
    assign C0_c3_2_l0_c2_i1 = {l0_c2_i0, layer0_col13[6:5]};
    
    assign layer1_col13[2] = O_c3_2_l0_c2_i1[0];
    
    assign l0_c2_i1            = COUT_LA_l0_c2_s0[0];
    assign CY_LA_l0_c2_s0[1]   = CY_c3_2_l0_c2_i1;
    assign PROP_LA_l0_c2_s0[1] = PROP_c3_2_l0_c2_i1;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c2_i2(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c2_i2  ),
        .C1  (C1_c15_3_l0_c2_i2  ),
        .CLA (CLA_c15_3_l0_c2_i2 ),
        .O   (O_c15_3_l0_c2_i2   ),
        .CY  (CY_c15_3_l0_c2_i2  ),
        .PROP(PROP_c15_3_l0_c2_i2));
    
    assign C0_c15_3_l0_c2_i2 = {l0_c2_i1, layer0_col14[8:5]};
    assign C1_c15_3_l0_c2_i2 = layer0_col15[5];
    
    assign layer1_col14[2] = O_c15_3_l0_c2_i2[0];
    assign layer1_col15[2] = O_c15_3_l0_c2_i2[1];
    
    assign l0_c2_i2              = COUT_LA_l0_c2_s0[1];
    assign CY_LA_l0_c2_s0[3:2]   = CY_c15_3_l0_c2_i2;
    assign PROP_LA_l0_c2_s0[3:2] = PROP_c15_3_l0_c2_i2;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c2_i3(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c2_i3  ),
        .C1  (C1_c15_3_l0_c2_i3  ),
        .CLA (CLA_c15_3_l0_c2_i3 ),
        .O   (O_c15_3_l0_c2_i3   ),
        .CY  (CY_c15_3_l0_c2_i3  ),
        .PROP(PROP_c15_3_l0_c2_i3));
    
    assign C0_c15_3_l0_c2_i3 = {l0_c2_i2, layer0_col16[8:5]};
    assign C1_c15_3_l0_c2_i3 = layer0_col17[5];
    
    assign layer1_col16[2] = O_c15_3_l0_c2_i3[0];
    assign layer1_col17[2] = O_c15_3_l0_c2_i3[1];
    
    assign l0_c2_i3              = COUT_LA_l0_c2_s0[2];
    assign CY_LA_l0_c2_s0[5:4]   = CY_c15_3_l0_c2_i3;
    assign PROP_LA_l0_c2_s0[5:4] = PROP_c15_3_l0_c2_i3;
    
    c15_3 #(.OUTREG("FALSE"),
            .LEAVEC("TRUE" ),
            .POSODD("FALSE"),
            .FIRSTS("FALSE"),
            .LASTS ("FALSE"))
    c15_3_l0_c2_i4(
        .clk (clk                ),
        .C0  (C0_c15_3_l0_c2_i4  ),
        .C1  (C1_c15_3_l0_c2_i4  ),
        .CLA (CLA_c15_3_l0_c2_i4 ),
        .O   (O_c15_3_l0_c2_i4   ),
        .CY  (CY_c15_3_l0_c2_i4  ),
        .PROP(PROP_c15_3_l0_c2_i4));
    
    assign C0_c15_3_l0_c2_i4 = {l0_c2_i3, layer0_col18[8:5]};
    assign C1_c15_3_l0_c2_i4 = layer0_col19[5];
    
    assign layer1_col18[2] = O_c15_3_l0_c2_i4[0];
    assign layer1_col19[2] = O_c15_3_l0_c2_i4[1];
    
    assign l0_c2_i4              = COUT_LA_l0_c2_s0[3];
    assign CY_LA_l0_c2_s0[7:6]   = CY_c15_3_l0_c2_i4;
    assign PROP_LA_l0_c2_s0[7:6] = PROP_c15_3_l0_c2_i4;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i5(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i5  ),
        .O   (O_c3_2_l0_c2_i5   ),
        .CY  (CY_c3_2_l0_c2_i5  ),
        .PROP(PROP_c3_2_l0_c2_i5));
    
    assign C0_c3_2_l0_c2_i5 = {l0_c2_i4, layer0_col20[6:5]};
    
    assign layer1_col20[2] = O_c3_2_l0_c2_i5[0];
    
    assign l0_c2_i5            = O_c3_2_l0_c2_i5[1];
    assign CY_LA_l0_c2_s0[8]   = CY_c3_2_l0_c2_i5;
    assign PROP_LA_l0_c2_s0[8] = PROP_c3_2_l0_c2_i5;
    
    assign CIN_LA_l0_c2_s0[1] = COUT_LA_l0_c2_s0[3];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i6(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i6  ),
        .O   (O_c3_2_l0_c2_i6   ),
        .CY  (CY_c3_2_l0_c2_i6  ),
        .PROP(PROP_c3_2_l0_c2_i6));
    
    assign C0_c3_2_l0_c2_i6 = {l0_c2_i5, layer0_col21[6:5]};
    
    assign layer1_col21[2] = O_c3_2_l0_c2_i6[0];
    
    assign l0_c2_i6            = COUT_LA_l0_c2_s0[4];
    assign CY_LA_l0_c2_s0[9]   = CY_c3_2_l0_c2_i6;
    assign PROP_LA_l0_c2_s0[9] = PROP_c3_2_l0_c2_i6;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_l0_c2_i7(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i7  ),
        .O   (O_c3_2_l0_c2_i7   ),
        .CY  (CY_c3_2_l0_c2_i7  ),
        .PROP(PROP_c3_2_l0_c2_i7));
    
    assign C0_c3_2_l0_c2_i7 = {l0_c2_i6, layer0_col22[6:5]};
    
    assign layer1_col22[2] = O_c3_2_l0_c2_i7[0];
    
    assign l0_c2_i7             = O_c3_2_l0_c2_i7[1];
    assign CY_LA_l0_c2_s0[10]   = CY_c3_2_l0_c2_i7;
    assign PROP_LA_l0_c2_s0[10] = PROP_c3_2_l0_c2_i7;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("FALSE"),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_l0_c2_i8(
        .clk (clk               ),
        .C0  (C0_c3_2_l0_c2_i8  ),
        .O   (O_c3_2_l0_c2_i8   ),
        .CY  (CY_c3_2_l0_c2_i8  ),
        .PROP(PROP_c3_2_l0_c2_i8));
    
    assign C0_c3_2_l0_c2_i8 = {l0_c2_i7, layer0_col23[6:5]};
    
    assign layer1_col23[2] = O_c3_2_l0_c2_i8[0];
    assign layer1_col24[2] = O_c3_2_l0_c2_i8[1];
    
    assign l0_c2_i8             = COUT_LA_l0_c2_s0[5];
    assign CY_LA_l0_c2_s0[11]   = CY_c3_2_l0_c2_i8;
    assign PROP_LA_l0_c2_s0[11] = PROP_c3_2_l0_c2_i8;
    
    // GPC0 in layer0: (3 : 2] at column 17
    
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
    
    assign C0_c3_2_l0_f0 = layer0_col17[8:6];
    
    assign layer1_col17[3] = O_c3_2_l0_i0[0];
    assign layer1_col18[3] = O_c3_2_l0_i0[1];
    
    // GPC1 in layer0: (3 : 2] at column 19
    
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
    
    assign C0_c3_2_l0_f1 = layer0_col19[8:6];
    
    assign layer1_col19[3] = O_c3_2_l0_i1[0];
    assign layer1_col20[3] = O_c3_2_l0_i1[1];
    
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
    assign layer1_col18[4] = layer0_col18[9];
    assign layer1_col20[4] = layer0_col20[7];
    assign layer1_col21[3] = layer0_col21[7];
    assign layer1_col24[3] = layer0_col24[5];
    assign layer1_col25[2] = layer0_col25[5];
    assign layer1_col26[2] = layer0_col26[3];
    assign layer1_col26[3] = layer0_col26[4];
    assign layer1_col27[2] = layer0_col27[4];
    assign layer1_col28[2] = layer0_col28[2];
    assign layer1_col28[3] = layer0_col28[3];
    assign layer1_col29[1] = layer0_col29[2];
    assign layer1_col29[2] = layer0_col29[3];
    assign layer1_col30[1] = layer0_col30[0];
    assign layer1_col30[2] = layer0_col30[1];
    assign layer1_col30[3] = layer0_col30[2];
    assign layer1_col31[0] = layer0_col31[0];
    assign layer1_col31[1] = layer0_col31[1];
    assign layer1_col31[2] = layer0_col31[2];
    assign layer1_col32[0] = layer0_col32[0];
    assign layer1_col32[1] = layer0_col32[1];
    assign layer1_col33[0] = layer0_col33[0];
    assign layer1_col33[1] = layer0_col33[1];
    assign layer1_col34    = layer0_col34;
    assign layer1_col35    = layer0_col35;
    // ------------------------------ LAYER 1 ------------------------------
    // GPC chain0 in layer1:
    // -- (2,2,3 : 4] at column 15
    // -- (2,2,3 : 4] at column 18
    
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
    
    c223_4 #(.OUTREG("FALSE"),
             .LEAVEC("FALSE"),
             .POSODD("FALSE"))
    c223_4_l1_c0_i1(
        .clk (clk                 ),
        .C0  (C0_c223_4_l1_c0_i1  ),
        .C1  (C1_c223_4_l1_c0_i1  ),
        .C2  (C2_c223_4_l1_c0_i1  ),
        .CLA (CLA_c223_4_l1_c0_i1 ),
        .O   (O_c223_4_l1_c0_i1   ),
        .CY  (CY_c223_4_l1_c0_i1  ),
        .PROP(PROP_c223_4_l1_c0_i1));
    
    assign C0_c223_4_l1_c0_i1 = {l1_c0_i0, layer1_col18[1:0]};
    assign C1_c223_4_l1_c0_i1 = layer1_col19[1:0];
    assign C2_c223_4_l1_c0_i1 = layer1_col20[1:0];
    
    assign layer2_col18[0] = O_c223_4_l1_c0_i1[0];
    assign layer2_col19[0] = O_c223_4_l1_c0_i1[1];
    assign layer2_col20[0] = O_c223_4_l1_c0_i1[2];
    assign layer2_col21[0] = O_c223_4_l1_c0_i1[3];
    
    assign l1_c0_i1              = COUT_LA_l1_c0_s0[1];
    assign CY_LA_l1_c0_s0[3:2]   = CY_c223_4_l1_c0_i1;
    assign PROP_LA_l1_c0_s0[3:2] = PROP_c223_4_l1_c0_i1;
    
    // GPC0 in layer1: (3 : 2] at column 21
    
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
    
    assign C0_c3_2_l1_f0 = layer1_col21[2:0];
    
    assign layer2_col21[1] = O_c3_2_l1_i0[0];
    assign layer2_col22[0] = O_c3_2_l1_i0[1];
    
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
    assign layer2_col18[3] = layer1_col18[4];
    assign layer2_col19[1] = layer1_col19[2];
    assign layer2_col19[2] = layer1_col19[3];
    assign layer2_col20[1] = layer1_col20[2];
    assign layer2_col20[2] = layer1_col20[3];
    assign layer2_col20[3] = layer1_col20[4];
    assign layer2_col21[2] = layer1_col21[3];
    assign layer2_col22[1] = layer1_col22[0];
    assign layer2_col22[2] = layer1_col22[1];
    assign layer2_col22[3] = layer1_col22[2];
    assign layer2_col23[0] = layer1_col23[0];
    assign layer2_col23[1] = layer1_col23[1];
    assign layer2_col23[2] = layer1_col23[2];
    assign layer2_col24[0] = layer1_col24[0];
    assign layer2_col24[1] = layer1_col24[1];
    assign layer2_col24[2] = layer1_col24[2];
    assign layer2_col24[3] = layer1_col24[3];
    assign layer2_col25[0] = layer1_col25[0];
    assign layer2_col25[1] = layer1_col25[1];
    assign layer2_col25[2] = layer1_col25[2];
    assign layer2_col26[0] = layer1_col26[0];
    assign layer2_col26[1] = layer1_col26[1];
    assign layer2_col26[2] = layer1_col26[2];
    assign layer2_col26[3] = layer1_col26[3];
    assign layer2_col27[0] = layer1_col27[0];
    assign layer2_col27[1] = layer1_col27[1];
    assign layer2_col27[2] = layer1_col27[2];
    assign layer2_col28[0] = layer1_col28[0];
    assign layer2_col28[1] = layer1_col28[1];
    assign layer2_col28[2] = layer1_col28[2];
    assign layer2_col28[3] = layer1_col28[3];
    assign layer2_col29[0] = layer1_col29[0];
    assign layer2_col29[1] = layer1_col29[1];
    assign layer2_col29[2] = layer1_col29[2];
    assign layer2_col30[0] = layer1_col30[0];
    assign layer2_col30[1] = layer1_col30[1];
    assign layer2_col30[2] = layer1_col30[2];
    assign layer2_col30[3] = layer1_col30[3];
    assign layer2_col31[0] = layer1_col31[0];
    assign layer2_col31[1] = layer1_col31[1];
    assign layer2_col31[2] = layer1_col31[2];
    assign layer2_col32[0] = layer1_col32[0];
    assign layer2_col32[1] = layer1_col32[1];
    assign layer2_col33[0] = layer1_col33[0];
    assign layer2_col33[1] = layer1_col33[1];
    assign layer2_col34    = layer1_col34;
    assign layer2_col35    = layer1_col35;
    
    
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
    
    assign C0_c3_2_terminal_chain1_i0[0] = layer2_col0[0];
    assign C0_c3_2_terminal_chain1_i0[1] = layer2_col0[1];
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
    assign C0_c3_2_terminal_chain1_i1[0] = layer2_col1;
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
    assign C0_c15_3_terminal_chain1_i2[1] = layer2_col2[0];
    assign C0_c15_3_terminal_chain1_i2[2] = layer2_col2[1];
    assign C0_c15_3_terminal_chain1_i2[3] = layer2_col2[2];
    assign C1_c15_3_terminal_chain1_i2    = layer2_col3[0];
    
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
    assign C0_c15_3_terminal_chain1_i3[0] = layer2_col4[0];
    assign C0_c15_3_terminal_chain1_i3[1] = layer2_col4[1];
    assign C0_c15_3_terminal_chain1_i3[2] = layer2_col4[2];
    assign C0_c15_3_terminal_chain1_i3[3] = layer2_col4[3];
    assign C1_c15_3_terminal_chain1_i3    = layer2_col5[0];
    
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
    assign C0_c15_3_terminal_chain1_i4[1] = layer2_col6[0];
    assign C0_c15_3_terminal_chain1_i4[2] = layer2_col6[1];
    assign C0_c15_3_terminal_chain1_i4[3] = layer2_col6[2];
    assign C1_c15_3_terminal_chain1_i4    = layer2_col7[0];
    
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
    assign C0_c15_3_terminal_chain1_i5[1] = layer2_col8[0];
    assign C0_c15_3_terminal_chain1_i5[2] = layer2_col8[1];
    assign C0_c15_3_terminal_chain1_i5[3] = layer2_col8[2];
    assign C1_c15_3_terminal_chain1_i5    = layer2_col9[0];
    
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
    assign C0_c15_3_terminal_chain1_i6[1] = layer2_col10[0];
    assign C0_c15_3_terminal_chain1_i6[2] = layer2_col10[1];
    assign C0_c15_3_terminal_chain1_i6[3] = layer2_col10[2];
    assign C1_c15_3_terminal_chain1_i6    = layer2_col11[0];
    
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
    assign C0_c15_3_terminal_chain1_i7[1] = layer2_col12[0];
    assign C0_c15_3_terminal_chain1_i7[2] = layer2_col12[1];
    assign C0_c15_3_terminal_chain1_i7[3] = layer2_col12[2];
    assign C1_c15_3_terminal_chain1_i7    = layer2_col13[0];
    
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
    assign C0_c15_3_terminal_chain1_i8[1] = layer2_col14[0];
    assign C0_c15_3_terminal_chain1_i8[2] = layer2_col14[1];
    assign C0_c15_3_terminal_chain1_i8[3] = layer2_col14[2];
    assign C1_c15_3_terminal_chain1_i8    = layer2_col15[0];
    
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
    assign C0_c15_3_terminal_chain1_i9[1] = layer2_col16[0];
    assign C0_c15_3_terminal_chain1_i9[2] = layer2_col16[1];
    assign C0_c15_3_terminal_chain1_i9[3] = layer2_col16[2];
    assign C1_c15_3_terminal_chain1_i9    = layer2_col17[0];
    
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
    assign C0_c15_3_terminal_chain1_i10[0] = layer2_col18[0];
    assign C0_c15_3_terminal_chain1_i10[1] = layer2_col18[1];
    assign C0_c15_3_terminal_chain1_i10[2] = layer2_col18[2];
    assign C0_c15_3_terminal_chain1_i10[3] = layer2_col18[3];
    assign C1_c15_3_terminal_chain1_i10    = layer2_col19[0];
    
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
    assign C0_c15_3_terminal_chain1_i11[0] = layer2_col20[0];
    assign C0_c15_3_terminal_chain1_i11[1] = layer2_col20[1];
    assign C0_c15_3_terminal_chain1_i11[2] = layer2_col20[2];
    assign C0_c15_3_terminal_chain1_i11[3] = layer2_col20[3];
    assign C1_c15_3_terminal_chain1_i11    = layer2_col21[0];
    
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
    assign C0_c15_3_terminal_chain1_i12[0] = layer2_col22[0];
    assign C0_c15_3_terminal_chain1_i12[1] = layer2_col22[1];
    assign C0_c15_3_terminal_chain1_i12[2] = layer2_col22[2];
    assign C0_c15_3_terminal_chain1_i12[3] = layer2_col22[3];
    assign C1_c15_3_terminal_chain1_i12    = layer2_col23[0];
    
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
    assign C0_c15_3_terminal_chain1_i13[0] = layer2_col24[0];
    assign C0_c15_3_terminal_chain1_i13[1] = layer2_col24[1];
    assign C0_c15_3_terminal_chain1_i13[2] = layer2_col24[2];
    assign C0_c15_3_terminal_chain1_i13[3] = layer2_col24[3];
    assign C1_c15_3_terminal_chain1_i13    = layer2_col25[0];
    
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
    assign C0_c15_3_terminal_chain1_i14[0] = layer2_col26[0];
    assign C0_c15_3_terminal_chain1_i14[1] = layer2_col26[1];
    assign C0_c15_3_terminal_chain1_i14[2] = layer2_col26[2];
    assign C0_c15_3_terminal_chain1_i14[3] = layer2_col26[3];
    assign C1_c15_3_terminal_chain1_i14    = layer2_col27[0];
    
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
    assign C0_c15_3_terminal_chain1_i15[0] = layer2_col28[0];
    assign C0_c15_3_terminal_chain1_i15[1] = layer2_col28[1];
    assign C0_c15_3_terminal_chain1_i15[2] = layer2_col28[2];
    assign C0_c15_3_terminal_chain1_i15[3] = layer2_col28[3];
    assign C1_c15_3_terminal_chain1_i15    = layer2_col29[0];
    
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
    assign C0_c15_3_terminal_chain1_i16[0] = layer2_col30[0];
    assign C0_c15_3_terminal_chain1_i16[1] = layer2_col30[1];
    assign C0_c15_3_terminal_chain1_i16[2] = layer2_col30[2];
    assign C0_c15_3_terminal_chain1_i16[3] = layer2_col30[3];
    assign C1_c15_3_terminal_chain1_i16    = layer2_col31[0];
    
    assign terminal_chain1_out[30] = O_c15_3_terminal_chain1_i16[0];
    assign terminal_chain1_out[31] = O_c15_3_terminal_chain1_i16[1];
    
    assign terminal_chain1_i16            = COUT_LA_terminal_chain1[15];
    assign CY_LA_terminal_chain1[31:30]   = CY_c15_3_terminal_chain1_i16;
    assign PROP_LA_terminal_chain1[31:30] = PROP_c15_3_terminal_chain1_i16;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain1_i17(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain1_i17  ),
        .O   (O_c3_2_terminal_chain1_i17   ),
        .CY  (CY_c3_2_terminal_chain1_i17  ),
        .PROP(PROP_c3_2_terminal_chain1_i17));
    
    assign C0_c3_2_terminal_chain1_i17[2] = terminal_chain1_i16;
    assign C0_c3_2_terminal_chain1_i17[0] = layer2_col32[0];
    assign C0_c3_2_terminal_chain1_i17[1] = layer2_col32[1];
    
    assign terminal_chain1_out[32] = O_c3_2_terminal_chain1_i17[0];
    
    assign terminal_chain1_i17         = O_c3_2_terminal_chain1_i17[1];
    assign CY_LA_terminal_chain1[32]   = CY_c3_2_terminal_chain1_i17;
    assign PROP_LA_terminal_chain1[32] = PROP_c3_2_terminal_chain1_i17;
    
    assign CIN_LA_terminal_chain1[4] = COUT_LA_terminal_chain1[15];
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain1_i18(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain1_i18  ),
        .O   (O_c3_2_terminal_chain1_i18   ),
        .CY  (CY_c3_2_terminal_chain1_i18  ),
        .PROP(PROP_c3_2_terminal_chain1_i18));
    
    assign C0_c3_2_terminal_chain1_i18[2] = terminal_chain1_i17;
    assign C0_c3_2_terminal_chain1_i18[0] = layer2_col33[0];
    assign C0_c3_2_terminal_chain1_i18[1] = layer2_col33[1];
    
    assign terminal_chain1_out[33] = O_c3_2_terminal_chain1_i18[0];
    assign terminal_chain1_out[34] = O_c3_2_terminal_chain1_i18[1];
    
    assign terminal_chain1_i18         = COUT_LA_terminal_chain1[16];
    assign CY_LA_terminal_chain1[33]   = CY_c3_2_terminal_chain1_i18;
    assign PROP_LA_terminal_chain1[33] = PROP_c3_2_terminal_chain1_i18;
    
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
    assign C0_c15_3_terminal_chain2_i0[2] = layer2_col3[1];
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
    assign C0_c15_3_terminal_chain2_i1[1] = layer2_col5[1];
    assign C0_c15_3_terminal_chain2_i1[2] = layer2_col5[2];
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
    assign C0_c15_3_terminal_chain2_i2[1] = layer2_col7[1];
    assign C0_c15_3_terminal_chain2_i2[2] = layer2_col7[2];
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
    assign C0_c15_3_terminal_chain2_i3[1] = layer2_col9[1];
    assign C0_c15_3_terminal_chain2_i3[2] = layer2_col9[2];
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
    assign C0_c15_3_terminal_chain2_i4[1] = layer2_col11[1];
    assign C0_c15_3_terminal_chain2_i4[2] = layer2_col11[2];
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
    assign C0_c15_3_terminal_chain2_i5[1] = layer2_col13[1];
    assign C0_c15_3_terminal_chain2_i5[2] = layer2_col13[2];
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
    assign C0_c15_3_terminal_chain2_i6[1] = layer2_col15[1];
    assign C0_c15_3_terminal_chain2_i6[2] = layer2_col15[2];
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
    assign C0_c15_3_terminal_chain2_i7[1] = layer2_col17[1];
    assign C0_c15_3_terminal_chain2_i7[2] = layer2_col17[2];
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
    assign C0_c15_3_terminal_chain2_i8[1] = layer2_col19[1];
    assign C0_c15_3_terminal_chain2_i8[2] = layer2_col19[2];
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
    assign C0_c15_3_terminal_chain2_i9[1] = layer2_col21[1];
    assign C0_c15_3_terminal_chain2_i9[2] = layer2_col21[2];
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
    assign C0_c15_3_terminal_chain2_i10[1] = layer2_col23[1];
    assign C0_c15_3_terminal_chain2_i10[2] = layer2_col23[2];
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
    assign C0_c15_3_terminal_chain2_i11[1] = layer2_col25[1];
    assign C0_c15_3_terminal_chain2_i11[2] = layer2_col25[2];
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
    assign C0_c15_3_terminal_chain2_i12[1] = layer2_col27[1];
    assign C0_c15_3_terminal_chain2_i12[2] = layer2_col27[2];
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
    assign C0_c15_3_terminal_chain2_i13[1] = layer2_col29[1];
    assign C0_c15_3_terminal_chain2_i13[2] = layer2_col29[2];
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
    assign C0_c15_3_terminal_chain2_i14[1] = layer2_col31[1];
    assign C0_c15_3_terminal_chain2_i14[2] = layer2_col31[2];
    assign C1_c15_3_terminal_chain2_i14    = terminal_chain1_out[32];
    
    assign terminal_chain2_out[28] = O_c15_3_terminal_chain2_i14[0];
    assign terminal_chain2_out[29] = O_c15_3_terminal_chain2_i14[1];
    
    assign terminal_chain2_i14            = COUT_LA_terminal_chain2[14];
    assign CY_LA_terminal_chain2[29:28]   = CY_c15_3_terminal_chain2_i14;
    assign PROP_LA_terminal_chain2[29:28] = PROP_c15_3_terminal_chain2_i14;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i15(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain2_i15  ),
        .O   (O_c3_2_terminal_chain2_i15   ),
        .CY  (CY_c3_2_terminal_chain2_i15  ),
        .PROP(PROP_c3_2_terminal_chain2_i15));
    
    assign C0_c3_2_terminal_chain2_i15[2] = terminal_chain2_i14;
    assign C0_c3_2_terminal_chain2_i15[0] = terminal_chain1_out[33];
    assign C0_c3_2_terminal_chain2_i15[1] = 1'b0;
    
    assign terminal_chain2_out[30] = O_c3_2_terminal_chain2_i15[0];
    
    assign terminal_chain2_i15         = O_c3_2_terminal_chain2_i15[1];
    assign CY_LA_terminal_chain2[30]   = CY_c3_2_terminal_chain2_i15;
    assign PROP_LA_terminal_chain2[30] = PROP_c3_2_terminal_chain2_i15;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("TRUE" ),
           .FIRSTS("FALSE"),
           .LASTS ("FALSE"))
    c3_2_terminal_chain2_i16(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain2_i16  ),
        .O   (O_c3_2_terminal_chain2_i16   ),
        .CY  (CY_c3_2_terminal_chain2_i16  ),
        .PROP(PROP_c3_2_terminal_chain2_i16));
    
    assign C0_c3_2_terminal_chain2_i16[2] = terminal_chain2_i15;
    assign C0_c3_2_terminal_chain2_i16[0] = terminal_chain1_out[34];
    assign C0_c3_2_terminal_chain2_i16[1] = layer2_col34;
    
    assign terminal_chain2_out[31] = O_c3_2_terminal_chain2_i16[0];
    
    assign terminal_chain2_i16         = COUT_LA_terminal_chain2[15];
    assign CY_LA_terminal_chain2[31]   = CY_c3_2_terminal_chain2_i16;
    assign PROP_LA_terminal_chain2[31] = PROP_c3_2_terminal_chain2_i16;
    
    c3_2 #(.OUTREG("FALSE"),
           .LEAVEC("TRUE" ),
           .POSODD("FALSE"),
           .FIRSTS("FALSE"),
           .LASTS ("TRUE" ))
    c3_2_terminal_chain2_i17(
        .clk (clk                          ),
        .C0  (C0_c3_2_terminal_chain2_i17  ),
        .O   (O_c3_2_terminal_chain2_i17   ),
        .CY  (CY_c3_2_terminal_chain2_i17  ),
        .PROP(PROP_c3_2_terminal_chain2_i17));
    
    assign C0_c3_2_terminal_chain2_i17[2] = terminal_chain2_i16;
    assign C0_c3_2_terminal_chain2_i17[0] = 1'b0;
    assign C0_c3_2_terminal_chain2_i17[1] = layer2_col35;
    
    assign terminal_chain2_out[32] = O_c3_2_terminal_chain2_i17[0];
    assign terminal_chain2_out[33] = O_c3_2_terminal_chain2_i17[1];
    
    assign terminal_chain2_i17         = O_c3_2_terminal_chain2_i17[1];
    assign CY_LA_terminal_chain2[32]   = CY_c3_2_terminal_chain2_i17;
    assign PROP_LA_terminal_chain2[32] = PROP_c3_2_terminal_chain2_i17;
    
    assign CIN_LA_terminal_chain2[4] = COUT_LA_terminal_chain2[15];
    
    always_ff @(posedge clk) begin
        comp_out[2:0] <= terminal_chain1_out[2:0];
    
        comp_out[36:3] <= terminal_chain2_out[33:0];
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
    
endmodule