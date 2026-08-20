`timescale 1ns / 1ps

module DSP58Block #(
    parameter PREADD      = "TRUE",
    parameter SQUARE      = "FALSE",
    parameter DOTPRO      = "FALSE",
    parameter ADDAD       = "TRUE",
    parameter PREADD_SUB  = "FALSE",
    parameter USEC        = "TRUE",
    parameter USEPCIN = "ZERO", // USEPCIN options: "ZERO", "PCIN", "PCIN_SHIFT23"
    parameter PREADD_PIPE = 1,
    parameter A_PIPE      = 0,
    parameter B_PIPE      = 1,
    parameter C_PIPE      = 0,
    parameter D_PIPE      = 0,
    parameter MULT_PIPE   = 1,
    parameter P_PIPE      = 1,
    parameter NEG_PCIN    = "FALSE",
    parameter NEG_M       = "FALSE",
    parameter NEG_C       = "FALSE"
)(
    input  logic          clk, 
    input  logic          reset,
    input  logic          in_valid,
    input  logic [33 : 0] A,
    input  logic [23 : 0] B,
    input  logic [57 : 0] C,
    input  logic [26 : 0] D,
    input  logic [57 : 0] PCIN,
    output logic          out_valid,
    output logic [57 : 0] PCOUT,
    output logic [57 : 0] P
    );

    localparam AMULTSEL    = PREADD == "TRUE" ? "AD" : "A";
    localparam BMULTSEL    = SQUARE == "TRUE" ? "AD" : "B";
    localparam DSP_MODE    = DOTPRO == "TRUE" ? "INT8" : "INT24";
    localparam PREADDINSEL = ADDAD  == "TRUE" ? "A" : "B";
    localparam ALUMODE     = NEG_C == "TRUE" ? (NEG_PCIN == "TRUE" ? 4'b0010 : 4'b0011) : (NEG_PCIN == "TRUE" ? 4'b0001 : 4'b0000);
    localparam NEGATE0     = ((NEG_M == "TRUE") & (NEG_C == "FALSE") & (NEG_PCIN == "FALSE") | 
                              (NEG_M == "FALSE") & (NEG_C == "TRUE") & (NEG_PCIN == "FALSE") |
                              (NEG_M == "TRUE") & (NEG_C == "FALSE") & (NEG_PCIN == "TRUE") |
                              (NEG_M == "FALSE") & (NEG_C == "TRUE") & (NEG_PCIN == "TRUE")) ? 1'b1 : 1'b0;
    localparam logic [4:0] INMODE = (PREADD == "TRUE")
        ? ((PREADD_SUB == "FALSE") ? 5'b00100 : 5'b01100) : 5'b00000;
    localparam CARRYIN     = ((NEG_PCIN == "TRUE") & (NEG_C == "FALSE")) ? 1'b1 : 1'b0;
    localparam PIPE_STAGE  = A_PIPE + PREADD_PIPE + MULT_PIPE + P_PIPE;
    localparam logic [1:0] W_OP =
        USEC == "TRUE" ? 2'b11 : 2'b00;
    localparam logic [2:0] Z_OP =
        USEPCIN == "PCIN_SHIFT23" ? 3'b101 :
        USEPCIN == "PCIN"         ? 3'b001 :
                                    3'b000;
    localparam logic [8:0] OPMODE = {W_OP, Z_OP, 4'b0101};

    logic [33 : 0] ACOUT;
    logic [23 : 0] BCOUT;
    logic          CARRYCASCOUT;
    logic          MULTSIGNOUT;
    logic          OVERFLOW;
    logic          PATTERNBDETECT;
    logic          PATTERNDETECT;
    logic          UNDERFLOW;

    logic [3  : 0] CARRYOUT;
    logic [7  : 0] XOROUT;

    localparam int VW = (PIPE_STAGE > 0) ? PIPE_STAGE : 1;
    logic [VW-1 : 0] valid_reg;

    integer i;
    always_ff @(posedge clk) begin
        if (reset) begin
            valid_reg <= 'b0;
        end else begin
            for (i = 0; i < PIPE_STAGE-1; i = i + 1) begin
                valid_reg[i+1] <= valid_reg[i];
            end
            valid_reg[0] <= in_valid;
        end
    end
    assign out_valid = (PIPE_STAGE > 0) ? valid_reg[VW-1] : in_valid;

   DSP58 #(
      // Feature Control Attributes: Data Path Selection
      .AMULTSEL(AMULTSEL),
      .A_INPUT("DIRECT"),
      .BMULTSEL(BMULTSEL),
      .B_INPUT("DIRECT"),
      .DSP_MODE(DSP_MODE),
      .PREADDINSEL(PREADDINSEL),
      .RND(58'h000000000000000),
      .USE_MULT("MULTIPLY"),
      .USE_SIMD("ONE58"),
      .USE_WIDEXOR("FALSE"),
      .XORSIMD("XOR24_34_58_116"),
      // Pattern Detector Attributes: Pattern Detection Configuration
      .AUTORESET_PATDET("NO_RESET"),
      .AUTORESET_PRIORITY("RESET"),
      .MASK(58'h0ffffffffffffff),
      .PATTERN(58'h000000000000000),
      .SEL_MASK("MASK"),
      .SEL_PATTERN("PATTERN"),
      .USE_PATTERN_DETECT("NO_PATDET"),
      // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
      .IS_ALUMODE_INVERTED(4'b0000),
      .IS_CARRYIN_INVERTED(1'b0),
      .IS_CLK_INVERTED(1'b0),
      .IS_INMODE_INVERTED(5'b00000),
      .IS_NEGATE_INVERTED(3'b000),
      .IS_OPMODE_INVERTED(9'b000000000),
      .IS_RSTALLCARRYIN_INVERTED(1'b0),
      .IS_RSTALUMODE_INVERTED(1'b0),
      .IS_RSTA_INVERTED(1'b0),
      .IS_RSTB_INVERTED(1'b0),
      .IS_RSTCTRL_INVERTED(1'b0),
      .IS_RSTC_INVERTED(1'b0),
      .IS_RSTD_INVERTED(1'b0),
      .IS_RSTINMODE_INVERTED(1'b0),
      .IS_RSTM_INVERTED(1'b0),
      .IS_RSTP_INVERTED(1'b0),
      // Register Control Attributes: Pipeline Register Configuration
      .ACASCREG(A_PIPE),
      .ADREG(PREADD_PIPE),
      .ALUMODEREG(0),
      .AREG(A_PIPE),
      .BCASCREG(B_PIPE),
      .BREG(B_PIPE),
      .CARRYINREG(0),
      .CARRYINSELREG(0),
      .CREG(C_PIPE),
      .DREG(D_PIPE),
      .INMODEREG(0),
      .MREG(MULT_PIPE),
      .OPMODEREG(0),
      .PREG(P_PIPE),
      .RESET_MODE("SYNC"))
   DSP58_inst (
      // Cascade outputs: Cascade Ports
      .ACOUT(ACOUT),
      .BCOUT(BCOUT),
      .CARRYCASCOUT(CARRYCASCOUT),
      .MULTSIGNOUT(MULTSIGNOUT),
      .PCOUT(PCOUT),
      // Control outputs: Control Inputs/Status Bits
      .OVERFLOW(OVERFLOW),
      .PATTERNBDETECT(PATTERNBDETECT),
      .PATTERNDETECT(PATTERNDETECT),
      .UNDERFLOW(UNDERFLOW),
      // Data outputs: Data Ports
      .CARRYOUT(CARRYOUT),
      .P(P),
      .XOROUT(XOROUT),
      // Cascade inputs: Cascade Ports
      .ACIN(34'b0),
      .BCIN(24'b0),
      .CARRYCASCIN(1'b0),
      .MULTSIGNIN(1'b0),
      .PCIN(PCIN),
      // Control inputs: Control Inputs/Status Bits
      .ALUMODE(ALUMODE),
      .CARRYINSEL(3'b000),
      .CLK(clk),
      .INMODE(INMODE),
      .NEGATE({2'b0, NEGATE0}),
      .OPMODE(OPMODE),
      // Data inputs: Data Ports
      .A(A),
      .B(B),
      .C(C),
      .CARRYIN(CARRYIN),
      .D(D),
      // Reset/Clock Enable inputs: Reset/Clock Enable Inputs
      .ASYNC_RST(1'b0),
      .CEA1(1'b1),
      .CEA2(1'b1),
      .CEAD(1'b1),
      .CEALUMODE(1'b0),
      .CEB1(1'b1),
      .CEB2(1'b1),
      .CEC(1'b1),
      .CECARRYIN(1'b0),
      .CECTRL(1'b0),
      .CED(1'b1),
      .CEINMODE(1'b0),
      .CEM(1'b1),
      .CEP(1'b1),
      .RSTA(reset),
      .RSTALLCARRYIN(reset),
      .RSTALUMODE(reset),
      .RSTB(reset),
      .RSTC(reset),
      .RSTCTRL(reset),
      .RSTD(reset),
      .RSTINMODE(reset),
      .RSTM(reset),
      .RSTP(reset));

endmodule
