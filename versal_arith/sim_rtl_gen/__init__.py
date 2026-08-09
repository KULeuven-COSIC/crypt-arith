"""Simulation-only behavioral RTL backend for the Goldilocks NTT butterfly /
pipeline. Mirrors the hw `rtl_gen` package's two public entry points
(`Butterfly_RTL_gen` / `NTT_RTL_gen`) so the operator_modeling `emitRtl` methods
can pick a backend via a `backend='sim'` kwarg.

The sim backend consumes the exact same `ButterflyOperatorSpec` /
`NTTOperatorSpec` dataclasses and writes byte-identical testvector files,
so it is a drop-in faster-sim substitute for the hw backend. Each butterfly
body is a `+/-` sum of signed-shifted-sliced terms taken straight from the
spec; no compressor trees, no GPC primitives, no bit-heap intermediate files.
"""
