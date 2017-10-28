create_project test_bram ../vivado/test_bram_prj -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]
create_bd_design "test_bram_hw"
set_property ip_repo_paths [list ../example_transfer/basic_bram_prj/solution1/impl/ip/ timer_subsystem/] [current_fileset]
update_ip_catalog

puts "Building Full System"

# clear
set list [get_bd_intf_nets]
foreach item $list {
    delete_bd_objs [get_bd_intf_nets $item]
}
set list [get_bd_nets]
foreach item $list {
    delete_bd_objs [get_bd_nets $item]
}
set list [get_bd_cells]
foreach item $list {
    delete_bd_objs [get_bd_cells $item]
}
set list [get_bd_intf_ports]
foreach item $list {
    delete_bd_objs [get_bd_intf_ports $item]
}
#########
#Zynq PS                                
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7
set_property -dict [list CONFIG.preset {ZedBoard}] [get_bd_cells processing_system7]
set_property -dict [list CONFIG.PCW_USE_S_AXI_ACP {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0} CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1}] [get_bd_cells processing_system7]
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "0" }  [get_bd_cells processing_system7]

#timer
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer

# next, do the control interconnect
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 control_interconnect
set_property -dict [ list CONFIG.NUM_MI {3} CONFIG.NUM_SI {1}  ] [get_bd_cell control_interconnect]

# add a system reset controller
set proc_sys_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset ]

# combine individual interrupt bits to form a bus to make connection with the Zynq_PS
#    default values are sufficient - 2 single signal inputs into one two bit bus
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 coalesce_interrupts

# add in the timer IP
create_bd_cell -type ip -vlnv user.org:user:timer_subsystem:1.3 timer_subsystem_0
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 sw_trig_isolator
set_property -dict [list CONFIG.DIN_WIDTH {64} CONFIG.DIN_TO {0} CONFIG.DIN_FROM {0}] [get_bd_cells sw_trig_isolator]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 reset_isolator
set_property -dict [list CONFIG.DIN_WIDTH {64} CONFIG.DIN_TO {2} CONFIG.DIN_FROM {2}] [get_bd_cells reset_isolator]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 OE_high_low_selector
set_property -dict [list CONFIG.DIN_WIDTH {64} CONFIG.DIN_TO {1} CONFIG.DIN_FROM {1}] [get_bd_cells OE_high_low_selector]
# into PS
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 push_data_to_upper_32_bits
set_property -dict [list CONFIG.IN0_WIDTH {32} CONFIG.IN1_WIDTH {32}] [get_bd_cells push_data_to_upper_32_bits]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
set_property -dict [list CONFIG.CONST_WIDTH {32} CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]
# add in and configure the VIO
create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0
set_property -dict [list CONFIG.C_PROBE_IN0_WIDTH {64} CONFIG.C_NUM_PROBE_OUT {0}] [get_bd_cells vio_0]

#DNN
create_bd_cell -type ip -vlnv xilinx.com:hls:basic_bram:1.0 basic_bram

