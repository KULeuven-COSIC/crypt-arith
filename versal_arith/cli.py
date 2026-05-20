import argparse
import os
import shutil

from bitheap import BitHeap
from counter import Counter
from heuristic import compressAll, formGPCChain, merge_last_stage
from rtl_gen import (
    Bmult_RTL_gen,
    Cmult_RTL_gen,
    Cmultbank_RTL_gen,
    compressor_RTL_gen,
    read_nonneg_int_list,
    reg_flag_list_gen,
)

DEFAULT_OUTPUT_DIR = "versal_arith_generated"


def _str2bool(s):
    """Robust string-to-bool for argparse — argparse's built-in type=bool
    silently turns every non-empty string (including "False") into True
    because bool("False") is True. Use this instead."""
    if isinstance(s, bool):
        return s
    if s.lower() in ("true", "1", "yes", "y", "t"):
        return True
    if s.lower() in ("false", "0", "no", "n", "f"):
        return False
    raise argparse.ArgumentTypeError(f"expected boolean, got {s!r}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description="""\
Versal Arithmetic RTL Generator
================================

Generates synthesizable SystemVerilog for arithmetic operators
targeting AMD Versal FPGAs (Versal LUT + LOOKAHEAD8 primitives).

Supported operators (-operator):

  cmp        Compressor Tree using Generalized Parallel Counters (GPCs)
  bmult      Radix-4 Booth Tree Multiplier on LUTs (signed, >= 6-bit)
  cmult      Constant Multiplier using shifts and adds (A * constant C)
  cmultbank  Bank of N parallel constant multipliers (one per line in a
             file). Use this for any parallel constant-multiply array,
             including NTT pre-twist / post-twist banks.
  clean      Remove all generated files in the output directory

NAF modulus lifting (-modulus):
  Optional. By default the generator runs vanilla NAF on each constant.
  Pass -modulus q to ask the generator to find a sparser-NAF equivalent
  c' ≡ c (mod q) before generation; the produced multiplier computes
  A * c' (which is congruent to A * c mod q, but typically much cheaper
  in LUTs since c' has 2-4 NAF terms instead of ~21 for full-width
  Goldilocks values). If you have already pre-lifted your constants, just
  omit -modulus and the generator uses them as-is.

  Lift parameters (only consulted when -modulus is set):
    -lift_max_pow      cap on NAF exponents in the lifted form (def 96)
    -lift_max_shift    how far q can be shifted during search   (def 32)
    -lift_depth        beam-search iterations                   (def 3)
    -lift_beam         beam width                               (def 200)

Examples:
  python cli.py -operator cmp       -txt_file_name bitheap.txt -pipeline_stages 1
  python cli.py -operator bmult     -width_a 16 -width_b 16
  python cli.py -operator cmult     -width_a 24 -constant 12345
  python cli.py -operator cmult     -width_a 16 -powers "10,5,-3"
  python cli.py -operator cmult     -width_a 24 -constant 13797081185216407910 \\
                                    -modulus  18446744069414584321
  python cli.py -operator cmultbank -txt_file_name constants.txt -width_a 24
  python cli.py -operator cmultbank -txt_file_name constants.txt -width_a 24 \\
                                    -modulus 18446744069414584321
  python cli.py -operator clean
