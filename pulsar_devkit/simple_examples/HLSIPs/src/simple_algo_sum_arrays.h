#ifndef SIMPLE_ALGO_SUM_ARRAYS_H
#define SIMPLE_ALGO_SUM_ARRAYS_H

// Xilinx Libraries
#include "ap_int.h"
#include "ap_fixed.h"

// STL Libraries
#include <cstdio>
#include <bitset>

#define N_COLUMNS     27
#define N_ROWS        24
#define N_OUTPUTS     N_ROWS
#define BITS_PER_WORD 11
#define MAXBIN        511

typedef ap_uint<BITS_PER_WORD>                                   type_t;
typedef struct { type_t data[N_ROWS]; }                          invec;
typedef ap_ufixed<BITS_PER_WORD+2,BITS_PER_WORD+2,AP_RND,AP_SAT> tmp_t; //+2 seems to lead to the best balance of timing and resources

inline void produce_coe_file(type_t in_ref[N_COLUMNS][N_ROWS]) {
	std::bitset<BITS_PER_WORD> bset_;

	FILE *file_ = fopen("input.coe", "w");
	fprintf(file_,"; Sample memory initialization file for Dual Port Block Memory,\n");
	fprintf(file_,"; v3.0 or later.\n");
	fprintf(file_,"; Board: Board_?\n");
	fprintf(file_,"; tmux: 1\n");
	fprintf(file_,";\n");
	fprintf(file_,"; This .COE file specifies the contents for a block memory\n");
	fprintf(file_,"; of depth=24, and width=2970. In this case, values are specified\n");
	fprintf(file_,"; in binary format.\n");
	fprintf(file_,"memory_initialization_radix=2;\n");
	fprintf(file_,"memory_initialization_vector=\n");
	
	for (int iRow = 0; iRow < N_ROWS; ++iRow) {
        for (int iCol = 0; iCol < N_COLUMNS; ++iCol) {
        	bset_.reset();
        	//printf("%.1f\n",float(in_ref[iCol][iRow]));
	        for(int b=0; b<BITS_PER_WORD; b++) {
    	    	bset_.set(b,in_ref[iCol][iRow][b]);
    	       	//if(iRow==0 && iCol<2) {
        	//	printf("%i",int(in_ref[iCol][iRow][b]));
        	//	if(b==BITS_PER_WORD-1) printf("\n");
        	//}
    		}
        	fprintf(file_, "%s", bset_.to_string().c_str());
	    }
    	fprintf(file_, (iRow==N_ROWS-1) ? ";\n" : ",\n");
    }
    fclose(file_);
}
void simple_algo_sum_arrays_ref(type_t in_ref[N_COLUMNS][N_ROWS], type_t out_ref[N_OUTPUTS]);
void simple_algo_sum_arrays_hw(invec in_hw[N_COLUMNS], type_t out_hw[N_OUTPUTS]);
void simple_algo_sum_arrays_fixed_hw(invec in_hw[N_COLUMNS], type_t out_hw[N_OUTPUTS]);

#endif
