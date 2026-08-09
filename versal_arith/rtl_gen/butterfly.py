"""Butterfly RTL generator.

Consumes a `ButterflyOperatorSpec` (produced by
`operator_modeling.ntt.ButterflyScheme.GoldilocksSlice64.getOperatorInterface`) and emits SystemVerilog
for one Goldilocks-NTT butterfly module: two compressor instances (one per
output, aOut and bOut) sharing the input registers `aIn` and `bIn`, with the
per-position twiddle baked in via limb-shifted slices of the inputs.

Output strategy: two independent bit-heaps with shared input wires. The two
compressors are `<spec.name>_aOut_cmp` and `<spec.name>_bOut_cmp`; the wrapper
routes the same `aIn`/`bIn` registers into both via fan-out (Bit metadata is
emitted with the same signal_name across both heaps).

When `gen_testbench=True`, the caller supplies the four `aIn` / `bIn` /
`aOut` / `bOut` testvector arrays as data; the generator just writes the hex
files and emits the self-checking testbench. The caller (typically
`operator_modeling.ntt.ButterflyScheme.GoldilocksSlice64.emitRtl`) is responsible for sampling
inputs and computing goldens via `propagateValue`.
"""

from __future__ import annotations
import os

from butterfly_spec import ButterflyOperatorSpec, SliceTerm
from bitheap import BitHeap
from heuristic import compressAll, formGPCChain, merge_last_stage
from rtl_gen.compressor import reg_flag_list_gen, compressor_RTL_gen
from rtl_gen.utils import width_expr, to_twos_complement_hex


# ---------------------------------------------------------------------------
# Step 2a — bit-heap descriptor builder
# ---------------------------------------------------------------------------

def _emit_term_bits(term: SliceTerm, raw_cols: list[list], N: int) -> int:
    """Place one SliceTerm's bits into raw_cols (mutated) and return its
    contribution to the integer `sign_ext` constant accumulator.

    Each non-const term is one of four cases:
      A. Unsigned slice (or signed slice truncated by N), sign=+1:
         straight placement of slice bits at columns k..k+W'-1.
      B. Unsigned slice (or truncated), sign=-1: Baugh-Wooley negation —
         complement bits, +1 at column k, sign-ext 1's at [k+W..N-1].
      C. Full signed slice (k+W-1 < N), sign=+1: A[0..W-2] normally;
         ~A[W-1] at column k+W-1; +1 at column k+W-1; 1's at [k+W..N-1].
      D. Full signed slice, sign=-1: ~A[0..W-2]; A[W-1] (no complement);
         +1 at column k; +1 at column k+W-1; 1's at [k+W..N-1].

    Const terms are folded directly into sign_ext as `sign * constValue * 2^k
    mod 2^N` — there is no per-bit emission since every bit of the constant
    is known at generation time, and lumping them all into one constant is
    cheaper than emitting individual `1'b1` bits per set bit of the constant.
    """
    k = term.limbShift
    if term.source == 'const':
        return term.sign * term.constValue * (1 << k)

    W = term.sliceEnd - term.sliceStart + 1
    if k >= N:
        return 0    # term shifts entirely past the heap MSB
    W_eff = min(W, N - k)
    truncated = W_eff < W

    def slice_bit(i: int):
        """Source bit feeding slice position i (i in 0..W_eff-1).

        Returns (signal_name, signal_index) for an actual register bit, or
        None if this position is a guaranteed-zero LSB introduced by the
        input shift (i.e. (sliceStart + i) < inputShift).
        """
        p = term.sliceStart + i
        src_bit_pos = p - term.inputShift
        if src_bit_pos < 0:
            return None
        return (term.source, src_bit_pos)

    sign_ext_delta = 0

    if truncated or not term.isSigned:
        # Cases A / B (unsigned, or truncated-signed which collapses to unsigned)
        if term.sign == 1:
            for i in range(W_eff):
                src = slice_bit(i)
                if src is None:
                    continue
                raw_cols[k + i].append((src[0], src[1], False, False))
        else:
            for i in range(W_eff):
                src = slice_bit(i)
                if src is None:
                    # ~0 = constant 1
                    raw_cols[k + i].append((None, None, False, True))
                else:
                    raw_cols[k + i].append((src[0], src[1], True, False))
            sign_ext_delta += (1 << k)
            if not truncated:
                for col in range(k + W, N):
                    sign_ext_delta += (1 << col)
    else:
        # Cases C / D (full-width signed slice)
        msb = W - 1
        if term.sign == 1:
            for i in range(msb):
                src = slice_bit(i)
                if src is None:
                    continue
                raw_cols[k + i].append((src[0], src[1], False, False))
            src = slice_bit(msb)
            if src is None:
                raw_cols[k + msb].append((None, None, False, True))
            else:
                raw_cols[k + msb].append((src[0], src[1], True, False))
            sign_ext_delta += (1 << (k + msb))
            for col in range(k + W, N):
                sign_ext_delta += (1 << col)
        else:
            for i in range(msb):
                src = slice_bit(i)
                if src is None:
                    raw_cols[k + i].append((None, None, False, True))
                else:
                    raw_cols[k + i].append((src[0], src[1], True, False))
            src = slice_bit(msb)
            if src is not None:
                raw_cols[k + msb].append((src[0], src[1], False, False))
            sign_ext_delta += (1 << k)
            sign_ext_delta += (1 << (k + msb))
            for col in range(k + W, N):
                sign_ext_delta += (1 << col)

    return sign_ext_delta


