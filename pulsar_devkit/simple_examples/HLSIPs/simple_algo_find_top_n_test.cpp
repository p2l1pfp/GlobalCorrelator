#include <iostream>
#include <random>
#include <algorithm>
#include <iomanip>
#include "src/simple_algo_find_top_n.h"

#define STRINGIZE(x) #x
#define STRINGIZE_VALUE_OF(x) STRINGIZE(x)
#define CONCAT2(a, b) a ## b
#define CONCAT(a, b) CONCAT2(a, b)
#define TOPFUNCTION CONCAT(FindTopN_, METHOD)

//error codes
const int SORT_ERROR = 200;
const int OK = 0;
using namespace std;

struct gt
{
    template<class T>
    bool operator()(T const &a, T const &b) const { return a > b; }
};

int main () {
    //0. Generating the input data and fill the work_array
    cout << "Generating input data in range [0," << PWRTWO(M) << "] and filling work_array ... " << flush;
    std::mt19937 rng;
    rng.seed(std::random_device()());
    std::uniform_int_distribution<std::mt19937::result_type> distM(0,PWRTWO(M)-1); // distribution in range [0, 2^M]
    value_t work_array[N];
    for (unsigned int i=0; i<128; i++) {
        work_array[i] = distM(rng);
    }
    cout << "DONE" << endl;

    //1. Generate the golden data using C++ sorting
    cout << "Sorting the work_array to make the golden_array ... " << flush;
    value_t golden_array[N];
    std::copy(std::begin(work_array), std::end(work_array), std::begin(golden_array));
    std::sort(golden_array,golden_array+128,gt());
    cout << "DONE" << endl;

    //2. Sort the data in HW
    cout << "Finding the top " << O << "/" << N << " values from work_array using "
         << STRINGIZE_VALUE_OF(TOPFUNCTION) << " ... " << flush;
    value_t result_array[O];
    TOPFUNCTION(work_array, result_array);
    cout << "DONE" << endl << endl;

    //3. Print the arrays
    cout << "Index  Input  Golden  Output" << endl
         << "=====  =====  ======  ======" << endl;
    for (unsigned int i=0; i<N; i++) {
        cout << setw(5) << i << setw(7) << work_array[i] << setw(8) << golden_array[i];
        if (i<O) cout << setw(8) << result_array[i];
        cout << endl;
    }

    //4. Check the result
    cout << "Checking the result ... " << endl;
    for (unsigned int i=0; i<O; i++) {
        if (result_array[i] != golden_array[i]) {
            cout << "FAIL: Output DOES NOT match the golden output." << endl;
            return SORT_ERROR;      
        }
    }
    cout << "PASS: The output MATCHES the golden output!" << endl;
    return OK;
}
