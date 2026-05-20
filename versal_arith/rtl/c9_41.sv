`timescale 1ns / 1ps


module c9_41 #(
    parameter OUTREG = "FALSE",
    parameter LEAVEC = "FALSE",
    parameter POSODD = "FALSE"
)(
    input  logic         clk,
    input  logic [8 : 0] C0,
    input  logic         CLA,
    output logic         O0,
    output logic [3 : 0] O1,
    output logic [1 : 0] CY,
    output logic [1 : 0] PROP
    );


    logic         cascade;
    logic         O_cascade;
    logic         O0_wire;
    logic         O0_reg;
    logic [3 : 0] O1_wire;
    logic [3 : 0] O1_reg;


    assign cascade = POSODD == "FALSE" ? O_cascade : CLA;

    LUT6CY #(.INIT(64'h96696996FF969600))
    LUT6CY_inst0 (
        .O52 (O_cascade ),
        .O51 (O1_wire[2]),
        .PROP(PROP[0]   ),
        .I0  (C0[0]     ),
        .I1  (C0[1]     ),
        .I2  (C0[2]     ),
        .I3  (C0[3]     ),
        .I4  (C0[8]     ));

    LUT6CY #(.INIT(64'hFF96960096696996))
    LUT6CY_inst1 (
        .O52 (O1_wire[3]),
        .O51 (O0_wire   ),
        .PROP(PROP[1]   ),
        .I0  (C0[5]     ),
        .I1  (C0[6]     ),
        .I2  (C0[7]     ),
        .I3  (C0[4]     ),
        .I4  (cascade   ));

    LUT3 #(.INIT(8'hE8))
    LUT3_inst0 (
        .O (O1_wire[0]),
        .I0(C0[0]     ),
        .I1(C0[1]     ),
        .I2(C0[2]     ));

    LUT3 #(.INIT(8'hE8))
    LUT3_inst1 (
        .O (O1_wire[1]),
        .I0(C0[5]     ),
        .I1(C0[6]     ),
        .I2(C0[7]     ));

    generate
        if (OUTREG == "FALSE") begin
            assign O0 = O0_wire;
            assign O1 = O1_wire;
        end else begin
            if (LEAVEC == "FALSE") begin
                assign O0 = O0_reg;
                assign O1 = O1_reg;
                always_ff @(posedge clk)
                    O0_reg <= O0_wire;
                always_ff @(posedge clk)
                    O1_reg <= O1_wire;
            end else begin
                always_ff @(posedge clk)
                    O0_reg <= O0_wire;
                always_ff @(posedge clk)
                    O1_reg[2:0] <= O1_wire[2:0];
                assign O0      = O0_reg;
                assign O1[2:0] = O1_reg[2:0];
                assign O1[3]   = O1_wire[3];
            end
        end
    endgenerate

    assign CY = {O1_wire[3], cascade};
endmodule