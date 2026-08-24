# core/walker.py
"""
Translate a (SolutionNode, LutReportNode) pair into an IRModule.
Contract: _implement(sol, rep, A, B, builder, lib) -> Signal (that subtree's product).
  - TilingNode leaf   : builds one product per DSP/LUT tile, feeds it into the bit heap at weight a0+b0
  - Karatsuba2Node    : splits A0/A1/B0/B1, builds dA/dB, recurses into the three subtrees, merges via the reconstruction formula
Current stage: the whole tree only produces one Product (the top-level output).
"""
from __future__ import annotations

from dsp_multiplier.frontend.datamodel import Signedness
from dsp_multiplier.frontend.seed_tiles import oriented_sign_mode, build_static_seed_library, tile_latency_of
from dsp_multiplier.frontend.solution_tree import TilingNode, Karatsuba2Node, Karatsuba3Node, GridNode
from dataclasses import dataclass, field
from dsp_multiplier.frontend.storage import assert_aligned
import dsp_multiplier.backend.ir as IR
from dsp_multiplier.backend.schedule import align_latency
from dsp_multiplier.backend.delay_model import LatencyMode, ns_budget_latency

def _is_signed(s: Signedness) -> bool:
    return s is Signedness.SIGNED


def _params_dict(impl) -> dict:
    """impl.body.parameters is a tuple of ("key", value) pairs;
    dict()-ing it lets you look things up by name. SeedTiles guarantees
    key names are unique."""
    return dict(impl.body.parameters)


def _mode_of(modes, node) -> str:
    """Which sign-handling route this node's final heap takes.
    When `modes` is None (caller didn't pass one), always "extend" --
    identical to the behavior before this option existed."""
    return "extend" if modes is None else modes.get(id(node), "extend")

@dataclass
class TraceNode:
    """The footprint left behind while translating: which subtree ->
    which product signal. Same shape as the solution/report trees, just
    with the signal recorded too, for inspecting timing later."""
    kind: str                 # "leaf" / "K2" / "K3" / "Grid"
    a_width: int
    b_width: int
    a_in: object = None       # the A fed into this subtree (may be a slice or a difference)
    b_in: object = None
    signal: object = None     # this subtree's product
    children: list = field(default_factory=list)   # [(name, TraceNode), ...]


def _kind_of(node) -> str:
    """Short tag for a solution node's type, used by TraceNode.kind."""
    if isinstance(node, TilingNode):
        return "leaf"
    if isinstance(node, Karatsuba3Node):
        return "K3"
    if isinstance(node, GridNode):
        return "Grid"
    if isinstance(node, Karatsuba2Node):
        return "K2"
    raise TypeError(f"unsupported solution node: {type(node).__name__}")


def _sub_trace(tr, name, node):
    """Open a trace node for a child and attach it under `tr`. If `tr` is
    None this stays None all the way down (= tracing disabled, zero overhead)."""
    if tr is None:
        return None
    child = TraceNode(kind=_kind_of(node),
                      a_width=node.a_width, b_width=node.b_width)
    tr.children.append((name, child))
    return child


