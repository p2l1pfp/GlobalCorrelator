# open the project, don't forget to reset
open_project -reset proj0

set prefix "simple_algo_sum_arrays"
set version "_fixed"
set topFunc ${prefix}${version}_hw
set_top ${topFunc}
add_files src/simple_algo_sum_arrays.cpp
add_files -tb simple_algo_sum_arrays_test.cpp -cflags "-DTOP_FUNC=${topFunc}"
add_files -tb simple_algo_sum_arrays_ref.cpp

# reset the solution
open_solution -reset "solution1_${prefix}${version}"
# part options:
#	xcku9p-ffve900-2-i-EVAL
#	xc7vx690tffg1927-2
#	xcku5p-sfvb784-3-e
#	xcku115-flvf1924-2-i
#	xcvu9p-flga2104-2l-e
set_part {xcvu9p-flga2104-2l-e}
create_clock -period 3.125 -name default

# do stuff
csim_design
csynth_design
cosim_design -trace_level all
export_design -format ip_catalog  -vendor "cern-cms"

# exit Vivado HLS
exit
