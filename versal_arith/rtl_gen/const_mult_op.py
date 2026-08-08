"""Spec-driven constant-multiplier RTL generator.

Consumes a `ConstMultOperatorSpec` produced by
`NTT_modeling.ConstMultScheme.NafConstMult.getOperatorInterface`, together with
explicit testvector and golden arrays, and emits SystemVerilog plus a
self-checking testbench.

Relationship to `rtl_gen/const_mult.py`
---------------------------------------
That module stays exactly as it is; it backs `cli.py -operator cmult` and the
checked-in ARITH 2026 examples. The difference is where the numbers come from:

  legacy   `Cmult_RTL_gen(width_a, constant, ...)` derives the output width, the
           NAF, and the implementation strategy itself, and samples its own
           testvectors.

  here     the spec already carries the width, the lifted NAF, the exact value
           interval and the chosen strategy, and the caller supplies the
           testvectors and the goldens from `propagateValue`. This generator
           samples nothing and decides nothing.

That mirrors `Butterfly_RTL_gen`, and it is what lets the model and the RTL agree
on port widths by construction rather than by two calculations happening to
match.

The emitted module has the same name shape and the same `clk` / `A` / `P` port
list as the legacy one, so the two are drop-in interchangeable in a project.
"""
from __future__ import annotations

import json
import os

from const_mult_spec import ConstMultBankSpec, ConstMultOperatorSpec
from rtl_gen.compressor import compressor_RTL_gen, reg_flag_list_gen
from rtl_gen.const_mult import _gen_adder, _gen_shift_only
from rtl_gen.heap_terms import buildHeapDescriptors, countCompressionLayers
from rtl_gen.utils import to_twos_complement_hex, width_expr

_RTL_DIR = "RTL_generated"
_TV_DIR = "testvectors"


def _write_hex_file(path: str, values: list[int], bit_width: int) -> None:
    """Write one hex line per value, truncated to `bit_width` two's-complement bits."""
    with open(path, "w", encoding="utf-8") as f:
        for v in values:
            f.write(to_twos_complement_hex(v, bit_width) + "\n")


