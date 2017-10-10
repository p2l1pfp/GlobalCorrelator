-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Tue Oct 10 15:14:06 2017
-- Host        : nucts01 running 64-bit CentOS release 6.9 (Final)
-- Command     : write_vhdl -force -mode funcsim
--               /home/ssevova/GlobalCorrelator/pulsar_devkit/simple_examples/minimal_HLSArray_BRAM_ILA/top/top.srcs/sources_1/ip/simple_algo_array_hw_0/simple_algo_array_hw_0_sim_netlist.vhdl
-- Design      : simple_algo_array_hw_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity simple_algo_array_hw_0_simple_algo_array_hw is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    inA_V_address0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    inA_V_ce0 : out STD_LOGIC;
    inA_V_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    inB_V_address0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    inB_V_ce0 : out STD_LOGIC;
    inB_V_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    outA_V : out STD_LOGIC_VECTOR ( 31 downto 0 );
    outA_V_ap_vld : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of simple_algo_array_hw_0_simple_algo_array_hw : entity is "simple_algo_array_hw";
end simple_algo_array_hw_0_simple_algo_array_hw;

architecture STRUCTURE of simple_algo_array_hw_0_simple_algo_array_hw is
  signal \ap_CS_fsm_reg_n_0_[0]\ : STD_LOGIC;
  signal ap_NS_fsm : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^ap_done\ : STD_LOGIC;
  signal \^ina_v_address0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^inb_v_address0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^inb_v_ce0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[0]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[12]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[16]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[20]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[24]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[28]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[4]_INST_0_n_3\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_n_0\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_n_1\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_n_2\ : STD_LOGIC;
  signal \outA_V[8]_INST_0_n_3\ : STD_LOGIC;
  signal reg_77 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal tmp_fu_81_p2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal tmp_reg_119 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \tmp_reg_119[11]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[11]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[11]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[11]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[15]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[15]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[15]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[15]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[19]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[19]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[19]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[19]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[23]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[23]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[23]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[23]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[27]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[27]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[27]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[27]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[31]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[31]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[31]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[31]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[3]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[3]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[3]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[3]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[7]_i_2_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[7]_i_3_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[7]_i_4_n_0\ : STD_LOGIC;
  signal \tmp_reg_119[7]_i_5_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[15]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[15]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[15]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[19]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[19]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[19]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[23]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[23]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[23]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[27]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[27]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[27]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[27]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[31]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[31]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[31]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \tmp_reg_119_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \tmp_reg_119_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \tmp_reg_119_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \tmp_reg_119_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \NLW_outA_V[28]_INST_0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_tmp_reg_119_reg[31]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ap_CS_fsm[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \ap_CS_fsm[1]_i_1\ : label is "soft_lutpair0";
  attribute FSM_ENCODING : string;
  attribute FSM_ENCODING of \ap_CS_fsm_reg[0]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[1]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[2]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[3]\ : label is "none";
  attribute SOFT_HLUTNM of ap_idle_INST_0 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of inA_V_ce0_INST_0 : label is "soft_lutpair0";
  attribute HLUTNM : string;
  attribute HLUTNM of \outA_V[0]_INST_0_i_1\ : label is "lutpair1";
  attribute HLUTNM of \outA_V[0]_INST_0_i_2\ : label is "lutpair0";
  attribute HLUTNM of \outA_V[0]_INST_0_i_3\ : label is "lutpair29";
  attribute HLUTNM of \outA_V[0]_INST_0_i_4\ : label is "lutpair2";
  attribute HLUTNM of \outA_V[0]_INST_0_i_5\ : label is "lutpair1";
  attribute HLUTNM of \outA_V[0]_INST_0_i_6\ : label is "lutpair0";
  attribute HLUTNM of \outA_V[0]_INST_0_i_7\ : label is "lutpair29";
  attribute HLUTNM of \outA_V[12]_INST_0_i_1\ : label is "lutpair13";
  attribute HLUTNM of \outA_V[12]_INST_0_i_2\ : label is "lutpair12";
  attribute HLUTNM of \outA_V[12]_INST_0_i_3\ : label is "lutpair11";
  attribute HLUTNM of \outA_V[12]_INST_0_i_4\ : label is "lutpair10";
  attribute HLUTNM of \outA_V[12]_INST_0_i_5\ : label is "lutpair14";
  attribute HLUTNM of \outA_V[12]_INST_0_i_6\ : label is "lutpair13";
  attribute HLUTNM of \outA_V[12]_INST_0_i_7\ : label is "lutpair12";
  attribute HLUTNM of \outA_V[12]_INST_0_i_8\ : label is "lutpair11";
  attribute HLUTNM of \outA_V[16]_INST_0_i_1\ : label is "lutpair17";
  attribute HLUTNM of \outA_V[16]_INST_0_i_2\ : label is "lutpair16";
  attribute HLUTNM of \outA_V[16]_INST_0_i_3\ : label is "lutpair15";
  attribute HLUTNM of \outA_V[16]_INST_0_i_4\ : label is "lutpair14";
  attribute HLUTNM of \outA_V[16]_INST_0_i_5\ : label is "lutpair18";
  attribute HLUTNM of \outA_V[16]_INST_0_i_6\ : label is "lutpair17";
  attribute HLUTNM of \outA_V[16]_INST_0_i_7\ : label is "lutpair16";
  attribute HLUTNM of \outA_V[16]_INST_0_i_8\ : label is "lutpair15";
  attribute HLUTNM of \outA_V[20]_INST_0_i_1\ : label is "lutpair21";
  attribute HLUTNM of \outA_V[20]_INST_0_i_2\ : label is "lutpair20";
  attribute HLUTNM of \outA_V[20]_INST_0_i_3\ : label is "lutpair19";
  attribute HLUTNM of \outA_V[20]_INST_0_i_4\ : label is "lutpair18";
  attribute HLUTNM of \outA_V[20]_INST_0_i_5\ : label is "lutpair22";
  attribute HLUTNM of \outA_V[20]_INST_0_i_6\ : label is "lutpair21";
  attribute HLUTNM of \outA_V[20]_INST_0_i_7\ : label is "lutpair20";
  attribute HLUTNM of \outA_V[20]_INST_0_i_8\ : label is "lutpair19";
  attribute HLUTNM of \outA_V[24]_INST_0_i_1\ : label is "lutpair25";
  attribute HLUTNM of \outA_V[24]_INST_0_i_2\ : label is "lutpair24";
  attribute HLUTNM of \outA_V[24]_INST_0_i_3\ : label is "lutpair23";
  attribute HLUTNM of \outA_V[24]_INST_0_i_4\ : label is "lutpair22";
  attribute HLUTNM of \outA_V[24]_INST_0_i_5\ : label is "lutpair26";
  attribute HLUTNM of \outA_V[24]_INST_0_i_6\ : label is "lutpair25";
  attribute HLUTNM of \outA_V[24]_INST_0_i_7\ : label is "lutpair24";
  attribute HLUTNM of \outA_V[24]_INST_0_i_8\ : label is "lutpair23";
  attribute HLUTNM of \outA_V[28]_INST_0_i_1\ : label is "lutpair28";
  attribute HLUTNM of \outA_V[28]_INST_0_i_2\ : label is "lutpair27";
  attribute HLUTNM of \outA_V[28]_INST_0_i_3\ : label is "lutpair26";
  attribute HLUTNM of \outA_V[28]_INST_0_i_6\ : label is "lutpair28";
  attribute HLUTNM of \outA_V[28]_INST_0_i_7\ : label is "lutpair27";
  attribute HLUTNM of \outA_V[4]_INST_0_i_1\ : label is "lutpair5";
  attribute HLUTNM of \outA_V[4]_INST_0_i_2\ : label is "lutpair4";
  attribute HLUTNM of \outA_V[4]_INST_0_i_3\ : label is "lutpair3";
  attribute HLUTNM of \outA_V[4]_INST_0_i_4\ : label is "lutpair2";
  attribute HLUTNM of \outA_V[4]_INST_0_i_5\ : label is "lutpair6";
  attribute HLUTNM of \outA_V[4]_INST_0_i_6\ : label is "lutpair5";
  attribute HLUTNM of \outA_V[4]_INST_0_i_7\ : label is "lutpair4";
  attribute HLUTNM of \outA_V[4]_INST_0_i_8\ : label is "lutpair3";
  attribute HLUTNM of \outA_V[8]_INST_0_i_1\ : label is "lutpair9";
  attribute HLUTNM of \outA_V[8]_INST_0_i_2\ : label is "lutpair8";
  attribute HLUTNM of \outA_V[8]_INST_0_i_3\ : label is "lutpair7";
  attribute HLUTNM of \outA_V[8]_INST_0_i_4\ : label is "lutpair6";
  attribute HLUTNM of \outA_V[8]_INST_0_i_5\ : label is "lutpair10";
  attribute HLUTNM of \outA_V[8]_INST_0_i_6\ : label is "lutpair9";
  attribute HLUTNM of \outA_V[8]_INST_0_i_7\ : label is "lutpair8";
  attribute HLUTNM of \outA_V[8]_INST_0_i_8\ : label is "lutpair7";
begin
  ap_done <= \^ap_done\;
  ap_ready <= \^ap_done\;
  inA_V_address0(0) <= \^ina_v_address0\(0);
  inB_V_address0(0) <= \^inb_v_address0\(0);
  inB_V_ce0 <= \^inb_v_ce0\;
  outA_V_ap_vld <= \^ap_done\;
\ap_CS_fsm[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \^ap_done\,
      I1 => ap_start,
      I2 => \ap_CS_fsm_reg_n_0_[0]\,
      O => ap_NS_fsm(0)
    );
\ap_CS_fsm[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => ap_start,
      I1 => \^ap_done\,
      I2 => \^ina_v_address0\(0),
      I3 => \^inb_v_address0\(0),
      O => ap_NS_fsm(1)
    );
\ap_CS_fsm_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(0),
      Q => \ap_CS_fsm_reg_n_0_[0]\,
      S => ap_rst
    );
