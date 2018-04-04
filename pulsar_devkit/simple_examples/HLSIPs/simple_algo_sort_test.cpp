#include <iostream>
#include <fstream>
#include "src/EvenOddIterSorter.h"

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

	//get the input data
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

	//perform sorting
	sorted_data = SORT_METHOD(input_data);

	//save the result
	ap_uint<M> mask = ~0;
	for (unsigned i = 0; i < N; i++)
	{
		sorted_data_stream << (sorted_data & mask) << endl; // extract M LSBs
		sorted_data >>= M; // shift right M bits
	}

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