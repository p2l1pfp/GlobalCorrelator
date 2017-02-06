# Source common utilities
source -notrace utils.tcl

# Location of hdl
set hdlRoot hdl

# Set the reference directory for source file relative paths (by default the value is scrip\
t directory path)                                                                           
set origin_dir "."

# Set the directory path for the original project from where this script was exported       
set orig_proj_dir "[file normalize "$origin_dir/"]"

# Create project                                                                            
create_project -force ParticeFlow ./ParticeFlow

# Set the directory path for the new project                                                
set proj_dir [get_property directory [current_project]]

# Set project properties                                                                    
set obj [get_projects ParticeFlow]
set_property "default_lib" "xil_defaultlib" $obj
set_property "part" "xc7vx690tffg1930-2" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

add_files -norecurse $hdlRoot/top.vhd

# If successful, "touch" a file so the make utility will know it's done 
touch {.setup.done}