def _gen_compressor(spec: ConstMultOperatorSpec, compressor_desc: list,
                    assign_desc: list, bitheap_list: list[int], width_bh: int,
                    pipeline_stages: int, visualization: bool) -> tuple[str, int]:
    """Compressor-tree wrapper for a heap with columns three bits or taller.

    Follows `rtl_gen/const_mult.py::_gen_compressor`, with two differences: the
    output width comes from the spec instead of being recomputed, and the
    intermediate heap file is named per module rather than a bare `bitheap.txt`
    — the legacy bank leaves a single `bitheap.txt` in the run dir reflecting
    only whichever constant happened to be generated last.
    """
    heap_txt = f"{spec.name}_bitheap.txt"
    with open(heap_txt, "w", encoding="utf-8") as f:
        for val in bitheap_list:
            f.write(f"{val}\n")

    n_layers, _, _ = countCompressionLayers(bitheap_list, width_bh)
    reg_flag_list = reg_flag_list_gen(pipeline_stages=pipeline_stages,
                                      num_layers=n_layers)

    compressor_module = f"{spec.name}_cmp"
    compressor_RTL_gen(
        txt_file_name=heap_txt,
        sv_file_name=compressor_module,
        compressor_module_name=compressor_module,
        visualization=visualization,
        tb_out_width=spec.pOutBitWidth,
        gen_testbench=False,
        test_size=0,
        reg_flag_list=reg_flag_list,
        bitheap_desc=compressor_desc,
    )

    left_vals = ([spec.aInBitWidth - 1, spec.pOutBitWidth - 1]
                 + [v - 1 for v in bitheap_list] + [width_bh - 1])
    left_w = max(len(str(v)) for v in left_vals if v >= 0)

    rtl = f"""`timescale 1ns / 1ps

module {spec.name} (
    input  logic {width_expr(0, left_w):<{left_w+6}} clk,
    input  logic {width_expr(spec.aInBitWidth - 1, left_w):<{left_w+6}} {spec.inPortName},
    output logic {width_expr(spec.pOutBitWidth - 1, left_w):<{left_w+6}} {spec.outPortName}
    );

    logic {width_expr(width_bh - 1, left_w):<{left_w+6}} comp_out;
    """

    for entry in compressor_desc:
        col_idx = entry[0]
        n_bits = len(entry) - 1
        cname = f"col{col_idx}"
        if n_bits == 1:
            rtl += f"""logic {' ' * (left_w + 6)} {cname};
    """
        else:
            rtl += f"""logic {width_expr(n_bits - 1, left_w):<{left_w+6}} {cname};
    """

    rtl += f"""
    // ------ Bitheap input assignments ({spec.inPortName} * {spec.constant}) ------
    """
    for entry in assign_desc:
        col_idx = entry[0]
        cname = f"col{col_idx}"
        bits = entry[1:]
        for bit_idx, (sig_name, sig_index, neg, cnst) in enumerate(bits):
            lhs = cname if len(bits) == 1 else f"{cname}[{bit_idx}]"
            if cnst:
                rtl += f"""assign {lhs} = 1'b1;
    """
            elif sig_name is None:
                rtl += f"""assign {lhs} = 1'b0;
    """
            else:
                idx = "" if (sig_index is None or sig_index == -1) else f"[{sig_index}]"
                tilde = "~" if neg else ""
                rtl += f"""assign {lhs} = {tilde}{sig_name}{idx};
    """

    rtl += f"""
    // ------ Compressor tree ------
    {compressor_module} {compressor_module}_inst(
        .clk(clk)"""
    for entry in compressor_desc:
        rtl += f""",
        .col{entry[0]}(col{entry[0]})"""
    rtl += f""",
        .comp_out(comp_out));

    assign {spec.outPortName} = comp_out[{spec.pOutBitWidth - 1}:0];

endmodule
"""
    return rtl, sum(1 for v in reg_flag_list if v)


def _gen_testbench(spec: ConstMultOperatorSpec, latency: int,
                   test_size: int) -> None:
    """Self-checking testbench, X-safe.

    Verdict markers match what `scripts/run_remote_sim.py` greps for, and the
    FAILED line uses the `N out of M testvectors failed` form so the driver
    reports a real count rather than falling through to the generic WRONG grep.

    Comparisons are guarded on `$isunknown`. `===` alone is a 4-state identity
    operator, so `X === X` is true: a run whose `$readmemh` silently failed would
    otherwise report a full PASS having checked nothing. Same guard as the NTT
    testbenches.
    """
    tb = f"""`timescale 1ns / 1ps

module {spec.name}_tb ();
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       {test_size}
    `define INIT_RESET    200

    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    logic [{spec.aInBitWidth - 1}:0] {spec.inPortName};
    logic [{spec.pOutBitWidth - 1}:0] {spec.outPortName};
    logic [{spec.aInBitWidth - 1}:0] {spec.inPortName}_ts [`TS_SIZE-1:0];
    logic [{spec.pOutBitWidth - 1}:0] {spec.outPortName}_ts [`TS_SIZE-1:0];

    initial begin
        $readmemh("../../../../../{_TV_DIR}/{spec.inPortName}.txt", {spec.inPortName}_ts);
        $readmemh("../../../../../{_TV_DIR}/{spec.outPortName}.txt", {spec.outPortName}_ts);
    end

    {spec.name} DUT (
        .clk(clk),
        .{spec.inPortName}  ({spec.inPortName}  ),
        .{spec.outPortName}  ({spec.outPortName}  ));

    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
            {spec.inPortName} = {spec.inPortName}_ts[i];
            #`CLK_P;
        end
    end

    int j;
    int correct_cnt;
    initial begin
        correct_cnt = 0;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*{latency});
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
            // `===` alone is NOT X-safe: X === X is true, so a run whose
            // $readmemh silently failed (all-X goldens, all-X DUT output) would
            // score a full PASS having checked nothing. Guard on $isunknown.
            if (!$isunknown({spec.outPortName}) && !$isunknown({spec.outPortName}_ts[j])
                && {spec.outPortName} === {spec.outPortName}_ts[j]) begin
                $display("Testvector-%d CORRECT!", j);
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("=================================================================================");
                $display("Testvector-%d WRONG", j);
                if ($isunknown({spec.outPortName}_ts[j]))
                    $display("  golden is X — testvectors not loaded (check the $readmemh path)");
                if ($isunknown({spec.outPortName}))
                    $display("  DUT output is X — undriven logic or X-valued inputs");
                $display("module    output: %h", {spec.outPortName});
                $display("reference output: %h", {spec.outPortName}_ts[j]);
                $display("=================================================================================");
            end
            #`CLK_P;
        end
        if (correct_cnt == `TS_SIZE) begin
            $display("SUCCESS!");
            $display("PASS All %0d Testvectors!", `TS_SIZE);
        end else begin
            $display("TO BE DEBUGGED...");
            $display("FAILED: %0d out of %0d testvectors failed", (`TS_SIZE-correct_cnt), `TS_SIZE);
        end
        $finish();
    end

endmodule
"""
    os.makedirs(_RTL_DIR, exist_ok=True)
    with open(os.path.join(_RTL_DIR, f"{spec.name}_tb.sv"), "w", encoding="utf-8") as f:
        f.write(tb)


