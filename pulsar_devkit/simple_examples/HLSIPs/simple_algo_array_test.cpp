#include <cstdio>
#include "src/simple_algo_array.h"
#include "ap_int.h"

#define NTEST 1


int main() {
	
	ap_int<32> inA[2];
	ap_int<32> inB[2];
	ap_int<32> outA;

	for (int test = 1; test <= NTEST; ++test) {

		inA[0] = 1;
		inB[0] = 5;
		inA[1] = 1;
		inB[1] = 4;
		outA = 0;

		simple_algo_array_ref(inA, inB, outA);
		simple_algo_array_hw(inA, inB, outA);

		printf( "test = %i + %i - %i - %i = %i \n", int(inA[0]), int(inB[0]), int(inA[1]), int(inB[1]), int(outA) );

	}

	return 0;
}
