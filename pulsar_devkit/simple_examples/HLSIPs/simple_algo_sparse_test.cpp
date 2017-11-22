#include <cstdio>
#include "src/simple_algo_sparse.h"

using namespace std;

int main() {
	
  mytype input = 3.14159;
  mytype output[N] = {0,0,0,0};
  simple_algo_sparse_hw(input, output);
  
  for(int i=0; i<N; i++){
    cout << "Ouput " << i << ": " << output[i] << endl;
  }
  
  return 0;
}
