#include <ap_int.h>

const unsigned int M = 8;  //number of bits in each data item
const unsigned int N = 16; //number of data items

ap_uint<N*M> EvenOddIterSorter(ap_uint<N*M> input_data); 