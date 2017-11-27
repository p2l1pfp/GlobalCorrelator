// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Fri Oct  6 11:58:51 2017
// Host        : nucts01 running 64-bit CentOS release 6.9 (Final)
// Command     : write_verilog -force -mode synth_stub
//               /home/ssevova/GlobalCorrelator/pulsar_devkit/simple_examples/minimal_BRAM_ILA/cgn/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2016.4" *)
module ila_0(clk, probe0, probe1, probe2)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[31:0],probe1[31:0],probe2[31:0]" */;
  input clk;
  input [31:0]probe0;
  input [31:0]probe1;
  input [31:0]probe2;
endmodule
