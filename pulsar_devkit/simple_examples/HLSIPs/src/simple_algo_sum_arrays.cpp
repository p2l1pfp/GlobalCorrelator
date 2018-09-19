#include "simple_algo_sum_arrays.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_sum_arrays_hw(invec in_hw[N_COLUMNS], type_t out_hw[N_OUTPUTS]) {
	#pragma HLS pipeline II=1
	#pragma HLS ARRAY_PARTITION variable=in_hw complete
	#pragma HLS ARRAY_PARTITION variable=in_hw->data complete
	#pragma HLS ARRAY_PARTITION variable=out_hw complete

	loopRow: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
		type_t sum = 0;
        loopCol: for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	sum += in_hw[iCol].data[iRow];
        	sum = (sum > MAXBIN+1) ? type_t(MAXBIN) : sum;
        }
      	out_hw[iRow] = sum;
    }
}

// This is the better version
void simple_algo_sum_arrays_fixed_hw(invec in_hw[N_COLUMNS], type_t out_hw[N_OUTPUTS]) {
	#pragma HLS pipeline II=1
	#pragma HLS ARRAY_PARTITION variable=in_hw complete
	#pragma HLS ARRAY_PARTITION variable=in_hw->data complete
	#pragma HLS ARRAY_PARTITION variable=out_hw complete

	loopRow: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
		tmp_t sum = 0;
        loopCol: for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	sum += in_hw[iCol].data[iRow];
        }
      	out_hw[iRow] = (type_t)sum;
    }
    loopMax: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
    	if (out_hw[iRow] > MAXBIN+1) out_hw[iRow] = (type_t)MAXBIN;
    }
}
