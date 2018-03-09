#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "src/simple_algo_struct.h"

void simple_algo_struct_ref( simple_struct structA, ap_int<32> &outA ) {
    outA = structA.inA + structA.inB;
}

