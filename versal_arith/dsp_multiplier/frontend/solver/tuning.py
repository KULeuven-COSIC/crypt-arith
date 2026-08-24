# solver/tuning.py
"""Every knob that trades off search speed against solution quality in the
frontend (tiling + Karatsuba search), gathered in one place instead of
scattered across solve.py / tiling_search_phase.py.

These are the values worth sweeping if a search run is too slow, or if
it's leaving DSP/LUT on the table -- as opposed to constants elsewhere
that are geometric facts about a specific tile (K2_CELLS, _LARGE_MAX_EXT
in tiling_search_phase.py) or physical hardware characteristics
(CHAIN_BASE_LATENCY, PCIN_PITCH, ... in core/frontend_seed_tiles.py),
neither of which make sense to tune independently of what they describe.

Note: SPLIT_FLOOR and LARGE_FLOOR happen to share the same value (23*23)
and the same underlying rationale -- "the smallest board that can hold one
DSP58" -- but are kept as two separate constants here since they gate two
different decisions (whether to attempt a Karatsuba split at all, vs.
whether an off-board large tile still covers enough cells to be worth
it); nothing currently forces them to move together.
"""
from __future__ import annotations

# ==================== solve.py: top-level beam search ====================

BEAM = 1
# Each sub-problem ultimately keeps only the BEAM cheapest solutions.

GREEDY_PREFILTER = 5
# Phase A: after a coarse area-based ranking, how many tilings go on to
# exact costing (folds in what used to be TILINGS_PER_NODE).

TILING_MAX_NODES = 200_000
# DFS node cap for a single sub-board -- this is the real throttle on
# runtime.

SPLIT_FLOOR = 529   # 23*23 = 529
# The area floor for attempting a Karatsuba split at all: if the short
# side squared can't even fit one DSP, cutting further only adds merge
# overhead -- better to hand the whole thing straight to tiling+bmult.

# ==================== tiling_search_phase.py: the three-phase tiling search ====================

T_COARSE = 5
# free/K2_CELLS >= T_COARSE -> coarse phase (whole rows);
# free/K2_CELLS <  T_COARSE -> fine phase (single blocks).

DENSITY_M1 = 0.75
# mode1 threshold: past this density, fill a chain directly and take the
# solution outright (no branching).

LARGE_MIN_DSP = 3
# The large-tile phase only considers tiles with at least this many DSPs
# (k2 and up); smaller ones are left for the chain-fill phase instead.

LARGE_FLOOR = 529
# Once a large tile goes off-board, the minimum cells each DSP it uses
# must still cover, or the overhang isn't worth it.

FILL_FLOOR = 50
# Once a DSP58/chain goes off-board during the fill phase, the minimum
# cells each DSP must still cover.