def _build_heap_descriptors(terms: list[SliceTerm], output_width: int, col_prefix: str):
    """Build bit-heap descriptors for one output's term list.

    Returns (compressor_desc, assign_desc, bitheap_list, width_bh) where:

    - compressor_desc: list of [col_idx, (port_name, bit_idx_or_None), ...]
      passed to compressor_RTL_gen for column-port-name derivation. Each
      column gets one prefixed port name, e.g. "aOut_col5".

    - assign_desc: same shape as compressor_desc but each tuple is
      (signal_name, signal_index, complemented, is_constant) describing the
      actual register bit (or constant) that drives this column position.
      Used by the wrapper to emit `assign aOut_col5[2] = aIn[37];` style.

    - bitheap_list: per-column heights — input to the compressor pipeline.

    - width_bh: bit-width of the worst-case heap sum = compressor's output
      width. The wrapper truncates `comp_out[output_width-1:0]` to recover
      the predicted N-bit value.
    """
    N = output_width
    raw_cols: list[list] = [[] for _ in range(N)]
    sign_ext = 0

    for term in terms:
        sign_ext += _emit_term_bits(term, raw_cols, N)

    # Fold all accumulated constants (sign-extension corrections + Baugh-Wooley
    # +1's + the const-term mod-q value) into the heap as 1'b1 bits at each
    # set position of (sign_ext mod 2^N). Anything above 2^N is discarded —
    # the wrapper's `assign aOut = comp_out[N-1:0]` truncation makes those
    # high-order constants irrelevant.
    sign_ext = sign_ext % (1 << N)
    for i in range(N):
        if (sign_ext >> i) & 1:
            raw_cols[i].append((None, None, False, True))

    compressor_desc: list = []
    assign_desc: list = []
    for col_idx in range(N):
        bits = raw_cols[col_idx]
        if not bits:
            continue
        n_bits = len(bits)
        col_port = f"{col_prefix}col{col_idx}"
        comp_entry = [col_idx]
        for bit_idx in range(n_bits):
            comp_entry.append((col_port, bit_idx if n_bits > 1 else None))
        compressor_desc.append(comp_entry)
        assign_desc.append([col_idx] + bits)

    if not compressor_desc:
        return [], [], [], 0

    # The compressor pipeline's two-operand and terminal-adder loops assume
    # >=1 bit per column in the [first..last] range. Pad empty middle columns
    # with a 1'b0 filler so they exist (mirrors the same pad in const_mult.py).
    populated = {entry[0] for entry in compressor_desc}
    first_col = min(populated)
    last_col = max(populated)
    bitheap_list = [0] * (last_col + 1)
    for entry in compressor_desc:
        bitheap_list[entry[0]] = len(entry) - 1

    for col_idx in range(first_col, last_col + 1):
        if col_idx in populated:
            continue
        col_port = f"{col_prefix}col{col_idx}"
        compressor_desc.append([col_idx, (col_port, None)])
        assign_desc.append([col_idx, (None, None, False, False)])
        bitheap_list[col_idx] = 1

    compressor_desc.sort(key=lambda e: e[0])
    assign_desc.sort(key=lambda e: e[0])

    sum_max = sum(bitheap_list[col] * (2 ** col) for col in range(len(bitheap_list)))
    width_bh = sum_max.bit_length()

    return compressor_desc, assign_desc, bitheap_list, width_bh


