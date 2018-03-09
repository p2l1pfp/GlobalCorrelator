#include <cstdio>
#include "src/simple_algo_arraystruct.h"
#include "ap_int.h"

int main() {
	
  simple_struct structA[N_INPUTS];
  ap_int<32> outA[N_OUTPUTS];
  
  
  for (int test = 0; test < N_OUTPUTS; ++test) {
    structA[test].inA=test;
    structA[test].inB=test;
    outA[test] = -999;//inA[test]+inB[test];
  }
  simple_algo_arraystruct_ref(structA,outA);
  simple_algo_arraystruct_hw(structA,outA);
  
  for (int t=0; t<N_OUTPUTS; ++t){
    printf( "test: %i %i %i\n",int(structA[t].inA), int(structA[t].inB), int(outA[t]));
  }
  return 0;
}
