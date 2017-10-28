#include "example_output.h"

void test_hw(input_t  input[N_INPUTS],output_t output[N_OUTPUTS]) {
    #pragma HLS ARRAY_PARTITION variable=input  complete
    #pragma HLS ARRAY_PARTITION variable=output complete
    //#pragma HLS pipeline II=1 
    // Remove ap ctrl ports (ap_start, ap_ready, ap_idle, etc) since we only use the AXI-Stream ports
    #pragma HLS INTERFACE ap_ctrl_none port=return
    //#pragma HLS DATAFLOW

    //Do something dumb (in this case invert the order and scale by 2), but do in unrolled
    for(int i0 = 0; i0 < N_OUTPUTS; i0++) {
      #pragma HLS UNROLL
      output[i0] = (input[N_INPUTS-i0-1])*2;
    }
}
input_t pop_stream(apin_t const &e) {
#pragma HLS INLINE OFF
  input_t ret    = e.data;
  //input_t ret    = e.data >> 6;
  volatile ap_uint<sizeof(input_o)>  strb = e.strb;
  volatile ap_uint<sizeof(input_o)>  keep = e.keep;
  volatile ap_uint<4>  user = e.user;
  volatile ap_uint<1>  last = e.last;
  volatile ap_uint<5>  id   = e.id;
  volatile ap_uint<5>  dest = e.dest;
  return ret;
}
apin_t push_stream(output_t const &v, bool last) {
#pragma HLS INLINE OFF
  apin_t e;
  e.data = v;//.to_uint(); 
  e.strb = (1<<sizeof(output_o))-1;
  e.keep = (1<<sizeof(output_o))-1;
  e.user = 0;
  e.last = last ? 1 : 0;
  e.id   = 0;
  e.dest = 0;
  return e;
}
void basic_axistream(apin_t in_stream[STREAMSIZE*N_INPUTS],apin_t out_stream[STREAMSIZE*N_OUTPUTS]){
#pragma HLS INTERFACE s_axilite        port=return bundle=CTRL_BUS
#pragma HLS INTERFACE axis             port=in_stream
#pragma HLS INTERFACE axis             port=out_stream

  input_t  input [STREAMSIZE][N_INPUTS];
  output_t output[STREAMSIZE][N_OUTPUTS];
  unsigned int inid=0;

  for(unsigned int j = 0; j < STREAMSIZE; j++) { 
    //No point in unrolling this guy
#pragma HLS PIPELINE II=1
    // stream in first matrix                                                                                                                            
    for(unsigned int i=0; i<N_INPUTS; i++) {
#pragma HLS PIPELINE II=1
      input[j][i] = pop_stream(in_stream[inid++]);
    }
  }
  for(unsigned int j = 0; j < STREAMSIZE; j++) {
#pragma HLS PIPELINE II=1
    test_hw(input[j],output[j]);
  }
  unsigned int outid=0;
  for(unsigned int j = 0; j < STREAMSIZE; j++) { 
#pragma HLS PIPELINE II=1
    for(unsigned int i=0; i<N_OUTPUTS; i++) {
#pragma HLS PIPELINE II=1
      out_stream[outid++] = push_stream(output[j][i],outid==(STREAMSIZE*N_OUTPUTS));
    }
  }
 return;
}
void basic_stream(unsigned int in_stream[N_INPUTS*STREAMSIZE],unsigned int out_stream[N_OUTPUTS*STREAMSIZE]){
#pragma HLS DATAFLOW
#pragma HLS INTERFACE s_axilite        port=return bundle=CTRL_BUS
#pragma HLS INTERFACE axis             port=in_stream
#pragma HLS INTERFACE axis             port=out_stream

  input_t  input [STREAMSIZE][N_INPUTS];
  output_t output[STREAMSIZE][N_OUTPUTS];
  unsigned int inid=0;
  unsigned int outid=0;
  for(unsigned int j = 0; j < STREAMSIZE; j++) { 
    //This guy below is what slows everything dow
#pragma HLS PIPELINE II=1
    // stream in first matrix                                                                                                                            
    for(unsigned int i=0; i<N_INPUTS; i++) {
#pragma HLS UNROLL
      input[j][i] = (input_t) in_stream[inid++];
    }
    test_hw(input[j],output[j]);
    for(unsigned int i=0; i<N_OUTPUTS; i++) {
#pragma HLS UNROLL
      out_stream[outid++] = (unsigned int) output[j][i];
    }
  }
 return;
}
void basic_bram(unsigned int in_stream[N_INPUTS],unsigned int out_stream[N_OUTPUTS]){
#pragma HLS INTERFACE s_axilite        port=return bundle=CTRL_BUS
#pragma HLS INTERFACE bram             port=in_stream
#pragma HLS INTERFACE bram             port=out_stream
  input_t  input [N_INPUTS];
  output_t output[N_OUTPUTS];
  unsigned int inid=0;
  for(unsigned int i=0; i<N_INPUTS; i++) {
    //#pragma HLS UNROLL Unroll also works, but have nto played much with it
#pragma HLS PIPELINE II=1
    input[i] = (input_t) in_stream[inid++];
  }
  test_hw(input,output);
  unsigned int outid=0;
  for(unsigned int i=0; i<N_OUTPUTS; i++) {
    //#pragma HLS UNROLL
#pragma HLS PIPELINE II=1
    out_stream[outid++] = output[i];
  }
  return;
}


