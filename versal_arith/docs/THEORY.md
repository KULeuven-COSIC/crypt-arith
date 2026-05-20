# versal_arith — Theory and Implementation Notes

The compressor-tree synthesis and Booth-multiplier generator implemented here is the open-source companion to:

> Z. Miao, X. Pottier, J. Bertels, W. Legiest, I. Verbauwhede.
> *Area-Efficient LUT-Based Multipliers for AMD Versal FPGAs.*
> IACR ePrint **2026/344**. <https://eprint.iacr.org/2026/344>

This document covers the math and microarchitecture: the Versal LUT and LOOKAHEAD8 changes vs. UltraScale, the GPC catalogue actually used (including the new `(9:4,1)` GPC introduced in this paper), the proposed area-and-delay heuristic for compressor-tree synthesis, the proposed two-layer quaternary terminal adder, and the dual-5-LUT mapping that lets one Versal LUT generate two adjacent radix-4 Booth partial-product bits — yielding the paper's headline ~n²/4 LUT cost for an n-bit multiplication.

The `cmult` constant-multiplier and `cmultbank` (constant-multiplier-bank) operators are user extensions on top of this generator; their math (NAF, modulus lifting, signed-input Baugh-Wooley) is documented in §7 below but is **not** part of the paper.

For "how do I run this" walk-through, see `USAGE.md`. The exact RTL used for every Booth-multiplier and compressor-tree example reported in the paper is checked in under `versal_arith/ARITH2026_Evaluation_Examples/`; see `USAGE.md` §14 for the inventory.

---

## 1. Versal CLB vs. UltraScale: what changed

The Versal CLB (paper §II.A) keeps the high-level structure of UltraScale — LUTs + carry hardware + flip-flops — but the LUT and the carry chain were both re-architected:

**LUT changes (paper Fig. 1).** UltraScale and UltraScale+ run a 6-input LUT in dual 5-LUT mode by sharing all 5 inputs `A1..A5` between the two halves; the second 5-LUT output is on `O5`/`O6` of the same 6-LUT. **Versal LUTs add two configurable cascade muxes** that let one of `A5`, `A6`, or `CASC` drive the fifth input independently for each half — so the two 5-LUTs can have **different fifth inputs**, with the second 5-LUT's output emerging on a new `O5_2` pin instead of `O6`. A new `PROP` output exists exclusively for the LOOKAHEAD8 carry path, and a dedicated **LUT-cascade wire** runs from the `O6` of the lower LUT in a pair into the `CASC` input of the upper LUT (no general-purpose routing required).

**Carry changes (paper Fig. 2).** UltraScale's `CARRY8` is replaced by **`LOOKAHEAD8`**. Inside each two-bit section, the carry XOR/MUX cells that used to live alongside the LUT are removed; instead, propagate signals come from the dedicated 4-input sub-LUT and exit on `PROP`, and carry multiplexing happens inside the LOOKAHEAD8 block under the control of attributes `LOOKB`, `LOOKD`, `LOOKF`, `LOOKH` (one per two-bit section). When all `LOOKx` are FALSE, only the `CYB → COUTB` arc is timing-defined — meaning GPCs that aren't explicitly compatible with the carry-lookahead structure cannot just "fall through" with `LOOKD/F/H = FALSE`; they have to use general-purpose routing for their cascade, which is slower.

These two changes drive nearly every architectural decision in this generator.

---

## 2. Bit heaps

A multi-operand sum

```
S = a₀ + a₁ + … + a_{k-1}
```

is laid out as a **bit heap**: a 2-D structure where column `c` holds every bit of weight `2^c` contributed by any operand. Reducing `S` means compressing every column down to a height that a final adder can resolve.

In `bitheap.py`, each `Column` tracks four sets of bits per round:

| Set | Meaning |
|-----|---------|
| `_all_bits` | every bit currently in the column for this compression round |
| `_locked_bits` | bits already assigned to a counter in this round (input-side) |
| `free_bits` | derived: `_all_bits − _locked_bits`, what's still available |
| `_all_bits_next_round` | output bits queued for the next compression layer |

