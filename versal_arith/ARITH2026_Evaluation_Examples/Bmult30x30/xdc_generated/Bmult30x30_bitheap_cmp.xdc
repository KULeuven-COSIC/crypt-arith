
### constraints for c9_41_l0_c3_i8 ###
set lut_hi_l0_c3_i8 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_c3_i8/LUT3_inst0"}]
set lut_lo_l0_c3_i8 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_c3_i8/LUT3_inst1"}]
set_property LUTNM grp_l0_c3_i8 $lut_hi_l0_c3_i8
set_property LUTNM grp_l0_c3_i8 $lut_lo_l0_c3_i8


### constraints for c9_41_l0_f7 ###
set lut_hi_l0_f7 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_f7/LUT3_inst0"}]
set lut_lo_l0_f7 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_f7/LUT3_inst1"}]
set_property LUTNM grp_l0_f7 $lut_hi_l0_f7
set_property LUTNM grp_l0_f7 $lut_lo_l0_f7



### constraints for c9_41_l0_f9 ###
set lut_hi_l0_f9 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_f9/LUT3_inst0"}]
set lut_lo_l0_f9 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_f9/LUT3_inst1"}]
set_property LUTNM grp_l0_f9 $lut_hi_l0_f9
set_property LUTNM grp_l0_f9 $lut_lo_l0_f9


