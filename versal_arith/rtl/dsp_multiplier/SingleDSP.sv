`timescale 1ns / 1ps

// ---------------------------------------------------------------------------
// SingleDSP -- one DSP58 computing P = X * Y, selectable pipeline depth.
//
//  LATENCY  OUT_REG  critical stage                     predicted ns / MHz
//  -------  -------  --------------------------------   ------------------
//     1        0     fabric -> MREG                      1.613 /  567
//     1        1     fabric -> PREG                      2.118 /  441
//     2        0     MREG -> fabric                      1.229 /  725
//     2        1     AREG -> PREG                        1.436 /  630
//     3        -     AREG -> MREG   (DSP58 hard floor)   0.931 /  925
//     4        -     fabric -> AREG (boundary route)     0.767 / 1090
//
//  OUT_REG only applies to LATENCY 1 and 2.  It trades a faster internal
//  stage (OUT_REG=0: MREG cuts the cone near its midpoint) against a
//  registered P output (OUT_REG=1: keeps downstream fabric logic off the
//  DSP's own path).  LATENCY 3 and 4 always register P.
//
//  LATENCY 4 runs the pre-adder as a pass-through (AD = D + A, D tied to 0)
//  purely to get ADREG into the path.  Only worth it if the DSP58 F_MAX for
//  your speed grade is above ~925 MHz -- otherwise stop at 3.

//  budget = 0
//    latency  0  2.702 ns   350.6 MHz   A=0 AD=0 M=0 P=0
//        critical stage: -> fabric FF (P combinational)

//  budget = 1
//    latency  1  1.613 ns   567.2 MHz   A=0 AD=0 M=1 P=0
//        critical stage: -> MREG (array)

//  budget = 2
//    latency  2  1.229 ns   725.2 MHz   A=1 AD=0 M=1 P=0
//        critical stage: -> fabric FF (P combinational)

//  budget = 3
//    latency  3  0.931 ns   925.1 MHz   A=1 AD=0 M=1 P=1
//        critical stage: -> MREG (array)

//  budget = 4
//    latency  4  0.767 ns  1090.5 MHz   A=1 AD=1 M=1 P=1
//        critical stage: fabric FF -> AREG
// ---------------------------------------------------------------------------
module SingleDSP #(
    parameter int LATENCY = 3,      // 1 .. 4
    parameter bit OUT_REG = 1'b1    // ignored when LATENCY >= 3
)(
    input  logic               clk,
    input  logic               reset,

    input  logic               in_valid,
    input  logic signed [26:0] X,
    input  logic signed [23:0] Y,

    output logic               out_valid,
    output logic signed [50:0] P
);

    // -----------------------------------------------------------------------
    // LATENCY -> DSP58 register settings.  This table is the only place the
    // mapping lives; everything below is mechanical.
    // -----------------------------------------------------------------------
    localparam bit USE_PREADD = (LATENCY == 4);

    localparam int A_P  = (LATENCY >= 2) ? 1 : 0;                  // AREG
    localparam int AD_P = (LATENCY == 4) ? 1 : 0;                  // ADREG
    localparam int M_P  = (LATENCY >= 3) ? 1 : (OUT_REG ? 0 : 1);  // MREG
    localparam int P_P  = (LATENCY >= 3) ? 1 : (OUT_REG ? 1 : 0);  // PREG

    // B must carry exactly as many stages as A does before the multiplier.
    // If it does not, the two operands meet one cycle apart and the product
    // is silently wrong -- no tool will warn you.
    localparam int B_P  = A_P + AD_P;                              // BREG, 0..2
    localparam int D_P  = USE_PREADD ? A_P : 0;                    // DREG tracks A

    localparam string PREADD_STR = USE_PREADD ? "TRUE" : "FALSE";

    initial begin
        if (LATENCY < 1 || LATENCY > 4)
            $fatal(1, "SingleDSP: LATENCY must be 1..4, got %0d", LATENCY);
        if (A_P + AD_P + M_P + P_P != LATENCY)
            $fatal(1, "SingleDSP: pipe mapping broken for LATENCY=%0d", LATENCY);
        if (B_P > 2)
            $fatal(1, "SingleDSP: BREG cannot exceed 2, got %0d", B_P);
    end

    logic signed [57:0] dsp_p;

    DSP58Block #(
        .PREADD      (PREADD_STR),
        .ADDAD       ("TRUE"),      // PREADDINSEL = "A"
        .PREADD_SUB  ("FALSE"),     // AD = D + A ; D is 0 -> AD = A
        .USEC        ("FALSE"),
        .USEPCIN     ("ZERO"),
        .PREADD_PIPE (AD_P),
        .A_PIPE      (A_P),
        .B_PIPE      (B_P),
        .C_PIPE      (0),
        .D_PIPE      (D_P),
        .MULT_PIPE   (M_P),
        .P_PIPE      (P_P)
    ) u_dsp (
        .clk       (clk),
        .reset     (reset),
        .in_valid  (in_valid),

        .A         ({{7{X[26]}}, X}),
        .B         (Y),
        .C         (58'b0),
        .D         (27'b0),
        .PCIN      (58'b0),

        .out_valid (out_valid),
        .PCOUT     (),
        .P         (dsp_p)
    );

    assign P = dsp_p[50:0];

endmodule