`advance_round()` carries surviving free bits into the next round (with fresh UIDs so RTL generators can emit `assign next[k] = curr[m];`), then commits the next-round bits as the new current-round and clears the locks.

`Bit` objects (`bit.py`) carry source metadata — Verilog signal name, bit index, a `complemented` flag (for `~A[i]`), and an `is_constant` flag (for `1'b1`). This lets the bit-heap state drive RTL generation directly.

The compression target in this generator is **height ≤ 4** (not the classic Dadda height ≤ 2), because the proposed terminal quaternary adder (§5) is faster than a binary CPA at that depth on Versal fabric.

---

## 3. GPCs on Versal

A **Generalized Parallel Counter** is denoted `(p_{m-1}, …, p_0 : q_{n-1}, …, q_0)`, where `p_i` is the number of input bits of weight `2^i` and `q_j` is the number of output bits of weight `2^j`. When every output column has exactly one bit, the compact form `(p_{m-1}, …, p_0 : n]` is used, with `n` the total output count. So `(1, 5 : 1, 1, 1)` is written `(1, 5 : 3]`.

Two metrics from prior work (paper §II.C):

```
        Σ p_i − Σ q_j               Σ p_i
   E = ───────────────         S = ───────
            #LUTs                   Σ q_j
```

`E` (efficiency, implementation-dependent) measures bit-reduction per LUT. `S` (strength, implementation-independent) is the raw input/output ratio.

### The catalogue (paper Table IV)

| GPC | LUTs | E | S | LOOKAHEAD8 compatible¹ | Row counter² |
|-----|:----:|:----:|:----:|:----:|:----:|
| `(5, 17 : 4, 5, 1)`   | 8 | 1.5  | 2.2   | ✗ | ✗ |
| `(4, 13 : 3, 4, 1)`   | 6 | 1.5  | 2.125 | ✗ | ✗ |
| `(3, 9 : 2, 3, 1)`    | 4 | 1.5  | 2.0   | ✗ (dual-rail exception, see §3.3) | ✓ |
| `(9 : 4, 1)` ★        | 3 | 1.33 | 1.8   | ✗ | ✓ |
| `(6 : 3]`             | 3 | 1.0  | 2.0   | ✗ | ✓ |
| `(2, 2, 3 : 4]`       | 2 | 1.5  | 1.75  | ✗ | ✓ |
| `(3 : 2]`             | 1 | 1.0  | 1.5   | ✓ | ✓ |
| `(1, 5 : 3]`          | 2 | 1.5  | 2.0   | ✓ | ✓ |

¹ "compatible" means the GPC's carry path uses the LOOKAHEAD8 lookahead chain; otherwise it depends on general-purpose routing or the LUT-cascade path.
² eligible to participate in a row counter under the rules in §3.2.

★ `(9 : 4, 1)` is **proposed by this paper** (§IV.B), replacing the earlier `(10 : 4, 2)` because of higher strength, and replacing the depth-`n=4` column counter `(2n+1 : n, 1)` because of higher efficiency. Column counters are dropped entirely from this catalogue: the paper argues they must be depth-limited to satisfy timing on Versal, and within those depth limits the row-counter constructions dominate them. `(2, 5 : 1, 2, 1)` is also dropped because `(1, 5 : 3]` strictly subsumes it.

### 3.1 LUT-level mapping

Every GPC's bit equations are realised by enumerating all 2^k input patterns and emitting the truth table — see `lut_init.py`. Two examples:

**`(6 : 3]`** — three full adders feeding a half adder, then a carry-resolution full adder; the LUT5 outputs are packed onto a single Versal LUT site by sharing the upper inputs:

```
sum_lo = HA_sum(FA_sum(I0,I1,I2), FA_sum(I3,I4,I5))                              # column 0
sum_mid = FA_sum(HA_carry(...), FA_carry(I0,I1,I2), FA_carry(I3,I4,I5))           # column 1
sum_hi = FA_carry(HA_carry(...), FA_carry(I0,I1,I2), FA_carry(I3,I4,I5))          # column 2
```

