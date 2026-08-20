"""
k3_rtl_gen.py -- turn a config dict from dsp_model.best_k3() into a .sv file.

Same rules as the other generators:
  * no timing decisions here, everything comes from `cfg`
  * generated RTL has no `generate` / genvar: what you read is the circuit
  * cycle accounting is checked in Python, so an alignment mistake is an
    exception at generation time instead of a wrong number in simulation

There is no mid_C knob.  u_dsp_11 and u_dsp_22 each drive one PCIN and one C
port, which closes a loop:

    L_11 = m_12 = L_22 + C_12       (11 -> 12 PCOUT,  22 -> 12 C)
    L_22 = m_02 = L_11 + C_02       (22 -> 02 PCOUT,  11 -> 02 C)
    =>  C_12 + C_02 = 0  =>  both zero

so C_PIPE is hardwired to 0 below.
"""

import json
import os

from dsp_multiplier.backend.timing.dsp_model import _seg_widths          # keep segment cuts identical to the model
from .dsp_rtl_gen import _ff_block, lint_sv

# ---- fixed by the algorithm ------------------------------------------------
X_W, Y_W, P_W = 70, 67, 137
X_HI_W = 26
X_MID_W = X_LO_W = 22
Y_HI_W = 23
Y_MID_W = Y_LO_W = 22

P00_W, P22_W = 44, 49          # X_lo*Y_lo , X_hi*Y_hi
P01_W, P12_W = 45, 49
P02ADD_W = 50                  # P02 + P00
ADD_W = 115                    # P[136:22]
LOW_W = 22                     # P[21:0], straight through


# ===========================================================================
# plan
# ===========================================================================
def k3_plan(cfg):
    L_diag = cfg["diag_A"] + cfg["diag_M"] + cfg["diag_P"]
    L_M = cfg["mid_A"] + cfg["mid_AD"] + 1        # cross-DSP MREG always on
    S = cfg["split"]
    out = L_M + cfg["mid_P"]                      # cycle P01/P12/P02 are valid
    tree = out + cfg["p02_d1"]                    # cycle the 115-bit adder starts

    widths = _seg_widths(ADD_W, S)
    lsb, seg = 0, []
    for i, w in enumerate(widths):
        seg.append({"i": i, "lsb": lsb, "w": w,
                    "in_dly": i, "out_dly": S - 1 - i})
        lsb += w

    return {
        "cfg": cfg,
        "L_diag": L_diag, "L_M": L_M, "S": S, "out": out, "tree": tree,
        "latency": tree + S,
        "p00_to_cpa50": out - L_diag,             # P00 into the 50-bit adder
        "p00_to_tree": tree - L_diag,             # P00[43:22] into the tree
        "p22_to_tree": tree - L_diag,
        "p01_to_tree": tree - out,
        "p12_to_tree": tree - out,
        "low_dly": tree - L_diag + S,             # P00[21:0] -> P[21:0]
        "diag_B": cfg["diag_A"],                  # plain multipliers: B tracks A
        "mid_D": cfg["mid_A"],                    # D enters the preadder with A
        "seg": seg,
    }


