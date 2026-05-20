`timescale 1ns / 1ps

module Bmult26x26_bitheap_gen (
    input  logic          clk,
    input  logic [25 : 0] OPA,
    input  logic [25 : 0] OPB,
    output logic [1  : 0] col0,
    output logic          col1,
    output logic [2  : 0] col2,
    output logic [1  : 0] col3,
    output logic [3  : 0] col4,
    output logic [2  : 0] col5,
    output logic [4  : 0] col6,
    output logic [3  : 0] col7,
    output logic [5  : 0] col8,
    output logic [4  : 0] col9,
    output logic [6  : 0] col10,
    output logic [5  : 0] col11,
    output logic [7  : 0] col12,
    output logic [6  : 0] col13,
    output logic [8  : 0] col14,
    output logic [7  : 0] col15,
    output logic [9  : 0] col16,
    output logic [8  : 0] col17,
    output logic [10 : 0] col18,
    output logic [9  : 0] col19,
    output logic [11 : 0] col20,
    output logic [10 : 0] col21,
    output logic [12 : 0] col22,
    output logic [11 : 0] col23,
    output logic [13 : 0] col24,
    output logic [12 : 0] col25,
    output logic [13 : 0] col26,
    output logic [12 : 0] col27,
    output logic [11 : 0] col28,
    output logic [11 : 0] col29,
    output logic [10 : 0] col30,
    output logic [10 : 0] col31,
    output logic [9  : 0] col32,
    output logic [9  : 0] col33,
    output logic [8  : 0] col34,
    output logic [8  : 0] col35,
    output logic [7  : 0] col36,
    output logic [7  : 0] col37,
    output logic [6  : 0] col38,
    output logic [6  : 0] col39,
    output logic [5  : 0] col40,
    output logic [5  : 0] col41,
    output logic [4  : 0] col42,
    output logic [4  : 0] col43,
    output logic [3  : 0] col44,
    output logic [3  : 0] col45,
    output logic [2  : 0] col46,
    output logic [2  : 0] col47,
    output logic [1  : 0] col48,
    output logic [1  : 0] col49,
    output logic          col50,
    output logic          col51
    );
    
    
    logic [1  : 0] col0_wire;
    logic          col1_wire;
    logic [2  : 0] col2_wire;
    logic [1  : 0] col3_wire;
    logic [3  : 0] col4_wire;
    logic [2  : 0] col5_wire;
    logic [4  : 0] col6_wire;
    logic [3  : 0] col7_wire;
    logic [5  : 0] col8_wire;
    logic [4  : 0] col9_wire;
    logic [6  : 0] col10_wire;
    logic [5  : 0] col11_wire;
    logic [7  : 0] col12_wire;
    logic [6  : 0] col13_wire;
    logic [8  : 0] col14_wire;
    logic [7  : 0] col15_wire;
    logic [9  : 0] col16_wire;
    logic [8  : 0] col17_wire;
    logic [10 : 0] col18_wire;
    logic [9  : 0] col19_wire;
    logic [11 : 0] col20_wire;
    logic [10 : 0] col21_wire;
    logic [12 : 0] col22_wire;
    logic [11 : 0] col23_wire;
    logic [13 : 0] col24_wire;
    logic [12 : 0] col25_wire;
    logic [13 : 0] col26_wire;
    logic [12 : 0] col27_wire;
    logic [11 : 0] col28_wire;
    logic [11 : 0] col29_wire;
    logic [10 : 0] col30_wire;
    logic [10 : 0] col31_wire;
    logic [9  : 0] col32_wire;
    logic [9  : 0] col33_wire;
    logic [8  : 0] col34_wire;
    logic [8  : 0] col35_wire;
    logic [7  : 0] col36_wire;
    logic [7  : 0] col37_wire;
    logic [6  : 0] col38_wire;
    logic [6  : 0] col39_wire;
    logic [5  : 0] col40_wire;
    logic [5  : 0] col41_wire;
    logic [4  : 0] col42_wire;
    logic [4  : 0] col43_wire;
    logic [3  : 0] col44_wire;
    logic [3  : 0] col45_wire;
    logic [2  : 0] col46_wire;
    logic [2  : 0] col47_wire;
    logic [1  : 0] col48_wire;
    logic [1  : 0] col49_wire;
    logic          col50_wire;
    logic          col51_wire;
    
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
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst10 (
        .O6(col11_wire[0]),
        .O5(col10_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[9]),
        .I3(OPA[10]),
        .I4(OPA[11]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst12 (
        .O6(col13_wire[0]),
        .O5(col12_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[11]),
        .I3(OPA[12]),
        .I4(OPA[13]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst14 (
        .O6(col15_wire[0]),
        .O5(col14_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[13]),
        .I3(OPA[14]),
        .I4(OPA[15]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst16 (
        .O6(col17_wire[0]),
        .O5(col16_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[15]),
        .I3(OPA[16]),
        .I4(OPA[17]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst18 (
        .O6(col19_wire[0]),
        .O5(col18_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[17]),
        .I3(OPA[18]),
        .I4(OPA[19]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst20 (
        .O6(col21_wire[0]),
        .O5(col20_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[19]),
        .I3(OPA[20]),
        .I4(OPA[21]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst22 (
        .O6(col23_wire[0]),
        .O5(col22_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[21]),
        .I3(OPA[22]),
        .I4(OPA[23]),
        .I5(1'b1));
    
    LUT6_2 #(.INIT(64'h226688CC268C268C))
    LUT6_2_row0_inst24 (
        .O6(col25_wire[0]),
        .O5(col24_wire[0]),
        .I0(OPB[0]),
        .I1(OPB[1]),
        .I2(OPA[23]),
        .I3(OPA[24]),
        .I4(OPA[25]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row0_inst26 (
        .O (col26_wire[0]),
        .I0(1'b0),
        .I1(OPB[0]),
        .I2(OPB[1]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col27_wire[0] = 1'b1;
    
    
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
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst10 (
        .O (col12_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst11 (
        .O (col13_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst12 (
        .O (col14_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst13 (
        .O (col15_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst14 (
        .O (col16_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst15 (
        .O (col17_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst16 (
        .O (col18_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst17 (
        .O (col19_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst18 (
        .O (col20_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst19 (
        .O (col21_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst20 (
        .O (col22_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst21 (
        .O (col23_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst22 (
        .O (col24_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst23 (
        .O (col25_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row1_inst24 (
        .O (col26_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row1_inst25 (
        .O (col27_wire[1]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row1_inst26 (
        .O (col28_wire[0]),
        .I0(OPB[1]),
        .I1(OPB[2]),
        .I2(OPB[3]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col29_wire[0] = 1'b1;
    
    
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
        .O (col12_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst9 (
        .O (col13_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst10 (
        .O (col14_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst11 (
        .O (col15_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst12 (
        .O (col16_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst13 (
        .O (col17_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst14 (
        .O (col18_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst15 (
        .O (col19_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst16 (
        .O (col20_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst17 (
        .O (col21_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst18 (
        .O (col22_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst19 (
        .O (col23_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst20 (
        .O (col24_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst21 (
        .O (col25_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst22 (
        .O (col26_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst23 (
        .O (col27_wire[2]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row2_inst24 (
        .O (col28_wire[1]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row2_inst25 (
        .O (col29_wire[1]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row2_inst26 (
        .O (col30_wire[0]),
        .I0(OPB[3]),
        .I1(OPB[4]),
        .I2(OPB[5]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col31_wire[0] = 1'b1;
    
    
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
        .O (col12_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst7 (
        .O (col13_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst8 (
        .O (col14_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst9 (
        .O (col15_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst10 (
        .O (col16_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst11 (
        .O (col17_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst12 (
        .O (col18_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst13 (
        .O (col19_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst14 (
        .O (col20_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst15 (
        .O (col21_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst16 (
        .O (col22_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst17 (
        .O (col23_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst18 (
        .O (col24_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst19 (
        .O (col25_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst20 (
        .O (col26_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst21 (
        .O (col27_wire[3]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst22 (
        .O (col28_wire[2]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst23 (
        .O (col29_wire[2]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row3_inst24 (
        .O (col30_wire[1]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row3_inst25 (
        .O (col31_wire[1]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row3_inst26 (
        .O (col32_wire[0]),
        .I0(OPB[5]),
        .I1(OPB[6]),
        .I2(OPB[7]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col33_wire[0] = 1'b1;
    
    
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
        .O (col12_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst5 (
        .O (col13_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst6 (
        .O (col14_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst7 (
        .O (col15_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst8 (
        .O (col16_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst9 (
        .O (col17_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst10 (
        .O (col18_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst11 (
        .O (col19_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst12 (
        .O (col20_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst13 (
        .O (col21_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst14 (
        .O (col22_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst15 (
        .O (col23_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst16 (
        .O (col24_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst17 (
        .O (col25_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst18 (
        .O (col26_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst19 (
        .O (col27_wire[4]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst20 (
        .O (col28_wire[3]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst21 (
        .O (col29_wire[3]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst22 (
        .O (col30_wire[2]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst23 (
        .O (col31_wire[2]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row4_inst24 (
        .O (col32_wire[1]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row4_inst25 (
        .O (col33_wire[1]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row4_inst26 (
        .O (col34_wire[0]),
        .I0(OPB[7]),
        .I1(OPB[8]),
        .I2(OPB[9]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col35_wire[0] = 1'b1;
    
    
    // the main part of row 5
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row5_inst0 (
        .O6(col11_wire[5]),
        .O5(col10_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst2 (
        .O (col12_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst3 (
        .O (col13_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst4 (
        .O (col14_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst5 (
        .O (col15_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst6 (
        .O (col16_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst7 (
        .O (col17_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst8 (
        .O (col18_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst9 (
        .O (col19_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst10 (
        .O (col20_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst11 (
        .O (col21_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst12 (
        .O (col22_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst13 (
        .O (col23_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst14 (
        .O (col24_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst15 (
        .O (col25_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst16 (
        .O (col26_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst17 (
        .O (col27_wire[5]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst18 (
        .O (col28_wire[4]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst19 (
        .O (col29_wire[4]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst20 (
        .O (col30_wire[3]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst21 (
        .O (col31_wire[3]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst22 (
        .O (col32_wire[2]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst23 (
        .O (col33_wire[2]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row5_inst24 (
        .O (col34_wire[1]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row5_inst25 (
        .O (col35_wire[1]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row5_inst26 (
        .O (col36_wire[0]),
        .I0(OPB[9]),
        .I1(OPB[10]),
        .I2(OPB[11]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col37_wire[0] = 1'b1;
    
    
    // the main part of row 6
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row6_inst0 (
        .O6(col13_wire[6]),
        .O5(col12_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst2 (
        .O (col14_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst3 (
        .O (col15_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst4 (
        .O (col16_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst5 (
        .O (col17_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst6 (
        .O (col18_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst7 (
        .O (col19_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst8 (
        .O (col20_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst9 (
        .O (col21_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst10 (
        .O (col22_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst11 (
        .O (col23_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst12 (
        .O (col24_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst13 (
        .O (col25_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst14 (
        .O (col26_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst15 (
        .O (col27_wire[6]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst16 (
        .O (col28_wire[5]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst17 (
        .O (col29_wire[5]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst18 (
        .O (col30_wire[4]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst19 (
        .O (col31_wire[4]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst20 (
        .O (col32_wire[3]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst21 (
        .O (col33_wire[3]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst22 (
        .O (col34_wire[2]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst23 (
        .O (col35_wire[2]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row6_inst24 (
        .O (col36_wire[1]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row6_inst25 (
        .O (col37_wire[1]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row6_inst26 (
        .O (col38_wire[0]),
        .I0(OPB[11]),
        .I1(OPB[12]),
        .I2(OPB[13]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col39_wire[0] = 1'b1;
    
    
    // the main part of row 7
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row7_inst0 (
        .O6(col15_wire[7]),
        .O5(col14_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst2 (
        .O (col16_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst3 (
        .O (col17_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst4 (
        .O (col18_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst5 (
        .O (col19_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst6 (
        .O (col20_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst7 (
        .O (col21_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst8 (
        .O (col22_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst9 (
        .O (col23_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst10 (
        .O (col24_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst11 (
        .O (col25_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst12 (
        .O (col26_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst13 (
        .O (col27_wire[7]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst14 (
        .O (col28_wire[6]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst15 (
        .O (col29_wire[6]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst16 (
        .O (col30_wire[5]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst17 (
        .O (col31_wire[5]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst18 (
        .O (col32_wire[4]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst19 (
        .O (col33_wire[4]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst20 (
        .O (col34_wire[3]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst21 (
        .O (col35_wire[3]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst22 (
        .O (col36_wire[2]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst23 (
        .O (col37_wire[2]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row7_inst24 (
        .O (col38_wire[1]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row7_inst25 (
        .O (col39_wire[1]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row7_inst26 (
        .O (col40_wire[0]),
        .I0(OPB[13]),
        .I1(OPB[14]),
        .I2(OPB[15]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col41_wire[0] = 1'b1;
    
    
    // the main part of row 8
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row8_inst0 (
        .O6(col17_wire[8]),
        .O5(col16_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst2 (
        .O (col18_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst3 (
        .O (col19_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst4 (
        .O (col20_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst5 (
        .O (col21_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst6 (
        .O (col22_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst7 (
        .O (col23_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst8 (
        .O (col24_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst9 (
        .O (col25_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst10 (
        .O (col26_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst11 (
        .O (col27_wire[8]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst12 (
        .O (col28_wire[7]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst13 (
        .O (col29_wire[7]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst14 (
        .O (col30_wire[6]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst15 (
        .O (col31_wire[6]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst16 (
        .O (col32_wire[5]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst17 (
        .O (col33_wire[5]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst18 (
        .O (col34_wire[4]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst19 (
        .O (col35_wire[4]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst20 (
        .O (col36_wire[3]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst21 (
        .O (col37_wire[3]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst22 (
        .O (col38_wire[2]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst23 (
        .O (col39_wire[2]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row8_inst24 (
        .O (col40_wire[1]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row8_inst25 (
        .O (col41_wire[1]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row8_inst26 (
        .O (col42_wire[0]),
        .I0(OPB[15]),
        .I1(OPB[16]),
        .I2(OPB[17]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col43_wire[0] = 1'b1;
    
    
    // the main part of row 9
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row9_inst0 (
        .O6(col19_wire[9]),
        .O5(col18_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst2 (
        .O (col20_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst3 (
        .O (col21_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst4 (
        .O (col22_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst5 (
        .O (col23_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst6 (
        .O (col24_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst7 (
        .O (col25_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst8 (
        .O (col26_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst9 (
        .O (col27_wire[9]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst10 (
        .O (col28_wire[8]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst11 (
        .O (col29_wire[8]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst12 (
        .O (col30_wire[7]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst13 (
        .O (col31_wire[7]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst14 (
        .O (col32_wire[6]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst15 (
        .O (col33_wire[6]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst16 (
        .O (col34_wire[5]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst17 (
        .O (col35_wire[5]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst18 (
        .O (col36_wire[4]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst19 (
        .O (col37_wire[4]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst20 (
        .O (col38_wire[3]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst21 (
        .O (col39_wire[3]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst22 (
        .O (col40_wire[2]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst23 (
        .O (col41_wire[2]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row9_inst24 (
        .O (col42_wire[1]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row9_inst25 (
        .O (col43_wire[1]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row9_inst26 (
        .O (col44_wire[0]),
        .I0(OPB[17]),
        .I1(OPB[18]),
        .I2(OPB[19]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col45_wire[0] = 1'b1;
    
    
    // the main part of row 10
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row10_inst0 (
        .O6(col21_wire[10]),
        .O5(col20_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst2 (
        .O (col22_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst3 (
        .O (col23_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst4 (
        .O (col24_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst5 (
        .O (col25_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst6 (
        .O (col26_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst7 (
        .O (col27_wire[10]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst8 (
        .O (col28_wire[9]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst9 (
        .O (col29_wire[9]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst10 (
        .O (col30_wire[8]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst11 (
        .O (col31_wire[8]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst12 (
        .O (col32_wire[7]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst13 (
        .O (col33_wire[7]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst14 (
        .O (col34_wire[6]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst15 (
        .O (col35_wire[6]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst16 (
        .O (col36_wire[5]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst17 (
        .O (col37_wire[5]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst18 (
        .O (col38_wire[4]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst19 (
        .O (col39_wire[4]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst20 (
        .O (col40_wire[3]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst21 (
        .O (col41_wire[3]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst22 (
        .O (col42_wire[2]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst23 (
        .O (col43_wire[2]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row10_inst24 (
        .O (col44_wire[1]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row10_inst25 (
        .O (col45_wire[1]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row10_inst26 (
        .O (col46_wire[0]),
        .I0(OPB[19]),
        .I1(OPB[20]),
        .I2(OPB[21]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col47_wire[0] = 1'b1;
    
    
    // the main part of row 11
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row11_inst0 (
        .O6(col23_wire[11]),
        .O5(col22_wire[11]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst2 (
        .O (col24_wire[11]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst3 (
        .O (col25_wire[11]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst4 (
        .O (col26_wire[11]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst5 (
        .O (col27_wire[11]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst6 (
        .O (col28_wire[10]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst7 (
        .O (col29_wire[10]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst8 (
        .O (col30_wire[9]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst9 (
        .O (col31_wire[9]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst10 (
        .O (col32_wire[8]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst11 (
        .O (col33_wire[8]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst12 (
        .O (col34_wire[7]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst13 (
        .O (col35_wire[7]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst14 (
        .O (col36_wire[6]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst15 (
        .O (col37_wire[6]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst16 (
        .O (col38_wire[5]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst17 (
        .O (col39_wire[5]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst18 (
        .O (col40_wire[4]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst19 (
        .O (col41_wire[4]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst20 (
        .O (col42_wire[3]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst21 (
        .O (col43_wire[3]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst22 (
        .O (col44_wire[2]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst23 (
        .O (col45_wire[2]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row11_inst24 (
        .O (col46_wire[1]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row11_inst25 (
        .O (col47_wire[1]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row11_inst26 (
        .O (col48_wire[0]),
        .I0(OPB[21]),
        .I1(OPB[22]),
        .I2(OPB[23]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col49_wire[0] = 1'b1;
    
    
    // the main part of row 12
    LUT6_2 #(.INIT(64'h8E96E8F096F096F0))
    LUT6_2_row12_inst0 (
        .O6(col25_wire[12]),
        .O5(col24_wire[12]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[0]),
        .I4(OPA[1]),
        .I5(1'b1));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst2 (
        .O (col26_wire[12]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[2]),
        .I4(OPA[1]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst3 (
        .O (col27_wire[12]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[2]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst4 (
        .O (col28_wire[11]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[4]),
        .I4(OPA[3]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst5 (
        .O (col29_wire[11]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[4]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst6 (
        .O (col30_wire[10]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[6]),
        .I4(OPA[5]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst7 (
        .O (col31_wire[10]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[6]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst8 (
        .O (col32_wire[9]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[8]),
        .I4(OPA[7]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst9 (
        .O (col33_wire[9]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[8]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst10 (
        .O (col34_wire[8]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[10]),
        .I4(OPA[9]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst11 (
        .O (col35_wire[8]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[10]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst12 (
        .O (col36_wire[7]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[12]),
        .I4(OPA[11]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst13 (
        .O (col37_wire[7]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[12]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst14 (
        .O (col38_wire[6]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[14]),
        .I4(OPA[13]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst15 (
        .O (col39_wire[6]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[14]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst16 (
        .O (col40_wire[5]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[16]),
        .I4(OPA[15]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst17 (
        .O (col41_wire[5]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[16]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst18 (
        .O (col42_wire[4]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[18]),
        .I4(OPA[17]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst19 (
        .O (col43_wire[4]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[18]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst20 (
        .O (col44_wire[3]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[20]),
        .I4(OPA[19]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst21 (
        .O (col45_wire[3]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[20]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst22 (
        .O (col46_wire[2]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[22]),
        .I4(OPA[21]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst23 (
        .O (col47_wire[2]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[22]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8EE896F0))
    LUT5_row12_inst24 (
        .O (col48_wire[1]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[24]),
        .I4(OPA[23]));
    
    LUT5 #(.INIT(32'h8E96E8F0))
    LUT5_row12_inst25 (
        .O (col49_wire[1]),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[24]),
        .I4(OPA[25]));
    
    LUT5 #(.INIT(32'h7169170F))
    LUT5_row12_inst26 (
        .O (col50_wire),
        .I0(OPB[23]),
        .I1(OPB[24]),
        .I2(OPB[25]),
        .I3(OPA[25]),
        .I4(OPA[25]));
    
    assign col51_wire = 1'b1;
    
    assign col0_wire[1] = OPB[1];
    assign col2_wire[2] = OPB[3];
    assign col4_wire[3] = OPB[5];
    assign col6_wire[4] = OPB[7];
    assign col8_wire[5] = OPB[9];
    assign col10_wire[6] = OPB[11];
    assign col12_wire[7] = OPB[13];
    assign col14_wire[8] = OPB[15];
    assign col16_wire[9] = OPB[17];
    assign col18_wire[10] = OPB[19];
    assign col20_wire[11] = OPB[21];
    assign col22_wire[12] = OPB[23];
    assign col24_wire[13] = OPB[25];
    assign col26_wire[13] = 1'b1;
    
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
    assign col20 = col20_wire;
    assign col21 = col21_wire;
    assign col22 = col22_wire;
    assign col23 = col23_wire;
    assign col24 = col24_wire;
    assign col25 = col25_wire;
    assign col26 = col26_wire;
    assign col27 = col27_wire;
    assign col28 = col28_wire;
    assign col29 = col29_wire;
    assign col30 = col30_wire;
    assign col31 = col31_wire;
    assign col32 = col32_wire;
    assign col33 = col33_wire;
    assign col34 = col34_wire;
    assign col35 = col35_wire;
    assign col36 = col36_wire;
    assign col37 = col37_wire;
    assign col38 = col38_wire;
    assign col39 = col39_wire;
    assign col40 = col40_wire;
    assign col41 = col41_wire;
    assign col42 = col42_wire;
    assign col43 = col43_wire;
    assign col44 = col44_wire;
    assign col45 = col45_wire;
    assign col46 = col46_wire;
    assign col47 = col47_wire;
    assign col48 = col48_wire;
    assign col49 = col49_wire;
    assign col50 = col50_wire;
    assign col51 = col51_wire;
endmodule