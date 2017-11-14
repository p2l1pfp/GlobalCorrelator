#include "simple_algo_array.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_array_hw( ap_int<32> inA[N_INPUTS], ap_int<32> inB[N_INPUTS], ap_int<32> outA[N_OUTPUTS] ) {
  //#pragma HLS RESOURCE variable=inA core=RAM_1P_BRAM
  //#pragma HLS RESOURCE variable=inB core=RAM_1P_BRAM
#pragma HLS INTERFACE bram   port=inA
#pragma HLS INTERFACE bram   port=inB
#pragma HLS INTERFACE bram   port=outA

  for (int i = 0; i < N_OUTPUTS; i++){
    #pragma HLS UNROLL
    outA[i] = inA[i] + inB[i];
  }  
}
