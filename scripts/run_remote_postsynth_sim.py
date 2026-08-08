#!/usr/bin/env python3
"""run_remote_postsynth_sim.py — simulate the post-synthesis netlist of a
generated run on the V80 server.

Where ``run_remote_sim.py`` simulates the *RTL* (the generated compressor-tree
SystemVerilog), this script simulates the *synthesized netlist* — the UNISIM
cell-level Verilog Vivado produced from that RTL. Running both against the same
testbench and the same testvectors answers "did synthesis change the
behaviour?", which RTL simulation alone cannot.

Prerequisite: the netlist must already exist on the server, i.e. run ::

    python scripts/run_remote_synth.py --run-dir <run> --write-netlist

which leaves ``<remote-root>/src/netlist/<top>_funcsim.v`` in place.

Flow (mirrors run_remote_sim.py, and reuses its ssh/rsync helpers):

  1. Validate the local run dir; auto-detect the top from ``<top>_tb.sv``.
  2. Check the netlist exists on the server.
  3. Stage the testbench (with the ``$readmemh`` paths patched to
     ``../testvectors/``) and the testvectors.
  4. Push a per-run bash script that runs xvlog / xelab / xsim over
     ``netlist + testbench + src/rtl_resources`` — deliberately NOT over
     ``src/rtl/``, since the RTL modules would collide with the netlist's
     identically-named top.
  5. Launch it detached, poll the exit marker, pull the log back.
  6. Parse the same PASS/FAIL markers ``run_remote_sim.py`` uses; exit
     0 (PASS) / 1 (FAIL) / 2 (tooling failure).

Note this is a *functional* (zero-delay) netlist simulation. It verifies logic
equivalence through synthesis, not timing; post-synthesis hold numbers are
meaningless before place-and-route, so timing simulation only makes sense on an
implemented (routed) design.

Run from the project root, e.g.::

    python scripts/run_remote_postsynth_sim.py --run-dir work/ntt_s130/NTT_s130
"""

from __future__ import annotations

import argparse
import re
import shlex
import subprocess
import sys
import time
from pathlib import Path

# Reuse the ssh/rsync helpers, top detection, testvector staging and verdict
# parsing from the RTL sim driver — the only thing that differs here is which
# sources get compiled.
sys.path.insert(0, str(Path(__file__).resolve().parent))
from run_remote_sim import (  # noqa: E402
    DEFAULT_SERVER, DEFAULT_REMOTE_ROOT,
    EXIT_PASS, EXIT_FAIL, EXIT_TOOLING,
    _run, _ssh, detect_top, ensure_resources, stage_testvectors, parse_verdict,
)


def netlist_remote_path(remote_root: str, top: str) -> str:
    return f"{remote_root}/src/netlist/{top}_funcsim.v"


def check_netlist(server: str, remote_root: str, top: str, run_dir: Path,
                  allow_origin_mismatch: bool = False) -> None:
    """Fail early if the netlist isn't there, or came from a different design.

    The netlist path is keyed only on the top module name, and distinct designs
    can share one — the pre-twist and post-twist constant-multiplier banks are
    both `cmultbank`. Synthesizing one and then simulating the other would
    silently produce a confident, wrong result, so the origin marker written by
    run_remote_synth.py --write-netlist is checked against this run dir.
    """
    path = netlist_remote_path(remote_root, top)
    probe = _ssh(server, f"test -f {shlex.quote(path)} && stat -c %s {shlex.quote(path)}",
                 capture_output=True, text=True, check=False)
    if probe.returncode != 0:
        raise SystemExit(
            f"post-synthesis netlist not found on {server}: {path}\n"
            f"Generate it first with:\n"
            f"  python scripts/run_remote_synth.py --run-dir <run-dir> "
            f"--top {top} --write-netlist"
        )
    size = probe.stdout.strip()
    print(f"[run_remote_postsynth_sim] netlist: {path} ({size} bytes)")

    marker = f"{remote_root}/src/netlist/{top}_funcsim.origin"
    got = _ssh(server, f"cat {shlex.quote(marker)} 2>/dev/null || true",
               capture_output=True, text=True, check=False)
    lines = [l for l in got.stdout.splitlines() if l.strip()]
    if not lines:
        print(f"[run_remote_postsynth_sim] warning: no origin marker beside the "
              f"netlist — cannot confirm it was synthesized from {run_dir}")
        return
    origin_dir, origin_when = lines[0].strip(), (lines[1].strip() if len(lines) > 1 else "?")
    if origin_dir == str(run_dir):
        print(f"[run_remote_postsynth_sim] netlist origin OK: {origin_dir} ({origin_when})")
        return
    msg = (f"netlist/run-dir mismatch for top '{top}':\n"
           f"  netlist was synthesized from : {origin_dir}  ({origin_when})\n"
           f"  this run dir is             : {run_dir}\n"
           f"Distinct designs sharing a top module name (e.g. both cmultbanks) "
           f"overwrite each other's netlist. Re-run run_remote_synth.py "
           f"--write-netlist for this run dir, or pass --allow-origin-mismatch "
           f"if you are certain.")
    if allow_origin_mismatch:
        print(f"[run_remote_postsynth_sim] WARNING (overridden): {msg}")
    else:
        raise SystemExit(msg)


