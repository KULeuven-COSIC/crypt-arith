"""The multiplier's intermediate representation (IR). Deliberately doesn't
depend on any solver-side file -- the walker is responsible for translating
a SolutionNode/LutReportNode into ops here, and the HDL generator then
emits hardware by following the op sequence in an IRModule.

Core concepts:
  Signal        -- a named bit vector, i.e. one subtree's output product
                   word. Each subtree's product has LSB weight=0 in its
                   own local coordinates; where it lands is decided by the
                   parent.
  WeightedTerm  -- (signal, weight, negate): feeds a signal into the bit
                   heap starting at column `weight`, optionally negated
                   (that's how Karatsuba's -P_mid works).
"""
from __future__ import annotations

from dataclasses import dataclass

@dataclass(frozen=True)
class LatencyConfig:
    """Latency for non-tile ops. A DSP tile's latency comes from the tile
    library, not from here."""
    lut: int = 1
    bitheap: int = 1
    sub: int = 1

@dataclass(frozen=True)
class Signal:
    """An SSA handle for a bit vector. `name` is globally unique, assigned
    by IRBuilder."""
    name: str
    width: int
    signed: bool

    def __post_init__(self):
        if self.width <= 0:
            raise ValueError(f"Signal {self.name!r} width must be >0, got {self.width}")

    def __str__(self) -> str:
        tag = "s" if self.signed else "u"
        return f"{self.name}:{self.width}{tag}"


@dataclass(frozen=True)
class WeightedTerm:
    """One term in a bit heap: `signal` participates in the sum starting at
       column `weight`. negate=True means this term is subtracted (the HDL
       generator decides whether that's two's-complement or something
       else)."""
    signal: Signal
    weight: int
    negate: bool = False

    def __post_init__(self):
        if self.weight < 0:
            raise ValueError(f"WeightedTerm weight must be >=0, got {self.weight}")

    def __str__(self) -> str:
        sign = "-" if self.negate else "+"
        return f"{sign}({self.signal}) << {self.weight}"

# ---- IR op nodes: each op defines one result Signal ----

@dataclass(frozen=True)
class Input:
    """One of the circuit's raw input ports (top-level A / B, or any
    externally-fed word)."""
    result: Signal
    port_name: str


@dataclass(frozen=True)
class Slice:
    """result = source[lo : lo+result.width]. Used to cut out A0=A[0:k],
    A1=A[k:], etc."""
    result: Signal
    source: Signal
    lo: int


@dataclass(frozen=True)
class Sub:
    """result = minuend - subtrahend (signed). Karatsuba's dA=A1-A0, dB=B1-B0."""
    result: Signal
    minuend: Signal
    subtrahend: Signal
    latency: int = 1

@dataclass(frozen=True)
class DspTile:
    """An opaque hard-block multiplier: DSP58 / DSPChain / K2 / Toom2.5 / K3.
    The IR only cares that result = a * b; the concrete expansion lives in
    the .sv."""
    result: Signal
    a: Signal
    b: Signal
    backend_key: str
    params: tuple[tuple[str, object], ...]
    impl_id: str
    latency: int              # required
    orientation: str = "ab"

    # -- Overhang padding --
    # The tile logically wants a.width+pad_a bits, but only a.width bits
    # are available at the board edge. The HDL generator pads when wiring
    # up: sign-extend if signed, zero-extend if unsigned (neither changes
    # the value).
    pad_a: int = 0
    pad_b: int = 0

    # -- RTL instantiation info (lifted from SeedTiles' params) --
    rtl_module_name: str = ""   # which .sv to instantiate: SingleDSP / DSPChain / Karatsuba2x2 ...
    chain_blocks: int = 1       # >1 = a PCIN cascade chain, uses DSPChain.sv
    pcin_pitch: int = 0         # fixed right-shift per stage within the chain; always 0 for non-chains

    @property
    def is_chain(self) -> bool:
        """The emitter branches to a different .sv based on this."""
        return self.chain_blocks > 1

    def __post_init__(self):
        if self.pad_a < 0 or self.pad_b < 0:
            raise ValueError(
                f"DspTile {self.result.name}: pad must be >=0, "
                f"got ({self.pad_a}, {self.pad_b})"
            )
        if self.chain_blocks < 1:
            raise ValueError(
                f"DspTile {self.result.name}: chain_blocks must be >=1, "
                f"got {self.chain_blocks}"
            )
        # A chain must carry a pitch, a non-chain must not -- fail early
        # instead of silently mis-wiring the RTL.
        if (self.chain_blocks > 1) != (self.pcin_pitch > 0):
            raise ValueError(
                f"DspTile {self.result.name}: chain_blocks="
                f"{self.chain_blocks} is inconsistent with pcin_pitch={self.pcin_pitch}"
            )


