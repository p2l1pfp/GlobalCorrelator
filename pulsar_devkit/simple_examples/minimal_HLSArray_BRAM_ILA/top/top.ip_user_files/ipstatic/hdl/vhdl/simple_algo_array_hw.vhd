-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2016.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity simple_algo_array_hw is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    inA_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    inA_V_ce0 : OUT STD_LOGIC;
    inA_V_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    inB_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    inB_V_ce0 : OUT STD_LOGIC;
    inB_V_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    outA_V : OUT STD_LOGIC_VECTOR (31 downto 0);
    outA_V_ap_vld : OUT STD_LOGIC );
end;


architecture behav of simple_algo_array_hw is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "simple_algo_array_hw,hls_ip_2016_4,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7vx690tffg1927-2,HLS_INPUT_CLOCK=5.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=4.020000,HLS_SYN_LAT=3,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=68,HLS_SYN_LUT=67}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv64_1 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal reg_77 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal ap_CS_fsm_state3 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal tmp_fu_81_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_reg_119 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal tmp_1_fu_87_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((((ap_const_lv1_1 = ap_CS_fsm_state2)) or ((ap_const_lv1_1 = ap_CS_fsm_state3)))) then
                reg_77 <= inA_V_q0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_state3))) then
                tmp_reg_119 <= tmp_fu_81_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (not((ap_start = ap_const_logic_0))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0 downto 0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1 downto 1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2 downto 2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3 downto 3);

    ap_done_assign_proc : process(ap_CS_fsm_state4)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state4))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_0 = ap_start) and (ap_CS_fsm_state1 = ap_const_lv1_1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state4)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state4))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    inA_V_address0_assign_proc : process(ap_CS_fsm_state1, ap_CS_fsm_state2)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state2))) then 
            inA_V_address0 <= ap_const_lv64_1(1 - 1 downto 0);
        elsif (((ap_CS_fsm_state1 = ap_const_lv1_1))) then 
            inA_V_address0 <= ap_const_lv64_0(1 - 1 downto 0);
        else 
            inA_V_address0 <= "X";
        end if; 
    end process;


    inA_V_ce0_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state2)
    begin
        if ((((ap_const_lv1_1 = ap_CS_fsm_state2)) or ((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0))))) then 
            inA_V_ce0 <= ap_const_logic_1;
        else 
            inA_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    inB_V_address0_assign_proc : process(ap_CS_fsm_state2, ap_CS_fsm_state3)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state3))) then 
            inB_V_address0 <= ap_const_lv64_1(1 - 1 downto 0);
        elsif (((ap_const_lv1_1 = ap_CS_fsm_state2))) then 
            inB_V_address0 <= ap_const_lv64_0(1 - 1 downto 0);
        else 
            inB_V_address0 <= "X";
        end if; 
    end process;


    inB_V_ce0_assign_proc : process(ap_CS_fsm_state2, ap_CS_fsm_state3)
    begin
        if ((((ap_const_lv1_1 = ap_CS_fsm_state2)) or ((ap_const_lv1_1 = ap_CS_fsm_state3)))) then 
            inB_V_ce0 <= ap_const_logic_1;
        else 
            inB_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    outA_V <= std_logic_vector(unsigned(tmp_1_fu_87_p2) - unsigned(inB_V_q0));

    outA_V_ap_vld_assign_proc : process(ap_CS_fsm_state4)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state4))) then 
            outA_V_ap_vld <= ap_const_logic_1;
        else 
            outA_V_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    tmp_1_fu_87_p2 <= std_logic_vector(unsigned(tmp_reg_119) - unsigned(reg_77));
    tmp_fu_81_p2 <= std_logic_vector(unsigned(inB_V_q0) + unsigned(reg_77));
end behav;
