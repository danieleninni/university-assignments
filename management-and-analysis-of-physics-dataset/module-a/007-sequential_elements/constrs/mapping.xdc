## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

## Switches
set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { a_in }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { ab_in }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]

## RGB LEDs
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { cmb_out }]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { ltch_out }]; #IO_L21P_T3_DQS_35 Sch=led1_g
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { ff_out }]; #IO_L22P_T3_35 Sch=led2_r

## Buttons
set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L6N_T0_VREF_16 Sch=btn[0]