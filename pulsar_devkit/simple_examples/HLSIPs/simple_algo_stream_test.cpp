#include "src/simple_algo_stream.h"
#include <cstdio>
#include <iostream>

int main() {
	
    in_t               in_ref[N_COLUMNS][N_ROWS];
    out_t              out_ref[N_OUTPUTS];
    hls::stream<invec> in_hw;
    hls::stream<out_t> out_hw_stream;
    out_t              out_hw[N_OUTPUTS];
  
    //Fill the inputs and reset the outputs
    for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        invec row;
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
            float value = (N_COLUMNS*iRow)+iCol+0.5;
            in_ref[iCol][iRow] = in_t(value);
            row.data[iCol] = in_t(value);
        }
        in_hw.write(row);
        out_ref[iRow] = 0;
    }

    //Produce a coe file from the inputs
    produce_coe_file(in_ref);

    //Run the ref and hw codes
    simple_algo_stream_ref(in_ref,out_ref);
    simple_algo_stream_hw(in_hw,out_hw_stream);

    //Read the output from the stream
    for(int iRow = 0; iRow < N_ROWS; ++iRow) {
        out_hw[iRow] = out_hw_stream.read();
    }

    //Print the input and the output
    int mismatch = 0;
    for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        if(iCol==0) printf("%8s","INPUT");
        printf("     C%2i",iCol);
        if(iCol==N_COLUMNS-1) {
            printf("%8s","REF");
            printf("%8s","HW");
            printf("%8s","Match");
            printf("\n");
        }
    }
    for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
            if (iCol==0) printf("  Row%3i",iRow);
            printf("%8.1f",float(in_ref[iCol][iRow]));
        }
        printf("%8i",int(out_ref[iRow]));
        printf("%8i",int(out_hw[iRow]));
        printf("%8i",(out_ref[iRow]==out_hw[iRow])?1:0);
        if(out_ref[iRow]!=out_hw[iRow]) mismatch++;
        printf("\n");
    }
    printf("Matches: %i/%i (%0.1f%%)\n",int(N_OUTPUTS-mismatch),N_OUTPUTS,(float(N_OUTPUTS-mismatch)/N_OUTPUTS)*100.);

    if(mismatch==0) return 0;
    else return -1;
}
