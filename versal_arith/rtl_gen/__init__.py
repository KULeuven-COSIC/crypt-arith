"""RTL generation sub-package for versal_arith.

Re-exports all public functions for backward compatibility.
"""

from rtl_gen.utils import (
    width_expr,
    read_nonneg_int_list,
    gen_bitheap_testvectors,
    to_twos_complement_hex,
)
from rtl_gen.lookahead import LOOKAHEAD8_gen, analyze_subchain
from rtl_gen.chain import chain_gen
from rtl_gen.floating_gpc import floatingGPC_gen, floatingGPC_placement
from rtl_gen.layer import layer_admin, assignment_gen, layer_gen
from rtl_gen.terminal_add import terminalAdd_gen
from rtl_gen.compressor import reg_flag_list_gen, compressor_gen, compressor_RTL_gen
from rtl_gen.booth_mult import Bmult_bitheap_RTL_gen, gen_Bmult_testvectors, Bmult_RTL_gen
from rtl_gen.const_mult import Cmult_RTL_gen, Cmultbank_RTL_gen
from rtl_gen.butterfly import Butterfly_RTL_gen
