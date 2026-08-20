"""
dsp_rtl_gen.py -- turn a config dict from dsp_model.py into a .sv file.

Rules this generator follows:
  * it does NOT make timing decisions -- everything comes from `cfg`
  * the output contains no `generate`, no `if`, no genvar: what you read is
    the actual circuit
  * signal names carry the DSP index, so a timing report name maps straight
    back to a line in the file
"""

import json
import os

PITCH = 23          # fixed by the DSP58 PCIN>>>23 cascade
B_PORT = 24
A_WIDTH = 27
TOP_WIDTH = A_WIDTH + B_PORT        # 51

DSP_AB_MAX = 2       # AREG/BREG: DSP58 has at most 2 pipeline stages each


# ===========================================================================
# helpers
# ===========================================================================
def group_of(sizes):
    """sizes=[3,3,3,3] -> [0,0,0,1,1,1,2,2,2,3,3,3]"""
    g = []
    for gi, n in enumerate(sizes):
        g += [gi] * n
    return g


def chain_plan(cfg, L):
    """Everything the generator needs, derived once so the RTL and the
       comments can never disagree."""
    a, ad, m = cfg["A_PIPE"], cfg["PREADD_PIPE"], cfg["MULT_PIPE"]
    sizes = cfg["sizes"]
    preg_at = set(cfg["preg_at"])
    g = group_of(sizes)
    g_max = len(sizes) - 1

    plan = {
        "L": L,
        "a": a, "ad": ad, "m": m,
        "b": a + ad,                       # BREG must match the A side
        "d": a if ad else 0,               # DREG only matters with the preadder
        "L_in": a + ad + m,                # DSP stages before the ALU
        "sizes": sizes,
        "g": g,
        "g_max": g_max,
        "G": len(sizes),
        "preg": [1 if k in preg_at else 0 for k in range(L)],
        "latency": a + ad + m + len(sizes),
    }
    plan["out_dly"] = [
        (g_max - g[k]) if plan["preg"][k] else (1 + g_max - g[k])
        for k in range(L)
    ]
    plan["in_dly"] = [g[k] for k in range(L)]      # X and B slice skew

    # Every DSP in group `gi` needs its A/B operands held back `a + gi`
    # cycles before they reach the multiplier (the global `a` every DSP
    # already pays, plus `gi` cycles of group skew).  Up to DSP_AB_MAX of
    # that can live in the DSP's own AREG/BREG instead of a fabric FF chain
    # -- BREG must still equal AREG + PREADD_PIPE cycles (see plan["b"]),
    # which caps how much AREG room a nonzero preadder leaves.
    a_pipe_g = [min(a + gi, DSP_AB_MAX - ad) for gi in range(len(sizes))]
    ext_g = [(a + gi) - a_pipe_g[gi] for gi in range(len(sizes))]
    plan["a_pipe"] = [a_pipe_g[g[k]] for k in range(L)]   # per-DSP A_PIPE
    plan["b_pipe"] = [a_pipe_g[g[k]] + ad for k in range(L)]  # per-DSP B_PIPE
    plan["ext_dly"] = [ext_g[g[k]] for k in range(L)]     # fabric FF stages left
    return plan


