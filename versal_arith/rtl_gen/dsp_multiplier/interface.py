"""SystemVerilog interface emission for :mod:`dsp_multiplier.backend.ir`.

This module emits the top-level module, slices, subtractors and block
instances.  ``write_rtl_project`` (in ``rtl/project.py``) also generates the
LUT multiplier and bit-heap compressor implementations recorded in the
block manifest, and the DSP tile implementations (single DSP58 or
Karatsuba/Toom-Cook chains) via DelayModel + latency_model's RTL
generators -- see ``rtl/inner_backends.py``'s ``_write_dsp_inner``.

It does not:
  * align pipeline latency;
  * emit the implementation-only XDC constraints produced by the LUT backend.

This is the base layer of the ``rtl/`` package: dataclasses, naming/shape
helpers, and the phase-2 top-level emitter. ``rtl/wrappers.py``,
``rtl/inner_backends.py``, and ``rtl/project.py`` all import from here;
this module imports nothing from them.
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
from pathlib import Path
import re
from typing import Callable

import dsp_multiplier.backend.delay_model as DM
import dsp_multiplier.backend.ir as IR

@dataclass(frozen=True)
class BlockRequest:
    """One external RTL module required by an emitted top level."""

    kind: str
    key: str
    module_name: str                # the outer wrapper: this is what the top level instantiates
    instance_name: str
    result: IR.Signal
    operands: tuple[IR.Signal, ...] # board order (not transposed)
    params: tuple[tuple[str, object], ...] = ()
    orientation: str = "ab"
    terms: tuple[IR.WeightedTerm, ...] = ()

    # -- the real arithmetic block on the inside, always signed x signed --
    inner_module_name: str = ""
    inner_a_width: int = 0          # inner physical A width (canonical orientation)
    inner_b_width: int = 0          # inner physical B width
    latency: int = 0                # this block's latency, for pipelining the placeholder implementation
    # -- #(...) parameters to pass when instantiating the inner module. Required for parameterized modules like DSPChain --
    inner_params: tuple[tuple[str, object], ...] = ()
    sign_mode: str = "extend"       # only meaningful for a bitheap: extend / removal
    # Whether the inner ports are always signed. True for DSP / Booth
    # (the wrapper is responsible for sign-padding); False for SmallMult
    # (the ports follow the operands' own sign as-is, not a single bit padded).
    inner_signed: bool = True


@dataclass(frozen=True)
class RTLInterface:
    """Emitted top-level RTL and its phase-3 dependency manifest."""

    module: IR.IRModule
    systemverilog: str
    blocks: tuple[BlockRequest, ...]


ModuleNameResolver = Callable[[str, str, IR.IRNode], str]


@dataclass(frozen=True)
class EmittedRTL:
    """The file manifest produced by write_rtl_project."""
    top: Path
    wrappers: tuple[Path, ...]
    inners: tuple[Path, ...]
    gpc: tuple[Path, ...]
    xdc: tuple[Path, ...]

    @property
    def sv_files(self) -> tuple[Path, ...]:
        """All .sv files in compile order (lowest-level first)."""
        return (*self.gpc, *self.inners, *self.wrappers, self.top)

KEEP_HIERARCHY = True   # True while evaluating per-block LUT usage; flip to False and regenerate for the final QoR push

def _kh() -> str:
    return '(* keep_hierarchy = "yes" *) ' if KEEP_HIERARCHY else ""

def _identifier(text: str) -> str:
    value = re.sub(r"[^A-Za-z0-9_$]", "_", text)
    if not value or value[0].isdigit():
        value = "_" + value
    return value


def _sign_code(sig: IR.Signal) -> str:
    return "s" if sig.signed else "u"


def _signed_width(sig: IR.Signal) -> int:
    """Width needed to represent a signal as signed: unsigned needs one extra 0 bit."""
    return sig.width if sig.signed else sig.width + 1


SMALL_MULT_MAX = 5      # must match lut_count.estimate_bmult_luts' threshold


def _is_small_mult(op: IR.LutMult) -> bool:
    """min(external width) <= 5 -> behavioral small multiplier, let Vivado infer it.

    The check must use the external widths, exactly like
    lut_count.estimate_bmult_luts. Never use the sign-padded inner width:
    an external (5,20) unsigned pads to (6,21), and using that would make
    the two sides disagree about "small" vs "large" -- the cost model
    would be estimating a different circuit than what actually gets built."""
    return min(op.a.width, op.b.width) <= SMALL_MULT_MAX


def _inner_widths(op: IR.IRNode) -> tuple[int, int]:
    """The inner block's physical width (canonical orientation, i.e. A x B
    when not transposed)."""
    if isinstance(op, IR.Sub):
        # the inner block is always signed: an unsigned operand needs one extra sign bit padded on
        return _signed_width(op.minuend), _signed_width(op.subtrahend)
    if isinstance(op, IR.DspTile):
        # DSP always defers to what the seed library declared, never inferred
        p = dict(op.params)
        return int(p["physical_a_width"]), int(p["physical_b_width"])
    if isinstance(op, IR.LutMult):
        if _is_small_mult(op):
            # the behavioral multiplier natively supports unsigned, no sign bit padding.
            # Padding moves inside the SmallMult module, where synthesis
            # sees it as a constant 0 and folds it away; padding it in the
            # wrapper instead would be blocked by keep_hierarchy, and that
            # bit would genuinely cost a LUT.
            return op.a.width, op.b.width
        # the Booth core only does signed x signed; unsigned needs 1 zero bit padded on
        return _signed_width(op.a), _signed_width(op.b)
    raise TypeError(f"no inner widths for {type(op).__name__}")


# ---------------------------------------------------------------- DSP inner blocks
def _dsp_inner_module_name(fam: str, blocks: int, latency: int) -> str:
    """The DSP inner module's name for one (family, blocks, latency).

    The single family is a hand-written parameterized template
    (latency_model/rtl/SingleDSP.sv, picks its concrete configuration via
    #(.LATENCY, .OUT_REG) at instantiation time, one shared file for the
    whole project); chain/k2/k3/t25 each get a complete circuit freshly
    built by latency_model for every (family, blocks, latency) combination,
    with no #(...) parameters -- the module name itself must uniquely encode
    that combination, or two different circuits with the same name would
    clobber each other. The naming convention here must exactly match what
    _write_dsp_inner actually passes as module= when calling the generator;
    both come from this one function so they can't drift apart."""
    if fam == "single":
        return "SingleDSP"
    if fam == "chain":
        return f"DSPChain_L{blocks}_lat{latency}"
    if fam == "k2":
        return f"Karatsuba2x2_lat{latency}"
    if fam == "k3":
        return f"Karatsuba3x3_lat{latency}"
    if fam == "t25":
        return f"ToomCook25_lat{latency}"
    raise ValueError(f"unknown DSP family {fam!r}")


