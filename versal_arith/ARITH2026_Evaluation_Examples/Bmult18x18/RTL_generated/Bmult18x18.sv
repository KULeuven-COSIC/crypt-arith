`timescale 1ns / 1ps

module Bmult18x18 (
    input  logic          clk,
    input  logic [17 : 0] A,
    input  logic [17 : 0] B,
    output logic [35 : 0] P
    );
    
    logic [17 : 0] OPA;
    logic [17 : 0] OPB;
    logic [1  : 0] col0;
    logic          col1;
    logic [2  : 0] col2;
    logic [1  : 0] col3;
    logic [3  : 0] col4;
    logic [2  : 0] col5;
    logic [4  : 0] col6;
    logic [3  : 0] col7;
    logic [5  : 0] col8;
    logic [4  : 0] col9;
    logic [6  : 0] col10;
    logic [5  : 0] col11;
    logic [7  : 0] col12;
    logic [6  : 0] col13;
    logic [8  : 0] col14;
    logic [7  : 0] col15;
    logic [9  : 0] col16;
    logic [8  : 0] col17;
    logic [9  : 0] col18;
    logic [8  : 0] col19;
    logic [7  : 0] col20;
    logic [7  : 0] col21;
    logic [6  : 0] col22;
    logic [6  : 0] col23;
    logic [5  : 0] col24;
    logic [5  : 0] col25;
    logic [4  : 0] col26;
    logic [4  : 0] col27;
    logic [3  : 0] col28;
    logic [3  : 0] col29;
    logic [2  : 0] col30;
    logic [2  : 0] col31;
    logic [1  : 0] col32;
    logic [1  : 0] col33;
    logic          col34;
    logic          col35;
    logic [36 : 0] comp_out;
    
    assign OPA = A;
    assign OPB = B;
    
    Bmult18x18_bitheap_gen Bmult18x18_bitheap_gen_inst (
        .clk(clk),
        .OPA(OPA),
        .OPB(OPB),
        .col0(col0),
        .col1(col1),
        .col2(col2),
        .col3(col3),
        .col4(col4),
        .col5(col5),
        .col6(col6),
        .col7(col7),
        .col8(col8),
        .col9(col9),
        .col10(col10),
        .col11(col11),
        .col12(col12),
        .col13(col13),
        .col14(col14),
        .col15(col15),
        .col16(col16),
        .col17(col17),
        .col18(col18),
        .col19(col19),
        .col20(col20),
        .col21(col21),
        .col22(col22),
        .col23(col23),
        .col24(col24),
        .col25(col25),
        .col26(col26),
        .col27(col27),
        .col28(col28),
        .col29(col29),
        .col30(col30),
        .col31(col31),
        .col32(col32),
        .col33(col33),
        .col34(col34),
        .col35(col35));
    
    Bmult18x18_bitheap_cmp Bmult18x18_bitheap_cmp_inst(
        .clk(clk),
        .col0(col0),
        .col1(col1),
        .col2(col2),
        .col3(col3),
        .col4(col4),
        .col5(col5),
        .col6(col6),
        .col7(col7),
        .col8(col8),
        .col9(col9),
        .col10(col10),
        .col11(col11),
        .col12(col12),
        .col13(col13),
        .col14(col14),
        .col15(col15),
        .col16(col16),
        .col17(col17),
        .col18(col18),
        .col19(col19),
        .col20(col20),
        .col21(col21),
        .col22(col22),
        .col23(col23),
        .col24(col24),
        .col25(col25),
        .col26(col26),
        .col27(col27),
        .col28(col28),
        .col29(col29),
        .col30(col30),
        .col31(col31),
        .col32(col32),
        .col33(col33),
        .col34(col34),
        .col35(col35),
        .comp_out(comp_out));
    
    assign P = comp_out[35:0];

endmodule