# ---------------------------------------------------------------------------
# Step 2b — per-output compressor generation
# ---------------------------------------------------------------------------

def _gen_butterfly_compressor(spec: ButterflyOperatorSpec,
                              terms: list[SliceTerm],
                              output_width: int,
                              output_label: str,
                              pipeline_stages: int,
                              visualization: bool):
    """Generate one output's compressor module via compressor_RTL_gen.

    Returns a tuple (compressor_module_name, compressor_desc, assign_desc,
    bitheap_list, width_bh, comp_pipeline_stages) used by the wrapper.
    """
    col_prefix = f"{output_label}_"
    compressor_desc, assign_desc, bitheap_list, width_bh = _build_heap_descriptors(
        terms, output_width, col_prefix
    )

    if not bitheap_list:
        raise ValueError(
            f"{spec.name} {output_label} bit-heap is empty — every term was truncated. "
            f"Check that {output_label}BitWidth in the spec is non-zero."
        )

    compressor_module_name = f"{spec.name}_{output_label}_cmp"

    # First pass: run the heuristic to count compression layers, so reg_flag_list
    # can distribute pipeline_stages registers across them. compressor_RTL_gen
    # internally re-runs this same heuristic; the duplication mirrors how
    # const_mult.py's _gen_compressor does it (the heuristic is fast and the
    # double pass keeps the compressor_RTL_gen API unchanged).
    bh_layer_cal = BitHeap(width_bh, 0)
    for col in range(len(bitheap_list)):
        bh_layer_cal.add_bits(col, bitheap_list[col])
    last_bh, raw_cl = compressAll(bh_layer_cal, 0, width_bh - 1, False, False)
    cl_formed = formGPCChain(raw_cl)
    n_layers = len(cl_formed)
    if n_layers >= 2:
        mf, _ = merge_last_stage(
            last_compression_layer_counter_list=cl_formed[-1],
            last_compression_layer_bitheap=last_bh,
        )
    else:
        mf = False
    if mf:
        n_layers -= 1
    n_layers += 1   # +1 for the terminal-addition layer

    reg_flag_list = reg_flag_list_gen(pipeline_stages=pipeline_stages, num_layers=n_layers)

    # The compressor expects the column heights as a text file; write per-output
    # distinct paths so the two compressors don't clobber each other's input.
    heap_txt = f"{spec.name}_{output_label}_bitheap.txt"
    with open(heap_txt, "w", encoding="utf-8") as f:
        for v in bitheap_list:
            f.write(f"{v}\n")

    # If visualization is on, both compressor calls would write to the same
    # bitheap_visualization/{original_bitheap, after_layer_*}.png paths. Snapshot
    # the PNGs that exist BEFORE this call so we can rename only the new ones
    # (i.e. the ones produced by THIS compressor) afterwards. Pre-existing PNGs
    # from prior runs or the other output's call are left alone.
    viz_dir = "bitheap_visualization"
    pre_run_pngs: set[str] = set()
    if visualization and os.path.isdir(viz_dir):
        pre_run_pngs = {f for f in os.listdir(viz_dir) if f.endswith(".png")}

    compressor_RTL_gen(
        txt_file_name=heap_txt,
        sv_file_name=compressor_module_name,
        compressor_module_name=compressor_module_name,
        tb_out_width=output_width,
        reg_flag_list=reg_flag_list,
        visualization=visualization,
        gen_testbench=False,
        test_size=0,
        bitheap_desc=compressor_desc,
    )

    if visualization and os.path.isdir(viz_dir):
        for fname in os.listdir(viz_dir):
            if not fname.endswith(".png") or fname in pre_run_pngs:
                continue
            if fname.startswith(f"{output_label}_"):
                continue   # already-prefixed, idempotent on re-runs
            os.replace(os.path.join(viz_dir, fname),
                       os.path.join(viz_dir, f"{output_label}_{fname}"))

    comp_pipeline_stages = sum(1 for v in reg_flag_list if v)
    return (compressor_module_name, compressor_desc, assign_desc,
            bitheap_list, width_bh, comp_pipeline_stages)