@dataclass(frozen=True)
class LutMult:
    """A LUT multiplier: result = a * b, implemented by your LUT generator.
       a_signed/b_signed are this residual rectangle's actual signs after
       whatever sign edges it's touching."""
    result: Signal
    a: Signal
    b: Signal
    a_signed: bool
    b_signed: bool
    latency: int = 1
    generator_key: str = "lut_bmult"


@dataclass(frozen=True)
class BitHeap:
    """result = sum of terms (aligned addition/compression). ..."""
    result: Signal
    terms: tuple[WeightedTerm, ...]
    latency: int = 1
    # -- Sign-handling route. Must match whichever one ExactCost picked, or
    #    the reported cost numbers won't be trustworthy --
    #   "extend"  route A: sign bit propagated all the way to the top of the heap
    #   "removal" route C: sign bit inverted in place + a single constant row at the end
    # The two routes are mathematically equivalent; they just put the cost
    # in different places. Default is extend = existing behavior.
    sign_mode: str = "extend"

    def __post_init__(self):
        if self.sign_mode not in ("extend", "removal"):
            raise ValueError(
                f"BitHeap {self.result.name}: unknown sign_mode={self.sign_mode!r}"
            )


@dataclass(frozen=True)
class Delay:
    """result = source delayed by `cycles`. A pure alignment register chain;
    never changes the value."""
    result: Signal
    source: Signal
    cycles: int

    def __post_init__(self):
        if self.cycles < 1:
            raise ValueError(f"Delay {self.result.name}: cycles must be >=1, got {self.cycles}")
        if self.result.width != self.source.width or self.result.signed != self.source.signed:
            raise ValueError(f"Delay {self.result.name}: type must match source {self.source}")


from typing import Union

IRNode = Union[Input, Slice, Sub, DspTile, LutMult, BitHeap, Delay]


# ---- The frozen finished product: one complete multiplier's IR ----

@dataclass(frozen=True)
class IRModule:
    """The IR for one complete multiplier.
       inputs  -- top-level input ports (usually two Signals, A and B)
       ops     -- every op, in topological (= construction) order
       output  -- the circuit's single output product word (the root
                  SolutionNode's ProductWord)"""
    name: str
    inputs: tuple[Signal, ...]
    ops: tuple[IRNode, ...]
    output: Signal

    def signals(self) -> tuple[Signal, ...]:
        """Every signal that appears in the module (inputs + each op's
        result), in definition order."""
        seen: dict[str, Signal] = {}
        for s in self.inputs:
            seen[s.name] = s
        for op in self.ops:
            seen[op.result.name] = op.result
        return tuple(seen.values())


# ---- Mutable builder: the walker uses this to assemble IR bottom-up ----