\ap_CS_fsm_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(1),
      Q => \^ina_v_address0\(0),
      R => ap_rst
    );
\ap_CS_fsm_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \^ina_v_address0\(0),
      Q => \^inb_v_address0\(0),
      R => ap_rst
    );
\ap_CS_fsm_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \^inb_v_address0\(0),
      Q => \^ap_done\,
      R => ap_rst
    );
ap_idle_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ap_CS_fsm_reg_n_0_[0]\,
      I1 => ap_start,
      O => ap_idle
    );
inA_V_ce0_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => \^ina_v_address0\(0),
      I1 => \ap_CS_fsm_reg_n_0_[0]\,
      I2 => ap_start,
      O => inA_V_ce0
    );
inB_V_ce0_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^ina_v_address0\(0),
      I1 => \^inb_v_address0\(0),
      O => \^inb_v_ce0\
    );
\outA_V[0]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \outA_V[0]_INST_0_n_0\,
      CO(2) => \outA_V[0]_INST_0_n_1\,
      CO(1) => \outA_V[0]_INST_0_n_2\,
      CO(0) => \outA_V[0]_INST_0_n_3\,
      CYINIT => '1',
      DI(3) => \outA_V[0]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[0]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[0]_INST_0_i_3_n_0\,
      DI(0) => '1',
      O(3 downto 0) => outA_V(3 downto 0),
      S(3) => \outA_V[0]_INST_0_i_4_n_0\,
      S(2) => \outA_V[0]_INST_0_i_5_n_0\,
      S(1) => \outA_V[0]_INST_0_i_6_n_0\,
      S(0) => \outA_V[0]_INST_0_i_7_n_0\
    );
\outA_V[0]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(2),
      I1 => inB_V_q0(2),
      I2 => tmp_reg_119(2),
      O => \outA_V[0]_INST_0_i_1_n_0\
    );
\outA_V[0]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(1),
      I1 => inB_V_q0(1),
      I2 => tmp_reg_119(1),
      O => \outA_V[0]_INST_0_i_2_n_0\
    );
