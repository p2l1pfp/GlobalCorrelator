#ifndef SIMPLE_ALGO_H
#define SIMPLE_ALGO_H

#include "ap_int.h"

void simple_algo_ref( ap_int<32> inA, ap_int<32> inB, ap_int<32> &outA );
void simple_algo_hw( ap_int<32> inA, ap_int<32> inB, ap_int<32> &outA );

#endif
