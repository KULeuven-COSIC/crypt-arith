"""Constant multiplier RTL generation.

Generates a module that computes A * C where A is an input (unsigned or
signed) and C is a constant, using only shifts, adds, and (for tall bit
heaps) a compressor tree. No DSP multipliers are used.

Strategy by bit heap max column height (after Baugh-Wooley correction):
  height == 1: pure wiring (shifts + optional inverters)
  height == 2: two-operand adder (Verilog +/- operator)
  height >= 3: bitheap compressor tree
"""

import json
import os
from random import randint

from bitheap import BitHeap
from heuristic import compressAll, formGPCChain, merge_last_stage
from power_writer import format_signed_powers, reduce_mod_q_min_powers_lift, build_const_mult_bitheap
from rtl_gen.utils import width_expr, to_twos_complement_hex
from rtl_gen.compressor import reg_flag_list_gen, compressor_RTL_gen


def _resolve_powers(constant, powers, modulus,
                    lift_max_pow: int = 96,
                    lift_max_shift: int = 32,
                    lift_depth: int = 3,
                    lift_beam: int = 200):
    """Resolve the constant into a list of (sign, power) tuples.

    If powers is given as a list of signed ints (CLI format), convert to tuples
    directly (NAF lifting is bypassed — the caller has supplied the powers).
    Otherwise, decompose ``constant`` either with vanilla NAF (modulus=None) or
    with ``reduce_mod_q_min_powers_lift`` (modulus set), forwarding the lift
    parameters.

    Returns (constant_value, [(sign, power), ...]).
    """
    if powers is not None:
        # Caller-supplied powers: take them verbatim, no NAF lifting.
        pw = [(1 if p >= 0 else -1, abs(p)) for p in powers]
        if constant is None:
            constant = sum(s * (1 << p) for s, p in pw)
    elif constant is not None:
        if modulus is not None:
            _, pw, _, _ = reduce_mod_q_min_powers_lift(
                constant, modulus,
                max_pow=lift_max_pow,
                max_shift=lift_max_shift,
                depth=lift_depth,
                beam=lift_beam,
            )
        else:
            pw = format_signed_powers(constant)
    else:
        raise ValueError("Either 'constant' or 'powers' must be provided.")
    return constant, pw


def _output_width(width_a, constant, signed_input=False):
    """Compute the output bit-width for A * constant."""
    if signed_input:
        min_a = -(1 << (width_a - 1))
        max_a = (1 << (width_a - 1)) - 1
        max_abs = max(abs(min_a * constant), abs(max_a * constant))
        w = max(max_abs.bit_length() + 1, 2)  # +1 for sign bit
    else:
        max_product = ((1 << width_a) - 1) * abs(constant)
        w = max(max_product.bit_length(), 1)
        if constant < 0:
            w += 1
    return w


def _output_int_type(width_a: int, constant: int,
                     signed_input: bool = False) -> tuple[int, bool, int, int]:
    """Per-cmult output IntType bound: (bitWidth, isSigned, minValue, maxValue).

    Mirrors `_output_width`'s arithmetic but additionally returns the exact
    [minValue, maxValue] product range — the tight bound that the NTT's
    `getInputsNatural([bounds])` consumes downstream.
    """
    bit_width = _output_width(width_a, constant, signed_input=signed_input)
    if signed_input:
        a_lo = -(1 << (width_a - 1))
        a_hi = (1 << (width_a - 1)) - 1
        candidates = (a_lo * constant, a_hi * constant)
        min_v = min(candidates)
        max_v = max(candidates)
        is_signed = True
    else:
        # A in [0, 2^width_a - 1]
        a_lo = 0
        a_hi = (1 << width_a) - 1
        if constant >= 0:
            min_v = 0
            max_v = a_hi * constant
            is_signed = False
        else:
            min_v = a_hi * constant   # most negative
            max_v = 0
            is_signed = True
    return bit_width, is_signed, min_v, max_v


def _module_name(width_a, constant):
    const_str = f"{abs(constant)}" if constant >= 0 else f"neg{abs(constant)}"
    return f"Cmult_{width_a}x{const_str}"


def _max_col_height(assign_desc: list) -> int:
    """Compute the maximum column height from a bitheap assign descriptor."""
    if not assign_desc:
        return 0
    return max(len(entry) - 1 for entry in assign_desc)


def _bit_expr(sig_name, sig_index, neg, cnst) -> str:
    """Generate a Verilog expression for a single bitheap bit."""
    if cnst:
        return "1'b1"
    if sig_name is None:
        return "1'b0"
    idx = "" if (sig_index is None or sig_index == -1) else f"[{sig_index}]"
    if neg:
        return f"~{sig_name}{idx}"
    return f"{sig_name}{idx}"


