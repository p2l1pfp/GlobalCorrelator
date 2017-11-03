#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "firmware/example_output.h"

int main(int argc, char **argv){
  //Define arrays of inputs
  unsigned int  data_i[N_INPUTS ] = {0};
  unsigned int  data_o[N_OUTPUTS] = {0};

  //Define arrays of streams
  unsigned int  sdata_i[N_INPUTS *STREAMSIZE] = {0};
  unsigned int  sdata_o[N_OUTPUTS*STREAMSIZE] = {0};

  //Now define the axi streams
  apin_t        asdata_i[STREAMSIZE*N_INPUTS];
  apin_t        asdata_o[STREAMSIZE*N_OUTPUTS];
  unsigned int  rasdata_o[N_OUTPUTS*STREAMSIZE] = {0};

  for (unsigned int i = 0; i < N_INPUTS;  i++) data_i[i] = i;
  for (unsigned int i = 0; i < N_OUTPUTS; i++) data_o[i] = 0;
  
  //FILL WITH A SERIES OF ARRAYS
  for (unsigned int i = 0; i < N_INPUTS*STREAMSIZE; ++i)  sdata_i[i] = i;
  for (unsigned int i = 0; i < N_OUTPUTS*STREAMSIZE; ++i) sdata_o[i] = 0;

  //Axi-stream it up
  for (unsigned int i = 0; i < STREAMSIZE*N_INPUTS;  ++i) asdata_i[i] = push_stream(sdata_i[i],i==(STREAMSIZE*N_INPUTS-1));
  for (unsigned int i = 0; i < STREAMSIZE*N_OUTPUTS; ++i) asdata_o[i] = push_stream(sdata_o[i],i==(STREAMSIZE*N_OUTPUTS-1));

  basic_bram     (data_i,  data_o);
  basic_stream   (sdata_i, sdata_o);
  basic_axistream(asdata_i,asdata_o);
  
  for (unsigned int i = 0; i < N_OUTPUTS*STREAMSIZE; ++i) rasdata_o[i] = pop_stream(asdata_o[i]);
  // Print result vector for a few events
  std::cout << "====> BRAM " << std::endl;
  for(unsigned int i = 0; i < N_INPUTS;  i++) std::cout << "# input  id: " << i << " -- val: " << data_i[i] << std::endl;
  for(unsigned int i = 0; i < N_OUTPUTS; i++) std::cout << "# output id: " << i << " -- val: " << data_o[i] << std::endl;
  
  std::cout << "====> Stream " << std::endl;
  for (int ev = 0; ev < 1; ev++) {
    for(unsigned int i = 0; i < N_INPUTS;  i++) std::cout << "event: " << ev << "# input  id: " << i << " -- val: " << sdata_i[ev*N_INPUTS+i] << std::endl;
    for(unsigned int i = 0; i < N_OUTPUTS; i++) std::cout << "event: " << ev << "# output id: " << i << " -- val: " << sdata_o[ev*N_OUTPUTS+i] << std::endl;
  }

  std::cout << "====> Axi-Stream " << std::endl;
  for (int ev = 0; ev < 1; ev++) {
    for(unsigned int i = 0; i < N_INPUTS;  i++) std::cout << "event: " << ev << "# input  id: " << i << " -- val: " << sdata_i[ev*N_INPUTS+i] << std::endl;
    for(unsigned int i = 0; i < N_OUTPUTS; i++) std::cout << "event: " << ev << "# output id: " << i << " -- val: " << rasdata_o[ev*N_OUTPUTS+i] << std::endl;
  }
}