def ConstMult_RTL_gen(
    spec: ConstMultOperatorSpec,
    pipeline_stages: int = 1,
    gen_testbench: bool = True,
    visualization: bool = False,
    A: list[int] | None = None,
    P: list[int] | None = None,
) -> dict:
    """Emit RTL for one constant multiplier described by `spec`.

    `A` and `P` are the input testvectors and their goldens. Both are required
    when `gen_testbench=True`; this generator never samples, so `test_size` is
    implicit in `len(A)`. The caller — normally
    `NafConstMult.emitRtl` — draws the inputs and runs `propagateValue` for the
    goldens, exactly as `GoldilocksSlice64.emitRtl` does for butterflies.

    Writes `RTL_generated/<name>.sv`, plus for the compressor strategy
    `RTL_generated/<name>_cmp.sv` and `xdc_generated/<name>_cmp.xdc`, plus
    testvectors and a testbench when asked. All paths are relative to the
    current working directory.
    """
    if pipeline_stages < 1:
        raise ValueError(
            f"pipeline_stages must be >= 1, got {pipeline_stages} "
            f"(reg_flag_list_gen divides by it)"
        )
    if spec.pOutBitWidth <= 0:
        raise ValueError(f"{spec.name}: pOutBitWidth must be > 0")

    compressor_desc, assign_desc, bitheap_list, width_bh = buildHeapDescriptors(
        spec.pOutTerms, spec.pOutBitWidth, ""
    )
    if not bitheap_list:
        raise ValueError(
            f"{spec.name}: bit heap is empty — every term was truncated at "
            f"pOutBitWidth={spec.pOutBitWidth}"
        )

    # The spec already recorded the strategy; recomputing the height here is a
    # consistency check on the contract, not a second decision.
    height = max(len(entry) - 1 for entry in assign_desc)
    if height != spec.maxColumnHeight:
        raise ValueError(
            f"{spec.name}: spec says maxColumnHeight={spec.maxColumnHeight} but "
            f"the heap built here has {height}; the model and generator disagree"
        )

    if spec.strategy == "wire":
        rtl, comp_stages = _gen_shift_only(
            spec.name, spec.aInBitWidth, spec.pOutBitWidth, spec.constant,
            assign_desc, signed_input=spec.aInIsSigned,
        )
    elif spec.strategy == "adder":
        rtl, comp_stages = _gen_adder(
            spec.name, spec.aInBitWidth, spec.pOutBitWidth, spec.constant,
            assign_desc, signed_input=spec.aInIsSigned,
        )
    elif spec.strategy == "compressor":
        rtl, comp_stages = _gen_compressor(
            spec, compressor_desc, assign_desc, bitheap_list, width_bh,
            pipeline_stages, visualization,
        )
    else:
        raise ValueError(
            f"{spec.name}: unknown strategy {spec.strategy!r} "
            f"(expected 'wire', 'adder' or 'compressor')"
        )

    os.makedirs(_RTL_DIR, exist_ok=True)
    with open(os.path.join(_RTL_DIR, f"{spec.name}.sv"), "w", encoding="utf-8") as f:
        f.write(rtl)

    test_size = 0
    if gen_testbench:
        if A is None or P is None:
            raise ValueError(
                f"{spec.name}: gen_testbench=True requires both A and P arrays "
                f"(this generator does not sample its own testvectors)"
            )
        if len(A) != len(P):
            raise ValueError(
                f"{spec.name}: A has {len(A)} entries but P has {len(P)}"
            )
        if not A:
            raise ValueError(f"{spec.name}: A is empty")
        test_size = len(A)

        os.makedirs(_TV_DIR, exist_ok=True)
        _write_hex_file(os.path.join(_TV_DIR, f"{spec.inPortName}.txt"),
                        A, spec.aInBitWidth)
        _write_hex_file(os.path.join(_TV_DIR, f"{spec.outPortName}.txt"),
                        P, spec.pOutBitWidth)
        # A combinational multiplier still needs one cycle of settle time in the
        # testbench's sampling loop, matching the legacy tb_stages = max(1, ...).
        _gen_testbench(spec, max(1, comp_stages), test_size)

    return {
        "module": spec.name,
        "strategy": spec.strategy,
        "max_column_height": spec.maxColumnHeight,
        "compressor_module": f"{spec.name}_cmp" if spec.strategy == "compressor" else None,
        "aIn_bit_width": spec.aInBitWidth,
        "pOut_bit_width": spec.pOutBitWidth,
        "bitheap_width": width_bh,
        "pipeline_latency": comp_stages,
        "test_size": test_size,
    }


