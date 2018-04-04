#include "EvenOddIterSorter.h"

ap_uint<N*M> EvenOddIterSorter (ap_uint<N*M> input_data)
{
	ap_uint<N*M> sorted_data;
	bool sorting_completed;
	
	ap_uint<M> work_array[N];
	ap_uint<M> even[N];
	
	//1. Fill in the work array
	ap_uint<M> mask = ~0;
	init_loop: for (unsigned i = N; i > 0; i--)
	{
		#pragma HLS UNROLL
		work_array[i-1] = input_data & mask; // extract M LSBs
		input_data >>= M;					 // shift right M bits
	}

	//2. Sort the data
	sorting_completed = false;
	sort_loop: while (!sorting_completed)
	{
		#pragma HLS PIPELINE II=1
		// even line of comparators
		sorting_completed = true;
		sort_even: for (unsigned j = 0; j < (N / 2); j++)
			#pragma HLS UNROLL
			if (work_array[2 * j] > work_array[2 * j + 1])
			{
				sorting_completed = false;
				even[2 * j]     = work_array[2 * j + 1];
				even[2 * j + 1] = work_array[2 * j];
			}
			else
			{
				even[2 * j]     = work_array[2 * j];
				even[2 * j + 1]	= work_array[2 * j + 1];
			}
		// odd line of comparators
		sort_odd: for (unsigned j = 0; j < (N / 2 - 1); j++)
			#pragma HLS UNROLL
			if (even[2 * j + 1] > even[2 * j + 2])
			{
				sorting_completed = false;
				work_array[2 * j + 1] = even[2 * j + 2];
				work_array[2 * j + 2] = even[2 * j + 1];
			}
			else
			{
				work_array[2 * j + 1] = even[2 * j + 1];
				work_array[2 * j + 2] = even[2 * j + 2];
			}
		work_array[0]   = even[0];
		work_array[N-1] = even[N-1];
	}

	//3. Write the result
	write_res_loop: for (unsigned i = 0; i < N; i++)
	{
		#pragma HLS UNROLL
		sorted_data <<= M; // shift left M bits
		sorted_data |= work_array[i]; // write M LSBs
	}

	return sorted_data;
}