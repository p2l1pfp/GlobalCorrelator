#include <cstdio>
#include "src/simple_algo_fixedshift.h"
#include "ap_int.h"
#include "ap_fixed.h"

#define NTEST 1


int main() {
	
   ftype inA;
   ap_uint<10>   inB;
   ftype outA;

	for (int test = 1; test <= NTEST; ++test) {

		inA = 1.68;
        inB = 35;
		outA = 0;

		simple_algo_fixedshift_ref(inA, inB, outA);
		simple_algo_fixedshift_hw(inA, inB, outA);

        printf( "Result:\n=======\n" );
		printf( "test = %f %i %f \n", float(inA), int(inB), float(outA) );

	}

	return 0;
}
