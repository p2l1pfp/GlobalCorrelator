#include "simple_algo_find_max.h"
#ifdef DEBUG
    #include "utility.h"
#endif

binvalue_t FourCompParallelFindMax(binvalue_t input_array[NBINS], binindex_t &max_index) {
    #pragma HLS PIPELINE II=1
    #pragma HLS array_partition variable=input_array complete dim=1

    #ifdef DEBUG
        std::cout<<"===================================="<<std::endl;
        std::cout<<"BITS_TO_STORE_NBINS="<<BITS_TO_STORE_NBINS<<std::endl;
        std::cout<<"MAXIMUM_SEARCH_SIZE="<<MAXIMUM_SEARCH_SIZE<<std::endl;
        std::cout<<"MAXIMUM_SEARCH_SIZE_ITERATIONS="<<MAXIMUM_SEARCH_SIZE_ITERATIONS<<std::endl;
        std::cout<<"MAXIMUM_SEARCH_SIZE_ITERATIONS_FOUR="<<MAXIMUM_SEARCH_SIZE_ITERATIONS_FOUR<<std::endl;
        std::cout<<"MAXIMUM_SEARCH_SIZE_ITERATIONS_TWO="<<MAXIMUM_SEARCH_SIZE_ITERATIONS_TWO<<std::endl;
        std::cout<<"IS_EVEN(128)="<<IS_EVEN(128)<<std::endl;
        std::cout<<"IS_ODD(128)="<<IS_ODD(128)<<std::endl;
        std::cout<<"===================================="<<std::endl;
    #endif

    binvalue_t values_array[MAXIMUM_SEARCH_SIZE];
    binindex_t index_array[MAXIMUM_SEARCH_SIZE];
    #pragma HLS array_partition variable=values_array complete dim=1
    #pragma HLS array_partition variable=index_array complete dim=1
    copy_to_p2_array<binvalue_t,binindex_t,NBINS,MAXIMUM_SEARCH_SIZE>(input_array,values_array,index_array);
    #ifdef DEBUG
        show<binvalue_t,MAXIMUM_SEARCH_SIZE>(values_array);
    #endif

    binvalue_t larger_of_pair_array[MAXIMUM_SEARCH_SIZE];
    binindex_t larger_of_pair_index_array[MAXIMUM_SEARCH_SIZE];
    #pragma HLS array_partition variable=larger_of_pair_array complete dim=1
    #pragma HLS array_partition variable=larger_of_pair_index_array complete dim=1

    ITERATIONLOOP4: for (unsigned int iteration=0; iteration<MAXIMUM_SEARCH_SIZE_ITERATIONS_FOUR; ++iteration) {
        #pragma HLS UNROLL

        #ifdef DEBUG
            std::cout<<"iteration="<<iteration<<std::endl;
            std::cout<<"PWRTWO(iteration)="<<PWRTWO(iteration)<<std::endl;
            std::cout<<"MAXIMUM_SEARCH_SIZE="<<MAXIMUM_SEARCH_SIZE<<std::endl;
            std::cout<<"128/PWRTWO((BITS_TO_REPRESENT(4)-1)*iteration)="<<128/PWRTWO((BITS_TO_REPRESENT(4)-1)*iteration)<<std::endl;
        #endif

        initialize_array<binvalue_t>(larger_of_pair_array,MAXIMUM_SEARCH_SIZE);
        initialize_array<binindex_t>(larger_of_pair_index_array,MAXIMUM_SEARCH_SIZE);

        COMPARATORLOOP4: for (int pair=0; pair<128/PWRTWO((BITS_TO_REPRESENT(4)-1)*iteration); pair+=4) {
            #pragma HLS UNROLL
            comparator4(values_array[pair], values_array[pair+1],values_array[pair+2], values_array[pair+3],
                        index_array[pair], index_array[pair+1],index_array[pair+2], index_array[pair+3],
                        larger_of_pair_array[pair>>2],larger_of_pair_index_array[pair>>2]);
        }

        copy_array<binvalue_t,MAXIMUM_SEARCH_SIZE>(larger_of_pair_array,values_array);
        copy_array<binindex_t,MAXIMUM_SEARCH_SIZE>(larger_of_pair_index_array,index_array);
        #ifdef DEBUG
            show<binvalue_t,MAXIMUM_SEARCH_SIZE>(values_array);
        #endif
    }
    ITERATIONLOOP2: for (unsigned int iteration=0; iteration<MAXIMUM_SEARCH_SIZE_ITERATIONS_TWO; ++iteration) {
        #pragma HLS UNROLL

        #ifdef DEBUG
            std::cout<<"iteration2="<<iteration<<std::endl;
        #endif

        initialize_array<binvalue_t>(larger_of_pair_array,MAXIMUM_SEARCH_SIZE);
        initialize_array<binindex_t>(larger_of_pair_index_array,MAXIMUM_SEARCH_SIZE);
        comparator<binvalue_t,binindex_t>(values_array[0], values_array[1], index_array[0], index_array[1],
                                          larger_of_pair_array[0],larger_of_pair_index_array[0]);
        copy_array<binvalue_t,MAXIMUM_SEARCH_SIZE>(larger_of_pair_array,values_array);
        copy_array<binindex_t,MAXIMUM_SEARCH_SIZE>(larger_of_pair_index_array,index_array);
    }
    #ifdef DEBUG
        show<binvalue_t,MAXIMUM_SEARCH_SIZE>(values_array);
    #endif

    #ifdef DEBUG
        std::cout<<"values_array[0]="<<values_array[0]<<std::endl;
    #endif
    max_index = index_array[0];
    return values_array[0];
}