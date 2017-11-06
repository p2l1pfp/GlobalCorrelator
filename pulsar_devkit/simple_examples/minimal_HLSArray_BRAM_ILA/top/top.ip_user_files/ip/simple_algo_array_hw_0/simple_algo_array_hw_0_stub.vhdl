-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Tue Oct 10 15:14:06 2017
-- Host        : nucts01 running 64-bit CentOS release 6.9 (Final)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ssevova/GlobalCorrelator/pulsar_devkit/simple_examples/minimal_HLSArray_BRAM_ILA/top/top.srcs/sources_1/ip/simple_algo_array_hw_0/simple_algo_array_hw_0_stub.vhdl
-- Design      : simple_algo_array_hw_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simple_algo_array_hw_0 is
  Port ( 
    inA_V_ce0 : out STD_LOGIC;
    inB_V_ce0 : out STD_LOGIC;
    outA_V_ap_vld : out STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    inA_V_address0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    inA_V_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inB_V_address0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    inB_V_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    outA_V : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end simple_algo_array_hw_0;

architecture stub of simple_algo_array_hw_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "inA_V_ce0,inB_V_ce0,outA_V_ap_vld,ap_clk,ap_rst,ap_start,ap_done,ap_idle,ap_ready,inA_V_address0[0:0],inA_V_q0[31:0],inB_V_address0[0:0],inB_V_q0[31:0],outA_V[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "simple_algo_array_hw,Vivado 2016.4";
begin
end;
