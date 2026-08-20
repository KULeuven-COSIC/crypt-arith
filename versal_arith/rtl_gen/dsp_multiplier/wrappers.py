"""Wrapper .sv text emission for sub/mult/bitheap blocks. Builds on the
dataclasses and shape/naming helpers in ``rtl/interface.py``.
"""
from __future__ import annotations

import dsp_multiplier.backend.ir as IR
from rtl_gen.dsp_multiplier.interface import (
    BlockRequest,
    _kh,
    _sv_type,
    _result_cast,
    _to_signed_expr,
    _term_port_of,
    _distinct_term_ports,
    _bitheap_columns,
    _cmp_out_width,
    _bitheap_max_height,
    _bitheap_is_plain_add,
)


def _inner_ports(kind: str) -> tuple[str, str, str]:
    """Port names for the inner block. Hand-written DSPs use X/Y/P, the LUT
    Bmult uses A/B/P."""
    if kind == "dsp":
        return ("X", "Y", "P")
    return ("A", "B", "P")


def _emit_sub_wrapper(r: BlockRequest) -> list[str]:
    """Sub wrapper: input may be signed/unsigned, sign-extended to signed ->
    parameterized inner -> truncated output."""
    a, b = r.operands                       # (minuend, subtrahend)
    pa, pb = r.inner_a_width, r.inner_b_width
    inner_p_width = max(pa, pb) + 1         # a signed difference needs at most this many bits

    ports = [
        "    input  logic clk",
        f"    input  {_sv_type(a)} A",
        f"    input  {_sv_type(b)} B",
        f"    output {_sv_type(r.result)} P",
    ]
    lines = [f"module {r.module_name} (", ",\n".join(ports), ");", ""]
    lines.append(f"    logic signed [{pa - 1}:0] inner_a;")
    lines.append(f"    logic signed [{pb - 1}:0] inner_b;")
    lines.append(f"    logic signed [{inner_p_width - 1}:0] inner_p;")
    lines.append("")
    lines.append(f"    assign inner_a = {_to_signed_expr(a, pa, 'A')};")
    lines.append(f"    assign inner_b = {_to_signed_expr(b, pb, 'B')};")
    lines.append("")
    lines.append(f"    {_kh()}{r.inner_module_name} #(")
    lines.append(f"        .PA      ({pa}),")
    lines.append(f"        .PB      ({pb}),")
    lines.append(f"        .LATENCY ({r.latency})")
    lines.append("    ) u_inner (")
    lines.append("        .clk (clk),")
    lines.append("        .A   (inner_a),")
    lines.append("        .B   (inner_b),")
    lines.append("        .P   (inner_p)")
    lines.append("    );")
    lines.append("")
    if r.result.width <= inner_p_width:
        result_expr = f"inner_p[{r.result.width - 1}:0]"
    else:
        # the declared result is wider than the inner difference: a size cast on a signed value sign-extends automatically
        result_expr = f"{r.result.width}'(inner_p)"
    lines.append(f"    assign P = {_result_cast(result_expr, r.result)};")
    lines.extend(["", "endmodule", ""])
    return lines


