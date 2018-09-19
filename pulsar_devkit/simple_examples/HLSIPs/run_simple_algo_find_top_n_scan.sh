#!/bin/bash

#for method in "ParallelFindMax" "SortAndSelect"; do
for method in "SortAndSelect"; do
	top="FindTopN_${method}"
	#seq LAST
	#seq FIRST LAST
	#seq FIRST INCREMENT LAST
	for i in $(seq 8 10); do
		echo "Doing $top with nOutput=${i}"
		set method ParallelFindMax
		sed -ri 's/(set method ).*/\1'"${method}"'/g' run_simple_algo_find_top_n.tcl
		sed -ri 's/(solution1_FindTopN_\$\{method\}_nOutput).*\"/\1'"${i}"'\"/g' run_simple_algo_find_top_n.tcl
		sed -ri 's/(\#define O )(.*?)(\/\/.*)/\1'"${i}"' \3/g' src/simple_algo_find_top_n.h
		vivado_hls -f run_simple_algo_find_top_n.tcl
		#grep -B 1 -A 17 "Performance Estimates" proj0/solution1_FindTopN_ParallelFindMax/syn/report/FindTopN_ParallelFindMax_csynth.rpt
		#grep -B 1 -A 19 "Utilization Estimates" proj0/solution1_FindTopN_ParallelFindMax/syn/report/FindTopN_ParallelFindMax_csynth.rpt
	done
done
