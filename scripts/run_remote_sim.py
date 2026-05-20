#!/usr/bin/env python3
"""run_remote_sim.py — stage a versal_arith run onto the V80 server and
batch-simulate it through Vivado.

Workflow (each step uses ssh / rsync via subprocess):

  1. Validate the local run dir; auto-detect the top module from
     ``RTL_generated/<top>_tb.sv``.
  2. Ensure GPC primitives exist on the server (push if missing).
  3. Wipe the shared slot: ``src/rtl/*.sv``, ``src/rtl_tb/*.sv``,
     ``testvectors/``.
  4. rsync ``RTL_generated/*.sv`` (excluding ``*_tb.sv``) into ``src/rtl/``.
  5. Patch the testbench: rewrite the depth-5 ``$readmemh`` paths to
     ``../testvectors/`` so the testvectors resolve relative to
     ``build_<top>_tb/`` on the server. The testbench module name is left
     alone — generator and server both use the ``<top>_tb`` suffix
     convention.
  6. rsync ``testvectors/`` to the server's project-root testvectors/.
  7. Run ``./scripts/sim.sh <top>`` on the server; capture stdout.
  8. rsync ``build_<top>_tb/`` back into ``<pull-to>/``; save sim stdout.
  9. Parse the log for ``SUCCESS!`` / ``PASS All`` / ``FAILED:`` / ``WRONG``;
     print a verdict; exit 0 (PASS) or 1 (FAIL) or 2 (tooling failure).
 10. Optionally clean ``build_<top>_tb/`` on the server.

Run from the project root, e.g.::

    python scripts/run_remote_sim.py \\
        --run-dir work/pre_twist_NTT128/cmultbank
"""

from __future__ import annotations

import argparse
import os
import os
import re
import subprocess
import sys
import shlex
import time
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
VERSAL_RTL_DIR = PROJECT_ROOT / "versal_arith" / "rtl"

# Defaults can be overridden via env vars V80_SERVER / V80_REMOTE_ROOT, or
# via the --server / --remote-root flags. The bundled fallbacks are
# intentionally generic placeholders — set the env vars to your own SSH
# alias + Vivado-project root, or always pass the flags explicitly.
DEFAULT_SERVER = os.environ.get("V80_SERVER", "v80-server")
DEFAULT_REMOTE_ROOT = os.environ.get("V80_REMOTE_ROOT", "~/AMD_V80_dev")

# Tooling exit codes
EXIT_PASS = 0
EXIT_FAIL = 1
EXIT_TOOLING = 2


def _run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    """subprocess.run wrapper with verbose echo."""
    print(f"[run_remote_sim] $ {' '.join(shlex.quote(c) for c in cmd)}")
    return subprocess.run(cmd, **kw)


def _ssh(server: str, remote_cmd: str, **kw) -> subprocess.CompletedProcess:
    return _run(["ssh", server, remote_cmd], **kw)


def detect_top(run_dir: Path, override: str | None) -> str:
    if override:
        return override
    rtl_dir = run_dir / "RTL_generated"
    tb_files = sorted(rtl_dir.glob("*_tb.sv"))
    if len(tb_files) == 0:
        raise SystemExit(
            f"no testbench found under {rtl_dir} (expected one *_tb.sv)"
        )
    if len(tb_files) > 1:
        names = ", ".join(f.name for f in tb_files)
        raise SystemExit(
            f"multiple testbenches under {rtl_dir} ({names}); pass --top "
            "to disambiguate"
        )
    return tb_files[0].name.removesuffix("_tb.sv")


def ensure_resources(server: str, remote_root: str) -> None:
    """If src/rtl_resources/ is empty, push the GPC primitives."""
    test = _ssh(server, f"test -e {shlex.quote(remote_root)}/src/rtl_resources/c3_2.sv",
                check=False)
    if test.returncode == 0:
        print("[run_remote_sim] resources already present on server")
        return
    print("[run_remote_sim] pushing GPC primitives to src/rtl_resources/")
    _ssh(server, f"mkdir -p {shlex.quote(remote_root)}/src/rtl_resources",
         check=True)
    _run([
        "rsync", "-a", "--ignore-existing",
        f"{VERSAL_RTL_DIR}/",
        f"{server}:{remote_root}/src/rtl_resources/",
    ], check=True)


