`timescale 1ns / 1ps

module Bmult10x10_bitheap_gen (
    input  logic         clk,
    input  logic [9 : 0] OPA,
    input  logic [9 : 0] OPB,
    output logic [1 : 0] col0,
    output logic         col1,
    output logic [2 : 0] col2,
    output logic [1 : 0] col3,
    output logic [3 : 0] col4,
    output logic [2 : 0] col5,
    output logic [4 : 0] col6,
    output logic [3 : 0] col7,
    output logic [5 : 0] col8,
    output logic [4 : 0] col9,
    output logic [5 : 0] col10,
    output logic [4 : 0] col11,
    output logic [3 : 0] col12,
    output logic [3 : 0] col13,
    output logic [2 : 0] col14,
    output logic [2 : 0] col15,
    output logic [1 : 0] col16,
    output logic [1 : 0] col17,
    output logic         col18,
    output logic         col19
    );
    
    
    logic [1 : 0] col0_wire;
    logic         col1_wire;
    logic [2 : 0] col2_wire;
    logic [1 : 0] col3_wire;
    logic [3 : 0] col4_wire;
    logic [2 : 0] col5_wire;
    logic [4 : 0] col6_wire;
    logic [3 : 0] col7_wire;
    logic [5 : 0] col8_wire;
    logic [4 : 0] col9_wire;
    logic [5 : 0] col10_wire;
    logic [4 : 0] col11_wire;
    logic [3 : 0] col12_wire;
    logic [3 : 0] col13_wire;
    logic [2 : 0] col14_wire;
    logic [2 : 0] col15_wire;
    logic [1 : 0] col16_wire;
    logic [1 : 0] col17_wire;
    logic         col18_wire;
    logic         col19_wire;
    
    // the main part of row 0
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst0 (
        .O6(col1_wire),
        .O5(col0_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(1'b0),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst2 (
        .O6(col3_wire[0]),
        .O5(col2_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[1]),
        .I3(OPA[2]),
        .I4(OPA[3]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst4 (
        .O6(col5_wire[0]),
        .O5(col4_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[3]),
        .I3(OPA[4]),
        .I4(OPA[5]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst6 (
        .O6(col7_wire[0]),
        .O5(col6_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[5]),
        .I3(OPA[6]),
        .I4(OPA[7]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst8 (
        .O6(col9_wire[0]),
        .O5(col8_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[7]),
        .I3(OPA[8]),
        .I4(OPA[9]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row0_inst10 (
        .O (col10_wire[0]),
        .I0(1'b0),
        .I1(OPB[0]),
        .I2(OPB[1]),
        .I3(OPA[9]),
        .I4(OPA[9]));
    
    assign col11_wire[0] = 1'b1;
    
    
    // the main part of row 1
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row1_inst0 (
        .O6(col3_wire[1]),
        .O5(col2_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst2 (
        .O (col4_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst3 (
        .O (col5_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst4 (
        .O (col6_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst5 (
        .O (col7_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst6 (
        .O (col8_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst7 (
        .O (col9_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst8 (
        .O (col10_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst9 (
        .O (col11_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row1_inst10 (
        .O (col12_wire[0]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[9]),
        .I4(OPA[9]));
    
    assign col13_wire[0] = 1'b1;
    
    
    // the main part of row 2
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row2_inst0 (
        .O6(col5_wire[2]),
        .O5(col4_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst2 (
        .O (col6_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst3 (
        .O (col7_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst4 (
        .O (col8_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst5 (
        .O (col9_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst6 (
        .O (col10_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst7 (
        .O (col11_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst8 (
        .O (col12_wire[1]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst9 (
        .O (col13_wire[1]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row2_inst10 (
        .O (col14_wire[0]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[9]),
        .I4(OPA[9]));
    
    assign col15_wire[0] = 1'b1;
    
    
    // the main part of row 3
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row3_inst0 (
        .O6(col7_wire[3]),
        .O5(col6_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst2 (
        .O (col8_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst3 (
        .O (col9_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst4 (
        .O (col10_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst5 (
        .O (col11_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst6 (
        .O (col12_wire[2]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst7 (
        .O (col13_wire[2]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst8 (
        .O (col14_wire[1]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst9 (
        .O (col15_wire[1]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row3_inst10 (
        .O (col16_wire[0]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[9]),
        .I4(OPA[9]));
    
    assign col17_wire[0] = 1'b1;
    
    
    // the main part of row 4
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row4_inst0 (
        .O6(col9_wire[4]),
        .O5(col8_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst2 (
        .O (col10_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst3 (
        .O (col11_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst4 (
        .O (col12_wire[3]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst5 (
        .O (col13_wire[3]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst6 (
        .O (col14_wire[2]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst7 (
        .O (col15_wire[2]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst8 (
        .O (col16_wire[1]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst9 (
        .O (col17_wire[1]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row4_inst10 (
        .O (col18_wire),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[9]),
        .I4(OPA[9]));
    
    assign col19_wire = 1'b1;
    
    assign col0_wire[1] = OPB[1];
    assign col2_wire[2] = OPB[3];
    assign col4_wire[3] = OPB[5];
    assign col6_wire[4] = OPB[7];
    assign col8_wire[5] = OPB[9];
    assign col10_wire[5] = 1'b1;
    
    assign col0 = col0_wire;
    assign col1 = col1_wire;
    assign col2 = col2_wire;
    assign col3 = col3_wire;
    assign col4 = col4_wire;
    assign col5 = col5_wire;
    assign col6 = col6_wire;
    assign col7 = col7_wire;
    assign col8 = col8_wire;
    assign col9 = col9_wire;
    assign col10 = col10_wire;
    assign col11 = col11_wire;
    assign col12 = col12_wire;
    assign col13 = col13_wire;
    assign col14 = col14_wire;
    assign col15 = col15_wire;
    assign col16 = col16_wire;
    assign col17 = col17_wire;
    assign col18 = col18_wire;
    assign col19 = col19_wire;
endmodule