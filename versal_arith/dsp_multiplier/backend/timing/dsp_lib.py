"""
dsp_lib.py -- all delay numbers, in nanoseconds.

Source tag in the comment:
  M = measured directly from post-implementation Vivado timing reports
  E = estimated (Vivado never printed it, because that arc was bypassed)
  X = derived from two measured numbers

Change a number here and every result in dsp_model.py follows.
"""

D = {
    # ------------------------------------------------ fabric side
    "FF_CLK_Q":        0.091,  # M  LFSR FF clk -> Q
    "ROUTE_FF_TO_A":   0.596,  # M  fabric FF -> DSP A pin
    "ROUTE_P_TO_FF":   0.439,  # M  DSP P -> fabric LUT/FF
    "T_SU_FF":         0.030,  # E  fabric FF setup

    # ------------------------------------------------ DSP58 combinational arcs
    "A_TO_A2DATA":     0.275,  # M  DSP_A_B_DATA58, AREG=0 bypass mux
    "A2DATA_TO_A2A1":  0.123,  # M  DSP_PREADD_DATA58, preadder bypassed
    "PREADD_ACTIVE":   0.350,  # E  same arc with the preadder actually adding
    "A2A1_TO_V":       0.448,  # M  DSP_MULTIPLIER58, the 27x24 array
    "V_TO_VDATA":      0.090,  # M  DSP_M_DATA58, MREG=0 bypass mux
    "ALUMUX_Y":        0.072,  # M  ALUMUX, multiplier operand -> Y
    "ALUADD_Y":        0.343,  # M  ALUADD, Y -> ALU_OUT
    "ALUMUX_Z":        0.105,  # M  ALUMUX, PCIN -> Z
    "ALUADD_Z":        0.310,  # M  ALUADD, Z -> ALU_OUT
    "ALUOUT_TO_PCOUT": 0.144,  # M  DSP_OUTPUT58 -> PCOUT
    "ALUOUT_TO_P":     0.195,  # M  DSP_OUTPUT58 -> P
    "ROUTE_CASCADE":   0.041,  # M  PCOUT -> PCIN, dedicated cascade

    # ------------------------------------------------ DSP58 registers
    "TCO_AREG":        0.280,  # E  AREG  clk -> A2_DATA
    "TCO_ADREG":       0.200,  # E  ADREG clk -> A2A1
    "TCO_MREG":        0.150,  # E  MREG  clk -> V_DATA
    "TCO_PREG_P":      0.278,  # M  PREG  clk -> P
    "TCO_PREG_PCOUT":  0.227,  # X  0.278 - (0.195 - 0.144)
    "T_SU_DSP":        0.080,  # E  any DSP internal register setup

    # ------------------------------------------------ margin
    "CLK_UNCERTAINTY": 0.150,  # clock uncertainty + realistic skew

    # ------------------------------------------------ Karatsuba extras (k2 report)
    "ROUTE_P_TO_C":    0.555,  # M  DSP P -> adjacent DSP C pin
    "C_TO_CDATA":      0.363,  # M  DSP_C_DATA58, CREG=0 bypass
    "ALUMUX_W":        0.132,  # M  C_DATA -> W
    "ALUADD_W":        0.282,  # M  W -> ALU_OUT
    "TCO_CREG":        0.200,  # E  CREG clk -> C_DATA
    "TCO_BREG":        0.280,  # E  assume same as AREG
    "B_TO_V":          0.448,  # E  assume same as A2A1_TO_V
    "ROUTE_FF_TO_LUT": 0.250,  # E  fabric FF -> LUT input

    # ------------------------------------------------ Versal fabric carry chain
    "CARRY_ENTRY":     0.110,  # M  LUTCY2 I->GE 0.074 + net 0.036
    "CARRY_FIRST":     0.148,  # M  LOOKAHEAD8 GEA->COUTH
    "CARRY_STEP":      0.042,  # M  LOOKAHEAD8 CIN->COUTH 0.040 + net 0.002
    "CARRY_LAST_NET":  0.014,  # M
    "CARRY_EXIT":      0.199,  # M  LUTCY2 0.058+0.027 + LUTCY1 0.068+0.046
    "CARRY_BITS":      8,      #    bits per LOOKAHEAD8 in one Versal SLICE

    # ------------------------------------------------ Karatsuba 3x3 extras (k3 report)
    "ROUTE_P_TO_C_K3":    0.576,  # M  11.P -> 02.C, fo=2, X20->X21 column crossing
    "ROUTE_DSP_TO_ADDER": 0.583,  # M  02.P[17] -> P_reg[61]_i_2
    "ROUTE_ADDER_TO_LUT3":0.611,  # M  CPA50 exit -> LUT3, a long hop
    "LUT3_COMPRESS":      0.049,  # M  3:2 compression layer, independent of width
    "ROUTE_LUT3_TO_ADDER":0.285,  # M  LUT3 -> CPA115
    "CARRY_ENTRY_K3":     0.075,  # M  LUTCY1 I->PROP 0.073 + net 0.002
    "CARRY_FIRST_PROP":   0.155,  # M  midpoint of 0.177 (PROPB) and 0.130 (PROPE)
    "CARRY_EXIT_K3":      0.153,  # M  LUTCY2 0.053+0.020 + LUTCY1 0.065
    "END_NET":            0.045,  # M  the last net segment into the FF

    # ------------------------------------------------ Toom-Cook 2.5 extras (T25 report)
    "ROUTE_P_TO_C_T25":      0.773,  # M  p0.P -> s.C, fo=2, X22Y0 -> X23Y2
    "ROUTE_FF_TO_A_T25":     1.076,  # M  X_reg -> DSP A, fo=7 (harness fanout)
    "ROUTE_DSP_TO_ADDER_T25":0.758,  # M  s.P[37] -> interpolation adder, fo=6
    "ROUTE_ADDER_TO_LUT_T25":0.648,  # M  interpolation CPA -> LUT4, fo=5
    "LUT4_COMPRESS":         0.134,  # M  4-operand compression layer, A6LUT I2->O
    "ROUTE_LUT_TO_ADDER_T25":0.476,  # M  LUT4 -> reconstruction adder
    "END_NET_T25":           0.046,  # M
}

