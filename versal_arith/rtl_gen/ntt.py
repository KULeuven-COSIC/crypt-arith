"""NTT/INTT pipeline RTL generator.

Composes per-butterfly RTL units (via Butterfly_RTL_gen) into a complete
fully-pipelined NTT/INTT datapath: a top wrapper that wires butterflies per
the in-place memory layout, an end-to-end self-checking testbench with
natural-order input/output testvectors, aggregated XDC files, and a JSON
manifest summarizing pipeline latency.

Consumes an `NTTOperatorSpec` (produced by
`NTT_modeling.NTT.FullyPipelinedNTT.getOperatorInterface`) and the
per-layer pipeline-stage configuration. The user is responsible for
providing precomputed natural-order goldens (typically by running batches
through the populated FullyPipelinedNTT instance — same approach as
`NTT_modeling._verifyImpl`).
"""

from __future__ import annotations
import json
import os

from ntt_spec import NTTOperatorSpec, InterStageWire
from rtl_gen.butterfly import Butterfly_RTL_gen


# ---------------------------------------------------------------------------
# Hex packing for the natural-order x_in / y_out testvector files
# ---------------------------------------------------------------------------

def _consolidate_butterfly_artifacts(
    rtl_dir: str,
    spec: NTTOperatorSpec,
    butterfly_module_names: list[list[str]],
) -> None:
    """Merge the 3 × (n/2 × log2(n)) per-butterfly artifacts produced by
    `Butterfly_RTL_gen` into two consolidated SV files and clean up the
    bit-heap intermediates.

    After this call `RTL_generated/` contains exactly:
      - `<TOP>_butterflies.sv`  — every butterfly wrapper module
      - `<TOP>_compressors.sv`  — every aOut + bOut compressor module
      - `<TOP>.sv`              — top wrapper (written by the caller)
      - `<TOP>_tb.sv`           — top testbench (written by the caller when
                                  `gen_testbench=True`)

    And the run-dir root no longer has any `<butterfly>_<aOut|bOut>_bitheap.txt`
    files (those were compressor inputs at gen time; useless after).

    The XDCs in `xdc_generated/` are left alone — they carry LUTNM placement
    keyed on specific compressor module instances and Vivado expects them as
    separate files added to the implementation set.
    """
    wrappers: list[str] = []
    compressors: list[str] = []
    for layer in butterfly_module_names:
        for mod in layer:
            wrapper_path = os.path.join(rtl_dir, f"{mod}.sv")
            a_cmp_path   = os.path.join(rtl_dir, f"{mod}_aOut_cmp.sv")
            b_cmp_path   = os.path.join(rtl_dir, f"{mod}_bOut_cmp.sv")
            if os.path.isfile(wrapper_path):
                with open(wrapper_path, "r", encoding="utf-8") as f:
                    wrappers.append(f"// ===== {mod} =====\n{f.read()}")
                os.remove(wrapper_path)
            if os.path.isfile(a_cmp_path):
                with open(a_cmp_path, "r", encoding="utf-8") as f:
                    compressors.append(f"// ===== {mod}_aOut_cmp =====\n{f.read()}")
                os.remove(a_cmp_path)
            if os.path.isfile(b_cmp_path):
                with open(b_cmp_path, "r", encoding="utf-8") as f:
                    compressors.append(f"// ===== {mod}_bOut_cmp =====\n{f.read()}")
                os.remove(b_cmp_path)
            # Bit-heap descriptor txt files (one per compressor) live in
            # cwd (= run-dir root), not under RTL_generated/.
            for suffix in ("_aOut_bitheap.txt", "_bOut_bitheap.txt"):
                p = f"{mod}{suffix}"
                if os.path.isfile(p):
                    os.remove(p)

    if wrappers:
        with open(os.path.join(rtl_dir, f"{spec.name}_butterflies.sv"), "w", encoding="utf-8") as f:
            f.write("`timescale 1ns / 1ps\n\n")
            f.write(f"// Consolidated butterfly wrapper modules for {spec.name}.\n")
            f.write(f"// One module per (layer, position): {spec.name}_btf_L<s>_p<p>.\n\n")
            f.write("\n".join(wrappers))
    if compressors:
        with open(os.path.join(rtl_dir, f"{spec.name}_compressors.sv"), "w", encoding="utf-8") as f:
            f.write("`timescale 1ns / 1ps\n\n")
            f.write(f"// Consolidated compressor modules for {spec.name}.\n")
            f.write(f"// Two per butterfly: {spec.name}_btf_L<s>_p<p>_{{aOut,bOut}}_cmp.\n\n")
            f.write("\n".join(compressors))