**`(1, 5 : 3]`** even-position LUT for the 5-bit half:

```
O5 = FA_sum(  FA_sum(I0, I1, I2), I3, I4 )
O6 = FA_carry(FA_sum(I0, I1, I2), I3, I4 )
```

The 1-bit `C1` input enters via the cascade carry, contributing the +1 from the higher-rank input. The fact that `(1, 5 : 3]`'s sum-cascade rides the LUT-cascade path (paper Fig. 3) is what makes it fast on Versal — no general-purpose routing.

For the LOOKAHEAD8-compatible GPCs, one of the output bits is the local lookahead carry-out and one of the inputs absorbs a previous lookahead carry-in. That's what makes a chain of `(3 : 2]` or `(1, 5 : 3]` GPCs as fast as a CLA across the same column range.

### 3.2 Row-counter construction rules (paper §IV.C)

Because LOOKAHEAD8 only defines the `CYB → COUTB` timing arc when `LOOKx = FALSE`, we cannot just chain arbitrary GPCs through a LOOKAHEAD8 by setting `LOOKD/F/H = FALSE`. Specifically:

1. **GPCs that are LOOKAHEAD8-compatible** (`(3 : 2]`, `(1, 5 : 3]`) **may be cascaded freely** in a row counter with no positional restriction.
2. **Incompatible GPCs may only appear at chain boundaries** — at the very *start* of a chain, where propagation can be forced through `LOOKB`; or at the very *end*, where no further carry propagation is required.
3. **When a chain *starts* with an incompatible GPC, its total length is capped at 8 LUTs**, because of CYMUXH behavior — going further can produce incorrect carry outputs.

This is implemented in `heuristic.py` via the `state = [chain_active, position_in_chain]` tracker. Whenever a placement would push `position_in_chain + cost > 8`, the heuristic ends the chain (sets `out_cascade = False` on the last counter and clears all cascade bits), and a fresh chain begins.

`formGPCChain` then groups consecutive counters whose `out_cascade` / `in_cascade` flags align and whose columns abut — `prev.applied_column + len(prev.outputs) - 1 == curr.applied_column` — into a single physical chain. Each chain becomes one LOOKAHEAD8 sequence with one `CIN_LA / COUT_LA` pair.

### 3.3 The `(3, 9 : 2, 3, 1)` exception

`(3, 9 : 2, 3, 1)` is structurally incompatible with the carry-lookahead scheme — but its **dual-rail** structure (paper Fig. 4) gives it an alternative. Two `(2, 5 : 1, 2, 1)`-like sub-counters are stacked vertically with their sum signals rippled along a *parallel physical carry path*. The result: this GPC can still cascade effectively in a row counter, even bypassing the 8-LUT length cap that incompatible chain-starters normally suffer. It is also typically shorter in tree depth than two `(1, 5 : 3]` GPCs connected through general-purpose routing.

The chain-formation logic in `heuristic.py` and `rtl_gen/chain.py` treats `(3, 9 : 2, 3, 1)` specially: it terminates one LOOKAHEAD8 sub-chain and initiates a new one (the `SUBCHAIN_END` marker in `analyze_subchain`).

---

## 4. The proposed compression heuristic (paper §IV.E)

Existing Versal compressor heuristics (Hoßfeld et al. [20]) prioritize either GPC efficiency or strength in isolation. The paper observes this is suboptimal — efficient counters do not compose into efficient *trees* unless the choice considers downstream consequences. The heuristic here instead **takes both area and delay into account, with the objective of minimizing LUT cost while keeping the critical path short**.

### Scheduling rule

A GPC is scheduled at column `c` only when both:

- **applicable** — the required input columns have enough free bits to fully populate the counter, and any LOOKAHEAD8 cascade constraints (§3.2) are met;
- **necessary** — placing this GPC is expected to reach the lowest LUT cost for reducing column `c` (and a limited span of subsequent columns) to height ≤ 4.

