"""CLI orchestration for the DSP/LUT multiplier pipeline."""

from pathlib import Path


def run_dsp_multiplier(args, parser):
    """Run the combined DSP-multiplier frontend/backend pipeline."""
    from dsp_multiplier.frontend.datamodel import Signedness
    from dsp_multiplier.frontend.reports import build_lut_report
    from dsp_multiplier.frontend.solver.solve import solve_grid_top
    from dsp_multiplier.frontend.storage import load_bundle, save_bundle
    from rtl_gen.dsp_multiplier.pipeline import (
        CLOCK_PERIOD_MARGIN,
        build_final_module,
        default_out_dir,
        generate_evaluation,
        generate_rtl,
    )

    run_frontend = args.frontend
    run_backend = args.backend
    dsp_output_dir = Path(args.output_dir) / "dspmult"
    default_bundle_dir = dsp_output_dir / "bundles"
    rtl_output_dir = dsp_output_dir / "rtl"
    if not run_frontend and not run_backend:
        run_frontend = True
        run_backend = True

    if run_frontend and args.budget is None:
        parser.error("-operator dspmult frontend requires -budget")
    if run_backend and not args.rtl and not args.evaluate:
        parser.error(
            "-operator dspmult backend requires -rtl and/or -evaluate"
        )
    if not run_frontend and args.bundle is None:
        parser.error("-operator dspmult -backend requires -bundle")
    if args.width_a <= 0 or args.width_b <= 0:
        parser.error("-width_a and -width_b must be greater than zero")
    if args.budget is not None and args.budget <= 0:
        parser.error("-budget must be greater than zero")
    if args.latency_budget is not None and args.latency_budget <= 0:
        parser.error("-latency_budget must be greater than zero")
    if args.clock_period_ns is not None and args.clock_period_ns <= 0:
        parser.error("-clock_period_ns must be greater than zero")

    signs = {
        "signed": Signedness.SIGNED,
        "unsigned": Signedness.UNSIGNED,
    }
    node = report = None
    bundle_path = Path(args.bundle) if args.bundle is not None else None

    if run_frontend:
        a_sign = signs[args.a_sign]
        b_sign = signs[args.b_sign]
        print(
            f"=== Solving {args.width_a}x{args.width_b} "
            f"[{a_sign.value}/{b_sign.value}] budget={args.budget} ==="
        )
        result = solve_grid_top(
            args.width_a,
            args.width_b,
            a_sign,
            b_sign,
            args.budget,
        )
        if result is None:
            print("No feasible solution within budget.")
            return 1

        cost, node = result
        report = build_lut_report(node)
        print(f"best cost={cost}")

        if bundle_path is None:
            sign_code = (
                ("s" if a_sign is Signedness.SIGNED else "u")
                + ("s" if b_sign is Signedness.SIGNED else "u")
            )
            bundle_path = default_bundle_dir / (
                f"sol_{args.width_a}x{args.width_b}_{sign_code}_"
                f"{args.budget}dsp.json"
            )
        bundle_path.parent.mkdir(parents=True, exist_ok=True)
        save_bundle(str(bundle_path), node, report)
        print(f"Solution bundle saved to {bundle_path.resolve()}")

    if not run_backend:
        return 0

    if node is None:
        node, report = load_bundle(str(bundle_path))

    module, worst_ns = build_final_module(
        node,
        report,
        latency_budget=args.latency_budget,
    )
    out_dir = default_out_dir(
        rtl_output_dir, bundle_path.stem, module
    )
    clock_period_ns = (
        args.clock_period_ns
        if args.clock_period_ns is not None
        else worst_ns * CLOCK_PERIOD_MARGIN
    )

    if args.clock_period_ns is None:
        print(
            "\nNo -clock_period_ns given: deriving the evaluation clock "
            f"from {worst_ns:.3f} ns * {CLOCK_PERIOD_MARGIN} "
            f"= {clock_period_ns:.3f} ns"
        )

    if args.rtl:
        generate_rtl(module, out_dir)
    if args.evaluate:
        generate_evaluation(
            module,
            out_dir,
            test_size=args.test_size,
            seed=args.seed,
            clock_period_ns=clock_period_ns,
        )
    return 0