class IRBuilder:
    """Mutable builder the walker uses to assemble IR bottom-up: each
    method allocates a fresh Signal, records the matching op, and returns
    the signal for the caller to wire into further ops. Call finish() once
    the whole module is built to seal it into a frozen IRModule."""
    def __init__(self, latency: LatencyConfig | None = None):
        self.latency = latency or LatencyConfig()   # falls back to the default if not given
        self._counter: dict[str, int] = {}
        self._inputs: list[Signal] = []
        self._ops: list[IRNode] = []
        self._defined: set[str] = set()

    # Allocate a unique prefixed signal name, e.g. dsp0 / sum3.
    def _fresh_name(self, prefix: str) -> str:
        n = self._counter.get(prefix, 0)
        self._counter[prefix] = n + 1
        return f"{prefix}{n}"

    def _new_signal(self, prefix: str, width: int, signed: bool) -> Signal:
        sig = Signal(self._fresh_name(prefix), width, signed)
        self._defined.add(sig.name)
        return sig

    # -- Each method creates a new signal + records one op, and returns the new signal --
    def input(self, port_name: str, width: int, signed: bool) -> Signal:
        sig = self._new_signal("in", width, signed)
        self._inputs.append(sig)
        self._ops.append(Input(result=sig, port_name=port_name))
        return sig

    def slice(self, source: Signal, lo: int, width: int, signed: bool) -> Signal:
        if lo < 0 or lo + width > source.width:
            raise ValueError(
                f"slice [{lo}:{lo+width}] out of range for {source}"
            )
        sig = self._new_signal("sl", width, signed)
        self._ops.append(Slice(result=sig, source=source, lo=lo))
        return sig

    def sub(self, minuend: Signal, subtrahend: Signal, width: int,
            latency: int | None = None) -> Signal:
        sig = self._new_signal("sub", width, signed=True)   # a difference is always signed
        self._ops.append(Sub(
            result=sig, minuend=minuend, subtrahend=subtrahend,
            latency=self.latency.sub if latency is None else latency,
        ))
        return sig

    def dsp(self, a: Signal, b: Signal, *, width: int, signed: bool,
            backend_key: str, params: tuple[tuple[str, object], ...],
            impl_id: str, orientation: str = "ab",
            latency: int,
            pad_a: int = 0, pad_b: int = 0,
            rtl_module_name: str = "", chain_blocks: int = 1,
            pcin_pitch: int = 0) -> Signal:
        sig = self._new_signal("dsp", width, signed)
        self._ops.append(DspTile(
            result=sig, a=a, b=b, backend_key=backend_key,
            params=params, impl_id=impl_id, orientation=orientation,
            latency=latency,
            pad_a=pad_a, pad_b=pad_b,
            rtl_module_name=rtl_module_name,
            chain_blocks=chain_blocks, pcin_pitch=pcin_pitch,
        ))
        return sig

    def lut_mult(self, a: Signal, b: Signal, *, width: int, signed: bool,
                 a_signed: bool, b_signed: bool,
                 generator_key: str = "lut_bmult",
                 latency: int | None = None) -> Signal:
        sig = self._new_signal("lut", width, signed)
        self._ops.append(LutMult(
            result=sig, a=a, b=b, a_signed=a_signed, b_signed=b_signed,
            generator_key=generator_key,
            latency=self.latency.lut if latency is None else latency,
        ))
        return sig

    def bitheap(self, terms: tuple[WeightedTerm, ...], *,
                width: int, signed: bool,
                latency: int | None = None,
                sign_mode: str = "extend") -> Signal:
        sig = self._new_signal("sum", width, signed)
        self._ops.append(BitHeap(
            result=sig, terms=tuple(terms),
            latency=self.latency.bitheap if latency is None else latency,
            sign_mode=sign_mode,
        ))
        return sig

    # -- Seal: produce a frozen IRModule --
    def finish(self, name: str, output: Signal) -> IRModule:
        return IRModule(
            name=name,
            inputs=tuple(self._inputs),
            ops=tuple(self._ops),
            output=output,
        )

