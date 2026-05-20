from counter import Counter
from rtl_gen.utils import width_expr


def LOOKAHEAD8_gen(num: int, suffix: str, attr: list[bool]) -> tuple[str, str]:
    left_vals = [4*num-1, num-1, 8*num-1]
    left_w = max(len(str(v)) for v in left_vals)
    width_expr_cout = width_expr(4*num-1, left_w)
    width_expr_cin = width_expr(num-1, left_w)
    width_expr_cy = width_expr(8*num-1, left_w)
    width_expr_prop = width_expr(8*num-1, left_w)
    w = max(len(width_expr_cout), len(width_expr_cin), len(width_expr_cy), len(width_expr_prop))
    signal_decl = f"""
    logic {width_expr_cout:<{w}} COUT_LA_{suffix};
    logic {width_expr_cin:<{w}} CIN_LA_{suffix};
    logic {width_expr_cy:<{w}} CY_LA_{suffix};
    logic {width_expr_prop:<{w}} PROP_LA_{suffix};
    """
    instantiation = f""""""
    for i in range(num):
        LOOKB = '"TRUE"' if attr[4*i] else '"FALSE"'
        LOOKD = '"TRUE"' if attr[4*i+1] else '"FALSE"'
        LOOKF = '"TRUE"' if attr[4*i+2] else '"FALSE"'
        LOOKH = '"TRUE"' if attr[4*i+3] else '"FALSE"'
        attr_list = [LOOKB, LOOKD, LOOKF, LOOKH]
        attr_len = max(len(s) for s in attr_list)
        COUTB = f"COUT_LA_{suffix}[{4*i}]"
        COUTD = f"COUT_LA_{suffix}[{4*i+1}]"
        COUTF = f"COUT_LA_{suffix}[{4*i+2}]"
        COUTH = f"COUT_LA_{suffix}[{4*i+3}]"
        CIN = f"CIN_LA_{suffix}[{i}]" if num > 1 else f"CIN_LA_{suffix}"
        CYA = f"CY_LA_{suffix}[{8*i}]"
        CYB = f"CY_LA_{suffix}[{8*i+1}]"
        CYC = f"CY_LA_{suffix}[{8*i+2}]"
        CYD = f"CY_LA_{suffix}[{8*i+3}]"
        CYE = f"CY_LA_{suffix}[{8*i+4}]"
        CYF = f"CY_LA_{suffix}[{8*i+5}]"
        CYG = f"CY_LA_{suffix}[{8*i+6}]"
        CYH = f"CY_LA_{suffix}[{8*i+7}]"
        PROPA = f"PROP_LA_{suffix}[{8*i}]"
        PROPB = f"PROP_LA_{suffix}[{8*i+1}]"
        PROPC = f"PROP_LA_{suffix}[{8*i+2}]"
        PROPD = f"PROP_LA_{suffix}[{8*i+3}]"
        PROPE = f"PROP_LA_{suffix}[{8*i+4}]"
        PROPF = f"PROP_LA_{suffix}[{8*i+5}]"
        PROPG = f"PROP_LA_{suffix}[{8*i+6}]"
        PROPH = f"PROP_LA_{suffix}[{8*i+7}]"
        port_list = [COUTB, COUTD, COUTF, COUTH, CIN, CYA, CYB, CYC, CYD, CYE, CYF, CYG, CYH, PROPA, PROPB, PROPC, PROPD, PROPE, PROPF, PROPG, PROPH]
        max_len = max(len(s) for s in port_list)
        instantiation += f"""
    LOOKAHEAD8 #(
        .LOOKB({LOOKB.ljust(attr_len)}),
        .LOOKD({LOOKD.ljust(attr_len)}),
        .LOOKF({LOOKF.ljust(attr_len)}),
        .LOOKH({LOOKH.ljust(attr_len)}))
    LOOKAHEAD8_{suffix}_inst{i} (
        .COUTB({COUTB.ljust(max_len)}),
        .COUTD({COUTD.ljust(max_len)}),
        .COUTF({COUTF.ljust(max_len)}),
        .COUTH({COUTH.ljust(max_len)}),
        .CIN  ({CIN.ljust(max_len)}),
        .CYA  ({CYA.ljust(max_len)}),
        .CYB  ({CYB.ljust(max_len)}),
        .CYC  ({CYC.ljust(max_len)}),
        .CYD  ({CYD.ljust(max_len)}),
        .CYE  ({CYE.ljust(max_len)}),
        .CYF  ({CYF.ljust(max_len)}),
        .CYG  ({CYG.ljust(max_len)}),
        .CYH  ({CYH.ljust(max_len)}),
        .PROPA({PROPA.ljust(max_len)}),
        .PROPB({PROPB.ljust(max_len)}),
        .PROPC({PROPC.ljust(max_len)}),
        .PROPD({PROPD.ljust(max_len)}),
        .PROPE({PROPE.ljust(max_len)}),
        .PROPF({PROPF.ljust(max_len)}),
        .PROPG({PROPG.ljust(max_len)}),
        .PROPH({PROPH.ljust(max_len)}));
"""
    return signal_decl, instantiation


