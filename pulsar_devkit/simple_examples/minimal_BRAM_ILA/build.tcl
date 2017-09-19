#
# Vivado (TM) v2016.2 (64-bit)
#

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

variable script_file
set script_file "build.tcl"

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/top"]"

# Create project
create_project top ./top -part xc7vx690tffg1930-2

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects top]
set_property "default_lib" "xil_defaultlib" $obj
set_property "generate_ip_upgrade_log" "0" $obj
set_property "part" "xc7vx690tffg1930-2" $obj
set_property "sim.ip.auto_export_scripts" "1" $obj
set_property "simulator_language" "VHDL" $obj
set_property "target_language" "VHDL" $obj
set_property "xpm_libraries" "XPM_MEMORY" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
# set obj [get_filesets sources_1]
# set_property "ip_repo_paths" "[file normalize "/home/ntran/HLS/dev/Sep18/GlobalCorrelator/pulsar_devkit/simple_examples/HLSIPs/proj0"]" $obj

# Rebuild user ip_repo's index before adding any source files
set_property  ip_repo_paths  user_ip_repo [current_project]
update_ip_catalog -rebuild
update_ip_catalog -add_ip "/home/ntran/HLS/dev/Sep18/v2/GlobalCorrelator/pulsar_devkit/simple_examples/HLSIPs/proj0/solution1/impl/ip/cern-cms_hls_simple_algo_hw_1_0.zip" -repo_path user_ip_repo
#update_ip_catalog -add_ip "/home/ntran/HLS/dev/Sep18/v2/GlobalCorrelator/pulsar_devkit/simple_examples/HLSIPs/proj0/solution1/impl/ip.zip"
#create_ip -name simple_algo_hw -vendor cern-cms -library hls -version v1.0.0 -module_name simple_algo_hw_0
create_ip -name simple_algo_hw -vendor "cern-cms" -library hls -module_name simple_algo_hw_0
generate_target {instantiation_template} [get_files top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci]
generate_target all [get_files top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci]
export_ip_user_files -of_objects [get_files top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci] -no_script -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci]




# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/hdl/test_algo.vhd"]"\
 "[file normalize "$origin_dir/hdl/top.vhd"]"\
 "[file normalize "$origin_dir/cgn/my_coe.coe"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/hdl/test_algo.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/hdl/top.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

# set file "$origin_dir/hdl/simple_algo_hw.vhd"
# set file [file normalize $file]
# set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
# set_property "file_type" "VHDL" $file_obj

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "top" $obj

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/cgn/blk_mem_gen_0/blk_mem_gen_0.xci"]"\
]
add_files -norecurse -fileset $obj $files

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Empty (no sources present)

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
 "[file normalize "$origin_dir/hdl/testbench/txt_util.vhd"]"\
 "[file normalize "$origin_dir/hdl/testbench/sim_file_read.vhd"]"\
 "[file normalize "$origin_dir/hdl/testbench/top_tb.vhd"]"\
 "[file normalize "$origin_dir/hdl/testbench/data1.dat"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files
set file "$origin_dir/hdl/testbench/txt_util.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj

set file "$origin_dir/hdl/testbench/sim_file_read.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "used_in" "simulation" $file_obj
set_property "used_in_synthesis" "0" $file_obj

set file "$origin_dir/hdl/testbench/top_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "used_in" "simulation" $file_obj
set_property "used_in_synthesis" "0" $file_obj

set file "$origin_dir/hdl/testbench/data1.dat"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "Data Files" $file_obj
set_property "used_in" "simulation" $file_obj
set_property "used_in_synthesis" "0" $file_obj

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "top_tb" $obj
set_property "transport_int_delay" "0" $obj
set_property "transport_path_delay" "0" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7vx690tffg1930-2 -flow {Vivado Synthesis 2015} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2015" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property "part" "xc7vx690tffg1930-2" $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7vx690tffg1930-2 -flow {Vivado Implementation 2015} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2015" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "part" "xc7vx690tffg1930-2" $obj
set_property "steps.write_bitstream.args.readback_file" "0" $obj
set_property "steps.write_bitstream.args.verbose" "0" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:top"