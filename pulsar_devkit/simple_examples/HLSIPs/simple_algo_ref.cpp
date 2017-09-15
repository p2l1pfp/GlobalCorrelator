#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo.h"

void simple_algo_ref( ap_int<32> inA, ap_int<32> inB, ap_int<32> &outA ) {

	outA = inA + inB;

}

