#include <math.h>
#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "ap_fixed.h"
#include "src/simple_algo_division.h"

void simple_algo_division_ref(int in_num, int in_den, float& out){
    out = float(in_num)/in_den;
    return;
}