\outA_V[0]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(0),
      I1 => inB_V_q0(0),
      I2 => tmp_reg_119(0),
      O => \outA_V[0]_INST_0_i_3_n_0\
    );
\outA_V[0]_INST_0_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(3),
      I1 => inB_V_q0(3),
      I2 => tmp_reg_119(3),
      I3 => \outA_V[0]_INST_0_i_1_n_0\,
      O => \outA_V[0]_INST_0_i_4_n_0\
    );
\outA_V[0]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(2),
      I1 => inB_V_q0(2),
      I2 => tmp_reg_119(2),
      I3 => \outA_V[0]_INST_0_i_2_n_0\,
      O => \outA_V[0]_INST_0_i_5_n_0\
    );
\outA_V[0]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(1),
      I1 => inB_V_q0(1),
      I2 => tmp_reg_119(1),
      I3 => \outA_V[0]_INST_0_i_3_n_0\,
      O => \outA_V[0]_INST_0_i_6_n_0\
    );
\outA_V[0]_INST_0_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => reg_77(0),
      I1 => inB_V_q0(0),
      I2 => tmp_reg_119(0),
      O => \outA_V[0]_INST_0_i_7_n_0\
    );
\outA_V[12]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[8]_INST_0_n_0\,
      CO(3) => \outA_V[12]_INST_0_n_0\,
      CO(2) => \outA_V[12]_INST_0_n_1\,
      CO(1) => \outA_V[12]_INST_0_n_2\,
      CO(0) => \outA_V[12]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \outA_V[12]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[12]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[12]_INST_0_i_3_n_0\,
      DI(0) => \outA_V[12]_INST_0_i_4_n_0\,
      O(3 downto 0) => outA_V(15 downto 12),
      S(3) => \outA_V[12]_INST_0_i_5_n_0\,
      S(2) => \outA_V[12]_INST_0_i_6_n_0\,
      S(1) => \outA_V[12]_INST_0_i_7_n_0\,
      S(0) => \outA_V[12]_INST_0_i_8_n_0\
    );
\outA_V[12]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(14),
      I1 => inB_V_q0(14),
      I2 => tmp_reg_119(14),
      O => \outA_V[12]_INST_0_i_1_n_0\
    );
\outA_V[12]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(13),
      I1 => inB_V_q0(13),
      I2 => tmp_reg_119(13),
      O => \outA_V[12]_INST_0_i_2_n_0\
    );
\outA_V[12]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(12),
      I1 => inB_V_q0(12),
      I2 => tmp_reg_119(12),
      O => \outA_V[12]_INST_0_i_3_n_0\
    );
\outA_V[12]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(11),
      I1 => inB_V_q0(11),
      I2 => tmp_reg_119(11),
      O => \outA_V[12]_INST_0_i_4_n_0\
    );
\outA_V[12]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(15),
      I1 => inB_V_q0(15),
      I2 => tmp_reg_119(15),
      I3 => \outA_V[12]_INST_0_i_1_n_0\,
      O => \outA_V[12]_INST_0_i_5_n_0\
    );
\outA_V[12]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(14),
      I1 => inB_V_q0(14),
      I2 => tmp_reg_119(14),
      I3 => \outA_V[12]_INST_0_i_2_n_0\,
      O => \outA_V[12]_INST_0_i_6_n_0\
    );
\outA_V[12]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(13),
      I1 => inB_V_q0(13),
      I2 => tmp_reg_119(13),
      I3 => \outA_V[12]_INST_0_i_3_n_0\,
      O => \outA_V[12]_INST_0_i_7_n_0\
    );
\outA_V[12]_INST_0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(12),
      I1 => inB_V_q0(12),
      I2 => tmp_reg_119(12),
      I3 => \outA_V[12]_INST_0_i_4_n_0\,
      O => \outA_V[12]_INST_0_i_8_n_0\
    );
\outA_V[16]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[12]_INST_0_n_0\,
      CO(3) => \outA_V[16]_INST_0_n_0\,
      CO(2) => \outA_V[16]_INST_0_n_1\,
      CO(1) => \outA_V[16]_INST_0_n_2\,
      CO(0) => \outA_V[16]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \outA_V[16]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[16]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[16]_INST_0_i_3_n_0\,
      DI(0) => \outA_V[16]_INST_0_i_4_n_0\,
      O(3 downto 0) => outA_V(19 downto 16),
      S(3) => \outA_V[16]_INST_0_i_5_n_0\,
      S(2) => \outA_V[16]_INST_0_i_6_n_0\,
      S(1) => \outA_V[16]_INST_0_i_7_n_0\,
      S(0) => \outA_V[16]_INST_0_i_8_n_0\
    );
\outA_V[16]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(18),
      I1 => inB_V_q0(18),
      I2 => tmp_reg_119(18),
      O => \outA_V[16]_INST_0_i_1_n_0\
    );
\outA_V[16]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(17),
      I1 => inB_V_q0(17),
      I2 => tmp_reg_119(17),
      O => \outA_V[16]_INST_0_i_2_n_0\
    );
\outA_V[16]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(16),
      I1 => inB_V_q0(16),
      I2 => tmp_reg_119(16),
      O => \outA_V[16]_INST_0_i_3_n_0\
    );
\outA_V[16]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(15),
      I1 => inB_V_q0(15),
      I2 => tmp_reg_119(15),
      O => \outA_V[16]_INST_0_i_4_n_0\
    );
\outA_V[16]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(19),
      I1 => inB_V_q0(19),
      I2 => tmp_reg_119(19),
      I3 => \outA_V[16]_INST_0_i_1_n_0\,
      O => \outA_V[16]_INST_0_i_5_n_0\
    );
\outA_V[16]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(18),
      I1 => inB_V_q0(18),
      I2 => tmp_reg_119(18),
      I3 => \outA_V[16]_INST_0_i_2_n_0\,
      O => \outA_V[16]_INST_0_i_6_n_0\
    );
\outA_V[16]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(17),
      I1 => inB_V_q0(17),
      I2 => tmp_reg_119(17),
      I3 => \outA_V[16]_INST_0_i_3_n_0\,
      O => \outA_V[16]_INST_0_i_7_n_0\
    );
