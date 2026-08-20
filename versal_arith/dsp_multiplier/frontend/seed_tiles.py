# core/frontend_seed_tiles.py
"""Builds the TileLibrary the solver searches over: one TileSpec +
TileImplementation per (static tile definition x sign-mode variant),
covering the DSP58 primitive, K2/K3/Toom-2.5 macro tiles, and DSP58
cascade chains of every supported length.
"""
from __future__ import annotations

from dataclasses import dataclass, field, replace
from types import MappingProxyType

from dsp_multiplier.frontend.datamodel import (
    SignMode,
    Signedness,
    AtomicBody,
    ImplementationKind,
    ResourceUsage,
    SignCharacterization,
    TileImplementation,
    TileLibrary,
    TimingProfile,
    Orientation,
    OutputTermSpec,
    TileSpec,
    TileImplId,
    TileSpecId,
)
from dsp_multiplier.frontend.mask_ops import make_full_mask
from collections.abc import Mapping

# ---- Chain latency formula: the whole project computes this in exactly one place ----
CHAIN_BASE_LATENCY = 1        # base cycle count for a chain
CHAIN_LATENCY_PER_BLOCK = 1   # extra cycles per additional block; change this to get 3+(L-1)


def chain_latency(blocks: int,
                  base: int = CHAIN_BASE_LATENCY,
                  per_block: int = CHAIN_LATENCY_PER_BLOCK) -> int:
    """Latency of an L-block cascade chain. base+(L-1)*per_block is only the
    intent (roughly one cycle per block); the value actually returned gets
    snapped down to the nearest value <= it that's really achievable, per
    dsp_multiplier.backend.delay_model.achievable_latencies("chain", blocks).

    Why: dsp_chain's critical path isn't a smooth function of `blocks` --
    once the grouping is fine enough (the cascade delay via_z is already
    below via_m), splitting further doesn't help, so dsp_model's search
    simply never picks those cycle counts, and best_chain(budget) ends up
    returning a latency smaller than the budget. This "budget buys nothing"
    gap moves around with `blocks` and with the timing constants in
    dsp_lib.py, so there's no stable closed-form formula that dodges it
    forever (tried base+blocks//3: correct up to blocks<=13, falls back
    into the gap at 14). Querying DelayModel is the only approach that
    never goes stale -- snap downward, not upward: a latency that falls
    into the gap only ever gets the critical_ns of the last real version
    before the gap anyway, so snapping upward just spends extra registers
    for nothing.
    """
    want = base + (blocks - 1) * per_block
    import dsp_multiplier.backend.delay_model as DM
    achievable = DM.achievable_latencies("chain", blocks)
    return max((L for L in achievable if L <= want), default=achievable[0])


@dataclass(frozen=True)
class TileLatencyConfig:
    """User-facing tile latency configuration. Takes effect when the library
    is built; doesn't affect lut/bitheap/sub."""
    by_name:   Mapping[str, int] = field(default_factory=dict)  # "K2" -> 4
    by_family: Mapping[str, int] = field(default_factory=dict)  # whole-family default
    chain_base: int | None = None      # None = don't touch chains, use the library default
    chain_per_block: int = 1
    strict: bool = True                # unknown keys are a hard error

    def __post_init__(self):
        for table in (self.by_name, self.by_family):
            for key, value in table.items():
                if not isinstance(value, int) or value < 0:
                    raise ValueError(
                        f"TileLatencyConfig: latency for {key!r} must be a non-negative int, "
                        f"got {value!r}"
                    )
        if self.chain_base is not None and self.chain_base < 0:
            raise ValueError(f"chain_base must be >=0, got {self.chain_base}")
        if self.chain_per_block < 0:
            raise ValueError(
                f"chain_per_block must be >=0, got {self.chain_per_block}"
            )

    def resolve(self, definition: "StaticTileDefinition") -> int:
        """Decide how many cycles this tile ultimately gets. Highest
        priority first; returns on the first match."""
        # 1) by name, most precise
        if definition.name in self.by_name:
            return self.by_name[definition.name]
        # 2) chain formula
        if definition.chain_blocks > 1 and self.chain_base is not None:
            return chain_latency(definition.chain_blocks,
                                 self.chain_base, self.chain_per_block)
        # 3) by family
        if definition.family in self.by_family:
            return self.by_family[definition.family]
        # 4) fallback: the hardcoded default on the definition
        return definition.latency

    def validate(self, definitions) -> None:
        """When strict, check the caller didn't typo a name. Don't skip this."""
        if not self.strict:
            return
        names    = {d.name   for d in definitions}
        families = {d.family for d in definitions}
        bad_names    = set(self.by_name)   - names
        bad_families = set(self.by_family) - families
        if bad_names or bad_families:
            raise ValueError(
                f"TileLatencyConfig has keys that don't exist:\n"
                f"  unknown by_name:   {sorted(bad_names)}\n"
                f"  unknown by_family: {sorted(bad_families)}\n"
                f"  available names:   {sorted(names)}\n"
                f"  available families: {sorted(families)}"
            )