# ---------------------------------------------------------------------------
# Step 2c — wrapper SystemVerilog
# ---------------------------------------------------------------------------

def _bit_assign(lhs: str, sig_name, sig_index, neg: bool, cnst: bool) -> str:
    """One-line assign for a column bit. Mirrors the per-bit RHS expression
    helper inlined in const_mult.py's wrapper generator."""
    if cnst:
        return f"    assign {lhs} = 1'b1;\n"
    if sig_name is None:
        return f"    assign {lhs} = 1'b0;\n"
    idx = "" if (sig_index is None or sig_index == -1) else f"[{sig_index}]"
    if neg:
        return f"    assign {lhs} = ~{sig_name}{idx};\n"
    return f"    assign {lhs} = {sig_name}{idx};\n"


def _gen_butterfly_wrapper(spec: ButterflyOperatorSpec,
                           aOut_info, bOut_info) -> str:
    """Build the wrapper SV string. Two compressors are instantiated and the
    same `aIn` and `bIn` registers feed both via fan-out at the column-wire
    level."""
    a_in_w = spec.aInBitWidth
    b_in_w = spec.bInBitWidth
    a_out_w = spec.aOutBitWidth
    b_out_w = spec.bOutBitWidth

    aOut_module, aOut_compressor_desc, aOut_assign_desc, _, aOut_width_bh, aOut_stages = aOut_info
    bOut_module, bOut_compressor_desc, bOut_assign_desc, _, bOut_width_bh, bOut_stages = bOut_info

    # Uniform left-padding width so port declarations line up like in Cmult/Bmult.
    bracket_widths = [a_in_w - 1, b_in_w - 1, a_out_w - 1, b_out_w - 1,
                      aOut_width_bh - 1, bOut_width_bh - 1]
    left_w = max(len(str(v)) for v in bracket_widths if v >= 0)

    rtl = f"""`timescale 1ns / 1ps

// Goldilocks butterfly: type={spec.butterflyType}, twiddle NAF = {spec.liftedTwiddleNaf}
// aIn:  {'signed' if spec.aInIsSigned else 'unsigned'} {a_in_w}-bit
// bIn:  {'signed' if spec.bInIsSigned else 'unsigned'} {b_in_w}-bit
// aOut: {'signed' if spec.aOutIsSigned else 'unsigned'} {a_out_w}-bit  (compressor pipeline stages: {aOut_stages})
// bOut: {'signed' if spec.bOutIsSigned else 'unsigned'} {b_out_w}-bit  (compressor pipeline stages: {bOut_stages})
module {spec.name} (
    input  logic {width_expr(0, left_w):<{left_w+6}} clk,
    input  logic {width_expr(a_in_w - 1, left_w):<{left_w+6}} aIn,
    input  logic {width_expr(b_in_w - 1, left_w):<{left_w+6}} bIn,
    output logic {width_expr(a_out_w - 1, left_w):<{left_w+6}} aOut,
    output logic {width_expr(b_out_w - 1, left_w):<{left_w+6}} bOut
    );

    logic {width_expr(aOut_width_bh - 1, left_w):<{left_w+6}} aOut_comp_out;
    logic {width_expr(bOut_width_bh - 1, left_w):<{left_w+6}} bOut_comp_out;
"""

    # Per-output column wires (one wire per populated column, with the
    # appropriate width if more than one bit accumulates at that column).
    for label, comp_desc in (('aOut', aOut_compressor_desc), ('bOut', bOut_compressor_desc)):
        rtl += f"\n    // ---- {label} bit-heap column wires ----\n"
        for entry in comp_desc:
            col_idx = entry[0]
            n_bits = len(entry) - 1
            cname = f"{label}_col{col_idx}"
            if n_bits == 1:
                rtl += f"    logic {' ' * (left_w + 6)} {cname};\n"
            else:
                rtl += f"    logic {width_expr(n_bits - 1, left_w):<{left_w+6}} {cname};\n"

    # Per-bit assigns from aIn/bIn (and constants).
    for label, assign_desc in (('aOut', aOut_assign_desc), ('bOut', bOut_assign_desc)):
        rtl += f"\n    // ---- {label} bit-heap input assignments ----\n"
        for entry in assign_desc:
            col_idx = entry[0]
            cname = f"{label}_col{col_idx}"
            bits = entry[1:]
            for bit_idx, (sig_name, sig_index, neg, cnst) in enumerate(bits):
                lhs = cname if len(bits) == 1 else f"{cname}[{bit_idx}]"
                rtl += _bit_assign(lhs, sig_name, sig_index, neg, cnst)

    # Compressor instances. The compressor's port names match the column wire
    # names (set via bitheap_desc's signal_name field when generating it), so
    # the connect list is just .col<i>(col<i>) per populated column.
    for label, comp_desc, comp_module_name in (
        ('aOut', aOut_compressor_desc, aOut_module),
        ('bOut', bOut_compressor_desc, bOut_module),
    ):
        rtl += f"\n    // ---- {label} compressor ----\n"
        rtl += f"    {comp_module_name} {comp_module_name}_inst (\n"
        rtl += f"        .clk(clk)"
        for entry in comp_desc:
            col_idx = entry[0]
            cname = f"{label}_col{col_idx}"
            rtl += f",\n        .{cname}({cname})"
        rtl += f",\n        .comp_out({label}_comp_out));\n"

    rtl += f"""
    // ---- Output truncation to bound bit-width ----
    assign aOut = aOut_comp_out[{a_out_w - 1}:0];
    assign bOut = bOut_comp_out[{b_out_w - 1}:0];

endmodule
"""
    return rtl