def _default_inner_module_name(op: IR.IRNode, pa: int, pb: int) -> str:
    """The inner module name for an op, using the default (non-resolver) naming."""
    if isinstance(op, IR.Sub):
        return "sub_signed"        # parameterized module, one shared file for the whole project
    if isinstance(op, IR.DspTile):
        fam, blocks = DM.dsp_family(op.params, op.impl_id)
        # early check: latency must be a number dsp_model can genuinely
        # build, regardless of whether it's pinned by mode0 from SeedTiles
        # or chosen by mode3's assign() -- the latter should never trip
        # this in theory, the former is what this check is really
        # guarding against (see dsp_multiplier.backend.delay_model.exact_dsp_config).
        DM.exact_dsp_config(fam, blocks, op.latency, label=op.impl_id)
        return _dsp_inner_module_name(fam, blocks, op.latency)
    if isinstance(op, IR.LutMult):
        if _is_small_mult(op):
            return "SmallMult"     # parameterized module, one shared file for the whole project
        return f"Bmult{pa}x{pb}"
    raise TypeError(f"no inner module name for {type(op).__name__}")


def _inner_instance_params(op: IR.IRNode) -> tuple[tuple[str, object], ...]:
    """The #(...) parameters to pass when instantiating the inner module.

    chain/k2/k3/t25-generated modules take no parameters (each latency is
    a completely different circuit, distinguished purely by module name,
    see _dsp_inner_module_name); only the single family's SingleDSP.sv is
    a parameterized template, so LATENCY/OUT_REG get passed here.
    OUT_REG only matters when LATENCY is in {1,2} (the two sub-paths tie,
    and dsp_model picks whichever has smaller ns); at LATENCY>=3 the
    module ignores this parameter itself, but passing it anyway is
    harmless and keeps the handling uniform."""
    if isinstance(op, IR.DspTile):
        fam, blocks = DM.dsp_family(op.params, op.impl_id)
        if fam != "single":
            return ()               # generated families: no parameters, distinguished by module name
        cfg = DM.exact_dsp_config(fam, blocks, op.latency, label=op.impl_id)["config"]
        return (("LATENCY", op.latency), ("OUT_REG", int(bool(cfg["P_PIPE"]))))
    if isinstance(op, IR.LutMult) and _is_small_mult(op):
        # SmallMult.sv is one source file serving every width and sign
        # combination; all five parameters must be passed. Omitting one
        # falls back to a default -- synthesis doesn't error, the result
        # is just silently wrong.
        return (("WA", op.a.width), ("WB", op.b.width),
                ("A_SIGNED", int(op.a.signed)),
                ("B_SIGNED", int(op.b.signed)),
                ("LATENCY", op.latency))
    return ()


