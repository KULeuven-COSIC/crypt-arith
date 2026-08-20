# rtl/emit_tb.py
"""Generate a Vivado testbench for an (already-aligned) IRModule.

Includes a pure-Python IR interpreter (evaluate()) that the testbench
generator uses as an independent cross-check: the golden expected value is
computed directly from the top-level inputs' signed/unsigned
multiplication, and evaluate() is only used to double-check it at
generation time, so a bug in IR lowering can't also sneak the same wrong
golden value into the testbench.
"""
from __future__ import annotations
import random
from dsp_multiplier.backend.schedule import module_latency
import dsp_multiplier.backend.ir as IR

# =============================================================================
# Pure-Python IR interpreter
#
# Semantics must match the hardware RTLInterface generates, bit for bit --
# in particular, BitHeap follows lower_bitheap's two's-complement/sign-
# extension convention (unsigned sum mod 2^width = the true value).
# =============================================================================


def _mask(width: int) -> int:
    return (1 << width) - 1


def _as_unsigned(value: int, width: int) -> int:
    """Truncate an integer to a non-negative width-bit two's-complement pattern."""
    return value & _mask(width)


def _as_signed(value: int, width: int) -> int:
    """Interpret a width-bit two's-complement pattern as a signed integer."""
    v = value & _mask(width)
    if v >> (width - 1):
        v -= (1 << width)
    return v


def evaluate(module: IR.IRModule, inputs: dict[str, int]) -> dict[str, int]:
    """Returns {signal name: signed integer value}. `inputs` is keyed by port name (port_name).

    Every signal stores its "mathematically true value" (a signed int);
    bit-pattern semantics are handled within each op.
    """
    val: dict[str, int] = {}

    def get(sig: IR.Signal) -> int:
        return val[sig.name]

    for op in module.ops:
        if isinstance(op, IR.Input):
            raw = inputs[op.port_name]
            # normalize to the true value per the port's declared width/sign
            val[op.result.name] = (
                _as_signed(raw, op.result.width) if op.result.signed
                else _as_unsigned(raw, op.result.width)
            )

        elif isinstance(op, IR.Slice):
            src = get(op.source)
            bits = (_as_unsigned(src, op.source.width) >> op.lo) & _mask(op.result.width)
            val[op.result.name] = (
                _as_signed(bits, op.result.width) if op.result.signed
                else bits
            )

        elif isinstance(op, IR.Sub):
            val[op.result.name] = get(op.minuend) - get(op.subtrahend)

        elif isinstance(op, (IR.DspTile, IR.LutMult)):
            val[op.result.name] = get(op.a) * get(op.b)

        elif isinstance(op, IR.Delay):
            val[op.result.name] = get(op.source)      # a delay doesn't change the value

        elif isinstance(op, IR.BitHeap):
            total = 0
            for t in op.terms:
                term_val = get(t.signal)
                # matches lower_bitheap: each term participates per its own bit pattern, negated terms take two's complement
                if t.negate:
                    term_val = -term_val
                total += term_val << t.weight
            # the heap's output is finished off per the result width's two's-complement semantics
            val[op.result.name] = (
                _as_signed(total, op.result.width) if op.result.signed
                else _as_unsigned(total, op.result.width)
            )

        else:
            raise TypeError(f"evaluate: unknown op {type(op).__name__}")

    return val


def dump_intermediates(module: IR.IRModule, inputs: dict[str, int],
                       path: str) -> dict[str, int]:
    """Compute every signal's value and write it to a file; decimal values
    are interpreted per each signal's own `signed` attribute."""
    val = evaluate(module, inputs)

    def format_value(sig: IR.Signal) -> str:
        bits = _as_unsigned(val[sig.name], sig.width)
        decimal_kind = "signed" if sig.signed else "unsigned"
        decimal_value = _as_signed(bits, sig.width) if sig.signed else bits
        return (
            f"hex=0x{bits:0{(sig.width + 3) // 4}x} "
            f"{decimal_kind}={decimal_value}"
        )

    lines = ["# inputs:"]
    for op in module.ops:
        if not isinstance(op, IR.Input):
            continue
        r = op.result
        lines.append(
            f"#   {op.port_name:<8} ({r.name}) width={r.width:<3} "
            f"{format_value(r)}"
        )
    out = module.output
    lines += [
        f"# output {out.name}: {format_value(out)}",
        "",
    ]
    for op in module.ops:
        r = op.result
        kind = type(op).__name__
        lines.append(
            f"{r.name:<10} {kind:<8} width={r.width:<3} "
            f"{format_value(r)}"
        )
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    return val


