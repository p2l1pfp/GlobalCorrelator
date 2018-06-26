#include <iostream>
#include <fstream>
#include "src/simple_algo_sort.h"

//error codes
const int SORT_ERROR = 200;
const int OK = 0;
using namespace std;

int main ()
{
	ap_uint<N*M> input_data, sorted_data;
	uint32_t item_tmp = 0;
	ap_uint<M> item = 0;

	ifstream unsorted_data_stream("input_data.dat"); // open for reading
	ofstream sorted_data_stream("sorted_data.dat"); // open for writing

	//0. Get the input data
	cout << "Reading input data" << endl;
	if (!unsorted_data_stream.is_open())
  	{
    	cout << "The file is unable to open!" << '\n';
    	return 1;
  	}
  	else
  	{
		for (unsigned i = 0; i < N; i++)
		{
			unsorted_data_stream >> item_tmp;
			item = item_tmp;
			cout << item << endl;
			input_data <<= M; // shift left M bits
			input_data |= item; // write M LSBs
		}
	}

	//1. Fill in the work array
	ap_uint<M> work_array[N];
	ap_uint<M> mask = ~0;
	init_loop: for (unsigned i = N; i > 0; i--)
	{
		#pragma HLS UNROLL
		work_array[i-1] = input_data & mask; // extract M LSBs
		input_data >>= M;					 // shift right M bits
	}

	//2. Sort the data
	SORT_METHOD(work_array);

	//3. Write the result
	write_res_loop: for (unsigned i = 0; i < N; i++)
	{
		#pragma HLS UNROLL
		sorted_data <<= M; // shift left M bits
		sorted_data |= work_array[i]; // write M LSBs
	}

	//4. Save the result
	for (unsigned i = 0; i < N; i++)
	{
		sorted_data_stream << (sorted_data & mask) << endl; // extract M LSBs
		sorted_data >>= M; // shift right M bits
	}

	//5. Check the result
	cout << "Checking the result" << endl;
	if (system("diff -w sorted_data.dat sorted_data.gold.dat"))
	{
		cout << "FAIL: Output DOES NOT match the golden output." << endl;
		return SORT_ERROR;
	}
	else
	{
		cout << "PASS: The output MATCHES the golden output!" << endl;
		return OK;
	}
}