# =========================================================================
# Bank: N constant multipliers over one input, uniform output latency
# =========================================================================

#: Version of the `output_bounds.json` side-car this generator writes.
#: Schema 1 is the legacy `rtl_gen/const_mult.py` format, whose declared
#: bitWidth can exceed the interval-derived one; `IntType.loadBoundsJson`
#: widens those bounds to compensate. Schema 2 bounds come from the model, so
#: the declared width IS the interval-derived width and no widening applies.
BOUNDS_SCHEMA = 2


def _write_bank_bounds(spec: ConstMultBankSpec) -> None:
    """Write `output_bounds.json` from the spec's exact per-entry intervals.

    The legacy bank recomputes these with `_output_int_type`, whose width can
    be one bit wider than the interval implies (signed input, positive
    power-of-two constant). Here they are serialised straight from the model, so
    the port width and the bound agree by construction.
    """
    payload = {
        "schema": BOUNDS_SCHEMA,
        "bank": spec.name,
        "aInBitWidth": spec.aInBitWidth,
        "aInIsSigned": spec.aInIsSigned,
        "uniformLatency": spec.uniformLatency,
        "entries": [
            {
                "idx": i,
                "constant": e.constant,
                "originalConstant": e.originalConstant,
                "bitWidth": e.pOutBitWidth,
                "isSigned": e.pOutIsSigned,
                "minValue": e.pOutMinValue,
                "maxValue": e.pOutMaxValue,
                "zeroLsbs": e.pOutZeroLsbs,
                "strategy": e.strategy,
            }
            for i, e in enumerate(spec.entries)
        ],
    }
    with open("output_bounds.json", "w", encoding="utf-8") as f:
        json.dump(payload, f, indent=2)