def _implement_leaf(node, report, A, B, b, lib, modes=None) -> IR.Signal:
    """Build one product per DSP placement and LUT rectangle, feed each
    into a bit heap at its own weight, and seal it."""
    acc = IR.TermAccumulator()

    # ---- DSP tiles: the solution tree's placements ----
    for p in node.placements:
        rect = p.bounding_rect                       # board coordinates, extent already accounts for transposition
        # board-side operand sign: flip the impl's local sign per orientation
        board_sign = oriented_sign_mode(p.required_sign_mode, p.key.orientation)
        a_sig = b.slice(A, rect.a0, rect.a_width, board_sign.a is Signedness.SIGNED)
        b_sig = b.slice(B, rect.b0, rect.b_width, board_sign.b is Signedness.SIGNED)

        term = p.output_terms[0]
        impl = lib.implementations[p.key.impl_id]
        pm = _params_dict(impl)          # to pull out rtl_module_name / chain_blocks

        # bounding_rect has already been clipped to the board, so the
        # slice is only rect.a_width bits; the pad_a bits that fall
        # off-board get filled in by the HDL generator (sign bit/0),
        # without changing the value. Value unchanged -> product unchanged
        # -> term.width / lsb_weight are used as-is.
        assert term.width >= rect.a_width + rect.b_width, (
            f"{p.key}: output_term is only {term.width} bits, "
            f"too narrow for the on-board {rect.a_width}x{rect.b_width} product"
        )

        prod = b.dsp(
            a_sig, b_sig,
            width=term.width,
            signed=term.signedness is Signedness.SIGNED,
            backend_key=impl.body.backend_key,
            params=impl.body.parameters,
            impl_id=str(p.key.impl_id),
            orientation=p.key.orientation.value,
            latency=tile_latency_of(impl),
            pad_a=p.pad_a, pad_b=p.pad_b,             # off-board padding
            # a chain and a single DSP use different .sv files; carry that distinction into the IR
            rtl_module_name=pm.get("rtl_module_name", ""),
            chain_blocks=pm.get("chain_blocks", 1),
            pcin_pitch=pm.get("pcin_pitch", 0),
        )
        acc.add(prod, term.lsb_weight)               # weight = a0+b0

    # ---- LUT leftovers: the report's rects (never recomputed here) ----
    for r in report.rects:
        # per-rect sign: only treated as signed when it touches the sub-board's sign edge (MSB at the high index)
        a_signed = _is_signed(node.a_signedness) and (r.a0 + r.a_width == node.a_width)
        b_signed = _is_signed(node.b_signedness) and (r.b0 + r.b_width == node.b_width)
        a_sig = b.slice(A, r.a0, r.a_width, a_signed)
        b_sig = b.slice(B, r.b0, r.b_width, b_signed)
        prod = b.lut_mult(
            a_sig, b_sig,
            width=r.a_width + r.b_width,
            signed=(a_signed or b_signed),
            a_signed=a_signed, b_signed=b_signed,
        )
        acc.add(prod, r.a0 + r.b0)                    # weight = a0+b0

    out_signed = _is_signed(node.a_signedness) or _is_signed(node.b_signedness)
    return acc.seal(b, width=node.a_width + node.b_width, signed=out_signed,
                    sign_mode=_mode_of(modes, node))


def _implement_karatsuba2(node, report, A, B, b, lib, tr=None,
                          modes=None) -> IR.Signal:
    """Slice A0/A1/B0/B1, build the two differences, recurse into the
    three sub-products, and reconstruct via Karatsuba's formula."""
    assert node.k_a == node.k_b, "this merge requires k_a == k_b"
    k = node.k_a          # k_a is the low segment's width, i.e. the shift amount
    # order must match SolutionTree.children_of(K2): (low, mid, high)
    lo_rep, mid_rep, hi_rep = report.children

    # ---- slice A, B ----
    # Width and sign are both read off the child node, never hardcoded.
    # Previously A1/B1 hardcoded signed=True, which blew up in
    # _implement's assertion when the parent was unsigned (this happens
    # once you descend into K2 under an unsigned board) -- fixed here too.
    A0 = b.slice(A, 0, node.low.a_width,  _is_signed(node.low.a_signedness))
    B0 = b.slice(B, 0, node.low.b_width,  _is_signed(node.low.b_signedness))
    A1 = b.slice(A, k, node.high.a_width, _is_signed(node.high.a_signedness))
    B1 = b.slice(B, k, node.high.b_width, _is_signed(node.high.b_signedness))

    # ---- differences: dA = A1 - A0, dB = B0 - B1 (signed), width taken from the mid subtree's declared input width ----
    dA = b.sub(A1, A0, width=node.mid.a_width)
    dB = b.sub(B0, B1, width=node.mid.b_width)

    # Build the trace nodes in low/mid/high order first, so that's the printed order too.
    tr_lo, tr_mid, tr_hi = (_sub_trace(tr, "low",  node.low),
                            _sub_trace(tr, "mid",  node.mid),
                            _sub_trace(tr, "high", node.high))
    P_lo  = _implement(node.low,  lo_rep,  A0, B0, b, lib, tr_lo,  modes)
    P_hi  = _implement(node.high, hi_rep,  A1, B1, b, lib, tr_hi,  modes)
    P_mid = _implement(node.mid,  mid_rep, dA, dB, b, lib, tr_mid, modes)

    # dA*dB = (A1-A0)*(B0-B1), so the cross term = P_hi + P_lo + P_mid
    # ---- reconstruction: P = P_hi*2^(2k) + (P_hi + P_lo + P_mid)*2^k + P_lo ----
    acc = IR.TermAccumulator()
    acc.add(P_lo,  0)             # P_lo @ 0
    acc.add(P_lo,  k)            # the +P_lo inside cross*2^k
    acc.add(P_hi,  k)            # the +P_hi inside cross*2^k
    acc.add(P_mid, k)             # the +P_mid inside cross*2^k
    acc.add(P_hi,  2 * k)        # P_hi*2^(2k)

    out_signed = _is_signed(node.a_signedness) or _is_signed(node.b_signedness)
    return acc.seal(b, width=node.a_width + node.b_width, signed=out_signed,
                    sign_mode=_mode_of(modes, node))

