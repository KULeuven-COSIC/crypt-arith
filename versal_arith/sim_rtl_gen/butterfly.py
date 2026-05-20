"""Behavioral butterfly RTL generator (simulation-only).

Renders one Goldilocks-NTT butterfly module as a sum of signed-shifted-sliced
terms taken directly from a `ButterflyOperatorSpec`. Two entry points:

  - `render_butterfly_sv(spec, pipeline_stages) -> (sv_text, metadata)`:
        pure string builder used by `NTT_SimRTL_gen` when concatenating
        many butterflies into one `<topName>_butterflies.sv`.

  - `Butterfly_SimRTL_gen(spec, ..., gen_testbench, aIn, bIn, aOut, bOut)`:
        standalone entry that writes the wrapper SV, optional self-checking
        testbench, and hex testvectors to disk. Used by `build_butterfly.py`
        and by `build_ntt.py --debug-butterfly`.

The signature and return-shape of `Butterfly_SimRTL_gen` match the hw-side
`rtl_gen.butterfly.Butterfly_RTL_gen` so the upstream `emitRtl` dispatcher
can swap one for the other based on a `backend` kwarg.
"""

from __future__ import annotations
import os

from butterfly_spec import ButterflyOperatorSpec, SliceTerm
from rtl_gen.utils import to_twos_complement_hex


# ---------------------------------------------------------------------------
# SV emission helpers
# ---------------------------------------------------------------------------

def _ext_width(spec_in_w: int, terms: list[SliceTerm], src: str) -> int:
    """Width needed for `<src>_ext` so every slice expression can be a pure
    bit-select. Bit `b` of `(src << inputShift)` corresponds to source bit
    `b - inputShift`, so the max source bit any term references is
    `max(sliceEnd - inputShift)`. We extend up to at least `spec_in_w` (the
    declared input width) so the alias never narrows the source."""
    max_ref = -1
    for t in terms:
        if t.source != src:
            continue
        b = t.sliceEnd - t.inputShift
        if b > max_ref:
            max_ref = b
    return max(spec_in_w, max_ref + 1, 1)


def _emit_slice_rhs(t: SliceTerm, src_ext_name: str) -> str:
    """SV right-hand side that extracts `term`'s bit-slice from `src_ext_name`.
    Returns a `(W = sliceEnd - sliceStart + 1)`-bit expression.

    Cases:
      (a) slice entirely in zero LSBs (srcHi < 0): emit `{W}'b0`.
      (b) slice fully inside the extended source (srcLo >= 0):
          bit-select `src_ext[srcHi:srcLo]` (or `src_ext[srcHi]` for W=1).
      (c) slice straddles the zero-LSB boundary (srcLo < 0 <= srcHi):
          concat the upper part of `src_ext` with `-srcLo` zero LSBs.

    Signedness of the returned expression is unsigned (bit-selects are
    inherently unsigned in SV). The caller declares the per-term wire as
    `signed` or unsigned based on `term.isSigned`; same-width signed/unsigned
    assignment is a bit-pattern reinterpret, which gives the desired
    propagateValue-equivalent semantics.
    """
    W = t.sliceEnd - t.sliceStart + 1
    src_lo = t.sliceStart - t.inputShift
    src_hi = t.sliceEnd - t.inputShift

    if src_hi < 0:
        return f"{W}'b0"

    if src_lo >= 0:
        if src_hi == src_lo:
            return f"{src_ext_name}[{src_hi}]"
        return f"{src_ext_name}[{src_hi}:{src_lo}]"

    # straddle: src_lo < 0 <= src_hi
    n_zero = -src_lo
    upper = f"{src_ext_name}[{src_hi}]" if src_hi == 0 else f"{src_ext_name}[{src_hi}:0]"
    return f"{{{upper}, {{{n_zero}{{1'b0}}}}}}"


def _term_max_magnitude(t: SliceTerm) -> int:
    """Upper bound on `|sign * sliceValue * 2^limbShift|` for accumulator sizing."""
    if t.source == 'const':
        return abs(t.constValue) << t.limbShift
    W = t.sliceEnd - t.sliceStart + 1
    if t.isSigned:
        # signed slice: value in [-2^(W-1), 2^(W-1) - 1]; magnitude up to 2^(W-1)
        return (1 << (W - 1)) << t.limbShift
    return ((1 << W) - 1) << t.limbShift