def verify_chain_plan(p):
    """
    Cycle accounting.  This is the whole point of generating instead of
    parameterising: an alignment mistake becomes a Python exception here
    rather than a wrong number in simulation three days from now.
    """
    L, L_in, lat = p["L"], p["L_in"], p["latency"]

    # 1. cascade: DSP k's PCIN must land in the same cycle as its own product
    for k in range(1, L):
        want = p["in_dly"][k]
        have = p["in_dly"][k - 1] + p["preg"][k - 1]
        if want != have:
            raise ValueError(
                f"DSP{k}: PCIN arrives in cycle {have + L_in}, "
                f"but its own M is ready in cycle {want + L_in}")

    # 2. every output slice must reach the final assembly in the same cycle
    for k in range(L):
        got = p["in_dly"][k] + L_in + p["preg"][k] + p["out_dly"][k]
        if got != lat:
            raise ValueError(
                f"DSP{k}: low slice lands in cycle {got}, expected {lat}")

    # 3. only the last DSP of a group may carry a PREG
    base = 0
    for n in p["sizes"]:
        for i, k in enumerate(range(base, base + n)):
            if p["preg"][k] != (1 if i == n - 1 else 0):
                raise ValueError(f"DSP{k}: PREG must sit on the last DSP of its group")
        base += n

    # 4. AREG/BREG absorption must not change what the multiplier sees, and
    #    must stay inside the DSP58's physical AREG/BREG stage count.
    for k in range(L):
        if p["ext_dly"][k] + p["a_pipe"][k] != p["a"] + p["in_dly"][k]:
            raise ValueError(f"DSP{k}: absorbed skew changes A arrival cycle")
        if p["b_pipe"][k] != p["a_pipe"][k] + p["ad"]:
            raise ValueError(f"DSP{k}: B_PIPE must track A_PIPE + PREADD_PIPE")
        if p["a_pipe"][k] > 2 or p["b_pipe"][k] > 2:
            raise ValueError(f"DSP{k}: AREG/BREG exceeds the DSP58's 2-stage limit")
    return True


def lint_sv(text):
    """Cheap structural check on the emitted file (comments stripped first)."""
    code = "\n".join(l.split("//")[0] for l in text.splitlines())
    toks = code.replace("(", " ( ").replace(")", " ) ").split()
    if toks.count("begin") != toks.count("end"):
        raise ValueError("begin/end mismatch in generated RTL")
    if toks.count("(") != toks.count(")"):
        raise ValueError("paren mismatch in generated RTL")
    if toks.count("module") != 1 or toks.count("endmodule") != 1:
        raise ValueError("module/endmodule mismatch in generated RTL")
    return True


def _ff_block(lines, pairs, indent="    "):
    """Emit one pipeline/shift always_ff from a list of (dst, src) pairs.

    No reset, on purpose.  Everything _ff_block emits across dsp_rtl_gen /
    k2_rtl_gen / k3_rtl_gen / t25_rtl_gen is pure feed-forward datapath
    alignment (input skew, output de-skew, segment-adder pipeline stages) --
    never state whose correctness depends on being zero at reset.  The
    separate, hand-written valid_sr shift register (see each gen_*'s own
    "valid" block) is what actually needs and keeps a real reset; every
    consumer of this data only trusts it once out_valid says so, same as
    delay_line/sub_signed/SmallMult elsewhere in this toolchain already do.

    A synchronous reset here blocks Vivado from inferring SRL16E (that
    primitive has no reset pin): it pulls the last stage out as a real FDRE
    and ANDs every earlier stage's input with ~reset via an extra LUT2 per
    bit per stage instead.  On a design with nine 11-DSP chains this showed
    up as ~2290 extra "LUT as Logic" cells a plain SRL chain wouldn't need."""
    if not pairs:
        return
    lines.append(indent + "always_ff @(posedge clk) begin")
    for dst, src in pairs:
        lines.append(indent + f"    {dst} <= {src};")
    lines.append(indent + "end")
    lines.append("")


