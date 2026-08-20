"""Latency reports for lowered DSP-multiplier designs."""
from __future__ import annotations
import dsp_multiplier.backend.ir as IR
from dsp_multiplier.backend.schedule import compute_ready, module_latency

# Print each subtree's start / end / pad, following the
# solution tree's shape. Needs the TraceNode tree collected via
# walker.build_ir(trace=[]), plus the corresponding IRModule.
#
# Definitions of the three numbers:
#   start -- which cycle this subtree's two input signals are ready (the
#            earliest it could start working)
#   end   -- which cycle this subtree's product is ready
#   pad   -- how many cycles earlier it arrives than the latest of its
#            siblings, i.e. how many FFs need inserting to hold it back;
#            pad=0 means it IS the latest one, i.e. on the critical path
class _View:
    """Wraps a module, providing convenience lookups by signal name: which
    op produced it, which cycle it's ready on."""

    def __init__(self, module: IR.IRModule):
        self.module = module
        self.ready = compute_ready(module)
        self.by_result = {op.result.name: op for op in module.ops}

    def r(self, sig) -> int:
        return self.ready[sig.name]

    def op_of(self, sig):
        return self.by_result.get(sig.name)

    def undelay(self, sig):
        """Walk back through alignment FFs to the real source signal --
        otherwise the tree would show nothing but dly0/dly1 instead of
        lut0/dsp1."""
        op = self.op_of(sig)
        while isinstance(op, IR.Delay):
            sig = op.source
            op = self.op_of(sig)
        return sig


def _block_name(op) -> str | None:
    """Whether an op is a hard block/LUT multiplier; returns its display
    name if so, None otherwise."""
    if isinstance(op, IR.DspTile):
        name = op.rtl_module_name or "DSP"
        return f"{name}x{op.chain_blocks}" if op.is_chain else name
    if isinstance(op, IR.LutMult):
        return "LUT"
    return None


def _leaf_blocks(view: _View, tr) -> list:
    """The blocks used inside a leaf, returned as [(display name, op, weight), ...]."""
    op = view.op_of(tr.signal)
    if not isinstance(op, IR.BitHeap):
        # seal was short-circuited (the leaf has only one tile): the product IS that tile
        pairs = [(op, 0)]
    else:
        pairs = [(view.op_of(view.undelay(t.signal)), t.weight)
                 for t in op.terms]

    out = []
    for o, w in pairs:
        nm = _block_name(o)
        if nm is not None:
            out.append((nm, o, w))
    return out


def _summary(blocks) -> str:
    """[('LUT',..), ('SingleDSP',..)] -> '[LUTx1 SingleDSPx2]'"""
    if not blocks:
        return ""
    cnt: dict[str, int] = {}
    for nm, _, _ in blocks:
        cnt[nm] = cnt.get(nm, 0) + 1
    return "   [" + " ".join(f"{k}x{v}" for k, v in sorted(cnt.items())) + "]"


def print_latency_tree(root, module: IR.IRModule, *,
                       show_blocks: bool = False,
                       max_depth: int = 99) -> None:
    """Print the timing tree, following the solution tree's shape.
       When show_blocks=True, also lists each tile within a leaf on its own line."""
    view = _View(module)

    def start_of(tr) -> int:
        return max(view.r(tr.a_in), view.r(tr.b_in))

    def end_of(tr) -> int:
        return view.r(tr.signal)

    def walk(label, tr, depth, pad):
        p = "  " * depth
        lab = f"{label}: " if label else ""
        kind = "Tiling" if tr.kind == "leaf" else tr.kind
        line = (f"{p}{lab}{kind} {tr.a_width}x{tr.b_width}"
                f"  start={start_of(tr)} end={end_of(tr)}")
        if pad is not None:
            line += f"  pad+{pad}"
            if pad == 0:
                line += "  <-critical path"

        blocks = _leaf_blocks(view, tr) if tr.kind == "leaf" else []
        print(line + _summary(blocks))

        if tr.kind == "leaf":
            # inside a leaf: multiple tiles have their own pad relative to each other too
            if show_blocks and len(blocks) > 1:
                target = max(view.r(o.result) for _, o, _ in blocks)
                for nm, o, w in blocks:
                    e = view.r(o.result)
                    print(f"{p}    {nm:<12} start={view.r(o.a)} end={e} "
                          f"pad+{target - e}  <<{w}")
            return

        if depth >= max_depth:
            print(f"{p}  ...")
            return

        # siblings align to each other: everyone waits for the latest one
        target = max(end_of(c) for _, c in tr.children)
        for cname, child in tr.children:
            walk(cname, child, depth + 1, target - end_of(child))

    walk("", root, 0, None)


def print_latency_report(root, module: IR.IRModule, **kwargs) -> None:
    """One call does it all: title + tree + FF overhead. Use this for everyday use."""
    print(f"\n=== Timing tree: total latency {module_latency(module)} cycles ===")
    print_latency_tree(root, module, **kwargs)

    n = sum(1 for op in module.ops if isinstance(op, IR.Delay))
    bits = sum(op.source.width * op.cycles
               for op in module.ops if isinstance(op, IR.Delay))
    print(f"\nAlignment: {n} delay chain(s), ~{bits} FF(s)")