@dataclass(frozen=True)
class StaticTileDefinition:
    name: str
    family: str
    backend_key: str

    # canonical orientation: A width x B width
    a_width: int
    b_width: int

    dsp_count: int

    # Assumes the table's preadder/post-adder figures are LUT counts.
    pre_adder_lut: int
    post_adder_lut: int

    latency: int                    # this tile's DSP latency (clock cycles)
    rtl_module_name: str

    allow_transpose: bool = True
    chain_blocks: int = 1

    @property
    def total_intrinsic_lut(self) -> int:
        return self.pre_adder_lut + self.post_adder_lut

PCIN_PITCH = 23          # fixed right-shift per PCIN cascade stage = the uu variant's b width
CHAIN_MAX_BLOCKS = 11    # 256 // 23 = 11; bump this for a bigger board


def make_chain_definition(blocks: int) -> StaticTileDefinition:
    """L blocks of DSP58 cascaded head-to-tail via PCIN. Geometrically a
    solid rectangle, physical width along b = (L-1)*23 + 24 = 23L + 1."""
    return StaticTileDefinition(
        name=f"DSPChain{blocks}",
        family="versal.dsp58.chain",
        backend_key="versal_dsp58_chain",
        a_width=27,
        b_width=PCIN_PITCH * blocks + 1,
        dsp_count=blocks,
        pre_adder_lut=0,
        post_adder_lut=0,             # cascade addition uses the dedicated on-chip path, costs no LUTs
        latency=chain_latency(blocks),
        rtl_module_name="DSPChain",
        chain_blocks=blocks,
    )


CHAIN_TILE_DEFINITIONS: tuple[StaticTileDefinition, ...] = tuple(
    make_chain_definition(L) for L in range(2, CHAIN_MAX_BLOCKS + 1)
)

STATIC_TILE_DEFINITIONS: tuple[StaticTileDefinition, ...] = (
    StaticTileDefinition(
        name="DSP58",
        family="versal.dsp58",
        backend_key="versal_dsp58_signed_multiplier",
        a_width=27,
        b_width=24,
        dsp_count=1,
        pre_adder_lut=0,
        post_adder_lut=0,
        latency=3,
        rtl_module_name="SingleDSP",        # DSP58
    ),
    StaticTileDefinition(
        name="K2",
        family="versal.karatsuba2.static",
        backend_key="versal_static_k2",
        a_width=48,
        b_width=45,
        dsp_count=3,
        pre_adder_lut=24,
        post_adder_lut=76,
        latency=4,
        rtl_module_name="Karatsuba2x2",     # K2
    ),
    StaticTileDefinition(
        name="Toom-2.5",
        family="versal.toom25.static",
        backend_key="versal_static_toom25",
        a_width=65,
        b_width=47,
        dsp_count=4,
        pre_adder_lut=94,
        post_adder_lut=224,
        latency=5,
        rtl_module_name="ToomCook25",       # Toom-2.5
    ),
    StaticTileDefinition(
        name="K3",
        family="versal.karatsuba3.static",
        backend_key="versal_static_k3",
        a_width=70,
        b_width=67,
        dsp_count=6,
        pre_adder_lut=72,
        post_adder_lut=200,
        latency=5,
        rtl_module_name="Karatsuba3x3",     # K3
    ),
)