# =========================================================================
# max_height == 1: pure wiring (shifts + optional inverters)
# =========================================================================

def _gen_shift_only(module_name, width_a, output_width, constant, assign_desc, signed_input=False):
    """Generate RTL when every column has exactly 1 bit — pure wiring (with inverters)."""
    left_w = max(len(str(width_a - 1)), len(str(output_width - 1)))

    # Build the output bit-by-bit from MSB to LSB
    col_map = {entry[0]: entry[1:] for entry in assign_desc}

    bits = []
    for col in range(output_width - 1, -1, -1):
        if col in col_map and col_map[col]:
            sig_name, sig_index, neg, cnst = col_map[col][0]
            bits.append(_bit_expr(sig_name, sig_index, neg, cnst))
        else:
            bits.append("1'b0")

    a_type = "signed" if signed_input else "unsigned"
    RTL_str = f"""`timescale 1ns / 1ps

module {module_name} (
    input  logic {width_expr(0, left_w):<{left_w+6}} clk,
    input  logic {width_expr(width_a - 1, left_w):<{left_w+6}} A,
    output logic {width_expr(output_width - 1, left_w):<{left_w+6}} P
    );

    // A ({a_type} {width_a}-bit) * {constant} — pure wiring (max column height = 1)
    assign P = {{{", ".join(bits)}}};

endmodule
"""
    return RTL_str, 0


# =========================================================================
# max_height == 2: two-operand adder
# =========================================================================

def _gen_adder(module_name, width_a, output_width, constant, assign_desc, signed_input=False):
    """Generate RTL when max column height is 2 — two operands + Verilog add."""
    left_w = max(len(str(width_a - 1)), len(str(output_width - 1)))

    col_map = {entry[0]: entry[1:] for entry in assign_desc}

    # Build two operands: op0 gets the first bit of each column, op1 gets the second (or 0)
    op0_bits = []
    op1_bits = []
    for col in range(output_width - 1, -1, -1):
        bits_in_col = col_map.get(col, [])
        if len(bits_in_col) >= 1:
            sig_name, sig_index, neg, cnst = bits_in_col[0]
            op0_bits.append(_bit_expr(sig_name, sig_index, neg, cnst))
        else:
            op0_bits.append("1'b0")
        if len(bits_in_col) >= 2:
            sig_name, sig_index, neg, cnst = bits_in_col[1]
            op1_bits.append(_bit_expr(sig_name, sig_index, neg, cnst))
        else:
            op1_bits.append("1'b0")

    a_type = "signed" if signed_input else "unsigned"
    RTL_str = f"""`timescale 1ns / 1ps

module {module_name} (
    input  logic {width_expr(0, left_w):<{left_w+6}} clk,
    input  logic {width_expr(width_a - 1, left_w):<{left_w+6}} A,
    output logic {width_expr(output_width - 1, left_w):<{left_w+6}} P
    );

    // A ({a_type} {width_a}-bit) * {constant} — two-operand adder (max column height = 2)
    logic {width_expr(output_width - 1, left_w):<{left_w+6}} op0;
    logic {width_expr(output_width - 1, left_w):<{left_w+6}} op1;
    assign op0 = {{{", ".join(op0_bits)}}};
    assign op1 = {{{", ".join(op1_bits)}}};
    assign P = op0 + op1;

endmodule
"""
    return RTL_str, 0


# =========================================================================
# 3+ terms: bitheap compressor
# =========================================================================

