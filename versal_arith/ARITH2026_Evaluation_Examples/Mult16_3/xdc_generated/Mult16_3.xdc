
### constraints for c9_41_l0_c2_i3 ###
set lut_hi_l0_c2_i3 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_c2_i3/LUT3_inst0"}]
set lut_lo_l0_c2_i3 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_c2_i3/LUT3_inst1"}]
set_property LUTNM grp_l0_c2_i3 $lut_hi_l0_c2_i3
set_property LUTNM grp_l0_c2_i3 $lut_lo_l0_c2_i3


### constraints for c9_41_l0_f4 ###
set lut_hi_l0_f4 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_f4/LUT3_inst0"}]
set lut_lo_l0_f4 [get_cells -hier -filter {NAME =~ "*/c9_41_l0_f4/LUT3_inst1"}]
set_property LUTNM grp_l0_f4 $lut_hi_l0_f4
set_property LUTNM grp_l0_f4 $lut_lo_l0_f4