The *necessity* conditions come from paper Table V; restating with `H_c` = height of column `c` (counting unassigned bits *plus* outputs already produced this stage):

| Counter | Necessity condition |
|---------|---------------------|
| `(5, 17 : 4, 5, 1)` | always necessary |
| `(4, 13 : 3, 4, 1)` | `H_c ≥ 16` |
| `(3, 9 : 2, 3, 1)`  | `H_c ≥ 12` |
| `(9 : 4, 1)`        | `H_c ≥ 12` and `H_{c+1}/5 < H_c/17` |
| `(6 : 3]`           | `H_c = 9`, `H_{c+1} ≤ 3`, `H_{c+2} ≤ 3` |
| `(2, 2, 3 : 4]`     | `5 ≤ H_c ≤ 6`, `4 ≤ H_{c+1} ≤ 5`, `4 ≤ H_{c+2} ≤ 5` |
| `(3 : 2]`           | `5 ≤ H_c ≤ 6` |
| `(1, 5 : 3]`        | always necessary |

The heuristic walks the table in this **priority order** (top to bottom of the table above), placing the first counter that is both applicable and necessary at the current column, with its LSB aligned to that column.

### Stage-wise traversal

Within one compression stage:

- Scheduling starts from the **right-most column whose height exceeds 4** (in the paper's bit-heap diagrams the LSB is on the right; in the code's column indexing this is the lowest-index column with `H_c > 4`).
- After placing a counter that is a row-counter candidate, the scan moves to the column corresponding to the **MSB of the counter's outputs**, so the row counter can be extended.
- Otherwise, the scan moves to the next column.
- The stage ends when no further counter can be scheduled.

Counters within a stage are arranged in parallel; row-counter cascading is restricted to dedicated fast paths (§3.2 rules), avoiding general-purpose routing for the carry.

### Stage merging (paper §IV.E, end)

After all stages are placed, the heuristic checks whether the last GPC-compression stage can be **merged into the previous stage** by allowing limited under-utilization of `(3 : 2]` and `(1, 5 : 3]` counters — i.e. running them with one fewer input bit than nominal, supplied by leftovers that would otherwise spill into the next stage. As long as the merge does not prevent the terminal quaternary adder from completing, the two stages collapse into one. This trims one sequential compression stage with no LUT-cost increase.

`heuristic.py:merge_last_stage` implements the check; only `(3 : 2]` and `(1, 5 : 3]` are eligible — any other GPC in the last stage forfeits the merge (returns `False`).

### Result

Paper Fig. 11 reports an **8–20% area-delay product improvement** over Hoßfeld et al.'s efficiency-first and strength-first heuristics, evaluated on `(128)`, `(256)`, `(512)`, `(128,128)`, `(256,256)`, `(512,512)`, and `Mul16` bit heaps.

---

## 5. The proposed quaternary terminal adder (paper §IV.D)

Hoßfeld et al. [20] proposed a quaternary terminal adder that absorbs carry-save logic into LUTs implementing ripple-carry addition (paper Fig. 9). It saves one LUT per bit vs. two-operand adder trees, but breaks down on bit heaps where higher-weight columns hold only a single bit: direct application prevents LUT merging in those columns, and stitching it together with a two-operand adder for those columns adds a logic stage and forces general-purpose routing, increasing critical-path delay.

The paper's alternative (Fig. 10) is built as **two layers of row counters**:

- **Primary GPC: `(1, 5 : 3]`.** Each instance consumes 4 bits of column `c` plus 1 bit of column `c+1` and produces 3 output bits across columns `c, c+1, c+2`. Cascading these in a row counter handles the typical "height = 3 or 4" body of the bit heap directly.
- **Stitching GPC: `(3 : 2]`.** Where the bit heap thins out — single-bit columns toward the MSB — `(3 : 2]` propagates the carry through one column at a cost of 1 LUT per bit, with no extra routing.

