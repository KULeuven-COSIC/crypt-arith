`timescale 1ns / 1ps


module c3_2 #(
    parameter OUTREG = "FALSE",
    parameter LEAVEC = "FALSE",
    parameter POSODD = "FALSE",
    parameter FIRSTS = "FALSE",
    parameter LASTS  = "FALSE"
)(
    input  logic         clk,
    input  logic [2 : 0] C0,
    output logic [1 : 0] O,
    output logic         CY,
    output logic         PROP
    );


    parameter INIT = POSODD == "TRUE" ? (FIRSTS == "TRUE" ? 64'hFFF0F000F00F0FF0 : (LASTS == "TRUE" ? 64'hFFF0F000F00F0FF0 : 64'hF000F000F00F0FF0)) : 64'hFFF0F000F00F0FF0;

    logic [1 : 0] O_wire;
    logic [1 : 0] O_reg;


    generate
        if (POSODD == "FALSE") begin
            LUT6CY #(.INIT(INIT)) 
            LUT6CY_inst0 (
                .O51 (O_wire[0]),
                .O52 (O_wire[1]),
                .PROP(PROP     ),
                .I0  (1'b0     ),
                .I1  (1'b0     ),
                .I2  (C0[0]    ),
                .I3  (C0[1]    ),
                .I4  (C0[2]    ));
        end else begin
            LUT6CY #(.INIT(INIT)) 
            LUT6CY_inst0 (
                .O51 (O_wire[0]),
                .O52 (O_wire[1]),
                .PROP(PROP     ),
                .I0  (1'b0     ),
                .I1  (1'b0     ),
                .I2  (C0[0]    ),
                .I3  (C0[1]    ),
                .I4  (C0[2]    ));
        end
    endgenerate

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
                    O_reg[0] <= O_wire[0];
                assign O[0] = O_reg[0];
                assign O[1] = O_wire[1];
            end
        end
    endgenerate

    assign CY = O_wire[1];
endmodule

