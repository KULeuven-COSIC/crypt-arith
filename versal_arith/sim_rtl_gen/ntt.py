"""Behavioral NTT/INTT pipeline RTL generator (simulation-only).

Composes per-butterfly behavioral modules (via `render_butterfly_sv`) into a
complete fully-pipelined NTT/INTT datapath:

  - One concatenated `RTL_generated/<topName>_butterflies.sv` containing every
    butterfly module (banner-separated). No per-butterfly `.sv` files.
  - `RTL_generated/<topName>.sv` top wrapper that instantiates butterflies
    per the in-place memory layout.
  - `RTL_generated/<topName>_tb.sv` self-checking top testbench (when
    `gen_testbench=True`).
  - `testvectors/x_in.txt` and `y_out.txt` packed-hex testvectors
    (when `gen_testbench=True`).
  - `manifest.json` summarizing pipeline latency and butterfly module names.

No `xdc_generated/` and no bit-heap intermediate `.txt` files are written —
the sim backend has no place-and-route artifacts.

Within-layer balancing is trivial here because the sim backend controls
butterfly latency directly: every butterfly in layer `s` has latency
`pipeline_stages_per_layer[s]` exactly. The hw backend's auto-balancing
shift-register logic collapses to a one-line passthrough per butterfly.

Drop-in API match for `rtl_gen.ntt.NTT_RTL_gen` so the upstream `emitRtl`
dispatcher can swap on a `backend` kwarg.
"""

from __future__ import annotations
import json
import os

from ntt_spec import NTTOperatorSpec
from rtl_gen.ntt import _pack_per_slot, _write_packed_hex
from sim_rtl_gen.butterfly import render_butterfly_sv


# ---------------------------------------------------------------------------
# Top wrapper SV (no within-layer balancing needed — see module docstring)
# ---------------------------------------------------------------------------