# Per-counter contribution to a cascading subchain's CYMUX position count.
# Counters absent from this table (e.g. "(5,17 : 4,5,1)") are not chainable
# — they're emitted as floating GPCs with their own internal LOOKAHEAD8.
_SUBCHAIN_LEN = {
    "(6 : 3]":        1,
    "(3 : 2]":        1,
    "(1,5 : 3]":      2,
    "(2,2,3 : 4]":    2,
    "(9 : 4,1)":      2,
    "(3,9 : 2,3,1)":  2,
    "(4,13 : 3,4,1)": 3,
}


def analyze_subchain(counter_list: list[Counter]) -> tuple[list, list, list]:
    subchain_list = []
    subchain_num_LOOKAHEAD8 = []
    subchain_LOOKAHEAD8_attributes = []
    subchain = []
    num_counters = len(counter_list)
    current_subchain_length = 0
    for i in range(num_counters):
        name = counter_list[i].name
        delta = _SUBCHAIN_LEN.get(name, 0)
        current_subchain_length += delta
        if delta:
            subchain.append(counter_list[i])
        # (3,9 : 2,3,1) terminates the current subchain mid-chain (unless it's
        # also the last counter — in which case the CHAIN_END block below handles it).
        if name == "(3,9 : 2,3,1)" and i != num_counters-1:
            subchain.append("SUBCHAIN_END")
            subchain_list.append(subchain)
            num_LOOKAHEAD8 = current_subchain_length // 8
            if current_subchain_length % 8:
                num_LOOKAHEAD8 += 1
            subchain_num_LOOKAHEAD8.append(num_LOOKAHEAD8)
            num_CYMUX = current_subchain_length // 2
            attributes = []
            for j in range(4*num_LOOKAHEAD8):
                if j == 0:
                    attributes.append(False)
                elif j < num_CYMUX-1:
                    attributes.append(True)
                else:
                    attributes.append(False)
            subchain_LOOKAHEAD8_attributes.append(attributes)
            current_subchain_length = 2
            subchain = []
        if i == num_counters-1:
            subchain.append("CHAIN_END")
            subchain_list.append(subchain)
            num_LOOKAHEAD8 = current_subchain_length // 8
            if current_subchain_length % 8:
                num_LOOKAHEAD8 += 1
            subchain_num_LOOKAHEAD8.append(num_LOOKAHEAD8)
            num_CYMUX = current_subchain_length // 2
            attributes = []
            if current_subchain_length % 2 == 0:
                for j in range(4*num_LOOKAHEAD8):
                    if j == 0:
                        attributes.append(False)
                    elif j <= num_CYMUX-2:
                        attributes.append(True)
                    else:
                        attributes.append(False)
            else:
                for j in range(4*num_LOOKAHEAD8):
                    if j == 0:
                        attributes.append(False)
                    elif j < num_CYMUX-1:
                        attributes.append(True)
                    elif j == num_CYMUX-1:
                        if subchain[-2].name == "(3,9 : 2,3,1)" or subchain[-2].name == "(9 : 4,1)" or subchain[-2].name == "(2,2,3 : 4]":
                            attributes.append(False)
                        else:
                            attributes.append(True)
                    else:
                        attributes.append(False)
            subchain_LOOKAHEAD8_attributes.append(attributes)
    return subchain_list, subchain_num_LOOKAHEAD8, subchain_LOOKAHEAD8_attributes

