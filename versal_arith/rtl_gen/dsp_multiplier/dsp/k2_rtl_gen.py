"""
k2_rtl_gen.py -- turn a config dict from dsp_model.best_k2() into a .sv file.

Same rules as dsp_rtl_gen.py:
  * no timing decisions here, everything comes from `cfg`
  * generated RTL has no `generate` / genvar: what you read is the circuit
  * cycle accounting is checked in Python, so an alignment mistake is an
    exception at generation time instead of a wrong number in simulation
"""

import json
import os

from dsp_multiplier.backend.timing.dsp_model import _seg_widths          # keep segment cuts identical to the model
from .dsp_rtl_gen import _ff_block, lint_sv

# ---- fixed by the algorithm ------------------------------------------------
X_W, Y_W, P_W = 48, 45, 93
X_HI_W, X_LO_W = 26, 22
Y_HI_W, Y_LO_W = 23, 22
Y0Y1_W = 24
P_HI_W = 49          # X_hi * Y_hi
P_LO_W = 44          # X_lo * Y_lo
ADD_W  = 71          # P[92:22]
LOW_W  = 22          # P[21:0], straight through


# ===========================================================================
# plan
# ===========================================================================
def k2_plan(cfg):
    L_lo = cfg["lo_A"] + cfg["lo_M"] + cfg["lo_P"]
    L_hi = cfg["hi_A"] + cfg["hi_M"] + cfg["hi_P"]
    L_M  = cfg["mid_A"] + cfg["mid_AD"] + 1        # mid MREG is always on
    S    = cfg["split"]
    out  = L_M + cfg["mid_P"]                      # cycle P_mid is valid

    widths = _seg_widths(ADD_W, S)
    lsb, seg = 0, []
    for i, w in enumerate(widths):
        seg.append({"i": i, "lsb": lsb, "w": w,
                    "in_dly": i,                   # operands wait i cycles
                    "out_dly": S - 1 - i})         # result waits S-1-i cycles
        lsb += w

    return {
        "cfg": cfg,
        "L_lo": L_lo, "L_hi": L_hi, "L_M": L_M, "S": S, "out": out,
        "latency": out + S,
        "hi_dly":  out - L_hi,                     # FFs on P_hi before the adder
        "lo_dly":  out - L_lo,                     # FFs on P_lo before the adder
        "low_dly": out - L_lo + S,                 # FFs on P_lo before P[21:0]
        "lo_B": cfg["lo_A"], "hi_B": cfg["hi_A"],  # plain multipliers: B tracks A
        "mid_D": cfg["mid_A"],                     # D enters the preadder with A
        "seg": seg,
    }


def verify_k2_plan(p):
    c = p["cfg"]

    # 1. PCIN has no input register, so u_dsp_lo must land exactly on L_M
    if p["L_lo"] != p["L_M"]:
        raise ValueError(f"PCIN: u_dsp_lo ready in cycle {p['L_lo']}, "
                         f"mid ALU fires in cycle {p['L_M']}")
    # 2. the C path may only be shifted by CREG
    if p["L_hi"] + c["mid_C"] != p["L_M"]:
        raise ValueError(f"C: u_dsp_hi ready in cycle {p['L_hi']} + CREG "
                         f"{c['mid_C']}, mid ALU fires in cycle {p['L_M']}")
    # 3. B side must carry as many stages as the A side
    if c["y0y1_ff"] + c["mid_B"] != c["mid_A"] + c["mid_AD"]:
        raise ValueError("B side stages != A side stages: the two multiplier "
                         "operands would meet one cycle apart")
    if c["mid_B"] > 2:
        raise ValueError(f"BREG cannot exceed 2 (mid_B={c['mid_B']})")
    # 4. all three adder operands must be valid in the same cycle
    if p["L_hi"] + p["hi_dly"] != p["out"]:
        raise ValueError("P_hi does not reach the adder in cycle out")
    if p["L_lo"] + p["lo_dly"] != p["out"]:
        raise ValueError("P_lo does not reach the adder in cycle out")
    if min(p["hi_dly"], p["lo_dly"]) < 0:
        raise ValueError("negative alignment delay -- config is not causal")
    # 5. every piece must reach the final assembly in the same cycle
    for s in p["seg"]:
        got = p["out"] + s["in_dly"] + 1 + s["out_dly"]
        if got != p["latency"]:
            raise ValueError(f"segment {s['i']} lands in cycle {got}, "
                             f"expected {p['latency']}")
    if p["L_lo"] + p["low_dly"] != p["latency"]:
        raise ValueError("P[21:0] does not land with the rest of the result")
    return True


