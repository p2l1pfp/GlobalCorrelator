#include "simple_algo_struct.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

void simple_algo_struct_hw( simple_struct structA, ap_int<32> &outA ) {
	#ifdef __MEMBERS__
		outA = structA.sum();
		structA.clear();
		outA += structA.sum();
	#else
		outA = structA.inA + structA.inB;
		clear(structA);
		outA += (structA.inA + structA.inB);
	#endif
}