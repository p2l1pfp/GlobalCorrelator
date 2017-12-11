library std;
use std.textio.all;
use std.env.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;
use work.pftm_mp7_textio.all;
use work.bhv_data_types.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    constant N_IN : natural := BHV_NSECTORS;
    constant N_OUT : natural := 3 + 2*BHV_NSECTORS;
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal valid_in : std_logic_vector(N_IN-1 downto 0);
    signal links_in : words32(N_IN-1 downto 0);
    signal links_out : words32(N_OUT-1 downto 0);
    signal valid_out : std_logic_vector(N_OUT-1 downto 0);
    file FI : text open read_mode is "data/mp7_input.txt";
    file FO : text open write_mode is "mp7_output_hdltb.txt";
begin
    clk  <= not clk after 2.0833333 ns;
    
    uut : entity work.bhv_mp7
        port map(clk => clk, rst => rst, mp7_in => links_in, mp7_out => links_out, mp7_valid => valid_in, mp7_outv => valid_out);
   
    pippo : process 
        variable in_data : words32(N_IN-1 downto 0);
        variable in_valid : std_logic_vector(N_IN-1 downto 0);
        variable out_data : words32(N_OUT-1 downto 0);
        variable out_valid : std_logic_vector(N_OUT-1 downto 0);
        variable remainingEvents : integer := 10;
        variable frame : integer := 0;
        variable L : line;
    begin
        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        links_in <= (others => (others => '0'));
        wait until rising_edge(clk);
        while remainingEvents > 0 loop
            if not endfile(FI) then
                read_mp7_frame(FI, in_data, in_valid);
             else
                in_valid := (others => '0'); 
                in_data := (others => (others => '0'));
                remainingEvents := remainingEvents - 1;
            end if;
            -- prepare stuff
            valid_in <= in_valid;
            links_in <= in_data;
            -- ready to dispatch ---
            wait until rising_edge(clk);
            frame := frame + 1;
            out_data(N_OUT-1 downto 0) := links_out; out_valid := valid_out;
            write_mp7_frame(FO, frame, out_data, out_valid);
        end loop;
        wait for 50 ns;
        finish(0);
    end process;
end Behavioral;