def stage_testbench(server: str, remote_root: str, run_dir: Path, top: str,
                    build_dir: str) -> None:
    """Patch the testbench's 5-deep `$readmemh` paths to `../testvectors/` and
    push it into the per-run build dir. Same patch as the RTL flow — the build
    dir sits at the remote root, so `../testvectors/` resolves to the shared
    testvectors directory."""
    src = run_dir / "RTL_generated" / f"{top}_tb.sv"
    if not src.is_file():
        raise SystemExit(f"testbench not found: {src}")
    text = src.read_text()
    patched = re.sub(r'"(\.\./){5}testvectors/', '"../testvectors/', text)
    if patched == text:
        print("[run_remote_postsynth_sim] warning: $readmemh path patch matched "
              "nothing — check the testbench's path style")
    _ssh(server, f"mkdir -p {shlex.quote(build_dir)}", check=True)
    subprocess.run(
        ["ssh", server, f"cat > {shlex.quote(build_dir)}/{top}_tb.sv"],
        input=patched, text=True, check=True,
    )


def _gpc_prune_expr() -> str:
    """`find` expression excluding the project's own GPC design modules.

    src/rtl_resources/ holds two different kinds of file: Vivado's primitive
    simulation models (LUT6CY.v, LOOKAHEAD8.v, URAM288E5.sv, ...) — which the
    netlist needs — and the project's GPC *design* modules (c3_2.sv, c6_3.sv,
    ...) — which it must not have. Synthesis already consumed the GPCs, and
    Vivado re-interfaced the preserved hierarchies while writing the netlist:
    the netlist's own `c6_3` has ports (C0, O, x_in_82, x_in_18), whereas the
    RTL `c6_3` has (clk, C0, O, CY, PROP). Compiling the RTL copy after the
    netlist silently overwrites the netlist's definition, and elaboration then
    fails on ports that no longer exist.

    The same list already exists in run_remote_synth._GPC_PRIMITIVES (used
    there to *include* them for synthesis); imported rather than duplicated.
    """
    from run_remote_synth import _GPC_PRIMITIVES
    return " ".join(f'! -name {shlex.quote(n)}' for n in _GPC_PRIMITIVES)


def build_sim_script(remote_root: str, top: str, build_dir: str) -> str:
    """Per-run bash script: compile the netlist + TB + primitive models, then
    elaborate and simulate.

    Deliberately does NOT use the project's scripts/sim.sh: that globs
    src/rtl/, which for a post-synthesis run would compile the original RTL
    top alongside the netlist top of the same name (xvlog would silently keep
    whichever it analyzed last, so we could end up simulating the RTL and
    calling it a netlist result).

    `glbl` is compiled and passed as a second elaboration top: Vivado's
    funcsim netlists reference `glbl.GSR` for the global set/reset of the
    inferred flip-flops, and without it every register stays X.
    """
    return f"""#!/bin/bash
set -e
cd {shlex.quote(remote_root)}
source ./source

BUILD={shlex.quote(build_dir)}
TOP={shlex.quote(top)}
NETLIST={shlex.quote(netlist_remote_path(remote_root, top))}
GLBL="$XILINX_VIVADO/data/verilog/src/glbl.v"

cd "$BUILD"
rm -rf xsim.dir *.jou *.pb *.wdb

echo "[postsynth] netlist : $NETLIST"
echo "[postsynth] tb      : $BUILD/${{TOP}}_tb.sv"
echo "[postsynth] glbl    : $GLBL"

# Primitive simulation models that the generated RTL flow already relies on
# (LUT6CY.v, LOOKAHEAD8.v, ...). The netlist instantiates the same cells, so
# compiling them keeps netlist and RTL simulation semantics identical.
# `-sv` is required: the directory mixes .v and .sv, and several models
# (URAM288E5.sv, ...) use SystemVerilog constructs that fail to parse in
# Verilog-2001 mode. This matches how the project's own scripts/sim.sh
# compiles the same directory.
RES_FILES=$(find "{remote_root}/src/rtl_resources" -type f \\( -name "*.v" -o -name "*.sv" \\) {_gpc_prune_expr()})

# The funcsim netlist is plain Verilog-2001; compile it on its own so a
# parse error in it is unambiguous.
xvlog "$NETLIST" -work work
xvlog -sv $RES_FILES -work work
[ -f "$GLBL" ] && xvlog "$GLBL" -work work
xvlog -sv "${{TOP}}_tb.sv" -work work

if [ -f "$GLBL" ]; then
  xelab -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib \\
        work.${{TOP}}_tb work.glbl -s ${{TOP}}_tb --debug typical -log elab.log
else
  xelab -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib \\
        work.${{TOP}}_tb -s ${{TOP}}_tb --debug typical -log elab.log
fi

cat > sim.tcl <<'TCL'
run all
quit
TCL

xsim ${{TOP}}_tb -t sim.tcl
echo "[postsynth] done. Artifacts in $BUILD/"
"""


