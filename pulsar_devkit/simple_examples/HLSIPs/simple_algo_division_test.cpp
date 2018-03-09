/*
Example using division LUT
*/
#include <vector>
#include <cstdio>
#include <utility>

#include "ap_int.h"
#include "ap_fixed.h"
#include "src/simple_algo_division.h"

#define NTEST 1

int main() {
    val_t in_num_hw, in_den_hw;
    result_t out_hw;
    int in_num,in_den;
    float out;

    std::vector<std::pair<int,int> > values;
    values.reserve(NTEST);
    values[0] = std::make_pair(236,140);

    for (int i=0; i<NTEST; ++i) {

        in_num  = values[i].first;
        in_den  = values[i].second;
        out = 0;

        simple_algo_division_ref(in_num, in_den, out);
        std::cout << " REF : division(" << in_num << ","<< in_den << ") = " << out << std::endl;

        in_num_hw  = values[i].first;
        in_den_hw  = values[i].second;
        out_hw = 0;
        simple_algo_division_hw(in_num_hw, in_den_hw, out_hw);
        std::cout << " HW  : division(" << in_num_hw << ","<< in_den_hw << ") = " << out_hw << std::endl;
    }

    return 0;
}
