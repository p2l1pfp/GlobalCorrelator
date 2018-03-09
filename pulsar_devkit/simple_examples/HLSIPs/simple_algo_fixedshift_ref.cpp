#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "ap_fixed.h"
#include "src/simple_algo_fixedshift.h"

void simple_algo_fixedshift_ref( ftype inA, ap_uint<10> inB, ftype &outA ) {
    inA += inB;
    inA -= BHV_NHALFBINS;
    outA = (inA << BNV_SHIFT) + ( 1 << (BNV_SHIFT-1) );
}

