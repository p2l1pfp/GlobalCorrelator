#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_arraystruct.h"

void simple_algo_arraystruct_ref(simple_struct structA[N_INPUTS], ap_int<32> outA[N_OUTPUTS] ) {

  for(int i=0; i<N_OUTPUTS; i++){
    outA[i] = structA[i].inA + structA[i].inB;
  }
}

