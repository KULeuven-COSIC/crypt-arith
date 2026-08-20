# rtl/emit_synth_settings.py
"""Write the per-project synth_1 run-property tcl. Content is deliberately
   design-independent -- these are quality/runtime tradeoffs that apply
   the same way to every generated bundle -- so this is just "always write
   the same file", unlike the scoped-xdc emitter which has to scan the
   output directory first.

   Usage: source this in Vivado GUI's Tcl Console (or a project-mode batch
   script) before launching synth_1."""
from __future__ import annotations
from pathlib import Path

_BODY = """\
# Disable global retiming
set_property STEPS.SYNTH_DESIGN.ARGS.GLOBAL_RETIMING off \\
    [get_runs synth_1]

# Reduce synthesis runtime
set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE RuntimeOptimized \\
    [get_runs synth_1]

# Preserve hierarchy globally
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none \\
    [get_runs synth_1]
"""


def write_synth_settings_tcl(outdir: str | Path, *,
                             tcl_name: str = "synth_settings.tcl") -> Path:
    """mode='project' only (matches scoped_xdc's project mode): a
       set_property-on-get_runs script with no path dependency, safe to
       source from the GUI Tcl console or a project-mode batch script
       before launching synth_1."""
    out = Path(outdir).resolve()
    out.mkdir(parents=True, exist_ok=True)
    tcl = out / tcl_name
    tcl.write_text(_BODY, encoding="utf-8")
    return tcl
