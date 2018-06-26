#include "src/simple_algo_stream.h"

void simple_algo_stream_ref(in_t in_ref[N_COLUMNS][N_ROWS], out_t out_ref[N_OUTPUTS]) {
    for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
            out_ref[iRow] += tmp_t(in_ref[iCol][iRow]);
        }
    }
}

