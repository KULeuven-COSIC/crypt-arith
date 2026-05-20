`timescale 1ns / 1ps

module Bmult6x6 (
    input  logic          clk,
    input  logic [5  : 0] A,
    input  logic [5  : 0] B,
    output logic [11 : 0] P
    );
    
    logic [5  : 0] OPA;
    logic [5  : 0] OPB;
    logic [1  : 0] col0;
    logic          col1;
    logic [2  : 0] col2;
    logic [1  : 0] col3;
    logic [3  : 0] col4;
    logic [2  : 0] col5;
    logic [3  : 0] col6;
    logic [2  : 0] col7;
    logic [1  : 0] col8;
    logic [1  : 0] col9;
    logic          col10;
    logic          col11;
    logic [12 : 0] comp_out;
    
    assign OPA = A;
    assign OPB = B;
    
    Bmult6x6_bitheap_gen Bmult6x6_bitheap_gen_inst (
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
        .col11(col11));
    
    Bmult6x6_bitheap_cmp Bmult6x6_bitheap_cmp_inst(
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
        .comp_out(comp_out));
    
    assign P = comp_out[11:0];

endmodule
