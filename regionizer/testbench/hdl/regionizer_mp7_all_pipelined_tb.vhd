library std;
use std.textio.all;
use std.env.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;
use work.pftm_textio.all;
use work.pftm_mp7_textio.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    constant N_FIBERS_OBJ : natural := 1;
    constant N_ALL_FIBERS_SECTOR : natural := 4; -- 2 for tracker, 1 for ecal, 1 for calo (muons are separate)
    constant N_ALL_FIBERS_IN : natural := N_ALL_FIBERS_SECTOR*N_SECTORS + MU_SECTORS;
    constant N_OUT : natural := N_FIBERS_OBJ*(N_CALO+N_EMCALO+N_TRACK+N_MU);
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal valid_in : std_logic_vector(N_ALL_FIBERS_IN-1 downto 0);
    signal links_in : words32(N_ALL_FIBERS_IN-1 downto 0);
    signal links_out : words32(N_OUT-1 downto 0);
    signal valid_out : std_logic_vector(N_OUT-1 downto 0);
    file FI : text open read_mode is "data/mp7_input.txt";
    file FO : text open write_mode is "mp7_output_hdltb.txt";
    file FL : text open write_mode is "test-regionizer-log.txt";
    file FLP: text open write_mode is "test-regionizer-log-p.txt";
begin
    clk  <= not clk after 2.0833333 ns;
    
    calo : entity work.regionizer_mp7_others
        generic map(N_OBJ_SECTOR => N_CALO_SECTOR, N_OBJ_SECTOR_ETA => N_CALO_SECTOR_ETA, N_OBJ => N_CALO, N_FIBERS_SECTOR => 1, N_FIBERS_OBJ => 1, 
                   SECTOR_VALID_BIT_DELAY => 1 )
        port map(clk => clk, rst => rst, 
                 mp7_valid => valid_in(1*N_SECTORS-1 downto 0*N_SECTORS), 
                 mp7_in    => links_in(1*N_SECTORS-1 downto 0*N_SECTORS), 
                 mp7_out  => links_out(N_CALO-1 downto 0), 
                 mp7_outv => valid_out(N_CALO-1 downto 0));
   emcalo : entity work.regionizer_mp7_others
       generic map(N_OBJ_SECTOR => N_EMCALO_SECTOR, N_OBJ_SECTOR_ETA => N_EMCALO_SECTOR_ETA, N_OBJ => N_EMCALO, N_FIBERS_SECTOR => 1, N_FIBERS_OBJ => 1, 
                   SECTOR_VALID_BIT_DELAY => 7)
       port map(clk => clk, rst => rst, 
                mp7_valid => valid_in(2*N_SECTORS-1 downto 1*N_SECTORS), 
                mp7_in    => links_in(2*N_SECTORS-1 downto 1*N_SECTORS), 
                mp7_out  => links_out(N_CALO+N_EMCALO-1 downto N_CALO), 
                mp7_outv => valid_out(N_CALO+N_EMCALO-1 downto N_CALO));
   track : entity work.regionizer_mp7_others
       generic map(N_OBJ_SECTOR => N_TRACK_SECTOR, N_OBJ_SECTOR_ETA => N_TRACK_SECTOR_ETA, N_OBJ => N_TRACK, N_FIBERS_SECTOR => 2, N_FIBERS_OBJ => 1, 
                   SECTOR_VALID_BIT_DELAY => 7)
       port map(clk => clk, rst => rst, 
                mp7_valid => valid_in(4*N_SECTORS-1 downto 2*N_SECTORS),  
                mp7_in    => links_in(4*N_SECTORS-1 downto 2*N_SECTORS), 
                mp7_out  => links_out(N_CALO+N_EMCALO+N_TRACK-1 downto N_CALO+N_EMCALO), 
                mp7_outv => valid_out(N_CALO+N_EMCALO+N_TRACK-1 downto N_CALO+N_EMCALO));
    muon: entity work.regionizer_mp7_muons
        generic map(N_OBJ_SECTOR => N_MU, N_OBJ_SECTOR_ETA => N_MU, N_OBJ => N_MU, 
                    N_FIBERS_OBJ => N_FIBERS_OBJ, MP7_INPUT_DELAY => 35 )
        port map(clk => clk, rst => rst, 
                 mp7_valid => valid_in(N_ALL_FIBERS_IN-1 downto 4*N_SECTORS), 
                 mp7_in    => links_in(N_ALL_FIBERS_IN-1 downto 4*N_SECTORS), 
                 mp7_out  => links_out(N_CALO+N_EMCALO+N_TRACK+N_MU-1 downto N_CALO+N_EMCALO+N_TRACK), 
                 mp7_outv => valid_out(N_CALO+N_EMCALO+N_TRACK+N_MU-1 downto N_CALO+N_EMCALO+N_TRACK));
 
    pippo : process 
        variable in_data : words32(N_ALL_FIBERS_IN-1 downto 0);
        variable in_valid : std_logic_vector(N_ALL_FIBERS_IN-1 downto 0);
        variable out_data : words32(N_OUT-1 downto 0);
        variable out_valid : std_logic_vector(N_OUT-1 downto 0);
        variable remainingEvents : integer := 50;
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
            write(L, frame, field=>4);  
            write(L, string'("  | IN  ")); 
            for i in 0 to N_ALL_FIBERS_SECTOR*N_SECTORS-1 loop --N_OBJ-1 loop
                write(L, valid_in(i)); write(L, string'("v")); hwrite(L, links_in(i)); write(L, string'("  "));
            end loop;
            write(L, string'("| OUT  ")); 
            for i in 0 to N_OUT-1 loop --N_OBJ-1 loop
                write(L, valid_out(i)); write(L, string'("v")); hwrite(L, links_out(i)); write(L, string'("  "));
            end loop;
            --write(L, string'("..."));
            writeline(FL, L);
                    
            write(L, frame, field=>3);  
            --write(L, string'(" | ")); write(L, spy_valid); write(L, string'(" | ")); 
            --for i in 0 to spy_out'length-1 loop 
            --   write(L, to_integer(spy_out(i).pt), field => 5); 
            --   --write(L, to_integer(spy_out(i).phi), field => 5); 
            --end loop;
            --write(L, string'(" | ")); write(L, debug_valid); write(L, string'(" | ")); 
            --for i in 0 to debug_out'length-1 loop 
            --   write(L, to_integer(debug_out(i).pt), field => 5); 
            ----   write(L, to_integer(debug_out(i).phi), field => 5); 
            --end loop;
            writeline(FLP, L);

            out_data(N_OUT-1 downto 0) := links_out; 
            out_valid(N_OUT-1 downto 0) := valid_out;
            write_mp7_frame(FO, frame, out_data, out_valid);
        end loop;
        wait for 50 ns;
        finish(0);
    end process;

    
end Behavioral;