\outA_V[16]_INST_0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(16),
      I1 => inB_V_q0(16),
      I2 => tmp_reg_119(16),
      I3 => \outA_V[16]_INST_0_i_4_n_0\,
      O => \outA_V[16]_INST_0_i_8_n_0\
    );
\outA_V[20]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[16]_INST_0_n_0\,
      CO(3) => \outA_V[20]_INST_0_n_0\,
      CO(2) => \outA_V[20]_INST_0_n_1\,
      CO(1) => \outA_V[20]_INST_0_n_2\,
      CO(0) => \outA_V[20]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \outA_V[20]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[20]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[20]_INST_0_i_3_n_0\,
      DI(0) => \outA_V[20]_INST_0_i_4_n_0\,
      O(3 downto 0) => outA_V(23 downto 20),
      S(3) => \outA_V[20]_INST_0_i_5_n_0\,
      S(2) => \outA_V[20]_INST_0_i_6_n_0\,
      S(1) => \outA_V[20]_INST_0_i_7_n_0\,
      S(0) => \outA_V[20]_INST_0_i_8_n_0\
    );
\outA_V[20]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(22),
      I1 => inB_V_q0(22),
      I2 => tmp_reg_119(22),
      O => \outA_V[20]_INST_0_i_1_n_0\
    );
\outA_V[20]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(21),
      I1 => inB_V_q0(21),
      I2 => tmp_reg_119(21),
      O => \outA_V[20]_INST_0_i_2_n_0\
    );
\outA_V[20]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(20),
      I1 => inB_V_q0(20),
      I2 => tmp_reg_119(20),
      O => \outA_V[20]_INST_0_i_3_n_0\
    );
\outA_V[20]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(19),
      I1 => inB_V_q0(19),
      I2 => tmp_reg_119(19),
      O => \outA_V[20]_INST_0_i_4_n_0\
    );
\outA_V[20]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(23),
      I1 => inB_V_q0(23),
      I2 => tmp_reg_119(23),
      I3 => \outA_V[20]_INST_0_i_1_n_0\,
      O => \outA_V[20]_INST_0_i_5_n_0\
    );
\outA_V[20]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(22),
      I1 => inB_V_q0(22),
      I2 => tmp_reg_119(22),
      I3 => \outA_V[20]_INST_0_i_2_n_0\,
      O => \outA_V[20]_INST_0_i_6_n_0\
    );
\outA_V[20]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(21),
      I1 => inB_V_q0(21),
      I2 => tmp_reg_119(21),
      I3 => \outA_V[20]_INST_0_i_3_n_0\,
      O => \outA_V[20]_INST_0_i_7_n_0\
    );
\outA_V[20]_INST_0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(20),
      I1 => inB_V_q0(20),
      I2 => tmp_reg_119(20),
      I3 => \outA_V[20]_INST_0_i_4_n_0\,
      O => \outA_V[20]_INST_0_i_8_n_0\
    );
\outA_V[24]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[20]_INST_0_n_0\,
      CO(3) => \outA_V[24]_INST_0_n_0\,
      CO(2) => \outA_V[24]_INST_0_n_1\,
      CO(1) => \outA_V[24]_INST_0_n_2\,
      CO(0) => \outA_V[24]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \outA_V[24]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[24]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[24]_INST_0_i_3_n_0\,
      DI(0) => \outA_V[24]_INST_0_i_4_n_0\,
      O(3 downto 0) => outA_V(27 downto 24),
      S(3) => \outA_V[24]_INST_0_i_5_n_0\,
      S(2) => \outA_V[24]_INST_0_i_6_n_0\,
      S(1) => \outA_V[24]_INST_0_i_7_n_0\,
      S(0) => \outA_V[24]_INST_0_i_8_n_0\
    );
\outA_V[24]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(26),
      I1 => inB_V_q0(26),
      I2 => tmp_reg_119(26),
      O => \outA_V[24]_INST_0_i_1_n_0\
    );
\outA_V[24]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(25),
      I1 => inB_V_q0(25),
      I2 => tmp_reg_119(25),
      O => \outA_V[24]_INST_0_i_2_n_0\
    );
\outA_V[24]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(24),
      I1 => inB_V_q0(24),
      I2 => tmp_reg_119(24),
      O => \outA_V[24]_INST_0_i_3_n_0\
    );
\outA_V[24]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(23),
      I1 => inB_V_q0(23),
      I2 => tmp_reg_119(23),
      O => \outA_V[24]_INST_0_i_4_n_0\
    );
\outA_V[24]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(27),
      I1 => inB_V_q0(27),
      I2 => tmp_reg_119(27),
      I3 => \outA_V[24]_INST_0_i_1_n_0\,
      O => \outA_V[24]_INST_0_i_5_n_0\
    );
\outA_V[24]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(26),
      I1 => inB_V_q0(26),
      I2 => tmp_reg_119(26),
      I3 => \outA_V[24]_INST_0_i_2_n_0\,
      O => \outA_V[24]_INST_0_i_6_n_0\
    );
\outA_V[24]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(25),
      I1 => inB_V_q0(25),
      I2 => tmp_reg_119(25),
      I3 => \outA_V[24]_INST_0_i_3_n_0\,
      O => \outA_V[24]_INST_0_i_7_n_0\
    );
\outA_V[24]_INST_0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(24),
      I1 => inB_V_q0(24),
      I2 => tmp_reg_119(24),
      I3 => \outA_V[24]_INST_0_i_4_n_0\,
      O => \outA_V[24]_INST_0_i_8_n_0\
    );
