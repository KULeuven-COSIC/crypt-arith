
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


set pp_row1_i6 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst6"}]
set pp_row1_i7 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst7"}]
set_property LUTNM grp3_row1 $pp_row1_i6
set_property LUTNM grp3_row1 $pp_row1_i7
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row1_i6
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row1_i7


set pp_row1_i8 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst8"}]
set pp_row1_i9 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst9"}]
set_property LUTNM grp4_row1 $pp_row1_i8
set_property LUTNM grp4_row1 $pp_row1_i9
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row1_i8
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row1_i9


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


set pp_row2_i6 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst6"}]
set pp_row2_i7 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst7"}]
set_property LUTNM grp3_row2 $pp_row2_i6
set_property LUTNM grp3_row2 $pp_row2_i7
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row2_i6
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row2_i7


set pp_row2_i8 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst8"}]
set pp_row2_i9 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst9"}]
set_property LUTNM grp4_row2 $pp_row2_i8
set_property LUTNM grp4_row2 $pp_row2_i9
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row2_i8
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row2_i9


set pp_row3_i2 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst2"}]
set pp_row3_i3 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst3"}]
set_property LUTNM grp1_row3 $pp_row3_i2
set_property LUTNM grp1_row3 $pp_row3_i3
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row3_i2
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row3_i3


set pp_row3_i4 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst4"}]
set pp_row3_i5 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst5"}]
set_property LUTNM grp2_row3 $pp_row3_i4
set_property LUTNM grp2_row3 $pp_row3_i5
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row3_i4
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row3_i5


set pp_row3_i6 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst6"}]
set pp_row3_i7 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst7"}]
set_property LUTNM grp3_row3 $pp_row3_i6
set_property LUTNM grp3_row3 $pp_row3_i7
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row3_i6
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row3_i7


set pp_row3_i8 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst8"}]
set pp_row3_i9 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst9"}]
set_property LUTNM grp4_row3 $pp_row3_i8
set_property LUTNM grp4_row3 $pp_row3_i9
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row3_i8
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row3_i9


set pp_row4_i2 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst2"}]
set pp_row4_i3 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst3"}]
set_property LUTNM grp1_row4 $pp_row4_i2
set_property LUTNM grp1_row4 $pp_row4_i3
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row4_i2
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row4_i3


set pp_row4_i4 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst4"}]
set pp_row4_i5 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst5"}]
set_property LUTNM grp2_row4 $pp_row4_i4
set_property LUTNM grp2_row4 $pp_row4_i5
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row4_i4
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row4_i5


set pp_row4_i6 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst6"}]
set pp_row4_i7 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst7"}]
set_property LUTNM grp3_row4 $pp_row4_i6
set_property LUTNM grp3_row4 $pp_row4_i7
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row4_i6
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row4_i7


set pp_row4_i8 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst8"}]
set pp_row4_i9 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst9"}]
set_property LUTNM grp4_row4 $pp_row4_i8
set_property LUTNM grp4_row4 $pp_row4_i9
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row4_i8
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row4_i9