`rtl_gen/terminal_add.py` implements this as two physical chains. Conceptually the input column-height list is partitioned by `terminalAdd_gen` into four contiguous regions:

1. **Tail.** A run of `H_c ≤ 2` columns at the bottom, summed with `(3 : 2]` counters chained into LOOKAHEAD8.
2. **Body.** A run of `H_c ∈ {3, 4}` columns, summed with `(1, 5 : 3]` counters at stride 2.
3. **Two-operand region.** A short trailing run of `H_c = 2` columns, summed with `(3 : 2]` counters again.
4. **Head.** A run of `H_c = 1` columns at the top — already a single bit; passes through.

The bookkeeping figures out chain parity, whether the tail can cascade into chain 1 (saving one chain), and how chain 1's outputs are folded back into chain 2's `(1, 5 : 3]` inputs at the right column offsets. The final result is then assigned into `comp_out` either combinationally or behind a register controlled by `terminal_reg_flag`.

The advantage over Hoßfeld's design shows up exactly when the bit heap has skinny single-bit columns at the top: the `(3 : 2]` stitches them together inside the same LOOKAHEAD8 fabric, no general-purpose routing required.

---

## 6. Booth radix-4 partial products on Versal (paper §IV.A)

For variable × variable multiplication, the generator emits a signed radix-4 modified-Booth multiplier.

### Booth digit recoding

A signed `B` is recoded by overlapping 3-bit windows `(b_{2i+1}, b_{2i}, b_{2i-1})` — with `b_{-1} = 0` and `B` sign-extended to even bit-width — into digits `b'_i = -2·b_{2i+1} + b_{2i} + b_{2i-1} ∈ {-2, -1, 0, +1, +2}` (paper Table II):

| (b_{2i+1}, b_{2i}, b_{2i-1}) | b'_i | partial product `P'_i = b'_i · A` | c_i |
|------------------------------|------|----------------------------------|:---:|
| 0 0 0 | 0  | 0          | 0 |
| 0 0 1 | +1 | A          | 0 |
| 0 1 0 | +1 | A          | 0 |
| 0 1 1 | +2 | A << 1     | 0 |
| 1 0 0 | −2 | −(A << 1)  | 1 |
| 1 0 1 | −1 | −A         | 1 |
| 1 1 0 | −1 | −A         | 1 |
| 1 1 1 | 0  | 0          | 1 |

`c_i` is the per-row "+1 correction" carry bit at column `2i`, exposed for the negative digits (it equals `b_{2i+1}`, so it costs no LUT). Recoding `B` into `⌈width_b / 2⌉` digits halves the partial-product count vs. radix-2.

### The dual-5-LUT trick: 2 PP bits per Versal LUT

Each partial-product bit `P'_{i,j}` is a Boolean function of five inputs: `(b_{2i+1}, b_{2i}, b_{2i-1})` from `B` and `(a_j, a_{j-1})` (with `a_{-1} = 0`) from `A`. On UltraScale this is **one LUT per PP bit**, since dual-5-LUT mode there forces all five inputs to be shared — and any UltraScale design therefore needs ~n²/2 LUTs for the partial-product heap of an n×n multiplication.

The paper's key Versal observation:

> Adjacent partial-product bits `(P'_{i,j+1}, P'_{i,j})` share four inputs, namely `(b_{2i+1}, b_{2i}, b_{2i-1}, a_j)`.

Versal's dual-5-LUT mode allows **independent fifth inputs** for the two halves (`a_{j-1}` for `P'_{i,j}` on `O5_1`, `a_{j+1}` for `P'_{i,j+1}` on `O5_2`) — so a single Versal LUT generates **two adjacent PP bits**. Paper Table III spells out the LUT-pin assignment:

```
A1..A4  =  (b_{2i-1}, b_{2i}, b_{2i+1}, a_j)         # shared between the two 5-LUTs
A5      =  a_{j-1}                                    # drives 5-LUT producing O5_1 = P'_{i,j}
A6      =  a_{j+1}                                    # drives 5-LUT producing O5_2 = P'_{i,j+1}
```

