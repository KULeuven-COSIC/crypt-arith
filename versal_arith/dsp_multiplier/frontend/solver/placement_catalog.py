# solver/placement_catalog.py
"""Builds the lazy placement source the tiling search draws on.

Note: the eager catalog-building path (enumerate every legal placement up
front into one big PlacementCatalog) has been removed here -- it turned
out to be dead code. The lazy path (LazyPlacementSource, generating a
placement only when a corner query actually asks for it) is what the live
search uses.
"""
from __future__ import annotations

from dsp_multiplier.frontend.datamodel import (
    Signedness,
    Orientation,
    PlacementKey,
    ResolvedPlacement,
    TileShape,
    WeightedWord,
    Rect,
)
from dsp_multiplier.frontend.mask_ops import (
    mask_transpose,
    place_mask_on_board_clipped,
    mask_cell_count,
)
from dsp_multiplier.frontend.seed_tiles import oriented_sign_mode


def _sign_matches_edges(
    board_sign,
    *,
    a_covers_msb: bool,
    b_covers_msb: bool,
    board_a_signed: bool,
    board_b_signed: bool,
) -> bool:
    """Whether a shape's own sign mode is legal at this position: only a
    tile covering the board's MSB gets to treat the corresponding input
    as signed."""
    want_a_signed = a_covers_msb and board_a_signed
    want_b_signed = b_covers_msb and board_b_signed
    got_a_signed = board_sign.a is Signedness.SIGNED
    got_b_signed = board_sign.b is Signedness.SIGNED
    return got_a_signed == want_a_signed and got_b_signed == want_b_signed


def build_tile_shapes(library):
    """Expand a TileLibrary into every (implementation x orientation)
    TileShape, board-size-independent and ready for LazyPlacementSource
    to position. Sorted by DSP count then area, descending."""
    shapes = []
    for impl in library.implementations.values():
        spec = library.specs[impl.spec_id]
        profile = impl.sign_profiles[0]
        # Sort rather than iterating the frozenset directly: set/frozenset
        # iteration order for Enum members falls back to id()-based
        # hashing (Enum doesn't override __hash__), which depends on
        # allocation order and is not guaranteed stable across different
        # module layouts -- moving Orientation's class definition into a
        # different file with more/fewer classes defined before it can
        # silently flip this order, changing which of two equally-scored
        # tie-broken candidates gets picked downstream. Sorting by value
        # pins it to a fixed, reproducible order.
        for orientation in sorted(spec.allowed_orientations, key=lambda o: o.value):
            local = spec.local_coverage
            if orientation is Orientation.TRANSPOSED:
                local = mask_transpose(local)
            shapes.append(TileShape(
                impl_id=impl.impl_id,
                spec_id=impl.spec_id,
                orientation=orientation,
                local=local,
                a_ext=local.a_extent,
                b_ext=local.b_extent,
                impl_sign=profile.sign_mode,
                board_sign=oriented_sign_mode(profile.sign_mode, orientation),
                resources=profile.resources,
            ))
    # same priority ordering as the (now-removed) eager catalog: more DSPs first, larger area first among equal DSP counts
    shapes.sort(key=lambda s: (-s.resources.dsp, -(s.a_ext * s.b_ext)))
    return tuple(shapes)