# ---------------------------------------------------------------------------
# Step 3 — testvectors + self-checking testbench
# ---------------------------------------------------------------------------

def _write_hex_file(path: str, values: list[int], bit_width: int) -> None:
    """One hex value per line, two's-complement-encoded at `bit_width`. Negative
    Python ints turn into the corresponding bit pattern; matches what the RTL
    output port `[bit_width-1:0]` produces after `assign aOut = comp_out[N-1:0]`
    truncation, so $readmemh into a `logic [N-1:0]` array compares equal."""
    with open(path, "w", encoding="utf-8") as f:
        for v in values:
            f.write(f"{to_twos_complement_hex(v, bit_width)}\n")


def _write_butterfly_testvectors(
    spec: ButterflyOperatorSpec,
    aIn: list[int], bIn: list[int],
    aOut: list[int], bOut: list[int],
) -> None:
    """Write the four hex testvector files. Caller is responsible for both inputs
    and goldens — the generator does not sample. Lengths must agree."""
    sizes = (len(aIn), len(bIn), len(aOut), len(bOut))
    if len(set(sizes)) != 1:
        raise ValueError(
            f"aIn/bIn/aOut/bOut must all have the same length, got {sizes}"
        )

    folder = "testvectors"
    os.makedirs(folder, exist_ok=True)
    _write_hex_file(os.path.join(folder, "aIn.txt"),  aIn,  spec.aInBitWidth)
    _write_hex_file(os.path.join(folder, "bIn.txt"),  bIn,  spec.bInBitWidth)
    _write_hex_file(os.path.join(folder, "aOut.txt"), aOut, spec.aOutBitWidth)
    _write_hex_file(os.path.join(folder, "bOut.txt"), bOut, spec.bOutBitWidth)