The total partial-product cost drops from ~n²/2 to **~n²/4 LUTs** for an n-bit multiplication.

The first row uses a slightly specialized truth table because `b_{-1} = 0` simplifies its 3-bit window to a 2-bit one. `Bmult_bitheap_RTL_gen` emits `LUT6_2` instances with INIT constants `64'h226688CC268C268C` (and `64'hDD33DD33268C268C` at the row-end) for that special case, with subsequent rows using `LUT5` instances with INIT constants `32'h8E96E8F0`, `32'h8EE896F0`, and `32'h7169170F` for the body and end-of-row sign-extension cells.

### Sign extension via Baugh-Wooley

Each partial-product row spans `width_a + 2` columns: one for the row's `+1` correction at column `2i` for digits `b'_i < 0`, and one for the sign-extension constant at column `width_a + 1`. Replicating the sign bit `width_a + width_b − 2i` times across the heap would inflate column heights unnecessarily. The Baugh-Wooley simplification (paper Fig. 5) replaces those replicated copies with **a single inverted sign bit plus constant `1'b1`s at fixed positions**.

For an n-bit multiplication the result is a bit heap of `≤ width_a + width_b + 2` columns and average column height around `width_b / 2` — small enough that the heuristic from §4 reduces it to height-4 in 1–2 stages, even for n = 32.

### Operand normalization

Booth recoding wants the recoded operand `OPB` to have even bit-width. The wrapper:

1. Picks whichever of `(width_a, width_b)` is wider (after rounding up to even) as `OPB`.
2. Sign-extends `OPB` to even width if it was odd.
3. Drives the smaller operand as `OPA` directly.

This is why Booth has a 6×6 minimum: below that, the bit heap is too narrow for the heuristic's chain-formation rules to give a useful pipeline.

### Result

Paper Fig. 12 reports up to **40% LUT reduction** vs. AMD LogiCORE IP multipliers (speed-optimized) with comparable critical-path delay across operand widths 6..32. Table VII shows the proposed 16-bit multiplier uses >25% fewer LUTs than Hoßfeld et al.'s gate-absorption multiplier (175 vs. 245 LUTs); even the proposed 18-bit multiplier (217 LUTs) beats their 16-bit multiplier.

---

## 7. NAF and constant multiplication *(extension, not in the paper)*

`cmult` generates `A · C` for constant `C` using only shifts, adds, and (when needed) the GPC compressor pipeline above. **No DSP blocks are inferred.**

A constant multiplier `A · C` is far cheaper if `C` is expressible as a small number of signed shifts:

```
A · C = ±(A << a₁) ±(A << a₂) ±…
```

The **non-adjacent form** (NAF) gives the shortest such representation in the unconstrained case: every two consecutive non-zero terms have at least one zero between them, guaranteeing minimum Hamming weight. `power_writer.py:naf_terms`:

```python
while n > 0:
    if n & 1:
        u = 2 - (n & 3)         # u ∈ {-1, +1}; chosen to clear two LSBs
        terms.append((sign0 * u, k))
        n = (n - u) >> 1
    else:
        n >>= 1
    k += 1
```

For an arbitrary 64-bit constant, NAF averages ~21 terms.

### Modulus lifting

For NTT twiddles we don't need `C` exactly — anything congruent to `C (mod q)` works. So `reduce_mod_q_min_powers_lift` does a beam search for `y ≡ C (mod q)` with the fewest NAF terms:

1. Start frontier `{C mod q, C mod q − q}`.
2. For `depth` iterations, expand each frontier element by `± q · 2^t` for `t = 0..max_shift`.
3. Score each candidate by `(num_NAF_terms, |value|, max_exponent)`; keep the best `beam` (default 200).
4. Return the best across all iterations.

For Goldilocks twiddles, a 21-term constant routinely drops to 2–4 terms.

### Building the bit heap from signed powers