class LazyPlacementSource:
    """Generates placements on demand: a placement is only constructed and
    cached once a corner query actually asks for it."""

    def __init__(self, a_width, b_width, a_signedness, b_signedness, shapes):
        self.a_width = a_width
        self.b_width = b_width
        self._board_a_signed = a_signedness is Signedness.SIGNED
        self._board_b_signed = b_signedness is Signedness.SIGNED

        # -- for area feasibility: the minimum cells each DSP occupies --
        dsp_shapes = [
            (mask_cell_count(s.local), s.resources.dsp)
            for s in shapes
            if s.resources.dsp >= 1 and self._shape_fits_somewhere(s)
        ]
        self.min_cells_per_dsp = (
            min(cells / dsp for cells, dsp in dsp_shapes)
            if dsp_shapes else float("inf")
        )
        self._shapes = shapes
        self._cache = {}          # PlacementKey -> ResolvedPlacement

    def _position_legal(self, shape, a0, b0,
                        allow_overhang: bool = False,
                        floor: int = 0) -> bool:
        """Bounds check + sign-edge check + off-board utilization check.
        allow_overhang=False: the tile must fit entirely on-board, `floor` has no effect
        allow_overhang=True : allowed to stick out past the high boundary, but on-board coverage/DSP must be >= floor"""
        if a0 < 0 or b0 < 0:
            return False

        if allow_overhang:
            if a0 >= self.a_width or b0 >= self.b_width:
                return False          # origin itself is off-board, covers zero cells
            dsp = shape.resources.dsp
            if dsp >= 1 and floor > 0:
                a_ext = min(shape.a_ext, self.a_width - a0)
                b_ext = min(shape.b_ext, self.b_width - b0)
                if a_ext * b_ext < floor * dsp:
                    return False      # too much off-board, this DSP isn't worth it
        else:
            if a0 + shape.a_ext > self.a_width:
                return False
            if b0 + shape.b_ext > self.b_width:
                return False

        return _sign_matches_edges(
            shape.board_sign,
            a_covers_msb=(a0 + shape.a_ext >= self.a_width),
            b_covers_msb=(b0 + shape.b_ext >= self.b_width),
            board_a_signed=self._board_a_signed,
            board_b_signed=self._board_b_signed,
        )

    def _resolve(self, shape, a0, b0):
        """Construct (or fetch from cache) a ResolvedPlacement. The off-board part gets clipped off."""
        key = PlacementKey(shape.impl_id, a0, b0, shape.orientation)
        hit = self._cache.get(key)
        if hit is not None:
            return hit

        a_ext = min(shape.a_ext, self.a_width - a0)     # actual width after clipping
        b_ext = min(shape.b_ext, self.b_width - b0)

        coverage = place_mask_on_board_clipped(          # the clipped variant
            shape.local, a0=a0, b0=b0,
            board_a_width=self.a_width, board_b_width=self.b_width,
        )
        rect = Rect(a0, b0, a_ext, b_ext)                # store the clipped width/height
        term_signedness = (
            Signedness.SIGNED
            if shape.impl_sign.a is Signedness.SIGNED
            or shape.impl_sign.b is Signedness.SIGNED
            else Signedness.UNSIGNED
        )
        p = ResolvedPlacement(
            key=key,
            spec_id=shape.spec_id,
            bounding_rect=rect,
            coverage=coverage,
            a_slice=rect.a_slice,
            b_slice=rect.b_slice,
            required_sign_mode=shape.impl_sign,
            resources=shape.resources,
            output_terms=(WeightedWord(
                name="product",
                width=a_ext + b_ext,                     # width after clipping
                lsb_weight=a0 + b0,
                signedness=term_signedness,
                coefficient=1,
            ),),
            pad_a=shape.a_ext - a_ext,
            pad_b=shape.b_ext - b_ext,
        )
        self._cache[key] = p
        return p

    def placements_at_corner(self, a, b, da, db,
                             allow_overhang: bool = False, floor: int = 0):
        """Every legal placement whose bounding rect has a (da,db)-type
        corner at (a,b). The corner position uniquely determines a0/b0, so
        each shape contributes at most one."""
        if allow_overhang and (da == 1 or db == 1):
            raise ValueError("allow_overhang currently only supports the (-1,-1) corner")

        out = []
        for shape in self._shapes:
            a0 = a if da == -1 else a - (shape.a_ext - 1)
            b0 = b if db == -1 else b - (shape.b_ext - 1)
            if self._position_legal(shape, a0, b0, allow_overhang, floor):
                out.append(self._resolve(shape, a0, b0))
        return out

    def can_hold_dsp(self, floor: int = 0) -> bool:
        """Existence check: is there any DSP-bearing shape that can legally
        be placed on this board.
        floor == 0 -> old behavior: the tile must fit entirely on-board
        floor > 0  -> off-board allowed, but on-board coverage/DSP must be >= floor
        Pure arithmetic, doesn't construct any placement."""
        for shape in self._shapes:
            if shape.resources.dsp < 1:
                continue
            if floor <= 0:
                if self._shape_fits_somewhere(shape):
                    return True
            elif self._max_clipped_cells(shape) >= floor * shape.resources.dsp:
                return True
        return False

    @staticmethod
    def _dim_max_extent(ext, width, shape_signed, board_signed) -> int:
        """Along a single dimension, the largest on-board width across all
        legal positions. 0 = no legal position exists."""
        if ext >= width:
            # any position covers the MSB -> sign must match the board's; the widest position is at a0=0
            return width if shape_signed == board_signed else 0
        # ext < width: the tile fits entirely, so the widest position is just ext
        if shape_signed:
            return ext if board_signed else 0
        return ext      # unsigned tile: dodges the top edge when the board is signed, placed freely when the board is unsigned

    def _max_clipped_cells(self, shape) -> int:
        """When off-board is allowed, the most cells this shape can cover
        on this board. The two dimensions' position ranges are independent,
        so their maxima can be taken separately and multiplied."""
        a_max = self._dim_max_extent(
            shape.a_ext, self.a_width,
            shape.board_sign.a is Signedness.SIGNED, self._board_a_signed)
        if a_max == 0:
            return 0
        b_max = self._dim_max_extent(
            shape.b_ext, self.b_width,
            shape.board_sign.b is Signedness.SIGNED, self._board_b_signed)
        return a_max * b_max

    def _shape_fits_somewhere(self, shape) -> bool:
        """Whether this shape has at least one legal on-board position,
        without constructing any placement."""
        if shape.a_ext > self.a_width or shape.b_ext > self.b_width:
            return False
        # A direction: if the tile's A is signed -> only the flush-to-top
        #   position is legal, and it requires the board's A to be signed
        #   too (that flush position must exist); if the tile's A is
        #   unsigned -> when the board is signed, a "not flush to top"
        #   position must exist.
        if shape.board_sign.a is Signedness.SIGNED:
            if not self._board_a_signed:
                return False
        elif self._board_a_signed and shape.a_ext == self.a_width:
            return False          # the only position is flush-to-top, but flush-to-top must be signed -> no solution
        # same reasoning for the B direction
        if shape.board_sign.b is Signedness.SIGNED:
            if not self._board_b_signed:
                return False
        elif self._board_b_signed and shape.b_ext == self.b_width:
            return False
        # the two directions' edge conditions are independent, so satisfying each individually satisfies both
        return True
