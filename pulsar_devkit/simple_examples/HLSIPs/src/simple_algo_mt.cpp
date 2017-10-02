#include "simple_algo_mt.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_mt_hw( ap_int<8> inA1, ap_int<8> inA2, ap_int<8>inA3, ap_int<8>inA4, ap_int<8> inB1, ap_int<8> inB2, ap_int<8> inB3, ap_int<8> inB4, ap_int<32> &outA ) {

  //		outA = inA + inB;
  outA = sqrt(2*inA1*inB1*(coshf(inA2-inB2) - cos(inA3-inB3)));
}
