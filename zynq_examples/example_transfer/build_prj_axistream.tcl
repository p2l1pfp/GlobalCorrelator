open_project -reset basic_axistream_prj
set_top basic_axistream
add_files firmware/example_output.cpp 
add_files -tb transfer_test.cpp 
open_solution -reset "solution1"
#Zynq 7020
set_part {xc7z020clg484-1}
#create_clock -period 5 -name default
csim_design
csynth_design
#cosim_design
export_design -format ip_catalog
exit