def _check_dsp_pad(op: IR.DspTile, pa: int, pb: int) -> None:
    """Verify the IR's pad matches the inner physical width.

    The wrapper uses _to_signed_expr to pad a narrow operand up to the
    physical width; the number of bits padded MUST equal `pad` -- they're
    derived from the same source (the tile definition), and a mismatch
    means the placement layer and the seed library have drifted apart;
    the RTL would silently compute the wrong thing, so this raises instead.

    The physical width is the signed variant's width; the unsigned variant
    logically uses one fewer bit at the top, so subtract 1 before
    comparing against the on-board width."""
    # transposed: the board's a goes to the inner B port (long side), the board's b goes to inner A
    phys_a, phys_b = (pb, pa) if op.orientation == "transposed" else (pa, pb)
    want_a = phys_a - (0 if op.a.signed else 1) - op.a.width
    want_b = phys_b - (0 if op.b.signed else 1) - op.b.width
    if (want_a, want_b) != (op.pad_a, op.pad_b):
        raise ValueError(
            f"{op.result.name} ({op.impl_id}): pad mismatch.\n"
            f"  IR has pad=({op.pad_a},{op.pad_b}), but computed from physical "
            f"width {pa}x{pb} + on-board {op.a.width}x{op.b.width}"
            f" it should be ({want_a},{want_b}).\n"
            f"  Common causes: a placement's pad wasn't rotated along with "
            f"its orientation, or the seed library's physical_*_width changed."
        )

def _to_signed_expr(sig: IR.Signal, target_width: int, port: str) -> str:
    """Turn wrapper port `port` into a target_width-bit signed expression."""
    pad = target_width - sig.width
    if pad < 0:
        raise ValueError(
            f"{port}: inner width {target_width} is smaller than operand width {sig.width}"
        )
    if sig.signed:
        return f"$signed({port})"          # signed assigned to a wider signed, SV sign-extends automatically
    if pad < 1:
        raise ValueError(
            f"{port}: an unsigned operand needs at least 1 zero bit padded on before it can be used as signed"
        )
    return f"$signed({{{pad}'b0, {port}}})"