def _consolidate(rtl_dir: str, bank_name: str, module_names: list[str]) -> tuple[int, int]:
    """Fold per-constant wrappers and compressors into two files.

    A 64-wide bank otherwise leaves up to 128 tiny `.sv` files, which is slow to
    rsync and noisy to browse. SystemVerilog allows many modules per file and
    the tools resolve by module name, so nothing downstream changes. XDCs stay
    split — they carry LUTNM placement keyed on specific compressor instances.

    Mirrors `rtl_gen/const_mult.py::_consolidate_bank_artifacts`, but dedupes:
    two entries with the same lifted constant share one module, and the file
    must not contain it twice.
    """
    wrappers: list[str] = []
    compressors: list[str] = []
    for mod in dict.fromkeys(module_names):          # de-dupe, keep order
        cmp_path = os.path.join(rtl_dir, f"{mod}_cmp.sv")
        if os.path.isfile(cmp_path):
            with open(cmp_path, "r", encoding="utf-8") as f:
                compressors.append(f"// ===== {mod}_cmp =====\n{f.read()}")
            os.remove(cmp_path)
        wrapper_path = os.path.join(rtl_dir, f"{mod}.sv")
        if os.path.isfile(wrapper_path):
            with open(wrapper_path, "r", encoding="utf-8") as f:
                wrappers.append(f"// ===== {mod} =====\n{f.read()}")
            os.remove(wrapper_path)

    if wrappers:
        with open(os.path.join(rtl_dir, f"{bank_name}_cmults.sv"), "w",
                  encoding="utf-8") as f:
            f.write("\n".join(wrappers))
    if compressors:
        with open(os.path.join(rtl_dir, f"{bank_name}_compressors.sv"), "w",
                  encoding="utf-8") as f:
            f.write("\n".join(compressors))
    return len(wrappers), len(compressors)


def _gen_bank_wrapper(spec: ConstMultBankSpec, module_names: list[str]) -> str:
    """Top wrapper: per-index ports, per-entry balancing registers.

    Every `P_<i>` keeps its own width — no zero or sign extension to a common
    maximum — and shorter entries get balancing registers at that same width, so
    all outputs share `spec.uniformLatency`.
    """
    n = len(spec.entries)
    max_out_w = max(e.pOutBitWidth for e in spec.entries)
    left_w = max(len(str(spec.aInBitWidth - 1)), len(str(max_out_w - 1)),
                 len(str(n - 1)))
    w_a = width_expr(spec.aInBitWidth - 1, left_w)

    rtl = f"""`timescale 1ns / 1ps

// Constant-multiplier bank, generated from a ConstMultBankSpec.
//
// Each P_<i> is exactly as wide as its own multiplier's output bound — no
// zero/sign extension to a common width — and every output shares a latency of
// {spec.uniformLatency} cycle(s), reached by balancing registers inserted per
// entry at that entry's own width. The exact IntType bound behind each port is
// recorded in `output_bounds.json` next to this file.
module {spec.name} (
    input  logic {' ' * (left_w + 6)} clk,
"""
    for i in range(n):
        rtl += f"    input  logic {w_a} A_{i},\n"
    for i, entry in enumerate(spec.entries):
        comma = "," if i < n - 1 else ""
        rtl += f"    output logic {width_expr(entry.pOutBitWidth - 1, left_w)} P_{i}{comma}\n"
    rtl += "    );\n"

    for i, entry in enumerate(spec.entries):
        latency = spec.perEntryLatency[i]
        extra = spec.uniformLatency - latency
        ind_w = width_expr(entry.pOutBitWidth - 1, left_w)
        rtl += f"""
    // --- Multiplier {i}: {module_names[i]} (C={entry.constant}, {entry.strategy}, latency={latency}, padding={extra}) ---
    logic {ind_w} P_raw_{i};
    {module_names[i]} cmult_{i} (.clk(clk), .{entry.inPortName}(A_{i}), .{entry.outPortName}(P_raw_{i}));
"""
        if extra <= 0:
            source = f"P_raw_{i}"
        else:
            for r in range(extra):
                src = f"P_raw_{i}" if r == 0 else f"P_pipe_{i}_{r - 1}"
                rtl += f"""    logic {ind_w} P_pipe_{i}_{r};
    always_ff @(posedge clk) P_pipe_{i}_{r} <= {src};
"""
            source = f"P_pipe_{i}_{extra - 1}"
        rtl += f"    assign P_{i} = {source};\n"

    rtl += "\nendmodule\n"
    return rtl


