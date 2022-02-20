## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

## Switches
set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { updown }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { double_freq }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { half_freq }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { freeze }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]

## RGB LEDs
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { y_out[0] }]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { y_out[1] }]; #IO_L20P_T3_35 Sch=led1_b
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { y_out[2] }]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { y_out[3] }]; #IO_L23P_T3_35 Sch=led3_b

## Buttons
set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L6N_T0_VREF_16 Sch=btn[0]