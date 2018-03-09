#ifndef SIMPLE_ALGO_DIVISION_H
#define SIMPLE_ALGO_DIVISION_H

#include "ap_int.h"
#include "ap_fixed.h"

// size of the LUT
#define N_TABLE_SIZE_NUM 2048
#define N_TABLE_SIZE_DEN 2048
#define RANGE_NUM 2048
#define RANGE_DEN 2048

typedef ap_uint<11> val_t;
// Type used for LUT output (ap_fixed<X,Y>)
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
void init_division_table(data_T table_out[N_TABLE_NUM][N_TABLE_DEN]) {
    std::cout << "init sfsg1" << std::endl;
    // Implement division lookup
    for (int inum = 0; inum < N_TABLE_NUM; inum++) {
        for (int iden = 0; iden < N_TABLE_DEN; iden++) {
            // Convert from table index to X-value (unsigned 4-bit, range 0 to +4)
            //float in_val = (TANH_RANGE)*((N_TABLE-1)-inum)/float(N_TABLE);
            // Next, compute lookup table function
            data_T real_val = (iden>0) ? float(inum)/iden : 0; //tanh(in_val);
            //std::cout << "Tanh:  Lookup table Index: " <<  inum<< " In Value: " << in_val << " Result: " << real_val << std::endl;
            table_out[inum][iden] = real_val;
        }
    }
    std::cout << "init sfsg2" << std::endl;
    return;
}


template<class data_T, class res_T, int TABLE_SIZE_NUM, int TABLE_SIZE_DEN>
void division(data_T &data_num, data_T &data_den, res_T &res) {
    std::cout << "sfsg1 " << std::endl;
    // Initialize the lookup table
    res_T division_table[TABLE_SIZE_NUM][TABLE_SIZE_DEN];
    init_division_table<res_T, TABLE_SIZE_NUM, TABLE_SIZE_DEN>(division_table);
    std::cout << "sfsg2 " << std::endl;
    // Index into the lookup table based on data
    int index_num, index_den;

    #pragma HLS PIPELINE

    index_num = (1-data_num/RANGE_NUM)*TABLE_SIZE_NUM;
    index_den = (1-data_den/RANGE_DEN)*TABLE_SIZE_DEN;
    std::cout << "sfsg3 " << std::endl;
    if (index_num < 0) index_num = 0;
    if (index_den < 0) index_den = 0;
    if (index_num > TABLE_SIZE_NUM-1) index_num = TABLE_SIZE_NUM-1;
    if (index_den > TABLE_SIZE_DEN-1) index_den = TABLE_SIZE_DEN-1;
    res = division_table[index_num][index_den];
    std::cout << "sfsg4 " << std::endl;
    return;
}


// Default table size provided here:
template<class data_T, class res_T>
void division(data_T &data_num, data_T &data_den, res_T &res) { 
    /* Get the division value from the LUT */
    std::cout << "top: sfsg0 " << std::endl;
    if(data_den==0) {
        std::cout << "WARNING::division::data_num==0" << std::endl;
        return;
    }
    std::cout << "top: sfsg1 " << std::endl;
    std::cout << data_num << std::endl;
    std::cout << data_den << std::endl;
    std::cout << res << std::endl;
    division<data_T, res_T, N_TABLE_SIZE_NUM, N_TABLE_SIZE_DEN>(data_num, data_den, res); 
    std::cout << "top: sfsg2 " << std::endl;
    return;
}

#endif