def wipe_slot(server: str, remote_root: str) -> None:
    cmd = (
        f"cd {shlex.quote(remote_root)} && "
        "rm -f src/rtl/*.sv src/rtl/*.v "
        "src/rtl_tb/*.sv src/rtl_tb/*.v && "
        "rm -rf testvectors && mkdir -p testvectors"
    )
    _ssh(server, cmd, check=True)


def stage_rtl(server: str, remote_root: str, run_dir: Path) -> None:
    """Push RTL_generated/*.sv (minus *_tb.sv) to src/rtl/."""
    _run([
        "rsync", "-a",
        "--include=*.sv", "--include=*.v",
        "--exclude=*_tb.sv", "--exclude=*_tb.v",
        "--exclude=*",
        f"{run_dir}/RTL_generated/",
        f"{server}:{remote_root}/src/rtl/",
    ], check=True)


def stage_testbench(server: str, remote_root: str, run_dir: Path,
                     top: str) -> None:
    """Read the testbench, patch $readmemh paths, push to src/rtl_tb/."""
    src = run_dir / "RTL_generated" / f"{top}_tb.sv"
    if not src.is_file():
        raise SystemExit(f"testbench not found: {src}")
    text = src.read_text()
    patched = re.sub(
        r'"(\.\./){5}testvectors/',
        '"../testvectors/',
        text,
    )
    if patched == text:
        print("[run_remote_sim] warning: $readmemh path patch matched "
              "nothing — check the testbench's path style")
    # Push via stdin → file on the server. Avoids creating a temp local file.
    dest = f"{remote_root}/src/rtl_tb/{top}_tb.sv"
    subprocess.run(
        ["ssh", server, f"cat > {shlex.quote(dest)}"],
        input=patched,
        text=True,
        check=True,
    )


def stage_testvectors(server: str, remote_root: str, run_dir: Path) -> None:
    _run([
        "rsync", "-a", "--delete",
        f"{run_dir}/testvectors/",
        f"{server}:{remote_root}/testvectors/",
    ], check=True)


def run_sim(server: str, remote_root: str, top: str, pull_to: Path,
            poll_interval_s: int = 30) -> tuple[int, str]:
    """Invoke ./scripts/sim.sh <top> on the server. Return (exit_code, log_text).

    The sim is fully detached from the launching SSH session via setsid + nohup
    + background, with stdin/stdout/stderr redirected to a server-side log file.
    The launching SSH returns immediately. Completion is then detected by
    polling for a marker file (`build_<top>_tb_sim.exit`) that the wrapper
    writes after sim.sh exits.

    This sidesteps two failure modes from streaming the log live: (a) a stuck
    SSH stdout pipe leaving the local subprocess hanging after xsim has
    already finished, and (b) a jump-host idle timeout severing the connection
    mid-sim — both observed on long NTT128 sims (~30 min)."""
    sim_log_remote = f"{remote_root}/build_{top}_tb_sim.log"
    sim_exit_remote = f"{remote_root}/build_{top}_tb_sim.exit"
    sim_log_local = pull_to / "sim_stdout.log"
    pull_to.mkdir(parents=True, exist_ok=True)

    # Launch (detached). Removes any stale exit marker first so the polling loop
    # below cannot trip on a previous run's marker if launch racing happens.
    # bash (not sh) because sim.sh's `source ./source` is a bashism.
    launch_cmd = (
        f"cd {shlex.quote(remote_root)} && "
        f"rm -f {shlex.quote(sim_exit_remote)} && "
        f"setsid nohup bash -c "
        f"'cd {shlex.quote(remote_root)} && source ./source && "
        f"./scripts/sim.sh {shlex.quote(top)} "
        f"> {shlex.quote(sim_log_remote)} 2>&1; "
        f"echo $? > {shlex.quote(sim_exit_remote)}' "
        f"</dev/null >/dev/null 2>&1 &"
    )
    print(f"[run_remote_sim] launching detached sim on {server}")
    _ssh(server, launch_cmd, check=True)

    # Poll for the exit marker. Each poll is a short, idle-timeout-resistant SSH
    # call; we don't keep a long-lived connection open during the sim.
    print(f"[run_remote_sim] polling for {sim_exit_remote} every {poll_interval_s}s")
    sim_exit: int | None = None
    while sim_exit is None:
        time.sleep(poll_interval_s)
        proc = subprocess.run(
            ["ssh",
             "-o", "ServerAliveInterval=30", "-o", "ServerAliveCountMax=3",
             "-o", "ConnectTimeout=30",
             server,
             f"test -f {shlex.quote(sim_exit_remote)} && cat {shlex.quote(sim_exit_remote)} || echo NOT_DONE"],
            capture_output=True, text=True,
        )
        if proc.returncode != 0:
            print(f"[run_remote_sim] poll SSH failed (rc={proc.returncode}, "
                  f"stderr={proc.stderr.strip()!r}); retrying")
            continue
        out = proc.stdout.strip()
        if out == "NOT_DONE" or out == "":
            continue
        try:
            sim_exit = int(out)
        except ValueError:
            print(f"[run_remote_sim] unexpected exit marker content: {out!r}; retrying")
            continue
    print(f"[run_remote_sim] sim done, exit={sim_exit}; pulling log")

    # Fetch the log via rsync — small marker file content above already
    # confirmed the sim finished writing.
    try:
        _run([
            "rsync", "-a",
            f"{server}:{sim_log_remote}",
            str(sim_log_local),
        ], check=True)
    except subprocess.CalledProcessError as e:
        print(f"[run_remote_sim] warning: rsync of sim log failed ({e})")
        sim_log_local.write_text("")

    log_text = sim_log_local.read_text() if sim_log_local.exists() else ""
    return sim_exit, log_text