`build_const_mult_bitheap(powers, input_name, input_width, signed_input)` constructs the partial-product bit heap. For each `(sign, power)` term and each input bit `A[i]`:

```
contribution = sign · A[i] · 2^(power + i)
```

Naively this places a bit at column `power + i`. Three corrections happen:

1. **Negative term, unsigned input.** Negation is `-A = ~A + 1` followed by an infinite chain of leading 1's (sign extension). The correction is computed once into `sign_ext` and then collapsed into the bit heap as `1'b1` bits at the appropriate columns.

2. **Signed input, positive term.** Standard two's-complement extension via **Baugh-Wooley**:
   - put `~A[W − 1]` at column `power + W − 1`,
   - add a `1'b1` correction in the same column,
   - add `1'b1` in every column `≥ power + W` that needs sign extension.
   This replaces `W − power` replicated sign bits with a single inverted sign bit and a constant.

3. **Signed input, negative term.** Combines both tricks: `−2^k · A_signed = +2^k · (~A + 1)`, so non-sign bits are complemented, the sign bit is *not* inverted (double negation cancels), a `+1` correction goes in column `k`, plus the sign-extension trick at the top.

The output width is computed exactly from `(min_A · C, max_A · C)` so the bit heap is no wider than necessary. **Implementation note (signed-output cases):** `build_const_mult_bitheap`'s internal `max_bits` must agree with `Cmult_RTL_gen._output_width()`'s convention — both use the IntType `+1`-for-sign-bit width, so for a signed product range that just brushes a power-of-2 boundary (e.g. `-2^96 ≤ result ≤ 2^96 − 2^29` for a `s68 · +2^29` cmult) the bit heap fills column `power + W` with the Baugh-Wooley `1'b1` sign-extension correction. An older revision computed `max_bits = max(neg_w, pos_w)` (one column short of the wrapper's port width), which left column `power + W` empty and silently miscomputed the sign bit on signed-input × single-positive-power-of-2 cases. The fix is to use `max(abs(prod_min), abs(prod_max)).bit_length()` everywhere, matching `_output_width()` exactly.

### Strategy dispatch — column height, not term count

`Cmult_RTL_gen` dispatches by **maximum column height** of the assembled heap (not by NAF term count — sign-extension constants can lift heights):

| Max height | Strategy | Why |
|------------|----------|-----|
| 1 | Pure wiring (shifts + inverters) | Only one bit per column; no addition needed |
| 2 | Verilog `+`/`-` (two-operand adder) | A single CPA suffices; LOOKAHEAD8 maps it to the dedicated carry chain |
| ≥ 3 | Full bit-heap compressor tree | More than two operands; reuses the heuristic from §4 |

A 2-NAF-term constant with `signed_input=True` can produce a height-3 heap (the inverted sign bit + correction lifts the column above the input width), so it goes through the compressor path despite having only 2 "real" terms.

---

## 8. Pipelining

Pipeline registers are inserted **between compression layers** (and between partial-product generation and the compressor, for `bmult`), not within a layer. `reg_flag_list_gen` distributes `pipeline_stages` register-insertion flags across `num_layers + 1` boundaries (the `+1` covers the terminal adder output) as evenly as possible. Each GPC primitive in `rtl/` exposes an `OUTREG` parameter — the chain generator passes the corresponding boolean from `reg_flag_list[layer]` so the same physical Versal LUT site provides either a flop or a wire on the output.

Empty layers — or layers folded by `merge_last_stage` (§4) — get no register, so register placement matches actual datapath depth. The result: requesting `pipeline_stages = 2` on a 4-layer compression always yields exactly 2 register stages, never 4 individual flops.

Paper Table VI gives achievable critical-path delays for several reference bit-heap shapes across 1–8 pipeline stages on Vivado 2025.2 / `xcvc1902-vsva2197-2MP-e-S`.

For `cmultbank`, individual constant multipliers may have shorter compressor latency than the worst case in the bank. To keep the bank's outputs mutually aligned, `Cmultbank_RTL_gen` inserts balancing flip-flops on the shorter-latency outputs in the wrapper:

```
uniform_latency = max(deepest_compressor_latency, requested_pipeline_stages, 1)
extra_regs[i]   = uniform_latency - compressor_latency[i]
```

with `extra_regs[i]` flops chained on the wrapper-side output of multiplier `i`.

---

## 9. Mapping summary

| Generator artifact | Versal primitive | Role |
|--------------------|------------------|------|
| GPC truth tables (`lut_init.py`) | Versal LUT in dual-5-LUT mode (`O5_1`/`O5_2`) and 6-LUT mode (`O6`) | Combinational sum/carry/propagate per bit-slice |
| `(3 : 2]`, `(1, 5 : 3]` chains | Versal LUT + LOOKAHEAD8 lookahead carry path (`PROP`/`CY*`) | Fast carry chain along the bit-heap columns |
| Cascade through LUT-cascade path (e.g. `(1, 5 : 3]` in Fig. 3, `(3, 9 : 2, 3, 1)` in Fig. 4) | LUT `O6 → CASC` direct wire | Avoids general-purpose routing for sum/carry forwarding |
| Chain length cap (8 LUTs when chain starts with incompatible GPC) | LOOKAHEAD8 CYMUXH constraint | Hard physical limit |
| Two-layer terminal quaternary adder | Two parallel LOOKAHEAD8 chains: `(1, 5 : 3]` body + `(3 : 2]` stitching | Final CPA after compression |
| Booth partial-product cells | Versal LUT in dual-5-LUT mode with independent A5 / A6 inputs | One LUT generates **two** adjacent PP bits — paper's ~n²/4 result |
| Inter-layer registers | Versal LUT site's optional output flop (`OUTREG`) | Free pipelining at zero LUT cost |
| Constant 0/1 in heap | Tied to `1'b0`/`1'b1` | Sign-extension and Baugh-Wooley constants |

---

## 10. References

- **Z. Miao et al., *Area-Efficient LUT-Based Multipliers for AMD Versal FPGAs*, IACR ePrint 2026/344.** The paper this generator implements. Versal LUT/LOOKAHEAD8 background (§II), compressor heuristic (§IV.E), proposed `(9:4,1)` GPC (§IV.B), row-counter rules (§IV.C), two-layer quaternary adder (§IV.D), dual-5-LUT Booth mapping (§IV.A).
- **K. Hoßfeld et al., *High-efficiency Compressor Trees for Latest AMD FPGAs*, ACM TRETS 17(2), 2024.** Prior Versal compressor work; baseline for the heuristic comparison and for the `(3, 9 : 2, 3, 1)`, `(2, 2, 3 : 4]`, `(1, 5 : 3]`, `(3 : 2]`, `(6 : 3]` GPCs.
- **C. R. Baugh and B. A. Wooley, *A Two's Complement Parallel Array Multiplication Algorithm*, IEEE TC C-22(12), 1973.** Sign-extension simplification used in both Booth row construction (§6) and signed-input `cmult` (§7).
- **O. L. MacSorley, *High-speed arithmetic in binary computers*, Proc. IRE 49(1), 1961.** Modified radix-4 Booth recoding.
- **AMD UG974 / AM005**, *Versal Adaptive SoC Configurable Logic Block Architecture Manual.* The authoritative reference on Versal LUT, LOOKAHEAD8, `PROP`, `CASC`, and the `LOOKB/D/F/H` attribute semantics.

The eight specific GPCs in this generator are not exhaustive; they were chosen to (a) each fit one or a few Versal LUT sites without spilling into fabric routing for the carry, and (b) collectively span the column-height ranges that show up in the target workloads (NTT butterflies, Goldilocks reductions, Booth partial-product reductions). Adding a new GPC requires both a primitive `.sv` file in `rtl/` and matching entries in `counter.py:counter_list`, `heuristic.py:isCounterApplicable / isCounterNecessary`, `rtl_gen/chain.py`, and `rtl_gen/lookahead.py:analyze_subchain`.
