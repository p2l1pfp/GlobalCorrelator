#ifndef SIMPLE_ALGO_ARRAY_H
#define SIMPLE_ALGO_ARRAY_H

#define N_INPUTS  2
#define N_OUTPUTS 2
#include "ap_int.h"

struct struct_of_arrays {
    ap_int<32> inA[N_INPUTS];
    ap_int<32> inB[N_INPUTS];
};

void simple_algo_structarray_ref(struct_of_arrays structA, ap_int<32> outA[N_OUTPUTS] );
void simple_algo_structarray_hw(struct_of_arrays structA, ap_int<32> outA[N_OUTPUTS] );

#endif
