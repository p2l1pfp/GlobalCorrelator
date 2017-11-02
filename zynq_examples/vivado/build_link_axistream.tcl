puts "Building Full System"
create_project test_axistream ../vivado/test_axistream_prj -part xc7z020clg484-1 -force
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property target_language VHDL [current_project]
create_bd_design "test_axistream_hw"
set_property ip_repo_paths [list ../example_transfer/basic_axistream_prj/solution1/impl/ip/ ../vivado/timer_subsystem/] [current_fileset]
update_ip_catalog
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
# AXI DMA_controller this is what communicates with the zynq
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 DMA_controller
set_property -dict [ list CONFIG.c_include_sg {0} CONFIG.c_mm2s_burst_size {256} CONFIG.c_s2mm_burst_size {256}  ] [get_bd_cells DMA_controller]
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 accelerator_interconnect
set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {0} CONFIG.NUM_MI {1} CONFIG.NUM_SI {2}  ] [get_bd_cells accelerator_interconnect]

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
create_bd_cell -type ip -vlnv xilinx.com:hls:basic_axistream:1.0 basic_axistream
#set_property -dict [list CONFIG.C_S_AXI_CONTROL_BUS_ADDR_WIDTH {32}] [get_bd_cells basic_axistream]

# connections to Everything!!!!! (its more fun in the gui)
connect_bd_net -net [get_bd_nets processing_system7_fclk_clk0] [get_bd_pins timer_subsystem_0/clk] [get_bd_pins processing_system7/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_fclk_clk0] [get_bd_pins basic_axistream/ap_clk]      [get_bd_pins processing_system7/FCLK_CLK0]
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
connect_bd_intf_net -intf_net DMA_controller_m_axi_mm2s [get_bd_intf_pins DMA_controller/M_AXI_MM2S] [get_bd_intf_pins accelerator_interconnect/S00_AXI]
connect_bd_intf_net -intf_net accelerator_interconnect_m00_axi [get_bd_intf_pins accelerator_interconnect/M00_AXI] [get_bd_intf_pins processing_system7/S_AXI_ACP]
connect_bd_intf_net -intf_net control_interconnect_m00_axi [get_bd_intf_pins DMA_controller/S_AXI_LITE] [get_bd_intf_pins control_interconnect/M00_AXI]
connect_bd_intf_net -intf_net control_interconnect_m01_axi [get_bd_intf_pins control_interconnect/M01_AXI] [get_bd_intf_pins axi_timer/S_AXI]
connect_bd_intf_net -intf_net processing_system7_m_axi_gp0 [get_bd_intf_pins control_interconnect/S00_AXI] [get_bd_intf_pins processing_system7/M_AXI_GP0]
connect_bd_intf_net [get_bd_intf_pins DMA_controller/M_AXI_S2MM] [get_bd_intf_pins accelerator_interconnect/S01_AXI]
connect_bd_net -net axi_timer_interrupt [get_bd_pins axi_timer/interrupt] [get_bd_pins coalesce_interrupts/In0]
connect_bd_net [get_bd_pins basic_axistream/interrupt] [get_bd_pins coalesce_interrupts/In1]
#clocks everywhere else
connect_bd_net -net processing_system7_fclk_clk0 [get_bd_pins DMA_controller/m_axi_mm2s_aclk] [get_bd_pins DMA_controller/m_axi_s2mm_aclk] [get_bd_pins DMA_controller/s_axi_lite_aclk] [get_bd_pins accelerator_interconnect/ACLK] [get_bd_pins accelerator_interconnect/M00_ACLK] [get_bd_pins accelerator_interconnect/S00_ACLK] [get_bd_pins accelerator_interconnect/S01_ACLK] [get_bd_pins control_interconnect/ACLK] [get_bd_pins control_interconnect/M00_ACLK] [get_bd_pins control_interconnect/M01_ACLK] [get_bd_pins control_interconnect/M02_ACLK] [get_bd_pins control_interconnect/S00_ACLK] [get_bd_pins axi_timer/s_axi_aclk] [get_bd_pins proc_sys_reset/slowest_sync_clk] [get_bd_pins processing_system7/FCLK_CLK0] [get_bd_pins processing_system7/M_AXI_GP0_ACLK] [get_bd_pins processing_system7/S_AXI_ACP_ACLK]
#processor reset to proc_sys_reset
connect_bd_net -net processing_system7_fclk_reset0_n [get_bd_pins proc_sys_reset/ext_reset_in] [get_bd_pins processing_system7/FCLK_RESET0_N]
connect_bd_net -net [get_bd_nets proc_sys_reset_peripheral_aresetn] [get_bd_pins basic_axistream/ap_rst_n] [get_bd_pins proc_sys_reset/peripheral_aresetn]
#proc_sys_reset interconnect reset to interconnect devices
connect_bd_net [get_bd_pins proc_sys_reset/interconnect_aresetn] [get_bd_pins control_interconnect/ARESETN]
connect_bd_net -net [get_bd_nets proc_sys_reset_interconnect_aresetn] [get_bd_pins accelerator_interconnect/ARESETN] [get_bd_pins proc_sys_reset/interconnect_aresetn]
#proc_sys_reset peripheral reset to each peripheral
connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins DMA_controller/axi_resetn] [get_bd_pins accelerator_interconnect/M00_ARESETN] [get_bd_pins accelerator_interconnect/S00_ARESETN] [get_bd_pins accelerator_interconnect/S01_ARESETN] [get_bd_pins control_interconnect/M00_ARESETN] [get_bd_pins control_interconnect/M01_ARESETN] [get_bd_pins control_interconnect/M02_ARESETN] [get_bd_pins control_interconnect/S00_ARESETN] [get_bd_pins axi_timer/s_axi_aresetn] [get_bd_pins DMA_controller/axi_resetn] [get_bd_pins proc_sys_reset/peripheral_aresetn]
#interrupts
connect_bd_net -net coalesce_interrupts_dout [get_bd_pins processing_system7/IRQ_F2P] [get_bd_pins coalesce_interrupts/dout]
# Create address segments
create_bd_addr_seg -range 0x20000000 -offset 0x0        [get_bd_addr_spaces DMA_controller/Data_MM2S] [get_bd_addr_segs processing_system7/S_AXI_ACP/ACP_DDR_LOWOCM] SEG_processing_system7_ACP_DDR_LOWOCM
create_bd_addr_seg -range 0x20000000 -offset 0x0        [get_bd_addr_spaces DMA_controller/Data_S2MM] [get_bd_addr_segs processing_system7/S_AXI_ACP/ACP_DDR_LOWOCM] SEG_processing_system7_ACP_DDR_LOWOCM
create_bd_addr_seg -range 0x400000   -offset 0xE0000000 [get_bd_addr_spaces DMA_controller/Data_MM2S] [get_bd_addr_segs processing_system7/S_AXI_ACP/ACP_IOP] SEG_processing_system7_ACP_IOP
create_bd_addr_seg -range 0x400000   -offset 0xE0000000 [get_bd_addr_spaces DMA_controller/Data_S2MM] [get_bd_addr_segs processing_system7/S_AXI_ACP/ACP_IOP] SEG_processing_system7_ACP_IOP
create_bd_addr_seg -range 0x1000000  -offset 0xFC000000 [get_bd_addr_spaces DMA_controller/Data_MM2S] [get_bd_addr_segs processing_system7/S_AXI_ACP/ACP_QSPI_LINEAR] SEG_processing_system7_ACP_QSPI_LINEAR
create_bd_addr_seg -range 0x1000000  -offset 0xFC000000 [get_bd_addr_spaces DMA_controller/Data_S2MM] [get_bd_addr_segs processing_system7/S_AXI_ACP/ACP_QSPI_LINEAR] SEG_processing_system7_ACP_QSPI_LINEAR
create_bd_addr_seg -range 0x10000    -offset 0x40400000 [get_bd_addr_spaces processing_system7/Data] [get_bd_addr_segs DMA_controller/S_AXI_LITE/Reg] SEG_DMA_controller_Reg
create_bd_addr_seg -range 0x10000    -offset 0x42800000 [get_bd_addr_spaces processing_system7/Data] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg

connect_bd_intf_net [get_bd_intf_pins basic_axistream/out_stream] [get_bd_intf_pins DMA_controller/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins basic_axistream/in_stream] [get_bd_intf_pins DMA_controller/M_AXIS_MM2S]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins basic_axistream/s_axi_CTRL_BUS]

validate_bd_design
#Finish it up
make_wrapper -files [get_files ../vivado/test_axistream_prj/test_axistream.srcs/sources_1/bd/test_axistream_hw/test_axistream_hw.bd] -top
add_files -norecurse           ../vivado/test_axistream_prj/test_axistream.srcs/sources_1/bd/test_axistream_hw/hdl/test_axistream_hw_wrapper.vhd

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_bd_design
launch_runs synth_1
launch_runs impl_1
launch_runs impl_1 -to_step write_bitstream 
open_run impl_1