def _bitheap_shape(op: IR.BitHeap) -> str:
    """Return a canonical shape including term aliasing and output semantics."""
    aliases: dict[str, int] = {}
    terms: list[str] = []
    for t in op.terms:
        alias = aliases.setdefault(t.signal.name, len(aliases))
        terms.append(
            f"{alias}:{t.signal.width}:{t.weight}:"
            f"{int(t.negate)}:{int(t.signal.signed)}"
        )
    header = (
        f"out={op.result.width}:{int(op.result.signed)}:"
        f"lat={op.latency}:sign={op.sign_mode}"
    )
    return ";".join((header, *terms))


def _bitheap_digest(op: IR.BitHeap) -> str:
    return hashlib.sha1(_bitheap_shape(op).encode("ascii")).hexdigest()[:10]


def _default_bitheap_inner_name(op: IR.BitHeap) -> str:
    """The inner compressor-tree module name. Same shape reuses it,
       different shapes must get different modules. This name gets passed
       straight through to compressor_RTL_gen's compressor_module_name."""
    return f"bitheap_cmp_{op.result.width}_{_bitheap_digest(op)}"


def _default_module_name(kind: str, key: str, op: IR.IRNode) -> str:
    """Create deterministic placeholder names for phase-3 implementations."""

    if isinstance(op, IR.Sub):
        return _identifier(
            f"{key}_{_sign_code(op.minuend)}{_sign_code(op.subtrahend)}_"
            f"{op.minuend.width}x{op.subtrahend.width}"
        )

    if isinstance(op, IR.DspTile):
        tag = "_t" if op.orientation == "transposed" else ""
        # chain length must be in the name: two different chain lengths
        # can end up with the same on-board width after clipping, and a
        # name collision would make two different chains share one
        # wrapper, wiring CHAIN_BLOCKS wrong for one of them.
        chain = f"_x{op.chain_blocks}" if op.is_chain else ""
        return _identifier(
            f"{key}_{_sign_code(op.a)}{_sign_code(op.b)}_"
            f"{op.a.width}x{op.b.width}{chain}{tag}"
        )
    if isinstance(op, IR.LutMult):
        return _identifier(
            f"{key}_{_sign_code(op.a)}{_sign_code(op.b)}_"
            f"{op.a.width}x{op.b.width}"
        )
    if isinstance(op, IR.BitHeap):
        return f"terminal_bitheap_{op.result.width}_{_bitheap_digest(op)}"
    raise TypeError(f"no external module name for {type(op).__name__}")


def collect_block_requests(
    module: IR.IRModule,
    module_name_resolver: ModuleNameResolver | None = None,
) -> tuple[BlockRequest, ...]:
    """Return the external modules needed to implement ``module``.

    The resolver is the phase-3 extension point.  It may map an IR backend
    key to an existing module name or to a name generated by ``versal_arith``.
    """
    IR.verify(module)
    resolve = module_name_resolver or _default_module_name
    requests: list[BlockRequest] = []

    for op in module.ops:
        if isinstance(op, IR.DspTile):
            pa, pb = _inner_widths(op)
            _check_dsp_pad(op, pa, pb)
            requests.append(BlockRequest(
                kind="dsp",
                key=op.backend_key,
                module_name=resolve("dsp", op.backend_key, op),
                instance_name=f"u_{op.result.name}",
                result=op.result,
                operands=(op.a, op.b),
                params=op.params,
                orientation=op.orientation,
                inner_module_name=_default_inner_module_name(op, pa, pb),
                inner_a_width=pa,
                inner_b_width=pb,
                latency=op.latency,
                inner_params=_inner_instance_params(op),   # chains need CHAIN_BLOCKS passed
            ))
        elif isinstance(op, IR.LutMult):
            pa, pb = _inner_widths(op)
            requests.append(BlockRequest(
                kind="lut_mult",
                key=op.generator_key,
                module_name=resolve("lut_mult", op.generator_key, op),
                instance_name=f"u_{op.result.name}",
                result=op.result,
                operands=(op.a, op.b),
                inner_module_name=_default_inner_module_name(op, pa, pb),
                inner_a_width=pa,
                inner_b_width=pb,
                latency=op.latency,
                inner_params=_inner_instance_params(op),
                inner_signed=not _is_small_mult(op),
            ))
        elif isinstance(op, IR.BitHeap):
            requests.append(BlockRequest(
                kind="bitheap",
                key="terminal_bitheap",
                module_name=resolve("bitheap", "terminal_bitheap", op),
                instance_name=f"u_{op.result.name}",
                result=op.result,
                operands=tuple(t.signal for t in op.terms),
                terms=op.terms,
                inner_module_name=_default_bitheap_inner_name(op),
                latency=op.latency,
                sign_mode=op.sign_mode,
            ))
        elif isinstance(op, IR.Sub):
            pa, pb = _inner_widths(op)
            requests.append(BlockRequest(
                kind="sub",
                key="sub",
                module_name=resolve("sub", "sub", op),
                instance_name=f"u_{op.result.name}",
                result=op.result,
                operands=(op.minuend, op.subtrahend),
                inner_module_name=_default_inner_module_name(op, pa, pb),
                inner_a_width=pa,
                inner_b_width=pb,
                latency=op.latency,
            ))

    return tuple(requests)


