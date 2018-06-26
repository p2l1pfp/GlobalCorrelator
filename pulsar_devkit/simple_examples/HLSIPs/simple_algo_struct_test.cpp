#include <cstdio>
#include "src/simple_algo_struct.h"
#include "ap_int.h"

#define NTEST 1


int main() {

    simple_struct structA;
    ap_int<32> outA;

    for (int test = 1; test <= NTEST; ++test) {

        structA.inA = 1;
        structA.inB = 2;
        #ifdef __EXTENDED__
          structA.inC = 10;
        #endif
        outA = 0;

        simple_algo_struct_ref(structA, outA);
        simple_algo_struct_hw(structA, outA);

        printf( "test = %i %i %i \n", int(structA.inA), int(structA.inB), int(outA) );

    }

    return 0;
}