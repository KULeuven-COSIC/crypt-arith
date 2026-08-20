# rtl/pipeline.py
"""The backend pipeline: turn an already-solved (SolutionNode, LutReportNode)
pair into RTL and/or evaluation output files.

This is the half of the old main.py that both scripts/emit_from_bundle.py
(bundle in, RTL/evaluation out -- backend only) and the top-level main.py
(solve, then emit, in one run) share, so the two CLIs can't drift apart
from each other.
"""
from __future__ import annotations

import re
from pathlib import Path

import dsp_multiplier.backend.ir as IR
from dsp_multiplier.backend.delay_model import (
    ns_floor_report,
    ns_pareto_frontier,
    print_ns_pareto_report,
    select_ns_point,
)
from dsp_multiplier.backend.schedule import align_latency, module_latency
from dsp_multiplier.frontend.cost import describe_with_cost, sign_mode_map
from dsp_multiplier.frontend.seed_tiles import build_static_seed_library, print_tile_latency
from dsp_multiplier.backend.reports import print_latency_report
from dsp_multiplier.backend.lowering import build_ir
from rtl_gen.dsp_multiplier.emit_hweval import write_hweval
from rtl_gen.dsp_multiplier.emit_scoped_xdc import write_scoped_xdc_tcl
from rtl_gen.dsp_multiplier.emit_synth_settings import write_synth_settings_tcl
from rtl_gen.dsp_multiplier.emit_tb import write_testbench
from rtl_gen.dsp_multiplier.interface import emit_systemverilog
from rtl_gen.dsp_multiplier.project import write_rtl_project

# Default hardware-evaluation clock margin over the selected Pareto-frontier
# point's critical path (worst_ns), used when the caller omits an explicit
# clock period.
CLOCK_PERIOD_MARGIN = 1.25


def output_name_component(value: str) -> str:
    """Return a readable path component with separators/metacharacters removed."""
    component = re.sub(r"[^A-Za-z0-9_-]+", "_", value).strip("_-")
    return component or "unnamed"


def default_out_dir(output_root: Path, bundle_stem: str, module: IR.IRModule) -> Path:
    """Choose a deterministic per-bundle/per-module output directory."""
    bundle_name = output_name_component(bundle_stem)
    module_name = output_name_component(module.name)
    return output_root / f"rtl_out_{bundle_name}_{module_name}"


def build_final_module(
    node, report, *, latency_budget: int | None = None
) -> tuple[IR.IRModule, float]:
    """Build and latency-optimize an already-solved (node, report) pair,
    once, for every requested output.

    Returns (aligned_module, worst_ns) -- worst_ns is the selected
    Pareto-frontier point's critical path, in ns, so callers can derive a
    hardware-evaluation clock constraint from the design actually picked
    instead of a flat guess.

    Always runs the mode3 (NS_BUDGET) latency optimizer and selects a point
    off its Pareto frontier: with ``latency_budget=None`` (the default) that
    is the shortest-critical-path point (max fmax, whatever it costs in
    cycles); passing a budget instead caps total latency and picks the
    highest-fmax point within that cap. Mode0 (FIXED, i.e. skip the
    optimizer and keep whatever latencies SeedTiles assigned) is kept in
    dsp_multiplier.backend.delay_model/dsp_multiplier.backend.lowering for debugging but isn't wired up as a
    CLI choice here.
    """
    description, _ = describe_with_cost(node)
    print(description)

    library = build_static_seed_library()
    print_tile_latency(library)

    trace = []
    module = build_ir(
        node,
        report,
        library=library,
        latency=IR.LatencyConfig(),
        trace=trace,
        sign_modes=sign_mode_map(node),
    )
    print(f"T0 = {module_latency(module)}")

    print()
    print(ns_floor_report(module))
    print()
    points = ns_pareto_frontier(module)
    print_ns_pareto_report(points)

    best = select_ns_point(points, latency_budget)
    basis = (
        "shortest critical path (no latency budget)"
        if latency_budget is None
        else f"best fmax within latency budget={latency_budget}"
    )
    print(
        f"\nSelected point ({basis}): worst_ns={best.worst_ns:.3f} ns  "
        f"fmax={best.fmax_mhz:.1f} MHz  latency={best.latency}"
    )
    for record in sorted(best.moved, key=lambda item: -abs(item.extra)):
        print(
            f"  {record.signal:>8} {record.kind:>9}  "
            f"{record.old_latency}→{record.new_latency}  "
            f"({record.old_ns:.3f}→{record.new_ns:.3f} ns)"
        )
    # print(IR.dump(best.module))

    aligned = align_latency(best.module)
    print_latency_report(trace[0], aligned)
    return aligned, best.worst_ns


def generate_rtl(module: IR.IRModule, out_dir: Path) -> None:
    """Write the complete RTL project for an already-finalized module."""
    interface = emit_systemverilog(module)
    emitted = write_rtl_project(
        interface,
        out_dir,
        # GPC counter/compressor primitives (c15_3.sv, LFSR.sv, ...) are
        # instantiated by name straight out of lut_cmp/rtl whenever the
        # design uses a LUT-packed bitheap -- without copying them in,
        # synthesis fails to resolve those modules. Always include them;
        # write_rtl_project() only copies the ones actually referenced.
        include_gpc_primitives=True,
    )
    print(f"\n=== RTL written to {out_dir.resolve()}/ ===")
    print(f"  top:      {emitted.top}")
    print(f"  wrappers: {len(emitted.wrappers)}")
    print(f"  inners:   {len(emitted.inners)}")
    print(f"  gpc:      {len(emitted.gpc)}")

    settings_tcl = write_synth_settings_tcl(out_dir)
    print(f"  synth settings tcl: {settings_tcl}")


def generate_evaluation(
    module: IR.IRModule,
    out_dir: Path,
    *,
    test_size: int,
    seed: int,
    clock_period_ns: float,
) -> None:
    """Write the former main_evaluate.py output bundle."""
    out_dir.mkdir(parents=True, exist_ok=True)

    tb_path = out_dir / f"{module.name}_tb.sv"
    intermediates_path = out_dir / "intermediates.txt"
    write_testbench(
        module,
        tb_path,
        test_size=test_size,
        seed=seed,
        dump_intermediates_path=intermediates_path,
    )
    print(f"\n=== Evaluation files written to {out_dir.resolve()}/ ===")
    print(f"  testbench:    {tb_path.resolve()}")
    print(f"  intermediates: {intermediates_path.resolve()}")
    print(f"  latency:      {module_latency(module)}")

    paths = write_hweval(
        module,
        out_dir,
        style="auto",
        clock_period_ns=clock_period_ns,
    )
    print("  hweval:       ", *(str(path) for path in paths.values()))

    if "lfsr" in paths:
        # filelist.f is the single source of truth every downstream
        # consumer (GUI add_files, the non-project batch flow) reads
        # design sources from -- written earlier by write_rtl_project(),
        # before this (--evaluate-only) function knew whether the lfsr
        # hweval style, and hence LFSR.sv, would be needed at all.
        filelist_path = out_dir / "filelist.f"
        if filelist_path.is_file():
            rel = paths["lfsr"].relative_to(out_dir).as_posix()
            existing = filelist_path.read_text(encoding="utf-8").splitlines()
            if rel not in existing:
                with filelist_path.open("a", encoding="utf-8") as f:
                    f.write(rel + "\n")
                print(f"  filelist.f:    appended {rel}")

    scoped_tcl = write_scoped_xdc_tcl(out_dir, mode="project")
    print(f"  scoped tcl:   {scoped_tcl}")