def _sv_type(sig: IR.Signal) -> str:
    signed = " signed" if sig.signed else ""
    return f"logic{signed} [{sig.width - 1}:0]"


def _result_cast(expr: str, result: IR.Signal) -> str:
    """Cast a wrapper result according to the signedness of its output port."""
    cast = "$signed" if result.signed else "$unsigned"
    return f"{cast}({expr})"


# ---- shape/port-naming helpers shared with rtl/wrappers.py, rtl/inner_backends.py, rtl/project.py ----

def _bitheap_columns(r: BlockRequest) -> list[list[IR.ColumnBit]]:
    """Expand into columns, width = heap_width = the product word's bit width."""
    return IR.lower_bitheap(r.terms, r.result.width, r.sign_mode)


def _cmp_out_width(cols: list[list[IR.ColumnBit]]) -> int:
    """The compressor tree's output width. Same formula as width_bh in
       compressor.py: sum_max = sum of column height x 2^column, then bit_length."""
    total = sum(len(bits) << c for c, bits in enumerate(cols))
    return max(1, total.bit_length())


def _bitheap_max_height(r: BlockRequest) -> int:
    """How many bits the tallest column has. The sole criterion for
    "does this need a compressor tree"."""
    return max((len(bits) for bits in _bitheap_columns(r)), default=0)


def _bitheap_is_plain_add(r: BlockRequest) -> bool:
    """A heap with column height <= 2 has nothing left to compress:
    compressAll returns 0 counter layers, so terminalAdd_gen falls into
    the tail_end branch that was never assigned, generating illegal
    slices like comp_out[0:2] / chain2_out[-2:0], which Vivado rejects
    outright.

    And this kind of heap is really just ordinary multi-operand addition/
    subtraction to begin with -- it never needed a GPC compressor tree."""
    return _bitheap_max_height(r) <= 2


def _term_port_of(r: BlockRequest) -> dict[str, str]:
    """signal name -> wrapper port name; the same signal only ever gets one
       port. Port numbers use len(mapping) rather than the term's index, so
       numbering stays contiguous 0..N-1 (K3's term indices are
       0,1,3,4,7,8, with gaps)."""
    mapping: dict[str, str] = {}
    for t in r.terms:
        if t.signal.name not in mapping:
            mapping[t.signal.name] = f"term{len(mapping)}"
    return mapping


def _distinct_term_ports(r: BlockRequest) -> list[tuple[str, IR.Signal]]:
    """[(port name, signal), ...], in first-seen order. Used both when the
       wrapper declares its ports and when the top level wires them up, so
       the two stay consistent."""
    port_of = _term_port_of(r)
    seen: dict[str, IR.Signal] = {}
    for t in r.terms:
        seen.setdefault(t.signal.name, t.signal)
    return [(port_of[name], sig) for name, sig in seen.items()]


