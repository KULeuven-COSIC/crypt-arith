"""Top-level project writer: lays the whole design out as a directory tree
(top / wrapper / inner / gpc / xdc, each its own file), with dedup/caching
across repeated block requests.
"""
from __future__ import annotations

from pathlib import Path

import dsp_multiplier.backend.ir as IR
from rtl_gen.dsp_multiplier.interface import (
    RTLInterface,
    EmittedRTL,
    _identifier,
    _bitheap_columns,
    _bitheap_is_plain_add,
)
from rtl_gen.dsp_multiplier.wrappers import (
    _emit_bitheap_wrapper,
    _emit_sub_wrapper,
    _emit_mult_wrapper,
)
from rtl_gen.dsp_multiplier.inner_backends import (
    _write_sv,
    _sub_signed_module,
    _small_mult_module,
    _delay_line_module,
    _write_dsp_inner,
    _write_bmult_inner,
    _write_bitheap_inner,
    _copy_gpc_primitives,
)


def _inner_generation_key(r) -> tuple[object, ...]:
    """Settings that must agree when requests reuse an inner module name."""
    if r.kind == "bitheap":
        heights = tuple(len(bits) for bits in _bitheap_columns(r))
        return (r.kind, heights, r.latency)
    if r.inner_params:
        # a parameterized module (DSPChain): one .sv serves every chain
        # length, width/latency come from the instantiation parameters,
        # so they don't factor into the key -- otherwise every chain
        # would want its own file rewritten.
        return (r.kind, r.inner_module_name)
    return (
        r.kind,
        r.inner_a_width,
        r.inner_b_width,
        r.latency,
    )


def _wrapper_generation_key(r) -> tuple[object, ...]:
    """Structural signature used to reject unsafe wrapper-name reuse."""
    result_type = (r.result.width, r.result.signed)
    if r.kind == "bitheap":
        aliases: dict[str, int] = {}
        term_shape: list[tuple[object, ...]] = []
        for term in r.terms:
            alias = aliases.setdefault(term.signal.name, len(aliases))
            term_shape.append(
                (
                    alias,
                    term.signal.width,
                    term.signal.signed,
                    term.weight,
                    term.negate,
                )
            )
        return (
            r.kind,
            result_type,
            tuple(term_shape),
            r.inner_module_name,
            r.sign_mode,
        )
    operand_types = tuple((operand.width, operand.signed) for operand in r.operands)
    if r.kind == "sub":
        return (
            r.kind,
            result_type,
            operand_types,
            r.latency,              # LATENCY is now written into the wrapper body, so it must be part of the key
            r.inner_module_name,
        )

    return (
        r.kind,
        result_type,
        operand_types,
        r.orientation,
        r.inner_module_name,
        r.inner_params,          # a different LATENCY/OUT_REG for the single family = a different wrapper
                                  # (chain/k2/k3/t25 take no parameters, distinguished by inner_module_name itself)
    )


