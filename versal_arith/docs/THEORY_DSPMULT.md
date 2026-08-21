# versal_arith — DSP/LUT Multiplier: Theory Notes

This document covers `-operator dspmult`, the hybrid DSP58+LUT multiplier generator under
`dsp_multiplier/`. It is a separate subsystem from the compressor/Booth engine documented in
`THEORY.md` (it reuses that engine as a library — see §1.2), and its own extension, not part of
the paper. **This is a brief working note, not a finished spec** — it documents the current
search/costing strategy well enough to read the code, not every tuning constant.

For "how do I run this", see `USAGE_DSPMULT.md`.

---

## Introduction

Given `(width_a, width_b, a_sign, b_sign)` and a DSP budget, `dspmult` searches for the
cheapest-in-LUTs way to build that multiplier out of DSP58 tiles (single, cascaded chains, and
fixed Karatsuba/Toom-Cook macro tiles) plus a LUT-based Booth/compressor fallback for whatever
the DSP tiles don't cover, **never using more than `budget` DSPs** — every returned solution
satisfies `dsp_count(node) <= budget` (checked once, at the top, in `solve_top`/`solve_grid_top`).

Tiles are also allowed to **overhang**: a placement's bounding rectangle may extend past the
board's high edge as long as its *on-board* coverage still clears a minimum ratio
(`LARGE_FLOOR`/`FILL_FLOOR` in `solver/tuning.py`). This is a deliberate area/LUT trade: a DSP
tile that's 80% on-board still replaces 80% of what would otherwise be LUT-built product bits,
for the cost of one DSP that's only partly used — worthwhile whenever the LUTs it would otherwise
cost exceed the wasted DSP capacity. Overhang is only tried after every fully-on-board placement
is exhausted (see §1.1.1), and only at the board's low corner / origin for the one-shot "whole
tile bigger than the board" case.

Two independent decompositions run at every board:
- **Direct tiling** (§1.1.1): geometric placement of DSP58/chain/macro tiles on the current board.
- **Karatsuba-2 / Karatsuba-3** (§1.1.2): split the board algebraically into smaller
  sub-multiplications, recurse, then sum the sub-products back together (in LUTs).

Both are tried at every recursion level, memoized by `(a_width, b_width, a_sign, b_sign, budget)`,
and the top `BEAM` (`solver/tuning.py`) cheapest results are kept at each node — this is a
beam-search over algebraic decomposition, not branch-and-bound over the whole tree, so it isn't
guaranteed globally optimal, only locally greedy at each recursion boundary. A board with
`a_width != b_width` is first cut into `min(a_width,b_width)`-square tiles (plus one leftover
remainder) by `solve_grid`, each square/remainder then handed to the square solver above with a
DSP budget allocated by area (`_plan_dsp_targets`); this is orthogonal to Karatsuba/tiling and
runs one layer above them.

---

## 1.1 Frontend: Tiling && K2 && K3

### 1.1.1 Direct tiling: greedy narrowing → exhaustive large-tile search → greedy small-tile fill

`solver/tiling_search.py:tilings_phased` places tiles on one board within a DSP sub-budget. The
placement position is always chosen from `find_corner_cells`: the only candidate anchors are the
board's geometric "corners" (a free cell diagonally touching the board edge or an already-covered
cell), sorted ascending by `(a+b)` — i.e. **the search always progresses from the LSB corner
outward**, never scatters placements across weight order. This alone collapses the position space
from every free cell to just its corners.

Within that, three passes cooperate:

1. **Greedy row-lock (search-domain reduction).** Once the free area is "coarse" enough
   (`free >= T_COARSE * K2_CELLS`), placing a large tile at a corner **locks that row**: every
   following step is a forced, non-branching *continuation* — the same DSP count and row height,
   extended as wide as legally possible (`_continuation`) — until the row runs out. This turns
   what would otherwise be a huge combinatorial search over "how to tile a wide row" into one
   deterministic path, and is what makes the whole search tractable on large boards.
2. **Exhaustive large-tile DFS.** Once not row-locked, the search branches over **every** legal
   large tile (`dsp >= 2`) at the single best open corner and recurses (backtracking DFS), bounded
   by `max_nodes`. This is the genuinely exhaustive part — it explores real alternatives, not just
   the locally-best one — but only over placements at that one corner, keeping the branching
   factor small.
3. **Small-tile compensation (greedy, no branching).** Once local DSP density crosses
   `density_switch` (`DENSITY_M1`), the search stops considering large tiles altogether and
   greedily places one DSP58/chain tile at a time (`_best_fill_once`) until the budget or board is
   exhausted. The same greedy chain-fill also runs once, as a final mop-up pass, after every DFS
   leaf (`finish()`), so any DSP budget the large-tile/lock phases left idle still gets spent if a
   chain fits.

A one-shot **overhang** root (§1.0) is tried before the main DFS, at the board's origin only —
covering the "requested tile is bigger than the whole board" case.