def _pack_per_slot(values: list[int], widths: list[int]) -> str:
    """Pack a list of n values (per-slot widths) into a single hex string.
    `values[0]` occupies the LSBs, `values[n-1]` the MSBs — matching the SV
    concatenation `{values[n-1], ..., values[0]}` so a $readmemh into a wide
    logic vector aligns with the TB's slot slicing."""
    total = 0
    offset = 0
    for v, w in zip(values, widths):
        if v < 0:
            v = (1 << w) + v
        v &= (1 << w) - 1
        total |= v << offset
        offset += w
    total_bits = sum(widths)
    hex_width = (total_bits + 3) // 4
    return f"{total:0{hex_width}X}"


def _write_packed_hex(path: str, batches: list[list[int]], widths: list[int]) -> None:
    """One packed hex per cycle; `batches` is shape test_size x n."""
    with open(path, "w", encoding="utf-8") as f:
        for batch in batches:
            f.write(_pack_per_slot(batch, widths) + "\n")


# ---------------------------------------------------------------------------
# Top wrapper SystemVerilog
# ---------------------------------------------------------------------------

def _emit_top_wrapper(
    spec: NTTOperatorSpec,
    layer_latency: list[int],
    butterfly_latencies: list[list[int]],
) -> str:
    n = spec.n
    L = len(spec.butterflySpecs)
    in_widths = spec.inputBitWidthsNatural
    out_widths = spec.outputBitWidthsNatural

    lines: list[str] = []
    lines.append("`timescale 1ns / 1ps")
    lines.append("")
    lines.append(f"// Goldilocks NTT/INTT pipeline: butterflyType={spec.butterflyType}, n={n}, negacyclic={spec.negacyclic}")
    lines.append(f"// Per-layer pipeline latency: {layer_latency}")
    lines.append(f"// Total pipeline latency: {sum(layer_latency)} cycle(s)")
    lines.append(f"// Natural-order I/O via per-index named ports x_in_<i> / y_out_<i> (i = 0..{n-1}).")
    lines.append(f"// x_in_<i>  per-index widths range {min(in_widths)}..{max(in_widths)} bit (per stage-0 butterfly port bound).")
    lines.append(f"// y_out_<i> per-index widths range {min(out_widths)}..{max(out_widths)} bit (per final-stage butterfly port bound).")
    lines.append(f"module {spec.name} (")
    lines.append("    input  logic clk,")
    for i in range(n):
        lines.append(f"    input  logic [{in_widths[i] - 1}:0] x_in_{i},")
    for i in range(n):
        suffix = "," if i < n - 1 else ""
        lines.append(f"    output logic [{out_widths[i] - 1}:0] y_out_{i}{suffix}")
    lines.append("    );")
    lines.append("")

    lines.append("    // ---- Per-butterfly raw output wires (DUT outputs before within-layer balancing) ----")
    for s in range(L):
        for p in range(n // 2):
            bs = spec.butterflySpecs[s][p]
            lines.append(f"    logic [{bs.aOutBitWidth - 1}:0] s{s}_p{p}_aOut_raw;")
            lines.append(f"    logic [{bs.bOutBitWidth - 1}:0] s{s}_p{p}_bOut_raw;")
    lines.append("")

    lines.append("    // ---- Per-butterfly post-balancing output wires (feeds next layer / final outputs) ----")
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
            lines.append(f"        .aOut(s{s}_p{p}_aOut_raw),")
            lines.append(f"        .bOut(s{s}_p{p}_bOut_raw)")
            lines.append(f"    );")
    lines.append("")

    lines.append("    // ---- Within-layer balancing shift registers ----")
    has_any_extra = any(layer_latency[s] - butterfly_latencies[s][p] > 0
                        for s in range(L) for p in range(n // 2))
    for s in range(L):
        for p in range(n // 2):
            extra = layer_latency[s] - butterfly_latencies[s][p]
            if extra == 0:
                lines.append(f"    assign s{s}_p{p}_aOut = s{s}_p{p}_aOut_raw;")
                lines.append(f"    assign s{s}_p{p}_bOut = s{s}_p{p}_bOut_raw;")
            else:
                bs = spec.butterflySpecs[s][p]
                aw = bs.aOutBitWidth
                bw = bs.bOutBitWidth
                # Intermediate shift register stages d1..d{extra-1}; the final stage
                # drives s{s}_p{p}_aOut/_bOut (no _d suffix).
                for d in range(1, extra):
                    lines.append(f"    logic [{aw - 1}:0] s{s}_p{p}_aOut_d{d};")
                    lines.append(f"    logic [{bw - 1}:0] s{s}_p{p}_bOut_d{d};")
                lines.append(f"    always_ff @(posedge clk) begin")
                if extra == 1:
                    lines.append(f"        s{s}_p{p}_aOut <= s{s}_p{p}_aOut_raw;")
                    lines.append(f"        s{s}_p{p}_bOut <= s{s}_p{p}_bOut_raw;")
                else:
                    lines.append(f"        s{s}_p{p}_aOut_d1 <= s{s}_p{p}_aOut_raw;")
                    lines.append(f"        s{s}_p{p}_bOut_d1 <= s{s}_p{p}_bOut_raw;")
                    for d in range(2, extra):
                        lines.append(f"        s{s}_p{p}_aOut_d{d} <= s{s}_p{p}_aOut_d{d-1};")
                        lines.append(f"        s{s}_p{p}_bOut_d{d} <= s{s}_p{p}_bOut_d{d-1};")
                    lines.append(f"        s{s}_p{p}_aOut <= s{s}_p{p}_aOut_d{extra-1};")
                    lines.append(f"        s{s}_p{p}_bOut <= s{s}_p{p}_bOut_d{extra-1};")
                lines.append(f"    end")
    if not has_any_extra:
        lines.append("    // (all butterflies in every layer have matching latency; no shift registers needed)")
    lines.append("")

    lines.append("    // ---- Final-stage to natural-order outputs ----")
    lines.append("    // Each y_out_<i> port width matches the producing butterfly port's bound exactly.")
    for p in range(n // 2):
        natA, natB = spec.outputWiring[p]
        lines.append(f"    assign y_out_{natA} = s{L-1}_p{p}_aOut;")
        lines.append(f"    assign y_out_{natB} = s{L-1}_p{p}_bOut;")
    lines.append("")
    lines.append("endmodule")

    return "\n".join(lines) + "\n"


# ---------------------------------------------------------------------------
# Top testbench SystemVerilog
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
    lines.append(f"// Self-checking testbench for {spec.name}.")
    lines.append(f"// Drives natural-order x_in_<i> vectors and compares y_out_<i> against precomputed goldens.")
    lines.append(f"// Total pipeline latency: {total_latency} cycle(s).")
    lines.append(f"// PASS/FAIL strings match scripts/run_remote_sim.py grep patterns (SUCCESS!, PASS All, FAILED:).")
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

    # Concatenation that matches the per-slot packed hex: SV `{a, b, c}` puts `a`
    # at the MSBs, so `{y_out_{n-1}, ..., y_out_0}` aligns with values[0] in the
    # LSBs. Per-port widths line up natively — no truncation needed.
    concat_actual = ", ".join(f"y_out_{i}" for i in range(n - 1, -1, -1))
    lines.append(f"    logic [{total_out_bits - 1}:0] y_out_packed;")
    lines.append(f"    assign y_out_packed = {{{concat_actual}}};")
    lines.append("")

    # Driver block: per-slot constant-offset assigns from the packed x_in_ts row.
    # Per-natural widths can differ, so we unroll instead of using a `+:` loop
    # (which would require constant width).
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

    # Checker block.
    lines.append("    int j;")
    lines.append("    int correct_cnt;")
    lines.append("    initial begin")
    lines.append("        correct_cnt = 0;")
    lines.append("        #`INIT_RESET;")
    lines.append("        #`CLK_HP;")
    lines.append(f"        #(`CLK_P*{total_latency});")
    lines.append("        #1;")
    lines.append("        for (j = 0; j < `TS_SIZE; j = j + 1) begin")
    lines.append("            // `===` alone is NOT X-safe: X === X is true, so a run whose")
    lines.append("            // $readmemh silently failed (all-X inputs, all-X goldens, all-X")
    lines.append("            // DUT outputs) would score a full PASS having checked nothing.")
    lines.append("            // Guard on $isunknown so any X anywhere is a failure.")
    lines.append("            if (!$isunknown(y_out_packed) && !$isunknown(y_out_ts[j])")
    lines.append("                && y_out_packed === y_out_ts[j]) begin")
    lines.append("                $display(\"Testvector-%d CORRECT!\", j);")
    lines.append("                correct_cnt = correct_cnt + 1;")
    lines.append("            end else begin")
    lines.append("                $display(\"=================================================================================\");")
    lines.append("                $display(\"Testvector-%d WRONG\", j);")
    lines.append("                if ($isunknown(y_out_ts[j]))")
    lines.append("                    $display(\"  golden is X — testvectors not loaded (check the $readmemh path)\");")
    lines.append("                if ($isunknown(y_out_packed))")
    lines.append("                    $display(\"  DUT output is X — undriven logic or X-valued inputs\");")
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

def NTT_RTL_gen(
    spec: NTTOperatorSpec,
    pipeline_stages_per_layer: list[int],
    gen_testbench: bool = True,
    test_size: int = 1000,
    seed: int | None = None,
    visualization: bool = False,
    golden_x_natural: list[list[int]] | None = None,
    golden_y_natural: list[list[int]] | None = None,
) -> dict:
    """Emit SystemVerilog for a Goldilocks NTT/INTT pipeline.

    Files written (relative to cwd):
        RTL_generated/<spec.name>.sv                top wrapper
        RTL_generated/<spec.name>_tb.sv             top TB (when gen_testbench)
        RTL_generated/Butterfly_n<N>_<TYPE>_L<s>_p<p>.sv          per-butterfly DUTs
        RTL_generated/Butterfly_n<N>_<TYPE>_L<s>_p<p>_aOut_cmp.sv per-butterfly compressors
        RTL_generated/Butterfly_n<N>_<TYPE>_L<s>_p<p>_bOut_cmp.sv
        xdc_generated/Butterfly_n<N>_<TYPE>_L<s>_p<p>_{aOut,bOut}_cmp.xdc
        testvectors/x_in.txt, testvectors/y_out.txt   (when gen_testbench)
        manifest.json                                  pipeline latency / module list

    `pipeline_stages_per_layer` controls per-layer butterfly latency. Length
    must equal log2(n); every butterfly in layer s gets `pipeline_stages_per_layer[s]`
    forwarded to Butterfly_RTL_gen. Within-layer balancing shift registers are
    inserted automatically when butterflies in the same layer report different
    actual latencies.

    `golden_x_natural` and `golden_y_natural` (required when gen_testbench=True)
    are shape `test_size x n`, each row being one cycle's natural-order inputs
    or expected outputs. Caller is responsible for generating these (typically
    via `propagateValue` end-to-end through the populated FullyPipelinedNTT;
    see scripts/build_ntt.py).
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
                "NTT_RTL_gen: golden_x_natural and golden_y_natural are required when gen_testbench=True"
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

    # Per-butterfly emission. cwd is already set to the NTT run dir by the caller.
    butterfly_latencies: list[list[int]] = []
    butterfly_module_names: list[list[str]] = []
    for s in range(L):
        layer_latencies: list[int] = []
        layer_module_names: list[str] = []
        for p in range(n // 2):
            bs = spec.butterflySpecs[s][p]
            info = Butterfly_RTL_gen(
                spec=bs,
                pipeline_stages=pipeline_stages_per_layer[s],
                gen_testbench=False,
                visualization=visualization,
            )
            layer_latencies.append(info["pipeline_latency"])
            layer_module_names.append(bs.name)
        butterfly_latencies.append(layer_latencies)
        butterfly_module_names.append(layer_module_names)

    layer_latency = [max(layer_latencies) for layer_latencies in butterfly_latencies]
    total_latency = sum(layer_latency)

    # Consolidate per-butterfly artifacts. Each `Butterfly_RTL_gen` call wrote
    # three SV files (wrapper + aOut compressor + bOut compressor) into
    # `RTL_generated/` and one bit-heap descriptor `.txt` per output into the
    # run-dir root. For an n=128 NTT that's 1346 SVs + 896 .txt files — fine
    # for Vivado but slow to rsync and noisy to browse. Concatenate the
    # wrappers into `<TOP>_butterflies.sv` and the compressors into
    # `<TOP>_compressors.sv`, then delete the originals. SV permits multiple
    # modules per file; Vivado/xsim resolve them by module name. The per-XDC
    # files in `xdc_generated/` stay split — they carry LUTNM placement
    # constraints keyed on specific compressor module instances.
    rtl_dir = "RTL_generated"
    _consolidate_butterfly_artifacts(rtl_dir, spec, butterfly_module_names)

    # Top wrapper.
    os.makedirs(rtl_dir, exist_ok=True)
    wrapper_sv = _emit_top_wrapper(spec, layer_latency, butterfly_latencies)
    with open(os.path.join(rtl_dir, f"{spec.name}.sv"), "w", encoding="utf-8") as f:
        f.write(wrapper_sv)

    # Top testbench + testvectors.
    if gen_testbench:
        tv_dir = "testvectors"
        os.makedirs(tv_dir, exist_ok=True)
        _write_packed_hex(os.path.join(tv_dir, "x_in.txt"), golden_x_natural,
                          list(spec.inputBitWidthsNatural))
        _write_packed_hex(os.path.join(tv_dir, "y_out.txt"), golden_y_natural,
                          spec.outputBitWidthsNatural)
        tb_sv = _emit_top_testbench(spec, total_latency, test_size)
        with open(os.path.join(rtl_dir, f"{spec.name}_tb.sv"), "w", encoding="utf-8") as f:
            f.write(tb_sv)

    # Manifest.
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
    }
    with open("manifest.json", "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2)

    return manifest
