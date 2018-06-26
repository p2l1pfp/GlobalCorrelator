/*
HLS implementation of TANH function via LUT
*/
#include "simple_algo_division.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

// https://github.com/Xilinx/RFNoC-HLS-NeuralNet/blob/master/rfnoc/hls/test_activations/test_activations.h/cpp
void simple_algo_division_hw(val_t data_num, val_t data_den, result_t& res){
    division<val_t, result_t>(data_num, data_den, res);
    return;
}

// THE END