def verify_k3_plan(p):
    c = p["cfg"]
    Ld, LM = p["L_diag"], p["L_M"]

    # 1. every cross DSP takes PCIN from a diagonal DSP; PCIN has no register,
    #    and the C ports come from diagonal DSPs too with CREG blocked, so the
    #    diagonals and the cross ALUs must sit on exactly the same cycle
    if Ld != LM:
        raise ValueError(f"PCIN/C: diagonal DSPs ready in cycle {Ld}, "
                         f"cross ALUs fire in cycle {LM}")
    # 2. B side must carry as many stages as the A side
    if c["y0y1_ff"] + c["mid_B"] != c["mid_A"] + c["mid_AD"]:
        raise ValueError("B side stages != A side stages: the two multiplier "
                         "operands would meet one cycle apart")
    if c["mid_B"] > 2:
        raise ValueError(f"BREG cannot exceed 2 (mid_B={c['mid_B']})")
    if c["mid_A"] > 1:
        raise ValueError("DREG maxes out at 1, so mid_A cannot exceed 1")
    # 3. the 50-bit adder needs P02 and P00 in the same cycle
    if Ld + p["p00_to_cpa50"] != p["out"]:
        raise ValueError("P00 does not reach the 50-bit adder with P02")
    # 4. all four tree operands must be valid in the same cycle
    for nm, dly, ready in (("P01", p["p01_to_tree"], p["out"]),
                           ("P12", p["p12_to_tree"], p["out"]),
                           ("P22", p["p22_to_tree"], Ld),
                           ("P00", p["p00_to_tree"], Ld)):
        if dly < 0:
            raise ValueError(f"{nm}: negative alignment delay, config is not causal")
        if ready + dly != p["tree"]:
            raise ValueError(f"{nm} lands in cycle {ready + dly}, "
                             f"the tree starts in cycle {p['tree']}")
    # 5. every segment result must reach the final assembly together
    for s in p["seg"]:
        got = p["tree"] + s["in_dly"] + 1 + s["out_dly"]
        if got != p["latency"]:
            raise ValueError(f"segment {s['i']} lands in cycle {got}, "
                             f"expected {p['latency']}")
    if Ld + p["low_dly"] != p["latency"]:
        raise ValueError("P[21:0] does not land with the rest of the result")
    return True


def k3_cost_bits(p):
    n = {
        "P00 align":     P00_W * max(p["p00_to_cpa50"], p["p00_to_tree"]),
        "P22 align":     P22_W * p["p22_to_tree"],
        "P01 align":     P01_W * p["p01_to_tree"],
        "P12 align":     P12_W * p["p12_to_tree"],
        "P02+P00 reg":   P02ADD_W * p["cfg"]["p02_d1"],
        "P[21:0] align": LOW_W * p["S"],
        "Y sub regs":    (23 + 24 + 24) * p["cfg"]["y0y1_ff"],
    }
    ops = res = 0
    for s in p["seg"]:
        ops += 4 * s["w"] * s["in_dly"]              # four operands waiting
        # Four operands need a two-bit carry between segments.  Only the
        # w-bit sum (not that carry) is held by the output-alignment delays.
        res += (s["w"] + 2) + s["w"] * s["out_dly"]
    n["adder operands"] = ops
    n["adder results"] = res
    n["total"] = sum(n.values())
    return n


# ===========================================================================
# emit helpers
# ===========================================================================
def _dsp_inst(A, name, params, ports):
    A("    DSP58Block #(")
    for i, (k, v) in enumerate(params):
        comma = "," if i < len(params) - 1 else ""
        A(f"        .{k:<12}({v}){comma}")
    A(f"    ) {name} (")
    for i, (k, v) in enumerate(ports):
        comma = "," if i < len(ports) - 1 else ""
        A(f"        .{k:<10}({v}){comma}")
    A("    );")
    A("")


def _plain_dsp(A, cfg, p, name, a_expr, b_expr, pcout, pout, comment):
    A(f"    // {name} : {comment}   (ready in cycle {p['L_diag']})")
    _dsp_inst(A, name, [
        ("PREADD", '"FALSE"'), ("USEC", '"FALSE"'), ("USEPCIN", '"ZERO"'),
        ("PREADD_PIPE", 0), ("A_PIPE", cfg["diag_A"]), ("B_PIPE", p["diag_B"]),
        ("C_PIPE", 0), ("D_PIPE", 0),
        ("MULT_PIPE", cfg["diag_M"]), ("P_PIPE", cfg["diag_P"]),
    ], [
        ("clk", "clk"), ("reset", "reset"), ("in_valid", "1'b1"),
        ("A", a_expr), ("B", b_expr),
        ("C", "58'b0"), ("D", "27'b0"), ("PCIN", "58'b0"),
        ("out_valid", ""), ("PCOUT", pcout), ("P", pout),
    ])


