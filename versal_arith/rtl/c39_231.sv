`timescale 1ns / 1ps


module c39_231 #(
    parameter OUTREG = "FALSE",
    parameter LEAVEC = "FALSE",
    parameter POSODD = "FALSE"
)(
    input  logic         clk,
    input  logic [8 : 0] C0,
    input  logic [2 : 0] C1,
    input  logic         CLA,
    output logic         O0,
    output logic [2 : 0] O1,
    output logic [1 : 0] O2,
    output logic [1 : 0] CY0,
    output logic [1 : 0] CY1,
    output logic [1 : 0] PROP0,
    output logic [1 : 0] PROP1
    );


    logic [1 : 0] cascade;
    logic         O_cascade;
    logic         O0_wire;
    logic         O0_reg;
    logic [2 : 0] O1_wire;
    logic [2 : 0] O1_reg;
    logic [1 : 0] O2_wire;
    logic [1 : 0] O2_reg;


    assign cascade[0] = POSODD == "FALSE" ? O_cascade : CLA;

    LUT6CY #(.INIT(64'h96696996FF969600))
    LUT6CY_inst0 (
        .O52 (O_cascade ),
        .O51 (O1_wire[0]),
        .PROP(PROP0[0]  ),
        .I0  (C0[0]     ),
        .I1  (C0[1]     ),
        .I2  (C0[2]     ),
        .I3  (C0[3]     ),
        .I4  (C0[8]     ));

    LUT6CY #(.INIT(64'hFF96960096696996))
    LUT6CY_inst1 (
        .O52 (O1_wire[1]),
        .O51 (O0_wire   ),
        .PROP(PROP0[1]  ),
        .I0  (C0[5]     ),
        .I1  (C0[6]     ),
        .I2  (C0[7]     ),
        .I3  (C0[4]     ),
        .I4  (cascade[0]));

    LUT6CY #(.INIT(64'hE81717E8FFE8E800))
    LUT6CY_inst2 (
        .O52 (cascade[1]),
        .O51 (O2_wire[0]),
        .PROP(PROP1[0]  ),
        .I0  (C0[0]     ),
        .I1  (C0[1]     ),
        .I2  (C0[2]     ),
        .I3  (C1[0]     ),
        .I4  (C1[1]     ));

    LUT6CY #(.INIT(64'hFFE8E800E81717E8))
    LUT6CY_inst3 (
        .O52 (O2_wire[1]),
        .O51 (O1_wire[2]),
        .PROP(PROP1[1]  ),
        .I0  (C0[5]     ),
        .I1  (C0[6]     ),
        .I2  (C0[7]     ),
        .I3  (C1[2]     ),
        .I4  (cascade[1]));

    generate
        if (OUTREG == "FALSE") begin
            assign O0 = O0_wire;
            assign O1 = O1_wire;
            assign O2 = O2_wire;
        end else begin
            if (LEAVEC == "FALSE") begin
                assign O0 = O0_reg;
                assign O1 = O1_reg;
                assign O2 = O2_reg;
                always_ff @(posedge clk)
                    O0_reg <= O0_wire;
                always_ff @(posedge clk)
                    O1_reg <= O1_wire;
                always_ff @(posedge clk)
                    O2_reg <= O2_wire;
            end else begin
                always_ff @(posedge clk)
                    O0_reg <= O0_wire;
                always_ff @(posedge clk)
                    O1_reg <= O1_wire;
                always_ff @(posedge clk)
                    O2_reg[0] <= O2_wire[0];
                assign O0    = O0_reg;
                assign O1    = O1_reg;
                assign O2[0] = O2_reg[0];
                assign O2[1] = O2_wire[1];
            end
        end
    endgenerate

    assign CY0 = {O1_wire[1], O_cascade};
    assign CY1 = {O2_wire[1], cascade[1]};
endmodule