def _gen_butterfly_testbench(spec: ButterflyOperatorSpec,
                             pipeline_latency: int,
                             test_size: int) -> str:
    """Build the self-checking testbench string. Path convention matches Cmult:
    `$readmemh("../../../../../testvectors/<file>.txt", ...)` (5 levels up from
    `RTL_generated/`). `scripts/run_remote_sim.py` rewrites these paths to
    `../testvectors/` for the server build directory.

    The pass/fail markers mirror Cmult exactly (`SUCCESS!`, `PASS All`,
    `TO BE DEBUGGED...`, `FAILED:`) so the existing remote-sim verdict grep
    picks them up unchanged."""
    a_in_w  = spec.aInBitWidth
    b_in_w  = spec.bInBitWidth
    a_out_w = spec.aOutBitWidth
    b_out_w = spec.bOutBitWidth

    tb = f"""`timescale 1ns / 1ps

// Self-checking testbench for {spec.name}.
// Drives random aIn/bIn vectors and compares aOut/bOut against the unreduced
// goldens computed by GoldilocksSlice64.propagateValue (mod 2^N truncation
// happens at the wrapper's `assign aOut = comp_out[N-1:0]`).
// Pipeline latency: {pipeline_latency} cycle(s).
module {spec.name}_tb ();
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       {test_size}
    `define INIT_RESET    200

    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    logic [{a_in_w - 1}:0] aIn;
    logic [{b_in_w - 1}:0] bIn;
    logic [{a_out_w - 1}:0] aOut;
    logic [{b_out_w - 1}:0] bOut;
    logic [{a_in_w - 1}:0]  aIn_ts  [`TS_SIZE-1:0];
    logic [{b_in_w - 1}:0]  bIn_ts  [`TS_SIZE-1:0];
    logic [{a_out_w - 1}:0] aOut_ts [`TS_SIZE-1:0];
    logic [{b_out_w - 1}:0] bOut_ts [`TS_SIZE-1:0];

    initial begin
        $readmemh("../../../../../testvectors/aIn.txt",  aIn_ts );
        $readmemh("../../../../../testvectors/bIn.txt",  bIn_ts );
        $readmemh("../../../../../testvectors/aOut.txt", aOut_ts);
        $readmemh("../../../../../testvectors/bOut.txt", bOut_ts);
    end

    {spec.name} DUT (
        .clk (clk ),
        .aIn (aIn ),
        .bIn (bIn ),
        .aOut(aOut),
        .bOut(bOut));

    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            aIn = aIn_ts[i];
            bIn = bIn_ts[i];
            #`CLK_P;
        end
    end

    int j;
    int correct_cnt;
    initial begin
        correct_cnt = 0;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*{pipeline_latency});
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            if (aOut == aOut_ts[j] && bOut == bOut_ts[j]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                if (aOut !== aOut_ts[j]) begin
                    $display("aOut module    output: %h", aOut);
                    $display("aOut reference output: %h", aOut_ts[j]);
                end
                if (bOut !== bOut_ts[j]) begin
                    $display("bOut module    output: %h", bOut);
                    $display("bOut reference output: %h", bOut_ts[j]);
                end
                $display("=================================================================================");
            end
            #`CLK_P;
        end
        if (correct_cnt == `TS_SIZE) begin
            $display("SUCCESS!");
            $display("PASS All %d Testvectors!", `TS_SIZE);
        end else begin
            $display("TO BE DEBUGGED...");
            $display("FAILED: %d out of %d testvectors failed", (`TS_SIZE-correct_cnt), `TS_SIZE);
        end
        $finish();
    end

endmodule
"""
    return tb