# ===========================================================================
# DSPChain
# ===========================================================================
def gen_dsp_chain(cfg, L, result=None, outdir=".", module=None):
    """Generate one DSPChain .sv (L cascaded DSP58s) from a config dict
    produced by dsp_model.best_chain/dsp_chain, and write it to `outdir`.
    Returns the written file's path."""
    p = chain_plan(cfg, L)
    verify_chain_plan(p)
    lat = p["latency"]
    name = module or f"DSPChain_L{L}_lat{lat}"

    y_msb = PITCH * L
    p_msb = PITCH * L + 27
    nm = lambda k: f"{k:02d}"

    o = []
    A = o.append

    # ---------------------------------------------------------------- banner
    A("`timescale 1ns / 1ps")
    A("")
    A("//" + "=" * 75)
    A(f"// {name}")
    A("//")
    A("//   GENERATED by dsp_rtl_gen.py -- do not edit by hand.")
    A("//   Regenerate instead:  gen_dsp_chain(best_chain(%d, %d), %d)" % (lat, L, L))
    A("//")
    A("//   config    : " + json.dumps({k: cfg[k] for k in
        ("A_PIPE", "PREADD_PIPE", "MULT_PIPE", "PREADD", "groups", "sizes", "preg_at")}))
    if result:
        A("//   predicted : %.3f ns  /  %.0f MHz" %
          (result["critical_ns"], result["fmax_mhz"]))
        A("//   critical  : " + result["critical"][0])
    A("//")
    A(f"//   L = {L}   latency = {lat}   ( {p['a']}+{p['ad']}+{p['m']} DSP stages"
      f" + {p['G']} PREG groups )")
    A("//")
    A("//   group  DSPs        PREG on   skew   A/B_PIPE   fabric skew   low-slice skew out")
    base = 0
    for gi, n in enumerate(p["sizes"]):
        ks = list(range(base, base + n))
        pk = [k for k in ks if p["preg"][k]]
        A("//   %-6d %-11s %-9s %-6d %-10s %-13d %s" % (
            gi, f"{ks[0]}..{ks[-1]}", str(pk[0]) if pk else "-", gi,
            f"{p['a_pipe'][ks[0]]}/{p['b_pipe'][ks[0]]}", p["ext_dly"][ks[0]],
            ",".join(str(p["out_dly"][k]) for k in ks)))
        base += n
    A("//" + "=" * 75)
    A("")

    # ----------------------------------------------------------------- ports
    A(f"module {name} (")
    A("    input  logic                clk,")
    A("    input  logic                reset,")
    A("    input  logic                in_valid,")
    A(f"    input  logic signed [{A_WIDTH-1}:0]   X,")
    A(f"    input  logic signed [{y_msb}:0]  Y,")
    A("")
    A("    output logic                out_valid,")
    A(f"    output logic signed [{p_msb}:0]  P")
    A(");")
    A("")

    # ------------------------------------------------------------- A operand
    A("    // ---------------- A operand ----------------")
    A("    logic signed [33:0] a_ext;")
    A(f"    assign a_ext = {{{{{34-A_WIDTH}{{X[{A_WIDTH-1}]}}}}, X}};")
    A("")

    # -------------------------------------------------------- raw B slices
    A("    // ---------------- Y decomposition ----------------")
    A(f"    //   slice 0..{L-2} : {PITCH}-bit unsigned, zero-extended to {B_PORT}")
    A(f"    //   slice {L-1}      : {B_PORT}-bit signed (carries the sign of Y)")
    for k in range(L):
        A(f"    logic [{B_PORT-1}:0] b_raw{nm(k)};")
    A("")
    for k in range(L):
        if k == L - 1:
            A(f"    assign b_raw{nm(k)} = Y[{PITCH*k} +: {B_PORT}];")
        else:
            pad = ("1'b0" if B_PORT - PITCH == 1
                   else f"{{{B_PORT-PITCH}{{1'b0}}}}")
            A(f"    assign b_raw{nm(k)} = {{{pad}, Y[{PITCH*k} +: {PITCH}]}};")
    A("")

    # ------------------------------------------------------------- X/B skew
    ext_max = max(p["ext_dly"]) if L else 0
    A("    // ---------------- input skew ----------------")
    A(f"    //   DSP k sees X and its B slice {p['G']} group(s) deep:")
    A("    //   group g starts one cycle after group g-1, so both operands")
    A("    //   for a DSP in group g must be held back by a + g cycles before")
    A("    //   the multiplier.  Up to %d of those cycles are absorbed into" % DSP_AB_MAX)
    A("    //   that DSP's own AREG/BREG (see A_PIPE/B_PIPE below) instead of")
    A("    //   a fabric FF chain; only the remainder is built here.")
    if ext_max == 0:
        A("    //   (fully absorbed inside the DSPs: no fabric skew needed)")
        A("")
        x_of = {0: "a_ext"}
        b_of = {k: f"b_raw{nm(k)}" for k in range(L)}
    else:
        A("")
        for d in range(1, ext_max + 1):
            A(f"    logic signed [33:0] a_ext_d{d};")
        A("")
        _ff_block(o, [(f"a_ext_d{d}", "a_ext" if d == 1 else f"a_ext_d{d-1}")
                      for d in range(1, ext_max + 1)])
        x_of = {0: "a_ext"}
        for d in range(1, ext_max + 1):
            x_of[d] = f"a_ext_d{d}"

        pairs, b_of = [], {}
        for k in range(L):
            d = p["ext_dly"][k]
            b_of[k] = f"b_raw{nm(k)}" if d == 0 else f"b{nm(k)}_d{d}"
            for i in range(1, d + 1):
                A(f"    logic [{B_PORT-1}:0] b{nm(k)}_d{i};")
                pairs.append((f"b{nm(k)}_d{i}",
                              f"b_raw{nm(k)}" if i == 1 else f"b{nm(k)}_d{i-1}"))
        if pairs:
            A("")
            _ff_block(o, pairs)

    # ------------------------------------------------------------ DSP chain
    A("    // ---------------- DSP58 cascade ----------------")
    for k in range(L):
        A(f"    logic [57:0] dsp_p{nm(k)};")
        A(f"    logic [57:0] dsp_pcout{nm(k)};")
    A("")

    for k in range(L):
        usepcin = "ZERO" if k == 0 else "PCIN_SHIFT23"
        pcin = "58'b0" if k == 0 else f"dsp_pcout{nm(k-1)}"
        A(f"    // DSP {k}  (group {p['g'][k]}, PREG={p['preg'][k]})")
        A("    DSP58Block #(")
        A(f"        .PREADD      (\"{cfg['PREADD']}\"),")
        A("        .ADDAD       (\"TRUE\"),")
        A("        .PREADD_SUB  (\"FALSE\"),")
        A("        .USEC        (\"FALSE\"),")
        A(f"        .USEPCIN     (\"{usepcin}\"),")
        A(f"        .PREADD_PIPE ({p['ad']}),")
        A(f"        .A_PIPE      ({p['a_pipe'][k]}),")
        A(f"        .B_PIPE      ({p['b_pipe'][k]}),")
        A("        .C_PIPE      (0),")
        A(f"        .D_PIPE      ({p['d']}),")
        A(f"        .MULT_PIPE   ({p['m']}),")
        A(f"        .P_PIPE      ({p['preg'][k]})")
        A(f"    ) u_dsp{nm(k)} (")
        A("        .clk       (clk),")
        A("        .reset     (reset),")
        A("        .in_valid  (1'b1),")
        A("")
        A(f"        .A         ({x_of[p['ext_dly'][k]]}),")
        A(f"        .B         ({b_of[k]}),")
        A("        .C         (58'b0),")
        A("        .D         (27'b0),")
        A(f"        .PCIN      ({pcin}),")
        A("")
        A("        .out_valid (),")
        A(f"        .PCOUT     (dsp_pcout{nm(k)}),")
        A(f"        .P         (dsp_p{nm(k)})")
        A("    );")
        A("")

    # -------------------------------------------------------- output de-skew
    A("    // ---------------- output alignment ----------------")
    A("    //   DSP k finishes at the end of its group's cycle, the tail")
    A("    //   finishes last, so every low slice waits for the tail.")
    A("")
    pairs, low_of = [], {}
    for k in range(L - 1):
        d = p["out_dly"][k]
        src = f"dsp_p{nm(k)}[{PITCH-1}:0]"
        if d == 0:
            low_of[k] = src
            continue
        for i in range(1, d + 1):
            A(f"    logic [{PITCH-1}:0] low{nm(k)}_d{i};")
            pairs.append((f"low{nm(k)}_d{i}", src if i == 1 else f"low{nm(k)}_d{i-1}"))
        low_of[k] = f"low{nm(k)}_d{d}"
    A("")
    _ff_block(o, pairs)

    tail = L - 1
    if p["out_dly"][tail] != 0:
        raise ValueError("tail DSP must be the last PREG group (out_dly != 0)")

    # -------------------------------------------------------------- assembly
    A("    // ---------------- result assembly ----------------")
    A("    always_comb begin")
    A("        P = '0;")
    for k in range(L - 1):
        A(f"        P[{PITCH*k} +: {PITCH}] = {low_of[k]};")
    A(f"        P[{PITCH*tail} +: {TOP_WIDTH}] = dsp_p{nm(tail)}[{TOP_WIDTH-1}:0];")
    A("    end")
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