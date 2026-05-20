"""NAF decomposition and bitheap construction for constant multiplication.

Decomposes an integer constant into signed powers of 2 (Non-Adjacent Form),
then builds a bitheap descriptor for hardware implementation using only
shifts, adds, and subtracts — no DSP multipliers needed.
"""

from __future__ import annotations

from heapq import nsmallest


def naf_terms(n: int) -> list[tuple[int, int]]:
    """Non-Adjacent Form: represent n as sum of signed powers of 2.

    Returns list of (sign, k) where n = sum(sign * 2^k) and sign in {-1, +1}.
    Minimal number of non-zero terms.
    """
    if n == 0:
        return []
    sign0 = 1
    if n < 0:
        sign0 = -1
        n = -n

    terms = []
    k = 0
    while n > 0:
        if n & 1:
            u = 2 - (n & 3)
            terms.append((sign0 * u, k))
            n = (n - u) >> 1
        else:
            n >>= 1
        k += 1

    return terms


def format_signed_powers(n: int) -> list[tuple[int, int]]:
    """Convert integer to list of (sign, power) tuples via NAF.

    Each tuple is (sign, power) where sign is +1 or -1.
    E.g., 3 = 2^2 - 2^0 → [(1, 2), (-1, 0)]
    """
    terms = naf_terms(n)
    if not terms:
        return []
    terms.sort(key=lambda x: x[1], reverse=True)
    return terms


def naf_weight_and_maxpow(x: int) -> tuple[int, int]:
    """Return (number of NAF terms, max power) for integer x."""
    t = naf_terms(x)
    w = len(t)
    maxpow = max((k for _, k in t), default=0)
    return w, maxpow


def reduce_mod_q_min_powers_lift(
    n: int,
    q: int,
    max_pow: int = 96,
    max_shift: int = 32,
    depth: int = 3,
    beam: int = 200,
) -> tuple[int, list[int], int, int]:
    """Find an equivalent of n mod q with minimal NAF term count.

    Uses beam search over n ± q*2^t shifts, keeping exponents <= max_pow.

    Returns (best_value, signed_powers, weight, max_exponent).
    """
    r = n % q
    start = [r, r - q]

    def score(x: int):
        w, mp = naf_weight_and_maxpow(x)
        if mp > max_pow:
            return (10**9, 10**9, 10**9)
        return (w, abs(x), mp)

    frontier = list(set(start))
    best = min(frontier, key=score)

    for _ in range(depth):
        cand = []
        for x in frontier:
            cand.append(x)
            for t in range(max_shift + 1):
                step = q << t
                cand.append(x + step)
                cand.append(x - step)
        cand = list(set(cand))
        frontier = nsmallest(beam, cand, key=score)
        b2 = min(frontier, key=score)
        if score(b2) < score(best):
            best = b2

    w, mp = naf_weight_and_maxpow(best)
    return best, format_signed_powers(best), w, mp  # returns list of (sign, power) tuples


