# open the project, don't forget to reset
open_project -reset proj0
# sort options:
#    BatchersEvenOddMergeSort
#    BitonicSort
#    EvenOddIterSorter
set sortMethod BitonicSort
# wrapper options:
#    ""
#    Optimized
#    OptimizedInline
set wrapper OptimizedInline
# sort size options:
#    Size  Input Filename      Comparison Filename       II Bitonic  LUT Usage Bitonic (%)  FF Usage Bitonic (%)
#    ====  ==================  ========================  ==========  =====================  ====================
#    16    input_data.dat      sorted_data.gold.dat      4           ~0                     ~0
#    32    input_data_32.dat   sorted_data_32.gold.dat   5           1                      ~0
#    64    input_data_64.dat   sorted_data_64.gold.dat   7           3                      ~0
#    72    input_data_72.dat   sorted_data_72.gold.dat
#    128   input_data_128.dat  sorted_data_128.gold.dat  10          8                      1
#    200   input_data_200.dat  sorted_data_200.gold.dat
set inputDataSize 128
set_top ${sortMethod}${wrapper}
add_files src/${sortMethod}.cpp -cflags "-DINPUT_DATA_SIZE=${inputDataSize}"
add_files -tb simple_algo_sort_test.cpp -cflags "-DSORT_METHOD=${sortMethod} -DWRAPPER=${wrapper} -DINPUT_DATA_SIZE=${inputDataSize}"
add_files -tb input_data_${inputDataSize}.dat
add_files -tb sorted_data_${inputDataSize}.gold.dat

# reset the solution
open_solution -reset "solution1_${sortMethod}${wrapper}"
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