# ---- Bit heap accumulator: drop in weighted terms, then seal into one BitHeap ----
class TermAccumulator:
    """Collects WeightedTerms, then hands them to builder.bitheap to merge
       into one product word.
       Typical use:
           acc = TermAccumulator()
           acc.add(dsp_sig, weight=a0+b0)
           acc.add(lut_sig, weight=r.a0+r.b0)
           out = acc.seal(builder, width=..., signed=...)
    """
    def __init__(self):
        self._terms: list[WeightedTerm] = []

    def add(self, signal: Signal, weight: int, *, negate: bool = False) -> None:
        self._terms.append(WeightedTerm(signal=signal, weight=weight, negate=negate))

    def is_empty(self) -> bool:
        return not self._terms

    def seal(self, builder: IRBuilder, *, width: int, signed: bool,
             latency: int | None = None,
             sign_mode: str = "extend") -> Signal:
        if not self._terms:
            raise ValueError("TermAccumulator is empty; nothing to seal")

        # -- Single-term heap: adding nothing shouldn't still cost 1 cycle
        # plus a pile of alignment FFs, so short-circuit it. --
        # Under the current Walker, a single term only shows up when "the
        # leaf is exactly one tile covering the whole sub-board", in which
        # case all four conditions below must hold. If any one fails, the
        # tile library's declared product doesn't match the sub-board --
        # a real bug (the RTL width would silently be wrong) -- so this
        # raises instead of degrading into building a heap.
        if len(self._terms) == 1:
            t = self._terms[0]
            bad = []
            if t.weight != 0:
                bad.append(f"weight={t.weight} (should be 0)")
            if t.negate:
                bad.append("negate=True (should be False)")
            if t.signal.width != width:
                bad.append(f"width={t.signal.width} (should be {width})")
            if t.signal.signed != signed:
                bad.append(f"signed={t.signal.signed} (should be {signed})")
            if bad:
                raise ValueError(
                    f"Cannot short-circuit single-term heap: {t.signal.name} " + ", ".join(bad)
                    + ".\n  Common causes: an off-board tile's output_term wasn't "
                      "clipped to match, or the tile's sign variant doesn't match the sub-board."
                )
            return t.signal          # this signal IS the answer

        return builder.bitheap(tuple(self._terms), width=width,
                               signed=signed, latency=latency,
                               sign_mode=sign_mode)
# ---- Verification + printing ----

def verify(module: IRModule) -> None:
    """Structural self-check: topologically correct, no undefined signals,
    no duplicate result names, slices/weights in range."""
    defined: set[str] = set()

    def require(sig: Signal, where: str) -> None:
        if sig.name not in defined:
            raise ValueError(f"{where}: uses undefined signal {sig}")

    for s in module.inputs:
        if s.name in defined:
            raise ValueError(f"duplicate input signal {s}")
        defined.add(s.name)

    for op in module.ops:
        r = op.result
        if isinstance(op, Input):
            pass  # result is already registered via inputs
        elif isinstance(op, Slice):
            require(op.source, f"Slice->{r.name}")
            if op.lo < 0 or op.lo + r.width > op.source.width:
                raise ValueError(f"Slice {r.name}: out of range")
        elif isinstance(op, Sub):
            require(op.minuend, f"Sub->{r.name}")
            require(op.subtrahend, f"Sub->{r.name}")
        elif isinstance(op, (DspTile, LutMult)):
            require(op.a, f"{type(op).__name__}->{r.name}")
            require(op.b, f"{type(op).__name__}->{r.name}")
        elif isinstance(op, BitHeap):
            if not op.terms:
                raise ValueError(f"BitHeap {r.name}: empty")
            for t in op.terms:
                require(t.signal, f"BitHeap->{r.name}")
        elif isinstance(op, Delay):
            pass
        else:
            raise TypeError(f"unknown op {type(op).__name__}")

        if not isinstance(op, Input):
            if r.name in defined:
                raise ValueError(f"duplicate result signal {r}")
            defined.add(r.name)

    require(module.output, "module.output")


def dump(module: IRModule) -> str:
    """Render the IR as readable text."""
    lines = [f"module {module.name}  (output = {module.output})"]
    lines.append("  inputs: " + ", ".join(str(s) for s in module.inputs))
    for op in module.ops:
        if isinstance(op, Input):
            lines.append(f"  {op.result} = input {op.port_name!r}")
        elif isinstance(op, Slice):
            lines.append(f"  {op.result} = {op.source}[{op.lo}:{op.lo+op.result.width}]")
        elif isinstance(op, Sub):
            lines.append(f"  {op.result} = {op.minuend} - {op.subtrahend} lat={op.latency}")
        elif isinstance(op, DspTile):
            # Skip the annotation when there's no overhang and it's not a
            # chain, to avoid cluttering the output.
            pad = (f" pad=({op.pad_a},{op.pad_b})"
                   if (op.pad_a or op.pad_b) else "")
            chain = (f" chain x{op.chain_blocks} pitch={op.pcin_pitch}"
                     if op.is_chain else "")
            mod = op.rtl_module_name or "DSP"
            lines.append(f"  {op.result} = {mod}({op.a}, {op.b}) "
                         f"[{op.orientation}]{chain}{pad} lat={op.latency}")
        elif isinstance(op, LutMult):
            lines.append(f"  {op.result} = LUT({op.a}, {op.b}) "
                         f"sign={'s' if op.a_signed else 'u'}"
                         f"{'s' if op.b_signed else 'u'} lat={op.latency}")
        elif isinstance(op, BitHeap):
            body = "  ".join(str(t) for t in op.terms)
            lines.append(f"  {op.result} = Σ[ {body} ] lat={op.latency}")
        elif isinstance(op, Delay):
            lines.append(f"  {op.result} = delay({op.source}) x{op.cycles}")
    return "\n".join(lines)


