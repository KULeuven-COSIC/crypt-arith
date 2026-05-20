`timescale 1ns / 1ps


module c6_3 #(
    parameter OUTREG = "FALSE",
    parameter LEAVEC = "FALSE"
)(
    input  logic         clk,
    input  logic [5 : 0] C0,
    output logic [2 : 0] O
    );


    logic [2 : 0] O_wire;
    logic [2 : 0] O_reg;


    LUT6_2 #(.INIT(64'h6996966996696996))
    LUT6_2_inst0 (
        .O6(O_wire[0]),
        .O5(         ),
        .I0(C0[0]    ),
        .I1(C0[1]    ),
        .I2(C0[2]    ),
        .I3(C0[3]    ),
        .I4(C0[4]    ),
        .I5(C0[5]    ));

    LUT6_2 #(.INIT(64'h8117177E177E7EE8))
    LUT6_2_inst1 (
        .O6(O_wire[1]),
        .O5(         ),
        .I0(C0[0]    ),
        .I1(C0[1]    ),
        .I2(C0[2]    ),
        .I3(C0[3]    ),
        .I4(C0[4]    ),
        .I5(C0[5]    ));

    LUT6_2 #(.INIT(64'hFEE8E880E8808000))
    LUT6_2_inst2 (
        .O6(O_wire[2]),
        .O5(         ),
        .I0(C0[0]    ),
        .I1(C0[1]    ),
        .I2(C0[2]    ),
        .I3(C0[3]    ),
        .I4(C0[4]    ),
        .I5(C0[5]    ));

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
                    O_reg[1:0] <= O_wire[1:0];
                assign O[1:0] = O_reg[1:0];
                assign O[2]   = O_wire[2];
            end
        end
    endgenerate
endmodule