# =============================================================================
# Testbench generator
# =============================================================================


def _decode_operand(bits: int, signal: IR.Signal) -> int:
    """Interpret a port's bit pattern as a mathematical integer, without relying on the IR interpreter."""
    bits &= _mask(signal.width)
    if signal.signed and bits & (1 << (signal.width - 1)):
        bits -= 1 << signal.width
    return bits


def _product_oracle(a_bits: int, b_bits: int,
                    a_signal: IR.Signal, b_signal: IR.Signal,
                    output: IR.Signal) -> int:
    """An independent golden value: decode per each port's own sign, multiply directly, truncate to P's width."""
    product = (
        _decode_operand(a_bits, a_signal)
        * _decode_operand(b_bits, b_signal)
    )
    return product & _mask(output.width)


def _boundary_values(signal: IR.Signal) -> list[int]:
    """Signed: covers 0/1/max/min/-1. Unsigned: covers 0/1/max/midpoint/second-largest."""
    mask = _mask(signal.width)
    high_bit = 1 << (signal.width - 1)
    if signal.signed:
        candidates = [0, 1, high_bit - 1, high_bit, mask]
    else:
        candidates = [0, 1, mask, high_bit, mask - 1]

    # width=1 produces duplicate values above; dedup while preserving order.
    return list(dict.fromkeys(value & mask for value in candidates))


def _directed_vectors(a_signal: IR.Signal,
                      b_signal: IR.Signal) -> list[dict[str, int]]:
    """Generate deterministic test vectors that prioritize covering both
    sides' boundaries and their cross-combinations."""
    a_values = _boundary_values(a_signal)
    b_values = _boundary_values(b_signal)
    pairs: list[tuple[int, int]] = []

    # even with a small test_size, prioritize getting 0, 1, positive
    # boundary, negative boundary, and other diagonal combinations.
    for index in range(max(len(a_values), len(b_values))):
        pairs.append((a_values[index % len(a_values)],
                      b_values[index % len(b_values)]))
    for index in range(max(len(a_values), len(b_values))):
        pairs.append((a_values[index % len(a_values)],
                      b_values[-1 - (index % len(b_values))]))

    # then fill in the full cartesian product of every boundary; deduped in order below.
    pairs.extend((a, b) for a in a_values for b in b_values)
    unique_pairs = list(dict.fromkeys(pairs))
    return [{"A": a, "B": b} for a, b in unique_pairs]


def _evaluate_inputs(module: IR.IRModule, a: int, b: int) -> dict[str, int]:
    """Feed values to the interpreter keyed by each Input op's port_name."""
    port_by_signal = {
        op.result.name: op.port_name
        for op in module.ops
        if isinstance(op, IR.Input)
    }
    return {
        port_by_signal[module.inputs[0].name]: a,
        port_by_signal[module.inputs[1].name]: b,
    }


