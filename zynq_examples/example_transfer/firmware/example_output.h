#ifndef EXAMPLE_OUTPUT_H_
#define EXAMPLE_OUTPUT_H_

#define N_INPUTS      10
#define N_OUTPUTS      9  //I prefer to use 10 but this is some practice 
#define STREAMSIZE    32 //256 is the max for a DMA 

#include <complex>
#include "ap_int.h"
#include "ap_fixed.h"
#include "ap_axi_sdata.h"

typedef unsigned int input_t;
typedef unsigned int output_t;
typedef unsigned int input_o;
typedef unsigned int output_o;
//typedef ap_axiu<32,4,5,5> apin_t; //The 32,4,5,5 is added to get the linking right
typedef ap_axis<32,4,5,5> apin_t; //The 32,4,5,5 is added to get the linking right
typedef unsigned int u32;

void test_hw(input_o   data[N_INPUTS],output_o  res[N_OUTPUTS]);
input_t  pop_stream(apin_t const &e);
apin_t   push_stream(output_t const &v, bool last = false);
void     basic_bram     (u32    input[N_INPUTS]               ,u32    output    [N_OUTPUTS]);
void     basic_axistream(apin_t in_stream[N_INPUTS*STREAMSIZE],apin_t out_stream[N_OUTPUTS*STREAMSIZE]);
void     basic_stream   (u32    in_stream[N_INPUTS*STREAMSIZE],u32    out_stream[N_OUTPUTS*STREAMSIZE]); 
// Have a compiled HLS stream, but I couldn't get it to work in Vivado
#endif
