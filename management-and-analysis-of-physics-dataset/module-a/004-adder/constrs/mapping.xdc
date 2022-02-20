## Switches
set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { b_in[0] }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { b_in[1] }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { b_in[2] }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { b_in[3] }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]

## RGB LEDs
set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { y_out[0] }]; #IO_L19N_T3_VREF_35 Sch=led0_g
set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { y_out[1] }]; #IO_L21P_T3_DQS_35 Sch=led1_g
set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { y_out[2] }]; #IO_L22N_T3_35 Sch=led2_g
set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { y_out[3] }]; #IO_L24P_T3_35 Sch=led3_g

## LEDs
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { y_out[4] }]; #IO_L24N_T3_35 Sch=led[4]

## Buttons
set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { a_in[0] }]; #IO_L6N_T0_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { a_in[1] }]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { a_in[2] }]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { a_in[3] }]; #IO_L12P_T1_MRCC_16 Sch=btn[3]