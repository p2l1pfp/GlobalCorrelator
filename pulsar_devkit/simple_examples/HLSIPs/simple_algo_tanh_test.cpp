/*
Example using tanh LUT
*/
#include <vector>
#include <cstdio>

#include "ap_fixed.h"
#include "src/simple_algo_tanh.h"

#define NTEST 1

int main() {
    val_t in_hw;
    result_t out_hw;
    float in,out;

    std::vector<float> values;
    values.reserve(NTEST);
    values[0] = 0.1;

    for (int i=0; i<NTEST; ++i) {

        in  = values[i];
        out = 0;

        simple_algo_tanh_ref(in, out);
        std::cout << " REF : tanh(" << in << ") = " << out << std::endl;

        in_hw  = values[i];
        out_hw = 0;
        simple_algo_tanh_hw(in_hw, out_hw);
        std::cout << " HW  : tanh(" << in_hw << ") = " << out_hw << std::endl;
    }

    return 0;
}