def _implement_karatsuba3(node, report, A, B, b, lib, tr=None,
                          modes=None) -> IR.Signal:
    """3-way Karatsuba. Derivation (A = A0 + A1*2^k + A2*2^2k, same for B):

        d0=A0B0  d1=A1B1  d2=A2B2
        m01=(A1-A0)(B0-B1)  ->  A0B1+A1B0 = m01+d0+d1
        m02=(A2-A0)(B0-B2)  ->  A0B2+A2B0 = m02+d0+d2
        m12=(A2-A1)(B1-B2)  ->  A1B2+A2B1 = m12+d1+d2

    Grouped by power of 2^k, 12 terms total, all additions (that's exactly
    why this direction of subtraction was chosen):
        weight 0  : d0
        weight k  : m01 + d0 + d1
        weight 2k : m02 + d0 + d1 + d2
        weight 3k : m12 + d1 + d2
        weight 4k : d2
    """
    assert node.k_a == node.k_b, "karatsuba3 merge requires k_a == k_b"
    k = node.k_a
    # order must match children_of(K3): (d0, d1, d2, m01, m02, m12)
    d0_rep, d1_rep, d2_rep, m01_rep, m02_rep, m12_rep = report.children

    # ---- slice three segments: A0=A[0:k], A1=A[k:2k], A2=A[2k:] (only the top segment carries the parent's sign) ----
    A0 = b.slice(A, 0,     node.d0.a_width, _is_signed(node.d0.a_signedness))
    A1 = b.slice(A, k,     node.d1.a_width, _is_signed(node.d1.a_signedness))
    A2 = b.slice(A, 2 * k, node.d2.a_width, _is_signed(node.d2.a_signedness))
    B0 = b.slice(B, 0,     node.d0.b_width, _is_signed(node.d0.b_signedness))
    B1 = b.slice(B, k,     node.d1.b_width, _is_signed(node.d1.b_signedness))
    B2 = b.slice(B, 2 * k, node.d2.b_width, _is_signed(node.d2.b_signedness))

    # ---- six differences: high-minus-low on the A side, low-minus-high on the B side (per Karatsuba3Node's convention) ----
    dA01 = b.sub(A1, A0, width=node.m01.a_width)
    dB01 = b.sub(B0, B1, width=node.m01.b_width)
    dA02 = b.sub(A2, A0, width=node.m02.a_width)
    dB02 = b.sub(B0, B2, width=node.m02.b_width)
    dA12 = b.sub(A2, A1, width=node.m12.a_width)
    dB12 = b.sub(B1, B2, width=node.m12.b_width)

    names = ("d0", "d1", "d2", "m01", "m02", "m12")
    kids  = (node.d0, node.d1, node.d2, node.m01, node.m02, node.m12)
    t0, t1, t2, t01, t02, t12 = [_sub_trace(tr, n, k)
                                 for n, k in zip(names, kids)]
    P_d0  = _implement(node.d0,  d0_rep,  A0,   B0,   b, lib, t0,  modes)
    P_d1  = _implement(node.d1,  d1_rep,  A1,   B1,   b, lib, t1,  modes)
    P_d2  = _implement(node.d2,  d2_rep,  A2,   B2,   b, lib, t2,  modes)
    P_m01 = _implement(node.m01, m01_rep, dA01, dB01, b, lib, t01, modes)
    P_m02 = _implement(node.m02, m02_rep, dA02, dB02, b, lib, t02, modes)
    P_m12 = _implement(node.m12, m12_rep, dA12, dB12, b, lib, t12, modes)
    # ---- reconstruction: sum all 12 terms ----
    acc = IR.TermAccumulator()
    for sig, w in (
        (P_d0,  0),
        (P_m01, k),     (P_d0, k),      (P_d1, k),
        (P_m02, 2 * k), (P_d0, 2 * k),  (P_d1, 2 * k), (P_d2, 2 * k),
        (P_m12, 3 * k), (P_d1, 3 * k),  (P_d2, 3 * k),
        (P_d2,  4 * k),
    ):
        acc.add(sig, w)

    out_signed = _is_signed(node.a_signedness) or _is_signed(node.b_signedness)
    out_mode = _mode_of(modes, node)
    return acc.seal(b, width=node.a_width + node.b_width, signed=out_signed,
                    sign_mode=out_mode)


