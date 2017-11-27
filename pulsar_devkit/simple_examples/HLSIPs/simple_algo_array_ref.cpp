#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_array.h"

void simple_algo_array_ref( ap_int<32> inA[N_INPUTS], ap_int<32> inB[N_INPUTS], ap_int<32> outA[N_OUTPUTS] ) {
  //#pragma HLS RESOURCE variable=inA core=RAM_1P_BRAM
  //#pragma HLS RESOURCE variable=inB core=RAM_1P_BRAM
#pragma HLS INTERFACE bram   port=inA
#pragma HLS INTERFACE bram   port=inB
#pragma HLS INTERFACE bram   port=outA
  for(int i=0; i<100; i++){
    #pragma HLS UNROLL
    outA[i] = inA[i] + inB[i];
  }
}

