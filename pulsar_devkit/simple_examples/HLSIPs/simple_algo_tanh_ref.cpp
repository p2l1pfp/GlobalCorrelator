#include <math.h>
#include <cmath>
#include <algorithm>
#include "ap_fixed.h"
#include "src/simple_algo_tanh.h"

//void simple_algo_mt_ref( ap_fixed<12,3> in, ap_fixed<12,3>& out ){
void simple_algo_tanh_ref( float in, float& out ){
    out = tanh(in);
    return;
}

