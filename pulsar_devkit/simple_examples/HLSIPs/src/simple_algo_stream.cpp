#include "simple_algo_stream.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void convert_input(hls::stream<invec> &in_hw,hls::stream<tmpvec> &out_hw) {
	#pragma HLS inline
	tmpvec tmprow;
	convRow: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
		#pragma HLS PIPELINE II=1
		invec row = in_hw.read();
		convCol: for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
			tmprow.data[iCol] = tmp_t(row.data[iCol]);
		}
		out_hw.write(tmprow);
	}
}

void simple_algo_stream_hw(hls::stream<invec> &in_hw, hls::stream<out_t> &out_hw) {
	//#pragma HLS ARRAY_PARTITION variable=out_hw complete
	//Cannot use both pipeline and dataflow arguments in the same function domain
	//#pragma HLS pipeline II=2
	#pragma HLS dataflow

	hls::stream<tmpvec> tmp_hw;

	convert_input(in_hw,tmp_hw);

	readRow: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
		#pragma HLS PIPELINE II=1
		tmpvec row = tmp_hw.read();
		out_t sum = 0;
        sumCol: for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	sum += row.data[iCol];
        }
      	out_hw.write(sum);
    }
}

//One fewer stream reads
//Conversion and reads in same step
//Still the same overall time. I think the bottleneck is in the summation.
void simple_algo_stream_optimized_hw(hls::stream<invec> &in_hw, hls::stream<out_t> &out_hw) {
	#pragma HLS dataflow

	LoopReadIn: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
		#pragma HLS PIPELINE II=1
		invec row = in_hw.read();
		out_t sum = 0;
		LoopConvertAndSumCol: for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	sum += tmp_t(row.data[iCol]);
		}
      	out_hw.write(sum);
	}
}