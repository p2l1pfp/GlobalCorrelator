#include <iostream>
#include <fstream>
#include <string>
#include "src/simple_algo_sort.h"

#define STRINGIZE(x) #x
#define STRINGIZE_VALUE_OF(x) STRINGIZE(x)
#define CONCAT2(a, b) a ## b
#define CONCAT(a, b) CONCAT2(a, b)
#define TOPFUNCTION CONCAT(SORT_METHOD, WRAPPER)

//error codes
const int SORT_ERROR = 200;
const int OK = 0;
using namespace std;

int main ()
{
	ap_uint<N*M> input_data, sorted_data;
	uint32_t item_tmp = 0;
	ap_uint<M> item = 0;

	string ifile = string("input_data_") + STRINGIZE_VALUE_OF(INPUT_DATA_SIZE) + ".dat";
	string gfile = string("sorted_data_") + STRINGIZE_VALUE_OF(INPUT_DATA_SIZE) + ".gold.dat";
	string ofile = string("sorted_data_") + STRINGIZE_VALUE_OF(INPUT_DATA_SIZE) + ".dat";

	ifstream unsorted_data_stream(ifile.c_str()); // open for reading
	ofstream sorted_data_stream(ofile.c_str()); // open for writing

	//0. Get the input data
	cout << "Reading input data from " << ifile << " ... ";
	if (!unsorted_data_stream.is_open())
  	{
    	cout << endl << "\tThe file is unable to open!" << '\n';
    	return 1;
  	}
  	else
  	{
		for (unsigned i = 0; i < N; i++)
		{
			unsorted_data_stream >> item_tmp;
			item = item_tmp;
			//cout << item << endl;
			input_data <<= M; // shift left M bits
			input_data |= item; // write M LSBs
		}
		cout << "DONE" << endl;
	}

	//1. Fill in the work array
	ap_uint<M> work_array[N];
	ap_uint<M> mask = ~0;
	init_loop: for (unsigned i = N; i > 0; i--)
	{
		#pragma HLS UNROLL
		work_array[i-1] = input_data & mask; // extract M LSBs
		input_data >>= M;                    // shift right M bits
	}

	//2. Sort the data
	cout << "Using the top function " << STRINGIZE_VALUE_OF(TOPFUNCTION) << endl;
	TOPFUNCTION(work_array);

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
	string cmd = string("diff -w ") + ofile + " " + gfile;
	if (system(cmd.c_str()))
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
