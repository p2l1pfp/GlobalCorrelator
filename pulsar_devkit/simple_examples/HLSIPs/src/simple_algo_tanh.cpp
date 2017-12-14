/*
HLS implementation of TANH function via LUT
*/
#include "simple_algo_tanh.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

// https://github.com/Xilinx/RFNoC-HLS-NeuralNet/blob/master/rfnoc/hls/test_activations/test_activations.h/cpp
void simple_algo_tanh_hw(val_t data, result_t& res){ 
    tanh<val_t, result_t>(data, res);
    return;
}

// THE END
