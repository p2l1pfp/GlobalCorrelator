#!/bin/bash
( rm -r xsim.dir/ || true ) 
for f in pftm_constants.vhd pftm_data_types.vhd  pftm_textio.vhd sector_processor.vhd sector_merger.vhd regionizer_eta.vhd regionizer_full.vhd regionizer_full_tb.vhd ; do 
    xvhdl $f ;
done 
echo " --- press <return> if the VHDL compilation was ok, <ctrl>-C otherwise." ; read 

xelab testbench -s test && \
xsim test -R
