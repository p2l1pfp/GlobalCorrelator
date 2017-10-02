#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_mt.h"

void simple_algo_mt_ref( ap_int<8> inA1, ap_int<8> inA2, ap_int<8>inA3,ap_int<8>inA4, ap_int<8> inB1, ap_int<8> inB2, ap_int<8> inB3,ap_int<8> inB4, ap_int<32> &outA ){//( ap_int<32> inA, ap_int<32> inB, ap_int<32> &outA ) {

  outA = sqrt(2*inA1*inB1*(cosh(inA2-inB2) - cos(inA3-inB3)));//	outA = inA + inB;

}

