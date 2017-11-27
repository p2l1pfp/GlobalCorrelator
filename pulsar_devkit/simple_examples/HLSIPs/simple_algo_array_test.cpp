#include <cstdio>
#include "src/simple_algo_array.h"
#include "ap_int.h"

int main() {
	
	ap_int<32> inA[N_INPUTS];
	ap_int<32> inB[N_INPUTS];
	ap_int<32> outA[N_OUTPUTS];

	
	for (int test = 0; test < N_OUTPUTS; ++test) {

	  inA[test] = test;
	  inB[test] = test+1;
	  outA[test]= 0;
	}
	simple_algo_array_ref(inA, inB, outA);
	simple_algo_array_hw(inA, inB, outA);
	
	for (int t=0; t<N_OUTPUTS; ++t){
	  printf( "test = %i + %i = %i \n", int(inA[t]), int(inB[t]), int(outA[t]));
	}
	return 0;
}
