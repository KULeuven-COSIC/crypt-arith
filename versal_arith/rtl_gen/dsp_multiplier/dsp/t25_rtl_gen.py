"""
t25_rtl_gen.py -- turn a config dict from dsp_model.best_t25() into a .sv file.

Same rules as the other generators:
  * no timing decisions here, everything comes from `cfg`
  * generated RTL has no `generate` / genvar: what you read is the circuit
  * cycle accounting is checked in Python, so an alignment mistake is an
    exception at generation time instead of a wrong number in simulation

There is no mid_C knob.  u_dsp_p0 and u_dsp_p3 each drive one PCIN and one C
port, which closes a loop:

    L_p3 = m_s = L_p0 + C_s          (p3 -> s PCOUT,  p0 -> s C)
    L_p0 = m_d = L_p3 + C_d          (p0 -> d PCOUT,  p3 -> d C)
    =>  C_s + C_d = 0  =>  both zero

so C_PIPE is hardwired to 0 below.  Note the pre-adder sits on the Y side
here (A = Y1, D = Y0); the fabric-built X(+1)/X(-1) go to the B ports.
"""

import json
import os

from dsp_multiplier.backend.timing.dsp_model import _seg_widths          # keep segment cuts identical to the model
from .dsp_rtl_gen import _ff_block, lint_sv

# ---- fixed by the algorithm ------------------------------------------------
X_W, Y_W, P_W = 65, 47, 112
LIMB_W = 21
X0_W = X1_W = 21
X2_W = 23
Y0_W = 21
Y1_W = 26
XEVAL_W = 24                   # X(+1), X(-1)
DSP_W = 58
INTERP_W = 59                  # twice_P1, twice_P2
ADD_W = 91                     # Q = P[111:21]
LOW_W = 21                     # P[20:0], straight out of P0
P0_TREE_W = 42                 # P0[41:0] : [41:21] -> Q_op0, [20:0] -> P


# ===========================================================================
# plan
# ===========================================================================
def t25_plan(cfg):
    L_diag = cfg["diag_A"] + cfg["diag_M"] + cfg["diag_P"]
    L_M = cfg["mid_A"] + cfg["mid_AD"] + 1        # eval MREG is always on
    S = cfg["split"]
    out = L_M + cfg["mid_P"]                      # cycle S and D are valid
    interp = out + cfg["interp_d1"]               # cycle P1/P2 feed the tree

    widths = _seg_widths(ADD_W, S)
    lsb, seg = 0, []
    for i, w in enumerate(widths):
        seg.append({"i": i, "lsb": lsb, "w": w,
                    "in_dly": i, "out_dly": S - 1 - i})
        lsb += w

    return {
        "cfg": cfg,
        "L_diag": L_diag, "L_M": L_M, "S": S, "out": out, "interp": interp,
        "latency": interp + S,
        "p0_to_tree": interp - L_diag,            # P0[41:21] -> Q_op0
        "p3_to_tree": interp - L_diag,            # P3        -> Q_op3
        "low_dly": interp - L_diag + S,           # P0[20:0]  -> P[20:0]
        "diag_B": cfg["diag_A"],                  # plain multipliers: B tracks A
        "mid_D": cfg["mid_A"],                    # D enters the preadder with A
        "seg": seg,
    }


def verify_t25_plan(p):
    c = p["cfg"]
    Ld, LM = p["L_diag"], p["L_M"]

    # 1. p0/p3 feed both PCIN (no register) and C (CREG blocked by the loop),
    #    so they must land on exactly the cycle the eval ALUs fire
    if Ld != LM:
        raise ValueError(f"PCIN/C: u_dsp_p0 and u_dsp_p3 ready in cycle {Ld}, "
                         f"eval ALUs fire in cycle {LM}")
    # 2. B side must carry as many stages as the A side
    if c["xeval_ff"] + c["mid_B"] != c["mid_A"] + c["mid_AD"]:
        raise ValueError("B side stages != A side stages: X(+/-1) and Y1 would "
                         "meet the multiplier one cycle apart")
    if c["mid_B"] > 2:
        raise ValueError(f"BREG cannot exceed 2 (mid_B={c['mid_B']})")
    if c["mid_A"] > 1:
        raise ValueError("DREG maxes out at 1, so mid_A cannot exceed 1")
    # 3. the tree operands must all be valid in the same cycle
    for nm, dly in (("P0", p["p0_to_tree"]), ("P3", p["p3_to_tree"])):
        if dly < 0:
            raise ValueError(f"{nm}: negative alignment delay, config is not causal")
        if Ld + dly != p["interp"]:
            raise ValueError(f"{nm} lands in cycle {Ld + dly}, "
                             f"the tree starts in cycle {p['interp']}")
    # 4. every segment result must reach the final assembly together
    for s in p["seg"]:
        got = p["interp"] + s["in_dly"] + 1 + s["out_dly"]
        if got != p["latency"]:
            raise ValueError(f"segment {s['i']} lands in cycle {got}, "
                             f"expected {p['latency']}")
    if Ld + p["low_dly"] != p["latency"]:
        raise ValueError("P[20:0] does not land with the rest of the result")
    return True


