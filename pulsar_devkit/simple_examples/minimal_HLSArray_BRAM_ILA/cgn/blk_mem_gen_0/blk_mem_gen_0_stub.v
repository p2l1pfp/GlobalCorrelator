// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Tue Oct 17 16:54:15 2017
// Host        : nucts01 running 64-bit CentOS release 6.9 (Final)
// Command     : write_verilog -force -mode synth_stub
//               /home/ssevova/tmp/GlobalCorrelator/pulsar_devkit/simple_examples/minimal_HLSArray_BRAM_ILA/cgn/blk_mem_gen_0/blk_mem_gen_0_stub.v
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_5,Vivado 2016.4" *)
module blk_mem_gen_0(clka, ena, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[0:0],dina[63:0],douta[63:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [0:0]addra;
  input [63:0]dina;
  output [63:0]douta;
endmodule
