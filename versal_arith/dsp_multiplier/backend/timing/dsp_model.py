"""
dsp_model.py -- the timing model.

Two data structures, that is all:

  stage  = (name, delay_ns)          one register-to-register path
  result = dict with keys:
             "latency"     int
             "config"      dict, what to set in the RTL
             "stages"      list of stage, every path in the design
             "critical_ns" float, the slowest stage
             "critical"    stage, which one it was
             "fmax_mhz"    float
"""

from .dsp_lib import D

NEG_INF = float("-inf")


# ===========================================================================
# small helpers
# ===========================================================================
def fmax_mhz(critical_ns):
    """Convert a critical path (ns) to an Fmax figure (MHz), clock uncertainty included."""
    return 1000.0 / (critical_ns + D["CLK_UNCERTAINTY"])


def summarize(stages, latency, config):
    """Turn a list of stages into a result dict."""
    critical = max(stages, key=lambda s: s[1])
    return {
        "latency": latency,
        "config": config,
        "stages": stages,
        "critical_ns": critical[1],
        "critical": critical,
        "fmax_mhz": fmax_mhz(critical[1]),
    }


def _m_start(a_pipe, ad_pipe, m_pipe):
    """
    Arrival time of V_DATA, i.e. when the product A*B reaches the ALU input,
    counted from whatever clock edge launched it.
    """
    if m_pipe:
        return D["TCO_MREG"]
    t = D["A2A1_TO_V"] + D["V_TO_VDATA"]
    if ad_pipe:
        return D["TCO_ADREG"] + t
    t += D["A2DATA_TO_A2A1"]
    if a_pipe:
        return D["TCO_AREG"] + t
    return D["FF_CLK_Q"] + D["ROUTE_FF_TO_A"] + D["A_TO_A2DATA"] + t


def _input_stages(a_pipe, ad_pipe, m_pipe, prefix=""):
    """Every stage on the A/B side, up to and including MREG."""
    stages = []

    if a_pipe >= 1:
        stages.append((prefix + "fabric FF -> AREG",
                       D["FF_CLK_Q"] + D["ROUTE_FF_TO_A"] + D["T_SU_DSP"]))
    if a_pipe == 2:
        stages.append((prefix + "AREG1 -> AREG2",
                       D["TCO_AREG"] + D["T_SU_DSP"]))

    if ad_pipe:
        head = (D["TCO_AREG"] if a_pipe
                else D["FF_CLK_Q"] + D["ROUTE_FF_TO_A"] + D["A_TO_A2DATA"])
        stages.append((prefix + "-> ADREG (preadder)",
                       head + D["PREADD_ACTIVE"] + D["T_SU_DSP"]))

    if m_pipe:
        if ad_pipe:
            head = D["TCO_ADREG"]
        elif a_pipe:
            head = D["TCO_AREG"] + D["A2DATA_TO_A2A1"]
        else:
            head = (D["FF_CLK_Q"] + D["ROUTE_FF_TO_A"]
                    + D["A_TO_A2DATA"] + D["A2DATA_TO_A2A1"])
        stages.append((prefix + "-> MREG (array)",
                       head + D["A2A1_TO_V"] + D["T_SU_DSP"]))

    return stages


# ===========================================================================
# SingleDSP
# ===========================================================================
def single_dsp(a_pipe, ad_pipe, m_pipe, p_pipe):
    """Timing result for one DSP58 with the given pipeline-register configuration."""
    stages = _input_stages(a_pipe, ad_pipe, m_pipe)

    m = _m_start(a_pipe, ad_pipe, m_pipe)
    aluout = m + D["ALUMUX_Y"] + D["ALUADD_Y"]

    if p_pipe:
        stages.append(("-> PREG (ALU)", aluout + D["T_SU_DSP"]))
        stages.append(("PREG -> fabric FF",
                       D["TCO_PREG_P"] + D["ROUTE_P_TO_FF"] + D["T_SU_FF"]))
    else:
        stages.append(("-> fabric FF (P combinational)",
                       aluout + D["ALUOUT_TO_P"]
                       + D["ROUTE_P_TO_FF"] + D["T_SU_FF"]))

    config = {"A_PIPE": a_pipe, "PREADD_PIPE": ad_pipe,
              "MULT_PIPE": m_pipe, "P_PIPE": p_pipe,
              "PREADD": "TRUE" if ad_pipe else "FALSE"}
    return summarize(stages, a_pipe + ad_pipe + m_pipe + p_pipe, config)