def k2_cost_bits(p):
    """Alignment storage, in flip-flops."""
    n = {
        "P_hi align":    P_HI_W * p["hi_dly"],
        "P_lo align":    P_LO_W * p["lo_dly"],
        "P[21:0] align": LOW_W * p["S"],
        "Y0Y1 reg":      Y0Y1_W * p["cfg"]["y0y1_ff"],
    }
    ops = res = 0
    for s in p["seg"]:
        ops += 2 * s["w"] * s["in_dly"]              # op1/op2 slices waiting
        # The adder result register keeps w sum bits plus one carry; only the
        # w-bit sum is held by later output-alignment registers.
        res += (s["w"] + 1) + s["w"] * s["out_dly"]
    n["adder operands"] = ops
    n["adder results"]  = res
    n["total"] = sum(n.values())
    return n


# ===========================================================================
# emit
# ===========================================================================
def _dsp_inst(A, name, params, ports):
    A(f"    DSP58Block #(")
    for i, (k, v) in enumerate(params):
        comma = "," if i < len(params) - 1 else ""
        A(f"        .{k:<12}({v}){comma}")
    A(f"    ) {name} (")
    for i, (k, v) in enumerate(ports):
        comma = "," if i < len(ports) - 1 else ""
        A(f"        .{k:<10}({v}){comma}")
    A("    );")
    A("")


