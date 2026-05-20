`timescale 1ns / 1ps

module Bmult12x12 (
    input  logic          clk,
    input  logic [11 : 0] A,
    input  logic [11 : 0] B,
    output logic [23 : 0] P
    );
    
    logic [11 : 0] OPA;
    logic [11 : 0] OPB;
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
    logic [6  : 0] col12;
    logic [5  : 0] col13;
    logic [4  : 0] col14;
    logic [4  : 0] col15;
    logic [3  : 0] col16;
    logic [3  : 0] col17;
    logic [2  : 0] col18;
    logic [2  : 0] col19;
    logic [1  : 0] col20;
    logic [1  : 0] col21;
    logic          col22;
    logic          col23;
    logic [24 : 0] comp_out;
    
    assign OPA = A;
    assign OPB = B;
    
    Bmult12x12_bitheap_gen Bmult12x12_bitheap_gen_inst (
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
        .col23(col23));
    
    Bmult12x12_bitheap_cmp Bmult12x12_bitheap_cmp_inst(
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
        .comp_out(comp_out));
    
    assign P = comp_out[23:0];

endmodule
