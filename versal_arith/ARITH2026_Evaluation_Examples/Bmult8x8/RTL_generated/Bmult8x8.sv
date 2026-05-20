`timescale 1ns / 1ps

module Bmult8x8 (
    input  logic          clk,
    input  logic [7  : 0] A,
    input  logic [7  : 0] B,
    output logic [15 : 0] P
    );
    
    logic [7  : 0] OPA;
    logic [7  : 0] OPB;
    logic [1  : 0] col0;
    logic          col1;
    logic [2  : 0] col2;
    logic [1  : 0] col3;
    logic [3  : 0] col4;
    logic [2  : 0] col5;
    logic [4  : 0] col6;
    logic [3  : 0] col7;
    logic [4  : 0] col8;
    logic [3  : 0] col9;
    logic [2  : 0] col10;
    logic [2  : 0] col11;
    logic [1  : 0] col12;
    logic [1  : 0] col13;
    logic          col14;
    logic          col15;
    logic [16 : 0] comp_out;
    
    assign OPA = A;
    assign OPB = B;
    
    Bmult8x8_bitheap_gen Bmult8x8_bitheap_gen_inst (
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
        .col15(col15));
    
    Bmult8x8_bitheap_cmp Bmult8x8_bitheap_cmp_inst(
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
        .comp_out(comp_out));
    
    assign P = comp_out[15:0];

endmodule
