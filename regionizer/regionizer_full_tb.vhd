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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal links_in  : particles(N_SECTORS-1 downto 0);
    signal read_in : std_logic;
    signal counter : natural range N_CLOCK-1 downto 0;
    signal objs_out : particles(N_OBJ-1 downto 0);
    signal debug_out : particles(N_OBJ_SECTOR_ETA-1 downto 0); 
    signal valid_out : std_logic;
    signal counter_out : natural range N_REGIONS-1 downto 0;
    signal frame : natural;
    signal event : natural;
    file FI : text open read_mode is "test-regionizer-in.txt";
    file FO : text open write_mode is "test-regionizer-out.txt";
    file FL : text open write_mode is "test-regionizer-log.txt";
begin
    clk  <= not clk after 2.5 ns;
    
    uut : entity work.regionizer_full
        port map(clk => clk, rst => rst, counter_in => counter, read_in => read_in, data_in => links_in, data_out => objs_out, valid_out => valid_out, counter_out => counter_out); -- debug_out => debug_out, 

   
    pippo : process 
        variable L : line;
        variable in_data : particles(N_SECTORS-1 downto 0);
        variable in_counter : natural;
        variable in_event : natural;
        variable out_data : particles(N_OBJ-1 downto 0);
        variable out_counter : natural;
        variable out_valid : std_logic;
        variable remainingEvents : integer := 40;
    begin
        rst <= '1';
        wait for 15 ns;
        rst <= '0';
        frame <= 0;
        counter <= N_CLOCK-1;
        event <= 0;
        links_in <= (others => null_particle);
        write(L, string'("Starting the loop")); 
        writeline(FL, L);
        read_in <= '0';
        wait until rising_edge(clk);
        while remainingEvents > 0 loop
            if not endfile(FI) then
                if read_in = '0' then
                    read_frame(FI, in_event, in_counter, in_data);
                    read_in <= '1';
                else
                    read_frame(FI, in_event, in_counter, in_data); --// to advance in the file (it has empty frames every other clock cycle)
                    read_in <= '0';
                end if;
            else
                in_event   := 99; 
                in_counter := 0; 
                in_data := (others => null_particle);
                remainingEvents := remainingEvents-1;
            end if;
            -- prepare stuff
            frame <= frame + 1;
            event <= in_event;
            counter <= in_counter;
            links_in <= in_data;
            -- ready to dispatch ---
            wait until rising_edge(clk);           
            -- print what was dispatched / received ---
            --write(L, string'("Frame ")); write(L, frame, field => 3); 
            write(L, string'("E ")); write(L, event, field => 2); 
            write(L, string'(" C ")); write(L, counter, field => 2); 
            if read_in = '1' then
                write(L, string'("  | IN"));
                for o in 0 to N_SECTORS-1 loop
                    write(L, to_integer(links_in(o).pt),  field => 6); --write(L, to_integer(links_in(o).phi), field => 5);
                end loop;
            else
                write(L, string'("  |                                                                           "));
            end if;
            --write(L, string'(" | DBG ")); 
            --for o in 0 to N_OBJ_SECTOR_ETA-1 loop
            --    write(L, to_integer(debug_out(o).pt),  field => 6);  
            --end loop;
            write(L, string'(" | OV ")); write(L, valid_out); write(L, string'(" C ")); write(L, counter_out, field => 2);
            write(L, string'(" | OUT ")); 
            for o in 0 to N_OBJ-1 loop
                write(L, to_integer(objs_out(o).pt),  field => 6); --write(L, to_integer(objs_out(o).phi), field => 5); 
            end loop;
            writeline(FL, L);

            out_counter := frame; out_data := objs_out; out_valid := valid_out;
            write_frame(FO, out_counter, out_data, out_valid);
        end loop;
        write(L, string'("Waiting for completion")); 
        writeline(FL, L);
        wait for 50 ns;
        write(L, string'("Done")); 
        writeline(FL, L);
        finish(0);
    end process;

    
end Behavioral;
