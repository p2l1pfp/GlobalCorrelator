# open the project, don't forget to reset
open_project -reset proj0

# top options:
#    simple_algo_stream_hw
#    simple_algo_stream_optimized_hw
set_top simple_algo_stream_hw
add_files src/simple_algo_stream.cpp
add_files -tb simple_algo_stream_test.cpp 
add_files -tb simple_algo_stream_ref.cpp

# reset the solution
open_solution -reset "solution1"
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
#cosim_design -trace_level all
#export_design -format ip_catalog  -vendor "cern-cms"

# exit Vivado HLS
exit
