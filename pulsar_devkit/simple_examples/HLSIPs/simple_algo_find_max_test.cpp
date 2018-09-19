#include <iostream>
#include <fstream>
#include "src/simple_algo_find_max.h"

//error codes
const int SORT_ERROR = 200;
const int OK = 0;
const int DEBUG_RETURN = -200;
using namespace std;

int main ()
{
	ap_uint<NBINS*NBITS_PER_BIN> input_data;
	uint32_t item_tmp = 0;
	ap_uint<NBITS_PER_BIN> item = 0;

	//ifstream unsorted_data_stream("input_data.dat"); // open for reading
	ifstream unsorted_data_stream("input_data_72.dat"); // open for reading

	//0. Get the input data
	cout << "Reading input data" << endl;
	if (!unsorted_data_stream.is_open())
  	{
    	cout << "The file is unable to open!" << '\n';
    	return 1;
  	}
  	else
  	{
		for (unsigned i = 0; i < NBINS; i++)
		{
			unsorted_data_stream >> item_tmp;
			item = item_tmp;
			cout << item << endl;
			input_data <<= NBITS_PER_BIN; // shift left M bits
			input_data |= item; 		  // write M LSBs
		}
	}

	//1. Fill in the work array
	ap_uint<NBITS_PER_BIN> work_array[NBINS];
	ap_uint<NBITS_PER_BIN> mask = ~0;
	init_loop: for (unsigned i = NBINS; i > 0; i--)
	{
		#pragma HLS UNROLL
		work_array[i-1] = input_data & mask; // extract M LSBs
		input_data >>= NBITS_PER_BIN;		 // shift right M bits
	}

	//2. Sort the data
	binindex_t max_index;
	ap_uint<NBITS_PER_BIN> maximum_result = MAX_METHOD(work_array, max_index);

	//3. Check the result
	int golden_result = 501; //511//501//168
	#ifndef DEBUG
		cout << "Checking the result" << endl;
		if (maximum_result != golden_result)
		{
			cout << "FAIL: Output DOES NOT match the actual maximum ("<<golden_result<<")." << endl;
			return SORT_ERROR;
		}
		else
		{
			cout << "PASS: The output MATCHES "<<golden_result<<"!" << endl;
			return OK;
		}
	#else
		return DEBUG_RETURN;
	#endif
}