def _emit_instance(request: BlockRequest) -> list[str]:
    """Instantiate one BlockRequest's wrapper module at the top level."""
    ports = ["        .clk   (clk)"]
    if request.kind == "dsp":
        ports.append("        .reset (reset)")

    if request.kind in ("dsp", "lut_mult", "sub"):
        a, b = request.operands
        # IR operands are in board order.  A transposed physical tile expects
        # its canonical operand order, so swap only at this interface.
        if request.kind in ("dsp", "lut_mult", "sub"):
            a, b = request.operands       # board order; transposition is handled inside the wrapper
            ports.extend([
                f"        .A     ({a.name})",
                f"        .B     ({b.name})",
                f"        .P     ({request.result.name})",
            ])
    else:
        for pname, sig in _distinct_term_ports(request):
            ports.append(f"        .{pname} ({sig.name})")
        ports.append(f"        .P     ({request.result.name})")

    lines = [f"    {_kh()}{request.module_name} {request.instance_name} ("]
    lines.append(",\n".join(ports))
    lines.append("    );")
    return lines


def _emit_delay_instance(op: IR.Delay) -> list[str]:
    """Instantiate a delay_line: pipe `source` through `cycles` cycles to `result`."""
    return [
        f"    {_kh()}delay_line #(",
        f"        .WIDTH  ({op.source.width}),",
        f"        .CYCLES ({op.cycles})",
        f"    ) u_{op.result.name} (",
        f"        .clk (clk),",
        f"        .d   ({op.source.name}),",
        f"        .q   ({op.result.name})",
        f"    );",
    ]


def emit_systemverilog(
    module: IR.IRModule,
    module_name_resolver: ModuleNameResolver | None = None,
) -> RTLInterface:
    """Emit the phase-2 top-level interface for an IR module.

    External block convention:
      * DSP multiplier: ``clk, reset, A, B, P``;
      * LUT multiplier: ``clk, A, B, P``;
      * bit heap: ``clk, term0..termN, P``.

    For a bit heap, weights, negation and signedness live in the accompanying
    :class:`BlockRequest`; phase 3 must generate the matching implementation.
    """
    IR.verify(module)
    requests = collect_block_requests(module, module_name_resolver)
    request_by_result = {r.result.name: r for r in requests}

    ports = [
        "    input  logic clk",
        "    input  logic reset",
    ]
    input_ops = [op for op in module.ops if isinstance(op, IR.Input)]
    for op in input_ops:
        ports.append(f"    input  {_sv_type(op.result)} {op.port_name}")
    ports.append(f"    output {_sv_type(module.output)} P")

    lines = [
        "`timescale 1ns / 1ps",
        "",
        f"module {_identifier(module.name)} (",
        ",\n".join(ports),
        ");",
        "",
    ]

    for sig in module.signals():
        lines.append(f"    {_sv_type(sig)} {sig.name};")
    lines.append("")

    for op in module.ops:
        if isinstance(op, IR.Input):
            lines.append(f"    assign {op.result.name} = {op.port_name};")
        elif isinstance(op, IR.Slice):
            hi = op.lo + op.result.width - 1
            lines.append(
                f"    assign {op.result.name} = {op.source.name}[{hi}:{op.lo}];"
            )
        elif isinstance(op, IR.Sub):
            lines.extend(_emit_instance(request_by_result[op.result.name]))
        elif isinstance(op, (IR.DspTile, IR.LutMult, IR.BitHeap)):
            lines.extend(_emit_instance(request_by_result[op.result.name]))
        elif isinstance(op, IR.Delay):
            lines.extend(_emit_delay_instance(op))
        else:
            raise TypeError(f"unsupported IR op {type(op).__name__}")
        lines.append("")

    lines.extend([
        f"    assign P = {module.output.name};",
        "",
        "endmodule",
        "",
    ])
    return RTLInterface(
        module=module,
        systemverilog="\n".join(lines),
        blocks=requests,
    )
