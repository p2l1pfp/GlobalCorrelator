# open the project, don't forget to reset
open_project -reset proj0
set maxMethod ParallelFindMax
#set maxMethod FourCompParallelFindMax
#set maxMethod LinearFindMax
set_top ${maxMethod}
add_files src/${maxMethod}.cpp -cflags "-std=c++0x"
#-DDEBUG
#-DOPTIMIZED
add_files -tb simple_algo_find_max_test.cpp -cflags "-DMAX_METHOD=${maxMethod}"
add_files -tb input_data.dat
add_files -tb input_data_72.dat
add_files -tb input_data_200.dat
add_files -tb src/utility.h

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