SIGN_VARIANTS = (
    SignMode(Signedness.SIGNED, Signedness.SIGNED),
    SignMode(Signedness.SIGNED, Signedness.UNSIGNED),
    SignMode(Signedness.UNSIGNED, Signedness.SIGNED),
    SignMode(Signedness.UNSIGNED, Signedness.UNSIGNED),
)


def sign_mode_code(sign_mode: SignMode) -> str:
    """SignMode -> two-letter code, e.g. "su" = A signed, B unsigned."""
    a = "s" if sign_mode.a is Signedness.SIGNED else "u"
    b = "s" if sign_mode.b is Signedness.SIGNED else "u"
    return a + b


def logical_shape(
    definition: StaticTileDefinition,
    sign_mode: SignMode,
) -> tuple[int, int]:
    """The tile's usable (a_width, b_width) for a given sign mode: an
    unsigned operand gives up its sign bit, shrinking that side by one."""
    a_width = definition.a_width
    b_width = definition.b_width

    if sign_mode.a is Signedness.UNSIGNED:
        a_width -= 1

    if sign_mode.b is Signedness.UNSIGNED:
        b_width -= 1

    return a_width, b_width


def make_static_tile_spec(
    definition: StaticTileDefinition,
    sign_mode: SignMode,
) -> TileSpec:
    """Build the logical TileSpec for one (definition, sign_mode) pair."""
    orientations = {Orientation.AB}

    a_width, b_width = logical_shape(
            definition,
            sign_mode,
    )

    if (
        definition.allow_transpose
        and definition.a_width != definition.b_width
    ):
        orientations.add(Orientation.TRANSPOSED)

    mode = sign_mode_code(sign_mode)

    spec_id = TileSpecId(
        f"mul/{mode}/{a_width}x{b_width}/v1"
    )

    return TileSpec(
        spec_id=spec_id,

        family=definition.family,

        display_name=(
            f"{definition.name} "
            f"{definition.a_width}x{definition.b_width}"
        ),

        input_sign_mode=sign_mode,

        local_coverage=make_full_mask(
            a_width=a_width,
            b_width=b_width,
        ),

        allowed_orientations=frozenset(orientations),

        outputs=(
            OutputTermSpec(
                name="product",
                width=a_width + b_width,
                local_shift=0,
                signedness=(
                    Signedness.SIGNED
                    if sign_mode.a is Signedness.SIGNED
                    or sign_mode.b is Signedness.SIGNED
                    else Signedness.UNSIGNED
                ),
                coefficient=1,
            ),
        ),

        schema_version=1,
    )


def make_static_tile_implementation(
    definition: StaticTileDefinition,
    spec: TileSpec,
    sign_mode: SignMode,
) -> TileImplementation:
    """Build the TileImplementation (resource/timing cost + RTL-generator
    parameters) matching a spec built by make_static_tile_spec."""
    mode = sign_mode_code(sign_mode)

    spec_id = spec.spec_id
    impl_id = TileImplId(
        f"{definition.family}/"
        f"{spec.local_coverage.a_extent}x"
        f"{spec.local_coverage.b_extent}/"
        f"{mode}/static/v1"
    )

    body = AtomicBody(
        backend_key=definition.backend_key,
        parameters=(
            ("tile_name", definition.name),
            ("rtl_module_name", definition.rtl_module_name),

            ("physical_a_width", definition.a_width),
            ("physical_b_width", definition.b_width),

            (
                "zero_extend_a",
                sign_mode.a is Signedness.UNSIGNED,
            ),
            (
                "zero_extend_b",
                sign_mode.b is Signedness.UNSIGNED,
            ),
            ("chain_blocks", definition.chain_blocks),
            ("pcin_pitch", PCIN_PITCH if definition.chain_blocks > 1 else 0),
            ("opaque_to_tiler", True),
        )
    )

    sign_profile = SignCharacterization(
        sign_mode=sign_mode,
        resources=ResourceUsage(
            dsp=definition.dsp_count,
            intrinsic_lut=definition.total_intrinsic_lut,
            ff=None,
        ),
        timing=TimingProfile(
            latency_cycles=definition.latency,
            initiation_interval=1,
            fmax_mhz=None,
        ),
    )

    return TileImplementation(
        spec_id=spec_id,
        impl_id=impl_id,

        # As far as the current tiler is concerned, this is an atomic tile
        # that cannot be expanded further.
        kind=ImplementationKind.ATOMIC,
        body=body,

        target_architecture="amd_versal",

        sign_profiles=(sign_profile,),

        dependency_impl_ids=(),
    )

