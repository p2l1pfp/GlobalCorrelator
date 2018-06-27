# open the project, don't forget to reset
open_project -reset proj0
set_top simple_algo_struct_hw
add_files src/simple_algo_struct.cpp
add_files -tb simple_algo_struct_test.cpp 
add_files -tb simple_algo_struct_ref.cpp

#set_top simple_algo_structarray_hw
#add_files src/simple_algo_structarray.cpp
#add_files -tb simple_algo_structarray_test.cpp 
#add_files -tb simple_algo_structarray_ref.cpp

#set_top simple_algo_arraystruct_hw
#add_files src/simple_algo_arraystruct.cpp
#add_files -tb simple_algo_arraystruct_test.cpp 
#add_files -tb simple_algo_arraystruct_ref.cpp

#set_top simple_algo_fixedshift_hw
#add_files src/simple_algo_fixedshift.cpp
#add_files -tb simple_algo_fixedshift_test.cpp 
#add_files -tb simple_algo_fixedshift_ref.cpp

# reset the solution
open_solution -reset "solution1"
# part options:
#	xcku9p-ffve900-2-i-EVAL
#	xc7vx690tffg1927-2
#	xcku5p-sfvb784-3-e
#	xcku115-flvf1924-2-i
#	xcvu9p-flga2104-2l-e
set_part {xc7vx690tffg1927-2}
create_clock -period 5 -name default

# do stuff
csim_design
csynth_design
#cosim_design -trace_level all
#export_design -format ip_catalog  -vendor "cern-cms"

# exit Vivado HLS
exit
