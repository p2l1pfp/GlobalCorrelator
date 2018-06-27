#ifndef SIMPLE_ALGO_ARRAY_H
#define SIMPLE_ALGO_ARRAY_H

#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_stream.h"

#define N_COLUMNS 27
#define N_ROWS    24
#define N_OUTPUTS N_ROWS

typedef ap_ufixed<11,10> in_t;
typedef struct { in_t data[N_COLUMNS]; } invec;
typedef ap_int<10>      tmp_t;
typedef struct { tmp_t data[N_COLUMNS]; } tmpvec;
typedef ap_uint<18>     out_t;

void simple_algo_stream_ref(in_t in_ref[N_COLUMNS][N_ROWS], out_t out_ref[N_OUTPUTS]);
void simple_algo_stream_hw(hls::stream<invec> &in_hw, out_t out_hw[N_OUTPUTS]);
void convert_input(hls::stream<invec> &in_hw,hls::stream<tmpvec> &out_hw);

#endif