def t25_cost_bits(p):
    n = {
        "P0 align":      P0_TREE_W * p["p0_to_tree"],
        "P3 align":      DSP_W * p["p3_to_tree"],
        "P1/P2 reg":     2 * DSP_W * p["cfg"]["interp_d1"],
        "P[20:0] align": LOW_W * p["S"],
        "Xeval regs":    2 * XEVAL_W * p["cfg"]["xeval_ff"],
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


def _eval_dsp(A, cfg, p, name, sub, b_expr, c_expr, neg_c, pcin, pout, comment):
    A(f"    // {name} : {comment}")
    A(f"    //            AD = {'D - A' if sub == 'TRUE' else 'D + A'} = "
      f"{'Y0 - Y1' if sub == 'TRUE' else 'Y0 + Y1'}"
      f"          (ALU fires in cycle {p['L_M']})")
    _dsp_inst(A, name, [
        ("PREADD", '"TRUE"'), ("ADDAD", '"TRUE"'), ("PREADD_SUB", f'"{sub}"'),
        ("USEC", '"TRUE"'), ("USEPCIN", '"PCIN"'),
        ("PREADD_PIPE", cfg["mid_AD"]), ("A_PIPE", cfg["mid_A"]),
        ("B_PIPE", cfg["mid_B"]), ("C_PIPE", 0),      # CREG blocked by the loop
        ("D_PIPE", p["mid_D"]), ("MULT_PIPE", 1), ("P_PIPE", cfg["mid_P"]),
        ("NEG_C", f'"{neg_c}"'), ("NEG_PCIN", '"TRUE"'), ("NEG_M", '"FALSE"'),
    ], [
        ("clk", "clk"), ("reset", "reset"), ("in_valid", "1'b1"),
        ("A", f"{{{{8{{Y1[{Y1_W-1}]}}}}, Y1}}"), ("B", b_expr),
        ("C", c_expr), ("D", "{6'b0, Y0}"), ("PCIN", pcin),
        ("out_valid", ""), ("PCOUT", ""), ("P", pout),
    ])


# ===========================================================================
# main
# ===========================================================================
def gen_toomcook25(cfg, result=None, outdir=".", module=None):
    """Generate one ToomCook25 .sv (4 DSPs) from a config dict produced by
    dsp_model.best_t25/toomcook25, and write it to `outdir`. Returns the
    written file's path."""
    p = t25_plan(cfg)
    verify_t25_plan(p)
    lat = p["latency"]
    name = module or f"ToomCook25_lat{lat}"
    cost = t25_cost_bits(p)

    o = []
    A = o.append
    pend = []

    def chain(w, base, src, depth):
        """depth==0 used to just return `src` verbatim -- fine as a plain RHS,
        but several callers re-index the tap afterwards (`tap[msb]` for sign
        extension, `tap[hi:lo]` for a sub-slice), which is illegal Verilog
        when `src` is itself already a range-select: `P3[57:0]` re-indexed as
        `P3[57:0][57]` is "range is not allowed in a prefix", not valid
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
    A(f"// {name}      P = X * Y   (65 x 47 signed, exact)")
    A("//")
    A("//   GENERATED by t25_rtl_gen.py -- do not edit by hand.")
    A(f"//   Regenerate instead:  gen_toomcook25(best_t25({lat}))")
    A("//")
    A("//   config    : " + json.dumps(cfg))
    if result:
        A("//   predicted : %.3f ns  /  %.0f MHz" %
          (result["critical_ns"], result["fmax_mhz"]))
        A("//   critical  : " + result["critical"][0])
    A("//")
    A("//   u_dsp_p0 and u_dsp_p3 each drive one PCIN and one C port, which")
    A("//   forces C_s = C_d = 0.  CREG is unavailable in this topology.")
    A("//")
    A("//   cycle accounting")
    A(f"//     u_dsp_p0 / p3   ready in cycle {p['L_diag']}")
    A(f"//     eval ALUs       fire  in cycle {p['L_M']}")
    A(f"//     S and D         valid in cycle {p['out']}    (PREG={cfg['mid_P']})")
    A(f"//     P1 / P2         valid in cycle {p['interp']}    (reg={cfg['interp_d1']})")
    A(f"//     91-bit Q split into {p['S']} segment(s)      -> latency {lat}")
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

    # ----------------------------------------------------------------- valid
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

    # -------------------------------------------------------- decomposition
    A("    // ---------------- limb decomposition ----------------")
    A(f"    //   X = X0 + X1*2^{LIMB_W} + X2*2^{2*LIMB_W} ,  Y = Y0 + Y1*2^{LIMB_W}")
    A(f"    logic        [{X0_W-1}:0] X0;")
    A(f"    logic        [{X1_W-1}:0] X1;")
    A(f"    logic signed [{X2_W-1}:0] X2;")
    A(f"    logic        [{Y0_W-1}:0] Y0;")
    A(f"    logic signed [{Y1_W-1}:0] Y1;")
    A("")
    A(f"    assign X0 = X[{X0_W-1}:0];")
    A(f"    assign X1 = X[{X0_W+X1_W-1}:{X0_W}];")
    A(f"    assign X2 = X[{X_W-1}:{X0_W+X1_W}];")
    A(f"    assign Y0 = Y[{Y0_W-1}:0];")
    A(f"    assign Y1 = Y[{Y_W-1}:{Y0_W}];")
    A("")

    # -------------------------------------------------- X evaluation (fabric)
    A("    // ---------------- X evaluated at +1 and -1 (fabric, 3 operands) ----")
    A(f"    logic signed [{XEVAL_W-1}:0] X_at_p1;")
    A(f"    logic signed [{XEVAL_W-1}:0] X_at_m1;")
    A("    assign X_at_p1 = $signed({3'b000, X0}) + $signed({3'b000, X1})"
      f" + $signed({{X2[{X2_W-1}], X2}});")
    A("    assign X_at_m1 = $signed({3'b000, X0}) - $signed({3'b000, X1})"
      f" + $signed({{X2[{X2_W-1}], X2}});")
    A("")
    if cfg["xeval_ff"]:
        A("    // registered in fabric so the 24-bit evaluators get their own stage")
        A(f"    logic signed [{XEVAL_W-1}:0] X_at_p1_q;")
        A(f"    logic signed [{XEVAL_W-1}:0] X_at_m1_q;")
        _ff_block(o, [("X_at_p1_q", "X_at_p1"), ("X_at_m1_q", "X_at_m1")])
        bp1, bm1 = "X_at_p1_q", "X_at_m1_q"
    else:
        bp1, bm1 = "X_at_p1", "X_at_m1"

    # ------------------------------------------------------------- 4 DSPs
    A("    // ---------------- 4 DSP58 ----------------")
    A("    logic signed [57:0] P0, P0_PCOUT, P3, P3_PCOUT;")
    A("    logic signed [57:0] P2_plus_P1, P2_minus_P1;")
    A("")
    _plain_dsp(A, cfg, p, "u_dsp_p0", "{13'b0, X0}", "{3'b0, Y0}",
               "P0_PCOUT", "P0", "X0 * Y0        (beta^0 endpoint)")
    _plain_dsp(A, cfg, p, "u_dsp_p3",
               f"{{{{8{{Y1[{Y1_W-1}]}}}}, Y1}}", f"{{{{1{{X2[{X2_W-1}]}}}}, X2}}",
               "P3_PCOUT", "P3", "X2 * Y1        (beta^inf endpoint)")

    A("    // S = P1+P2 = X(1)*Y(1) - P0 - P3.  This encoding yields S-1;")
    A("    // the interpolation below adds the missing +1 back.")
    _eval_dsp(A, cfg, p, "u_dsp_p2_plus_p1", "FALSE", bp1,
              "P0", "TRUE", "P3_PCOUT", "P2_plus_P1",
              "S = P2 + P1")
    A("    // D = P2-P1 = X(-1)*Y(-1) - P0 + P3")
    _eval_dsp(A, cfg, p, "u_dsp_p2_minus_p1", "TRUE", bm1,
              "P3", "FALSE", "P0_PCOUT", "P2_minus_P1",
              "D = P2 - P1")

    # ------------------------------------------------------ interpolation
    A("    // ---------------- interpolation ----------------")
    A("    //   59-bit nodes so 2*P1 and 2*P2 cannot overflow; both are even.")
    A(f"    logic signed [{INTERP_W-1}:0] twice_P1, twice_P2;")
    A(f"    logic signed [{DSP_W-1}:0] P1_comb, P2_comb;")
    A(f"    assign twice_P1 = $signed({{P2_plus_P1[{DSP_W-1}],  P2_plus_P1}})")
    A(f"                    - $signed({{P2_minus_P1[{DSP_W-1}], P2_minus_P1}})"
      f" + {INTERP_W}'sd1;")
    A(f"    assign twice_P2 = $signed({{P2_plus_P1[{DSP_W-1}],  P2_plus_P1}})")
    A(f"                    + $signed({{P2_minus_P1[{DSP_W-1}], P2_minus_P1}})"
      f" + {INTERP_W}'sd1;")
    # The interpolation numerators are 59-bit signed and asserted even below.
    # Taking [58:1] is the exact 58-bit arithmetic divide-by-two result and
    # makes the intentional width reduction explicit to HDL lint tools.
    A("    assign P1_comb = twice_P1[58:1];")
    A("    assign P2_comb = twice_P2[58:1];")
    A("")
    if cfg["interp_d1"]:
        A(f"    logic signed [{DSP_W-1}:0] P1_reg, P2_reg;")
        _ff_block(o, [("P1_reg", "P1_comb"), ("P2_reg", "P2_comb")])
        p1, p2 = "P1_reg", "P2_reg"
    else:
        p1, p2 = "P1_comb", "P2_comb"

    # --------------------------------------------------------- align P0/P3
    A("    // ---------------- align P0 and P3 to the tree ----------------")
    A(f"    //   both are ready in cycle {p['L_diag']}, the tree starts in cycle {p['interp']}")
    A("")
    p0_t = chain(P0_TREE_W, "P0_t", f"P0[{P0_TREE_W-1}:0]", p["p0_to_tree"])
    p3_t = chain(DSP_W, "P3_t", f"P3[{DSP_W-1}:0]", p["p3_to_tree"])
    flush()

    # ------------------------------------------------------- recomposition
    A("    // ---------------- recomposition ----------------")
    A(f"    //   Q = P0[41:21] + P1 + P2*2^{LIMB_W} + P3*2^{2*LIMB_W}   ({ADD_W} bit)")
    A(f"    //   P = {{Q, P0[{LOW_W-1}:0]}}")
    A(f"    logic [{ADD_W-1}:0] Q_op0, Q_op1, Q_op2, Q_op3;")
    A(f"    assign Q_op0 = {{70'b0, {p0_t}[{P0_TREE_W-1}:{LOW_W}]}};")
    A(f"    assign Q_op1 = {{{{33{{{p1}[{DSP_W-1}]}}}}, {p1}}};")
    A(f"    assign Q_op2 = {{{{33{{{p2}[{DSP_W-1}]}}}}, {p2}}} <<< {LIMB_W};")
    A(f"    assign Q_op3 = {{{{33{{{p3_t}[{DSP_W-1}]}}}}, {p3_t}}} <<< {2*LIMB_W};")
    A("")

    # ------------------------------------------------------------ segments
    A(f"    // ---------------- {ADD_W}-bit Q, {p['S']} segment(s) ----------------")
    seg_out = []
    for s in p["seg"]:
        i, w, lsb, d = s["i"], s["w"], s["lsb"], s["in_dly"]
        hi = lsb + w - 1
        A(f"    // segment {i}: bits [{hi}:{lsb}]"
          f"   (operands wait {d}, result waits {s['out_dly']})")
        names = [f"s{i}_o{n}" for n in range(4)]
        srcs = [f"Q_op{n}[{hi}:{lsb}]" for n in range(4)]
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

    # ------------------------------------------------------------ P[20:0]
    A(f"    // ---------------- P[{LOW_W-1}:0] : straight out of X0*Y0 ----------------")
    low = chain(LOW_W, "P_low", f"P0[{LOW_W-1}:0]", p["low_dly"])
    flush()

    # ----------------------------------------------------------- assembly
    A("    // ---------------- result assembly ----------------")
    A(f"    logic [{ADD_W-1}:0] Q_comb;")
    A("    assign Q_comb = {" + ", ".join(reversed(seg_out)) + "};")
    A(f"    assign P = {{Q_comb, {low}}};")
    A("")

    # ---------------------------------------------------------- assertions
    A("`ifndef SYNTHESIS")
    A("    // Toom interpolation must always produce even numerators.")
    A("    always_ff @(posedge clk) begin")
    A(f"        if (!reset && valid_sr[{p['out']-1}]) begin")
    A("            assert (twice_P1[0] == 1'b0)")
    A(f"                else $error(\"{name}: S-D is not even\");")
    A("            assert (twice_P2[0] == 1'b0)")
    A(f"                else $error(\"{name}: S+D is not even\");")
    A("        end")
    A("    end")
    A("`endif")
    A("")
    A("endmodule")

    text = "\n".join(o) + "\n"
    lint_sv(text)

    os.makedirs(outdir, exist_ok=True)
    path = os.path.join(outdir, name + ".sv")
    with open(path, "w") as f:
        f.write(text)
    return path