def _cross_dsp(A, cfg, p, name, a_expr, b_expr, c_expr, d_expr, pcin, pout, comment):
    A(f"    // {name} : {comment}")
    A(f"    //            AD = D - A ; P = C + AD*B + PCIN"
      f"   (ALU fires in cycle {p['L_M']})")
    _dsp_inst(A, name, [
        ("PREADD", '"TRUE"'), ("ADDAD", '"TRUE"'), ("PREADD_SUB", '"TRUE"'),
        ("USEC", '"TRUE"'), ("USEPCIN", '"PCIN"'),
        ("PREADD_PIPE", cfg["mid_AD"]), ("A_PIPE", cfg["mid_A"]),
        ("B_PIPE", cfg["mid_B"]), ("C_PIPE", 0),      # CREG blocked by the loop
        ("D_PIPE", p["mid_D"]), ("MULT_PIPE", 1), ("P_PIPE", cfg["mid_P"]),
        ("NEG_C", '"FALSE"'), ("NEG_PCIN", '"FALSE"'), ("NEG_M", '"FALSE"'),
    ], [
        ("clk", "clk"), ("reset", "reset"), ("in_valid", "1'b1"),
        ("A", a_expr), ("B", b_expr),
        ("C", c_expr), ("D", d_expr), ("PCIN", pcin),
        ("out_valid", ""), ("PCOUT", ""), ("P", pout),
    ])


