#include "simple_algo_array.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_array_hw( ap_int<32> inA[2], ap_int<32> inB[2], ap_int<32> &outA ) {
#pragma HLS RESOURCE variable=inA core=ROM_1P_BRAM
#pragma HLS RESOURCE variable=inB core=ROM_1P_BRAM
  
  outA = inA[0] + inB[0] - inA[1] - inB[1];
  
}
