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

void simple_algo_stream_hw(hls::stream<invec> &in_hw, out_t out_hw[N_OUTPUTS]) {
	//Cannot use both pipeline and dataflow arguments in the same function domain
	//#pragma HLS pipeline II=2
	#pragma HLS dataflow

	hls::stream<tmpvec> tmp_hw;

	convert_input(in_hw,tmp_hw);

	readRow: for (int iRow = 0; iRow < N_ROWS; ++iRow) {
		#pragma HLS PIPELINE II=1
		tmpvec row = tmp_hw.read();
        sumCol: for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	out_hw[iRow] += row.data[iCol];
        }
    }
}
