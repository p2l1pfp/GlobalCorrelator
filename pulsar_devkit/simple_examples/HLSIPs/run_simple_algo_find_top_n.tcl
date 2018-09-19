# open the project, don't forget to reset
open_project -reset proj0
# method options:
#    SortAndSelect
#    ParallelFindMax
set method SortAndSelect
set_top FindTopN_${method}
add_files src/simple_algo_find_top_n.cpp -cflags "-DDEBUG=0"
add_files -tb simple_algo_find_top_n_test.cpp -cflags "-DMETHOD=${method} -std=c++11"
add_files -tb src/ParallelFindMax.cpp -cflags "-std=c++0x"

# reset the solution
open_solution -reset "solution1_FindTopN_${method}_nOutput10"
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
