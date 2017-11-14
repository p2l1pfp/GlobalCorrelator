set_property PACKAGE_PIN AU15 [get_ports sys_clk_p]
set_property PACKAGE_PIN AV15 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS [get_ports sys_clk_p]
set_property IOSTANDARD LVDS [get_ports sys_clk_n]
set_property DIFF_TERM TRUE [get_ports sys_clk_p]
create_clock -name sys_clk -period 5 -waveform {0 2.5} [get_ports sys_clk_p]

