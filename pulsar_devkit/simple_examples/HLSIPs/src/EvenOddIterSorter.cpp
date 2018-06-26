#include "simple_algo_sort.h"

void EvenOddIterSorter (ap_uint<M> work_array[N])
{
	bool sorting_completed;
	ap_uint<M> even[N];
	
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
}