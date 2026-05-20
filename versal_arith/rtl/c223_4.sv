`timescale 1ns / 1ps


module c223_4 #(
    parameter OUTREG = "FALSE",
    parameter LEAVEC = "FALSE",
    parameter POSODD = "FALSE"
)(
    input  logic         clk,
    input  logic [2 : 0] C0,
    input  logic [1 : 0] C1,
    input  logic [1 : 0] C2,
    input  logic         CLA,
    output logic [3 : 0] O,
    output logic [1 : 0] CY,
    output logic [1 : 0] PROP
    );


    logic [3 : 0] O_wire;
    logic [3 : 0] O_reg;
    logic         cascade;


    assign cascade = POSODD == "FALSE" ? O_wire[1] : CLA;

    LUT6CY #(.INIT(64'h99969666F00F0FF0))
    LUT6CY_inst0 (
        .O52 (O_wire[1]),
        .O51 (O_wire[0]),
        .PROP(PROP[0]  ),
        .I0  (C1[0]    ),
        .I1  (C1[1]    ),
        .I2  (C0[0]    ),
        .I3  (C0[1]    ),
        .I4  (C0[2]    ));

    LUT6CY #(.INIT(64'hF880FEE08778E11E))
    LUT6CY_inst1 (
        .O52 (O_wire[3]),
        .O51 (O_wire[2]),
        .PROP(PROP[1]  ),
        .I0  (C1[0]    ),
        .I1  (C1[1]    ),
        .I2  (C2[0]    ),
        .I3  (C2[1]    ),
        .I4  (cascade  ));

    generate
        if (OUTREG == "FALSE") begin
            assign O = O_wire;
        end else begin
            if (LEAVEC == "FALSE") begin
                assign O = O_reg;
                always_ff @(posedge clk)
                    O_reg <= O_wire;
            end else begin
                always_ff @(posedge clk)
                    O_reg[2 : 0] <= O_wire[2 : 0];
                assign O[2 : 0] = O_reg[2 : 0];
                assign O[3]     = O_wire[3];
            end
        end
    endgenerate

    assign CY = {O_wire[3], O_wire[1]};
endmodule