# connections to Everything!!!!! (its more fun in the gui)
connect_bd_net -net [get_bd_nets processing_system7_fclk_clk0] [get_bd_pins timer_subsystem_0/clk] [get_bd_pins processing_system7/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_fclk_clk0] [get_bd_pins basic_bram/ap_clk]      [get_bd_pins processing_system7/FCLK_CLK0]
connect_bd_net [get_bd_pins sw_trig_isolator/Dout] [get_bd_pins timer_subsystem_0/sw_capture_trig]
connect_bd_net [get_bd_pins reset_isolator/Dout] [get_bd_pins timer_subsystem_0/reset]
connect_bd_net -net [get_bd_nets processing_system7_gpio_o] [get_bd_pins reset_isolator/Din] [get_bd_pins processing_system7/GPIO_O]
connect_bd_net [get_bd_pins OE_high_low_selector/Dout] [get_bd_pins timer_subsystem_0/oe_high_or_low]
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins push_data_to_upper_32_bits/In1]
connect_bd_net [get_bd_pins timer_subsystem_0/data_out] [get_bd_pins push_data_to_upper_32_bits/In0]
connect_bd_net [get_bd_pins push_data_to_upper_32_bits/dout] [get_bd_pins processing_system7/GPIO_I]
connect_bd_net [get_bd_pins sw_trig_isolator/Din] [get_bd_pins processing_system7/GPIO_O]
connect_bd_net -net [get_bd_nets processing_system7_gpio_o] [get_bd_pins OE_high_low_selector/Din] [get_bd_pins processing_system7/GPIO_O]
connect_bd_net -net [get_bd_nets processing_system7_fclk_clk0] [get_bd_pins vio_0/clk] [get_bd_pins processing_system7/FCLK_CLK0]
connect_bd_net [get_bd_pins timer_subsystem_0/timer_value] [get_bd_pins vio_0/probe_in0]
connect_bd_intf_net -intf_net control_interconnect_m01_axi [get_bd_intf_pins control_interconnect/M01_AXI] [get_bd_intf_pins axi_timer/S_AXI]
connect_bd_intf_net -intf_net processing_system7_m_axi_gp0 [get_bd_intf_pins control_interconnect/S00_AXI] [get_bd_intf_pins processing_system7/M_AXI_GP0]
connect_bd_net -net axi_timer_interrupt [get_bd_pins axi_timer/interrupt] [get_bd_pins coalesce_interrupts/In0]
connect_bd_net [get_bd_pins basic_bram/interrupt] [get_bd_pins coalesce_interrupts/In1]
#clocks everywhere else
connect_bd_net -net processing_system7_fclk_clk0 [get_bd_pins accelerator_interconnect/ACLK] [get_bd_pins accelerator_interconnect/M00_ACLK] [get_bd_pins accelerator_interconnect/S00_ACLK] [get_bd_pins accelerator_interconnect/S01_ACLK] [get_bd_pins control_interconnect/ACLK] [get_bd_pins control_interconnect/M00_ACLK] [get_bd_pins control_interconnect/M01_ACLK] [get_bd_pins control_interconnect/M02_ACLK] [get_bd_pins control_interconnect/S00_ACLK] [get_bd_pins axi_timer/s_axi_aclk] [get_bd_pins proc_sys_reset/slowest_sync_clk] [get_bd_pins processing_system7/FCLK_CLK0] [get_bd_pins processing_system7/M_AXI_GP0_ACLK] [get_bd_pins processing_system7/S_AXI_ACP_ACLK]
#processor reset to proc_sys_reset
connect_bd_net -net processing_system7_fclk_reset0_n [get_bd_pins proc_sys_reset/ext_reset_in] [get_bd_pins processing_system7/FCLK_RESET0_N]
connect_bd_net -net [get_bd_nets proc_sys_reset_peripheral_aresetn] [get_bd_pins basic_bram/ap_rst_n] [get_bd_pins proc_sys_reset/peripheral_aresetn]
##proc_sys_reset interconnect reset to interconnect devices
connect_bd_net [get_bd_pins proc_sys_reset/interconnect_aresetn] [get_bd_pins control_interconnect/ARESETN]
#proc_sys_reset peripheral reset to each peripheral
connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins accelerator_interconnect/M00_ARESETN] [get_bd_pins accelerator_interconnect/S00_ARESETN] [get_bd_pins accelerator_interconnect/S01_ARESETN] [get_bd_pins control_interconnect/M00_ARESETN] [get_bd_pins control_interconnect/M01_ARESETN] [get_bd_pins control_interconnect/M02_ARESETN] [get_bd_pins control_interconnect/S00_ARESETN] [get_bd_pins axi_timer/s_axi_aresetn] [get_bd_pins proc_sys_reset/peripheral_aresetn]
##interrupts
connect_bd_net -net coalesce_interrupts_dout [get_bd_pins processing_system7/IRQ_F2P] [get_bd_pins coalesce_interrupts/dout]
create_bd_addr_seg -range 0x10000    -offset 0x42800000 [get_bd_addr_spaces processing_system7/Data] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
###Block Ram
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_1
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Use_RSTB_Pin {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100}] [get_bd_cells blk_mem_gen_0]
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Use_RSTB_Pin {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100}] [get_bd_cells blk_mem_gen_1]
connect_bd_intf_net [get_bd_intf_pins basic_bram/in_stream_PORTA]  [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins basic_bram/out_stream_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTA]

## Blcok Ram controllers
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_1
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_0]
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_1]
connect_bd_intf_net [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
connect_bd_intf_net [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTB]

#finish it
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins basic_bram/s_axi_CTRL_BUS]

validate_bd_design
#Finish it up
make_wrapper -files [get_files ../vivado/test_bram.srcs/sources_1/bd/test_bram_hw/test_bram_hw.bd] -top
add_files -norecurse           ../vivado/test_bram.srcs/sources_1/bd/test_bram_hw/hdl/test_bram_hw_wrapper.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_bd_design
launch_runs synth_1 -jobs 2
launch_runs impl_1 -jobs 2
launch_runs impl_1 -to_step write_bitstream -jobs 2
open_run impl_1