def _emit_mult_wrapper(r: BlockRequest) -> list[str]:
    """Shared DSP / LUT wrapper: sign-pad -> instantiate the inner
    signed x signed block -> truncate the output."""
    a, b = r.operands
    pa, pb = r.inner_a_width, r.inner_b_width

    # transposed: the board's B connects to inner A, the board's A connects to inner B
    if r.orientation == "transposed":
        (src_a, port_a), (src_b, port_b) = (b, "B"), (a, "A")
    else:
        (src_a, port_a), (src_b, port_b) = (a, "A"), (b, "B")

    inner_p_width = pa + pb
    has_reset = (r.kind == "dsp")

    ports = ["    input  logic clk"]
    if has_reset:
        ports.append("    input  logic reset")
    ports.append(f"    input  {_sv_type(a)} A")
    ports.append(f"    input  {_sv_type(b)} B")
    ports.append(f"    output {_sv_type(r.result)} P")

    lines = [f"module {r.module_name} (", ",\n".join(ports), ");", ""]

    if r.inner_signed:
        # DSP / Booth: the inner block is always signed; a narrow operand gets padded to the physical width here
        a_kw = b_kw = p_kw = " signed"
        a_expr = _to_signed_expr(src_a, pa, port_a)
        b_expr = _to_signed_expr(src_b, pb, port_b)
    else:
        # SmallMult: the inner block handles sign itself via A_SIGNED/B_SIGNED, so wire straight through
        a_kw = " signed" if src_a.signed else ""
        b_kw = " signed" if src_b.signed else ""
        p_kw = " signed" if r.result.signed else ""
        a_expr, b_expr = port_a, port_b

    lines.append(f"    logic{a_kw} [{pa - 1}:0] inner_a;")
    lines.append(f"    logic{b_kw} [{pb - 1}:0] inner_b;")
    lines.append(f"    logic{p_kw} [{inner_p_width - 1}:0] inner_p;")
    lines.append("")
    lines.append(f"    assign inner_a = {a_expr};")
    lines.append(f"    assign inner_b = {b_expr};")
    lines.append("")
    ia, ib, ip = _inner_ports(r.kind)
    # This comment matters: the latency the seed library declares and the
    # .sv's actual latency must agree, or the bit heap's alignment FFs get
    # padded by the wrong amount -- the result comes out wrong but
    # synthesis never complains.
    lines.append(f"    // seed library declares inner latency = {r.latency} cycle(s)")
    if r.inner_params:
        lines.append(f"    {_kh()}{r.inner_module_name} #(")
        lines.append(",\n".join(
            f"        .{k:<13}({v})" for k, v in r.inner_params))
        lines.append("    ) u_inner (")
    else:
        lines.append(f"    {_kh()}{r.inner_module_name} u_inner (")
    lines.append("        .clk (clk),")
    if has_reset:
        # The DSP inner blocks (both SingleDSP.sv and the chain/k2/k3/t25
        # generated by latency_model) all carry an in_valid/out_valid
        # handshake, but this IR layer doesn't model per-cycle valid --
        # data is always assumed to flow continuously, so in_valid is tied
        # to 1 and out_valid is left unconnected (SV allows a dangling
        # output port without error).
        lines.append("        .reset (reset),")
        lines.append("        .in_valid (1'b1),")
    lines.append(f"        .{ia}   (inner_a),")
    lines.append(f"        .{ib}   (inner_b),")
    lines.append(f"        .{ip}   (inner_p)")
    lines.append("    );")
    lines.append("")
    result_expr = f"inner_p[{r.result.width - 1}:0]"
    lines.append(f"    assign P = {_result_cast(result_expr, r.result)};")
    lines.extend(["", "endmodule", ""])
    return lines


def _column_bit_expr(cb: IR.ColumnBit, port_of: dict[str, str]) -> str:
    """The SV expression for one bit of a compressor-tree input column."""
    if cb.signal is None:
        return f"1'b{cb.const}"                 # a constant bit (two's-complement +1 / the top bit after inversion)
    expr = f"{port_of[cb.signal.name]}[{cb.bit}]"
    return f"~{expr}" if cb.invert else expr


def _col_decl(name: str, height: int) -> str:
    """A `logic` declaration sized to hold one compressor-tree input column."""
    return f"    logic {name};" if height == 1 else f"    logic [{height - 1}:0] {name};"


# ===========================================================================
# Heaps with column height <= 2: no compressor tree, straight addition in the wrapper
# ===========================================================================

def _extend_expr(port: str, width: int, signed: bool) -> str:
    """Route A (extend): signed replicates the sign bit, unsigned pads with
    0, both extended out to `width` bits.

    Must write $signed explicitly: in SV, as soon as an expression touches
    one unsigned operand, the whole expression degrades to unsigned, sign
    extension turns into zero-padding, and a negative number instantly
    becomes a huge positive one (off by 2^w)."""
    return f"{width}'($signed({port}))" if signed else f"{width}'({port})"


