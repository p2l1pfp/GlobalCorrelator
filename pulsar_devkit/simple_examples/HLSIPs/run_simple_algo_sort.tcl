# open the project, don't forget to reset
open_project -reset proj0
set sortMethod EvenOddIterSorter
#set sortMethod BatchersEvenOddMergeSort
set_top ${sortMethod}
add_files src/${sortMethod}.cpp
add_files -tb simple_algo_sort_test.cpp -cflags "-DSORT_METHOD=${sortMethod}"
add_files -tb input_data.dat
add_files -tb sorted_data.gold.dat

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
