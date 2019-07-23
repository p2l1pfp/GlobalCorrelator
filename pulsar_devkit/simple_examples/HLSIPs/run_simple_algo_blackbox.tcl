# Create a project
open_project -reset proj0

# Add design files
add_files src/simple_algo_blackbox.cpp
# Add test bench & files
add_files -tb simple_algo_blackbox_test.cpp
# JSON file
add_files -blackbox src/simple_algo_blackbox.json

# Set the top-level function
set_top simple_algo_blackbox

# ########################################################
# Create a solution
open_solution -reset solution1_rtl_as_blackbox
# Define technology and clock rate
set_part  {xcvu9p-flga2104-2l-e}
create_clock -period "320MHz"

# Set to 0: to run setup
# Set to 1: to run setup and synthesis
# Set to 2: to run setup, synthesis and RTL simulation
# Set to 3: to run setup, synthesis, RTL simulation and RTL synthesis
# Any other value will run setup only
set hls_exec 0
csim_design

# Set any optimization directives
# End of directives

if {$hls_exec == 1} {
	# Run Synthesis and Exit
	csynth_design
	
} elseif {$hls_exec == 2} {
	# Run Synthesis, RTL Simulation and Exit
	csynth_design	
	cosim_design
} elseif {$hls_exec == 3} { 
	# Run Synthesis, RTL Simulation, RTL implementation and Exit
	csynth_design	
	cosim_design
	export_design -rtl verilog -flow impl
} else {
	# Default is to exit after setup
	csynth_design
}

exit
