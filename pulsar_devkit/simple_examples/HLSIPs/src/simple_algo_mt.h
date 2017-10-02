#ifndef SIMPLE_ALGO_MT_H
#define SIMPLE_ALGO_MT_H

#include "ap_int.h"

void simple_algo_mt_ref ( ap_int<8> inA1, ap_int<8> inA2, ap_int<8>inA3, ap_int<8>inA4, ap_int<8> inB1, ap_int<8> inB2, ap_int<8> inB3, ap_int<8> inB4, ap_int<32> &outA );//( ap_int<32> inA, ap_int<32> inB, ap_int<32> &outA );
void simple_algo_mt_hw( ap_int<8> inA1, ap_int<8> inA2, ap_int<8>inA3, ap_int<8>inA4, ap_int<8> inB1, ap_int<8> inB2, ap_int<8> inB3, ap_int<8> inB4, ap_int<32> &outA );//( ap_int<32> inA, ap_int<32> inB, ap_int<32> &outA );

#endif
