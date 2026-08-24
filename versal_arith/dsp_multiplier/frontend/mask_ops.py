# core/frontend_mask_ops.py
"""Bit-level operations on CellMask, the coverage mask type: which cells of
the A x B multiplication grid are covered by a tile or already occupied on
the board. Each mask row is a bitmask (bit b_bit of rows[a_bit] means cell
(a_bit, b_bit) is set), so these are mostly just per-row bitwise ops.
"""
from __future__ import annotations

from dsp_multiplier.frontend.datamodel import CellMask

def make_empty_mask(
    a_width: int,
    b_width: int,
) -> CellMask:
    """An a_width x b_width mask with nothing covered."""
    return CellMask(
        a_extent=a_width,
        b_extent=b_width,
        rows=(0,) * a_width,
    )


def validate_mask(mask: CellMask) -> None:
    """Raise ValueError if `mask` is internally inconsistent (wrong row
    count, negative extents, or bits set outside b_extent)."""
    if mask.a_extent < 0 or mask.b_extent < 0:
        raise ValueError("CellMask extents cannot be negative")

    if len(mask.rows) != mask.a_extent:
        raise ValueError(
            "CellMask row count does not match a_extent: "
            f"{len(mask.rows)} != {mask.a_extent}"
        )

    valid_bits = (1 << mask.b_extent) - 1

    for row_index, row in enumerate(mask.rows):
        if row < 0:
            raise ValueError(
                f"CellMask row {row_index} cannot be negative"
            )

        if row & ~valid_bits:
            raise ValueError(
                f"CellMask row {row_index} contains bits outside "
                f"b_extent={mask.b_extent}"
            )


def require_same_shape(
    left: CellMask,
    right: CellMask,
) -> None:
    """Raise ValueError unless both masks have the same (a_extent, b_extent)."""
    if (
        left.a_extent != right.a_extent
        or left.b_extent != right.b_extent
    ):
        raise ValueError(
            "CellMask shapes differ: "
            f"{left.a_extent}x{left.b_extent} != "
            f"{right.a_extent}x{right.b_extent}"
        )


def make_full_mask(
    a_width: int,
    b_width: int,
) -> CellMask:
    """Create a fully-covered A_width x B_width multiplication area."""

    if a_width <= 0 or b_width <= 0:
        raise ValueError(
            "Board dimensions must be positive, got "
            f"{a_width}x{b_width}"
        )

    full_row = (1 << b_width) - 1

    return CellMask(
        a_extent=a_width,
        b_extent=b_width,
        rows=(full_row,) * a_width,
    )

def mask_transpose(mask: CellMask) -> CellMask:
    """Swap the A and B axes (used when a tile is placed in its
    transposed orientation)."""
    result_rows = [0] * mask.b_extent

    for a, row in enumerate(mask.rows):
        for b in range(mask.b_extent):
            if row & (1 << b):
                result_rows[b] |= 1 << a

    return CellMask(
        a_extent=mask.b_extent,
        b_extent=mask.a_extent,
        rows=tuple(result_rows),
    )

def place_mask_on_board(
    local_mask: CellMask,
    *,
    a0: int,
    b0: int,
    board_a_width: int,
    board_b_width: int,
) -> CellMask:
    """Translate a tile-local mask onto the board at (a0, b0). Raises
    ValueError if any part of it would fall outside the board -- for a
    version that instead clips the overhang, see
    place_mask_on_board_clipped."""
    if a0 < 0 or b0 < 0:
        raise ValueError("Placement origin cannot be negative")

    if a0 + local_mask.a_extent > board_a_width:
        raise ValueError("Placement exceeds A boundary")

    if b0 + local_mask.b_extent > board_b_width:
        raise ValueError("Placement exceeds B boundary")

    board_rows = [0] * board_a_width

    for local_a, local_row in enumerate(local_mask.rows):
        global_a = a0 + local_a
        board_rows[global_a] = local_row << b0

    return CellMask(
        a_extent=board_a_width,
        b_extent=board_b_width,
        rows=tuple(board_rows),
    )


def place_mask_on_board_clipped(
    local_mask: CellMask,
    *,
    a0: int,
    b0: int,
    board_a_width: int,
    board_b_width: int,
) -> CellMask:
    """Like place_mask_on_board, but allows the tile to stick out past the
    board's high-order boundary: whatever falls off-board is simply
    dropped, keeping only the in-board cells."""
    if a0 < 0 or b0 < 0:
        raise ValueError("Placement origin cannot be negative")

    if a0 >= board_a_width or b0 >= board_b_width:
        raise ValueError("Placement origin is outside the board")

    valid_bits = (1 << board_b_width) - 1
    board_rows = [0] * board_a_width

    for local_a, local_row in enumerate(local_mask.rows):
        global_a = a0 + local_a
        if global_a >= board_a_width:
            break                                  # out of bounds in A; every row after this is too
        board_rows[global_a] = (local_row << b0) & valid_bits   # clip the high bits in B

    return CellMask(
        a_extent=board_a_width,
        b_extent=board_b_width,
        rows=tuple(board_rows),
    )


def mask_is_empty(mask: CellMask) -> bool:
    """Whether no cell is covered."""
    return all(row == 0 for row in mask.rows)


def mask_cell_count(mask: CellMask) -> int:
    """How many cells are covered.

    Uses bin(...).count instead of int.bit_count, to stay compatible
    with older Python versions."""

    return sum(
        bin(row).count("1")
        for row in mask.rows
    )


def mask_is_subset(
    subset: CellMask,
    superset: CellMask,
) -> bool:
    """Whether every cell in `subset` is also in `superset`."""

    require_same_shape(subset, superset)

    return all(
        subset_row & ~superset_row == 0
        for subset_row, superset_row
        in zip(subset.rows, superset.rows)
    )


def mask_intersects(
    left: CellMask,
    right: CellMask,
) -> bool:
    """Whether the two masks share at least one covered cell."""
    require_same_shape(left, right)

    return any(
        left_row & right_row
        for left_row, right_row
        in zip(left.rows, right.rows)
    )


def mask_subtract(
    source: CellMask,
    removed: CellMask,
) -> CellMask:
    """Returns source - removed.

    `removed` must be entirely within `source` -- otherwise a placement
    conflicted with existing coverage."""

    require_same_shape(source, removed)

    if not mask_is_subset(removed, source):
        raise ValueError(
            "Cannot remove coverage that is not a subset "
            "of the current free mask"
        )

    return CellMask(
        a_extent=source.a_extent,
        b_extent=source.b_extent,
        rows=tuple(
            source_row & ~removed_row
            for source_row, removed_row
            in zip(source.rows, removed.rows)
        ),
    )


def mask_complement_within_board(
    covered: CellMask,
) -> CellMask:
    """Derive the free/uncovered mask from a covered mask.

    The result is only inverted within the current board extent."""

    validate_mask(covered)

    valid_bits = (1 << covered.b_extent) - 1

    return CellMask(
        a_extent=covered.a_extent,
        b_extent=covered.b_extent,
        rows=tuple(
            (~row) & valid_bits
            for row in covered.rows
        ),
    )

def mask_union(
    left: CellMask,
    right: CellMask,
) -> CellMask:
    """Cells covered by either mask."""
    require_same_shape(left, right)

    return CellMask(
        a_extent=left.a_extent,
        b_extent=left.b_extent,
        rows=tuple(
            left_row | right_row
            for left_row, right_row
            in zip(left.rows, right.rows)
        ),
    )
