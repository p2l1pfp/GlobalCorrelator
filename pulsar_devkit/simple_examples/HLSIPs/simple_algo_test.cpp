#include <cstdio>
#include "src/simple_algo.h"
#include "ap_int.h"

#define NTEST 1


int main() {
	
	ap_int<32> inA;
	ap_int<32> inB;
	ap_int<32> outA;

	for (int test = 1; test <= NTEST; ++test) {

		inA = 1;
		inB = 2;
		outA = 0;

		simple_algo_ref(inA, inB, outA);
		simple_algo_hw(inA, inB, outA);

		printf( "test = %i %i %i \n", int(inA), int(inB), int(outA) );

	}

	return 0;
}
