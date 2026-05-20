`timescale 1ns / 1ps


module LFSR #(
    parameter OUT_WIDTH = 128
)(
    input                    clk,
    input                    resetn,
    input  [15          : 0] in_init,
    output [OUT_WIDTH-1 : 0] out
    );

    logic [OUT_WIDTH-1 : 0] LFSR_reg;

    always @(posedge clk) begin
        if (~resetn) begin
            LFSR_reg[15 : 0]           <= in_init;
            LFSR_reg[OUT_WIDTH-1 : 16] <= 'b0;
        end else begin
            LFSR_reg[OUT_WIDTH-1 : 1]  <= LFSR_reg[OUT_WIDTH-2 : 0];
            LFSR_reg[0]                <= LFSR_reg[10] ^ LFSR_reg[12] ^ LFSR_reg[13] ^ LFSR_reg[15] ^ LFSR_reg[OUT_WIDTH-1];
        end
    end

    assign out = LFSR_reg;

endmodule