def _removal_expr(port: str, sig_width: int, width: int) -> str:
    """Route C (removal): the sign bit is inverted in place, the high bits
    are zero-padded, no sign extension. This must be paired with recording
    a correction of -2^(lsb+w-1) in the constant row.

    Rationale: s-bar*2^(w-1) - 2^(w-1) == (1-s)*2^(w-1) - 2^(w-1) == -s*2^(w-1)
    i.e. "flip the sign bit and subtract a constant" is exactly equivalent
    to "treat the sign bit as a negative weight". The benefit is the high
    bits no longer carry a long run of sign-bit copies, so the heap is
    much shorter."""
    top = sig_width - 1
    if sig_width == 1:
        body = f"~{port}[0]"                        # only a sign bit, no lower bits
    else:
        body = f"{{~{port}[{top}], {port}[{top - 1}:0]}}"
    return f"{width}'({body})"                      # zero-pad the high bits (body is unsigned)


def _addend_plan(r: BlockRequest, width: int, sign_mode: str):
    """Flatten every term into [(sign, addend name, expression), ...] plus
    one constant correction.

    This is the ONLY place the two sign-handling routes diverge; nothing
    upstream or downstream needs to know which one is in effect:
      extend  -> the correction is always 0
      removal -> the correction = the sum of every -2^(lsb+w-1), already
                 taken mod 2^width into a two's-complement constant

    Only signed, non-negated terms take the removal route: a negated term
    already needs a full-width invert, and combining that with removal's
    "flip only the sign bit" is easy to get wrong. The current Walker
    never produces negate (K2/K3's difference direction was chosen
    precisely so every term is an addition), so this isn't supported yet."""
    port_of = _term_port_of(r)
    pieces: list[tuple[str, str, str]] = []
    corr = 0

    for index, t in enumerate(r.terms):
        port = port_of[t.signal.name]
        w = t.signal.width
        use_removal = (sign_mode == "removal"
                       and t.signal.signed and not t.negate)

        if use_removal:
            expr = _removal_expr(port, w, width)
            e = t.weight + w - 1                    # the column the sign bit lands in
            if e < width:                           # no correction needed if it got truncated off
                corr -= (1 << e)
        else:
            expr = _extend_expr(port, width, t.signal.signed)

        if t.weight:
            # extend first, then shift left: the bits shifted out are
            # exactly the truncation we want, matching lower_bitheap's
            # "only fill c < heap_width" behavior exactly.
            expr = f"({expr} << {t.weight})"
        pieces.append(("-" if t.negate else "+", f"addend{index}", expr))

    return pieces, corr & ((1 << width) - 1)        # fold into a width-bit two's-complement constant


def _emit_bitheap_add_wrapper(r: BlockRequest) -> list[str]:
    """Column height <=2: don't instantiate a compressor tree, have the
    wrapper do the add/subtract + pipeline registers itself.

    Mathematically identical to the compressor-tree version -- lower_bitheap
    flattens exactly this addition down to bit level for the GPC tree to
    compress. This just goes back to word-level expressions, so synthesis
    infers an ordinary adder, which is cheaper than a GPC tree."""
    w = r.result.width
    pieces, correction = _addend_plan(r, w, r.sign_mode)

    ports = ["    input  logic clk"]
    for pname, sig in _distinct_term_ports(r):
        ports.append(f"    input  {_sv_type(sig)} {pname}")
    ports.append(f"    output {_sv_type(r.result)} P")

    lines = [f"module {r.module_name} (", ",\n".join(ports), ");", ""]
    lines.append(f"    // tallest column has only {_bitheap_max_height(r)} bit(s), "
                 f"no GPC compressor tree needed; sign_mode={r.sign_mode}")
    lines.append(f"    logic [{w - 1}:0] sum_comb;")
    lines.append("")

    # each term gets its own assign, not folded into one big expression (see _extend_expr's comment)
    for _, name, expr in pieces:
        lines.append(f"    logic [{w - 1}:0] {name};")
        lines.append(f"    assign {name} = {expr};")
    lines.append("")

    if correction:
        lines.append("    // sign-extension removal: the constant row folding all the -2^e corrections together")
        lines.append(f"    localparam logic [{w - 1}:0] SIGN_CORR = "
                     f"{w}'h{correction:x};")
        lines.append("")

    # everything summed as w-bit unsigned, mod 2^w. Two's-complement
    # addition/subtraction has the identical bit pattern whether treated
    # as signed or unsigned, so each term's own sign doesn't matter here.
    body = ""
    for sign, name, _ in pieces:
        if not body:
            body = name if sign == "+" else f"-{name}"
        else:
            body += f" {sign} {name}"
    if correction:
        body += " + SIGN_CORR"
    lines.append(f"    assign sum_comb = {body};")
    lines.append("")

    if r.latency <= 0:
        lines.append(f"    assign P = {_result_cast('sum_comb', r.result)};")
    else:
        lines.append(f"    logic [{w - 1}:0] stage [0:{r.latency - 1}];")
        lines.append("    always_ff @(posedge clk) begin")
        lines.append("        stage[0] <= sum_comb;")
        if r.latency > 1:
            lines.append(f"        for (int i = 1; i < {r.latency}; i++) "
                         "stage[i] <= stage[i-1];")
        lines.append("    end")
        lines.append(f"    assign P = "
                     f"{_result_cast(f'stage[{r.latency - 1}]', r.result)};")

    lines.extend(["", "endmodule", ""])
    return lines