def gen_karatsuba2(cfg, result=None, outdir=".", module=None):
    """Generate one Karatsuba2x2 .sv (3 DSPs) from a config dict produced
    by dsp_model.best_k2/karatsuba2, and write it to `outdir`. Returns the
    written file's path."""
    p = k2_plan(cfg)
    verify_k2_plan(p)
    lat = p["latency"]
    name = module or f"Karatsuba2x2_lat{lat}"
    cost = k2_cost_bits(p)

    o = []
    A = o.append

    # ---------------------------------------------------------------- banner
    A("`timescale 1ns / 1ps")
    A("")
    A("//" + "=" * 75)
    A(f"// {name}      P = X * Y   (48 x 45 signed, exact)")
    A("//")
    A("//   GENERATED by k2_rtl_gen.py -- do not edit by hand.")
    A(f"//   Regenerate instead:  gen_karatsuba2(best_k2({lat}))")
    A("//")
    A("//   config    : " + json.dumps(cfg))
    if result:
        A("//   predicted : %.3f ns  /  %.0f MHz" %
          (result["critical_ns"], result["fmax_mhz"]))
        A("//   critical  : " + result["critical"][0])
    A("//")
    A("//   cycle accounting")
    A(f"//     u_dsp_lo  ready in cycle {p['L_lo']}   -> PCIN of u_dsp_mid (no CREG possible)")
    A(f"//     u_dsp_hi  ready in cycle {p['L_hi']}   -> C    of u_dsp_mid (CREG={cfg['mid_C']})")
    A(f"//     mid ALU   fires in cycle {p['L_M']}")
    A(f"//     P_mid     valid in cycle {p['out']}   (PREG={cfg['mid_P']})")
    A(f"//     71-bit add split into {p['S']} segment(s)  -> latency {lat}")
    A("//")
    A(f"//   alignment FFs: {cost['total']}  " + json.dumps(
        {k: v for k, v in cost.items() if k != 'total' and v}))
    A("//" + "=" * 75)
    A("")

    # ----------------------------------------------------------------- ports
    A(f"module {name} (")
    A("    input  logic               clk,")
    A("    input  logic               reset,")
    A("    input  logic               in_valid,")
    A(f"    input  logic signed [{X_W-1}:0] X,")
    A(f"    input  logic signed [{Y_W-1}:0] Y,")
    A("")
    A("    output logic               out_valid,")
    A(f"    output logic signed [{P_W-1}:0] P")
    A(");")
    A("")

    # -------------------------------------------------------- decomposition
    A("    // ---------------- limb decomposition ----------------")
    A(f"    logic signed   [{X_HI_W-1}:0] X_hi;")
    A(f"    logic unsigned [{X_LO_W-1}:0] X_lo;")
    A(f"    logic signed   [{Y_HI_W-1}:0] Y_hi;")
    A(f"    logic unsigned [{Y_LO_W-1}:0] Y_lo;")
    A("")
    A(f"    assign X_hi = X[{X_W-1}:{X_LO_W}];")
    A(f"    assign X_lo = X[{X_LO_W-1}:0];")
    A(f"    assign Y_hi = Y[{Y_W-1}:{Y_LO_W}];")
    A(f"    assign Y_lo = Y[{Y_LO_W-1}:0];")
    A("")

    # -------------------------------------------------------------- Y0Y1
    A("    // ---------------- Y0Y1 = Y_lo - Y_hi (fabric subtractor) --------")
    A(f"    logic signed [{Y0Y1_W-1}:0] Y0Y1;")
    A(f"    assign Y0Y1 = $signed({{2'b00, Y_lo}}) - $signed({{Y_hi[{Y_HI_W-1}], Y_hi}});")
    A("")
    if cfg["y0y1_ff"]:
        A("    // registered in fabric so the 24-bit subtractor gets its own stage")
        A(f"    logic signed [{Y0Y1_W-1}:0] Y0Y1_q;")
        _ff_block(o, [("Y0Y1_q", "Y0Y1")])
        b_mid = "Y0Y1_q"
    else:
        b_mid = "Y0Y1"

    # --------------------------------------------------------------- DSPs
    A("    // ---------------- DSP58 x3 ----------------")
    A("    logic signed [57:0] P_lo, PCOUT_lo, P_hi, P_mid;")
    A("")

    A(f"    // u_dsp_lo : X_lo * Y_lo   -> PCIN of u_dsp_mid   (latency {p['L_lo']})")
    _dsp_inst(A, "u_dsp_lo", [
        ("PREADD", '"FALSE"'), ("USEC", '"FALSE"'), ("USEPCIN", '"ZERO"'),
        ("PREADD_PIPE", 0), ("A_PIPE", cfg["lo_A"]), ("B_PIPE", p["lo_B"]),
        ("C_PIPE", 0), ("D_PIPE", 0),
        ("MULT_PIPE", cfg["lo_M"]), ("P_PIPE", cfg["lo_P"]),
    ], [
        ("clk", "clk"), ("reset", "reset"), ("in_valid", "1'b1"),
        ("A", "{12'b0, X_lo}"), ("B", "{2'b0, Y_lo}"),
        ("C", "58'b0"), ("D", "27'b0"), ("PCIN", "58'b0"),
        ("out_valid", ""), ("PCOUT", "PCOUT_lo"), ("P", "P_lo"),
    ])

    A(f"    // u_dsp_hi : X_hi * Y_hi   -> C of u_dsp_mid      (latency {p['L_hi']})")
    _dsp_inst(A, "u_dsp_hi", [
        ("PREADD", '"FALSE"'), ("USEC", '"FALSE"'), ("USEPCIN", '"ZERO"'),
        ("PREADD_PIPE", 0), ("A_PIPE", cfg["hi_A"]), ("B_PIPE", p["hi_B"]),
        ("C_PIPE", 0), ("D_PIPE", 0),
        ("MULT_PIPE", cfg["hi_M"]), ("P_PIPE", cfg["hi_P"]),
    ], [
        ("clk", "clk"), ("reset", "reset"), ("in_valid", "1'b1"),
        ("A", f"{{{{8{{X_hi[{X_HI_W-1}]}}}}, X_hi}}"),
        ("B", f"{{Y_hi[{Y_HI_W-1}], Y_hi}}"),
        ("C", "58'b0"), ("D", "27'b0"), ("PCIN", "58'b0"),
        ("out_valid", ""), ("PCOUT", ""), ("P", "P_hi"),
    ])

    A("    // u_dsp_mid: AD = X_hi - X_lo ; P_mid = P_hi + AD*Y0Y1 + P_lo")
    A(f"    //            = X_lo*Y_hi + X_hi*Y_lo            (ALU fires in cycle {p['L_M']})")
    _dsp_inst(A, "u_dsp_mid", [
        ("PREADD", '"TRUE"'), ("ADDAD", '"TRUE"'), ("PREADD_SUB", '"TRUE"'),
        ("USEC", '"TRUE"'), ("USEPCIN", '"PCIN"'),
        ("PREADD_PIPE", cfg["mid_AD"]), ("A_PIPE", cfg["mid_A"]),
        ("B_PIPE", cfg["mid_B"]), ("C_PIPE", cfg["mid_C"]),
        ("D_PIPE", p["mid_D"]), ("MULT_PIPE", 1), ("P_PIPE", cfg["mid_P"]),
        ("NEG_C", '"FALSE"'), ("NEG_PCIN", '"FALSE"'), ("NEG_M", '"FALSE"'),
    ], [
        ("clk", "clk"), ("reset", "reset"), ("in_valid", "1'b1"),
        ("A", "{12'b0, X_lo}"), ("B", b_mid),
        ("C", "P_hi"), ("D", f"{{X_hi[{X_HI_W-1}], X_hi}}"), ("PCIN", "PCOUT_lo"),
        ("out_valid", ""), ("PCOUT", ""), ("P", "P_mid"),
    ])

    # ------------------------------------------------------------ alignment
    A("    // ---------------- operand alignment ----------------")
    A(f"    //   P_hi is ready in cycle {p['L_hi']}, P_lo in cycle {p['L_lo']},")
    A(f"    //   the adder needs both in cycle {p['out']}.")
    A("")

    def chain(w, base, src, depth, pairs):
        """Emit `depth` FFs named base_d1..base_dN, return the final name.

        depth==0 used to just return `src` verbatim -- fine as a plain RHS,
        but the caller re-indexes the tap afterwards (`lo_al[hi:lo]` for a
        sub-slice), which is illegal Verilog when `src` is itself already a
        range-select: `P_lo[43:0]` re-indexed as `P_lo[43:0][43:22]` is
        "range is not allowed in a prefix", not valid syntax.  So depth==0
        now materializes a plain wire instead of handing the raw expression
        back -- same value, but always safely indexable."""
        if depth == 0:
            tap0 = f"{base}_d0"
            A(f"    logic [{w-1}:0] {tap0};")
            A(f"    assign {tap0} = {src};")
            return tap0
        for i in range(1, depth + 1):
            A(f"    logic [{w-1}:0] {base}_d{i};")
            pairs.append((f"{base}_d{i}", src if i == 1 else f"{base}_d{i-1}"))
        return f"{base}_d{depth}"

    pairs = []
    hi_al = chain(P_HI_W, "P_hi_al", f"P_hi[{P_HI_W-1}:0]", p["hi_dly"], pairs)
    lo_al = chain(P_LO_W, "P_lo_al", f"P_lo[{P_LO_W-1}:0]", p["lo_dly"], pairs)
    A("")
    _ff_block(o, pairs)

    # ------------------------------------------------------------- operands
    A("    // ---------------- 71-bit addition ----------------")
    A(f"    //   op1 = {{P_hi[{P_HI_W-1}:0], P_lo[{P_LO_W-1}:{LOW_W}]}}   "
      f"({P_HI_W} + {P_LO_W-LOW_W} = {ADD_W}, no overlap -> free concatenation)")
    A("    //   op2 = P_mid sign-extended from 58 to 71")
    A(f"    logic [{ADD_W-1}:0] add_op1, add_op2;")
    A(f"    assign add_op1 = {{{hi_al}, {lo_al}[{P_LO_W-1}:{LOW_W}]}};")
    A(f"    assign add_op2 = {{{{13{{P_mid[57]}}}}, P_mid}};")
    A("")

    # -------------------------------------------------------------- segments
    seg_out = []
    for s in p["seg"]:
        i, w, lsb, d = s["i"], s["w"], s["lsb"], s["in_dly"]
        A(f"    // segment {i}: bits [{lsb+w-1}:{lsb}] of the sum"
          f"   (operands wait {d}, result waits {s['out_dly']})")
        A(f"    logic [{w-1}:0] s{i}_op1, s{i}_op2;")
        if d == 0:
            A(f"    assign s{i}_op1 = add_op1[{lsb+w-1}:{lsb}];")
            A(f"    assign s{i}_op2 = add_op2[{lsb+w-1}:{lsb}];")
        else:
            q = []
            for j in range(1, d + 1):
                A(f"    logic [{w-1}:0] s{i}_op1_d{j}, s{i}_op2_d{j};")
                q.append((f"s{i}_op1_d{j}",
                          f"add_op1[{lsb+w-1}:{lsb}]" if j == 1 else f"s{i}_op1_d{j-1}"))
                q.append((f"s{i}_op2_d{j}",
                          f"add_op2[{lsb+w-1}:{lsb}]" if j == 1 else f"s{i}_op2_d{j-1}"))
            A("")
            _ff_block(o, q)
            A(f"    assign s{i}_op1 = s{i}_op1_d{d};")
            A(f"    assign s{i}_op2 = s{i}_op2_d{d};")

        carry_slice = (
            "1'b0" if i == 0 else
            f"s{i-1}_q[{p['seg'][i-1]['w']}]"
        )
        carry = f"{w+1}'({carry_slice})"
        A(f"    logic [{w}:0] s{i}_res, s{i}_q;   // [{w}] = carry out")
        A(f"    assign s{i}_res = {{1'b0, s{i}_op1}} + {{1'b0, s{i}_op2}} + {carry};")
        _ff_block(o, [(f"s{i}_q", f"s{i}_res")])

        if s["out_dly"]:
            q2 = []
            for j in range(1, s["out_dly"] + 1):
                A(f"    logic [{w-1}:0] s{i}_sum_d{j};")
                q2.append((f"s{i}_sum_d{j}",
                           f"s{i}_q[{w-1}:0]" if j == 1 else f"s{i}_sum_d{j-1}"))
            A("")
            _ff_block(o, q2)
            seg_out.append(f"s{i}_sum_d{s['out_dly']}")
        else:
            seg_out.append(f"s{i}_q[{w-1}:0]")

    # ------------------------------------------------------------- P[21:0]
    A(f"    // ---------------- P[{LOW_W-1}:0] : straight out of X_lo*Y_lo ----------------")
    pairs = []
    low_al = chain(LOW_W, "P_low_al", f"P_lo[{LOW_W-1}:0]", p["low_dly"], pairs)
    A("")
    _ff_block(o, pairs)

    # -------------------------------------------------------------- assembly
    A("    // ---------------- result assembly ----------------")
    A(f"    logic [{ADD_W-1}:0] P_92_22;")
    A("    assign P_92_22 = {" + ", ".join(reversed(seg_out)) + "};")
    A(f"    assign P = {{P_92_22, {low_al}}};")
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
    A("endmodule")

    text = "\n".join(o) + "\n"
    lint_sv(text)

    os.makedirs(outdir, exist_ok=True)
    path = os.path.join(outdir, name + ".sv")
    with open(path, "w") as f:
        f.write(text)
    return path
