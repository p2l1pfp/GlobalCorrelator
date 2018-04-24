#include "simple_algo_find_max.h"
#ifdef DEBUG
    #include "utility.h"
#endif

binvalue_t LoopBasedFindMax(binvalue_t input_array[NBINS]) {
    #pragma HLS PIPELINE II=1
    #pragma HLS array_partition variable=input_array complete dim=1

    #ifdef DEBUG
        std::cout<<"================================"<<std::endl;
        std::cout<<"BITS_TO_STORE_NBINS="<<BITS_TO_STORE_NBINS<<std::endl;
        std::cout<<"MAXIMUM_SEARCH_SIZE="<<MAXIMUM_SEARCH_SIZE<<std::endl;
        std::cout<<"MAXIMUM_SEARCH_SIZE_ITERATIONS="<<MAXIMUM_SEARCH_SIZE_ITERATIONS<<std::endl;
        std::cout<<"================================"<<std::endl;
    #endif

    binvalue_t values_array[MAXIMUM_SEARCH_SIZE];
    binindex_t index_array[MAXIMUM_SEARCH_SIZE];
    #pragma HLS array_partition variable=values_array complete dim=1
    #pragma HLS array_partition variable=index_array complete dim=1
    copy_to_p2_array<binvalue_t,NBINS,MAXIMUM_SEARCH_SIZE>(input_array,values_array);
    #ifdef DEBUG
        show<binvalue_t,MAXIMUM_SEARCH_SIZE>(values_array);
    #endif

    //binvalue_t larger_of_pair_array[PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1)];
    //binindex_t larger_of_pair_index_array[PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1)];
    binvalue_t larger_of_pair_array[MAXIMUM_SEARCH_SIZE];
    binindex_t larger_of_pair_index_array[MAXIMUM_SEARCH_SIZE];
    #pragma HLS array_partition variable=larger_of_pair_array complete dim=1
    #pragma HLS array_partition variable=larger_of_pair_index_array complete dim=1

    ITERATIONLOOP: for (unsigned int iteration=0; iteration<MAXIMUM_SEARCH_SIZE_ITERATIONS; ++iteration) {
        #pragma HLS UNROLL

        #ifdef DEBUG
            std::cout<<"iteration="<<iteration<<std::endl;
            std::cout<<"PWRTWO(iteration)="<<PWRTWO(iteration)<<std::endl;
            std::cout<<"MAXIMUM_SEARCH_SIZE="<<MAXIMUM_SEARCH_SIZE<<std::endl;
            std::cout<<"PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1)="<<PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration)<<std::endl;
        #endif

        //initialize_array<binvalue_t>(larger_of_pair_array,PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1));
        //initialize_array<binindex_t>(larger_of_pair_index_array,PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1));
        initialize_array<binvalue_t>(larger_of_pair_array,MAXIMUM_SEARCH_SIZE);
        initialize_array<binindex_t>(larger_of_pair_index_array,MAXIMUM_SEARCH_SIZE);

        COMPARATORLOOP: for (int pair=0; pair<PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration); pair+=2) {
            #pragma HLS UNROLL
            comparator(values_array[pair], values_array[pair+1], index_array[pair], index_array[pair+1], larger_of_pair_array[pair>>1],larger_of_pair_index_array[pair>>1]);
        }

        //copy_to_p2_array<binvalue_t>(larger_of_pair_array,PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1),values_array,PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1));
        //copy_to_p2_array<binindex_t>(larger_of_pair_index_array,PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1),index_array,PWRTWO(MAXIMUM_SEARCH_SIZE_ITERATIONS-iteration-1));
        copy_array<binvalue_t,MAXIMUM_SEARCH_SIZE>(larger_of_pair_array,values_array);
        copy_array<binindex_t,MAXIMUM_SEARCH_SIZE>(larger_of_pair_index_array,index_array);
    }
    #ifdef DEBUG
        std::cout<<"values_array[0]="<<values_array[0]<<std::endl;
    #endif
    return values_array[0];
}