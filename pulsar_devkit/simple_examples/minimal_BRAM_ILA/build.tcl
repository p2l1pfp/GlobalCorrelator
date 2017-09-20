# Must run using this version of Vivado (BRAM xci is version dependent)
# Vivado (TM) v2016.2 (64-bit)
#

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

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

###########################################################################
# Import the HLS IP! 
set_property  ip_repo_paths user_ip_repo [current_project]
file mkdir user_ip_repo
update_ip_catalog -rebuild
update_ip_catalog -add_ip "$origin_dir/../HLSIPs/proj0/solution1/impl/ip/cern-cms_hls_simple_algo_hw_1_0.zip" -repo_path user_ip_repo

create_ip -name simple_algo_hw -vendor "cern-cms" -library hls -module_name simple_algo_hw_0
generate_target {instantiation_template} [get_files top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci]
generate_target all [get_files top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci]
export_ip_user_files -of_objects [get_files top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci] -no_script -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0.xci]

###########################################################################
# Declaring source files

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/hdl/test_algo.vhd"]"\
 "[file normalize "$origin_dir/hdl/top.vhd"]"\
 "[file normalize "$origin_dir/cgn/my_coe.coe"]"\
 "[file normalize "$origin_dir/cgn/blk_mem_gen_0/blk_mem_gen_0.xci"]"\
 "[file normalize "$origin_dir/cgn/ila_0/ila_0.xci"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "top" $obj

###########################################################################
# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/xdc/constraints.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$origin_dir/xdc/constraints.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

###########################################################################
# Declaring Sim files
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

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "top_tb" $obj
set_property "transport_int_delay" "0" $obj
set_property "transport_path_delay" "0" $obj
set_property "xelab.nosort" "1" $obj
set_property "xelab.unifast" "" $obj

puts "INFO: Project created:top"
