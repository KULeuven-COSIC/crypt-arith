
set pp_row1_i2 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst2"}]
set pp_row1_i3 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst3"}]
set_property LUTNM grp1_row1 $pp_row1_i2
set_property LUTNM grp1_row1 $pp_row1_i3
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row1_i2
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row1_i3


set pp_row1_i4 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst4"}]
set pp_row1_i5 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst5"}]
set_property LUTNM grp2_row1 $pp_row1_i4
set_property LUTNM grp2_row1 $pp_row1_i5
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row1_i4
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row1_i5


set pp_row2_i2 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst2"}]
set pp_row2_i3 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst3"}]
set_property LUTNM grp1_row2 $pp_row2_i2
set_property LUTNM grp1_row2 $pp_row2_i3
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row2_i2
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row2_i3


set pp_row2_i4 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst4"}]
set pp_row2_i5 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst5"}]
set_property LUTNM grp2_row2 $pp_row2_i4
set_property LUTNM grp2_row2 $pp_row2_i5
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row2_i4
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row2_i5