# ---------------------------------------------------------------------------
# Step 2d — public API
# ---------------------------------------------------------------------------

def Butterfly_RTL_gen(
    spec: ButterflyOperatorSpec,
    pipeline_stages: int = 1,
    gen_testbench: bool = True,
    visualization: bool = False,
    aIn: list[int] | None = None,
    bIn: list[int] | None = None,
    aOut: list[int] | None = None,
    bOut: list[int] | None = None,
) -> dict:
    """Emit SystemVerilog for one Goldilocks butterfly module.

    Files written (relative to cwd, mirroring Cmult's layout):
        RTL_generated/<spec.name>.sv               wrapper
        RTL_generated/<spec.name>_aOut_cmp.sv      aOut compressor
        RTL_generated/<spec.name>_bOut_cmp.sv      bOut compressor
        RTL_generated/<spec.name>_tb.sv            self-checking testbench (when gen_testbench)
        xdc_generated/<spec.name>_aOut_cmp.xdc     aOut placement
        xdc_generated/<spec.name>_bOut_cmp.xdc     bOut placement
        testvectors/{aIn,bIn,aOut,bOut}.txt        hex testvectors (when gen_testbench)
        bitheap_visualization/{aOut,bOut}_*.png    per-output PNGs (when visualization)
        <spec.name>_{aOut,bOut}_bitheap.txt        column heights (input to compressor)

    When `gen_testbench=True`, all four `aIn` / `bIn` / `aOut` / `bOut` arrays
    are required. Caller is responsible for both inputs and goldens — typically
    `GoldilocksSlice64.emitRtl` (or a per-scenario harness) draws random
    inputs and runs `propagateValue` for the unreduced goldens. The generator
    itself does not sample.

    `test_size` is implicit — equals `len(aIn)` (= len(bIn) = len(aOut) = len(bOut)).

    Returns a metadata dict (module names, per-output pipeline stages,
    compressor output widths, pipeline latency).
    """
    aOut_info = _gen_butterfly_compressor(
        spec, spec.aOutTerms, spec.aOutBitWidth, "aOut",
        pipeline_stages, visualization=visualization,
    )
    bOut_info = _gen_butterfly_compressor(
        spec, spec.bOutTerms, spec.bOutBitWidth, "bOut",
        pipeline_stages, visualization=visualization,
    )

    rtl = _gen_butterfly_wrapper(spec, aOut_info, bOut_info)
    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    with open(os.path.join(folder, f"{spec.name}.sv"), "w", encoding="utf-8") as f:
        f.write(rtl)

    # Pipeline latency is the deeper of the two compressors. reg_flag_list_gen
    # currently produces equal stage counts for both heaps (since pipeline_stages
    # is shared at the API level), so this is just max() defensively in case
    # downstream tweaks ever desync them.
    pipeline_latency = max(aOut_info[5], bOut_info[5], 1)

    if gen_testbench:
        if aIn is None or bIn is None or aOut is None or bOut is None:
            raise ValueError(
                "Butterfly_RTL_gen: aIn / bIn / aOut / bOut are all required when "
                "gen_testbench=True. Sample inputs and run propagateValue in the "
                "caller (GoldilocksSlice64.emitRtl does this automatically)."
            )
        _write_butterfly_testvectors(spec, aIn, bIn, aOut, bOut)
        test_size = len(aIn)
        tb = _gen_butterfly_testbench(spec, pipeline_latency, test_size)
        with open(os.path.join(folder, f"{spec.name}_tb.sv"), "w", encoding="utf-8") as f:
            f.write(tb)

    return {
        "wrapper_module": spec.name,
        "aOut_compressor_module": aOut_info[0],
        "bOut_compressor_module": bOut_info[0],
        "aOut_pipeline_stages": aOut_info[5],
        "bOut_pipeline_stages": bOut_info[5],
        "aOut_compressor_output_width": aOut_info[4],
        "bOut_compressor_output_width": bOut_info[4],
        "pipeline_latency": pipeline_latency,
    }