def _collect_grid_terms(node, report, A, B, b, lib, tr, modes,
                        acc, base_offset, name_prefix):
    """Flatten a Grid chain headed by `node` into the same accumulator: as
    long as a square/remainder is still a GridNode, keep flattening deeper
    (weights accumulate on top of base_offset; A/B are re-sliced in that
    node's own local coordinate system); once a Tiling/K2/K3 is reached,
    actually call _implement once and feed the product that subtree seals
    for itself in as one term (K2/K3 still have their own layered heap
    internally -- this doesn't flatten across a K2/K3 boundary).

    The trace is flattened right along with it: a nested Grid layer
    doesn't get its own trace node (it no longer has an independent
    product signal), its squares/remainder attach directly under the
    outermost Grid's trace node, with the name carrying a path prefix
    (e.g. "remainder.sq0") to keep them identifiable.
    """
    square_reports = report.children[:len(node.children)]
    remainder_report = (report.children[-1]
                        if node.remainder is not None else None)

    for i, (child, child_report) in enumerate(
            zip(node.children, square_reports)):
        local = i * node.tile_width
        offset = base_offset + local
        if node.a_is_chunked:
            child_A = b.slice(A, local, child.a_width,
                              _is_signed(child.a_signedness))
            child_B = B
        else:
            child_A = A
            child_B = b.slice(B, local, child.b_width,
                              _is_signed(child.b_signedness))

        name = f"{name_prefix}sq{i}"
        if isinstance(child, GridNode):
            _collect_grid_terms(child, child_report, child_A, child_B, b, lib,
                                tr, modes, acc, offset, f"{name}.")
        else:
            child_trace = _sub_trace(tr, name, child)
            product = _implement(child, child_report, child_A, child_B,
                                 b, lib, child_trace, modes)
            acc.add(product, offset)

    if node.remainder is not None:
        local = len(node.children) * node.tile_width
        offset = base_offset + local
        remainder = node.remainder
        if node.a_is_chunked:
            child_A = b.slice(A, local, remainder.a_width,
                              _is_signed(remainder.a_signedness))
            child_B = B
        else:
            child_A = A
            child_B = b.slice(B, local, remainder.b_width,
                              _is_signed(remainder.b_signedness))

        name = f"{name_prefix}remainder"
        if isinstance(remainder, GridNode):
            _collect_grid_terms(remainder, remainder_report, child_A, child_B,
                                b, lib, tr, modes, acc, offset, f"{name}.")
        else:
            child_trace = _sub_trace(tr, name, remainder)
            product = _implement(remainder, remainder_report, child_A, child_B,
                                 b, lib, child_trace, modes)
            acc.add(product, offset)


