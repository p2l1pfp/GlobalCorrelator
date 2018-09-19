#include <ap_int.h>

//From: https://stackoverflow.com/questions/27581671/how-to-compute-log-with-the-preprocessor
#define IS_REPRESENTIBLE_IN_D_BITS(D, N)                \
   (((unsigned long) N >= (1UL << (D - 1)) && (unsigned long) N < (1UL << D)) ? D : -1)
#define BITS_TO_REPRESENT(N)                             \
   (N == 0 ? 1 : (31                                     \
                  + IS_REPRESENTIBLE_IN_D_BITS( 1, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 2, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 3, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 4, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 5, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 6, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 7, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 8, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS( 9, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(10, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(11, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(12, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(13, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(14, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(15, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(16, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(17, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(18, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(19, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(20, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(21, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(22, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(23, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(24, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(25, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(26, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(27, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(28, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(29, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(30, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(31, N)    \
                  + IS_REPRESENTIBLE_IN_D_BITS(32, N)    \
                  )                                      \
      )
#define PWRTWO(x) (1 << (x))
#define IS_ODD(N) ((N) & 1)
#define IS_EVEN(N) (!((N) & 1))
#define CHECK_EVENODD(N) ((N%2==0)?1:0) //1 if even and 0 if odd

#define NBINS 72//200//72//16 //number of data items
#define NBITS_PER_BIN 9 //number of bits in each data item
#define BITS_TO_STORE_NBINS BITS_TO_REPRESENT(NBINS)+1
#define MAXIMUM_SEARCH_SIZE PWRTWO(BITS_TO_STORE_NBINS-1)
#define MAXIMUM_SEARCH_SIZE_ITERATIONS BITS_TO_REPRESENT(MAXIMUM_SEARCH_SIZE)-1
#define MAXIMUM_SEARCH_SIZE_ITERATIONS_TWO (IS_ODD(MAXIMUM_SEARCH_SIZE_ITERATIONS) ? 1 : 0)
#define MAXIMUM_SEARCH_SIZE_ITERATIONS_FOUR (IS_EVEN(MAXIMUM_SEARCH_SIZE_ITERATIONS) ? MAXIMUM_SEARCH_SIZE_ITERATIONS>>1 : (MAXIMUM_SEARCH_SIZE_ITERATIONS-1)>>1)

typedef ap_uint<NBITS_PER_BIN> binvalue_t;
typedef ap_uint<BITS_TO_STORE_NBINS> binindex_t;

template<class array_t>
inline void initialize_array(array_t arr[], const int size) {
    INITIALIZELOOP: for (unsigned int b = 0; b < size; ++b) {
        #pragma HLS UNROLL
        arr[b] = 0;
    }
}

//inline void copy_to_p2_array(binvalue_t input_array[NBINS], binvalue_t output_array[MAXIMUM_SEARCH_SIZE]) {
template<class array_t, class array2_t, int SIZE_SRC, int SIZE_DST>
inline void copy_to_p2_array(array_t input_array[SIZE_SRC], array_t output_array[SIZE_DST], array2_t output_array_index[SIZE_DST]) {
    COPYP2LOOP1: for(unsigned int i=0; i<SIZE_SRC; ++i) {
        #pragma HLS UNROLL
        output_array[i]       = input_array[i];
        output_array_index[i] = i;
    }
    COPYP2LOOP2: for(unsigned int i=SIZE_SRC; i<SIZE_DST; ++i) {
        #pragma HLS UNROLL
        output_array[i]       = 0;
        output_array_index[i] = MAXIMUM_SEARCH_SIZE;
    }
}

template<class array_t, int SIZE>
inline void copy_array(array_t input_array[SIZE], array_t output_array[SIZE]) {
    COPYLOOP: for(unsigned int i=0; i<SIZE; ++i) {
        #pragma HLS UNROLL
        output_array[i] = input_array[i];
    }
}

template<class bv_t, class bi_t>
inline void comparator(bv_t bin1, bv_t bin2, bi_t binindex1, bi_t binindex2, bv_t &res, bi_t &resindex) {
    if (bin1 >= bin2) {
        res = bin1;
        resindex = binindex1; 
    }
    else {
        res = bin2;
        resindex = binindex2;
    }
}

template<class bv_t, class bi_t>
inline void comparator4(bv_t bin1, bv_t bin2, bv_t bin3, bv_t bin4,
                        bi_t binindex1, bi_t binindex2, bi_t binindex3, bi_t binindex4,
                        bv_t &res, bi_t &resindex) {
    if (bin1 >= bin2 && bin1 >= bin3 && bin1 >= bin4) {
        res = bin1;
        resindex = binindex1;
    }
    else if (bin2 >= bin3 && bin2 >= bin4) {
        res = bin2;
        resindex = binindex2;
    }
    else if (bin3 >= bin4) {
        res = bin3;
        resindex = binindex3;
    }
    else {
        res = bin4;
        resindex = binindex4;
    }
}

binvalue_t ParallelFindMax(binvalue_t input_array[NBINS], binindex_t &max_index);
binvalue_t FourCompParallelFindMax(binvalue_t input_array[NBINS], binindex_t &max_index);
binvalue_t LinearFindMax(binvalue_t input_array[NBINS], binindex_t &max_index);