# bit widths of the Karatsuba2x2 datapath
K2W = {
    "ADD_WIDTH": 71,   # P_92_22 = op1 + op2
    "P_HI_BITS": 49,   # P_hi_delay
    "P_LO_BITS": 44,   # P_lo_delay 44 + P_21_0 22
    "Y0Y1_BITS": 24,   # Y_lo - Y_hi
}


K3W = {
    "ADD_WIDTH":   115,   # P_136_22
    "CPA50_WIDTH":  50,   # P02_add_P00
    # each of the four operands' least-significant bit within P_136_22, which decides how long its own carry chain still has to run
    "OP_P01_LSB":    0,   # P01_d1[44:0]      -> P[66:22]
    "OP_P02_LSB":   22,   # P02_add_P00[49:0] -> P[93:44]
    "OP_P12_LSB":   44,   # P12_d1[48:0]      -> P[114:66]
    "OP_P22_LSB":   66,   # P22_d2[48:0]      -> P[136:88]
    # alignment FF widths
    "P00_BITS":     44, "P22_BITS":    49,
    "P01_BITS":     45, "P12_BITS":    49,
    "P02ADD_BITS":  50,
    "YSUB_BITS":    24, "YSUB_TOTAL":  71,   # Y0Y1 23 + Y0Y2 24 + Y1Y2 24
}

T25W = {
    "CPA_INTERP":  59,   # twice_P1 / twice_P2
    "CPA_RECOMP":  91,   # Q_comb
    # each of the four operands' least-significant bit within Q
    "OP_Q0_LSB":    0,   # P0[41:21]
    "OP_Q1_LSB":    0,   # P1
    "OP_Q2_LSB":   21,   # P2 << 21
    "OP_Q3_LSB":   42,   # P3 << 42
    # twice_Px[k] -> Px[k-1] -> Q[k-1+offset]
    "P1_INTO_Q":    0,
    "P2_INTO_Q":   20,
    "XEVAL_BITS":  24, "XEVAL_TOTAL": 48,   # X_at_p1 + X_at_m1
    "P0_BITS":     58, "P3_BITS":     58,
    "P12_BITS":   116,                       # P1_reg + P2_reg
}