def pull_back(server: str, remote_root: str, top: str, pull_to: Path,
              full_build_dir: bool = False) -> None:
    """Pull simulation artifacts back to <pull_to>/.

    By default, only the small elaboration log (`elab.log`) is pulled —
    `run_sim` already grabs the simulation stdout (`sim_stdout.log`), which
    is what carries the per-testvector PASS/FAIL markers used by
    `parse_verdict`. The Vivado build directory `build_<top>_tb/` (xsim.dir,
    .wdb, .pb) is multi-GB and rarely needed; opt in with `full_build_dir=True`
    when you actually want the waveform / xsim state for offline debug."""
    pull_to.mkdir(parents=True, exist_ok=True)
    if full_build_dir:
        _run([
            "rsync", "-a",
            f"{server}:{remote_root}/build_{top}_tb/",
            f"{pull_to}/build_{top}_tb/",
        ], check=True)
        return
    # Default: just the elab log. If it doesn't exist on the remote (e.g.
    # xvlog/xelab failed before producing it), the rsync will fail — that's
    # non-fatal because the sim_stdout.log already pulled by run_sim carries
    # the verdict.
    try:
        _run([
            "rsync", "-a",
            f"{server}:{remote_root}/build_{top}_tb/elab.log",
            f"{pull_to}/elab.log",
        ], check=True)
    except subprocess.CalledProcessError as e:
        print(f"[run_remote_sim] note: elab.log not pulled ({e.returncode}); "
              f"sim_stdout.log already in {pull_to}/ has the verdict.")


PASS_RE = re.compile(r"PASS All\s+\d+")
FAIL_RE = re.compile(r"FAILED:\s*(\d+)\s*/\s*(\d+)\s*checks passed")
WRONG_RE = re.compile(r"WRONG", re.IGNORECASE)
NUM_RE = re.compile(r"PASS All\s+(\d+)")


def parse_verdict(top: str, log: str) -> tuple[str, str]:
    """Return (verdict, summary). verdict ∈ {'PASS', 'FAIL', 'UNKNOWN'}."""
    m_fail = FAIL_RE.search(log)
    if m_fail:
        passed, total = int(m_fail.group(1)), int(m_fail.group(2))
        return "FAIL", f"{top}: FAIL ({total - passed}/{total} checks failed)"
    if PASS_RE.search(log) and "SUCCESS" in log:
        m_n = NUM_RE.search(log)
        n = m_n.group(1) if m_n else "?"
        return "PASS", f"{top}: PASS ({n} checks)"
    if WRONG_RE.search(log):
        # individual wrong-vector lines without a final FAILED summary
        wrong_count = len(WRONG_RE.findall(log))
        return "FAIL", f"{top}: FAIL ({wrong_count} 'WRONG' lines in log)"
    return "UNKNOWN", f"{top}: verdict UNKNOWN — log lacks PASS/FAIL markers"


