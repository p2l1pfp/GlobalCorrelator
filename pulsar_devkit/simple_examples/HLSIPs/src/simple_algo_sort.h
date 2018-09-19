#include <ap_int.h>

const unsigned int M = 10; //number of bits in each data item
const unsigned int N = 128; //number of data items

void BatchersEvenOddMergeSort(ap_uint<M> work_array[N]);
void BitonicSort(ap_uint<M> work_array[N]);
void BitonicSortOptimized(ap_uint<M> work_array[N]);
void BitonicSortOptimizedInline(ap_uint<M> work_array[N]);
void EvenOddIterSorter(ap_uint<M> work_array[N]);
