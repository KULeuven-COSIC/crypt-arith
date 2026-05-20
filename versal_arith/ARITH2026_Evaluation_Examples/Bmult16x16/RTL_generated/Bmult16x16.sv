`timescale 1ns / 1ps

module Bmult16x16 (
    input  logic          clk,
    input  logic [15 : 0] A,
    input  logic [15 : 0] B,
    output logic [31 : 0] P
    );
    
    logic [15 : 0] OPA;
    logic [15 : 0] OPB;
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
    logic [8  : 0] col16;
    logic [7  : 0] col17;
    logic [6  : 0] col18;
    logic [6  : 0] col19;
    logic [5  : 0] col20;
    logic [5  : 0] col21;
    logic [4  : 0] col22;
    logic [4  : 0] col23;
    logic [3  : 0] col24;
    logic [3  : 0] col25;
    logic [2  : 0] col26;
    logic [2  : 0] col27;
    logic [1  : 0] col28;
    logic [1  : 0] col29;
    logic          col30;
    logic          col31;
    logic [32 : 0] comp_out;
    
    assign OPA = A;
    assign OPB = B;
    
    Bmult16x16_bitheap_gen Bmult16x16_bitheap_gen_inst (
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
        .col31(col31));
    
    Bmult16x16_bitheap_cmp Bmult16x16_bitheap_cmp_inst(
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
        .comp_out(comp_out));
    
    assign P = comp_out[31:0];

endmodule
