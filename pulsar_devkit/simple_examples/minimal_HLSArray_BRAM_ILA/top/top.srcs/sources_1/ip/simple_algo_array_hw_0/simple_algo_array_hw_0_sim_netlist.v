// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Tue Oct 10 15:14:06 2017
// Host        : nucts01 running 64-bit CentOS release 6.9 (Final)
// Command     : write_verilog -force -mode funcsim
//               /home/ssevova/GlobalCorrelator/pulsar_devkit/simple_examples/minimal_HLSArray_BRAM_ILA/top/top.srcs/sources_1/ip/simple_algo_array_hw_0/simple_algo_array_hw_0_sim_netlist.v
// Design      : simple_algo_array_hw_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "simple_algo_array_hw_0,simple_algo_array_hw,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "simple_algo_array_hw,Vivado 2016.4" *) 
(* NotValidForBitStream *)
module simple_algo_array_hw_0
   (inA_V_ce0,
    inB_V_ce0,
    outA_V_ap_vld,
    ap_clk,
    ap_rst,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    inA_V_address0,
    inA_V_q0,
    inB_V_address0,
    inB_V_q0,
    outA_V);
  output inA_V_ce0;
  output inB_V_ce0;
  output outA_V_ap_vld;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) input ap_clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 ap_rst RST" *) input ap_rst;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start" *) input ap_start;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done" *) output ap_done;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle" *) output ap_idle;
  (* x_interface_info = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready" *) output ap_ready;
  (* x_interface_info = "xilinx.com:signal:data:1.0 inA_V_address0 DATA" *) output [0:0]inA_V_address0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 inA_V_q0 DATA" *) input [31:0]inA_V_q0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 inB_V_address0 DATA" *) output [0:0]inB_V_address0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 inB_V_q0 DATA" *) input [31:0]inB_V_q0;
  (* x_interface_info = "xilinx.com:signal:data:1.0 outA_V DATA" *) output [31:0]outA_V;

  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;
  wire ap_rst;
  wire ap_start;
  wire [0:0]inA_V_address0;
  wire inA_V_ce0;
  wire [31:0]inA_V_q0;
  wire [0:0]inB_V_address0;
  wire inB_V_ce0;
  wire [31:0]inB_V_q0;
  wire [31:0]outA_V;
  wire outA_V_ap_vld;

  simple_algo_array_hw_0_simple_algo_array_hw U0
       (.ap_clk(ap_clk),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .ap_rst(ap_rst),
        .ap_start(ap_start),
        .inA_V_address0(inA_V_address0),
        .inA_V_ce0(inA_V_ce0),
        .inA_V_q0(inA_V_q0),
        .inB_V_address0(inB_V_address0),
        .inB_V_ce0(inB_V_ce0),
        .inB_V_q0(inB_V_q0),
        .outA_V(outA_V),
        .outA_V_ap_vld(outA_V_ap_vld));
endmodule

