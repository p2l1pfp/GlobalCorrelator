#include "simple_algo_sparse.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_sparse_hw(mytype input, mytype output[N]){
  
  #pragma HLS ARRAY_PARTITION variable=output complete 
  
  #pragma HLS PIPELINE
  
  mytype weight[N] = {0,0,3.14,0};
  for(int i = 0; i<N; i++){
    #pragma HLS UNROLL
    output[i] = weight[i]*input;
  }

}
