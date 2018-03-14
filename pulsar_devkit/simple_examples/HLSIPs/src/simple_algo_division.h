#ifndef SIMPLE_ALGO_DIVISION_H
#define SIMPLE_ALGO_DIVISION_H

#include "ap_int.h"
#include "ap_fixed.h"

// size of the LUT
#define N_TABLE_SIZE_NUM 1533 //Maximum number is 2045 for some reason (SIGSEGV otherwise)
#define N_TABLE_SIZE_DEN 1533 //Maximum number is 2045 for some reason (SIGSEGV otherwise)

typedef ap_uint<11> val_t;
// Type used for LUT (ap_fixed<X,Y>)
#define AP_FIXED_SIZE 14
#define AP_FIXED_DEC 11
typedef ap_fixed<AP_FIXED_SIZE,AP_FIXED_DEC> result_t;

// reference and hardware functions
void simple_algo_division_ref(int in_num, int in_den, float& out);
void simple_algo_division_hw(val_t data_num, val_t data_den, result_t& res);


// *************************************************
//       Division
// *************************************************
template<class data_T, int N_TABLE_NUM, int N_TABLE_DEN>
void init_division_table(data_T table_out[N_TABLE_NUM*N_TABLE_DEN]) {
    // Implement division lookup
    for (int inum = 0; inum < N_TABLE_NUM; inum++) {
        for (int iden = 0; iden < N_TABLE_DEN; iden++) {
            int index = (inum*N_TABLE_NUM)+iden;
            // Compute lookup table function
            data_T real_val = (iden>0) ? float(inum)/iden : 0;
            table_out[index] = real_val;
        }
    }
    return;
}


template<class data_T, class res_T, int TABLE_SIZE_NUM, int TABLE_SIZE_DEN>
void division(data_T &data_num, data_T &data_den, res_T &res) {
    // Initialize the lookup table
    res_T division_table[TABLE_SIZE_NUM*TABLE_SIZE_DEN];
    init_division_table<res_T, TABLE_SIZE_NUM, TABLE_SIZE_DEN>(division_table);

    // Index into the lookup table based on data
    int index_num, index_den, index;

    //#pragma HLS PIPELINE

    if (data_num < 0) data_num = 0;
    if (data_den < 0) data_den = 0;
    if (data_num > TABLE_SIZE_NUM-1) data_num = TABLE_SIZE_NUM-1;
    if (data_den > TABLE_SIZE_DEN-1) data_den = TABLE_SIZE_DEN-1;
    index = (data_num*TABLE_SIZE_NUM) + data_den;
    res = division_table[index];

    return;
}


// Default table size provided here:
template<class data_T, class res_T>
void division(data_T &data_num, data_T &data_den, res_T &res) { 
    /* Get the division value from the LUT */
    if(data_den==0) {
        std::cout << "WARNING::division::data_den==0" << std::endl;
        return;
    }
    division<data_T, res_T, N_TABLE_SIZE_NUM, N_TABLE_SIZE_DEN>(data_num, data_den, res); 
    return;
}

#endif
