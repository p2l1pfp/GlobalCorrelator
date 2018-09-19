#include "simple_algo_sort.h"
#include <assert.h>

template<class array_t, class index_t>
void exchange(array_t a[], index_t i, index_t j) {
    #pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}

/*
template<class array_t, class index_t, class mask_t>
void select(array_t a[], index_t i, index_t j, mask_t mask) {
    #pragma HLS function_instantiate variable=mask
    int ij=i^j;
    if ((ij)>i) {
        if ((i&mask)==0 && a[i] > a[ij]) 
            exchange(a,i,ij);
        if ((i&mask)!=0 && a[i] < a[ij])
            exchange(a,i,ij);
    }
}
*/

template<class array_t, class index_t, class mask_t>
void elementLoop(array_t a[], index_t j, mask_t mask) {
    #pragma HLS INLINE
    LOOP_OVER_ELEMENTS: for (int i=0; i<N; i++) {
#if (INPUT_DATA_SIZE>=128)
        #pragma HLS UNROLL skip_exit_check //factor=32
#endif
        int ij=i^j;
        if ((ij)>i) {
            if ((i&mask)==0 && a[i] > a[ij]) 
                exchange(a,i,ij);
            if ((i&mask)!=0 && a[i] < a[ij])
                exchange(a,i,ij);
        }
        //select(a,i,j,mask);
    }
}

void BitonicSort(ap_uint<M> work_array[N]) {
    int i,j,k;

    LOOP_OVER_ARRAY: for (k=2; k<=N; k=2*k) {
        #pragma HLS PIPELINE II=1
        //assert(k>>1<=8);
        JLOOP: for (j=k>>1; j>0; j=j>>1) {
            #pragma HLS loop_tripcount min=1 max=8
            ILOOP: for (i=0; i<N; i++) {
                int ij=i^j;
                if ((ij)>i) {
                    if ((i&k)==0 && work_array[i] > work_array[ij]) 
                        exchange(work_array,i,ij);
                    if ((i&k)!=0 && work_array[i] < work_array[ij])
                        exchange(work_array,i,ij);
                }
            }
        }
    }
}

void BitonicSortOptimized(ap_uint<M> work_array[N]) {
    // HLS csynth says it can't meeting timing requirements if II<4 for N=16
    // HLS csynth says it can't meeting timing requirements if II<5 for N=32
    // HLS csynth says it can't meeting timing requirements if II<7 for N=64
    // HLS csynth says it can't meeting timing requirements if II<10 for N=128
    #pragma HLS PIPELINE II=4
    #pragma HLS ARRAY_PARTITION variable=work_array complete
    int i,j;

    LOOP2: for (j=1; j>0; j=j>>1) {
        ILOOP2: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&2)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&2)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }

    LOOP4: for (j=2; j>0; j=j>>1) {
        ILOOP4: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&4)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&4)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }

    LOOP8: for (j=4; j>0; j=j>>1) {
        ILOOP8: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&8)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&8)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }

    LOOP16: for (j=8; j>0; j=j>>1) {
        ILOOP16: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&16)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&16)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }

#if (INPUT_DATA_SIZE>=32)
    LOOP32: for (j=16; j>0; j=j>>1) {
        ILOOP32: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&32)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&32)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }
#if (INPUT_DATA_SIZE>=64)
    LOOP64: for (j=32; j>0; j=j>>1) {
        ILOOP64: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&64)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&64)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }
#if (INPUT_DATA_SIZE>=128)
    LOOP128: for (j=64; j>0; j=j>>1) {
        ILOOP128: for (i=0; i<N; i++) {
            int ij=i^j;
            if ((ij)>i) {
                if ((i&128)==0 && work_array[i] > work_array[ij]) 
                    exchange(work_array,i,ij);
                if ((i&128)!=0 && work_array[i] < work_array[ij])
                    exchange(work_array,i,ij);
            }
        }
    }
#endif
#endif
#endif
}

void BitonicSortOptimizedInline(ap_uint<M> work_array[N]) {
    // HLS csynth says it can't meeting timing requirements if II<4 for N=16
    // HLS csynth says it can't meeting timing requirements if II<5 for N=32
    // HLS csynth says it can't meeting timing requirements if II<7 for N=64
    // HLS csynth says it can't meeting timing requirements if II<10 for N=128
    #pragma HLS PIPELINE II=10
    #pragma HLS ARRAY_PARTITION variable=work_array complete
    int j = 0;

    LOOP2: for (j=1; j>0; j=j>>1) {
        elementLoop(work_array,j,2);
    }

    LOOP4: for (j=2; j>0; j=j>>1) {
        elementLoop(work_array,j,4);
    }

    LOOP8: for (j=4; j>0; j=j>>1) {
        elementLoop(work_array,j,8);
    }

    LOOP16: for (j=8; j>0; j=j>>1) {
        elementLoop(work_array,j,16);
    }

#if (INPUT_DATA_SIZE>=32)
    LOOP32: for (j=16; j>0; j=j>>1) {
        elementLoop(work_array,j,32);
    }
#if (INPUT_DATA_SIZE>=64)
    LOOP64: for (j=32; j>0; j=j>>1) {
        elementLoop(work_array,j,64);
    }
#if (INPUT_DATA_SIZE>=128)
    LOOP128: for (j=64; j>0; j=j>>1) {
        elementLoop(work_array,j,128);
    }
#endif
#endif
#endif
}