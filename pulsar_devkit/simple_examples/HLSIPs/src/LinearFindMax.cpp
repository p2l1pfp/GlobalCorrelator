#include "simple_algo_find_max.h"

binvalue_t LinearFindMax(binvalue_t input_array[NBINS], binindex_t &max_index) {
	#pragma HLS PIPELINE II=1
    #pragma HLS array_partition variable=input_array complete dim=1

	binvalue_t current_max = 0;
	binindex_t current_max_index = 0;

    MAXLOOP: for (unsigned int b = 0; b < NBINS; ++b) {
        if(input_array[b] > current_max) {
            current_max = input_array[b];
            current_max_index = b;
        }
    }

    max_index = current_max_index;
    return current_max;
}