(* ORIG_REF_NAME = "simple_algo_array_hw" *) 
module simple_algo_array_hw_0_simple_algo_array_hw
   (ap_clk,
    ap_rst,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    inA_V_address0,
    inA_V_ce0,
    inA_V_q0,
    inB_V_address0,
    inB_V_ce0,
    inB_V_q0,
    outA_V,
    outA_V_ap_vld);
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [0:0]inA_V_address0;
  output inA_V_ce0;
  input [31:0]inA_V_q0;
  output [0:0]inB_V_address0;
  output inB_V_ce0;
  input [31:0]inB_V_q0;
  output [31:0]outA_V;
  output outA_V_ap_vld;

  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire [1:0]ap_NS_fsm;
  wire ap_clk;
  wire ap_done;
  wire ap_idle;
  wire ap_rst;
  wire ap_start;
  wire [0:0]inA_V_address0;
  wire inA_V_ce0;
  wire [31:0]inA_V_q0;
  wire [0:0]inB_V_address0;
  wire inB_V_ce0;
  wire [31:0]inB_V_q0;
  wire [31:0]outA_V;
  wire \outA_V[0]_INST_0_i_1_n_0 ;
  wire \outA_V[0]_INST_0_i_2_n_0 ;
  wire \outA_V[0]_INST_0_i_3_n_0 ;
  wire \outA_V[0]_INST_0_i_4_n_0 ;
  wire \outA_V[0]_INST_0_i_5_n_0 ;
  wire \outA_V[0]_INST_0_i_6_n_0 ;
  wire \outA_V[0]_INST_0_i_7_n_0 ;
  wire \outA_V[0]_INST_0_n_0 ;
  wire \outA_V[0]_INST_0_n_1 ;
  wire \outA_V[0]_INST_0_n_2 ;
  wire \outA_V[0]_INST_0_n_3 ;
  wire \outA_V[12]_INST_0_i_1_n_0 ;
  wire \outA_V[12]_INST_0_i_2_n_0 ;
  wire \outA_V[12]_INST_0_i_3_n_0 ;
  wire \outA_V[12]_INST_0_i_4_n_0 ;
  wire \outA_V[12]_INST_0_i_5_n_0 ;
  wire \outA_V[12]_INST_0_i_6_n_0 ;
  wire \outA_V[12]_INST_0_i_7_n_0 ;
  wire \outA_V[12]_INST_0_i_8_n_0 ;
  wire \outA_V[12]_INST_0_n_0 ;
  wire \outA_V[12]_INST_0_n_1 ;
  wire \outA_V[12]_INST_0_n_2 ;
  wire \outA_V[12]_INST_0_n_3 ;
  wire \outA_V[16]_INST_0_i_1_n_0 ;
  wire \outA_V[16]_INST_0_i_2_n_0 ;
  wire \outA_V[16]_INST_0_i_3_n_0 ;
  wire \outA_V[16]_INST_0_i_4_n_0 ;
  wire \outA_V[16]_INST_0_i_5_n_0 ;
  wire \outA_V[16]_INST_0_i_6_n_0 ;
  wire \outA_V[16]_INST_0_i_7_n_0 ;
  wire \outA_V[16]_INST_0_i_8_n_0 ;
  wire \outA_V[16]_INST_0_n_0 ;
  wire \outA_V[16]_INST_0_n_1 ;
  wire \outA_V[16]_INST_0_n_2 ;
  wire \outA_V[16]_INST_0_n_3 ;
  wire \outA_V[20]_INST_0_i_1_n_0 ;
  wire \outA_V[20]_INST_0_i_2_n_0 ;
  wire \outA_V[20]_INST_0_i_3_n_0 ;
  wire \outA_V[20]_INST_0_i_4_n_0 ;
  wire \outA_V[20]_INST_0_i_5_n_0 ;
  wire \outA_V[20]_INST_0_i_6_n_0 ;
  wire \outA_V[20]_INST_0_i_7_n_0 ;
  wire \outA_V[20]_INST_0_i_8_n_0 ;
  wire \outA_V[20]_INST_0_n_0 ;
  wire \outA_V[20]_INST_0_n_1 ;
  wire \outA_V[20]_INST_0_n_2 ;
  wire \outA_V[20]_INST_0_n_3 ;
  wire \outA_V[24]_INST_0_i_1_n_0 ;
  wire \outA_V[24]_INST_0_i_2_n_0 ;
  wire \outA_V[24]_INST_0_i_3_n_0 ;
  wire \outA_V[24]_INST_0_i_4_n_0 ;
  wire \outA_V[24]_INST_0_i_5_n_0 ;
  wire \outA_V[24]_INST_0_i_6_n_0 ;
  wire \outA_V[24]_INST_0_i_7_n_0 ;
  wire \outA_V[24]_INST_0_i_8_n_0 ;
  wire \outA_V[24]_INST_0_n_0 ;
  wire \outA_V[24]_INST_0_n_1 ;
  wire \outA_V[24]_INST_0_n_2 ;
  wire \outA_V[24]_INST_0_n_3 ;
  wire \outA_V[28]_INST_0_i_1_n_0 ;
  wire \outA_V[28]_INST_0_i_2_n_0 ;
  wire \outA_V[28]_INST_0_i_3_n_0 ;
  wire \outA_V[28]_INST_0_i_4_n_0 ;
  wire \outA_V[28]_INST_0_i_5_n_0 ;
  wire \outA_V[28]_INST_0_i_6_n_0 ;
  wire \outA_V[28]_INST_0_i_7_n_0 ;
  wire \outA_V[28]_INST_0_n_1 ;
  wire \outA_V[28]_INST_0_n_2 ;
  wire \outA_V[28]_INST_0_n_3 ;
  wire \outA_V[4]_INST_0_i_1_n_0 ;
  wire \outA_V[4]_INST_0_i_2_n_0 ;
  wire \outA_V[4]_INST_0_i_3_n_0 ;
  wire \outA_V[4]_INST_0_i_4_n_0 ;
  wire \outA_V[4]_INST_0_i_5_n_0 ;
  wire \outA_V[4]_INST_0_i_6_n_0 ;
  wire \outA_V[4]_INST_0_i_7_n_0 ;
  wire \outA_V[4]_INST_0_i_8_n_0 ;
  wire \outA_V[4]_INST_0_n_0 ;
  wire \outA_V[4]_INST_0_n_1 ;
  wire \outA_V[4]_INST_0_n_2 ;
  wire \outA_V[4]_INST_0_n_3 ;
  wire \outA_V[8]_INST_0_i_1_n_0 ;
  wire \outA_V[8]_INST_0_i_2_n_0 ;
  wire \outA_V[8]_INST_0_i_3_n_0 ;
  wire \outA_V[8]_INST_0_i_4_n_0 ;
  wire \outA_V[8]_INST_0_i_5_n_0 ;
  wire \outA_V[8]_INST_0_i_6_n_0 ;
  wire \outA_V[8]_INST_0_i_7_n_0 ;
  wire \outA_V[8]_INST_0_i_8_n_0 ;
  wire \outA_V[8]_INST_0_n_0 ;
  wire \outA_V[8]_INST_0_n_1 ;
  wire \outA_V[8]_INST_0_n_2 ;
  wire \outA_V[8]_INST_0_n_3 ;
  wire [31:0]reg_77;
  wire [31:0]tmp_fu_81_p2;
  wire [31:0]tmp_reg_119;
  wire \tmp_reg_119[11]_i_2_n_0 ;
  wire \tmp_reg_119[11]_i_3_n_0 ;
  wire \tmp_reg_119[11]_i_4_n_0 ;
  wire \tmp_reg_119[11]_i_5_n_0 ;
  wire \tmp_reg_119[15]_i_2_n_0 ;
  wire \tmp_reg_119[15]_i_3_n_0 ;
  wire \tmp_reg_119[15]_i_4_n_0 ;
  wire \tmp_reg_119[15]_i_5_n_0 ;
  wire \tmp_reg_119[19]_i_2_n_0 ;
  wire \tmp_reg_119[19]_i_3_n_0 ;
  wire \tmp_reg_119[19]_i_4_n_0 ;
  wire \tmp_reg_119[19]_i_5_n_0 ;
  wire \tmp_reg_119[23]_i_2_n_0 ;
  wire \tmp_reg_119[23]_i_3_n_0 ;
  wire \tmp_reg_119[23]_i_4_n_0 ;
  wire \tmp_reg_119[23]_i_5_n_0 ;
  wire \tmp_reg_119[27]_i_2_n_0 ;
  wire \tmp_reg_119[27]_i_3_n_0 ;
  wire \tmp_reg_119[27]_i_4_n_0 ;
  wire \tmp_reg_119[27]_i_5_n_0 ;
  wire \tmp_reg_119[31]_i_2_n_0 ;
  wire \tmp_reg_119[31]_i_3_n_0 ;
  wire \tmp_reg_119[31]_i_4_n_0 ;
  wire \tmp_reg_119[31]_i_5_n_0 ;
  wire \tmp_reg_119[3]_i_2_n_0 ;
  wire \tmp_reg_119[3]_i_3_n_0 ;
  wire \tmp_reg_119[3]_i_4_n_0 ;
  wire \tmp_reg_119[3]_i_5_n_0 ;
  wire \tmp_reg_119[7]_i_2_n_0 ;
  wire \tmp_reg_119[7]_i_3_n_0 ;
  wire \tmp_reg_119[7]_i_4_n_0 ;
  wire \tmp_reg_119[7]_i_5_n_0 ;
  wire \tmp_reg_119_reg[11]_i_1_n_0 ;
  wire \tmp_reg_119_reg[11]_i_1_n_1 ;
  wire \tmp_reg_119_reg[11]_i_1_n_2 ;
  wire \tmp_reg_119_reg[11]_i_1_n_3 ;
  wire \tmp_reg_119_reg[15]_i_1_n_0 ;
  wire \tmp_reg_119_reg[15]_i_1_n_1 ;
  wire \tmp_reg_119_reg[15]_i_1_n_2 ;
  wire \tmp_reg_119_reg[15]_i_1_n_3 ;
  wire \tmp_reg_119_reg[19]_i_1_n_0 ;
  wire \tmp_reg_119_reg[19]_i_1_n_1 ;
  wire \tmp_reg_119_reg[19]_i_1_n_2 ;
  wire \tmp_reg_119_reg[19]_i_1_n_3 ;
  wire \tmp_reg_119_reg[23]_i_1_n_0 ;
  wire \tmp_reg_119_reg[23]_i_1_n_1 ;
  wire \tmp_reg_119_reg[23]_i_1_n_2 ;
  wire \tmp_reg_119_reg[23]_i_1_n_3 ;
  wire \tmp_reg_119_reg[27]_i_1_n_0 ;
  wire \tmp_reg_119_reg[27]_i_1_n_1 ;
  wire \tmp_reg_119_reg[27]_i_1_n_2 ;
  wire \tmp_reg_119_reg[27]_i_1_n_3 ;
  wire \tmp_reg_119_reg[31]_i_1_n_1 ;
  wire \tmp_reg_119_reg[31]_i_1_n_2 ;
  wire \tmp_reg_119_reg[31]_i_1_n_3 ;
  wire \tmp_reg_119_reg[3]_i_1_n_0 ;
  wire \tmp_reg_119_reg[3]_i_1_n_1 ;
  wire \tmp_reg_119_reg[3]_i_1_n_2 ;
  wire \tmp_reg_119_reg[3]_i_1_n_3 ;
  wire \tmp_reg_119_reg[7]_i_1_n_0 ;
  wire \tmp_reg_119_reg[7]_i_1_n_1 ;
  wire \tmp_reg_119_reg[7]_i_1_n_2 ;
  wire \tmp_reg_119_reg[7]_i_1_n_3 ;
  wire [3:3]\NLW_outA_V[28]_INST_0_CO_UNCONNECTED ;
  wire [3:3]\NLW_tmp_reg_119_reg[31]_i_1_CO_UNCONNECTED ;

  assign ap_ready = ap_done;
  assign outA_V_ap_vld = ap_done;
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(ap_done),
        .I1(ap_start),
        .I2(\ap_CS_fsm_reg_n_0_[0] ),
        .O(ap_NS_fsm[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(ap_start),
        .I1(ap_done),
        .I2(inA_V_address0),
        .I3(inB_V_address0),
        .O(ap_NS_fsm[1]));
  (* FSM_ENCODING = "none" *) 
  FDSE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[0]),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .S(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[1]),
        .Q(inA_V_address0),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(inA_V_address0),
        .Q(inB_V_address0),
        .R(ap_rst));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(inB_V_address0),
        .Q(ap_done),
        .R(ap_rst));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    ap_idle_INST_0
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .O(ap_idle));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    inA_V_ce0_INST_0
       (.I0(inA_V_address0),
        .I1(\ap_CS_fsm_reg_n_0_[0] ),
        .I2(ap_start),
        .O(inA_V_ce0));
  LUT2 #(
    .INIT(4'hE)) 
    inB_V_ce0_INST_0
       (.I0(inA_V_address0),
        .I1(inB_V_address0),
        .O(inB_V_ce0));
  CARRY4 \outA_V[0]_INST_0 
       (.CI(1'b0),
        .CO({\outA_V[0]_INST_0_n_0 ,\outA_V[0]_INST_0_n_1 ,\outA_V[0]_INST_0_n_2 ,\outA_V[0]_INST_0_n_3 }),
        .CYINIT(1'b1),
        .DI({\outA_V[0]_INST_0_i_1_n_0 ,\outA_V[0]_INST_0_i_2_n_0 ,\outA_V[0]_INST_0_i_3_n_0 ,1'b1}),
        .O(outA_V[3:0]),
        .S({\outA_V[0]_INST_0_i_4_n_0 ,\outA_V[0]_INST_0_i_5_n_0 ,\outA_V[0]_INST_0_i_6_n_0 ,\outA_V[0]_INST_0_i_7_n_0 }));
  (* HLUTNM = "lutpair1" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[0]_INST_0_i_1 
       (.I0(reg_77[2]),
        .I1(inB_V_q0[2]),
        .I2(tmp_reg_119[2]),
        .O(\outA_V[0]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair0" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[0]_INST_0_i_2 
       (.I0(reg_77[1]),
        .I1(inB_V_q0[1]),
        .I2(tmp_reg_119[1]),
        .O(\outA_V[0]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair29" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[0]_INST_0_i_3 
       (.I0(reg_77[0]),
        .I1(inB_V_q0[0]),
        .I2(tmp_reg_119[0]),
        .O(\outA_V[0]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair2" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[0]_INST_0_i_4 
       (.I0(reg_77[3]),
        .I1(inB_V_q0[3]),
        .I2(tmp_reg_119[3]),
        .I3(\outA_V[0]_INST_0_i_1_n_0 ),
        .O(\outA_V[0]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair1" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[0]_INST_0_i_5 
       (.I0(reg_77[2]),
        .I1(inB_V_q0[2]),
        .I2(tmp_reg_119[2]),
        .I3(\outA_V[0]_INST_0_i_2_n_0 ),
        .O(\outA_V[0]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair0" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[0]_INST_0_i_6 
       (.I0(reg_77[1]),
        .I1(inB_V_q0[1]),
        .I2(tmp_reg_119[1]),
        .I3(\outA_V[0]_INST_0_i_3_n_0 ),
        .O(\outA_V[0]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair29" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \outA_V[0]_INST_0_i_7 
       (.I0(reg_77[0]),
        .I1(inB_V_q0[0]),
        .I2(tmp_reg_119[0]),
        .O(\outA_V[0]_INST_0_i_7_n_0 ));
  CARRY4 \outA_V[12]_INST_0 
       (.CI(\outA_V[8]_INST_0_n_0 ),
        .CO({\outA_V[12]_INST_0_n_0 ,\outA_V[12]_INST_0_n_1 ,\outA_V[12]_INST_0_n_2 ,\outA_V[12]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\outA_V[12]_INST_0_i_1_n_0 ,\outA_V[12]_INST_0_i_2_n_0 ,\outA_V[12]_INST_0_i_3_n_0 ,\outA_V[12]_INST_0_i_4_n_0 }),
        .O(outA_V[15:12]),
        .S({\outA_V[12]_INST_0_i_5_n_0 ,\outA_V[12]_INST_0_i_6_n_0 ,\outA_V[12]_INST_0_i_7_n_0 ,\outA_V[12]_INST_0_i_8_n_0 }));
  (* HLUTNM = "lutpair13" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[12]_INST_0_i_1 
       (.I0(reg_77[14]),
        .I1(inB_V_q0[14]),
        .I2(tmp_reg_119[14]),
        .O(\outA_V[12]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair12" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[12]_INST_0_i_2 
       (.I0(reg_77[13]),
        .I1(inB_V_q0[13]),
        .I2(tmp_reg_119[13]),
        .O(\outA_V[12]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair11" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[12]_INST_0_i_3 
       (.I0(reg_77[12]),
        .I1(inB_V_q0[12]),
        .I2(tmp_reg_119[12]),
        .O(\outA_V[12]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair10" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[12]_INST_0_i_4 
       (.I0(reg_77[11]),
        .I1(inB_V_q0[11]),
        .I2(tmp_reg_119[11]),
        .O(\outA_V[12]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair14" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[12]_INST_0_i_5 
       (.I0(reg_77[15]),
        .I1(inB_V_q0[15]),
        .I2(tmp_reg_119[15]),
        .I3(\outA_V[12]_INST_0_i_1_n_0 ),
        .O(\outA_V[12]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair13" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[12]_INST_0_i_6 
       (.I0(reg_77[14]),
        .I1(inB_V_q0[14]),
        .I2(tmp_reg_119[14]),
        .I3(\outA_V[12]_INST_0_i_2_n_0 ),
        .O(\outA_V[12]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair12" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[12]_INST_0_i_7 
       (.I0(reg_77[13]),
        .I1(inB_V_q0[13]),
        .I2(tmp_reg_119[13]),
        .I3(\outA_V[12]_INST_0_i_3_n_0 ),
        .O(\outA_V[12]_INST_0_i_7_n_0 ));
  (* HLUTNM = "lutpair11" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[12]_INST_0_i_8 
       (.I0(reg_77[12]),
        .I1(inB_V_q0[12]),
        .I2(tmp_reg_119[12]),
        .I3(\outA_V[12]_INST_0_i_4_n_0 ),
        .O(\outA_V[12]_INST_0_i_8_n_0 ));
  CARRY4 \outA_V[16]_INST_0 
       (.CI(\outA_V[12]_INST_0_n_0 ),
        .CO({\outA_V[16]_INST_0_n_0 ,\outA_V[16]_INST_0_n_1 ,\outA_V[16]_INST_0_n_2 ,\outA_V[16]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\outA_V[16]_INST_0_i_1_n_0 ,\outA_V[16]_INST_0_i_2_n_0 ,\outA_V[16]_INST_0_i_3_n_0 ,\outA_V[16]_INST_0_i_4_n_0 }),
        .O(outA_V[19:16]),
        .S({\outA_V[16]_INST_0_i_5_n_0 ,\outA_V[16]_INST_0_i_6_n_0 ,\outA_V[16]_INST_0_i_7_n_0 ,\outA_V[16]_INST_0_i_8_n_0 }));
  (* HLUTNM = "lutpair17" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[16]_INST_0_i_1 
       (.I0(reg_77[18]),
        .I1(inB_V_q0[18]),
        .I2(tmp_reg_119[18]),
        .O(\outA_V[16]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair16" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[16]_INST_0_i_2 
       (.I0(reg_77[17]),
        .I1(inB_V_q0[17]),
        .I2(tmp_reg_119[17]),
        .O(\outA_V[16]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair15" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[16]_INST_0_i_3 
       (.I0(reg_77[16]),
        .I1(inB_V_q0[16]),
        .I2(tmp_reg_119[16]),
        .O(\outA_V[16]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair14" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[16]_INST_0_i_4 
       (.I0(reg_77[15]),
        .I1(inB_V_q0[15]),
        .I2(tmp_reg_119[15]),
        .O(\outA_V[16]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair18" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[16]_INST_0_i_5 
       (.I0(reg_77[19]),
        .I1(inB_V_q0[19]),
        .I2(tmp_reg_119[19]),
        .I3(\outA_V[16]_INST_0_i_1_n_0 ),
        .O(\outA_V[16]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair17" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[16]_INST_0_i_6 
       (.I0(reg_77[18]),
        .I1(inB_V_q0[18]),
        .I2(tmp_reg_119[18]),
        .I3(\outA_V[16]_INST_0_i_2_n_0 ),
        .O(\outA_V[16]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair16" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[16]_INST_0_i_7 
       (.I0(reg_77[17]),
        .I1(inB_V_q0[17]),
        .I2(tmp_reg_119[17]),
        .I3(\outA_V[16]_INST_0_i_3_n_0 ),
        .O(\outA_V[16]_INST_0_i_7_n_0 ));
  (* HLUTNM = "lutpair15" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[16]_INST_0_i_8 
       (.I0(reg_77[16]),
        .I1(inB_V_q0[16]),
        .I2(tmp_reg_119[16]),
        .I3(\outA_V[16]_INST_0_i_4_n_0 ),
        .O(\outA_V[16]_INST_0_i_8_n_0 ));
  CARRY4 \outA_V[20]_INST_0 
       (.CI(\outA_V[16]_INST_0_n_0 ),
        .CO({\outA_V[20]_INST_0_n_0 ,\outA_V[20]_INST_0_n_1 ,\outA_V[20]_INST_0_n_2 ,\outA_V[20]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\outA_V[20]_INST_0_i_1_n_0 ,\outA_V[20]_INST_0_i_2_n_0 ,\outA_V[20]_INST_0_i_3_n_0 ,\outA_V[20]_INST_0_i_4_n_0 }),
        .O(outA_V[23:20]),
        .S({\outA_V[20]_INST_0_i_5_n_0 ,\outA_V[20]_INST_0_i_6_n_0 ,\outA_V[20]_INST_0_i_7_n_0 ,\outA_V[20]_INST_0_i_8_n_0 }));
  (* HLUTNM = "lutpair21" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[20]_INST_0_i_1 
       (.I0(reg_77[22]),
        .I1(inB_V_q0[22]),
        .I2(tmp_reg_119[22]),
        .O(\outA_V[20]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair20" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[20]_INST_0_i_2 
       (.I0(reg_77[21]),
        .I1(inB_V_q0[21]),
        .I2(tmp_reg_119[21]),
        .O(\outA_V[20]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair19" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[20]_INST_0_i_3 
       (.I0(reg_77[20]),
        .I1(inB_V_q0[20]),
        .I2(tmp_reg_119[20]),
        .O(\outA_V[20]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair18" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[20]_INST_0_i_4 
       (.I0(reg_77[19]),
        .I1(inB_V_q0[19]),
        .I2(tmp_reg_119[19]),
        .O(\outA_V[20]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair22" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[20]_INST_0_i_5 
       (.I0(reg_77[23]),
        .I1(inB_V_q0[23]),
        .I2(tmp_reg_119[23]),
        .I3(\outA_V[20]_INST_0_i_1_n_0 ),
        .O(\outA_V[20]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair21" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[20]_INST_0_i_6 
       (.I0(reg_77[22]),
        .I1(inB_V_q0[22]),
        .I2(tmp_reg_119[22]),
        .I3(\outA_V[20]_INST_0_i_2_n_0 ),
        .O(\outA_V[20]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair20" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[20]_INST_0_i_7 
       (.I0(reg_77[21]),
        .I1(inB_V_q0[21]),
        .I2(tmp_reg_119[21]),
        .I3(\outA_V[20]_INST_0_i_3_n_0 ),
        .O(\outA_V[20]_INST_0_i_7_n_0 ));
  (* HLUTNM = "lutpair19" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[20]_INST_0_i_8 
       (.I0(reg_77[20]),
        .I1(inB_V_q0[20]),
        .I2(tmp_reg_119[20]),
        .I3(\outA_V[20]_INST_0_i_4_n_0 ),
        .O(\outA_V[20]_INST_0_i_8_n_0 ));
  CARRY4 \outA_V[24]_INST_0 
       (.CI(\outA_V[20]_INST_0_n_0 ),
        .CO({\outA_V[24]_INST_0_n_0 ,\outA_V[24]_INST_0_n_1 ,\outA_V[24]_INST_0_n_2 ,\outA_V[24]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\outA_V[24]_INST_0_i_1_n_0 ,\outA_V[24]_INST_0_i_2_n_0 ,\outA_V[24]_INST_0_i_3_n_0 ,\outA_V[24]_INST_0_i_4_n_0 }),
        .O(outA_V[27:24]),
        .S({\outA_V[24]_INST_0_i_5_n_0 ,\outA_V[24]_INST_0_i_6_n_0 ,\outA_V[24]_INST_0_i_7_n_0 ,\outA_V[24]_INST_0_i_8_n_0 }));
  (* HLUTNM = "lutpair25" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[24]_INST_0_i_1 
       (.I0(reg_77[26]),
        .I1(inB_V_q0[26]),
        .I2(tmp_reg_119[26]),
        .O(\outA_V[24]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair24" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[24]_INST_0_i_2 
       (.I0(reg_77[25]),
        .I1(inB_V_q0[25]),
        .I2(tmp_reg_119[25]),
        .O(\outA_V[24]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair23" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[24]_INST_0_i_3 
       (.I0(reg_77[24]),
        .I1(inB_V_q0[24]),
        .I2(tmp_reg_119[24]),
        .O(\outA_V[24]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair22" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[24]_INST_0_i_4 
       (.I0(reg_77[23]),
        .I1(inB_V_q0[23]),
        .I2(tmp_reg_119[23]),
        .O(\outA_V[24]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair26" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[24]_INST_0_i_5 
       (.I0(reg_77[27]),
        .I1(inB_V_q0[27]),
        .I2(tmp_reg_119[27]),
        .I3(\outA_V[24]_INST_0_i_1_n_0 ),
        .O(\outA_V[24]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair25" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[24]_INST_0_i_6 
       (.I0(reg_77[26]),
        .I1(inB_V_q0[26]),
        .I2(tmp_reg_119[26]),
        .I3(\outA_V[24]_INST_0_i_2_n_0 ),
        .O(\outA_V[24]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair24" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[24]_INST_0_i_7 
       (.I0(reg_77[25]),
        .I1(inB_V_q0[25]),
        .I2(tmp_reg_119[25]),
        .I3(\outA_V[24]_INST_0_i_3_n_0 ),
        .O(\outA_V[24]_INST_0_i_7_n_0 ));
  (* HLUTNM = "lutpair23" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[24]_INST_0_i_8 
       (.I0(reg_77[24]),
        .I1(inB_V_q0[24]),
        .I2(tmp_reg_119[24]),
        .I3(\outA_V[24]_INST_0_i_4_n_0 ),
        .O(\outA_V[24]_INST_0_i_8_n_0 ));
  CARRY4 \outA_V[28]_INST_0 
       (.CI(\outA_V[24]_INST_0_n_0 ),
        .CO({\NLW_outA_V[28]_INST_0_CO_UNCONNECTED [3],\outA_V[28]_INST_0_n_1 ,\outA_V[28]_INST_0_n_2 ,\outA_V[28]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\outA_V[28]_INST_0_i_1_n_0 ,\outA_V[28]_INST_0_i_2_n_0 ,\outA_V[28]_INST_0_i_3_n_0 }),
        .O(outA_V[31:28]),
        .S({\outA_V[28]_INST_0_i_4_n_0 ,\outA_V[28]_INST_0_i_5_n_0 ,\outA_V[28]_INST_0_i_6_n_0 ,\outA_V[28]_INST_0_i_7_n_0 }));
  (* HLUTNM = "lutpair28" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[28]_INST_0_i_1 
       (.I0(reg_77[29]),
        .I1(inB_V_q0[29]),
        .I2(tmp_reg_119[29]),
        .O(\outA_V[28]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair27" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[28]_INST_0_i_2 
       (.I0(reg_77[28]),
        .I1(inB_V_q0[28]),
        .I2(tmp_reg_119[28]),
        .O(\outA_V[28]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair26" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[28]_INST_0_i_3 
       (.I0(reg_77[27]),
        .I1(inB_V_q0[27]),
        .I2(tmp_reg_119[27]),
        .O(\outA_V[28]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hD42B2BD42BD4D42B)) 
    \outA_V[28]_INST_0_i_4 
       (.I0(tmp_reg_119[30]),
        .I1(inB_V_q0[30]),
        .I2(reg_77[30]),
        .I3(inB_V_q0[31]),
        .I4(reg_77[31]),
        .I5(tmp_reg_119[31]),
        .O(\outA_V[28]_INST_0_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[28]_INST_0_i_5 
       (.I0(\outA_V[28]_INST_0_i_1_n_0 ),
        .I1(inB_V_q0[30]),
        .I2(reg_77[30]),
        .I3(tmp_reg_119[30]),
        .O(\outA_V[28]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair28" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[28]_INST_0_i_6 
       (.I0(reg_77[29]),
        .I1(inB_V_q0[29]),
        .I2(tmp_reg_119[29]),
        .I3(\outA_V[28]_INST_0_i_2_n_0 ),
        .O(\outA_V[28]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair27" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[28]_INST_0_i_7 
       (.I0(reg_77[28]),
        .I1(inB_V_q0[28]),
        .I2(tmp_reg_119[28]),
        .I3(\outA_V[28]_INST_0_i_3_n_0 ),
        .O(\outA_V[28]_INST_0_i_7_n_0 ));
  CARRY4 \outA_V[4]_INST_0 
       (.CI(\outA_V[0]_INST_0_n_0 ),
        .CO({\outA_V[4]_INST_0_n_0 ,\outA_V[4]_INST_0_n_1 ,\outA_V[4]_INST_0_n_2 ,\outA_V[4]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\outA_V[4]_INST_0_i_1_n_0 ,\outA_V[4]_INST_0_i_2_n_0 ,\outA_V[4]_INST_0_i_3_n_0 ,\outA_V[4]_INST_0_i_4_n_0 }),
        .O(outA_V[7:4]),
        .S({\outA_V[4]_INST_0_i_5_n_0 ,\outA_V[4]_INST_0_i_6_n_0 ,\outA_V[4]_INST_0_i_7_n_0 ,\outA_V[4]_INST_0_i_8_n_0 }));
  (* HLUTNM = "lutpair5" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[4]_INST_0_i_1 
       (.I0(reg_77[6]),
        .I1(inB_V_q0[6]),
        .I2(tmp_reg_119[6]),
        .O(\outA_V[4]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair4" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[4]_INST_0_i_2 
       (.I0(reg_77[5]),
        .I1(inB_V_q0[5]),
        .I2(tmp_reg_119[5]),
        .O(\outA_V[4]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair3" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[4]_INST_0_i_3 
       (.I0(reg_77[4]),
        .I1(inB_V_q0[4]),
        .I2(tmp_reg_119[4]),
        .O(\outA_V[4]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair2" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[4]_INST_0_i_4 
       (.I0(reg_77[3]),
        .I1(inB_V_q0[3]),
        .I2(tmp_reg_119[3]),
        .O(\outA_V[4]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair6" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[4]_INST_0_i_5 
       (.I0(reg_77[7]),
        .I1(inB_V_q0[7]),
        .I2(tmp_reg_119[7]),
        .I3(\outA_V[4]_INST_0_i_1_n_0 ),
        .O(\outA_V[4]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair5" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[4]_INST_0_i_6 
       (.I0(reg_77[6]),
        .I1(inB_V_q0[6]),
        .I2(tmp_reg_119[6]),
        .I3(\outA_V[4]_INST_0_i_2_n_0 ),
        .O(\outA_V[4]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair4" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[4]_INST_0_i_7 
       (.I0(reg_77[5]),
        .I1(inB_V_q0[5]),
        .I2(tmp_reg_119[5]),
        .I3(\outA_V[4]_INST_0_i_3_n_0 ),
        .O(\outA_V[4]_INST_0_i_7_n_0 ));
  (* HLUTNM = "lutpair3" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[4]_INST_0_i_8 
       (.I0(reg_77[4]),
        .I1(inB_V_q0[4]),
        .I2(tmp_reg_119[4]),
        .I3(\outA_V[4]_INST_0_i_4_n_0 ),
        .O(\outA_V[4]_INST_0_i_8_n_0 ));
  CARRY4 \outA_V[8]_INST_0 
       (.CI(\outA_V[4]_INST_0_n_0 ),
        .CO({\outA_V[8]_INST_0_n_0 ,\outA_V[8]_INST_0_n_1 ,\outA_V[8]_INST_0_n_2 ,\outA_V[8]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\outA_V[8]_INST_0_i_1_n_0 ,\outA_V[8]_INST_0_i_2_n_0 ,\outA_V[8]_INST_0_i_3_n_0 ,\outA_V[8]_INST_0_i_4_n_0 }),
        .O(outA_V[11:8]),
        .S({\outA_V[8]_INST_0_i_5_n_0 ,\outA_V[8]_INST_0_i_6_n_0 ,\outA_V[8]_INST_0_i_7_n_0 ,\outA_V[8]_INST_0_i_8_n_0 }));
  (* HLUTNM = "lutpair9" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[8]_INST_0_i_1 
       (.I0(reg_77[10]),
        .I1(inB_V_q0[10]),
        .I2(tmp_reg_119[10]),
        .O(\outA_V[8]_INST_0_i_1_n_0 ));
  (* HLUTNM = "lutpair8" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[8]_INST_0_i_2 
       (.I0(reg_77[9]),
        .I1(inB_V_q0[9]),
        .I2(tmp_reg_119[9]),
        .O(\outA_V[8]_INST_0_i_2_n_0 ));
  (* HLUTNM = "lutpair7" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[8]_INST_0_i_3 
       (.I0(reg_77[8]),
        .I1(inB_V_q0[8]),
        .I2(tmp_reg_119[8]),
        .O(\outA_V[8]_INST_0_i_3_n_0 ));
  (* HLUTNM = "lutpair6" *) 
  LUT3 #(
    .INIT(8'h71)) 
    \outA_V[8]_INST_0_i_4 
       (.I0(reg_77[7]),
        .I1(inB_V_q0[7]),
        .I2(tmp_reg_119[7]),
        .O(\outA_V[8]_INST_0_i_4_n_0 ));
  (* HLUTNM = "lutpair10" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[8]_INST_0_i_5 
       (.I0(reg_77[11]),
        .I1(inB_V_q0[11]),
        .I2(tmp_reg_119[11]),
        .I3(\outA_V[8]_INST_0_i_1_n_0 ),
        .O(\outA_V[8]_INST_0_i_5_n_0 ));
  (* HLUTNM = "lutpair9" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[8]_INST_0_i_6 
       (.I0(reg_77[10]),
        .I1(inB_V_q0[10]),
        .I2(tmp_reg_119[10]),
        .I3(\outA_V[8]_INST_0_i_2_n_0 ),
        .O(\outA_V[8]_INST_0_i_6_n_0 ));
  (* HLUTNM = "lutpair8" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[8]_INST_0_i_7 
       (.I0(reg_77[9]),
        .I1(inB_V_q0[9]),
        .I2(tmp_reg_119[9]),
        .I3(\outA_V[8]_INST_0_i_3_n_0 ),
        .O(\outA_V[8]_INST_0_i_7_n_0 ));
  (* HLUTNM = "lutpair7" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \outA_V[8]_INST_0_i_8 
       (.I0(reg_77[8]),
        .I1(inB_V_q0[8]),
        .I2(tmp_reg_119[8]),
        .I3(\outA_V[8]_INST_0_i_4_n_0 ),
        .O(\outA_V[8]_INST_0_i_8_n_0 ));
  FDRE \reg_77_reg[0] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[0]),
        .Q(reg_77[0]),
        .R(1'b0));
  FDRE \reg_77_reg[10] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[10]),
        .Q(reg_77[10]),
        .R(1'b0));
  FDRE \reg_77_reg[11] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[11]),
        .Q(reg_77[11]),
        .R(1'b0));
  FDRE \reg_77_reg[12] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[12]),
        .Q(reg_77[12]),
        .R(1'b0));
  FDRE \reg_77_reg[13] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[13]),
        .Q(reg_77[13]),
        .R(1'b0));
  FDRE \reg_77_reg[14] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[14]),
        .Q(reg_77[14]),
        .R(1'b0));
  FDRE \reg_77_reg[15] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[15]),
        .Q(reg_77[15]),
        .R(1'b0));
  FDRE \reg_77_reg[16] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[16]),
        .Q(reg_77[16]),
        .R(1'b0));
  FDRE \reg_77_reg[17] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[17]),
        .Q(reg_77[17]),
        .R(1'b0));
  FDRE \reg_77_reg[18] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[18]),
        .Q(reg_77[18]),
        .R(1'b0));
  FDRE \reg_77_reg[19] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[19]),
        .Q(reg_77[19]),
        .R(1'b0));
  FDRE \reg_77_reg[1] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[1]),
        .Q(reg_77[1]),
        .R(1'b0));
  FDRE \reg_77_reg[20] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[20]),
        .Q(reg_77[20]),
        .R(1'b0));
  FDRE \reg_77_reg[21] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[21]),
        .Q(reg_77[21]),
        .R(1'b0));
  FDRE \reg_77_reg[22] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[22]),
        .Q(reg_77[22]),
        .R(1'b0));
  FDRE \reg_77_reg[23] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[23]),
        .Q(reg_77[23]),
        .R(1'b0));
  FDRE \reg_77_reg[24] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[24]),
        .Q(reg_77[24]),
        .R(1'b0));
  FDRE \reg_77_reg[25] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[25]),
        .Q(reg_77[25]),
        .R(1'b0));
  FDRE \reg_77_reg[26] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[26]),
        .Q(reg_77[26]),
        .R(1'b0));
  FDRE \reg_77_reg[27] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[27]),
        .Q(reg_77[27]),
        .R(1'b0));
  FDRE \reg_77_reg[28] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[28]),
        .Q(reg_77[28]),
        .R(1'b0));
  FDRE \reg_77_reg[29] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[29]),
        .Q(reg_77[29]),
        .R(1'b0));
  FDRE \reg_77_reg[2] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[2]),
        .Q(reg_77[2]),
        .R(1'b0));
  FDRE \reg_77_reg[30] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[30]),
        .Q(reg_77[30]),
        .R(1'b0));
  FDRE \reg_77_reg[31] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[31]),
        .Q(reg_77[31]),
        .R(1'b0));
  FDRE \reg_77_reg[3] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[3]),
        .Q(reg_77[3]),
        .R(1'b0));
  FDRE \reg_77_reg[4] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[4]),
        .Q(reg_77[4]),
        .R(1'b0));
  FDRE \reg_77_reg[5] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[5]),
        .Q(reg_77[5]),
        .R(1'b0));
  FDRE \reg_77_reg[6] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[6]),
        .Q(reg_77[6]),
        .R(1'b0));
  FDRE \reg_77_reg[7] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[7]),
        .Q(reg_77[7]),
        .R(1'b0));
  FDRE \reg_77_reg[8] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[8]),
        .Q(reg_77[8]),
        .R(1'b0));
  FDRE \reg_77_reg[9] 
       (.C(ap_clk),
        .CE(inB_V_ce0),
        .D(inA_V_q0[9]),
        .Q(reg_77[9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[11]_i_2 
       (.I0(inB_V_q0[11]),
        .I1(reg_77[11]),
        .O(\tmp_reg_119[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[11]_i_3 
       (.I0(inB_V_q0[10]),
        .I1(reg_77[10]),
        .O(\tmp_reg_119[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[11]_i_4 
       (.I0(inB_V_q0[9]),
        .I1(reg_77[9]),
        .O(\tmp_reg_119[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[11]_i_5 
       (.I0(inB_V_q0[8]),
        .I1(reg_77[8]),
        .O(\tmp_reg_119[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[15]_i_2 
       (.I0(inB_V_q0[15]),
        .I1(reg_77[15]),
        .O(\tmp_reg_119[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[15]_i_3 
       (.I0(inB_V_q0[14]),
        .I1(reg_77[14]),
        .O(\tmp_reg_119[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[15]_i_4 
       (.I0(inB_V_q0[13]),
        .I1(reg_77[13]),
        .O(\tmp_reg_119[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[15]_i_5 
       (.I0(inB_V_q0[12]),
        .I1(reg_77[12]),
        .O(\tmp_reg_119[15]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[19]_i_2 
       (.I0(inB_V_q0[19]),
        .I1(reg_77[19]),
        .O(\tmp_reg_119[19]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[19]_i_3 
       (.I0(inB_V_q0[18]),
        .I1(reg_77[18]),
        .O(\tmp_reg_119[19]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[19]_i_4 
       (.I0(inB_V_q0[17]),
        .I1(reg_77[17]),
        .O(\tmp_reg_119[19]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[19]_i_5 
       (.I0(inB_V_q0[16]),
        .I1(reg_77[16]),
        .O(\tmp_reg_119[19]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[23]_i_2 
       (.I0(inB_V_q0[23]),
        .I1(reg_77[23]),
        .O(\tmp_reg_119[23]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[23]_i_3 
       (.I0(inB_V_q0[22]),
        .I1(reg_77[22]),
        .O(\tmp_reg_119[23]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[23]_i_4 
       (.I0(inB_V_q0[21]),
        .I1(reg_77[21]),
        .O(\tmp_reg_119[23]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[23]_i_5 
       (.I0(inB_V_q0[20]),
        .I1(reg_77[20]),
        .O(\tmp_reg_119[23]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[27]_i_2 
       (.I0(inB_V_q0[27]),
        .I1(reg_77[27]),
        .O(\tmp_reg_119[27]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[27]_i_3 
       (.I0(inB_V_q0[26]),
        .I1(reg_77[26]),
        .O(\tmp_reg_119[27]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[27]_i_4 
       (.I0(inB_V_q0[25]),
        .I1(reg_77[25]),
        .O(\tmp_reg_119[27]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[27]_i_5 
       (.I0(inB_V_q0[24]),
        .I1(reg_77[24]),
        .O(\tmp_reg_119[27]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[31]_i_2 
       (.I0(inB_V_q0[31]),
        .I1(reg_77[31]),
        .O(\tmp_reg_119[31]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[31]_i_3 
       (.I0(inB_V_q0[30]),
        .I1(reg_77[30]),
        .O(\tmp_reg_119[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[31]_i_4 
       (.I0(inB_V_q0[29]),
        .I1(reg_77[29]),
        .O(\tmp_reg_119[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[31]_i_5 
       (.I0(inB_V_q0[28]),
        .I1(reg_77[28]),
        .O(\tmp_reg_119[31]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[3]_i_2 
       (.I0(inB_V_q0[3]),
        .I1(reg_77[3]),
        .O(\tmp_reg_119[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[3]_i_3 
       (.I0(inB_V_q0[2]),
        .I1(reg_77[2]),
        .O(\tmp_reg_119[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[3]_i_4 
       (.I0(inB_V_q0[1]),
        .I1(reg_77[1]),
        .O(\tmp_reg_119[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[3]_i_5 
       (.I0(inB_V_q0[0]),
        .I1(reg_77[0]),
        .O(\tmp_reg_119[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[7]_i_2 
       (.I0(inB_V_q0[7]),
        .I1(reg_77[7]),
        .O(\tmp_reg_119[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[7]_i_3 
       (.I0(inB_V_q0[6]),
        .I1(reg_77[6]),
        .O(\tmp_reg_119[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[7]_i_4 
       (.I0(inB_V_q0[5]),
        .I1(reg_77[5]),
        .O(\tmp_reg_119[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \tmp_reg_119[7]_i_5 
       (.I0(inB_V_q0[4]),
        .I1(reg_77[4]),
        .O(\tmp_reg_119[7]_i_5_n_0 ));
  FDRE \tmp_reg_119_reg[0] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[0]),
        .Q(tmp_reg_119[0]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[10] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[10]),
        .Q(tmp_reg_119[10]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[11] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[11]),
        .Q(tmp_reg_119[11]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[11]_i_1 
       (.CI(\tmp_reg_119_reg[7]_i_1_n_0 ),
        .CO({\tmp_reg_119_reg[11]_i_1_n_0 ,\tmp_reg_119_reg[11]_i_1_n_1 ,\tmp_reg_119_reg[11]_i_1_n_2 ,\tmp_reg_119_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[11:8]),
        .O(tmp_fu_81_p2[11:8]),
        .S({\tmp_reg_119[11]_i_2_n_0 ,\tmp_reg_119[11]_i_3_n_0 ,\tmp_reg_119[11]_i_4_n_0 ,\tmp_reg_119[11]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[12] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[12]),
        .Q(tmp_reg_119[12]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[13] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[13]),
        .Q(tmp_reg_119[13]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[14] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[14]),
        .Q(tmp_reg_119[14]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[15] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[15]),
        .Q(tmp_reg_119[15]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[15]_i_1 
       (.CI(\tmp_reg_119_reg[11]_i_1_n_0 ),
        .CO({\tmp_reg_119_reg[15]_i_1_n_0 ,\tmp_reg_119_reg[15]_i_1_n_1 ,\tmp_reg_119_reg[15]_i_1_n_2 ,\tmp_reg_119_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[15:12]),
        .O(tmp_fu_81_p2[15:12]),
        .S({\tmp_reg_119[15]_i_2_n_0 ,\tmp_reg_119[15]_i_3_n_0 ,\tmp_reg_119[15]_i_4_n_0 ,\tmp_reg_119[15]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[16] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[16]),
        .Q(tmp_reg_119[16]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[17] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[17]),
        .Q(tmp_reg_119[17]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[18] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[18]),
        .Q(tmp_reg_119[18]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[19] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[19]),
        .Q(tmp_reg_119[19]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[19]_i_1 
       (.CI(\tmp_reg_119_reg[15]_i_1_n_0 ),
        .CO({\tmp_reg_119_reg[19]_i_1_n_0 ,\tmp_reg_119_reg[19]_i_1_n_1 ,\tmp_reg_119_reg[19]_i_1_n_2 ,\tmp_reg_119_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[19:16]),
        .O(tmp_fu_81_p2[19:16]),
        .S({\tmp_reg_119[19]_i_2_n_0 ,\tmp_reg_119[19]_i_3_n_0 ,\tmp_reg_119[19]_i_4_n_0 ,\tmp_reg_119[19]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[1] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[1]),
        .Q(tmp_reg_119[1]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[20] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[20]),
        .Q(tmp_reg_119[20]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[21] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[21]),
        .Q(tmp_reg_119[21]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[22] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[22]),
        .Q(tmp_reg_119[22]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[23] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[23]),
        .Q(tmp_reg_119[23]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[23]_i_1 
       (.CI(\tmp_reg_119_reg[19]_i_1_n_0 ),
        .CO({\tmp_reg_119_reg[23]_i_1_n_0 ,\tmp_reg_119_reg[23]_i_1_n_1 ,\tmp_reg_119_reg[23]_i_1_n_2 ,\tmp_reg_119_reg[23]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[23:20]),
        .O(tmp_fu_81_p2[23:20]),
        .S({\tmp_reg_119[23]_i_2_n_0 ,\tmp_reg_119[23]_i_3_n_0 ,\tmp_reg_119[23]_i_4_n_0 ,\tmp_reg_119[23]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[24] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[24]),
        .Q(tmp_reg_119[24]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[25] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[25]),
        .Q(tmp_reg_119[25]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[26] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[26]),
        .Q(tmp_reg_119[26]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[27] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[27]),
        .Q(tmp_reg_119[27]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[27]_i_1 
       (.CI(\tmp_reg_119_reg[23]_i_1_n_0 ),
        .CO({\tmp_reg_119_reg[27]_i_1_n_0 ,\tmp_reg_119_reg[27]_i_1_n_1 ,\tmp_reg_119_reg[27]_i_1_n_2 ,\tmp_reg_119_reg[27]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[27:24]),
        .O(tmp_fu_81_p2[27:24]),
        .S({\tmp_reg_119[27]_i_2_n_0 ,\tmp_reg_119[27]_i_3_n_0 ,\tmp_reg_119[27]_i_4_n_0 ,\tmp_reg_119[27]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[28] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[28]),
        .Q(tmp_reg_119[28]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[29] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[29]),
        .Q(tmp_reg_119[29]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[2] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[2]),
        .Q(tmp_reg_119[2]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[30] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[30]),
        .Q(tmp_reg_119[30]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[31] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[31]),
        .Q(tmp_reg_119[31]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[31]_i_1 
       (.CI(\tmp_reg_119_reg[27]_i_1_n_0 ),
        .CO({\NLW_tmp_reg_119_reg[31]_i_1_CO_UNCONNECTED [3],\tmp_reg_119_reg[31]_i_1_n_1 ,\tmp_reg_119_reg[31]_i_1_n_2 ,\tmp_reg_119_reg[31]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,inB_V_q0[30:28]}),
        .O(tmp_fu_81_p2[31:28]),
        .S({\tmp_reg_119[31]_i_2_n_0 ,\tmp_reg_119[31]_i_3_n_0 ,\tmp_reg_119[31]_i_4_n_0 ,\tmp_reg_119[31]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[3] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[3]),
        .Q(tmp_reg_119[3]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\tmp_reg_119_reg[3]_i_1_n_0 ,\tmp_reg_119_reg[3]_i_1_n_1 ,\tmp_reg_119_reg[3]_i_1_n_2 ,\tmp_reg_119_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[3:0]),
        .O(tmp_fu_81_p2[3:0]),
        .S({\tmp_reg_119[3]_i_2_n_0 ,\tmp_reg_119[3]_i_3_n_0 ,\tmp_reg_119[3]_i_4_n_0 ,\tmp_reg_119[3]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[4] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[4]),
        .Q(tmp_reg_119[4]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[5] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[5]),
        .Q(tmp_reg_119[5]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[6] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[6]),
        .Q(tmp_reg_119[6]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[7] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[7]),
        .Q(tmp_reg_119[7]),
        .R(1'b0));
  CARRY4 \tmp_reg_119_reg[7]_i_1 
       (.CI(\tmp_reg_119_reg[3]_i_1_n_0 ),
        .CO({\tmp_reg_119_reg[7]_i_1_n_0 ,\tmp_reg_119_reg[7]_i_1_n_1 ,\tmp_reg_119_reg[7]_i_1_n_2 ,\tmp_reg_119_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(inB_V_q0[7:4]),
        .O(tmp_fu_81_p2[7:4]),
        .S({\tmp_reg_119[7]_i_2_n_0 ,\tmp_reg_119[7]_i_3_n_0 ,\tmp_reg_119[7]_i_4_n_0 ,\tmp_reg_119[7]_i_5_n_0 }));
  FDRE \tmp_reg_119_reg[8] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[8]),
        .Q(tmp_reg_119[8]),
        .R(1'b0));
  FDRE \tmp_reg_119_reg[9] 
       (.C(ap_clk),
        .CE(inB_V_address0),
        .D(tmp_fu_81_p2[9]),
        .Q(tmp_reg_119[9]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