def _implement_grid(node, report, A, B, b, lib, tr=None,
                    modes=None) -> IR.Signal:
    """Flatten the whole (possibly many levels deep) Grid chain headed by
    `node` into a single final heap.

    Difference from the old per-level seal: previously, when a remainder
    was a GridNode, it would recursively _implement its own product,
    resolve it into a two's-complement word, and feed that in as a new
    term of the parent heap -- N levels of nesting meant N round trips of
    "compress -> resolve -> sign-extend -> compress again". A Grid never
    has subtraction/a preadder to begin with (it's pure position-weighted
    addition), so these round trips are mathematically unnecessary:
    flatten every square/remainder term of the whole chain straight into
    one TermAccumulator, seal only once at the outermost level, saving
    N-1 round trips and N-1 cycles of BitHeap latency along with it. K2/K3
    boundaries are untouched -- crossing one still honestly resolves via
    _implement (their subtraction happens on the operands, not as pure
    accumulation).
    """
    acc = IR.TermAccumulator()
    _collect_grid_terms(node, report, A, B, b, lib, tr, modes, acc, 0, "")

    out_signed = (_is_signed(node.a_signedness)
                  or _is_signed(node.b_signedness))
    return acc.seal(b, width=node.a_width + node.b_width,
                    signed=out_signed, sign_mode=_mode_of(modes, node))

def build_ir(node, report, *, library=None, name=None, latency=None,
             trace=None, sign_modes=None) -> IR.IRModule:
    """Top-level entry point: build the A, B input ports, recursively
    translate, seal into an IRModule."""
    assert_aligned(node, report)
    lib = library or build_static_seed_library()

    b = IR.IRBuilder(latency=latency)     # pass the caller's config through
    A = b.input("A", node.a_width, _is_signed(node.a_signedness))
    B = b.input("B", node.b_width, _is_signed(node.b_signedness))
    root = None
    if trace is not None:
        root = TraceNode(kind=_kind_of(node),
                         a_width=node.a_width, b_width=node.b_width)
        trace.append(root)             # the caller gets the tree root via trace[0]
    out = _implement(node, report, A, B, b, lib, root, sign_modes)
    return b.finish(name or f"mul_{node.a_width}x{node.b_width}", out)


def _apply_latency_mode(module, latency_mode, latency_budget, stretch_report):
    """Stretch an already-built module according to latency_mode, returning
       a new module. mode0 (FIXED) passes it through unchanged -- kept for
       debugging, for when you want to bypass mode3's Pareto search and
       see what SeedTiles' pinned configuration looks like directly.
       Passing a list for stretch_report records the NsParetoPoint chosen
       at this step.

       Both build_rtl_interface and build_final_module dispatch through
       this one function -- written once so the two entry points don't
       each maintain their own copy and drift apart (that's exactly what
       happened when mode3 first launched: the standalone evaluation entry
       point had hand-copied the old build_ir-then-align_latency sequence
       without the latency_mode branch, so the latency it reported didn't
       match what was actually built).

       (mode1 STRETCH / mode2 BUDGET, the units/depth abstract-proxy modes,
       have been retired -- dispatch only has FIXED / NS_BUDGET left.)"""
    if latency_mode is LatencyMode.NS_BUDGET:
        # mode3 (default): the real ns model, DelayModel's three-tier pruning.
        # latency_budget=None means take the highest-Fmax (shortest
        # critical path) point on the frontier outright, regardless of
        # cycle cost; given a budget, pick the highest-Fmax feasible point
        # within it.
        point = ns_budget_latency(module, latency_budget)
        if stretch_report is not None:
            stretch_report.append(point)       # note: appends an NsParetoPoint
        return point.module
    if latency_mode is LatencyMode.FIXED:
        return module
    raise NotImplementedError(f"unimplemented latency_mode: {latency_mode}")


