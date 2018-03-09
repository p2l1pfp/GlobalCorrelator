#include "simple_algo_struct.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_struct_hw( simple_struct structA, ap_int<32> &outA ) {
	outA = structA.inA + structA.inB;
}