def _gen_compressor(module_name, width_a, output_width, constant, pw, pipeline_stages, test_size, signed_input=False):
    """Generate RTL for tall bit heaps (max column height >= 3) using a compressor tree."""
    compressor_desc, assign_desc = build_const_mult_bitheap(pw, "A", width_a, signed_input=signed_input)

    # Build bitheap_list from the descriptor.
    # build_const_mult_bitheap only emits entries for populated columns.
    # LSB-empty columns (below the lowest populated one) stay at 0 bits and are
    # wired to 1'b0 directly in the terminal adder output section.
    # Empty *middle* columns (0 bits between populated columns) would break the
    # terminal adder's body/two-operand loops, which assume >=1 bit per column
    # in that range. Pad those with a single 1'b0 filler bit.
    populated_cols = {entry[0] for entry in compressor_desc}
    first_populated = min(populated_cols)
    max_col = max(populated_cols)
    bitheap_list = [0] * (max_col + 1)
    for entry in compressor_desc:
        bitheap_list[entry[0]] = len(entry) - 1

    # Insert a single-bit filler for empty middle columns
    for col_idx in range(first_populated, max_col + 1):
        if col_idx in populated_cols:
            continue
        comp_entry = [col_idx, (f"col{col_idx}", None)]
        assign_entry = [col_idx, (None, None, False, False)]
        compressor_desc.append(comp_entry)
        assign_desc.append(assign_entry)
        bitheap_list[col_idx] = 1

    # Keep descriptors sorted by column index for deterministic wrapper output
    compressor_desc.sort(key=lambda e: e[0])
    assign_desc.sort(key=lambda e: e[0])

    number_of_columns = len(bitheap_list)
    sum_max = sum(bitheap_list[col] * (2 ** col) for col in range(number_of_columns))
    width_bh = sum_max.bit_length()

    # Write bitheap.txt and run compressor pipeline
    with open("bitheap.txt", "w", encoding="utf-8") as f:
        for val in bitheap_list:
            f.write(f"{val}\n")

    bh_layer_cal = BitHeap(width_bh, 0)
    for col in range(number_of_columns):
        bh_layer_cal.add_bits(col, bitheap_list[col])
    last_bh, raw_cl = compressAll(bh_layer_cal, 0, width_bh - 1, False, False)
    cl_formed = formGPCChain(raw_cl)
    n_layers = len(cl_formed)
    if n_layers >= 2:
        mf, ri = merge_last_stage(last_compression_layer_counter_list=cl_formed[-1],
                                   last_compression_layer_bitheap=last_bh)
    else:
        mf = False
    if mf:
        n_layers -= 1
    n_layers += 1
    reg_flag_list = reg_flag_list_gen(pipeline_stages=pipeline_stages, num_layers=n_layers)

    compressor_RTL_gen(
        txt_file_name="bitheap.txt",
        sv_file_name=f"{module_name}_cmp",
        compressor_module_name=f"{module_name}_cmp",
        visualization=True,
        tb_out_width=output_width,
        gen_testbench=False,
        test_size=test_size,
        reg_flag_list=reg_flag_list,
        bitheap_desc=compressor_desc,
    )

    # Generate wrapper
    left_vals = [width_a - 1, output_width - 1] + [v - 1 for v in bitheap_list] + [width_bh - 1]
    left_w = max(len(str(v)) for v in left_vals if v >= 0)

    RTL_str = f"""`timescale 1ns / 1ps

module {module_name} (
    input  logic {width_expr(0, left_w):<{left_w+6}} clk,
    input  logic {width_expr(width_a - 1, left_w):<{left_w+6}} A,
    output logic {width_expr(output_width - 1, left_w):<{left_w+6}} P
    );

    logic {width_expr(width_bh - 1, left_w):<{left_w+6}} comp_out;
    """

    for entry in compressor_desc:
        col_idx = entry[0]
        n_bits = len(entry) - 1
        cname = f"col{col_idx}"
        if n_bits == 1:
            RTL_str += f"""logic {' ' * (left_w + 6)} {cname};
    """
        else:
            RTL_str += f"""logic {width_expr(n_bits - 1, left_w):<{left_w+6}} {cname};
    """

    RTL_str += f"""
    // ------ Bitheap input assignments (A * {constant}) ------
    """
    for entry in assign_desc:
        col_idx = entry[0]
        cname = f"col{col_idx}"
        bits = entry[1:]
        for bit_idx, (sig_name, sig_index, neg, cnst) in enumerate(bits):
            lhs = cname if len(bits) == 1 else f"{cname}[{bit_idx}]"
            if cnst:
                RTL_str += f"""assign {lhs} = 1'b1;
    """
            elif sig_name is None:
                RTL_str += f"""assign {lhs} = 1'b0;
    """
            elif neg:
                idx = "" if (sig_index is None or sig_index == -1) else f"[{sig_index}]"
                RTL_str += f"""assign {lhs} = ~{sig_name}{idx};
    """
            else:
                idx = "" if (sig_index is None or sig_index == -1) else f"[{sig_index}]"
                RTL_str += f"""assign {lhs} = {sig_name}{idx};
    """

    RTL_str += f"""
    // ------ Compressor tree ------
    {module_name}_cmp {module_name}_cmp_inst(
        .clk(clk)"""
    for entry in compressor_desc:
        col_idx = entry[0]
        RTL_str += f""",
        .col{col_idx}(col{col_idx})"""
    RTL_str += f""",
        .comp_out(comp_out));

    assign P = comp_out[{output_width - 1}:0];

endmodule
"""
    comp_pipeline = sum(1 for v in reg_flag_list if v)
    return RTL_str, comp_pipeline


