#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_structarray.h"

void simple_algo_structarray_ref(struct_of_arrays structA, ap_int<32> outA[N_OUTPUTS] ) {

  for(int i=0; i<N_OUTPUTS; i++){
    outA[i] = structA.inA[i] + structA.inB[i];
  }
}