def build_const_mult_bitheap(
    powers: list[tuple[int, int]],
    input_name: str,
    input_width: int,
    signed_input: bool = False,
) -> tuple[list, list]:
    """Build a bitheap descriptor for constant multiplication.

    Returns two lists:
    1. compressor_desc: bitheap descriptor with col{idx} signal names
       (for compressor port generation)
    2. assign_desc: bitheap descriptor with actual source info
       (input_name, bit_index, neg, cnst) for wrapper assign statements

    Parameters
    ----------
    powers : list[tuple[int, int]]
        List of (sign, power) tuples where sign is +1 or -1.
    input_name : str
        Name of the input signal in Verilog (e.g., "A").
    input_width : int
        Bit-width of the input.
    signed_input : bool
        If True, A is signed (two's complement). Uses the sign extension
        trick: replace sign-bit copies with ~A[W-1] + constant corrections.

    Returns
    -------
    (compressor_desc, assign_desc)
    """
    # Compute exact output width from the actual constant value and input range
    C = sum(sign * (1 << power) for sign, power in powers)
    if not signed_input:
        a_min, a_max = 0, (1 << input_width) - 1
    else:
        a_min = -(1 << (input_width - 1))
        a_max = (1 << (input_width - 1)) - 1
    prod_min = min(a_min * C, a_max * C)
    prod_max = max(a_min * C, a_max * C)
    if prod_min == 0 and prod_max == 0:
        max_bits = 0
    elif prod_min >= 0:
        # Unsigned output
        max_bits = prod_max.bit_length() - 1
    else:
        # Signed output — match the wrapper's IntType-derived port width, which
        # uses `max(|prod|).bit_length() + 1` (one extra bit for the sign). The
        # `+1` is what makes this `bit_length()` here vs. the unsigned branch's
        # `bit_length() - 1`. Without this, signed × single-positive-power
        # constants leave the top column empty and skip the Baugh-Wooley
        # sign-extension correction at `power + input_width` (silent miscompute).
        max_bits = max(abs(prod_min), abs(prod_max)).bit_length()

    # Build raw assignment info per column
    raw = [[] for _ in range(max_bits + 1)]
    sign_ext = 0

    for sign, power in powers:
        neg = (sign < 0)

        if not signed_input:
            # --- Unsigned input (original behavior) ---
            if neg:
                sign_ext += 1 << power
                for i in range(input_width + power, max_bits + 1):
                    sign_ext += 1 << i

            for i in range(input_width):
                raw[power + i].append((input_name, i, neg, False))
        else:
            # --- Signed input (sign extension trick) ---
            msb = input_width - 1  # sign bit index

            if not neg:
                # Positive term: +2^k * A_signed
                # Non-sign bits: A[0..W-2] at columns k..k+W-2 (normal)
                for i in range(msb):
                    raw[power + i].append((input_name, i, False, False))
                # Negated sign bit: ~A[W-1] at column k+W-1
                raw[power + msb].append((input_name, msb, True, False))
                # Constant 1 at column k+W-1 (correction for sign trick)
                sign_ext += 1 << (power + msb)
                # Constant 1s for sign extension above
                for i in range(power + input_width, max_bits + 1):
                    sign_ext += 1 << i
            else:
                # Negative term: -2^k * A_signed
                # Complemented non-sign bits: ~A[0..W-2] at columns k..k+W-2
                for i in range(msb):
                    raw[power + i].append((input_name, i, True, False))
                # Sign bit NOT negated (double negation cancels): A[W-1]
                raw[power + msb].append((input_name, msb, False, False))
                # +1 at column k (two's complement of negation)
                sign_ext += 1 << power
                # Constant correction at column k+W-1
                sign_ext += 1 << (power + msb)
                # Constant 1s for sign extension above
                for i in range(power + input_width, max_bits + 1):
                    sign_ext += 1 << i

    sign_ext = sign_ext % (1 << (max_bits + 1))
    sign_ext_bits = bin(sign_ext)[2:].zfill(max_bits + 1)
    for i, bit in enumerate(reversed(sign_ext_bits)):
        if bit == "1":
            raw[i].append((None, None, False, True))

    # Build both descriptors (only non-empty columns)
    compressor_desc = []
    assign_desc = []
    for col_idx in range(max_bits + 1):
        if not raw[col_idx]:
            continue
        n_bits = len(raw[col_idx])
        # Compressor descriptor: col{idx} signal names
        comp_entry = [col_idx]
        for bit_idx in range(n_bits):
            comp_entry.append((f"col{col_idx}", bit_idx if n_bits > 1 else None))
        compressor_desc.append(comp_entry)
        # Assignment descriptor: actual source info
        assign_entry = [col_idx] + raw[col_idx]
        assign_desc.append(assign_entry)

    return compressor_desc, assign_desc