def _calc_acc_width(terms: list[SliceTerm], output_width: int) -> int:
    """Pick an accumulator width that holds the worst-case signed sum of all
    SliceTerms losslessly. We use `bit_length()` of the total-magnitude bound
    plus 2 (one bit for sign, one for slack), with a floor at `output_width + 2`
    so truncation `acc[output_width-1:0]` is always well-defined."""
    total_mag = sum(_term_max_magnitude(t) for t in terms)
    if total_mag == 0:
        acc = output_width + 2
    else:
        acc = total_mag.bit_length() + 2
    return max(acc, output_width + 2)


def _signed_literal(value: int, width: int) -> str:
    """SV signed literal for an integer `value` of arbitrary sign, at the given
    width. We emit it as a two's-complement hex constant cast through
    `$signed(...)` so the bit pattern always matches Python's notion of
    `value mod 2^width`."""
    masked = value & ((1 << width) - 1)
    hex_width = (width + 3) // 4
    return f"$signed({width}'h{masked:0{hex_width}X})"


def _emit_term_wires(terms: list[SliceTerm], label: str) -> tuple[list[str], list[str]]:
    """For each term emit one wire declaration. Returns (decl_lines,
    per_term_wire_names). Const terms are emitted as signed literal wires.

    Naming: `<label>_t<i>` where i is the index in the term list.
    """
    decls: list[str] = []
    names: list[str] = []
    for i, t in enumerate(terms):
        W = (t.sliceEnd - t.sliceStart + 1) if t.source != 'const' else max(
            (t.constValue.bit_length() + 1), 1
        )
        name = f"{label}_t{i}"
        if t.source == 'const':
            # Treat the const as a width-(constValue.bit_length()+1) signed wire so
            # there's always a sign bit. Sign of the contribution is folded into
            # the accumulator expression (- vs +), so the wire itself carries
            # +|constValue|.
            const_w = max(t.constValue.bit_length() + 1, 2)
            decls.append(
                f"    wire signed [{const_w-1}:0] {name} = "
                f"{_signed_literal(t.constValue, const_w)};"
            )
        else:
            src_ext = f"{t.source}_ext"
            rhs = _emit_slice_rhs(t, src_ext)
            if t.isSigned:
                decls.append(f"    wire signed [{W-1}:0] {name} = {rhs};")
            else:
                decls.append(f"    wire        [{W-1}:0] {name} = {rhs};")
        names.append(name)
    return decls, names


def _emit_sum_expr(terms: list[SliceTerm], names: list[str], acc_w: int) -> str:
    """SV expression that sums every term into a signed `acc_w`-bit accumulator.
    Each contribution is `(signed'(acc_w'(t)) <<< limbShift)` so widening uses
    sign- or zero-extension per the term's declared signedness, and the shift
    is arithmetic on a signed operand. Sign of the term is folded by emitting
    `+` or `-` at the operator. Const-term signs are also folded here (the
    per-term wire carries the unsigned magnitude)."""
    parts: list[str] = []
    for t, name in zip(terms, names):
        cast = f"signed'({acc_w}'({name}))"
        shifted = cast if t.limbShift == 0 else f"({cast} <<< {t.limbShift})"
        op = "+" if t.sign == 1 else "-"
        if not parts:
            parts.append(("" if op == "+" else "-") + shifted)
        else:
            parts.append(f" {op} {shifted}")
    if not parts:
        return f"{acc_w}'sd0"
    return "".join(parts)


# ---------------------------------------------------------------------------
# Main SV builder
# ---------------------------------------------------------------------------

