#include "src/simple_algo_sum_arrays.h"

void simple_algo_sum_arrays_ref(type_t in_ref[N_COLUMNS][N_ROWS], type_t out_ref[N_OUTPUTS]) {
    for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	if (out_ref[iRow]+in_ref[iCol][iRow]> MAXBIN+1)
        		out_ref[iRow] = MAXBIN;
        	else
	            out_ref[iRow] += in_ref[iCol][iRow];
        }
    }
}

