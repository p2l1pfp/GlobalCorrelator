#include <ap_int.h>

const unsigned int M = 8;  //number of bits in each data item
const unsigned int N = 16; //number of data items

void BatchersEvenOddMergeSort (ap_uint<M> work_array[N]);
void EvenOddIterSorter(ap_uint<M> work_array[N]);