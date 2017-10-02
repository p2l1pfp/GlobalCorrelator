#include <cstdio>
#include "src/simple_algo_mt.h"
#include "ap_int.h"

#define NTEST 1


int main() {
	
	ap_int<8> inA1;
	ap_int<8> inA2;
	ap_int<8> inA3;
	ap_int<8> inA4;
	ap_int<8> inB1;
	ap_int<8> inB2;
	ap_int<8> inB3;
	ap_int<8> inB4;
	ap_int<32> outA;

	for (int test = 1; test <= NTEST; ++test) {

		inA1 = 5;
		inA2 = 3; 
		inA3 = 1;
		inA4 = 2;
		inB1 = 5;
		inB2 = 3;
		inB3 = 1;
		inB4 = 2;
		outA = 0;

		simple_algo_mt_ref(inA1, inA2, inA3, inA4, inB1, inB2, inB3, inB4, outA);
		simple_algo_mt_hw(inA1, inA2, inA3, inA4, inB1, inB2, inB3, inB4, outA);

		printf( "test = %i %i %i %i %i %i %i %i %i \n", int(inA1), int(inA2), int(inA3), int(inA4), int(inB1), int(inB2), int(inB3), int(inB4), int(outA) );

	}

	return 0;
}
