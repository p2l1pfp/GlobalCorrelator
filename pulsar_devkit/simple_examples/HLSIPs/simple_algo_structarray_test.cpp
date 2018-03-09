#include <cstdio>
#include "src/simple_algo_structarray.h"
#include "ap_int.h"

int main() {
	
  struct_of_arrays structA;
  ap_int<32> outA[N_OUTPUTS];
  
  
  for (int test = 0; test < N_OUTPUTS; ++test) {
    structA.inA[test]=test;
    structA.inB[test]=test;
    outA[test] = -999;//inA[test]+inB[test];
  }
  simple_algo_structarray_ref(structA,outA);
  simple_algo_structarray_hw(structA,outA);
  
  for (int t=0; t<N_OUTPUTS; ++t){
    printf( "test: %i %i %i\n",int(structA.inA[t]), int(structA.inB[t]), int(outA[t]));
  }
  return 0;
}
