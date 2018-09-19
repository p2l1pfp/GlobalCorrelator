#ifndef SIMPLE_ALGO_ARRAY_H
#define SIMPLE_ALGO_ARRAY_H

// Xilinx Libraries
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_stream.h"

// STL Libraries
#include <cstdio>
#include <bitset>

#define N_COLUMNS 27
#define N_ROWS    24
#define N_OUTPUTS N_ROWS
#define BITS_PER_WORD 100

typedef ap_ufixed<BITS_PER_WORD,BITS_PER_WORD-1> in_t;
typedef struct { in_t data[N_COLUMNS]; }         invec;
typedef ap_uint<BITS_PER_WORD-1>                 tmp_t;
typedef struct { tmp_t data[N_COLUMNS]; }        tmpvec;
typedef ap_uint<BITS_PER_WORD+5>                 out_t;

inline void produce_coe_file(in_t in_ref[N_COLUMNS][N_ROWS]) {
	std::bitset<BITS_PER_WORD+10> bset_;

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
    		for(int b=BITS_PER_WORD; b<BITS_PER_WORD+10; ++b) {
    			bset_.set(b,0);
    		}
        	fprintf(file_, "%s", bset_.to_string().c_str());
	    }
    	fprintf(file_, (iRow==N_ROWS-1) ? ";\n" : ",\n");
    }
    fclose(file_);
}
void simple_algo_stream_ref(in_t in_ref[N_COLUMNS][N_ROWS], out_t out_ref[N_OUTPUTS]);
void convert_input(hls::stream<invec> &in_hw,hls::stream<tmpvec> &out_hw);
void simple_algo_stream_hw(hls::stream<invec> &in_hw, hls::stream<out_t> &out_hw);
void simple_algo_stream_optimized_hw(hls::stream<invec> &in_hw, hls::stream<out_t> &out_hw);

#endif