def render_butterfly_sv(
    spec: ButterflyOperatorSpec,
    pipeline_stages: int = 1,
) -> tuple[str, dict]:
    """Build the behavioral SV for one butterfly module. Returns
    `(sv_text, metadata)`. `metadata` matches the hw `Butterfly_RTL_gen`
    return shape (with sim-irrelevant compressor fields set to sim-friendly
    placeholders) so callers can treat the two backends uniformly.
    """
    pipeline_latency = max(int(pipeline_stages), 1)

    a_in_w = spec.aInBitWidth
    b_in_w = spec.bInBitWidth
    a_out_w = spec.aOutBitWidth
    b_out_w = spec.bOutBitWidth

    # Both inputs are referenced in either aOutTerms or bOutTerms (or both).
    # Compute per-source extension widths from the union of all referencing terms.
    all_terms = list(spec.aOutTerms) + list(spec.bOutTerms)
    a_ext_w = _ext_width(a_in_w, all_terms, 'aIn')
    b_ext_w = _ext_width(b_in_w, all_terms, 'bIn')

    a_acc_w = _calc_acc_width(spec.aOutTerms, a_out_w)
    b_acc_w = _calc_acc_width(spec.bOutTerms, b_out_w)

    lines: list[str] = []
    lines.append("`timescale 1ns / 1ps")
    lines.append("")
    lines.append(f"// Behavioral simulation-only Goldilocks butterfly: {spec.name}")
    lines.append(f"// type={spec.butterflyType}, twiddle NAF={spec.liftedTwiddleNaf}")
    lines.append(f"// aIn:  {'signed' if spec.aInIsSigned else 'unsigned'} {a_in_w}-bit")
    lines.append(f"// bIn:  {'signed' if spec.bInIsSigned else 'unsigned'} {b_in_w}-bit")
    lines.append(f"// aOut: {'signed' if spec.aOutIsSigned else 'unsigned'} {a_out_w}-bit "
                 f"(latency {pipeline_latency} cycle(s))")
    lines.append(f"// bOut: {'signed' if spec.bOutIsSigned else 'unsigned'} {b_out_w}-bit "
                 f"(latency {pipeline_latency} cycle(s))")
    lines.append(f"// Body: sum of {len(spec.aOutTerms)} aOut terms + {len(spec.bOutTerms)} bOut terms,")
    lines.append(f"//       accumulator widths aOut={a_acc_w}b / bOut={b_acc_w}b, truncated to output width.")
    lines.append(f"module {spec.name} (")
    lines.append(f"    input  logic                  clk,")
    lines.append(f"    input  logic [{a_in_w-1}:0] aIn,")
    lines.append(f"    input  logic [{b_in_w-1}:0] bIn,")
    lines.append(f"    output logic [{a_out_w-1}:0] aOut,")
    lines.append(f"    output logic [{b_out_w-1}:0] bOut")
    lines.append(f"    );")
    lines.append("")

    # Extended input aliases. Sign-extend when the source bound is signed,
    # zero-extend otherwise — matches the implicit infinite-extension that
    # propagateValue does on Python ints.
    lines.append("    // ---- Extended input aliases ----")
    if spec.aInIsSigned:
        lines.append(f"    wire signed [{a_ext_w-1}:0] aIn_ext = $signed(aIn);")
    else:
        lines.append(f"    wire        [{a_ext_w-1}:0] aIn_ext = aIn;")
    if spec.bInIsSigned:
        lines.append(f"    wire signed [{b_ext_w-1}:0] bIn_ext = $signed(bIn);")
    else:
        lines.append(f"    wire        [{b_ext_w-1}:0] bIn_ext = bIn;")
    lines.append("")

    # Per-output: per-term wires + combinational sum + pipeline shift register.
    for label, terms, out_w, acc_w in (
        ('aOut', spec.aOutTerms, a_out_w, a_acc_w),
        ('bOut', spec.bOutTerms, b_out_w, b_acc_w),
    ):
        lines.append(f"    // ---- {label} term wires ----")
        decls, names = _emit_term_wires(terms, label)
        lines.extend(decls)
        lines.append("")
        sum_expr = _emit_sum_expr(terms, names, acc_w)
        lines.append(f"    // ---- {label} combinational sum ----")
        lines.append(f"    logic signed [{acc_w-1}:0] {label}_sum_comb;")
        lines.append(f"    always_comb {label}_sum_comb = {sum_expr};")
        lines.append("")
        # Pipeline: shift register of depth `pipeline_latency`.
        lines.append(f"    // ---- {label} pipeline ({pipeline_latency} stage(s)) ----")
        last_idx = pipeline_latency - 1
        lines.append(f"    logic [{out_w-1}:0] {label}_pipe [0:{last_idx}];")
        lines.append(f"    always_ff @(posedge clk) begin")
        lines.append(f"        {label}_pipe[0] <= {label}_sum_comb[{out_w-1}:0];")
        if pipeline_latency > 1:
            lines.append(f"        for (int s = 1; s <= {last_idx}; s++) "
                         f"{label}_pipe[s] <= {label}_pipe[s-1];")
        lines.append(f"    end")
        lines.append(f"    assign {label} = {label}_pipe[{last_idx}];")
        lines.append("")

    lines.append("endmodule")

    metadata = {
        "wrapper_module": spec.name,
        "aOut_compressor_module": None,
        "bOut_compressor_module": None,
        "aOut_pipeline_stages": pipeline_latency,
        "bOut_pipeline_stages": pipeline_latency,
        "aOut_compressor_output_width": a_acc_w,
        "bOut_compressor_output_width": b_acc_w,
        "pipeline_latency": pipeline_latency,
    }
    return "\n".join(lines) + "\n", metadata