def run_postsynth_sim(server: str, remote_root: str, top: str, pull_to: Path,
                      build_dir: str, script_remote: str,
                      poll_interval_s: int = 30, launch_timeout_s: int = 120,
                      startup_grace_s: int = 600) -> tuple[int, str]:
    """Launch detached, poll the exit marker, pull the log. Same detach+poll
    pattern as run_remote_sim.run_sim (see the comments there for why the
    launch channel is bounded rather than waited on)."""
    log_remote = f"{remote_root}/build_{top}_ps.log"
    exit_remote = f"{remote_root}/build_{top}_ps.exit"
    log_local = pull_to / "postsynth_sim_stdout.log"
    pull_to.mkdir(parents=True, exist_ok=True)

    launch_cmd = (
        f"cd {shlex.quote(remote_root)} && "
        f"rm -f {shlex.quote(exit_remote)} && "
        f"setsid nohup bash -c "
        f"'bash {shlex.quote(script_remote)} > {shlex.quote(log_remote)} 2>&1; "
        f"echo $? > {shlex.quote(exit_remote)}' "
        f"</dev/null >/dev/null 2>&1 &"
    )
    print(f"[run_remote_postsynth_sim] launching detached netlist sim on {server}")
    try:
        _run(["ssh", "-n",
              "-o", "ServerAliveInterval=30", "-o", "ServerAliveCountMax=3",
              "-o", "ConnectTimeout=30",
              server, launch_cmd],
             check=True, timeout=launch_timeout_s)
    except subprocess.TimeoutExpired:
        print(f"[run_remote_postsynth_sim] launch ssh did not return within "
              f"{launch_timeout_s}s; the job is detached, continuing to poll")

    print(f"[run_remote_postsynth_sim] polling for {exit_remote} every {poll_interval_s}s")
    sim_exit: int | None = None
    started = time.monotonic()
    saw_log = False
    while sim_exit is None:
        time.sleep(poll_interval_s)
        proc = subprocess.run(
            ["ssh", "-n",
             "-o", "ServerAliveInterval=30", "-o", "ServerAliveCountMax=3",
             "-o", "ConnectTimeout=30",
             server,
             f"test -f {shlex.quote(log_remote)} && echo LOG; "
             f"test -f {shlex.quote(exit_remote)} && cat {shlex.quote(exit_remote)} || echo NOT_DONE"],
            capture_output=True, text=True,
        )
        if proc.returncode != 0:
            print(f"[run_remote_postsynth_sim] poll SSH failed (rc={proc.returncode}, "
                  f"stderr={proc.stderr.strip()!r}); retrying")
            continue
        out = proc.stdout.strip()
        if "LOG" in out.split():
            saw_log = True
        out = out.replace("LOG", "").strip()
        if out == "NOT_DONE" or out == "":
            if not saw_log and (time.monotonic() - started) > startup_grace_s:
                raise RuntimeError(
                    f"netlist sim never started: {log_remote} absent after "
                    f"{startup_grace_s}s (launch failed?)"
                )
            continue
        try:
            sim_exit = int(out)
        except ValueError:
            print(f"[run_remote_postsynth_sim] unexpected exit marker: {out!r}; retrying")
            continue
    print(f"[run_remote_postsynth_sim] netlist sim done, exit={sim_exit}; pulling log")

    try:
        _run(["rsync", "-a", f"{server}:{log_remote}", str(log_local)], check=True)
    except subprocess.CalledProcessError as e:
        print(f"[run_remote_postsynth_sim] warning: rsync of log failed ({e})")
        log_local.write_text("")

    return sim_exit, (log_local.read_text() if log_local.exists() else "")


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--run-dir", required=True,
                   help="path to a generated run dir, e.g. work/ntt_s130/NTT_s130")
    p.add_argument("--top", default=None,
                   help="top module (auto-detected from RTL_generated/*_tb.sv)")
    p.add_argument("--server", default=DEFAULT_SERVER)
    p.add_argument("--remote-root", default=DEFAULT_REMOTE_ROOT)
    p.add_argument("--pull-to", default=None,
                   help="local dir for pulled artifacts (default: "
                        "<run_dir>/postsynth_remote)")
    p.add_argument("--allow-origin-mismatch", action="store_true",
                   help="proceed even if the netlist on the server was "
                        "synthesized from a different run dir (top module names "
                        "can collide across designs). Off by default.")
    p.add_argument("--cleanup-remote", action="store_true",
                   help="remove build_<top>_ps/ and its logs from the server "
                        "after pulling. Default OFF: post-synthesis runs are "
                        "expensive (a full synth + a multi-hundred-MB netlist "
                        "elaboration), so the result logs are kept server-side "
                        "as well as pulled locally.")
    args = p.parse_args()

    run_dir = Path(args.run_dir).resolve()
    if not (run_dir / "RTL_generated").is_dir():
        raise SystemExit(f"missing {run_dir}/RTL_generated/")
    if not (run_dir / "testvectors").is_dir():
        raise SystemExit(f"missing {run_dir}/testvectors/")

    top = detect_top(run_dir, args.top)
    pull_to = (Path(args.pull_to).resolve() if args.pull_to
               else run_dir / "postsynth_remote")
    build_dir = f"{args.remote_root}/build_{top}_ps"
    script_remote = f"{args.remote_root}/build_{top}_ps.sh"

    print(f"[run_remote_postsynth_sim] run_dir: {run_dir}")
    print(f"[run_remote_postsynth_sim] top:     {top}")
    print(f"[run_remote_postsynth_sim] server:  {args.server}")
    print(f"[run_remote_postsynth_sim] remote:  {args.remote_root}")
    print(f"[run_remote_postsynth_sim] pull-to: {pull_to}")

    try:
        ensure_resources(args.server, args.remote_root)
        check_netlist(args.server, args.remote_root, top, run_dir,
                      allow_origin_mismatch=args.allow_origin_mismatch)
        stage_testbench(args.server, args.remote_root, run_dir, top, build_dir)
        stage_testvectors(args.server, args.remote_root, run_dir)
        script_text = build_sim_script(args.remote_root, top, build_dir)
        subprocess.run(["ssh", args.server, f"cat > {shlex.quote(script_remote)}"],
                       input=script_text, text=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"[run_remote_postsynth_sim] staging failed: {e}", file=sys.stderr)
        return EXIT_TOOLING

    sim_rc, sim_log = run_postsynth_sim(args.server, args.remote_root, top,
                                        pull_to, build_dir, script_remote)

    # Pull the elaboration log too — netlist elaboration is where the
    # interesting failures (missing cells, glbl issues) surface.
    try:
        _run(["rsync", "-a", f"{args.server}:{build_dir}/elab.log",
              f"{pull_to}/elab.log"], check=True)
    except subprocess.CalledProcessError:
        print("[run_remote_postsynth_sim] note: elab.log not pulled")

    if sim_rc != 0:
        print(f"[run_remote_postsynth_sim] netlist sim tooling exit {sim_rc} — see "
              f"{pull_to}/postsynth_sim_stdout.log", file=sys.stderr)
        return EXIT_TOOLING

    verdict, summary = parse_verdict(top, sim_log)
    print(f"[run_remote_postsynth_sim] post-synthesis {summary}")

    if args.cleanup_remote:
        try:
            _ssh(args.server,
                 f"rm -rf {shlex.quote(build_dir)} {shlex.quote(script_remote)} "
                 f"{shlex.quote(args.remote_root)}/build_{top}_ps.log "
                 f"{shlex.quote(args.remote_root)}/build_{top}_ps.exit",
                 check=True)
        except subprocess.CalledProcessError as e:
            print(f"[run_remote_postsynth_sim] warning: cleanup failed: {e}",
                  file=sys.stderr)
    else:
        print(f"[run_remote_postsynth_sim] kept on server: {build_dir}/ "
              f"and build_{top}_ps.log (pass --cleanup-remote to remove)")

    if verdict == "PASS":
        return EXIT_PASS
    if verdict == "FAIL":
        return EXIT_FAIL
    return EXIT_TOOLING


if __name__ == "__main__":
    sys.exit(main())