def write_rtl_project(
    interface: RTLInterface,
    outdir: str | Path,
    *,
    include_sub_inner: bool = True,
    include_dsp_inner: bool = True,
    include_lut_inner: bool = True,
    include_bitheap_inner: bool = True,
    include_gpc_primitives: bool = False,
) -> EmittedRTL:
    """Lay the whole design out as a directory: top level / wrapper / inner
    / gpc / xdc, each its own file(s).

    include_dsp_inner defaults to True -- DSP inner blocks are now
    genuinely generated: the single family copies the hand-written
    parameterized template (latency_model/rtl/SingleDSP.sv), chain/k2/k3/t25
    each get a fresh circuit built specifically for that (family, blocks,
    latency) combination (_write_dsp_inner). Pass False if you want to
    hand-write or plug in an existing implementation instead.
    """
    out = Path(outdir).resolve()
    sv_wrap, sv_inner = out / "wrappers", out / "inner"
    sv_gpc, out_xdc = out / "gpc", out / "xdc"

    top_name = _identifier(interface.module.name)
    out.mkdir(parents=True, exist_ok=True)
    top_path = out / f"{top_name}.sv"
    top_path.write_text(interface.systemverilog, encoding="utf-8")

    inners: list[Path] = []
    if any(isinstance(op, IR.Delay) for op in interface.module.ops):
        dl = _write_sv(sv_inner / "delay_line.sv", _delay_line_module())
        inners.append(dl)
    if include_sub_inner and any(r.kind == "sub" for r in interface.blocks):
        inners.append(
            _write_sv(sv_inner / "sub_signed.sv", _sub_signed_module())
        )
    if include_lut_inner and any(
        r.kind == "lut_mult" and r.inner_module_name == "SmallMult"
        for r in interface.blocks
    ):
        inners.append(
            _write_sv(sv_inner / "SmallMult.sv", _small_mult_module())
        )

    wrapper_keys: dict[str, tuple[object, ...]] = {}
    inner_keys: dict[str, tuple[object, ...]] = {}
    wrappers: list[Path] = []
    xdcs: list[Path] = []
    uses_gpc = False

    for r in interface.blocks:
        # -- wrapper: one file per module_name --
        wkey = _wrapper_generation_key(r)
        prev = wrapper_keys.get(r.module_name)
        if prev is None:
            wrapper_keys[r.module_name] = wkey
            if r.kind == "bitheap":
                body = _emit_bitheap_wrapper(r)
            elif r.kind == "sub":
                body = _emit_sub_wrapper(r)
            else:
                body = _emit_mult_wrapper(r)
            wrappers.append(_write_sv(sv_wrap / f"{r.module_name}.sv", body))
        elif prev != wkey:
            raise ValueError(
                f"wrapper module {r.module_name} is reused with "
                "incompatible interface settings"
            )

        # -- inner: generated once per inner_module_name --
        if r.kind == "dsp" and not include_dsp_inner:
            continue

        if r.kind == "lut_mult" and r.inner_module_name == "SmallMult":
            continue        # parameterized module, already written once outside the loop
        if r.kind == "lut_mult" and not include_lut_inner:
            continue

        if r.kind == "bitheap" and not include_bitheap_inner:
            continue
        if r.kind == "bitheap" and _bitheap_is_plain_add(r):
            continue

        if r.kind == "sub":
            continue

        ikey = _inner_generation_key(r)
        prev_i = inner_keys.get(r.inner_module_name)
        if prev_i is not None:
            if prev_i != ikey:
                raise ValueError(
                    f"inner module {r.inner_module_name} is reused with "
                    "incompatible generation settings"
                )
            continue
        inner_keys[r.inner_module_name] = ikey

        if r.kind == "dsp":
            sv, xdc = _write_dsp_inner(r, sv_inner, out_xdc)
            inners.extend(sv)
            xdcs.extend(xdc)
        elif r.kind == "lut_mult":
            sv, xdc, used = _write_bmult_inner(r, sv_inner, out_xdc)
            inners.extend(sv)
            xdcs.extend(xdc)
            uses_gpc = uses_gpc or used
        else:
            sv, xdc = _write_bitheap_inner(r, sv_inner, out_xdc)
            inners.extend(sv)
            xdcs.extend(xdc)
            uses_gpc = True

    gpc: list[Path] = []
    if uses_gpc and include_gpc_primitives:
        gpc = _copy_gpc_primitives(sv_gpc)

    emitted = EmittedRTL(
        top=top_path,
        wrappers=tuple(wrappers),
        inners=tuple(dict.fromkeys(inners)),      # dedup, keep order
        gpc=tuple(gpc),
        xdc=tuple(xdcs),
    )

    # a file list for Vivado / verilator
    (out / "filelist.f").write_text(
        "\n".join(str(p.relative_to(out)) for p in emitted.sv_files) + "\n",
        encoding="utf-8",
    )
    return emitted