# ---------------------------------------------------------------------------
# Testvectors + self-checking testbench
# ---------------------------------------------------------------------------

def _write_hex_file(path: str, values: list[int], bit_width: int) -> None:
    with open(path, "w", encoding="utf-8") as f:
        for v in values:
            f.write(f"{to_twos_complement_hex(v, bit_width)}\n")


def _write_butterfly_testvectors(
    spec: ButterflyOperatorSpec,
    aIn: list[int], bIn: list[int],
    aOut: list[int], bOut: list[int],
) -> None:
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
    """Self-checking testbench. Byte-for-byte the same structure as the hw
    backend's testbench (clock/reset, 5-deep `$readmemh` paths, PASS/FAIL
    print strings) so `scripts/run_remote_sim.py` works without changes."""
    a_in_w  = spec.aInBitWidth
    b_in_w  = spec.bInBitWidth
    a_out_w = spec.aOutBitWidth
    b_out_w = spec.bOutBitWidth

    return f"""`timescale 1ns / 1ps

// Self-checking testbench for {spec.name} (behavioral sim backend).
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


# ---------------------------------------------------------------------------
# Public API — standalone disk-writing entry
# ---------------------------------------------------------------------------

def Butterfly_SimRTL_gen(
    spec: ButterflyOperatorSpec,
    pipeline_stages: int = 1,
    gen_testbench: bool = True,
    visualization: bool = False,  # accepted for API parity; ignored (no bit-heap to draw)
    aIn: list[int] | None = None,
    bIn: list[int] | None = None,
    aOut: list[int] | None = None,
    bOut: list[int] | None = None,
) -> dict:
    """Emit behavioral simulation-only SystemVerilog for one Goldilocks
    butterfly. Drop-in alternative to `rtl_gen.butterfly.Butterfly_RTL_gen`:
    identical signature, identical return-dict shape (compressor fields are
    None / placeholders), identical files-on-disk layout and testbench
    conventions.

    Files written (relative to cwd):
        RTL_generated/<spec.name>.sv         behavioral wrapper module
        RTL_generated/<spec.name>_tb.sv      self-checking TB (gen_testbench=True)
        testvectors/{aIn,bIn,aOut,bOut}.txt  hex testvectors (gen_testbench=True)

    No `xdc_generated/`, no `*_bitheap.txt`, no compressor or visualization
    files — the sim backend has no bit-heap.
    """
    sv_text, meta = render_butterfly_sv(spec, pipeline_stages=pipeline_stages)

    folder = "RTL_generated"
    os.makedirs(folder, exist_ok=True)
    with open(os.path.join(folder, f"{spec.name}.sv"), "w", encoding="utf-8") as f:
        f.write(sv_text)

    if gen_testbench:
        if aIn is None or bIn is None or aOut is None or bOut is None:
            raise ValueError(
                "Butterfly_SimRTL_gen: aIn / bIn / aOut / bOut are all required when "
                "gen_testbench=True. Sample inputs and run propagateValue in the "
                "caller (GoldilocksSlice64.emitRtl does this automatically)."
            )
        _write_butterfly_testvectors(spec, aIn, bIn, aOut, bOut)
        test_size = len(aIn)
        tb = _gen_butterfly_testbench(spec, meta["pipeline_latency"], test_size)
        with open(os.path.join(folder, f"{spec.name}_tb.sv"), "w", encoding="utf-8") as f:
            f.write(tb)

    return meta