# =========================================================================
# Main entry point
# =========================================================================

def Cmult_RTL_gen(
    width_a: int,
    constant: int | None = None,
    powers: list[int] | None = None,
    modulus: int | None = None,
    pipeline_stages: int = 1,
    gen_testbenches: bool = True,
    test_size: int = 1000,
    signed_input: bool = False,
    lift_max_pow: int = 96,
    lift_max_shift: int = 32,
    lift_depth: int = 3,
    lift_beam: int = 200,
) -> None:
    """Generate a constant multiplier: A * C.

    Strategy based on bitheap column heights:
      max_height == 1: pure wiring (shifts + inverters)
      max_height == 2: two-operand adder
      max_height >= 3: bitheap compressor tree

    NAF modulus lifting (only when modulus is set) is delegated to
    ``reduce_mod_q_min_powers_lift``; the ``lift_*`` parameters tune that
    search and are otherwise unused.
    """
    constant, pw = _resolve_powers(
        constant, powers, modulus,
        lift_max_pow=lift_max_pow,
        lift_max_shift=lift_max_shift,
        lift_depth=lift_depth,
        lift_beam=lift_beam,
    )
    out_w = _output_width(width_a, constant, signed_input=signed_input)
    mod_name = _module_name(width_a, constant)
    n_terms = len(pw)

    if n_terms <= 0:
        raise ValueError(f"Constant {constant} has 0 NAF terms (is it 0?).")

    # Build bitheap descriptor and determine strategy from column heights
    compressor_desc, assign_desc = build_const_mult_bitheap(pw, "A", width_a, signed_input=signed_input)
    max_h = _max_col_height(assign_desc)

    signed_str = "signed" if signed_input else "unsigned"
    print(f"Constant multiplier: {width_a}-bit {signed_str} x {constant} ({n_terms} NAF terms, max col height={max_h})")

    if max_h <= 1:
        print("  Strategy: pure wiring")
        rtl, comp_stages = _gen_shift_only(mod_name, width_a, out_w, constant, assign_desc, signed_input=signed_input)
    elif max_h == 2:
        print("  Strategy: two-operand adder")
        rtl, comp_stages = _gen_adder(mod_name, width_a, out_w, constant, assign_desc, signed_input=signed_input)
    else:
        print(f"  Strategy: bitheap compressor (max height={max_h})")
        rtl, comp_stages = _gen_compressor(mod_name, width_a, out_w, constant, pw, pipeline_stages, test_size, signed_input=signed_input)

    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    with open(os.path.join(folder, f"{mod_name}.sv"), "w") as f:
        f.write(rtl)

    if gen_testbenches:
        # Testbench needs at least 1 cycle delay for input to settle
        tb_stages = max(1, comp_stages)
        _gen_cmult_testbench(mod_name, width_a, out_w, constant, tb_stages, test_size, signed_input=signed_input)


def _gen_cmult_testbench(
    module_name: str, width_a: int, output_width: int, constant: int,
    comp_pipeline_stages: int, test_size: int, signed_input: bool = False,
) -> None:
    """Generate testbench and test vectors for constant multiplier."""
    folder = "testvectors"
    os.makedirs(folder, exist_ok=True)

    A_ts, P_ts = [], []
    for _ in range(test_size):
        if signed_input:
            a = randint(-(1 << (width_a - 1)), (1 << (width_a - 1)) - 1)
        else:
            a = randint(0, (1 << width_a) - 1)
        p = a * constant
        p = p & ((1 << output_width) - 1)
        A_ts.append(a)
        P_ts.append(p)

    a_hex_w = (width_a + 3) // 4
    p_hex_w = (output_width + 3) // 4
    a_mask = (1 << width_a) - 1
    with open(os.path.join(folder, "A.txt"), "w") as f:
        for v in A_ts:
            f.write(f"{(v & a_mask):0{a_hex_w}X}\n")
    with open(os.path.join(folder, "P.txt"), "w") as f:
        for v in P_ts:
            f.write(f"{v:0{p_hex_w}X}\n")

    tb_str = f"""`timescale 1ns / 1ps

module {module_name}_tb ();
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       {test_size}
    `define INIT_RESET    200

    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    logic [{width_a - 1}:0] A;
    logic [{output_width - 1}:0] P;
    logic [{width_a - 1}:0] A_ts [`TS_SIZE-1:0];
    logic [{output_width - 1}:0] P_ts [`TS_SIZE-1:0];

    initial begin
        $readmemh("../../../../../testvectors/A.txt", A_ts);
        $readmemh("../../../../../testvectors/P.txt", P_ts);
    end

    {module_name} DUT (
        .clk(clk),
        .A  (A  ),
        .P  (P  ));

    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            A = A_ts[i];
            #`CLK_P;
        end
    end

    int j;
    int correct_cnt;
    initial begin
        correct_cnt = 0;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*{comp_pipeline_stages});
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            if (P == P_ts[j]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                $display("module    output: %h", P);
                $display("reference output: %h", P_ts[j]);
                $display("=================================================================================");
            end
            #`CLK_P;
        end
        if (correct_cnt == `TS_SIZE) begin
            $display("SUCCESS!");
            $display("PASS All %d Testvectors!", `TS_SIZE);
        end else begin
            $display("TO BE DEBUGGED...");
            $display("%d out of %d testvectors failed...", (`TS_SIZE-correct_cnt), `TS_SIZE);
        end
        $finish();
    end

endmodule
"""
    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    with open(os.path.join(folder, f"{module_name}_tb.sv"), "w") as f:
        f.write(tb_str)


