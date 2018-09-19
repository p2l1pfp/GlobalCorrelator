#include "src/simple_algo_sum_arrays.h"
#include <cstdio>
#include <iostream>
#include <random>

int main() {
	
    type_t   in_ref[N_COLUMNS][N_ROWS];
    type_t   out_ref[N_OUTPUTS];
    invec    in_hw[N_COLUMNS];
    type_t   out_hw[N_OUTPUTS];
  
    std::default_random_engine generator;
    std::uniform_int_distribution<int> distribution(1,35);

    //Fill the inputs and reset the outputs
    for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {    
            //float value = (N_COLUMNS*iRow)+iCol;
            int value = distribution(generator);
            in_ref[iCol][iRow] = type_t(value);
            in_hw[iCol].data[iRow] = type_t(value);
        }
        out_ref[iRow] = 0;
        out_hw[iRow] = 0;
    }

    //Produce a coe file from the inputs
    produce_coe_file(in_ref);

    //Run the ref and hw codes
    printf("Running the reference function ... ");
    simple_algo_sum_arrays_ref(in_ref,out_ref);
    printf("DONE\nRunning the hardware function ... ");
    TOP_FUNC(in_hw,out_hw);
    printf("DONE\n");

    //Print the input and the output
    int mismatch = 0;
    for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        if(iCol==0) printf("%8s","INPUT");
        printf("   C%2i",iCol);
        if(iCol==N_COLUMNS-1) {
            printf("%6s","REF");
            printf("%6s","HW");
            printf("%6s","Match");
            printf("\n");
        }
    }
    for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
            if (iCol==0) printf("  Row%3i",iRow);
            printf("%6i",int(in_ref[iCol][iRow]));
        }
        printf("%6i",int(out_ref[iRow]));
        printf("%6i",int(out_hw[iRow]));
        printf("%6i",(out_ref[iRow]==out_hw[iRow])?1:0);
        if(out_ref[iRow]!=out_hw[iRow]) mismatch++;
        printf("\n");
    }
    printf("Matches: %i/%i (%0.1f%%)\n",int(N_OUTPUTS-mismatch),N_OUTPUTS,(float(N_OUTPUTS-mismatch)/N_OUTPUTS)*100.);

    if(mismatch==0) return 0;
    else return -1;
}
