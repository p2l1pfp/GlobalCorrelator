#ifndef SIMPLE_ALGO_ARRAY_H
#define SIMPLE_ALGO_ARRAY_H

#include "ap_int.h"

void simple_algo_array_ref( ap_int<32> inA[2], ap_int<32> inB[2], ap_int<32> &outA );
void simple_algo_array_hw( ap_int<32> inA[2], ap_int<32> inB[2], ap_int<32> &outA );

#endif