def _emit_top_wrapper(spec: NTTOperatorSpec, layer_latency: list[int]) -> str:
    n = spec.n
    L = len(spec.butterflySpecs)
    in_widths = spec.inputBitWidthsNatural
    out_widths = spec.outputBitWidthsNatural

    lines: list[str] = []
    lines.append("`timescale 1ns / 1ps")
    lines.append("")
    lines.append(f"// Behavioral simulation-only Goldilocks NTT/INTT pipeline.")
    lines.append(f"// butterflyType={spec.butterflyType}, n={n}, negacyclic={spec.negacyclic}")
    lines.append(f"// Per-layer pipeline latency: {layer_latency}")
    lines.append(f"// Total pipeline latency: {sum(layer_latency)} cycle(s)")
    lines.append(f"// Per-index named ports x_in_<i> / y_out_<i> (i = 0..{n-1}).")
    lines.append(f"// x_in_<i>  per-index widths: {min(in_widths)}..{max(in_widths)} bit.")
    lines.append(f"// y_out_<i> per-index widths: {min(out_widths)}..{max(out_widths)} bit.")
    lines.append(f"// Butterfly module bodies live in {spec.name}_butterflies.sv (this is the wrapper).")
    lines.append(f"module {spec.name} (")
    lines.append("    input  logic clk,")
    for i in range(n):
        lines.append(f"    input  logic [{in_widths[i] - 1}:0] x_in_{i},")
    for i in range(n):
        suffix = "," if i < n - 1 else ""
        lines.append(f"    output logic [{out_widths[i] - 1}:0] y_out_{i}{suffix}")
    lines.append("    );")
    lines.append("")

    lines.append("    // ---- Per-butterfly output wires (latency uniform within each layer) ----")
    for s in range(L):
        for p in range(n // 2):
            bs = spec.butterflySpecs[s][p]
            lines.append(f"    logic [{bs.aOutBitWidth - 1}:0] s{s}_p{p}_aOut;")
            lines.append(f"    logic [{bs.bOutBitWidth - 1}:0] s{s}_p{p}_bOut;")
    lines.append("")

    lines.append("    // ---- Butterfly instances ----")
    for s in range(L):
        for p in range(n // 2):
            bs = spec.butterflySpecs[s][p]
            mod = bs.name
            inst = f"{mod}_inst"
            if s == 0:
                ax, bx = spec.inputWiring[p]
                a_in = f"x_in_{ax}"
                b_in = f"x_in_{bx}"
            else:
                wA, wB = spec.interStageWiring[s - 1][p]
                a_in = f"s{s-1}_p{wA.src_p}_{'aOut' if wA.src_port == 'A' else 'bOut'}"
                b_in = f"s{s-1}_p{wB.src_p}_{'aOut' if wB.src_port == 'A' else 'bOut'}"
            lines.append(f"    {mod} {inst} (")
            lines.append(f"        .clk (clk),")
            lines.append(f"        .aIn ({a_in}),")
            lines.append(f"        .bIn ({b_in}),")
            lines.append(f"        .aOut(s{s}_p{p}_aOut),")
            lines.append(f"        .bOut(s{s}_p{p}_bOut)")
            lines.append(f"    );")
    lines.append("")

    lines.append("    // ---- Final-stage to natural-order outputs ----")
    for p in range(n // 2):
        natA, natB = spec.outputWiring[p]
        lines.append(f"    assign y_out_{natA} = s{L-1}_p{p}_aOut;")
        lines.append(f"    assign y_out_{natB} = s{L-1}_p{p}_bOut;")
    lines.append("")
    lines.append("endmodule")

    return "\n".join(lines) + "\n"


# ---------------------------------------------------------------------------
# Top testbench SV
# ---------------------------------------------------------------------------

def _emit_top_testbench(spec: NTTOperatorSpec, total_latency: int, test_size: int) -> str:
    n = spec.n
    in_widths = spec.inputBitWidthsNatural
    out_widths = spec.outputBitWidthsNatural
    total_in_bits = sum(in_widths)
    total_out_bits = sum(out_widths)

    in_offsets = [0]
    for w in in_widths:
        in_offsets.append(in_offsets[-1] + w)
    out_offsets = [0]
    for w in out_widths:
        out_offsets.append(out_offsets[-1] + w)

    lines: list[str] = []
    lines.append("`timescale 1ns / 1ps")
    lines.append("")
    lines.append(f"// Self-checking testbench for {spec.name} (behavioral sim backend).")
    lines.append(f"// Total pipeline latency: {total_latency} cycle(s).")
    lines.append(f"// PASS/FAIL grep tokens (SUCCESS!, PASS All, FAILED:) match the hw backend.")
    lines.append(f"module {spec.name}_tb ();")
    lines.append("    `define CLK_P         10")
    lines.append("    `define CLK_HP        5")
    lines.append(f"    `define TS_SIZE       {test_size}")
    lines.append("    `define INIT_RESET    200")
    lines.append("")
    lines.append("    logic clk;")
    lines.append("    initial clk = 1'b0;")
    lines.append("    always #`CLK_HP clk = ~clk;")
    lines.append("")

    for i in range(n):
        lines.append(f"    logic [{in_widths[i] - 1}:0] x_in_{i};")
    for i in range(n):
        lines.append(f"    logic [{out_widths[i] - 1}:0] y_out_{i};")
    lines.append("")

    lines.append(f"    logic [{total_in_bits - 1}:0]  x_in_ts  [`TS_SIZE-1:0];")
    lines.append(f"    logic [{total_out_bits - 1}:0] y_out_ts [`TS_SIZE-1:0];")
    lines.append("")

    lines.append("    initial begin")
    lines.append("        $readmemh(\"../../../../../testvectors/x_in.txt\",  x_in_ts );")
    lines.append("        $readmemh(\"../../../../../testvectors/y_out.txt\", y_out_ts);")
    lines.append("    end")
    lines.append("")

    lines.append(f"    {spec.name} DUT (")
    lines.append("        .clk(clk),")
    for i in range(n):
        lines.append(f"        .x_in_{i}(x_in_{i}),")
    for i in range(n):
        suffix = "," if i < n - 1 else ""
        lines.append(f"        .y_out_{i}(y_out_{i}){suffix}")
    lines.append("    );")
    lines.append("")

    concat_actual = ", ".join(f"y_out_{i}" for i in range(n - 1, -1, -1))
    lines.append(f"    logic [{total_out_bits - 1}:0] y_out_packed;")
    lines.append(f"    assign y_out_packed = {{{concat_actual}}};")
    lines.append("")

    lines.append("    int i;")
    lines.append("    initial begin")
    lines.append("        #`INIT_RESET;")
    lines.append("        #`CLK_HP;")
    lines.append("        #1;")
    lines.append("        for (i = 0; i < `TS_SIZE; i = i + 1) begin")
    for k in range(n):
        hi = in_offsets[k + 1] - 1
        lo = in_offsets[k]
        lines.append(f"            x_in_{k} = x_in_ts[i][{hi}:{lo}];")
    lines.append("            #`CLK_P;")
    lines.append("        end")
    lines.append("    end")
    lines.append("")

    lines.append("    int j;")
    lines.append("    int correct_cnt;")
    lines.append("    initial begin")
    lines.append("        correct_cnt = 0;")
    lines.append("        #`INIT_RESET;")
    lines.append("        #`CLK_HP;")
    lines.append(f"        #(`CLK_P*{total_latency});")
    lines.append("        #1;")
    lines.append("        for (j = 0; j < `TS_SIZE; j = j + 1) begin")
    lines.append("            if (y_out_packed === y_out_ts[j]) begin")
    lines.append("                $display(\"Testvector-%d CORRECT!\", j);")
    lines.append("                correct_cnt = correct_cnt + 1;")
    lines.append("            end else begin")
    lines.append("                $display(\"=================================================================================\");")
    lines.append("                $display(\"Testvector-%d WRONG\", j);")
    for i in range(n):
        hi = out_offsets[i + 1] - 1
        lo = out_offsets[i]
        lines.append(f"                if (y_out_{i} !== y_out_ts[j][{hi}:{lo}]) begin")
        lines.append(f"                    $display(\"  y_out_{i} module    output: %h\", y_out_{i});")
        lines.append(f"                    $display(\"  y_out_{i} reference output: %h\", y_out_ts[j][{hi}:{lo}]);")
        lines.append(f"                end")
    lines.append("                $display(\"=================================================================================\");")
    lines.append("            end")
    lines.append("            #`CLK_P;")
    lines.append("        end")
    lines.append("        if (correct_cnt == `TS_SIZE) begin")
    lines.append("            $display(\"SUCCESS!\");")
    lines.append("            $display(\"PASS All %d Testvectors!\", `TS_SIZE);")
    lines.append("        end else begin")
    lines.append("            $display(\"TO BE DEBUGGED...\");")
    lines.append("            $display(\"FAILED: %d out of %d testvectors failed\", (`TS_SIZE-correct_cnt), `TS_SIZE);")
    lines.append("        end")
    lines.append("        $finish();")
    lines.append("    end")
    lines.append("")
    lines.append("endmodule")

    return "\n".join(lines) + "\n"


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def NTT_SimRTL_gen(
    spec: NTTOperatorSpec,
    pipeline_stages_per_layer: list[int],
    gen_testbench: bool = True,
    test_size: int = 1000,
    seed: int | None = None,
    visualization: bool = False,  # accepted for API parity; ignored
    golden_x_natural: list[list[int]] | None = None,
    golden_y_natural: list[list[int]] | None = None,
) -> dict:
    """Emit behavioral simulation-only SystemVerilog for a Goldilocks
    NTT/INTT pipeline. Drop-in alternative to `rtl_gen.ntt.NTT_RTL_gen`.

    Files written (relative to cwd):
        RTL_generated/<spec.name>.sv               top wrapper
        RTL_generated/<spec.name>_butterflies.sv   all butterfly modules concatenated
        RTL_generated/<spec.name>_tb.sv            top TB (gen_testbench=True)
        testvectors/x_in.txt, testvectors/y_out.txt (gen_testbench=True)
        manifest.json                              pipeline latency / module list

    No per-butterfly `.sv` files, no `xdc_generated/`, no `*_bitheap.txt`.
    """
    n = spec.n
    L = len(spec.butterflySpecs)
    if len(pipeline_stages_per_layer) != L:
        raise ValueError(
            f"pipeline_stages_per_layer must have length log2(n)={L}, "
            f"got {len(pipeline_stages_per_layer)}"
        )
    if gen_testbench:
        if golden_x_natural is None or golden_y_natural is None:
            raise ValueError(
                "NTT_SimRTL_gen: golden_x_natural and golden_y_natural are required "
                "when gen_testbench=True"
            )
        if len(golden_x_natural) != test_size or len(golden_y_natural) != test_size:
            raise ValueError(
                f"golden batches must have length test_size={test_size}; "
                f"got x={len(golden_x_natural)}, y={len(golden_y_natural)}"
            )
        for r, row in enumerate(golden_x_natural):
            if len(row) != n:
                raise ValueError(f"golden_x_natural[{r}] has {len(row)} entries, expected n={n}")
        for r, row in enumerate(golden_y_natural):
            if len(row) != n:
                raise ValueError(f"golden_y_natural[{r}] has {len(row)} entries, expected n={n}")

    # Render every butterfly into one buffer; collect names and latencies for
    # the manifest. All butterflies in a layer share the same pipeline_stages
    # value, so layer_latency == pipeline_stages_per_layer (clamped to >=1).
    butterfly_module_names: list[list[str]] = []
    butterfly_latencies: list[list[int]] = []
    butterflies_sv_parts: list[str] = [
        "`timescale 1ns / 1ps",
        "",
        f"// Concatenated butterfly modules for {spec.name} (behavioral sim backend).",
        f"// One module per (layer, position): naming = {spec.name}_btf_L<s>_p<p>.",
        "",
    ]
    for s in range(L):
        layer_names: list[str] = []
        layer_lats: list[int] = []
        stages = pipeline_stages_per_layer[s]
        for p in range(n // 2):
            bs = spec.butterflySpecs[s][p]
            sv_text, meta = render_butterfly_sv(bs, pipeline_stages=stages)
            butterflies_sv_parts.append(f"// ===== {bs.name} =====")
            butterflies_sv_parts.append(sv_text)
            layer_names.append(bs.name)
            layer_lats.append(meta["pipeline_latency"])
        butterfly_module_names.append(layer_names)
        butterfly_latencies.append(layer_lats)

    layer_latency = [max(layer_lats) for layer_lats in butterfly_latencies]
    total_latency = sum(layer_latency)

    rtl_dir = "RTL_generated"
    os.makedirs(rtl_dir, exist_ok=True)

    # Single consolidated butterfly file.
    with open(os.path.join(rtl_dir, f"{spec.name}_butterflies.sv"), "w", encoding="utf-8") as f:
        f.write("\n".join(butterflies_sv_parts))

    # Top wrapper.
    wrapper_sv = _emit_top_wrapper(spec, layer_latency)
    with open(os.path.join(rtl_dir, f"{spec.name}.sv"), "w", encoding="utf-8") as f:
        f.write(wrapper_sv)

    # Top testbench + testvectors.
    if gen_testbench:
        tv_dir = "testvectors"
        os.makedirs(tv_dir, exist_ok=True)
        _write_packed_hex(os.path.join(tv_dir, "x_in.txt"), golden_x_natural,
                          list(spec.inputBitWidthsNatural))
        _write_packed_hex(os.path.join(tv_dir, "y_out.txt"), golden_y_natural,
                          list(spec.outputBitWidthsNatural))
        tb_sv = _emit_top_testbench(spec, total_latency, test_size)
        with open(os.path.join(rtl_dir, f"{spec.name}_tb.sv"), "w", encoding="utf-8") as f:
            f.write(tb_sv)

    manifest = {
        "top_name": spec.name,
        "n": n,
        "butterflyType": spec.butterflyType,
        "negacyclic": spec.negacyclic,
        "pipeline_stages_per_layer": list(pipeline_stages_per_layer),
        "butterfly_latencies": butterfly_latencies,
        "layer_latency": layer_latency,
        "total_latency": total_latency,
        "test_size": test_size if gen_testbench else 0,
        "butterfly_module_names": butterfly_module_names,
        "backend": "sim",
    }
    with open("manifest.json", "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2)

    return manifest
