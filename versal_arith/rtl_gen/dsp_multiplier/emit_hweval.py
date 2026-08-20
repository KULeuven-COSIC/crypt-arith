# rtl/emit_hweval.py
"""Generate the synthesis/on-hardware evaluation shell (hweval) for an
(already-aligned) IRModule.

direct form       -- inputs registered one cycle, wired straight to the
                      DUT, every port broken out. Only fits modules with
                      small width / an acceptable pin count.
lfsr form          -- stimulus is self-generated on-chip by an LFSR,
                      output XOR-compressed to 1 bit; even a 64x64 only
                      needs ~21 external ports. Requires LFSR.sv already
                      being in the project.
with_checker       -- a behavioral multiply + LAT-stage pipeline as an
                      on-chip reference model, raising a sticky error bit
                      on mismatch (wired to a VIO/LED to observe).
"""
from __future__ import annotations
from pathlib import Path

from dsp_multiplier.backend.schedule import module_latency
import dsp_multiplier.backend.ir as IR


def _sv_type(sig: IR.Signal) -> str:
    s = " signed" if sig.signed else ""
    return f"logic{s} [{sig.width - 1}:0]"


def _resolve_style(module: IR.IRModule, style: str,
                   max_direct_pins: int) -> str:
    """The single decision point for the hweval style, shared by emit/write."""
    if style == "auto":
        a, b = module.inputs[0], module.inputs[1]
        pin_count = a.width + b.width + module.output.width + 2
        style = "direct" if pin_count <= max_direct_pins else "lfsr"
    if style not in ("direct", "lfsr"):
        raise ValueError(f"unknown style {style!r}")
    return style


def _emit_hweval(module: IR.IRModule, *, style: str,
                 dut_name: str | None = None) -> str:
    """Emit the wrapper for an already-resolved style; no auto-detection here."""
    A, B = module.inputs[0], module.inputs[1]
    out = module.output
    dut = dut_name or module.name
    lat = module_latency(module)
    if lat < 1:
        raise ValueError("hweval assumes pipeline latency >= 1")
    aw, bw, pw = A.width, B.width, out.width

    lines = ["`timescale 1ns / 1ps", ""]

    if style == "lfsr":
        ports = [
            "    input  logic        clk",
            "    input  logic        resetn",
            "    input  logic [15:0] in_init",
            "    output logic        out",
        ]
        lines += [f"module {dut}_hweval (", ",\n".join(ports), ");", ""]
        lines += [
            f"    localparam int AW  = {aw};",
            f"    localparam int BW  = {bw};",
            f"    localparam int PW  = {pw};",
            f"    localparam int LAT = {lat};",
            "",
            "    // ---- on-chip stimulus: the LFSR emits AW+BW bits at once ----",
            "    logic [AW+BW-1:0] stim;",
            "    LFSR #(.OUT_WIDTH(AW + BW)) u_lfsr (",
            "        .clk(clk), .resetn(resetn), .in_init(in_init), .out(stim)",
            "    );",
            "",
            "    // ---- register the inputs one cycle, to trim the entry path ----",
            f"    {_sv_type(A)} A_reg;",
            f"    {_sv_type(B)} B_reg;",
            "    always_ff @(posedge clk) begin",
            "        A_reg <= stim[AW-1:0];",
            "        B_reg <= stim[AW+BW-1:AW];",
            "    end",
            "",
            f"    {_sv_type(out)} P;",
            f'    (* keep_hierarchy = "yes" *) {dut} dut (.clk(clk), .reset(~resetn),',
            "               .A(A_reg), .B(B_reg), .P(P));",
            "",
            "    // ---- compress the output: XOR-reduce and register once more, so the DUT can't be trimmed away by synthesis ----",
            "    always_ff @(posedge clk) out <= ^P;",
        ]

    else:  # direct
        ports = [
            "    input  logic clk",
            "    input  logic reset",
            f"    input  {_sv_type(A)} A",
            f"    input  {_sv_type(B)} B",
            f"    output {_sv_type(out)} P",
        ]
        lines += [f"module {dut}_hweval (", ",\n".join(ports), ");", ""]
        lines += [
            f"    localparam int PW  = {pw};",
            f"    localparam int LAT = {lat};",
            "",
            f"    {_sv_type(A)} A_reg;",
            f"    {_sv_type(B)} B_reg;",
            "    always_ff @(posedge clk) begin",
            "        A_reg <= A;",
            "        B_reg <= B;",
            "    end",
            "",
            f'    (* keep_hierarchy = "yes" *) {dut} dut (.clk(clk), .reset(reset),',
            "               .A(A_reg), .B(B_reg), .P(P));",
        ]

    lines += ["", "endmodule", ""]
    return "\n".join(lines)


def emit_hweval(module: IR.IRModule, *,
                style: str = "auto",
                max_direct_pins: int = 100,
                dut_name: str | None = None) -> str:
    """The hweval wrapper's SystemVerilog source, as a string. style="auto"
    picks "direct" when the pin count fits max_direct_pins, else "lfsr"."""
    resolved_style = _resolve_style(module, style, max_direct_pins)
    return _emit_hweval(
        module,
        style=resolved_style,
        dut_name=dut_name,
    )


def write_hweval(module: IR.IRModule, outdir: str | Path, *,
                 clock_period_ns: float = 5.0,
                 **kw) -> dict[str, Path]:
    """Write hweval.sv + the OOC clock constraint. The lfsr form also copies
       out and returns the supporting RTL it needs."""
    out = Path(outdir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    name = f"{module.name}_hweval"

    emit_kw = dict(kw)
    requested_style = emit_kw.pop("style", "auto")
    max_direct_pins = emit_kw.pop("max_direct_pins", 100)
    resolved_style = _resolve_style(
        module, requested_style, max_direct_pins,
    )

    sv = out / f"{name}.sv"
    sv.write_text(
        _emit_hweval(module, style=resolved_style, **emit_kw),
        encoding="utf-8",
    )

    xdc = out / f"{name}_ooc.xdc"
    xdc.write_text(
        # Round to 3 decimals (ps resolution, matching Vivado's own timing
        # precision) so a value derived from arithmetic like worst_ns * 1.25
        # doesn't leave a binary-float artifact (e.g. 5.074999999999999)
        # sitting in the constraint file. Cosmetic only -- doesn't change
        # the constraint the tool actually sees.
        f"create_clock -period {clock_period_ns:.3f} -name clk [get_ports clk]\n",
        encoding="utf-8",
    )
    paths = {"sv": sv, "xdc": xdc}

    if resolved_style == "lfsr":
        # lfsr-style hweval instantiates LFSR directly by module name (see
        # _emit_hweval above) -- without a copy sitting next to it,
        # synth_design's RTL elaboration fails with "module 'LFSR' not
        # found" since it's nowhere in the design's source list.
        lfsr_src = Path(__file__).resolve().parents[2] / "rtl" / "LFSR.sv"
        if not lfsr_src.is_file():
            raise RuntimeError(f"lfsr hweval style needs {lfsr_src}, not found")
        lfsr_dst = out / "LFSR.sv"
        lfsr_dst.write_text(lfsr_src.read_text(encoding="utf-8"), encoding="utf-8")
        paths["lfsr"] = lfsr_dst

    return paths