def build_static_seed_library(include_chains: bool = True,
                              definitions=None,
                              latency: TileLatencyConfig | None = None) -> TileLibrary:
    """Build the full TileLibrary: one spec + implementation per
    (definition, sign-mode variant). `definitions` defaults to every
    static tile plus (if include_chains) every chain length; pass an
    explicit subset to build a smaller library instead. `latency`
    optionally overrides individual tiles'/families' cycle counts."""
    specs: dict[TileSpecId, TileSpec] = {}
    implementations: dict[
        TileImplId,
        TileImplementation,
    ] = {}

    if definitions is None:
        definitions = STATIC_TILE_DEFINITIONS
        if include_chains:
            definitions = definitions + CHAIN_TILE_DEFINITIONS

    if latency is not None:
        latency.validate(definitions)
        definitions = tuple(
            replace(d, latency=latency.resolve(d)) for d in definitions
        )

    for definition in definitions:
        for sign_mode in SIGN_VARIANTS:
            spec = make_static_tile_spec(
                definition,
                sign_mode,
            )

            implementation = (
                make_static_tile_implementation(
                    definition,
                    spec,
                    sign_mode,
                )
            )

            if spec.spec_id in specs:
                raise ValueError(
                    f"Duplicate spec ID: {spec.spec_id}"
                )

            if implementation.impl_id in implementations:
                raise ValueError(
                    "Duplicate implementation ID: "
                    f"{implementation.impl_id}"
                )

            specs[spec.spec_id] = spec
            implementations[implementation.impl_id] = implementation

    return TileLibrary(
        library_version="versal-static-seed-v1",
        schema_version=1,
        specs=MappingProxyType(specs),
        implementations=MappingProxyType(
            implementations
        ),
    )

def oriented_sign_mode(
    sign_mode: SignMode,
    orientation: Orientation,
) -> SignMode:
    """The effective sign mode after applying an orientation (TRANSPOSED
    swaps which operand is A and which is B)."""
    if orientation is Orientation.AB:
        return sign_mode

    if orientation is Orientation.TRANSPOSED:
        return SignMode(
            a=sign_mode.b,
            b=sign_mode.a,
        )

    raise ValueError(
        f"Unsupported orientation: {orientation}"
    )

def print_tile_latency(lib) -> None:
    """Print how many cycles each tile ended up with, to confirm the
    configuration actually took effect."""
    seen: dict[str, int] = {}
    for impl in lib.implementations.values():
        name = dict(impl.body.parameters).get("tile_name", "?")
        seen.setdefault(name, impl.sign_profiles[0].timing.latency_cycles)
    for name in sorted(seen, key=lambda s: (len(s), s)):
        print(f"{name:12s} lat={seen[name]}")


def tile_latency_of(impl) -> int:
    """Read latency off a TileImplementation. Raises rather than silently
    defaulting to 0 when it can't."""
    cycles = impl.sign_profiles[0].timing.latency_cycles
    if cycles is None:
        raise ValueError(
            f"{impl.impl_id}: TimingProfile.latency_cycles is None; "
            "the tile library must provide a latency"
        )
    return cycles
