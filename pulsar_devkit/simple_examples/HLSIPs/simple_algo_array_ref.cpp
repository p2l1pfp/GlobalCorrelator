#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_array.h"

void simple_algo_array_ref(ap_int<32> inA[N_INPUTS], ap_int<32> inB[N_INPUTS], ap_int<32> outA[N_OUTPUTS] ) {

  for(int i=0; i<N_OUTPUTS; i++){
    outA[i] = inA[i] + inB[i];
  }
}

