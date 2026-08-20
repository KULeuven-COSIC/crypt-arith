# core/frontend_datamodel.py
"""The frontend's type system: the plain dataclasses/enums the solver's
search and cost model are built on.

Reads top-to-bottom as one build-up, each section depending only on the
ones above it: primitives -> problem spec -> tile spec -> tile
implementation -> placement.
"""
from __future__ import annotations

from collections.abc import Mapping
from dataclasses import dataclass
from enum import Enum
from typing import NewType

# =============================================================================
# Primitives
# =============================================================================

TileSpecId = NewType("TileSpecId", str)
TileImplId = NewType("TileImplId", str)


@dataclass(frozen=True)
class BitSlice:
    """A half-open bit slice: [lo, lo + width)."""

    lo: int
    width: int

    @property
    def hi_exclusive(self) -> int:
        return self.lo + self.width


@dataclass(frozen=True)
class Rect:
    """A rectangle within the multiplication area, in A/B bit-index coordinates."""

    a0: int
    b0: int
    a_width: int
    b_width: int

    @property
    def a_slice(self) -> BitSlice:
        return BitSlice(self.a0, self.a_width)

    @property
    def b_slice(self) -> BitSlice:
        return BitSlice(self.b0, self.b_width)


@dataclass(frozen=True)
class CellMask:
    """A local or global coverage mask.

    Bit ``b_bit`` of ``rows[a_bit]`` says whether Cell(a_bit, b_bit) exists.
    External code should never touch ``rows`` directly -- go through
    ``contains``/``union``/``intersects``/``translate`` etc. instead.
    """

    a_extent: int
    b_extent: int
    rows: tuple[int, ...]

    def __post_init__(self) -> None:
        from dsp_multiplier.frontend.mask_ops import validate_mask
        validate_mask(self)


# =============================================================================
# Problem specification
# =============================================================================


class Signedness(Enum):
    UNSIGNED = "unsigned"
    SIGNED = "signed"


@dataclass(frozen=True)
class SignMode:
    a: Signedness
    b: Signedness


# =============================================================================
# Tile spec
# =============================================================================


class Orientation(Enum):
    AB = "ab"
    TRANSPOSED = "transposed"


@dataclass(frozen=True)
class OutputTermSpec:
    """A weighted word produced by a tile.

    A fully-reconstructed macro tile normally has exactly one output term;
    the model still allows exposing several internal terms straight to the
    global bit heap.
    """

    name: str
    width: int
    local_shift: int
    signedness: Signedness
    coefficient: int = 1


@dataclass(frozen=True)
class TileSpec:
    """A logical tile, independent of any concrete FPGA resource, pipeline
    depth, or LUT count."""

    spec_id: TileSpecId

    # A plain string rather than a closed Enum, so new families can be
    # added without touching this module.
    family: str
    display_name: str

    input_sign_mode: SignMode
    # The tile's full coverage area, in its own local coordinates.
    local_coverage: CellMask

    allowed_orientations: frozenset[Orientation]

    # The arithmetic outputs visible to the outside.
    outputs: tuple[OutputTermSpec, ...]

    schema_version: int = 1

    @property
    def canonical_a_width(self) -> int:
        return self.local_coverage.a_extent

    @property
    def canonical_b_width(self) -> int:
        return self.local_coverage.b_extent

    @property
    def canonical_shape(self) -> tuple[int, int]:
        return (
            self.local_coverage.a_extent,
            self.local_coverage.b_extent,
        )


# =============================================================================
# Tile implementation
# =============================================================================


@dataclass(frozen=True)
class ResourceUsage:
    dsp: int

    # None means "not characterized yet" -- never silently write 0 for unknown.
    intrinsic_lut: int | None = None
    ff: int | None = None


@dataclass(frozen=True)
class TimingProfile:
    latency_cycles: int | None = None
    initiation_interval: int = 1
    fmax_mhz: float | None = None


@dataclass(frozen=True)
class SignCharacterization:
    sign_mode: SignMode
    resources: ResourceUsage
    timing: TimingProfile


class ImplementationKind(Enum):
    ATOMIC = "atomic"


@dataclass(frozen=True)
class AtomicBody:
    backend_key: str
    parameters: tuple[tuple[str, object], ...] = ()


@dataclass(frozen=True)
class TileImplementation:
    """One concrete way to build a TileSpec: its resource/timing cost per
    sign mode, plus how to generate its RTL."""

    spec_id: TileSpecId
    impl_id: TileImplId

    kind: ImplementationKind
    body: AtomicBody

    target_architecture: str

    sign_profiles: tuple[SignCharacterization, ...]

    # Other implementations this one depends on, directly or transitively.
    dependency_impl_ids: tuple[TileImplId, ...]


@dataclass(frozen=True)
class TileLibrary:
    """Every TileSpec/TileImplementation available to the solver, keyed by id."""

    library_version: str
    schema_version: int

    specs: Mapping[TileSpecId, TileSpec]
    implementations: Mapping[TileImplId, TileImplementation]


# =============================================================================
# Placement
# =============================================================================


@dataclass(frozen=True)
class PlacementKey:
    """Identifies one tile placement: which implementation, where, and
    in which orientation."""

    impl_id: TileImplId

    # Tile-local origin mapped to global Cell(a0, b0).
    a0: int
    b0: int

    orientation: Orientation


@dataclass(frozen=True)
class WeightedWord:
    """One output word of a placement, positioned in the global product's
    bit weighting."""

    name: str
    width: int

    # Global product-bit weight.
    lsb_weight: int

    signedness: Signedness
    coefficient: int


@dataclass(frozen=True)
class ResolvedPlacement:
    """A PlacementKey with everything resolved against the actual board:
    its coverage mask, resource cost, and output words."""

    key: PlacementKey
    spec_id: TileSpecId

    bounding_rect: Rect
    coverage: CellMask

    a_slice: BitSlice
    b_slice: BitSlice

    required_sign_mode: SignMode
    resources: ResourceUsage

    output_terms: tuple[WeightedWord, ...]

    # -- Off-board padding: the tile's logical width minus how much of it
    # actually lands on the board. --
    pad_a: int = 0
    pad_b: int = 0

    @property
    def full_cells(self) -> int:
        """How many cells this would cover without clipping. Coverage is a
        solid rectangle, so it's just a product."""
        return ((self.bounding_rect.a_width + self.pad_a)
                * (self.bounding_rect.b_width + self.pad_b))


@dataclass(frozen=True)
class TileShape:
    """An (impl x orientation) combination, independent of board size."""
    impl_id: object
    spec_id: object
    orientation: Orientation
    local: object              # Local coverage mask, already transposed for orientation.
    a_ext: int
    b_ext: int
    impl_sign: object
    board_sign: object         # Effective sign mode after transposition.
    resources: object