@dataclass(frozen=True)
class ColumnBit:
    signal: Signal | None    # None means a constant bit
    bit: int                 # which bit of `signal`; ignored when constant
    invert: bool = False     # whether to add a ~ when wiring this up
    const: int = 0           # the constant value (0/1) when signal is None

def lower_bitheap(terms, heap_width, sign_mode="extend"):
    """Flatten weighted terms into a per-column bit list, for the GPC
    compression tree.

    sign_mode:
      "extend"  route A: a signed term's sign bit is propagated all the
                way to the top of the heap (the heap gets tall)
      "removal" route C: the sign bit is inverted in place and not
                propagated upward; each signed term instead records one
                correction of -2^(lsb+w-1), and at the end every
                correction is folded into a single constant row pushed
                into the heap.

    The two routes are mathematically equivalent. Column heights here must
    exactly match dsp_multiplier.frontend.exact_cost's deposit_word_extend /
    deposit_word_removal / fold_corrections, or the reported cost won't
    match what synthesis produces -- this implementation mirrors those
    functions deliberately."""
    cols = [[] for _ in range(heap_width)]
    corrections = []                 # exponents of the 2^e terms to subtract

    for t in terms:
        w = t.signal.width
        inv = t.negate               # subtraction = full-width invert + +1 at the LSB column
        # A negated term already needs a full-width invert, which is easy
        # to get wrong when combined with removal's "flip only the sign
        # bit"; the current Walker never produces negate, so it just falls
        # back to extend.
        use_removal = (sign_mode == "removal"
                       and t.signal.signed and not inv)

        if use_removal:
            # Only the top bit gets inverted; nothing at all is propagated above it.
            for i in range(w):
                c = t.weight + i
                if c < heap_width:
                    cols[c].append(
                        ColumnBit(t.signal, i, invert=(i == w - 1))
                    )
            e = t.weight + w - 1                 # the column the sign bit lands in
            if e < heap_width:                   # if it got truncated off, no correction needed
                corrections.append(e)
            continue

        # ---- everything below is the original extend route, unchanged ----
        # raw bits
        for i in range(w):
            c = t.weight + i
            if c < heap_width:
                cols[c].append(ColumnBit(t.signal, i, invert=inv))
        # sign extension: signed propagates the msb; an unsigned subtraction
        # needs the constant-1 fill (the inverted 0) above it
        top = w - 1
        for c in range(t.weight + w, heap_width):
            if t.signal.signed:
                cols[c].append(ColumnBit(t.signal, top, invert=inv))
            elif inv:
                # inverting an unsigned value fills the high bits with 1s,
                # equivalent to a constant-1 fill
                cols[c].append(ColumnBit(None, 0, const=1))
        # two's-complement +1
        if inv:
            cols[t.weight].append(ColumnBit(None, 0, const=1))

    # ---- fold all the -2^e corrections into one heap_width-bit two's
    # complement constant, then push it into the heap ----
    # A plain modulo works because the heap is only this wide anyway --
    # any higher carry is naturally discarded.
    if corrections:
        mask = (1 << heap_width) - 1
        corr = (-sum(1 << e for e in corrections)) & mask
        for c in range(heap_width):
            if (corr >> c) & 1:
                cols[c].append(ColumnBit(None, 0, const=1))

    return cols