# =========================================================================
# Constant-multiplier bank: N parallel constant multipliers
# =========================================================================

def _gen_single_cmult(width_a: int, constant: int, pipeline_stages: int, test_size: int, signed_input: bool = False) -> tuple[str, str, int, int]:
    """Generate a single constant multiplier RTL.

    Returns (module_name, rtl_string, pipeline_stages_used, output_width).
    Strategy is chosen based on bitheap column heights.
    """
    constant, pw = _resolve_powers(constant, None, None)
    out_w = _output_width(width_a, constant, signed_input=signed_input)
    mod_name = _module_name(width_a, constant)
    n_terms = len(pw)

    if n_terms <= 0:
        raise ValueError(f"Constant {constant} has 0 NAF terms.")

    compressor_desc, assign_desc = build_const_mult_bitheap(pw, "A", width_a, signed_input=signed_input)
    max_h = _max_col_height(assign_desc)

    if max_h <= 1:
        rtl, comp_stages = _gen_shift_only(mod_name, width_a, out_w, constant, assign_desc, signed_input=signed_input)
    elif max_h == 2:
        rtl, comp_stages = _gen_adder(mod_name, width_a, out_w, constant, assign_desc, signed_input=signed_input)
    else:
        rtl, comp_stages = _gen_compressor(mod_name, width_a, out_w, constant, pw, pipeline_stages, test_size, signed_input=signed_input)

    return mod_name, rtl, comp_stages, out_w


def _consolidate_bank_artifacts(rtl_dir: str, bank_module_name: str,
                                mod_names: list[str]) -> None:
    """Merge the per-constant artifacts into two consolidated SV files.

    Each constant contributes one `<Cmult>.sv` wrapper and — only when its
    bit-heap needed the compressor strategy (max column height >= 3) — one
    `<Cmult>_cmp.sv`. For a 64-wide bank that is up to 128 tiny files, which
    is slow to rsync and noisy to browse. Concatenate them the same way
    `rtl_gen.ntt._consolidate_butterfly_artifacts` does for butterflies:

      - `<bank>_cmults.sv`      — every Cmult wrapper module
      - `<bank>_compressors.sv` — every compressor module (omitted when the
                                  bank has none, e.g. every constant lifted
                                  to <= 2 NAF terms)

    SV permits multiple modules per file; Vivado/xsim resolve them by module
    name. The XDCs stay split — they carry LUTNM placement keyed on specific
    compressor module instances.
    """
    wrappers: list[str] = []
    compressors: list[str] = []
    for mod in mod_names:
        wrapper_path = os.path.join(rtl_dir, f"{mod}.sv")
        cmp_path     = os.path.join(rtl_dir, f"{mod}_cmp.sv")
        if os.path.isfile(cmp_path):
            with open(cmp_path, "r", encoding="utf-8") as f:
                compressors.append(f"// ===== {mod}_cmp =====\n{f.read()}")
            os.remove(cmp_path)
        if os.path.isfile(wrapper_path):
            with open(wrapper_path, "r", encoding="utf-8") as f:
                wrappers.append(f"// ===== {mod} =====\n{f.read()}")
            os.remove(wrapper_path)

    if wrappers:
        with open(os.path.join(rtl_dir, f"{bank_module_name}_cmults.sv"),
                  "w", encoding="utf-8") as f:
            f.write("\n".join(wrappers))
    if compressors:
        with open(os.path.join(rtl_dir, f"{bank_module_name}_compressors.sv"),
                  "w", encoding="utf-8") as f:
            f.write("\n".join(compressors))
    print(f"  Consolidated {len(wrappers)} cmult + {len(compressors)} compressor "
          f"module(s) into {bank_module_name}_cmults.sv"
          + (f" + {bank_module_name}_compressors.sv" if compressors else ""))