def _gen_bank_testbench(spec: ConstMultBankSpec, test_size: int) -> None:
    """Self-checking bank testbench, X-safe.

    One shared `A.txt` drives every input; each output has its own `P_<i>.txt`.
    Verdict markers match `scripts/run_remote_sim.py`'s grep, using the
    `N / M checks passed` form the driver already understands for banks.
    """
    n = len(spec.entries)
    rtl = f"""`timescale 1ns / 1ps

module {spec.name}_tb ();
    `define CLK_P         10
    `define CLK_HP        5
    `define TS_SIZE       {test_size}
    `define N_MULTS       {n}
    `define INIT_RESET    200
    `define PIPE_LATENCY  {spec.uniformLatency}

    logic clk;
    initial clk = 1'b0;
    always #`CLK_HP clk = ~clk;

    logic [{spec.aInBitWidth - 1}:0] A_ts [`TS_SIZE-1:0];
"""
    for i, entry in enumerate(spec.entries):
        rtl += f"    logic [{entry.pOutBitWidth - 1}:0] P_{i}_ts [`TS_SIZE-1:0];\n"
    for i in range(n):
        rtl += f"    logic [{spec.aInBitWidth - 1}:0] A_{i};\n"
    for i, entry in enumerate(spec.entries):
        rtl += f"    logic [{entry.pOutBitWidth - 1}:0] P_{i};\n"

    rtl += f"""
    initial begin
        $readmemh("../../../../../{_TV_DIR}/A.txt", A_ts);
"""
    for i in range(n):
        rtl += f'        $readmemh("../../../../../{_TV_DIR}/P_{i}.txt", P_{i}_ts);\n'
    rtl += "    end\n\n"

    rtl += f"    {spec.name} DUT (\n        .clk(clk)"
    for i in range(n):
        rtl += f",\n        .A_{i}(A_{i})"
    for i in range(n):
        rtl += f",\n        .P_{i}(P_{i})"
    rtl += ");\n"

    rtl += """
    int i;
    initial begin
        #`INIT_RESET;
        #`CLK_HP;
        #1;
        for (i = 0; i < `TS_SIZE; i = i + 1) begin
"""
    for i in range(n):
        rtl += f"            A_{i} = A_ts[i];\n"
    rtl += """            #`CLK_P;
        end
    end

    int j;
    int correct_cnt;
    int total_checks;
    initial begin
        correct_cnt = 0;
        total_checks = `TS_SIZE * `N_MULTS;
        #`INIT_RESET;
        #`CLK_HP;
        #(`CLK_P*`PIPE_LATENCY);
        #1;
        for (j = 0; j < `TS_SIZE; j = j + 1) begin
"""
    for i in range(n):
        rtl += f"""            // `===` alone is NOT X-safe (X === X is true), so an unloaded
            // testvector array would score a silent PASS. Guard on $isunknown.
            if (!$isunknown(P_{i}) && !$isunknown(P_{i}_ts[j]) && P_{i} === P_{i}_ts[j]) begin
                correct_cnt = correct_cnt + 1;
            end else begin
                $display("Testvector-%0d mult-%0d WRONG: got %h expected %h", j, {i}, P_{i}, P_{i}_ts[j]);
                if ($isunknown(P_{i}_ts[j]))
                    $display("  golden is X — testvectors not loaded (check the $readmemh path)");
                if ($isunknown(P_{i}))
                    $display("  DUT output is X — undriven logic or X-valued inputs");
            end
"""
    rtl += """            #`CLK_P;
        end
        if (correct_cnt == total_checks) begin
            $display("SUCCESS!");
            $display("PASS All %0d checks (%0d multipliers x %0d vectors)", total_checks, `N_MULTS, `TS_SIZE);
        end else begin
            $display("TO BE DEBUGGED...");
            $display("FAILED: %0d / %0d checks passed", correct_cnt, total_checks);
        end
        $finish();
    end

endmodule
"""
    os.makedirs(_RTL_DIR, exist_ok=True)
    with open(os.path.join(_RTL_DIR, f"{spec.name}_tb.sv"), "w", encoding="utf-8") as f:
        f.write(rtl)