""")

    # --- Operator selection ---
    parser.add_argument("-operator", type=str, default="bmult",
        help="operator to generate: cmp, bmult, cmult, cmultbank, or clean (default: bmult)")

    # --- Common arguments ---
    parser.add_argument("-pipeline_stages", type=int, default=1,
        help="number of pipeline stages; 0 = pure combinational (default: 1)")
    parser.add_argument("-gen_testbench", type=_str2bool, default=True,
        help="generate testbench and test vectors (default: True)")
    parser.add_argument("-test_size", type=int, default=1000,
        help="number of random test vectors (default: 1000)")
    parser.add_argument("-visualization", type=_str2bool, default=True,
        help="generate bitheap compression PNG visualizations (default: True)")
    parser.add_argument("-output_dir", type=str, default=DEFAULT_OUTPUT_DIR,
        help=f"output directory for all generated files (default: {DEFAULT_OUTPUT_DIR})")

    # --- Compressor tree (cmp) arguments ---
    parser.add_argument("-txt_file_name", type=str, default="bitheap.txt",
        help="[cmp/cmultbank] input file (default: bitheap.txt)")
    parser.add_argument("-sv_file_name", type=str, default="bitheap_cmp",
        help="[cmp] output SystemVerilog file name (default: bitheap_cmp)")
    parser.add_argument("-cmp_module_name", type=str, default="bitheap_cmp",
        help="[cmp] compressor module name (default: bitheap_cmp)")
    parser.add_argument("-tb_out_width", type=int, default=44,
        help="[cmp] output bit-width tested in the testbench (default: 44)")

    # --- Booth multiplier (bmult) arguments ---
    parser.add_argument("-width_a", type=int, default=8,
        help="[bmult/cmult/cmultbank] bit-width of input operand A (default: 8)")
    parser.add_argument("-width_b", type=int, default=8,
        help="[bmult] bit-width of input operand B (default: 8)")

    # --- Constant multiplier (cmult / cmultbank) arguments ---
    parser.add_argument("-constant", type=int, default=None,
        help="[cmult] constant value to multiply by; decomposed via NAF")
    parser.add_argument("-powers", type=str, default=None,
        help='[cmult] signed power-of-2 exponents, e.g. "10,5,-3" = +2^10 + 2^5 - 2^3 '
             '(NAF lifting is bypassed when this is used; you supply the powers directly)')
    parser.add_argument("-modulus", type=int, default=None,
        help="[cmult/cmultbank] optional modulus q; if set, each constant c is "
             "replaced by a sparser-NAF c' with c' ≡ c (mod q) before generation. "
             "Omit to feed your constants in verbatim.")
    parser.add_argument("-signed_input", type=_str2bool, default=False,
        help="[cmult/cmultbank] treat input A as signed two's complement (default: False)")

    # --- NAF modulus-lift parameters (only consulted when -modulus is set) ---
    parser.add_argument("-lift_max_pow", type=int, default=96,
        help="[cmult/cmultbank, with -modulus] cap on NAF exponents in the lifted form (default: 96)")
    parser.add_argument("-lift_max_shift", type=int, default=32,
        help="[cmult/cmultbank, with -modulus] max shift t such that q*2^t may enter the search frontier (default: 32)")
    parser.add_argument("-lift_depth", type=int, default=3,
        help="[cmult/cmultbank, with -modulus] beam-search iterations (default: 3)")
    parser.add_argument("-lift_beam", type=int, default=200,
        help="[cmult/cmultbank, with -modulus] beam width (default: 200)")

    args = parser.parse_args()

    # --- clean operator ---
    if args.operator == "clean":
        if os.path.isdir(args.output_dir):
            shutil.rmtree(args.output_dir)
            print(f"Removed {args.output_dir}/")
        else:
            print(f"Nothing to clean: {args.output_dir}/ does not exist.")
        exit(0)

    # Validate operator early so unknown names fail before any directory work.
    valid_ops = {"cmp", "bmult", "cmult", "cmultbank"}
    if args.operator not in valid_ops:
        parser.error(f"Unknown operator: {args.operator!r} (valid: {sorted(valid_ops)})")

    # Warn when lift parameters are non-default but no modulus is set.
    if args.modulus is None:
        if (args.lift_max_pow != 96 or args.lift_max_shift != 32
                or args.lift_depth != 3 or args.lift_beam != 200):
            print("[cli] note: -lift_* parameters are only consulted when -modulus is set; ignoring.")

    # Resolve txt_file_name to absolute path before chdir.
    if args.operator in ("cmp", "cmultbank"):
        args.txt_file_name = os.path.abspath(args.txt_file_name)

    # Determine run-specific subdirectory name.
    if args.operator == "bmult":
        run_name = f"Bmult{args.width_a}x{args.width_b}"
    elif args.operator == "cmult":
        if args.constant is not None:
            run_name = f"Cmult_{args.width_a}x{args.constant}"
        elif args.powers is not None:
            run_name = f"Cmult_{args.width_a}_pw"
        else:
            run_name = "Cmult"
    elif args.operator == "cmp":
        run_name = args.sv_file_name
    elif args.operator == "cmultbank":
        run_name = "cmultbank"

    # All generated files go into output_dir/run_name/
    run_dir = os.path.join(args.output_dir, run_name)
    os.makedirs(run_dir, exist_ok=True)
    os.chdir(run_dir)

    if args.operator == "bmult":
        Bmult_RTL_gen(width_a=args.width_a,
                      width_b=args.width_b,
                      pipeline_stages=args.pipeline_stages,
                      gen_testbenches=args.gen_testbench,
                      test_size=args.test_size)

    elif args.operator == "cmp":
        number_list = read_nonneg_int_list(args.txt_file_name)
        number_of_columns = len(number_list)
        sum_max = 0
        for col in range(number_of_columns):
            sum_max += number_list[col] * (2 ** col)
        width_bh = sum_max.bit_length()
        bh_layer_cal = BitHeap(width_bh, 0)
        for col in range(number_of_columns):
            bh_layer_cal.add_bits(col, number_list[col])
        last_compression_layer_bitheap, raw_counter_list = compressAll(bh_layer_cal, 0, width_bh - 1, False, False)
        counter_list = formGPCChain(raw_counter_list)
        number_of_layers = len(counter_list)
        if number_of_layers >= 2:
            merge_flag_temp, reduced_inputs = merge_last_stage(
                last_compression_layer_counter_list=counter_list[-1],
                last_compression_layer_bitheap=last_compression_layer_bitheap)
        else:
            merge_flag_temp = False
        if merge_flag_temp:
            number_of_layers -= 1
        number_of_layers += 1
        reg_flag_list = reg_flag_list_gen(pipeline_stages=args.pipeline_stages,
                                          num_layers=number_of_layers)
        compressor_RTL_gen(txt_file_name=args.txt_file_name,
                           sv_file_name=args.sv_file_name,
                           compressor_module_name=args.cmp_module_name,
                           visualization=args.visualization,
                           tb_out_width=args.tb_out_width,
                           gen_testbench=args.gen_testbench,
                           test_size=args.test_size,
                           reg_flag_list=reg_flag_list)

    elif args.operator == "cmult":
        pw = None
        if args.powers is not None:
            pw = [int(x.strip()) for x in args.powers.split(",")]
        Cmult_RTL_gen(width_a=args.width_a,
                      constant=args.constant,
                      powers=pw,
                      modulus=args.modulus,
                      pipeline_stages=args.pipeline_stages,
                      gen_testbenches=args.gen_testbench,
                      test_size=args.test_size,
                      signed_input=args.signed_input,
                      lift_max_pow=args.lift_max_pow,
                      lift_max_shift=args.lift_max_shift,
                      lift_depth=args.lift_depth,
                      lift_beam=args.lift_beam)

    elif args.operator == "cmultbank":
        Cmultbank_RTL_gen(txt_file_name=args.txt_file_name,
                          width_a=args.width_a,
                          pipeline_stages=args.pipeline_stages,
                          gen_testbenches=args.gen_testbench,
                          test_size=args.test_size,
                          signed_input=args.signed_input,
                          modulus=args.modulus,
                          lift_max_pow=args.lift_max_pow,
                          lift_max_shift=args.lift_max_shift,
                          lift_depth=args.lift_depth,
                          lift_beam=args.lift_beam)

    print(f"\nOutput written to: {run_dir}/")