Because `tilings_phased` can produce far more candidates than are worth exact-costing, its results
are pre-filtered by a cheap proxy (`area_estimate` — intrinsic LUTs of the placed tiles plus one
LUT per uncovered cell) down to `GREEDY_PREFILTER` per DSP-count level (`_trim_results`), and only
*those* survivors go through the exact LUT costing in `cost_of`/`exact_cost.py` (which does a real
rectangle decomposition of the leftover area and prices it through the compressor/Booth engine
from `THEORY.md` — see §1.2's note on `common/lut_cost.py`). That two-stage filter — cheap proxy,
then exact pricing only on the survivors — is what keeps `solve()`'s recursion affordable.

### 1.1.2 K2 / K3: equal split only

`solve.py` implements the recursive algebraic decomposition — distinct from the fixed-size K2/K3
*macro tiles* in the tile library (§1.1.1's `STATIC_TILE_DEFINITIONS`: a hand-built 3-DSP 48×45 K2
and 6-DSP 70×67 K3 netlist, placed geometrically like any other tile). This section is about
recursively splitting the *algebraic* problem itself:

- **Karatsuba-2** (`make_children`/`split_point`): `A = A_hi<<k | A_lo`, `B = B_hi<<k | B_lo`, giving
  `low = A_lo*B_lo`, `high = A_hi*B_hi`, `mid = |A_hi-A_lo| * |B_lo-B_hi|` (3 sub-products instead
  of 4, at the cost of the merge-time adds/subtracts in `cost.py:karatsuba_merge`).
- **Karatsuba-3** (`make_children3`/`split3_point`): the 3-way analogue, 6 sub-products
  `(d0,d1,d2,m01,m02,m12)` instead of 9.

In both cases **the split point is fixed at the balanced halves/thirds** (`split_point(w) =
(w+1)//2`, `split3_point(w) = w//3`) — the code does not search over every possible split point
`1..w-1`. Likewise, the DSP budget handed to each child is only ever the "as even as possible"
partition (`balanced_split`/`balanced_split6`), not an enumeration over every way to divide the
parent's budget among its children (an older version did enumerate `partitions_into_3`; it's gone).

This is a deliberate restriction, not an oversight: search domain grows exponentially with depth
if either the split point or the budget split is enumerated (each of `O(budget)` choices at each
of up to `log w` recursion levels, times the K2/K3 branching itself) — with only balanced splits
tried, each recursion level contributes one candidate instead of `O(w)` or `O(budget²)`, keeping
the whole recursive search (tiling ⨯ K2 ⨯ K3, memoized, top-`BEAM` kept per node) polynomial rather
than combinatorial. Both `can_split`/`can_split3` gate this off entirely once the split wouldn't
shrink the problem (would recurse forever) or the resulting `mid`/`m02` sub-board can't hold a
single DSP (nothing to gain over pure LUT tiling).

---

## 1.2 Backend: xcv80-calibrated timing model + Pareto-optimal latency selection

The backend (`backend/lowering.py` → `backend/delay_model.py` → `backend/schedule.py` →
`rtl_gen/dsp_multiplier/`) turns an already-solved `(SolutionNode, LUTReport)` pair into a
latency-optimized IR module, then RTL.

**Timing data.** `backend/timing/dsp_lib.py` is a flat table of nanosecond constants for every
DSP58 combinational/register arc (A→A2DATA, the 27×24 multiplier array, ALU add paths, PCIN/PCOUT
cascade, …) plus the Karatsuba-2/3 and Toom-2.5 macro tiles' own measured critical-path segments,
and the Versal fabric LOOKAHEAD8 carry-chain arcs. Every constant is tagged `M` (measured directly
from a post-implementation Vivado timing report), `E` (estimated — Vivado never printed that arc
because it was bypassed in the measured design), or `X` (derived from two measured numbers).
**Calibrated against Vivado post-implementation data on `xcv80 -2MHP`** (comment in
`delay_model.py`). `backend/timing/dsp_model.py` composes those arcs into an achievable
`(latency → ns)` curve per tile family (single DSP, an L-block chain, K2, K3, T2.5).

**LUT-side delay** (for the Booth/compressor fallback and any bitheap summing sub-products back
together) reuses `common/lut_cost.py`'s LUT-count model, which itself calls straight into the
`bitheap`/`heuristic` compressor engine documented in `THEORY.md` §4 — the *same* GPC scheduling
and terminal-adder logic, run here purely for costing (no RTL side effects) so the DSP-vs-LUT
search and the eventual RTL agree on what a given bitheap actually costs.

**Latency selection** Every stretchable IR block (one whose latency can trade against its
own critical path — a DSP tile with multiple achievable pipeline depths, or a compressor stage)
contributes a `(latency → ns)` curve. `delay_model.py:pareto_frontier` finds every Pareto-optimal
`(per-stage budget D, achieved worst-case ns W, total cycles T)` point over the *whole design* with
three-tier pruning — never brute-forcing the cross product of every block's latency choices:
tier 0 drops blocks already pinned at their floor delay (they never need to move), tier 1 drops
any candidate `D` below that floor outright, tier 2 skips every candidate a given assignment
already dominates. `select_ns_point` then picks, from that frontier, the point with the smallest
`W` among those whose `T <= latency_budget` (or, with no budget given, the smallest `W` on the
whole frontier) — **the fastest achievable critical path the caller's latency budget can buy**.
`backend/schedule.py:align_latency` then inserts delay-line registers so every block actually
lands on its chosen latency, and that aligned module is what `rtl_gen` emits.

---

## Other notes

- **Solution bundles** (`frontend/storage.py`) serialize the solved `SolutionNode` + `LUTReport`
  tree to JSON so the frontend (search) and backend (lower + emit) steps can run as separate CLI
  invocations — see `USAGE_DSPMULT.md` §2.2.
- **Memoization caches** (`_solve_cache`, `_grid_cache`, per-shape `LazyPlacementSource` caches)
  are all cleared at the top of `solve_top`/`solve_grid_top`, so results don't leak or go stale
  across independent runs in the same process.
- **Sign handling** follows the board-edge rule throughout: a tile/sub-board is only allowed to
  treat an operand as signed if its own bounding rectangle actually touches that operand's MSB
  edge (`_sign_matches_edges`); everything strictly below the top is unsigned magnitude. Karatsuba
  differences (`mid`, `m01`/`m02`/`m12`) are always signed regardless of the parent's signedness,
  since a difference of two unsigned magnitudes can go negative.
