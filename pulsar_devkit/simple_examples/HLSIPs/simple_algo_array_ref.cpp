#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_array.h"

void simple_algo_array_ref( ap_int<32> inA[2], ap_int<32> inB[2],  ap_int<32> &outA ) {
#pragma HLS RESOURCE variable=inA core=ROM_1P_BRAM
#pragma HLS RESOURCE variable=inB core=ROM_1P_BRAM
  
  outA = inA[0] + inB[0] - inA[1] - inB[1];
  
}

