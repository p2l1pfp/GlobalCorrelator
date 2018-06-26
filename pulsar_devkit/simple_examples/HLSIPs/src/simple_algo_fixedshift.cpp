#include "simple_algo_fixedshift.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_fixedshift_hw( ftype inA, ap_uint<10> inB, ftype &outA ) {

    inA += inB;
    inA -= BHV_NHALFBINS;
    outA = (inA << BNV_SHIFT) + (1 << (BNV_SHIFT-1));

}