def _emit_bitheap_wrapper(r: BlockRequest) -> list[str]:
    """Split the term signals into column bit vectors, feed them to the
       compressor tree, and truncate comp_out back to P.
       Heaps with column height <=2 take a different path: no compressor
       tree, straight addition instead."""
    if _bitheap_is_plain_add(r):
        return _emit_bitheap_add_wrapper(r)

    cols = _bitheap_columns(r)
    port_of = _term_port_of(r)
    out_w = _cmp_out_width(cols)

    ports = ["    input  logic clk"]
    for pname, sig in _distinct_term_ports(r):
        ports.append(f"    input  {_sv_type(sig)} {pname}")
    ports.append(f"    output {_sv_type(r.result)} P")

    lines = [f"module {r.module_name} (", ",\n".join(ports), ");", ""]
    lines.append(f"    // heap_width={r.result.width}, comp_out={out_w} bits")
    lines.append(f"    logic [{out_w - 1}:0] comp_out;")
    lines.append("")

    used: list[int] = []
    for c, bits in enumerate(cols):
        if not bits:
            continue                            # empty columns don't appear in the interface
        used.append(c)
        name = f"in_col{c}"
        lines.append(_col_decl(name, len(bits)))
        exprs = [_column_bit_expr(cb, port_of) for cb in bits]
        if len(bits) == 1:
            lines.append(f"    assign {name} = {exprs[0]};")
        else:
            # the compressor tree only cares how many 1s are in this column; bit order doesn't matter
            lines.append(f"    assign {name} = {{{', '.join(reversed(exprs))}}};")
    lines.append("")

    conn = ["        .clk      (clk)"]
    for c in used:
        conn.append(f"        .in_col{c} (in_col{c})")
    conn.append("        .comp_out (comp_out)")
    lines.append(f"    {_kh()}{r.inner_module_name} u_cmp (")
    lines.append(",\n".join(conn))
    lines.append("    );")
    lines.append("")

    # comp_out is normally wider than heap_width; the high bits are
    # overflow, and truncating gives the true value. The reverse case
    # (out_w < heap_width) can't happen in the current IR:
    #   - a Karatsuba node always has a signed term, so the sign bit
    #     propagates up to the top column;
    #   - within a Tiling leaf, any rectangle containing the top-right
    #     cell must also touch the A/B high edges, so the top column is
    #     non-empty there too.
    # top column non-empty => weighted sum >= 2^(heap_width-1) => out_w >= heap_width.
    if out_w < r.result.width:
        raise AssertionError(
            f"{r.module_name}: comp_out={out_w} bits < heap_width={r.result.width} bits "
            f"(sign_mode={r.sign_mode}). Column {r.result.width - 1} has no bits at all, "
            "most likely a term's weight was computed wrong, or the tile/rectangle "
            "covering the top bit never made it into the heap."
        )

    result_expr = f"comp_out[{r.result.width - 1}:0]"
    lines.append(f"    assign P = {_result_cast(result_expr, r.result)};")
    lines.extend(["", "endmodule", ""])
    return lines
