#include "simple_algo_sort.h"

template<class index_t, class array_t>
void exch(array_t a[], index_t i, index_t j) {
    //#pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}

void BatchersEvenOddMergeSort (ap_uint<M> work_array[N])
{
    const int l = 0;
    const int r = N - 1;
    const int n = r-l+1;

    PLOOP: for (int p=1; p<n; p+=p) {
        #pragma HLS PIPELINE II=1
        KLOOP: for (int k=p; k>0; k/=2) {
            #pragma HLS UNROLL
            JLOOP: for (int j=k%p; j+k<n; j+=(k+k)) {
                #pragma HLS UNROLL
                ILOOP: for (int i=0; i<n-j-k; i++) {
                    #pragma HLS UNROLL
                    if ((j+i)/(p+p) == (j+i+k)/(p+p)) {
                        int i1 = l + j + i;
                        int i2 = l + j + i + k;
                        if (work_array[i1] > work_array[i2]) {
                            exch(work_array, i1, i2);
                        }
                    }
                }
            }
        }
    }
}