\outA_V[28]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[24]_INST_0_n_0\,
      CO(3) => \NLW_outA_V[28]_INST_0_CO_UNCONNECTED\(3),
      CO(2) => \outA_V[28]_INST_0_n_1\,
      CO(1) => \outA_V[28]_INST_0_n_2\,
      CO(0) => \outA_V[28]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \outA_V[28]_INST_0_i_1_n_0\,
      DI(1) => \outA_V[28]_INST_0_i_2_n_0\,
      DI(0) => \outA_V[28]_INST_0_i_3_n_0\,
      O(3 downto 0) => outA_V(31 downto 28),
      S(3) => \outA_V[28]_INST_0_i_4_n_0\,
      S(2) => \outA_V[28]_INST_0_i_5_n_0\,
      S(1) => \outA_V[28]_INST_0_i_6_n_0\,
      S(0) => \outA_V[28]_INST_0_i_7_n_0\
    );
\outA_V[28]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(29),
      I1 => inB_V_q0(29),
      I2 => tmp_reg_119(29),
      O => \outA_V[28]_INST_0_i_1_n_0\
    );
\outA_V[28]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(28),
      I1 => inB_V_q0(28),
      I2 => tmp_reg_119(28),
      O => \outA_V[28]_INST_0_i_2_n_0\
    );
\outA_V[28]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(27),
      I1 => inB_V_q0(27),
      I2 => tmp_reg_119(27),
      O => \outA_V[28]_INST_0_i_3_n_0\
    );
\outA_V[28]_INST_0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D42B2BD42BD4D42B"
    )
        port map (
      I0 => tmp_reg_119(30),
      I1 => inB_V_q0(30),
      I2 => reg_77(30),
      I3 => inB_V_q0(31),
      I4 => reg_77(31),
      I5 => tmp_reg_119(31),
      O => \outA_V[28]_INST_0_i_4_n_0\
    );
\outA_V[28]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \outA_V[28]_INST_0_i_1_n_0\,
      I1 => inB_V_q0(30),
      I2 => reg_77(30),
      I3 => tmp_reg_119(30),
      O => \outA_V[28]_INST_0_i_5_n_0\
    );
\outA_V[28]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(29),
      I1 => inB_V_q0(29),
      I2 => tmp_reg_119(29),
      I3 => \outA_V[28]_INST_0_i_2_n_0\,
      O => \outA_V[28]_INST_0_i_6_n_0\
    );
\outA_V[28]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(28),
      I1 => inB_V_q0(28),
      I2 => tmp_reg_119(28),
      I3 => \outA_V[28]_INST_0_i_3_n_0\,
      O => \outA_V[28]_INST_0_i_7_n_0\
    );
\outA_V[4]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[0]_INST_0_n_0\,
      CO(3) => \outA_V[4]_INST_0_n_0\,
      CO(2) => \outA_V[4]_INST_0_n_1\,
      CO(1) => \outA_V[4]_INST_0_n_2\,
      CO(0) => \outA_V[4]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \outA_V[4]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[4]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[4]_INST_0_i_3_n_0\,
      DI(0) => \outA_V[4]_INST_0_i_4_n_0\,
      O(3 downto 0) => outA_V(7 downto 4),
      S(3) => \outA_V[4]_INST_0_i_5_n_0\,
      S(2) => \outA_V[4]_INST_0_i_6_n_0\,
      S(1) => \outA_V[4]_INST_0_i_7_n_0\,
      S(0) => \outA_V[4]_INST_0_i_8_n_0\
    );
\outA_V[4]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(6),
      I1 => inB_V_q0(6),
      I2 => tmp_reg_119(6),
      O => \outA_V[4]_INST_0_i_1_n_0\
    );
\outA_V[4]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(5),
      I1 => inB_V_q0(5),
      I2 => tmp_reg_119(5),
      O => \outA_V[4]_INST_0_i_2_n_0\
    );
\outA_V[4]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(4),
      I1 => inB_V_q0(4),
      I2 => tmp_reg_119(4),
      O => \outA_V[4]_INST_0_i_3_n_0\
    );
\outA_V[4]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(3),
      I1 => inB_V_q0(3),
      I2 => tmp_reg_119(3),
      O => \outA_V[4]_INST_0_i_4_n_0\
    );
\outA_V[4]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(7),
      I1 => inB_V_q0(7),
      I2 => tmp_reg_119(7),
      I3 => \outA_V[4]_INST_0_i_1_n_0\,
      O => \outA_V[4]_INST_0_i_5_n_0\
    );
\outA_V[4]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(6),
      I1 => inB_V_q0(6),
      I2 => tmp_reg_119(6),
      I3 => \outA_V[4]_INST_0_i_2_n_0\,
      O => \outA_V[4]_INST_0_i_6_n_0\
    );
\outA_V[4]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(5),
      I1 => inB_V_q0(5),
      I2 => tmp_reg_119(5),
      I3 => \outA_V[4]_INST_0_i_3_n_0\,
      O => \outA_V[4]_INST_0_i_7_n_0\
    );
\outA_V[4]_INST_0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(4),
      I1 => inB_V_q0(4),
      I2 => tmp_reg_119(4),
      I3 => \outA_V[4]_INST_0_i_4_n_0\,
      O => \outA_V[4]_INST_0_i_8_n_0\
    );
\outA_V[8]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \outA_V[4]_INST_0_n_0\,
      CO(3) => \outA_V[8]_INST_0_n_0\,
      CO(2) => \outA_V[8]_INST_0_n_1\,
      CO(1) => \outA_V[8]_INST_0_n_2\,
      CO(0) => \outA_V[8]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \outA_V[8]_INST_0_i_1_n_0\,
      DI(2) => \outA_V[8]_INST_0_i_2_n_0\,
      DI(1) => \outA_V[8]_INST_0_i_3_n_0\,
      DI(0) => \outA_V[8]_INST_0_i_4_n_0\,
      O(3 downto 0) => outA_V(11 downto 8),
      S(3) => \outA_V[8]_INST_0_i_5_n_0\,
      S(2) => \outA_V[8]_INST_0_i_6_n_0\,
      S(1) => \outA_V[8]_INST_0_i_7_n_0\,
      S(0) => \outA_V[8]_INST_0_i_8_n_0\
    );
\outA_V[8]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(10),
      I1 => inB_V_q0(10),
      I2 => tmp_reg_119(10),
      O => \outA_V[8]_INST_0_i_1_n_0\
    );