def Cmultbank_RTL_gen(
    txt_file_name: str,
    width_a: int = 24,
    pipeline_stages: int = 1,
    gen_testbenches: bool = True,
    test_size: int = 1000,
    bank_module_name: str = "cmultbank",
    signed_input: bool = False,
    modulus: int | None = None,
    lift_max_pow: int = 96,
    lift_max_shift: int = 32,
    lift_depth: int = 3,
    lift_beam: int = 200,
) -> None:
    """Generate a bank of N parallel constant multipliers.

    Reads constants from a text file (one per line), generates one Cmult
    module per constant, a top-level wrapper, and a testbench. All bank
    outputs are uniformly pipelined to the same latency. Typical use case is
    an NTT pre-twist or post-twist bank, but nothing here is NTT-specific.

    NAF modulus lifting is **optional**:
      * modulus=None (default): every constant ``c`` is fed to the multiplier
        verbatim. The user owns whatever simplification has already been done
        (e.g. they pre-lifted the values themselves).
      * modulus=q: each ``c`` is replaced by a sparser-NAF integer
        ``c' ≡ c (mod q)`` found by ``reduce_mod_q_min_powers_lift``; the
        ``lift_*`` parameters tune that search.

    The produced multiplier always computes ``A * c_used``, where ``c_used``
    is whichever value (lifted or not) the bank fed in. For lifted constants
    the product is wider but congruent mod q to ``A * c``, so a downstream
    field reduction recovers the same residue.
    """
    # Read constants
    with open(txt_file_name) as f:
        constants = [int(line.strip()) for line in f if line.strip()]
    n_mults = len(constants)
    signed_str = "signed" if signed_input else "unsigned"
    print(f"Cmult bank: {n_mults} constant multipliers, {width_a}-bit {signed_str} input")

    # Modulus lifting: replace each constant with a sparser-NAF equivalent mod q.
    if modulus is not None:
        print(f"  Modulus lifting against q = {modulus}")
        print(f"    lift_max_pow={lift_max_pow}, lift_max_shift={lift_max_shift}, "
              f"lift_depth={lift_depth}, lift_beam={lift_beam}")
        lifted: list[int] = []
        max_lift_terms = 0
        for c in constants:
            c_lift, _, w, _ = reduce_mod_q_min_powers_lift(
                c, modulus,
                max_pow=lift_max_pow,
                max_shift=lift_max_shift,
                depth=lift_depth,
                beam=lift_beam,
            )
            lifted.append(c_lift)
            if w > max_lift_terms:
                max_lift_terms = w
        constants = lifted
        print(f"  Max NAF terms after lifting: {max_lift_terms}")

    # Compute uniform output width
    if signed_input:
        min_a = -(1 << (width_a - 1))
        max_a = (1 << (width_a - 1)) - 1
        max_abs_product = max(max(abs(min_a * c), abs(max_a * c)) for c in constants)
        output_width = max_abs_product.bit_length() + 1  # +1 for sign bit
    else:
        max_a = (1 << width_a) - 1
        max_abs_product = max(max_a * abs(c) for c in constants)
        output_width = max_abs_product.bit_length() + 1  # +1 for sign
    print(f"  Output width: {output_width} bits (signed)")

    # Generate each individual multiplier
    os.makedirs("RTL_generated", exist_ok=True)
    os.makedirs("xdc_generated", exist_ok=True)

    module_names = []
    max_latency = 0

    for i, const in enumerate(constants):
        pw = format_signed_powers(const)
        n_terms = len(pw)
        mod_name, rtl, comp_stages, ind_out_w = _gen_single_cmult(width_a, const, pipeline_stages, test_size, signed_input=signed_input)
        # Output is signed if input is signed or constant is negative
        needs_sign_ext = signed_input or (const < 0)
        module_names.append((mod_name, comp_stages, ind_out_w, needs_sign_ext))
        max_latency = max(max_latency, comp_stages)

        # Write individual module
        with open(os.path.join("RTL_generated", f"{mod_name}.sv"), "w") as f:
            f.write(rtl)

        if i % 16 == 0:
            print(f"  Generated {i}/{n_mults}: {mod_name} ({n_terms} NAF terms, {comp_stages} pipe stages)")

    # Fold the per-constant wrappers + compressors into two files. Done here,
    # before the top wrapper and testbench are written, so those are never
    # candidates for consolidation.
    _consolidate_bank_artifacts("RTL_generated", bank_module_name,
                                [m[0] for m in module_names])

    # Uniform latency = max of (deepest compressor, user-requested pipeline_stages, 1)
    max_comp_latency = max_latency
    uniform_latency = max(max_comp_latency, pipeline_stages, 1)
    extra_wrapper_regs = uniform_latency - max_comp_latency

    print(f"  Max compressor depth: {max_comp_latency} cycle(s)")
    if extra_wrapper_regs > 0:
        print(f"  Wrapper adds {extra_wrapper_regs} extra register stage(s) to reach requested latency")
    print(f"  Uniform pipeline latency: {uniform_latency} cycle(s)")
    print(f"  Generating top-level wrapper: {bank_module_name}")
    max_latency = uniform_latency

    # Generate top-level wrapper. Per-port output widths use each cmult's actual
    # ind_out_w (no zero / sign extension to a uniform max).
    max_ind_out_w = max(ind for _, _, ind, _ in module_names)
    left_w = max(len(str(width_a - 1)), len(str(max_ind_out_w - 1)), len(str(n_mults - 1)))
    w_a = width_expr(width_a - 1, left_w)

    RTL_str = f"""`timescale 1ns / 1ps

// Constant-multiplier bank.
// Per-port output widths (P_<i> width = bit_length((2^width_a - 1) * |C_i|),
// +1 if signed). Uniform pipeline latency = {uniform_latency} cycle(s) across
// all P_<i>; balancing shift registers are inserted per-cmult inside the
// wrapper at the cmult's own width — no zero/sign-extension at the bank
// boundary. Each P_<i>'s exact IntType bound is recorded in the sidecar
// `output_bounds.json` written next to this RTL.
module {bank_module_name} (
    input  logic {' ' * (left_w + 6)} clk,
"""
    for i in range(n_mults):
        RTL_str += f"""    input  logic {w_a} A_{i},\n"""
    for i in range(n_mults):
        ind_out_w = module_names[i][2]
        suffix = "," if i < n_mults - 1 else ""
        RTL_str += f"""    output logic {width_expr(ind_out_w - 1, left_w)} P_{i}{suffix}\n"""
    RTL_str += f"""    );
"""

    # Internal wires and instances
    for i, (mod_name, comp_stages, ind_out_w, _needs_sign_ext) in enumerate(module_names):
        extra_regs = max_latency - comp_stages
        ind_w = width_expr(ind_out_w - 1, left_w)

        RTL_str += f"""
    // --- Multiplier {i}: {mod_name} (latency={comp_stages}, padding={extra_regs}) ---
    logic {ind_w} P_raw_{i};
    {mod_name} cmult_{i} (.clk(clk), .A(A_{i}), .P(P_raw_{i}));
"""
        # Determine the final source after pipeline-balancing registers (sized
        # at the cmult's own ind_out_w — no width change at the wrapper).
        if extra_regs == 0:
            final_src = f"P_raw_{i}"
        else:
            for r in range(extra_regs):
                src = f"P_raw_{i}" if r == 0 else f"P_pipe_{i}_{r - 1}"
                dst = f"P_pipe_{i}_{r}"
                RTL_str += f"""    logic {ind_w} {dst};
    always_ff @(posedge clk) {dst} <= {src};
"""
            final_src = f"P_pipe_{i}_{extra_regs - 1}"

        # Direct connection to the per-port output — no padding, both sides
        # are exactly ind_out_w wide.
        RTL_str += f"""    assign P_{i} = {final_src};
"""

    RTL_str += f"""
endmodule
"""

    with open(os.path.join("RTL_generated", f"{bank_module_name}.sv"), "w") as f:
        f.write(RTL_str)

    # Generate testbench
    if gen_testbenches:
        out_widths = [module_names[i][2] for i in range(n_mults)]
        _gen_cmultbank_testbench(bank_module_name, constants, width_a, out_widths,
                                max_latency, n_mults, test_size, signed_input=signed_input)

    # Sidecar: per-port IntType bounds. Downstream consumers (NTT.getInputsNatural)
    # reload this via operator_modeling.core.IntType.loadBoundsJson and feed the resulting
    # list[IntType] straight into the next pipeline stage.
    bounds_entries = []
    for i, const in enumerate(constants):
        bw, is_signed, min_v, max_v = _output_int_type(width_a, const, signed_input=signed_input)
        bounds_entries.append({
            "idx": i,
            "constant": const,
            "bitWidth": bw,
            "isSigned": is_signed,
            "minValue": min_v,
            "maxValue": max_v,
        })
    with open("output_bounds.json", "w", encoding="utf-8") as f:
        json.dump(bounds_entries, f, indent=2)

    print(f"  Done: {n_mults} multipliers + wrapper + testbench + output_bounds.json")