def ConstMultBank_RTL_gen(
    spec: ConstMultBankSpec,
    pipeline_stages: int = 1,
    gen_testbench: bool = True,
    visualization: bool = False,
    A: list[int] | None = None,
    P: list[list[int]] | None = None,
) -> dict:
    """Emit a whole constant-multiplier bank described by `spec`.

    `A` is the shared input testvector stream; `P[i]` are the goldens for output
    `i`. Both required when `gen_testbench=True` — this generator samples
    nothing.

    Writes each entry's module, then consolidates them into
    `<bank>_cmults.sv` / `<bank>_compressors.sv`, then the top wrapper, the
    testbench, and `output_bounds.json`.
    """
    if not spec.entries:
        raise ValueError(f"{spec.name}: bank has no entries")

    module_names: list[str] = []
    for i, entry in enumerate(spec.entries):
        # gen_testbench=False: per-entry testbenches would each overwrite the
        # bank's shared testvectors/ directory.
        ConstMult_RTL_gen(entry, pipeline_stages=pipeline_stages,
                          gen_testbench=False, visualization=visualization)
        module_names.append(entry.name)
        if (i + 1) % 16 == 0:
            print(f"  Generated {i + 1}/{len(spec.entries)} multipliers")

    # Consolidate before the wrapper and testbench are written, so those are
    # never themselves candidates for consolidation.
    n_wrappers, n_compressors = _consolidate(_RTL_DIR, spec.name, module_names)
    print(f"  Consolidated {n_wrappers} cmult + {n_compressors} compressor "
          f"module(s) into {spec.name}_cmults.sv"
          + (f" + {spec.name}_compressors.sv" if n_compressors else ""))

    with open(os.path.join(_RTL_DIR, f"{spec.name}.sv"), "w", encoding="utf-8") as f:
        f.write(_gen_bank_wrapper(spec, module_names))

    test_size = 0
    if gen_testbench:
        if A is None or P is None:
            raise ValueError(
                f"{spec.name}: gen_testbench=True requires both A and P "
                f"(this generator does not sample its own testvectors)"
            )
        if len(P) != len(spec.entries):
            raise ValueError(
                f"{spec.name}: P has {len(P)} golden streams for "
                f"{len(spec.entries)} entries"
            )
        for i, golden in enumerate(P):
            if len(golden) != len(A):
                raise ValueError(
                    f"{spec.name}: P[{i}] has {len(golden)} values but A has {len(A)}"
                )
        test_size = len(A)
        os.makedirs(_TV_DIR, exist_ok=True)
        _write_hex_file(os.path.join(_TV_DIR, "A.txt"), A, spec.aInBitWidth)
        for i, entry in enumerate(spec.entries):
            _write_hex_file(os.path.join(_TV_DIR, f"P_{i}.txt"), P[i],
                            entry.pOutBitWidth)
        _gen_bank_testbench(spec, test_size)

    _write_bank_bounds(spec)

    return {
        "module": spec.name,
        "n_mults": len(spec.entries),
        "uniform_latency": spec.uniformLatency,
        "per_entry_latency": list(spec.perEntryLatency),
        "module_names": module_names,
        "distinct_modules": len(dict.fromkeys(module_names)),
        "strategies": [e.strategy for e in spec.entries],
        "output_bit_widths": [e.pOutBitWidth for e in spec.entries],
        "bounds_schema": BOUNDS_SCHEMA,
        "test_size": test_size,
    }