\outA_V[8]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(9),
      I1 => inB_V_q0(9),
      I2 => tmp_reg_119(9),
      O => \outA_V[8]_INST_0_i_2_n_0\
    );
\outA_V[8]_INST_0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(8),
      I1 => inB_V_q0(8),
      I2 => tmp_reg_119(8),
      O => \outA_V[8]_INST_0_i_3_n_0\
    );
\outA_V[8]_INST_0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"71"
    )
        port map (
      I0 => reg_77(7),
      I1 => inB_V_q0(7),
      I2 => tmp_reg_119(7),
      O => \outA_V[8]_INST_0_i_4_n_0\
    );
\outA_V[8]_INST_0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(11),
      I1 => inB_V_q0(11),
      I2 => tmp_reg_119(11),
      I3 => \outA_V[8]_INST_0_i_1_n_0\,
      O => \outA_V[8]_INST_0_i_5_n_0\
    );
\outA_V[8]_INST_0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(10),
      I1 => inB_V_q0(10),
      I2 => tmp_reg_119(10),
      I3 => \outA_V[8]_INST_0_i_2_n_0\,
      O => \outA_V[8]_INST_0_i_6_n_0\
    );
\outA_V[8]_INST_0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(9),
      I1 => inB_V_q0(9),
      I2 => tmp_reg_119(9),
      I3 => \outA_V[8]_INST_0_i_3_n_0\,
      O => \outA_V[8]_INST_0_i_7_n_0\
    );
\outA_V[8]_INST_0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => reg_77(8),
      I1 => inB_V_q0(8),
      I2 => tmp_reg_119(8),
      I3 => \outA_V[8]_INST_0_i_4_n_0\,
      O => \outA_V[8]_INST_0_i_8_n_0\
    );
\reg_77_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(0),
      Q => reg_77(0),
      R => '0'
    );
\reg_77_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(10),
      Q => reg_77(10),
      R => '0'
    );
\reg_77_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(11),
      Q => reg_77(11),
      R => '0'
    );
\reg_77_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(12),
      Q => reg_77(12),
      R => '0'
    );
\reg_77_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(13),
      Q => reg_77(13),
      R => '0'
    );
\reg_77_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(14),
      Q => reg_77(14),
      R => '0'
    );
\reg_77_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(15),
      Q => reg_77(15),
      R => '0'
    );
\reg_77_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(16),
      Q => reg_77(16),
      R => '0'
    );
\reg_77_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(17),
      Q => reg_77(17),
      R => '0'
    );
\reg_77_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(18),
      Q => reg_77(18),
      R => '0'
    );
\reg_77_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(19),
      Q => reg_77(19),
      R => '0'
    );
\reg_77_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(1),
      Q => reg_77(1),
      R => '0'
    );
\reg_77_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(20),
      Q => reg_77(20),
      R => '0'
    );
\reg_77_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(21),
      Q => reg_77(21),
      R => '0'
    );
\reg_77_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(22),
      Q => reg_77(22),
      R => '0'
    );
\reg_77_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(23),
      Q => reg_77(23),
      R => '0'
    );
\reg_77_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(24),
      Q => reg_77(24),
      R => '0'
    );
\reg_77_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(25),
      Q => reg_77(25),
      R => '0'
    );
\reg_77_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(26),
      Q => reg_77(26),
      R => '0'
    );
\reg_77_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(27),
      Q => reg_77(27),
      R => '0'
    );
\reg_77_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(28),
      Q => reg_77(28),
      R => '0'
    );
\reg_77_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(29),
      Q => reg_77(29),
      R => '0'
    );
\reg_77_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(2),
      Q => reg_77(2),
      R => '0'
    );
\reg_77_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(30),
      Q => reg_77(30),
      R => '0'
    );
\reg_77_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(31),
      Q => reg_77(31),
      R => '0'
    );
\reg_77_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(3),
      Q => reg_77(3),
      R => '0'
    );
\reg_77_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(4),
      Q => reg_77(4),
      R => '0'
    );
\reg_77_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(5),
      Q => reg_77(5),
      R => '0'
    );
\reg_77_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(6),
      Q => reg_77(6),
      R => '0'
    );
\reg_77_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(7),
      Q => reg_77(7),
      R => '0'
    );
\reg_77_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(8),
      Q => reg_77(8),
      R => '0'
    );
\reg_77_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_ce0\,
      D => inA_V_q0(9),
      Q => reg_77(9),
      R => '0'
    );
\tmp_reg_119[11]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(11),
      I1 => reg_77(11),
      O => \tmp_reg_119[11]_i_2_n_0\
    );
\tmp_reg_119[11]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(10),
      I1 => reg_77(10),
      O => \tmp_reg_119[11]_i_3_n_0\
    );
\tmp_reg_119[11]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(9),
      I1 => reg_77(9),
      O => \tmp_reg_119[11]_i_4_n_0\
    );
\tmp_reg_119[11]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(8),
      I1 => reg_77(8),
      O => \tmp_reg_119[11]_i_5_n_0\
    );
\tmp_reg_119[15]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(15),
      I1 => reg_77(15),
      O => \tmp_reg_119[15]_i_2_n_0\
    );
\tmp_reg_119[15]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(14),
      I1 => reg_77(14),
      O => \tmp_reg_119[15]_i_3_n_0\
    );
\tmp_reg_119[15]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(13),
      I1 => reg_77(13),
      O => \tmp_reg_119[15]_i_4_n_0\
    );
\tmp_reg_119[15]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(12),
      I1 => reg_77(12),
      O => \tmp_reg_119[15]_i_5_n_0\
    );
\tmp_reg_119[19]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(19),
      I1 => reg_77(19),
      O => \tmp_reg_119[19]_i_2_n_0\
    );
\tmp_reg_119[19]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(18),
      I1 => reg_77(18),
      O => \tmp_reg_119[19]_i_3_n_0\
    );
\tmp_reg_119[19]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(17),
      I1 => reg_77(17),
      O => \tmp_reg_119[19]_i_4_n_0\
    );
\tmp_reg_119[19]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(16),
      I1 => reg_77(16),
      O => \tmp_reg_119[19]_i_5_n_0\
    );