# ===========================================================================
# main
# ===========================================================================
def gen_karatsuba3(cfg, result=None, outdir=".", module=None):
    """Generate one Karatsuba3x3 .sv (6 DSPs) from a config dict produced
    by dsp_model.best_k3/karatsuba3, and write it to `outdir`. Returns the
    written file's path."""
    p = k3_plan(cfg)
    verify_k3_plan(p)
    lat = p["latency"]
    name = module or f"Karatsuba3x3_lat{lat}"
    cost = k3_cost_bits(p)

    o = []
    A = o.append
    pend = []                       # queued (dst, src) FF pairs

    def chain(w, base, src, depth):
        """Declare depth FFs base_d1..base_dN, queue the shifts, return the tap.

        depth==0 used to just return `src` verbatim -- fine as a plain RHS,
        but several callers re-index the tap afterwards (`tap[msb]` for sign
        extension, `tap[hi:lo]` for a sub-slice), which is illegal Verilog
        when `src` is itself already a range-select: `P12[48:0]` re-indexed
        as `P12[48:0][48]` is "range is not allowed in a prefix", not valid
        syntax.  So depth==0 now materializes a plain wire instead of handing
        the raw expression back -- same value, but always safely indexable."""
        if depth == 0:
            tap0 = f"{base}_d0"
            A(f"    logic [{w-1}:0] {tap0};")
            A(f"    assign {tap0} = {src};")
            return tap0
        for i in range(1, depth + 1):
            A(f"    logic [{w-1}:0] {base}_d{i};")
            pend.append((f"{base}_d{i}", src if i == 1 else f"{base}_d{i-1}"))
        return f"{base}_d{depth}"

    def flush():
        nonlocal pend
        if pend:
            A("")
            _ff_block(o, pend)
            pend = []

    # ---------------------------------------------------------------- banner
    A("`timescale 1ns / 1ps")
    A("")
    A("//" + "=" * 75)
    A(f"// {name}      P = X * Y   (70 x 67 signed, exact)")
    A("//")
    A("//   GENERATED by k3_rtl_gen.py -- do not edit by hand.")
    A(f"//   Regenerate instead:  gen_karatsuba3(best_k3({lat}))")
    A("//")
    A("//   config    : " + json.dumps(cfg))
    if result:
        A("//   predicted : %.3f ns  /  %.0f MHz" %
          (result["critical_ns"], result["fmax_mhz"]))
        A("//   critical  : " + result["critical"][0])
    A("//")
    A("//   u_dsp_11 and u_dsp_22 each drive one PCIN and one C port, which")
    A("//   forces C_12 = C_02 = 0.  CREG is unavailable in this topology.")
    A("//")
    A("//   cycle accounting")
    A(f"//     u_dsp_00/11/22 ready in cycle {p['L_diag']}")
    A(f"//     cross ALUs     fire  in cycle {p['L_M']}")
    A(f"//     P01/P12/P02    valid in cycle {p['out']}    (PREG={cfg['mid_P']})")
    A(f"//     P02+P00 (50b)  valid in cycle {p['tree']}    (reg={cfg['p02_d1']})")
    A(f"//     115-bit add split into {p['S']} segment(s)   -> latency {lat}")
    A("//")
    A(f"//   alignment FFs: {cost['total']}  " + json.dumps(
        {k: v for k, v in cost.items() if k != "total" and v}))
    A("//" + "=" * 75)
    A("")

    # ----------------------------------------------------------------- ports
    A(f"module {name} (")
    A("    input  logic                clk,")
    A("    input  logic                reset,")
    A("    input  logic                in_valid,")
    A(f"    input  logic signed [{X_W-1}:0]  X,")
    A(f"    input  logic signed [{Y_W-1}:0]  Y,")
    A("")
    A("    output logic                out_valid,")
    A(f"    output logic signed [{P_W-1}:0] P")
    A(");")
    A("")

    # -------------------------------------------------------- decomposition
    A("    // ---------------- limb decomposition ----------------")
    A(f"    logic signed   [{X_HI_W-1}:0] X_hi;")
    A(f"    logic unsigned [{X_MID_W-1}:0] X_mid;")
    A(f"    logic unsigned [{X_LO_W-1}:0] X_lo;")
    A(f"    logic signed   [{Y_HI_W-1}:0] Y_hi;")
    A(f"    logic unsigned [{Y_MID_W-1}:0] Y_mid;")
    A(f"    logic unsigned [{Y_LO_W-1}:0] Y_lo;")
    A("")
    A(f"    assign X_hi  = X[{X_W-1}:44];")
    A("    assign X_mid = X[43:22];")
    A("    assign X_lo  = X[21:0];")
    A(f"    assign Y_hi  = Y[{Y_W-1}:44];")
    A("    assign Y_mid = Y[43:22];")
    A("    assign Y_lo  = Y[21:0];")
    A("")

    # -------------------------------------------------------- Y differences
    A("    // ---------------- Y differences (fabric subtractors) ----------------")
    A("    logic signed [22:0] Y0Y1;")
    A("    logic signed [23:0] Y0Y2;")
    A("    logic signed [23:0] Y1Y2;")
    A("    assign Y0Y1 = $signed({1'b0, Y_lo})  - $signed({1'b0, Y_mid});")
    A(f"    assign Y0Y2 = $signed({{2'b0, Y_lo}})  - $signed({{Y_hi[{Y_HI_W-1}], Y_hi}});")
    A(f"    assign Y1Y2 = $signed({{2'b0, Y_mid}}) - $signed({{Y_hi[{Y_HI_W-1}], Y_hi}});")
    A("")
    if cfg["y0y1_ff"]:
        A("    // registered in fabric so the subtractors get their own stage")
        A("    logic signed [22:0] Y0Y1_q;")
        A("    logic signed [23:0] Y0Y2_q;")
        A("    logic signed [23:0] Y1Y2_q;")
        _ff_block(o, [("Y0Y1_q", "Y0Y1"), ("Y0Y2_q", "Y0Y2"), ("Y1Y2_q", "Y1Y2")])
        y01, y02, y12 = "Y0Y1_q", "Y0Y2_q", "Y1Y2_q"
    else:
        y01, y02, y12 = "Y0Y1", "Y0Y2", "Y1Y2"

    # ------------------------------------------------------------ diagonals
    A("    // ---------------- 3 diagonal DSPs ----------------")
    A("    logic signed [57:0] P00, P00_COUT, P11, P11_COUT, P22, P22_COUT;")
    A("    logic signed [57:0] P01, P12, P02;")
    A("")
    _plain_dsp(A, cfg, p, "u_dsp_00", "{12'b0, X_lo}", "{2'b0, Y_lo}",
               "P00_COUT", "P00", "X_lo * Y_lo")
    _plain_dsp(A, cfg, p, "u_dsp_11", "{12'b0, X_mid}", "{2'b0, Y_mid}",
               "P11_COUT", "P11", "X_mid * Y_mid")
    _plain_dsp(A, cfg, p, "u_dsp_22", f"{{{{8{{X_hi[{X_HI_W-1}]}}}}, X_hi}}",
               f"{{Y_hi[{Y_HI_W-1}], Y_hi}}",
               "P22_COUT", "P22", "X_hi * Y_hi")

    # ---------------------------------------------------------- cross terms
    A("    // ---------------- 3 cross DSPs ----------------")
    _cross_dsp(A, cfg, p, "u_dsp_01", "{12'b0, X_lo}", f"{{{y01}[22], {y01}}}",
               "P11", "{5'b0, X_mid}", "P00_COUT", "P01",
               "X_lo*Y_mid + X_mid*Y_lo + P11 + P00")
    _cross_dsp(A, cfg, p, "u_dsp_12", "{12'b0, X_mid}", y12,
               "P22", f"{{X_hi[{X_HI_W-1}], X_hi}}", "P11_COUT", "P12",
               "X_mid*Y_hi + X_hi*Y_mid + P22 + P11")
    _cross_dsp(A, cfg, p, "u_dsp_02", "{12'b0, X_lo}", y02,
               "P11", f"{{X_hi[{X_HI_W-1}], X_hi}}", "P22_COUT", "P02",
               "X_lo*Y_hi + X_hi*Y_lo + P11 - P00")

    # ------------------------------------------------------ P02 + P00 (50b)
    A("    // ---------------- P02 + P00  (50-bit adder) ----------------")
    A("    //   u_dsp_02 puts P11 on C and P22 on PCIN, which leaves the result")
    A("    //   short by P00, so P00 is added back here at weight 2^44.")
    A("")
    p00_a = chain(P00_W, "P00_a", f"P00[{P00_W-1}:0]", p["p00_to_cpa50"])
    flush()
    A(f"    logic signed [{P02ADD_W-1}:0] P02_add_P00;")
    A(f"    assign P02_add_P00 = $signed(P02[{P02ADD_W-1}:0])"
      f" + $signed({{6'b0, {p00_a}}});")
    A("")
    if cfg["p02_d1"]:
        A(f"    logic signed [{P02ADD_W-1}:0] P02_add_P00_q;")
        _ff_block(o, [("P02_add_P00_q", "P02_add_P00")])
        p02add = "P02_add_P00_q"
    else:
        p02add = "P02_add_P00"

    # ------------------------------------------------------- tree operands
    A("    // ---------------- align the four tree operands ----------------")
    A(f"    //   everything must be valid in cycle {p['tree']}")
    A("")
    extra00 = p["p00_to_tree"] - p["p00_to_cpa50"]
    p00_t = chain(P00_W, "P00_t", p00_a, extra00)
    p22_t = chain(P22_W, "P22_t", f"P22[{P22_W-1}:0]", p["p22_to_tree"])
    p01_t = chain(P01_W, "P01_t", f"P01[{P01_W-1}:0]", p["p01_to_tree"])
    p12_t = chain(P12_W, "P12_t", f"P12[{P12_W-1}:0]", p["p12_to_tree"])
    flush()

    A(f"    logic [{ADD_W-1}:0] tree_op1, tree_op2, tree_op3, tree_op4;")
    A(f"    assign tree_op1 = {{70'b0, {p01_t}}};")
    A(f"    assign tree_op2 = {{{{43{{{p02add}[{P02ADD_W-1}]}}}}, "
      f"{p02add}, {p00_t}[{P00_W-1}:{LOW_W}]}};")
    A(f"    assign tree_op3 = {{{{22{{{p12_t}[{P12_W-1}]}}}}, {p12_t}, 44'b0}};")
    A(f"    assign tree_op4 = {{{p22_t}, 66'b0}};")
    A("")

    # ------------------------------------------------------------ segments
    A(f"    // ---------------- 115-bit recomposition, {p['S']} segment(s) -------")
    seg_out = []
    for s in p["seg"]:
        i, w, lsb, d = s["i"], s["w"], s["lsb"], s["in_dly"]
        hi = lsb + w - 1
        A(f"    // segment {i}: bits [{hi}:{lsb}]"
          f"   (operands wait {d}, result waits {s['out_dly']})")
        names = [f"s{i}_o{n}" for n in (1, 2, 3, 4)]
        srcs = [f"tree_op{n}[{hi}:{lsb}]" for n in (1, 2, 3, 4)]
        for sname in names:
            A(f"    logic [{w-1}:0] {sname};")
        if d == 0:
            for sname, src in zip(names, srcs):
                A(f"    assign {sname} = {src};")
        else:
            for sname, src in zip(names, srcs):
                chain(w, sname + "_q", src, d)
            flush()
            for sname in names:
                A(f"    assign {sname} = {sname}_q_d{d};")
        carry_slice = (
            "2'b0" if i == 0 else
            f"s{i-1}_q[{p['seg'][i-1]['w'] + 1}:{p['seg'][i-1]['w']}]"
        )
        carry = f"{w+2}'({carry_slice})"
        A(f"    logic [{w+1}:0] s{i}_res, s{i}_q;   // [{w+1}:{w}] = carry out")
        A(f"    assign s{i}_res = {{2'b0, {names[0]}}} + {{2'b0, {names[1]}}}"
          f" + {{2'b0, {names[2]}}} + {{2'b0, {names[3]}}} + {carry};")
        _ff_block(o, [(f"s{i}_q", f"s{i}_res")])
        tap = chain(w, f"s{i}_sum", f"s{i}_q[{w-1}:0]", s["out_dly"])
        flush()
        seg_out.append(tap)

    # ------------------------------------------------------------- P[21:0]
    A(f"    // ---------------- P[{LOW_W-1}:0] : straight out of X_lo*Y_lo ------------")
    low = chain(LOW_W, "P_low", f"P00[{LOW_W-1}:0]", p["low_dly"])
    flush()

    # ------------------------------------------------------------ assembly
    A("    // ---------------- result assembly ----------------")
    A(f"    logic [{ADD_W-1}:0] P_136_22;")
    A("    assign P_136_22 = {" + ", ".join(reversed(seg_out)) + "};")
    A(f"    assign P = {{P_136_22, {low}}};")
    A("")

    # ---------------------------------------------------------------- valid
    A(f"    // ---------------- valid, {lat} cycle(s) ----------------")
    A(f"    logic [{lat-1}:0] valid_sr;")
    A("    always_ff @(posedge clk) begin")
    A("        if (reset) valid_sr <= '0;")
    if lat == 1:
        A("        else       valid_sr <= in_valid;")
    else:
        A(f"        else       valid_sr <= {{valid_sr[{lat-2}:0], in_valid}};")
    A("    end")
    A(f"    assign out_valid = valid_sr[{lat-1}];")
    A("")
    A("endmodule")

    text = "\n".join(o) + "\n"
    lint_sv(text)

    os.makedirs(outdir, exist_ok=True)
    path = os.path.join(outdir, name + ".sv")
    with open(path, "w") as f:
        f.write(text)
    return path
