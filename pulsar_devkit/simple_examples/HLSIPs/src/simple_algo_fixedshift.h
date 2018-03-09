#ifndef SIMPLE_ALGO_FIXEDSHIFT_H
#define SIMPLE_ALGO_FIXEDSHIFT_H

#include "ap_int.h"
#include "ap_fixed.h"

typedef ap_fixed<12,7> ftype;

#define BHV_NBINS 72
#define BHV_NHALFBINS (BHV_NBINS/2)
#define BNV_SHIFT 3

void simple_algo_fixedshift_ref( ftype inA, ap_uint<10> inB, ftype &outA );
void simple_algo_fixedshift_hw( ftype inA, ap_uint<10> inB, ftype &outA );

#endif
