`timescale 1ns / 1ps


module c15_3 #(
    parameter OUTREG = "FALSE",
    parameter LEAVEC = "FALSE",
    parameter POSODD = "FALSE",
    parameter FIRSTS = "FALSE",
    parameter LASTS  = "FALSE"
)(
    input  logic         clk,
    input  logic [4 : 0] C0,
    input  logic         C1,
    input  logic         CLA,
    output logic [2 : 0] O,
    output logic [1 : 0] CY,
    output logic [1 : 0] PROP
    );


    parameter INIT0 = POSODD == "TRUE" ? (FIRSTS == "TRUE" ? 64'hFF96960096696996 : 64'h9600960096696996) : 64'hFF96960096696996;
    parameter INIT1 = POSODD == "TRUE" ? 64'hFFE8E800E81717E8 : ((FIRSTS == "TRUE" | LASTS == "TRUE") ? 64'hFFE8E800E81717E8 : 64'hE800E800E81717E8);

    logic         O_cascade;
    logic [2 : 0] O_wire;
    logic [2 : 0] O_reg;


    generate
        if (POSODD == "FALSE") begin
            LUT6CY #(.INIT(INIT0)) 
            LUT6CY_inst0 (
                .O51 (O_wire[0]),
                .O52 (O_cascade),
                .PROP(PROP[0]  ),
                .I0  (C0[0]    ),
                .I1  (C0[1]    ),
                .I2  (C0[2]    ),
                .I3  (C0[3]    ),
                .I4  (C0[4]    ));

            LUT6CY #(.INIT(INIT1)) 
            LUT6CY_inst1 (
                .O51 (O_wire[1]),
                .O52 (O_wire[2]),
                .PROP(PROP[1]  ),
                .I0  (C0[0]    ),
                .I1  (C0[1]    ),
                .I2  (C0[2]    ),
                .I3  (C1       ),
                .I4  (O_cascade));
        end else begin
            LUT6CY #(.INIT(INIT0)) 
            LUT6CY_inst0 (
                .O51 (O_wire[0]),
                .O52 (O_cascade),
                .PROP(PROP[0]  ),
                .I0  (C0[0]    ),
                .I1  (C0[1]    ),
                .I2  (C0[2]    ),
                .I3  (C0[3]    ),
                .I4  (C0[4]    ));

            LUT6CY #(.INIT(INIT1)) 
            LUT6CY_inst1 (
                .O51 (O_wire[1]),
                .O52 (O_wire[2]),
                .PROP(PROP[1]  ),
                .I0  (C0[0]    ),
                .I1  (C0[1]    ),
                .I2  (C0[2]    ),
                .I3  (C1       ),
                .I4  (CLA      ));
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
                    O_reg[1 : 0] <= O_wire[1 : 0];
                assign O[1 : 0] = O_reg[1 : 0];
                assign O[2]     = O_wire[2];
            end
        end
    endgenerate

    assign CY = {O_wire[2], O_cascade};
endmodule








