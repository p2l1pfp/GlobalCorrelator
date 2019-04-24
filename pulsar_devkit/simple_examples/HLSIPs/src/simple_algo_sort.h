#include <ap_int.h>

const unsigned int M = 16; //number of bits in each data item
const unsigned int N = INPUT_DATA_SIZE; //number of data items (rounded up to next power of 2)

void BatchersEvenOddMergeSort(ap_uint<M> work_array[N]);
void BitonicSort(ap_uint<M> work_array[N]);
void BitonicSortOptimized(ap_uint<M> work_array[N]);
void BitonicSortOptimizedInline(ap_uint<M> work_array[N]);
void EvenOddIterSorter(ap_uint<M> work_array[N]);