\tmp_reg_119[23]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(23),
      I1 => reg_77(23),
      O => \tmp_reg_119[23]_i_2_n_0\
    );
\tmp_reg_119[23]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(22),
      I1 => reg_77(22),
      O => \tmp_reg_119[23]_i_3_n_0\
    );
\tmp_reg_119[23]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(21),
      I1 => reg_77(21),
      O => \tmp_reg_119[23]_i_4_n_0\
    );
\tmp_reg_119[23]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(20),
      I1 => reg_77(20),
      O => \tmp_reg_119[23]_i_5_n_0\
    );
\tmp_reg_119[27]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(27),
      I1 => reg_77(27),
      O => \tmp_reg_119[27]_i_2_n_0\
    );
\tmp_reg_119[27]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(26),
      I1 => reg_77(26),
      O => \tmp_reg_119[27]_i_3_n_0\
    );
\tmp_reg_119[27]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(25),
      I1 => reg_77(25),
      O => \tmp_reg_119[27]_i_4_n_0\
    );
\tmp_reg_119[27]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(24),
      I1 => reg_77(24),
      O => \tmp_reg_119[27]_i_5_n_0\
    );
\tmp_reg_119[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(31),
      I1 => reg_77(31),
      O => \tmp_reg_119[31]_i_2_n_0\
    );
\tmp_reg_119[31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(30),
      I1 => reg_77(30),
      O => \tmp_reg_119[31]_i_3_n_0\
    );
\tmp_reg_119[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(29),
      I1 => reg_77(29),
      O => \tmp_reg_119[31]_i_4_n_0\
    );
\tmp_reg_119[31]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(28),
      I1 => reg_77(28),
      O => \tmp_reg_119[31]_i_5_n_0\
    );
\tmp_reg_119[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(3),
      I1 => reg_77(3),
      O => \tmp_reg_119[3]_i_2_n_0\
    );
\tmp_reg_119[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(2),
      I1 => reg_77(2),
      O => \tmp_reg_119[3]_i_3_n_0\
    );
\tmp_reg_119[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(1),
      I1 => reg_77(1),
      O => \tmp_reg_119[3]_i_4_n_0\
    );
\tmp_reg_119[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(0),
      I1 => reg_77(0),
      O => \tmp_reg_119[3]_i_5_n_0\
    );
\tmp_reg_119[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(7),
      I1 => reg_77(7),
      O => \tmp_reg_119[7]_i_2_n_0\
    );
\tmp_reg_119[7]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(6),
      I1 => reg_77(6),
      O => \tmp_reg_119[7]_i_3_n_0\
    );
\tmp_reg_119[7]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(5),
      I1 => reg_77(5),
      O => \tmp_reg_119[7]_i_4_n_0\
    );
\tmp_reg_119[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inB_V_q0(4),
      I1 => reg_77(4),
      O => \tmp_reg_119[7]_i_5_n_0\
    );
\tmp_reg_119_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(0),
      Q => tmp_reg_119(0),
      R => '0'
    );
\tmp_reg_119_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(10),
      Q => tmp_reg_119(10),
      R => '0'
    );
\tmp_reg_119_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(11),
      Q => tmp_reg_119(11),
      R => '0'
    );
\tmp_reg_119_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[7]_i_1_n_0\,
      CO(3) => \tmp_reg_119_reg[11]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[11]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[11]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(11 downto 8),
      O(3 downto 0) => tmp_fu_81_p2(11 downto 8),
      S(3) => \tmp_reg_119[11]_i_2_n_0\,
      S(2) => \tmp_reg_119[11]_i_3_n_0\,
      S(1) => \tmp_reg_119[11]_i_4_n_0\,
      S(0) => \tmp_reg_119[11]_i_5_n_0\
    );
\tmp_reg_119_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(12),
      Q => tmp_reg_119(12),
      R => '0'
    );
\tmp_reg_119_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(13),
      Q => tmp_reg_119(13),
      R => '0'
    );
\tmp_reg_119_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(14),
      Q => tmp_reg_119(14),
      R => '0'
    );
\tmp_reg_119_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(15),
      Q => tmp_reg_119(15),
      R => '0'
    );
\tmp_reg_119_reg[15]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[11]_i_1_n_0\,
      CO(3) => \tmp_reg_119_reg[15]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[15]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[15]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[15]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(15 downto 12),
      O(3 downto 0) => tmp_fu_81_p2(15 downto 12),
      S(3) => \tmp_reg_119[15]_i_2_n_0\,
      S(2) => \tmp_reg_119[15]_i_3_n_0\,
      S(1) => \tmp_reg_119[15]_i_4_n_0\,
      S(0) => \tmp_reg_119[15]_i_5_n_0\
    );
\tmp_reg_119_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(16),
      Q => tmp_reg_119(16),
      R => '0'
    );
\tmp_reg_119_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(17),
      Q => tmp_reg_119(17),
      R => '0'
    );
\tmp_reg_119_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(18),
      Q => tmp_reg_119(18),
      R => '0'
    );
\tmp_reg_119_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(19),
      Q => tmp_reg_119(19),
      R => '0'
    );
\tmp_reg_119_reg[19]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[15]_i_1_n_0\,
      CO(3) => \tmp_reg_119_reg[19]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[19]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[19]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[19]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(19 downto 16),
      O(3 downto 0) => tmp_fu_81_p2(19 downto 16),
      S(3) => \tmp_reg_119[19]_i_2_n_0\,
      S(2) => \tmp_reg_119[19]_i_3_n_0\,
      S(1) => \tmp_reg_119[19]_i_4_n_0\,
      S(0) => \tmp_reg_119[19]_i_5_n_0\
    );
\tmp_reg_119_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(1),
      Q => tmp_reg_119(1),
      R => '0'
    );
\tmp_reg_119_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(20),
      Q => tmp_reg_119(20),
      R => '0'
    );
\tmp_reg_119_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(21),
      Q => tmp_reg_119(21),
      R => '0'
    );
\tmp_reg_119_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(22),
      Q => tmp_reg_119(22),
      R => '0'
    );
