
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


set pp_row1_i10 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst10"}]
set pp_row1_i11 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst11"}]
set_property LUTNM grp5_row1 $pp_row1_i10
set_property LUTNM grp5_row1 $pp_row1_i11
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row1_i10
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row1_i11


set pp_row1_i12 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst12"}]
set pp_row1_i13 [get_cells -hier -filter {NAME =~ "*/LUT5_row1_inst13"}]
set_property LUTNM grp6_row1 $pp_row1_i12
set_property LUTNM grp6_row1 $pp_row1_i13
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row1_i12
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row1_i13


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


set pp_row2_i10 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst10"}]
set pp_row2_i11 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst11"}]
set_property LUTNM grp5_row2 $pp_row2_i10
set_property LUTNM grp5_row2 $pp_row2_i11
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row2_i10
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row2_i11


set pp_row2_i12 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst12"}]
set pp_row2_i13 [get_cells -hier -filter {NAME =~ "*/LUT5_row2_inst13"}]
set_property LUTNM grp6_row2 $pp_row2_i12
set_property LUTNM grp6_row2 $pp_row2_i13
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row2_i12
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row2_i13


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


set pp_row3_i10 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst10"}]
set pp_row3_i11 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst11"}]
set_property LUTNM grp5_row3 $pp_row3_i10
set_property LUTNM grp5_row3 $pp_row3_i11
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row3_i10
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row3_i11


set pp_row3_i12 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst12"}]
set pp_row3_i13 [get_cells -hier -filter {NAME =~ "*/LUT5_row3_inst13"}]
set_property LUTNM grp6_row3 $pp_row3_i12
set_property LUTNM grp6_row3 $pp_row3_i13
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row3_i12
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row3_i13


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


set pp_row4_i10 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst10"}]
set pp_row4_i11 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst11"}]
set_property LUTNM grp5_row4 $pp_row4_i10
set_property LUTNM grp5_row4 $pp_row4_i11
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row4_i10
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row4_i11


set pp_row4_i12 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst12"}]
set pp_row4_i13 [get_cells -hier -filter {NAME =~ "*/LUT5_row4_inst13"}]
set_property LUTNM grp6_row4 $pp_row4_i12
set_property LUTNM grp6_row4 $pp_row4_i13
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row4_i12
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row4_i13


set pp_row5_i2 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst2"}]
set pp_row5_i3 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst3"}]
set_property LUTNM grp1_row5 $pp_row5_i2
set_property LUTNM grp1_row5 $pp_row5_i3
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row5_i2
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row5_i3


set pp_row5_i4 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst4"}]
set pp_row5_i5 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst5"}]
set_property LUTNM grp2_row5 $pp_row5_i4
set_property LUTNM grp2_row5 $pp_row5_i5
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row5_i4
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row5_i5


set pp_row5_i6 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst6"}]
set pp_row5_i7 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst7"}]
set_property LUTNM grp3_row5 $pp_row5_i6
set_property LUTNM grp3_row5 $pp_row5_i7
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row5_i6
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row5_i7


set pp_row5_i8 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst8"}]
set pp_row5_i9 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst9"}]
set_property LUTNM grp4_row5 $pp_row5_i8
set_property LUTNM grp4_row5 $pp_row5_i9
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row5_i8
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row5_i9


set pp_row5_i10 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst10"}]
set pp_row5_i11 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst11"}]
set_property LUTNM grp5_row5 $pp_row5_i10
set_property LUTNM grp5_row5 $pp_row5_i11
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row5_i10
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row5_i11


set pp_row5_i12 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst12"}]
set pp_row5_i13 [get_cells -hier -filter {NAME =~ "*/LUT5_row5_inst13"}]
set_property LUTNM grp6_row5 $pp_row5_i12
set_property LUTNM grp6_row5 $pp_row5_i13
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row5_i12
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row5_i13


set pp_row6_i2 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst2"}]
set pp_row6_i3 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst3"}]
set_property LUTNM grp1_row6 $pp_row6_i2
set_property LUTNM grp1_row6 $pp_row6_i3
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row6_i2
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row6_i3


set pp_row6_i4 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst4"}]
set pp_row6_i5 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst5"}]
set_property LUTNM grp2_row6 $pp_row6_i4
set_property LUTNM grp2_row6 $pp_row6_i5
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row6_i4
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row6_i5


set pp_row6_i6 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst6"}]
set pp_row6_i7 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst7"}]
set_property LUTNM grp3_row6 $pp_row6_i6
set_property LUTNM grp3_row6 $pp_row6_i7
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row6_i6
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row6_i7


set pp_row6_i8 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst8"}]
set pp_row6_i9 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst9"}]
set_property LUTNM grp4_row6 $pp_row6_i8
set_property LUTNM grp4_row6 $pp_row6_i9
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row6_i8
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row6_i9


set pp_row6_i10 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst10"}]
set pp_row6_i11 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst11"}]
set_property LUTNM grp5_row6 $pp_row6_i10
set_property LUTNM grp5_row6 $pp_row6_i11
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row6_i10
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row6_i11


set pp_row6_i12 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst12"}]
set pp_row6_i13 [get_cells -hier -filter {NAME =~ "*/LUT5_row6_inst13"}]
set_property LUTNM grp6_row6 $pp_row6_i12
set_property LUTNM grp6_row6 $pp_row6_i13
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A5} $pp_row6_i12
# set_property LOCK_PINS {I0:A1 I1:A2 I2:A3 I3:A4 I4:A6} $pp_row6_i13

