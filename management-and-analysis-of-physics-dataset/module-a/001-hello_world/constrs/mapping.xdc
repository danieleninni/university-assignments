## RGB LEDs
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { led_out }]; #IO_L18N_T2_35 Sch=led0_b

## Buttons
set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { btn_in }]; #IO_L6N_T0_VREF_16 Sch=btn[0]