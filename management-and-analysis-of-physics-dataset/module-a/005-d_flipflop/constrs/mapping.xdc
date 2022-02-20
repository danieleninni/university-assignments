## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

## Switches
set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { d }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]

## RGB LEDs
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { q }]; #IO_L18N_T2_35 Sch=led0_b

## Buttons
set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L6N_T0_VREF_16 Sch=btn[0]