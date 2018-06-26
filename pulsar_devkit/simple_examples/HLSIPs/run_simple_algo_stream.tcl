############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
############################################################

# open the project, don't forget to reset
open_project -reset proj0

set_top simple_algo_stream_hw
add_files src/simple_algo_stream.cpp
add_files -tb simple_algo_stream_test.cpp 
add_files -tb simple_algo_stream_ref.cpp

# reset the solution
open_solution -reset "solution1"
set_part {xcvu9p-flga2104-2l-e}
create_clock -period 5 -name default

# do stuff
csim_design
csynth_design
#cosim_design -trace_level all
#export_design -format ip_catalog  -vendor "cern-cms"

# exit Vivado HLS
exit
