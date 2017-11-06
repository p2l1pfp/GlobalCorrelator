// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Tue Oct 10 14:45:38 2017
// Host        : nucts01 running 64-bit CentOS release 6.9 (Final)
// Command     : write_verilog -force -mode synth_stub
//               /home/ssevova/GlobalCorrelator/pulsar_devkit/simple_examples/minimal_BRAM_ILA/top/top.srcs/sources_1/ip/simple_algo_hw_0/simple_algo_hw_0_stub.v
// Design      : simple_algo_hw_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "simple_algo_hw,Vivado 2016.4" *)
module simple_algo_hw_0(inA_V_ce0, inB_V_ce0, outA_V_ap_vld, ap_clk, 
  ap_rst, ap_start, ap_done, ap_idle, ap_ready, inA_V_address0, inA_V_q0, inB_V_address0, inB_V_q0, 
  outA_V)
/* synthesis syn_black_box black_box_pad_pin="inA_V_ce0,inB_V_ce0,outA_V_ap_vld,ap_clk,ap_rst,ap_start,ap_done,ap_idle,ap_ready,inA_V_address0[0:0],inA_V_q0[31:0],inB_V_address0[0:0],inB_V_q0[31:0],outA_V[31:0]" */;
  output inA_V_ce0;
  output inB_V_ce0;
  output outA_V_ap_vld;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [0:0]inA_V_address0;
  input [31:0]inA_V_q0;
  output [0:0]inB_V_address0;
  input [31:0]inB_V_q0;
  output [31:0]outA_V;
endmodule