def _gen_cmultbank_testbench(
    bank_module_name: str, constants: list[int], width_a: int,
    out_widths: list[int], pipeline_latency: int, n_mults: int, test_size: int,
    signed_input: bool = False,
) -> None:
    """Generate testbench and test vectors for the cmult bank.

    `out_widths[i]` is the actual product width of the i-th cmult (= the i-th
    bank wrapper P port width). Each P_<i>.txt golden file is masked to
    `out_widths[i]` (per-port two's complement); the TB locals match.
    """
    folder = "testvectors"
    os.makedirs(folder, exist_ok=True)

    a_hex_w = (width_a + 3) // 4
    a_mask = (1 << width_a) - 1

    # Generate shared random A values and per-constant P golden references
    if signed_input:
        A_ts = [randint(-(1 << (width_a - 1)), (1 << (width_a - 1)) - 1) for _ in range(test_size)]
    else:
        A_ts = [randint(0, (1 << width_a) - 1) for _ in range(test_size)]

    with open(os.path.join(folder, "A.txt"), "w") as f:
        for v in A_ts:
            f.write(f"{(v & a_mask):0{a_hex_w}X}\n")

    for idx, const in enumerate(constants):
        out_w = out_widths[idx]
        mask = (1 << out_w) - 1
        p_hex_w = (out_w + 3) // 4
        P_ts = []
        for a in A_ts:
            # Two's complement at the per-port width (Python's & on negative
            # ints handles this).
            p = (a * const) & mask
            P_ts.append(p)
        with open(os.path.join(folder, f"P_{idx}.txt"), "w") as f:
            for v in P_ts:
                f.write(f"{v:0{p_hex_w}X}\n")

    # Generate testbench SV
    tb_str = f"""`timescale 1ns / 1ps

module {bank_module_name}_tb ();
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       {test_size}
    `define INIT_RESET    200
    `define N_MULTS       {n_mults}
    `define PIPE_LATENCY  {pipeline_latency}

    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    // Input/output signals
"""
    for i in range(n_mults):
        tb_str += f"""    logic [{width_a - 1}:0] A_{i};
"""
    for i in range(n_mults):
        tb_str += f"""    logic [{out_widths[i] - 1}:0] P_{i};
"""

    tb_str += f"""
    // Test vectors
    logic [{width_a - 1}:0] A_ts [`TS_SIZE-1:0];
"""
    for i in range(n_mults):
        tb_str += f"""    logic [{out_widths[i] - 1}:0] P_{i}_ts [`TS_SIZE-1:0];
"""

    tb_str += f"""
    // Load test vectors
    initial begin
        $readmemh("../../../../../testvectors/A.txt", A_ts);
"""
    for i in range(n_mults):
        tb_str += f"""        $readmemh("../../../../../testvectors/P_{i}.txt", P_{i}_ts);
"""
    tb_str += f"""    end

    // DUT
    {bank_module_name} DUT (
        .clk(clk),
"""
    for i in range(n_mults):
        tb_str += f"""        .A_{i}(A_{i}),
"""
    for i in range(n_mults - 1):
        tb_str += f"""        .P_{i}(P_{i}),
"""
    tb_str += f"""        .P_{n_mults - 1}(P_{n_mults - 1}));

    // Drive inputs
    int idx;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (idx = 0; idx < `TS_SIZE; idx = idx + 1) begin
"""
    for i in range(n_mults):
        tb_str += f"""            A_{i} = A_ts[idx];
"""
    tb_str += f"""            #`CLK_P;
        end
    end

    // Check outputs
    int j;
    int correct_cnt;
    int total_checks;
    initial begin
        correct_cnt = 0;
        total_checks = `TS_SIZE * `N_MULTS;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P * `PIPE_LATENCY);
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
"""
    for i in range(n_mults):
        tb_str += f"""            if (P_{i} == P_{i}_ts[j]) correct_cnt = correct_cnt + 1;
            else $display("Cmult[{i}] TV-%0d WRONG: got %h, exp %h", j, P_{i}, P_{i}_ts[j]);
"""
    tb_str += f"""            #`CLK_P;
        end
        if (correct_cnt == total_checks) begin
            $display("SUCCESS!");
            $display("PASS All %0d checks (%0d multipliers x %0d vectors)", total_checks, `N_MULTS, `TS_SIZE);
        end else begin
            $display("FAILED: %0d / %0d checks passed", correct_cnt, total_checks);
        end
        $finish();
    end

endmodule
"""

    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    with open(os.path.join(folder, f"{bank_module_name}_tb.sv"), "w") as f:
        f.write(tb_str)
