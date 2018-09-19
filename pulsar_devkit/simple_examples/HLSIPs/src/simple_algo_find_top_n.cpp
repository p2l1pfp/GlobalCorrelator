#include "simple_algo_find_top_n.h"

value_t comparator4(value_t bin1, value_t bin2, value_t bin3, value_t bin4,
       		        unsigned int &index0, unsigned int &index1, unsigned int &index2, unsigned int &index3) {
	#pragma HLS INLINE
    if (bin1 >= bin2 && bin1 >= bin3 && bin1 >= bin4) {
        index0--;
        return bin1;
    }
    else if (bin2 >= bin3 && bin2 >= bin4) {
        index1--;
        return bin2;
    }
    else if (bin3 >= bin4) {
        index2--;
        return bin3;
    }
    else {
        index3--;
        return bin4;
    }
}

template<class array_t, class index_t>
void exchange(array_t a[], index_t i, index_t j) {
    #pragma HLS INLINE
    array_t t = a[i];
    a[i] = a[j];
    a[j] = t;
}

template<class array_t, class index_t, class mask_t>
void elementLoop(array_t a[], index_t j, mask_t mask) {
    #pragma HLS INLINE
    LOOP_OVER_ELEMENTS: for (int i=0; i<N_Partial; i++) {
        int ij=i^j;
        if ((ij)>i) {
            if ((i&mask)==0 && a[i] > a[ij]) 
                exchange(a,i,ij);
            if ((i&mask)!=0 && a[i] < a[ij])
                exchange(a,i,ij);
        }
    }
}

void BitonicSort(value_t to_sort[N_Partial]) {
    #pragma HLS INLINE
    #pragma HLS ARRAY_PARTITION variable=to_sort complete
    int j = 0;

    //for (unsigned int j=0; j<N_Partial; j++) {
    //	std::cout << to_sort[j] << std::endl;
    //}
    //std::cout << std::endl;

    LOOP2: for (j=1; j>0; j=j>>1) {
        elementLoop(to_sort,j,2);
    }

    LOOP4: for (j=2; j>0; j=j>>1) {
        elementLoop(to_sort,j,4);
    }

    LOOP8: for (j=4; j>0; j=j>>1) {
        elementLoop(to_sort,j,8);
    }

    LOOP16: for (j=8; j>0; j=j>>1) {
        elementLoop(to_sort,j,16);
    }

    LOOP32: for (j=16; j>0; j=j>>1) {
        elementLoop(to_sort,j,32);
    }
}

void selectSortArray(value_t work_array[N], value_t to_sort[N_Partial], int group) {
	#pragma HLS INLINE
	SPLIT_ARRAY_LOOP: for (unsigned int j=0; j<N_Partial; j++) {
		to_sort[j] = work_array[(N_Partial*group)+j];
#if DEBUG == 1
		printf("%i\n",int(work_array[(N_Partial*group)+j]));
#endif
	}
#if DEBUG == 1
	printf("\n");
#endif
}