def best_single(budget):
    """Cheapest critical path reachable with latency <= budget."""
    best = None
    for a in (0, 1, 2):
        for ad in (0, 1):
            for m in (0, 1):
                for p in (0, 1):
                    if a + ad + m + p > budget:
                        continue
                    r = single_dsp(a, ad, m, p)
                    key = (round(r["critical_ns"], 6), r["latency"])
                    if best is None or key < best[0]:
                        best = (key, r)
    return best[1]


# ===========================================================================
# DSPChain
# ===========================================================================
def group_sizes(L, G):
    """Split L DSPs into G groups, as evenly as possible, head group biggest."""
    base, rem = divmod(L, G)
    return [base + 1] * rem + [base] * (G - rem)


def preg_positions(sizes):
    """Index k of the DSP that carries the PREG, one per group."""
    pos, k = [], -1
    for n in sizes:
        k += n
        pos.append(k)
    return pos


def dsp_chain(a_pipe, ad_pipe, m_pipe, groups, L=12):
    """Timing result for an L-DSP PCIN cascade split into `groups` register groups."""
    stages = _input_stages(a_pipe, ad_pipe, m_pipe)
    sizes = group_sizes(L, groups)
    m = _m_start(a_pipe, ad_pipe, m_pipe)

    for g, n in enumerate(sizes):
        # group 0 has no PCIN (head DSP ties Z to zero)
        pcin = None if g == 0 else D["TCO_PREG_PCOUT"] + D["ROUTE_CASCADE"]

        for i in range(n):
            via_m = m + D["ALUMUX_Y"] + D["ALUADD_Y"]
            via_z = NEG_INF if pcin is None else (pcin + D["ALUMUX_Z"]
                                                  + D["ALUADD_Z"])
            aluout = max(via_m, via_z)

            if i == n - 1:                      # this DSP owns the PREG
                stages.append((f"group{g} (N={n}) -> PREG",
                               aluout + D["T_SU_DSP"]))
            else:                               # no PREG: low slice -> fabric
                stages.append((f"group{g} DSP{i} P -> fabric FF",
                               aluout + D["ALUOUT_TO_P"]
                               + D["ROUTE_P_TO_FF"] + D["T_SU_FF"]))
                pcin = aluout + D["ALUOUT_TO_PCOUT"] + D["ROUTE_CASCADE"]

    stages.append(("PREG -> fabric FF",
                   D["TCO_PREG_P"] + D["ROUTE_P_TO_FF"] + D["T_SU_FF"]))

    config = {"A_PIPE": a_pipe, "PREADD_PIPE": ad_pipe, "MULT_PIPE": m_pipe,
              "PREADD": "TRUE" if ad_pipe else "FALSE",
              "groups": groups, "sizes": sizes,
              "preg_at": preg_positions(sizes)}
    return summarize(stages, a_pipe + ad_pipe + m_pipe + groups, config)


def best_chain(budget, L=12):
    """Cheapest critical path reachable with latency <= budget. None if too small."""
    best = None
    for a in (0, 1):
        for ad in (0, 1):
            for m in (0, 1):
                for g in range(1, L + 1):
                    if a + ad + m + g > budget:
                        continue
                    r = dsp_chain(a, ad, m, g, L)
                    key = (round(r["critical_ns"], 6), r["latency"])
                    if best is None or key < best[0]:
                        best = (key, r)
    return best[1] if best else None

# ===========================================================================
# Karatsuba 2x2
# ===========================================================================
from .dsp_lib import K2W