def emit_testbench(module: IR.IRModule, *,
                   test_size: int = 1000,
                   seed: int = 0,
                   dut_name: str | None = None) -> tuple[str, list[dict[str, int]], list[int]]:
    """Returns (tb_sv text, each vector's inputs, each vector's expected output). Only P is compared."""
    if test_size <= 0:
        raise ValueError(f"test_size must be > 0, got {test_size}")

    rng = random.Random(seed)
    dut = dut_name or module.name
    A_port, B_port = module.inputs[0], module.inputs[1]
    out = module.output
    lat = module_latency(module)

    # test_size always means the total vector count: directed boundary values first, then random values to fill up.
    vectors = _directed_vectors(A_port, B_port)[:test_size]
    while len(vectors) < test_size:
        vectors.append({
            "A": rng.getrandbits(A_port.width),
            "B": rng.getrandbits(B_port.width),
        })

    expected: list[int] = []
    for index, vector in enumerate(vectors):
        oracle = _product_oracle(
            vector["A"], vector["B"], A_port, B_port, out,
        )
        interpreted = evaluate(
            module,
            _evaluate_inputs(module, vector["A"], vector["B"]),
        )[out.name] & _mask(out.width)
        if interpreted != oracle:
            raise AssertionError(
                "IR evaluation disagrees with direct multiplication oracle "
                f"at vector {index}: A=0x{vector['A']:x}, "
                f"B=0x{vector['B']:x}, evaluate=0x{interpreted:x}, "
                f"oracle=0x{oracle:x}"
            )
        expected.append(oracle)

    def sv_type(sig):
        s = " signed" if sig.signed else ""
        return f"logic{s} [{sig.width-1}:0]"

    # flatten stimulus and expected values into initial-block assignments
    # (kept simple: inlined directly, no reading from an external file)
    lines = [
        "`timescale 1ns / 1ps",
        f"module {dut}_tb;",
        "  logic clk = 0;",
        "  always #5 clk = ~clk;",
        f"  {sv_type(A_port)} A;",
        f"  {sv_type(B_port)} B;",
        f"  {sv_type(out)} P;",
        "  logic reset = 0;",
        "",
        f"  {dut} dut (.clk(clk), .reset(reset), .A(A), .B(B), .P(P));",
        "",
        f"  localparam int LAT = {lat};",
        f"  localparam int N   = {test_size};",
        f"  logic [{A_port.width-1}:0] A_ts [0:N-1];",
        f"  logic [{B_port.width-1}:0] B_ts [0:N-1];",
        f"  logic [{out.width-1}:0]    P_ts [0:N-1];",
        "",
        "  initial begin",
    ]
    for i, (vec, exp) in enumerate(zip(vectors, expected)):
        lines.append(f"    A_ts[{i}] = {A_port.width}'h{vec['A']:x}; "
                     f"B_ts[{i}] = {B_port.width}'h{vec['B']:x}; "
                     f"P_ts[{i}] = {out.width}'h{exp:x};")
    lines += [
        "  end",
        "",
        "  int correct = 0;",
        "",
        "  // ---- driver: local loop var + non-blocking drive ----",
        "  initial begin",
        "    reset = 1; A <= '0; B <= '0;",
        "    #200; reset = 0;",
        "    for (int di = 0; di < N; di++) begin",
        "      A <= A_ts[di];",
        "      B <= B_ts[di];",
        "      @(posedge clk);",
        "    end",
        "  end",
        "",
        "  // ---- checker: wait LAT cycles after reset releases, sample #1 after each edge ----",
        "  initial begin",
        "    @(negedge reset);",
        "    repeat (LAT) @(posedge clk);",
        "    #1;",
        "    for (int ci = 0; ci < N; ci++) begin",
        "      if (P === P_ts[ci]) correct = correct + 1;",
        "      else $display(\"WRONG[%0d] got=%h exp=%h\", ci, P, P_ts[ci]);",
        "      @(posedge clk); #1;",
        "    end",
        "    if (correct == N) $display(\"PASS all %0d\", N);",
        "    else $display(\"FAIL %0d/%0d\", N - correct, N);",
        "    $finish;",
        "  end",
        "endmodule",
        "",
    ]
    return "\n".join(lines), vectors, expected


def write_testbench(module: IR.IRModule, tb_path: str, *,
                    test_size: int = 1000, seed: int = 0,
                    dump_intermediates_path: str | None = None) -> None:
    """Write the TB file. When dump_intermediates_path is not None, also
       dump every signal's value for one representative vector."""
    tb_sv, vectors, _ = emit_testbench(module, test_size=test_size, seed=seed)
    with open(tb_path, "w", encoding="utf-8") as f:
        f.write(tb_sv)

    if dump_intermediates_path is not None:
        # Prefer vector 25 for continuity with the original diagnostic, but
        # remain valid when the caller requests a smaller test set.
        dump_intermediates(
            module,
            vectors[min(25, len(vectors) - 1)],
            dump_intermediates_path,
        )