void FindTopN_SortAndSelect(value_t work_array[N], value_t result_array[O]) {
    #pragma HLS PIPELINE II=1
    #pragma HLS ARRAY_PARTITION variable=work_array complete
    #pragma HLS ARRAY_PARTITION variable=result_array complete

	// This version of the algorithm relys on the fact that we can divide the values array
	//  into 4 equal parts or size 32. While the size 32 part can be modified for larger arrays,
	//  it must also be a power of two and a larger bitonic sort will take many more resources.
	//  There are many reasons why moving outside the (64,128] size range would be unwise.
	assert(N>64 || N<=128);

	// Copy the input array to an array which is guaranteed to be a power of 2 in size.
	//  This is necessary as the bitonic sort requires that its input array be a power of 2.
	//  Also, the function has been designed to divide 128 into four equal parts of 32.
	value_t values_array[MAXIMUM_SEARCH_SIZE];
	index_t index_array[MAXIMUM_SEARCH_SIZE];
	#pragma HLS ARRAY_PARTITION variable=values_array complete
	#pragma HLS ARRAY_PARTITION variable=index_array complete
	copy_to_p2_array<value_t,index_t,N,MAXIMUM_SEARCH_SIZE>(work_array,values_array,index_array);

	// Divide the larger array into four equal parts of size N_Partial, ideally size 32.
	value_t to_sort_0[N_Partial];
	value_t to_sort_1[N_Partial];
	value_t to_sort_2[N_Partial];
	value_t to_sort_3[N_Partial];
	#pragma HLS ARRAY_PARTITION variable=to_sort_0 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=to_sort_1 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=to_sort_2 dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=to_sort_3 dim=1 complete
#if DEBUG == 1
    printf("Starting selection of the arrays to sort\n");
#endif
    selectSortArray(values_array,to_sort_0,0);
    selectSortArray(values_array,to_sort_1,1);
    selectSortArray(values_array,to_sort_2,2);
    selectSortArray(values_array,to_sort_3,3);

    // Sort each of the smaller arrays using a bitonic sort. This type of sorting algorithm has
    //  a theoretical II of O((ln(N))**2), but we find that this is much faster after optimization.
#if DEBUG == 1
    printf("Starting bitonic sort\n");
#endif
    BitonicSort(to_sort_0);
    BitonicSort(to_sort_1);
    BitonicSort(to_sort_2);
    BitonicSort(to_sort_3);

#if DEBUG == 1
    for (unsigned int i=0; i<N_Partial; i++) {
    	printf("%i %i %i %i\n",int(to_sort_0[i]),int(to_sort_1[i]),int(to_sort_2[i]),int(to_sort_3[i]));
    }
#endif

    // Use a 4-wise comparison to select the top O values. This process occurs in O(O) time.
    unsigned int index0(N_Partial-1), index1(N_Partial-1), index2(N_Partial-1), index3(N_Partial-1);
    SELECT_TOP_N_LOOP: for (unsigned int i=0; i<O; i++) {
#if DEBUG==1
    	printf("comparator4(");
    	printf("%i,",int(to_sort_0[index0]));
    	printf("%i,",int(to_sort_1[index1]));
    	printf("%i,",int(to_sort_2[index2]));
    	printf("%i,",int(to_sort_3[index3]));
    	printf("%i,",index0);
    	printf("%i,",index1);
    	printf("%i,",index2);
    	printf("%i)\n",index3);
#endif
    	result_array[i] = comparator4(to_sort_0[index0],to_sort_1[index1],to_sort_2[index2],to_sort_3[index3],
    	            				  index0, index1, index2, index3);
#if DEBUG==1
    	printf("  result = %i\n",int(result_array[i]));
#endif
    }
}

void FindTopN_ParallelFindMax(value_t work_array[N], value_t result_array[O]) {
	#pragma HLS PIPELINE II=1
    #pragma HLS ARRAY_PARTITION variable=work_array complete
    #pragma HLS ARRAY_PARTITION variable=result_array complete

	value_t max;
	index_t max_index;
	value_t values_array[O][N];
	#pragma HLS ARRAY_PARTITION variable=values_array dim=1 complete
	#pragma HLS ARRAY_PARTITION variable=values_array dim=2 complete

	COPY_LOOP: for (unsigned int iO=0; iO<O; iO++) {
		#pragma HLS UNROLL
		copy_array<value_t,N>(work_array,values_array[iO]);
	}

	SELECT_TOP_N_LOOP: for (unsigned int iO=0; iO<O; iO++) {
		ParallelFindMax(values_array[iO], max, max_index);
#if DEBUG==1
		printf("\n%i\n",int(max));
		printf("%i\n",int(max_index));
#endif
		result_array[iO] = max;
		REMOVE_RESULT_LOOP: for (unsigned int iR=iO+1; iR<O; iR++) {
			#pragma HLS UNROLL
			values_array[iR][max_index] = 0;
		}
	}
}