\tmp_reg_119_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(23),
      Q => tmp_reg_119(23),
      R => '0'
    );
\tmp_reg_119_reg[23]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[19]_i_1_n_0\,
      CO(3) => \tmp_reg_119_reg[23]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[23]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[23]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[23]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(23 downto 20),
      O(3 downto 0) => tmp_fu_81_p2(23 downto 20),
      S(3) => \tmp_reg_119[23]_i_2_n_0\,
      S(2) => \tmp_reg_119[23]_i_3_n_0\,
      S(1) => \tmp_reg_119[23]_i_4_n_0\,
      S(0) => \tmp_reg_119[23]_i_5_n_0\
    );
\tmp_reg_119_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(24),
      Q => tmp_reg_119(24),
      R => '0'
    );
\tmp_reg_119_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(25),
      Q => tmp_reg_119(25),
      R => '0'
    );
\tmp_reg_119_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(26),
      Q => tmp_reg_119(26),
      R => '0'
    );
\tmp_reg_119_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(27),
      Q => tmp_reg_119(27),
      R => '0'
    );
\tmp_reg_119_reg[27]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[23]_i_1_n_0\,
      CO(3) => \tmp_reg_119_reg[27]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[27]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[27]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[27]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(27 downto 24),
      O(3 downto 0) => tmp_fu_81_p2(27 downto 24),
      S(3) => \tmp_reg_119[27]_i_2_n_0\,
      S(2) => \tmp_reg_119[27]_i_3_n_0\,
      S(1) => \tmp_reg_119[27]_i_4_n_0\,
      S(0) => \tmp_reg_119[27]_i_5_n_0\
    );
\tmp_reg_119_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(28),
      Q => tmp_reg_119(28),
      R => '0'
    );
\tmp_reg_119_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(29),
      Q => tmp_reg_119(29),
      R => '0'
    );
\tmp_reg_119_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(2),
      Q => tmp_reg_119(2),
      R => '0'
    );
\tmp_reg_119_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(30),
      Q => tmp_reg_119(30),
      R => '0'
    );
\tmp_reg_119_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(31),
      Q => tmp_reg_119(31),
      R => '0'
    );
\tmp_reg_119_reg[31]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[27]_i_1_n_0\,
      CO(3) => \NLW_tmp_reg_119_reg[31]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \tmp_reg_119_reg[31]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[31]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[31]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => inB_V_q0(30 downto 28),
      O(3 downto 0) => tmp_fu_81_p2(31 downto 28),
      S(3) => \tmp_reg_119[31]_i_2_n_0\,
      S(2) => \tmp_reg_119[31]_i_3_n_0\,
      S(1) => \tmp_reg_119[31]_i_4_n_0\,
      S(0) => \tmp_reg_119[31]_i_5_n_0\
    );
\tmp_reg_119_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(3),
      Q => tmp_reg_119(3),
      R => '0'
    );
\tmp_reg_119_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \tmp_reg_119_reg[3]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[3]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[3]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(3 downto 0),
      O(3 downto 0) => tmp_fu_81_p2(3 downto 0),
      S(3) => \tmp_reg_119[3]_i_2_n_0\,
      S(2) => \tmp_reg_119[3]_i_3_n_0\,
      S(1) => \tmp_reg_119[3]_i_4_n_0\,
      S(0) => \tmp_reg_119[3]_i_5_n_0\
    );
\tmp_reg_119_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(4),
      Q => tmp_reg_119(4),
      R => '0'
    );
\tmp_reg_119_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(5),
      Q => tmp_reg_119(5),
      R => '0'
    );
\tmp_reg_119_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(6),
      Q => tmp_reg_119(6),
      R => '0'
    );
\tmp_reg_119_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(7),
      Q => tmp_reg_119(7),
      R => '0'
    );
\tmp_reg_119_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \tmp_reg_119_reg[3]_i_1_n_0\,
      CO(3) => \tmp_reg_119_reg[7]_i_1_n_0\,
      CO(2) => \tmp_reg_119_reg[7]_i_1_n_1\,
      CO(1) => \tmp_reg_119_reg[7]_i_1_n_2\,
      CO(0) => \tmp_reg_119_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => inB_V_q0(7 downto 4),
      O(3 downto 0) => tmp_fu_81_p2(7 downto 4),
      S(3) => \tmp_reg_119[7]_i_2_n_0\,
      S(2) => \tmp_reg_119[7]_i_3_n_0\,
      S(1) => \tmp_reg_119[7]_i_4_n_0\,
      S(0) => \tmp_reg_119[7]_i_5_n_0\
    );
\tmp_reg_119_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(8),
      Q => tmp_reg_119(8),
      R => '0'
    );
\tmp_reg_119_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^inb_v_address0\(0),
      D => tmp_fu_81_p2(9),
      Q => tmp_reg_119(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity simple_algo_array_hw_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of simple_algo_array_hw_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of simple_algo_array_hw_0 : entity is "simple_algo_array_hw_0,simple_algo_array_hw,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of simple_algo_array_hw_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of simple_algo_array_hw_0 : entity is "simple_algo_array_hw,Vivado 2016.4";
end simple_algo_array_hw_0;

architecture STRUCTURE of simple_algo_array_hw_0 is
begin
U0: entity work.simple_algo_array_hw_0_simple_algo_array_hw
     port map (
      ap_clk => ap_clk,
      ap_done => ap_done,
      ap_idle => ap_idle,
      ap_ready => ap_ready,
      ap_rst => ap_rst,
      ap_start => ap_start,
      inA_V_address0(0) => inA_V_address0(0),
      inA_V_ce0 => inA_V_ce0,
      inA_V_q0(31 downto 0) => inA_V_q0(31 downto 0),
      inB_V_address0(0) => inB_V_address0(0),
      inB_V_ce0 => inB_V_ce0,
      inB_V_q0(31 downto 0) => inB_V_q0(31 downto 0),
      outA_V(31 downto 0) => outA_V(31 downto 0),
      outA_V_ap_vld => outA_V_ap_vld
    );
end STRUCTURE;