def cleanup_remote(server: str, remote_root: str, top: str) -> None:
    _ssh(server,
         f"rm -rf {shlex.quote(remote_root)}/build_{top}_tb "
         f"{shlex.quote(remote_root)}/build_{top}_tb_sim.log "
         f"{shlex.quote(remote_root)}/build_{top}_tb_sim.exit",
         check=True)


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--run-dir", required=True,
                   help="path to a generated run dir, e.g. "
                        "work/pre_twist_NTT128/cmultbank")
    p.add_argument("--top", default=None,
                   help="top module to simulate (auto-detected from "
                        "RTL_generated/*_tb.sv if omitted)")
    p.add_argument("--server", default=DEFAULT_SERVER,
                   help=f"SSH alias of the V80 server (default: {DEFAULT_SERVER})")
    p.add_argument("--remote-root", default=DEFAULT_REMOTE_ROOT,
                   help=f"path to the Vivado project on the server "
                        f"(default: {DEFAULT_REMOTE_ROOT})")
    p.add_argument("--pull-to", default=None,
                   help="local directory for the pulled-back artifacts "
                        "(default: <run_dir>/sim_remote)")
    p.add_argument("--keep-remote-build", action="store_true",
                   help="don't `rm -rf build_<top>_tb` on the server after pulling")
    p.add_argument("--pull-build-dir", action="store_true",
                   help="rsync the full build_<top>_tb/ Vivado work dir back "
                        "(xsim.dir, .wdb, .pb — multi-GB). Default off; only "
                        "the small elab.log + sim stdout log are pulled.")
    p.add_argument("--no-prune-server", action="store_true",
                   help="skip wiping src/rtl/, src/rtl_tb/, testvectors/ "
                        "before staging (use when keeping a previous run "
                        "intact)")
    args = p.parse_args()

    run_dir = Path(args.run_dir).resolve()
    if not (run_dir / "RTL_generated").is_dir():
        raise SystemExit(f"missing {run_dir}/RTL_generated/")
    if not (run_dir / "testvectors").is_dir():
        raise SystemExit(f"missing {run_dir}/testvectors/")

    top = detect_top(run_dir, args.top)
    pull_to = Path(args.pull_to).resolve() if args.pull_to else run_dir / "sim_remote"
    print(f"[run_remote_sim] run_dir:    {run_dir}")
    print(f"[run_remote_sim] top:        {top}")
    print(f"[run_remote_sim] server:     {args.server}")
    print(f"[run_remote_sim] remote:     {args.remote_root}")
    print(f"[run_remote_sim] pull-to:    {pull_to}")

    try:
        ensure_resources(args.server, args.remote_root)
        if not args.no_prune_server:
            wipe_slot(args.server, args.remote_root)
        stage_rtl(args.server, args.remote_root, run_dir)
        stage_testbench(args.server, args.remote_root, run_dir, top)
        stage_testvectors(args.server, args.remote_root, run_dir)
    except subprocess.CalledProcessError as e:
        print(f"[run_remote_sim] staging failed: {e}", file=sys.stderr)
        return EXIT_TOOLING

    sim_rc, sim_log = run_sim(args.server, args.remote_root, top, pull_to)

    # Always try to pull back what we have for diagnosis, even on sim failure.
    try:
        pull_back(args.server, args.remote_root, top, pull_to,
                  full_build_dir=args.pull_build_dir)
    except subprocess.CalledProcessError as e:
        print(f"[run_remote_sim] pull-back failed: {e}", file=sys.stderr)
        return EXIT_TOOLING

    if sim_rc != 0:
        print(f"[run_remote_sim] sim.sh exited {sim_rc} — see "
              f"{pull_to}/sim_stdout.log", file=sys.stderr)
        return EXIT_TOOLING

    verdict, summary = parse_verdict(top, sim_log)
    print(f"[run_remote_sim] {summary}")

    if not args.keep_remote_build:
        try:
            cleanup_remote(args.server, args.remote_root, top)
        except subprocess.CalledProcessError as e:
            print(f"[run_remote_sim] warning: cleanup failed: {e}",
                  file=sys.stderr)

    if verdict == "PASS":
        return EXIT_PASS
    if verdict == "FAIL":
        return EXIT_FAIL
    return EXIT_TOOLING  # UNKNOWN


if __name__ == "__main__":
    sys.exit(main())