def carry_chain_ns(width):
    """Versal fabric carry chain, `width` bits wide, LSB to MSB."""
    n = max(1, -(-width // D["CARRY_BITS"]))          # ceil, number of LOOKAHEAD8
    t = D["CARRY_ENTRY"] + D["CARRY_FIRST"]
    if n >= 2:
        t += (n - 2) * D["CARRY_STEP"] + D["CARRY_STEP"]
    t += D["CARRY_LAST_NET"] + D["CARRY_EXIT"]
    return t


def _seg_widths(total, split):
    """Cut the adder into `split` segments, as evenly as possible."""
    base, rem = divmod(total, split)
    return [base + 1] * rem + [base] * (split - rem)


def _plain_dsp_branch(prefix, a_pipe, m_pipe, p_pipe):
    """lo / hi: a plain A*B DSP. Returns (stages, P_start, PCOUT_start)."""
    stages = _input_stages(a_pipe, 0, m_pipe, prefix)
    aluout = _m_start(a_pipe, 0, m_pipe) + D["ALUMUX_Y"] + D["ALUADD_Y"]
    if p_pipe:
        stages.append((prefix + "-> PREG", aluout + D["T_SU_DSP"]))
        return stages, D["TCO_PREG_P"], D["TCO_PREG_PCOUT"]
    return stages, aluout + D["ALUOUT_TO_P"], aluout + D["ALUOUT_TO_PCOUT"]


def k2_latency(cfg):
    """(L_lo, L_hi, L_M, total)  -- mid MREG is always on, see check_k2."""
    L_lo = cfg["lo_A"] + cfg["lo_M"] + cfg["lo_P"]
    L_hi = cfg["hi_A"] + cfg["hi_M"] + cfg["hi_P"]
    L_M = cfg["mid_A"] + cfg["mid_AD"] + 1
    return L_lo, L_hi, L_M, L_M + cfg["mid_P"] + cfg["split"]


def check_k2(cfg):
    """Alignment rules. Anything that fails here is functionally WRONG."""
    L_lo, L_hi, L_M, _ = k2_latency(cfg)
    if L_lo != L_M:                                        # PCIN has no register
        return False
    if L_hi + cfg["mid_C"] != L_M:                         # C branch
        return False
    if cfg["y0y1_ff"] + cfg["mid_B"] != cfg["mid_A"] + cfg["mid_AD"]:
        return False                                       # B side must match A side
    if cfg["mid_A"] > 1:                                   # DREG max is 1, v1: no fabric FF on X_hi
        return False
    return True


def k2_cost(cfg):
    """Extra fabric FFs the configuration needs. Returns a dict."""
    L_lo, L_hi, L_M, _ = k2_latency(cfg)
    out = L_M + cfg["mid_P"]
    ff = {
        "P_hi align": (out - L_hi) * K2W["P_HI_BITS"],
        "P_lo align": (out - L_lo) * K2W["P_LO_BITS"],
        "Y0Y1 reg":   cfg["y0y1_ff"] * K2W["Y0Y1_BITS"],
    }
    n = 0
    widths = _seg_widths(K2W["ADD_WIDTH"], cfg["split"])
    for i, w in enumerate(widths):
        n += i * 2 * w + (cfg["split"] - 1 - i) * w        # operands in, results out
    ff["adder split"] = n + (cfg["split"] - 1)             # + carry bits
    ff["total"] = sum(ff.values())
    return ff


def karatsuba2(cfg):
    """Timing result for one Karatsuba-2 (3-DSP) configuration `cfg`."""
    stages = []

    # ---- lo and hi -------------------------------------------------------
    s, _, pcout_lo = _plain_dsp_branch("lo: ", cfg["lo_A"], cfg["lo_M"], cfg["lo_P"])
    stages += s
    s, p_hi, _ = _plain_dsp_branch("hi: ", cfg["hi_A"], cfg["hi_M"], cfg["hi_P"])
    stages += s

    # ---- mid, A/D side (preadder X_hi - X_lo) ----------------------------
    stages += _input_stages(cfg["mid_A"], cfg["mid_AD"], 1, "mid A/D: ")

    # ---- mid, B side (Y0Y1 subtractor in fabric) -------------------------
    start = D["FF_CLK_Q"]
    t = D["ROUTE_FF_TO_LUT"] + carry_chain_ns(K2W["Y0Y1_BITS"])
    if cfg["y0y1_ff"]:
        stages.append(("mid B: fabric FF -> Y0Y1 FF", start + t + D["T_SU_FF"]))
        start, t = D["FF_CLK_Q"], 0.0
    t += D["ROUTE_FF_TO_A"]
    if cfg["mid_B"] >= 1:
        stages.append(("mid B: Y0Y1 -> BREG", start + t + D["T_SU_DSP"]))
        start, t = D["TCO_BREG"], 0.0
    if cfg["mid_B"] == 2:
        stages.append(("mid B: BREG1 -> BREG2", D["TCO_BREG"] + D["T_SU_DSP"]))
        start, t = D["TCO_BREG"], 0.0
    stages.append(("mid B: -> MREG", start + t + D["B_TO_V"] + D["T_SU_DSP"]))

    # ---- the three paths that reconverge on mid's ALU --------------------
    via_z = pcout_lo + D["ROUTE_CASCADE"] + D["ALUMUX_Z"] + D["ALUADD_Z"]
    via_m = D["TCO_MREG"] + D["ALUMUX_Y"] + D["ALUADD_Y"]
    if cfg["mid_C"]:
        stages.append(("mid C: hi.P -> CREG", p_hi + D["ROUTE_P_TO_C"] + D["T_SU_DSP"]))
        via_c = D["TCO_CREG"] + D["ALUMUX_W"] + D["ALUADD_W"]
    else:
        via_c = (p_hi + D["ROUTE_P_TO_C"] + D["C_TO_CDATA"]
                 + D["ALUMUX_W"] + D["ALUADD_W"])
    aluout = max(via_c, via_z, via_m)

    if cfg["mid_P"]:
        stages.append(("mid: -> PREG", aluout + D["T_SU_DSP"]))
        p_mid = D["TCO_PREG_P"]
    else:
        p_mid = aluout + D["ALUOUT_TO_P"]

    # ---- final 71-bit fabric adder ---------------------------------------
    L_lo, L_hi, L_M, total = k2_latency(cfg)
    out = L_M + cfg["mid_P"]
    # op1 comes from P_hi / P_lo, straight out of the DSP if no align FF is needed
    op1 = D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"]
    if out == L_hi or out == L_lo:
        op1 = max(op1, D["TCO_PREG_P"] + D["ROUTE_P_TO_FF"])

    for i, w in enumerate(_seg_widths(K2W["ADD_WIDTH"], cfg["split"])):
        src = (max(p_mid + D["ROUTE_P_TO_FF"], op1) if i == 0
               else D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"])
        stages.append((f"adder seg{i} ({w} bit) -> FF",
                       src + carry_chain_ns(w) + D["T_SU_FF"]))

    r = summarize(stages, total, dict(cfg))
    r["cost"] = k2_cost(cfg)
    return r


def best_k2(budget):
    """Cheapest Karatsuba-2 critical path reachable with latency <= budget,
    searching every legal pipeline-register configuration. v1: mid MREG
    forced on, no fabric FF on X_hi, adder split <= 2."""
    best = None
    for lo_A in (0, 1):
     for lo_M in (0, 1):
      for lo_P in (0, 1):
       for hi_A in (0, 1):
        for hi_M in (0, 1):
         for hi_P in (0, 1):
          for mid_A in (0, 1):
           for mid_AD in (0, 1):
            for mid_C in (0, 1):
             for mid_P in (0, 1):
              for mid_B in (0, 1, 2):
               for y0y1 in (0, 1):
                for split in (1, 2):
                 cfg = {"lo_A": lo_A, "lo_M": lo_M, "lo_P": lo_P,
                        "hi_A": hi_A, "hi_M": hi_M, "hi_P": hi_P,
                        "mid_A": mid_A, "mid_AD": mid_AD, "mid_C": mid_C,
                        "mid_P": mid_P, "mid_B": mid_B, "y0y1_ff": y0y1,
                        "split": split}
                 if not check_k2(cfg):
                     continue
                 if k2_latency(cfg)[3] > budget:
                     continue
                 r = karatsuba2(cfg)
                 key = (round(r["critical_ns"], 6), r["latency"],
                        r["cost"]["total"])
                 if best is None or key < best[0]:
                     best = (key, r)
    return best[1] if best else None


# ===========================================================================
# Karatsuba 3x3
# ===========================================================================
from .dsp_lib import K3W


def cpa_ns(width):
    """Versal carry-propagate adder, k3 scale. Doesn't include the output net."""
    n = max(1, -(-width // D["CARRY_BITS"]))
    return (D["CARRY_ENTRY_K3"] + D["CARRY_FIRST_PROP"]
            + (n - 1) * D["CARRY_STEP"] + D["CARRY_LAST_NET"] + D["CARRY_EXIT_K3"])


def _to_ff(t):
    """A fabric path landing on a flip-flop."""
    return t + D["END_NET"] + D["T_SU_FF"]


def k3_latency(cfg):
    L_diag = cfg["diag_A"] + cfg["diag_M"] + cfg["diag_P"]
    L_M = cfg["mid_A"] + cfg["mid_AD"] + 1
    total = L_M + cfg["mid_P"] + cfg["p02_d1"] + cfg["split"]
    return L_diag, L_M, total


def check_k3(cfg):
    """
    Alignment rule. There's deliberately no mid_C here: DSPs 11 and 22 each
    simultaneously drive one PCIN port and one C port, forming the loop
    constraint C_12 + C_02 = 0, so CREG isn't usable within K3.
    """
    L_diag, L_M, _ = k3_latency(cfg)
    if L_diag != L_M:
        return False
    if cfg["y0y1_ff"] + cfg["mid_B"] != cfg["mid_A"] + cfg["mid_AD"]:
        return False
    if cfg["mid_A"] > 1:            # DREG maxes out at 1; v1 doesn't add a fabric FF on X_hi
        return False
    if cfg["split"] < 1:
        return False
    return True


def k3_cost(cfg):
    """How many fabric FFs alignment costs. Key names correspond to the
    matching signals in the generated RTL."""
    mP, p02 = cfg["mid_P"], cfg["p02_d1"]
    ff = {
        "P00_d1/d2": K3W["P00_BITS"] * (mP + p02),
        "P22_d1/d2": K3W["P22_BITS"] * (mP + p02),
        "P01_d1":    K3W["P01_BITS"] * p02,
        "P12_d1":    K3W["P12_BITS"] * p02,
        "P02add_d1": K3W["P02ADD_BITS"] * p02,
        "Y0Y1 regs": K3W["YSUB_TOTAL"] * cfg["y0y1_ff"],
    }
    S, W = cfg["split"], K3W["ADD_WIDTH"]
    seg = -(-W // S)
    n = 0
    for i in range(S):
        n += i * 2 * seg + (S - 1 - i) * seg
    ff["adder split"] = n + (S - 1)
    ff["total"] = sum(ff.values())
    return ff


def karatsuba3(cfg):
    """Timing result for one Karatsuba-3 (6-DSP) configuration `cfg`."""
    stages = []
    S = cfg["split"]
    seg = -(-K3W["ADD_WIDTH"] // S)

    # ---- diagonal DSPs 00 / 11 / 22 ---------------------------------------
    s, p_diag, pcout_diag = _plain_dsp_branch(
        "diag: ", cfg["diag_A"], cfg["diag_M"], cfg["diag_P"])
    stages += s

    # ---- cross DSPs 01 / 12 / 02, A and D side -----------------------------
    stages += _input_stages(cfg["mid_A"], cfg["mid_AD"], 1, "cross A/D: ")

    # ---- cross DSPs, B side (the three Y subtractors in fabric) -----------
    start = D["FF_CLK_Q"]
    t = D["ROUTE_FF_TO_LUT"] + cpa_ns(K3W["YSUB_BITS"]) + D["END_NET"]
    if cfg["y0y1_ff"]:
        stages.append(("cross B: fabric FF -> Ysub FF", start + t + D["T_SU_FF"]))
        start, t = D["FF_CLK_Q"], 0.0
    t += D["ROUTE_FF_TO_A"]
    if cfg["mid_B"] >= 1:
        stages.append(("cross B: Ysub -> BREG", start + t + D["T_SU_DSP"]))
        start, t = D["TCO_BREG"], 0.0
    if cfg["mid_B"] == 2:
        stages.append(("cross B: BREG1 -> BREG2", D["TCO_BREG"] + D["T_SU_DSP"]))
        start, t = D["TCO_BREG"], 0.0
    stages.append(("cross B: -> MREG", start + t + D["B_TO_V"] + D["T_SU_DSP"]))

    # ---- cross DSP's ALU: C / PCIN / M three-way remerge -------------------
    via_c = (p_diag + D["ROUTE_P_TO_C_K3"] + D["C_TO_CDATA"]
             + D["ALUMUX_W"] + D["ALUADD_W"])
    via_z = pcout_diag + D["ROUTE_CASCADE"] + D["ALUMUX_Z"] + D["ALUADD_Z"]
    via_m = D["TCO_MREG"] + D["ALUMUX_Y"] + D["ALUADD_Y"]
    aluout = max(via_c, via_z, via_m)

    if cfg["mid_P"]:
        stages.append(("cross: -> PREG  [C path, cannot be cut]",
                       aluout + D["T_SU_DSP"]))
        p_cross = D["TCO_PREG_P"]
    else:
        p_cross = aluout + D["ALUOUT_TO_P"]

    # ---- CPA50：P02 + P00 -------------------------------------------------
    cpa50_out = p_cross + D["ROUTE_DSP_TO_ADDER"] + cpa_ns(K3W["CPA50_WIDTH"])
    if cfg["p02_d1"]:
        stages.append(("P02+P00 -> FF", _to_ff(cpa50_out)))
        op2_start = D["FF_CLK_Q"] + D["ROUTE_ADDER_TO_LUT3"]
    else:
        op2_start = cpa50_out + D["ROUTE_ADDER_TO_LUT3"]

    # ---- 115-bit multi-operand addition ------------------------------------
    compress = D["LUT3_COMPRESS"] + D["ROUTE_LUT3_TO_ADDER"]
    W = K3W["ADD_WIDTH"]

    def tree(name, src, lsb):
        """Injected starting at bit `lsb`; can run at most to the end of this segment."""
        left = min(W - lsb, seg)
        stages.append((f"tree: {name} -> CPA seg({left}b) -> FF",
                       _to_ff(src + compress + cpa_ns(left))))

    tree("op2 (P02+P00)", op2_start,                                K3W["OP_P02_LSB"])
    tree("op1 (P01)",     p_cross + D["ROUTE_DSP_TO_ADDER"],        K3W["OP_P01_LSB"])
    tree("op3 (P12)",     p_cross + D["ROUTE_DSP_TO_ADDER"],        K3W["OP_P12_LSB"])
    tree("op4 (P22)",     D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"],     K3W["OP_P22_LSB"])
    tree("op2 low (P00)", D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"],     K3W["OP_P01_LSB"])

    for i in range(1, S):
        stages.append((f"adder seg{i} FF -> FF",
                       _to_ff(D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"] + cpa_ns(seg))))

    _, _, total = k3_latency(cfg)
    r = summarize(stages, total, dict(cfg))
    r["cost"] = k3_cost(cfg)
    return r


def best_k3(budget, max_split=10):
    """Cheapest Karatsuba-3 critical path reachable with latency <= budget,
    searching every legal pipeline-register configuration."""
    best = None
    for dA in (0, 1):
     for dM in (0, 1):
      for dP in (0, 1):
       for mA in (0, 1):
        for mAD in (0, 1):
         for mB in (0, 1, 2):
          for y in (0, 1):
           for mP in (0, 1):
            for p02 in (0, 1):
             for S in range(1, max_split + 1):
              cfg = {"diag_A": dA, "diag_M": dM, "diag_P": dP,
                     "mid_A": mA, "mid_AD": mAD, "mid_B": mB, "y0y1_ff": y,
                     "mid_P": mP, "p02_d1": p02, "split": S}
              if not check_k3(cfg):
                  continue
              if k3_latency(cfg)[2] > budget:
                  continue
              r = karatsuba3(cfg)
              key = (round(r["critical_ns"], 6), r["latency"], r["cost"]["total"])
              if best is None or key < best[0]:
                  best = (key, r)
    return best[1] if best else None



# ===========================================================================
# Toom-Cook 2.5
# ===========================================================================
from .dsp_lib import T25W


def _t25_front(a_pipe, ad_pipe, prefix, route_a):
    """The two evaluation DSPs' A/D side (A=Y1, D=Y0, preadder). MREG is always on."""
    stages = []
    if a_pipe:
        stages.append((prefix + "fabric FF -> AREG",
                       D["FF_CLK_Q"] + route_a + D["T_SU_DSP"]))
        head = D["TCO_AREG"]
    else:
        head = D["FF_CLK_Q"] + route_a + D["A_TO_A2DATA"]
    if ad_pipe:
        stages.append((prefix + "-> ADREG (preadder)",
                       head + D["PREADD_ACTIVE"] + D["T_SU_DSP"]))
        head = D["TCO_ADREG"]
    else:
        head = head + D["PREADD_ACTIVE"]
    stages.append((prefix + "-> MREG (array)",
                   head + D["A2A1_TO_V"] + D["T_SU_DSP"]))
    return stages


def t25_latency(cfg):
    L_diag = cfg["diag_A"] + cfg["diag_M"] + cfg["diag_P"]
    L_M = cfg["mid_A"] + cfg["mid_AD"] + 1
    total = L_M + cfg["mid_P"] + cfg["interp_d1"] + cfg["split"]
    return L_diag, L_M, total


def check_t25(cfg):
    """
    p0 and p3 each simultaneously drive one C port and one PCIN port,
    forming the loop C_s + C_d = 0. So there's no mid_C knob here either,
    same as K3.
    """
    L_diag, L_M, _ = t25_latency(cfg)
    if L_diag != L_M:
        return False
    if cfg["xeval_ff"] + cfg["mid_B"] != cfg["mid_A"] + cfg["mid_AD"]:
        return False
    if cfg["mid_A"] > 1:            # DREG maxes out at 1
        return False
    if cfg["split"] < 1:
        return False
    return True


def t25_cost(cfg):
    mP, i1 = cfg["mid_P"], cfg["interp_d1"]
    ff = {
        "P0/P3 align": (T25W["P0_BITS"] + T25W["P3_BITS"]) * (mP + i1),
        "P1/P2 reg":   T25W["P12_BITS"] * i1,
        "Xeval regs":  T25W["XEVAL_TOTAL"] * cfg["xeval_ff"],
    }
    S, W = cfg["split"], T25W["CPA_RECOMP"]
    seg = -(-W // S)
    n = 0
    for i in range(S):
        n += i * 2 * seg + (S - 1 - i) * seg
    ff["adder split"] = n + (S - 1)
    ff["total"] = sum(ff.values())
    return ff


def toomcook25(cfg, route_c=None):
    """Timing result for one Toom-Cook 2.5 (4-DSP) configuration `cfg`.
    route_c can override ROUTE_P_TO_C_T25, for trying different placements."""
    if route_c is None:
        route_c = D["ROUTE_P_TO_C_T25"]
    stages = []
    S = cfg["split"]
    W = T25W["CPA_RECOMP"]
    seg = -(-W // S)
    route_a = D["ROUTE_FF_TO_A_T25"]

    # ---- p0 / p3, pure multiplication --------------------------------------
    save = D["ROUTE_FF_TO_A"]
    D["ROUTE_FF_TO_A"] = route_a            # these two DSPs use T25's harness routing
    s, p_diag, pcout_diag = _plain_dsp_branch(
        "diag: ", cfg["diag_A"], cfg["diag_M"], cfg["diag_P"])
    D["ROUTE_FF_TO_A"] = save
    stages += s

    # ---- evaluation DSPs, A/D side -----------------------------------------
    stages += _t25_front(cfg["mid_A"], cfg["mid_AD"], "eval A/D: ", route_a)

    # ---- evaluation DSPs, B side (computes X(+1) / X(-1) in fabric, three operands) ----
    compress = D["LUT3_COMPRESS"] + D["ROUTE_LUT3_TO_ADDER"]
    start = D["FF_CLK_Q"]
    t = (D["ROUTE_FF_TO_LUT"] + compress
         + cpa_ns(T25W["XEVAL_BITS"]) + D["END_NET_T25"])
    if cfg["xeval_ff"]:
        stages.append(("eval B: fabric FF -> Xeval FF", start + t + D["T_SU_FF"]))
        start, t = D["FF_CLK_Q"], 0.0
    t += D["ROUTE_FF_TO_A"]
    if cfg["mid_B"] >= 1:
        stages.append(("eval B: Xeval -> BREG", start + t + D["T_SU_DSP"]))
        start, t = D["TCO_BREG"], 0.0
    if cfg["mid_B"] == 2:
        stages.append(("eval B: BREG1 -> BREG2", D["TCO_BREG"] + D["T_SU_DSP"]))
        start, t = D["TCO_BREG"], 0.0
    stages.append(("eval B: -> MREG", start + t + D["B_TO_V"] + D["T_SU_DSP"]))

    # ---- evaluation DSP's ALU: C / PCIN / M three-way remerge -------------
    via_c = (p_diag + route_c + D["C_TO_CDATA"] + D["ALUMUX_W"] + D["ALUADD_W"])
    via_z = pcout_diag + D["ROUTE_CASCADE"] + D["ALUMUX_Z"] + D["ALUADD_Z"]
    via_m = D["TCO_MREG"] + D["ALUMUX_Y"] + D["ALUADD_Y"]
    aluout = max(via_c, via_z, via_m)

    if cfg["mid_P"]:
        stages.append(("eval: -> PREG  [C path, cannot be cut]",
                       aluout + D["T_SU_DSP"]))
        p_eval = D["TCO_PREG_P"]
    else:
        p_eval = aluout + D["ALUOUT_TO_P"]

    # ---- interpolation: twice_P1 = S-D+1, twice_P2 = S+D+1 ----------------
    interp_out = (p_eval + D["ROUTE_DSP_TO_ADDER_T25"]
                  + cpa_ns(T25W["CPA_INTERP"]))
    if cfg["interp_d1"]:
        stages.append(("twice_P1/P2 -> FF",
                       interp_out + D["END_NET_T25"] + D["T_SU_FF"]))
        p1_src = p2_src = D["FF_CLK_Q"] + D["ROUTE_ADDER_TO_LUT_T25"]
        p1_lsb = p2_lsb = 0                       # the register truncates the carry, restarting from bit 0
    else:
        p1_src = p2_src = interp_out + D["ROUTE_ADDER_TO_LUT_T25"]
        p1_lsb = T25W["CPA_INTERP"] - 1 + T25W["P1_INTO_Q"]   # the carry falls in from the top of the interpolation
        p2_lsb = T25W["CPA_INTERP"] - 1 + T25W["P2_INTO_Q"]

    # ---- reconstruction: Q = op0+op1+op2+op3 (91 bits, 4 operands) --------
    comp4 = D["LUT4_COMPRESS"] + D["ROUTE_LUT_TO_ADDER_T25"]

    def tree(name, src, lsb):
        left = min(max(W - lsb, 1), seg)
        stages.append((f"Q: {name} -> CPA seg({left}b) -> FF",
                       src + comp4 + cpa_ns(left)
                       + D["END_NET_T25"] + D["T_SU_FF"]))

    tree("via twice_P1 -> P1", p1_src, p1_lsb)
    tree("via twice_P2 -> P2", p2_src, p2_lsb)
    tree("op0 (P0[41:21])", D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"], T25W["OP_Q0_LSB"])
    tree("op3 (P3<<42)",    D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"], T25W["OP_Q3_LSB"])

    for i in range(1, S):
        stages.append((f"Q seg{i} FF -> FF",
                       D["FF_CLK_Q"] + D["ROUTE_FF_TO_LUT"] + cpa_ns(seg)
                       + D["END_NET_T25"] + D["T_SU_FF"]))

    _, _, total = t25_latency(cfg)
    r = summarize(stages, total, dict(cfg))
    r["cost"] = t25_cost(cfg)
    return r


def best_t25(budget, max_split=10, route_c=None):
    """Cheapest Toom-Cook 2.5 critical path reachable with latency <= budget,
    searching every legal pipeline-register configuration."""
    best = None
    for dA in (0, 1):
     for dM in (0, 1):
      for dP in (0, 1):
       for mA in (0, 1):
        for mAD in (0, 1):
         for mB in (0, 1, 2):
          for xf in (0, 1):
           for mP in (0, 1):
            for i1 in (0, 1):
             for S in range(1, max_split + 1):
              cfg = {"diag_A": dA, "diag_M": dM, "diag_P": dP,
                     "mid_A": mA, "mid_AD": mAD, "mid_B": mB, "xeval_ff": xf,
                     "mid_P": mP, "interp_d1": i1, "split": S}
              if not check_t25(cfg):
                  continue
              if t25_latency(cfg)[2] > budget:
                  continue
              r = toomcook25(cfg, route_c)
              key = (round(r["critical_ns"], 6), r["latency"], r["cost"]["total"])
              if best is None or key < best[0]:
                  best = (key, r)
    return best[1] if best else None