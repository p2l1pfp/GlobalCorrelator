#include "simple_algo_arraystruct.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_arraystruct_hw(simple_struct structA[N_INPUTS], ap_int<32> outA[N_OUTPUTS]) {
#pragma HLS RESOURCE variable=structA core=RAM_1P_BRAM
#pragma HLS RESOURCE variable=outA core=RAM_1P_BRAM
  for(int i=0; i<2; i++){
    outA[i] = structA[i].inA + structA[i].inB;
  }
}
