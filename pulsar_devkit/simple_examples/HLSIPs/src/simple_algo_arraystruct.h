#ifndef SIMPLE_ALGO_ARRAYSTRUCT_H
#define SIMPLE_ALGO_ARRAYSTRUCT_H

#define N_INPUTS  2
#define N_OUTPUTS 2
#include "ap_int.h"

struct simple_struct {
    ap_int<32> inA;
    ap_int<32> inB;
};

void simple_algo_arraystruct_ref(simple_struct structA[N_INPUTS], ap_int<32> outA[N_OUTPUTS] );
void simple_algo_arraystruct_hw(simple_struct structA[N_INPUTS], ap_int<32> outA[N_OUTPUTS] );

#endif