def build_final_module(
    node,
    report,
    *,
    library=None,
    name=None,
    latency=None,
    trace=None,
    sign_modes=None,
    latency_mode=LatencyMode.NS_BUDGET,
    latency_budget=None,     # mode3-specific: None = default to the shortest-critical-path (highest-Fmax) point
    stretch_report=None,
):
    """build_ir -> stretch per latency_mode -> align_latency, stopping at
       an "aligned IRModule" without assembling SystemVerilog. Callers like
       EmitTB/EmitHWEval that only need the IRModule itself (not
       RTLInterface.blocks' manifest) should use this instead of
       re-assembling build_ir+align_latency by hand -- that guarantees
       they always get the exact same circuit build_rtl_interface actually
       emits, instead of silently drawing two different designs because
       library/sign_modes/latency_mode weren't all passed through.

       Defaults to mode3 (NS_BUDGET); without latency_budget it takes the
       shortest-critical-path point on the Pareto frontier. Pass
       latency_budget to fix the cycle count (cap total latency to buy
       higher Fmax, or the reverse, to save cycles); pass
       latency_mode=LatencyMode.FIXED to skip the optimizer entirely and
       debug against SeedTiles' pinned configuration."""
    module = build_ir(
        node, report, library=library, name=name, latency=latency,
        trace=trace, sign_modes=sign_modes,
    )
    module = _apply_latency_mode(module, latency_mode, latency_budget, stretch_report)
    return align_latency(module)


def build_rtl_interface(
    node,
    report,
    *,
    library=None,
    name=None,
    latency=None,
    module_name_resolver=None,
    align=True,
    trace=None,
    sign_modes=None,
    latency_mode=LatencyMode.NS_BUDGET,
    latency_budget=None,     # mode3-specific: None = default to the shortest-critical-path (highest-Fmax) point
    stretch_report=None,     # pass a list in to collect the chosen NsParetoPoint
):
    """Build IR and emit its phase-2 SystemVerilog block interface.

    No latency alignment or backend generation is performed.  The returned
    ``RTLInterface.blocks`` manifest is the extension point for later DSP
    block lookup and ``versal_arith`` LUT/bit-heap generation.

    Defaults to mode3 (NS_BUDGET), picking the shortest-critical-path point
    on the Pareto frontier; pass ``latency_budget`` to cap total latency
    instead, or ``latency_mode=LatencyMode.FIXED`` to bypass the optimizer
    entirely (debugging).
    """
    from rtl_gen.dsp_multiplier.interface import emit_systemverilog

    module = build_ir(
        node, report, library=library, name=name, latency=latency,
        trace=trace, sign_modes=sign_modes,
    )
    module = _apply_latency_mode(module, latency_mode, latency_budget, stretch_report)

    if align:
        module = align_latency(module)    # insert alignment FFs
    return emit_systemverilog(
        module,
        module_name_resolver=module_name_resolver,
    )

def _implement(node, report, A, B, b, lib, tr=None, modes=None) -> IR.Signal:
    """Dispatch to the right _implement_* for this node's type; every
    recursive call in this module goes through here."""
    # incoming signal signs must match what the node declares -- fail fast
    assert A.width == node.a_width and B.width == node.b_width, "input width mismatch"
    assert A.signed == _is_signed(node.a_signedness), "A signedness mismatch"
    assert B.signed == _is_signed(node.b_signedness), "B signedness mismatch"

    if tr is not None:
        tr.a_in, tr.b_in = A, B        # record the inputs, used to compute start

    if isinstance(node, TilingNode):
        sig = _implement_leaf(node, report, A, B, b, lib, modes)
    elif isinstance(node, Karatsuba3Node):
        sig = _implement_karatsuba3(node, report, A, B, b, lib, tr, modes)
    elif isinstance(node, GridNode):
        sig = _implement_grid(node, report, A, B, b, lib, tr, modes)
    elif isinstance(node, Karatsuba2Node):
        sig = _implement_karatsuba2(node, report, A, B, b, lib, tr, modes)
    else:
        raise TypeError(f"unsupported solution node: {type(node).__name__}")

    if tr is not None:
        tr.signal = sig                # record the product, used to compute end
    return sig
