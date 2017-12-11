library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bhv_data_types.all;

entity histo_double_add is
    port(
        clk : in std_logic;
        go  : in std_logic; -- toggles between 1 and 0
        bin : in zbin_t;
        val : in ptsum_t;
        hist_bin : out zbin_t;
        hist_in : in ptsum_t;
        hist_out : out ptsum_t;
        hist_we  : out std_logic
    );
end histo_double_add;

architecture Behavioral of histo_double_add is
    signal ivals : ptsum_arr_t(1 downto 0) := (others => (others => '0'));
    signal iwe   : std_logic_vector(1 downto 0) := (others => '0');
    signal bins  : zbin_arr_t(1 downto 0)  := (others => (others => '0'));
    signal read_track, second_track : std_logic := '0';
    -- second_track = 1 if this is the second track in the double-adder, zero otherwise
    -- read_track = 1 the clock cycle after having read one track (which happens when go=1) 
    -- example flow:
    --       input   | mem out     | mem in    | state in | state out |
    --      ----------------------------------------------------------
    --       track 1 |             |           | s=0 r=0  | s=0 r=1   |
    --       wait    | read bin 1  |           | s=0 r=1  | s=1 r=0   |
    --       track 2 | read bin 2  |           | s=1 r=0  | s=1 r=1   |
    --       wait    | write bin 1 | bin 1 val | s=1 r=1  | s=0 r=0   |
    --       track 3 | write bin 2 | bin 2 val | s=0 r=0  | s=0 r=1   |
    --       wait    | read bin 3  |   ---     | s=0 r=1  | s=1 r=0   |
    --       track 4 | read bin 4  |   ---     |   1   0  |   1   1   |
    --       wait    | write bin 3 | bin 3 val |   1   1  |   0   0   |
    --       track 5 | write bin 4 | bin 4 val |   0   0  |   0   1   |
    --       wait    | read bin 5  |   ---     |   0   1  |   1   0   |
    --       track 6 | read bin 6  |   ---     |   1   0  |   1   1   |
    --       wait    | write bin 5 | bin 5 val |   1   1  |   0   0   |
    -- note: we still miss the continuation when we stop to get inputs but we still have
    --       valid values in the pipeline.
begin

    process(clk)
    begin
        if rising_edge(clk) then
            --report "go = " & std_logic'image(go) & " bin = " & integer'image(to_integer(bin)) & " val =  " & integer'image(to_integer(val)) & 
            --       " state = " & std_logic'image(second_track) & std_logic'image(read_track) & 
            --       " mem in = " & integer'image(to_integer(hist_in)) ;
            if read_track = '1' then
                assert go = '0' report "Pushing in a full pipeline" severity warning;
                second_track <= not second_track;
                read_track <= '0';
                if second_track = '0' then
                    -- req read bin 1
                    hist_bin <= bins(0);
                    hist_we  <= '0'; 
                    hist_out <= (others => '0');
                    -- hist_in is the write of the track 2, not interesting
                else
                    -- receive and write out first bin
                    hist_bin <= bins(0);
                    hist_we  <= iwe(0); 
                    hist_out <= trunc_add(ivals(0), hist_in);
                end if;    
            elsif go = '1' then
                read_track <= '1';
                if second_track = '0' then
                    -- cache in values
                    bins(0)  <= bin;
                    ivals(0) <= val;
                    if val /= to_ptsum(0) then
                        iwe(0) <= '1';
                    else
                        iwe(0) <= '0';
                    end if;
                    -- receive and write out the second bin
                    hist_bin <= bins(1);
                    hist_we  <= iwe(1); 
                    hist_out <= trunc_add(ivals(1), hist_in);
                else
                    -- we cache in the values
                    bins(1)  <= bin;
                    ivals(1) <= val;
                    if val /= to_ptsum(0) then
                        iwe(1) <= '1';
                    else
                        iwe(1) <= '0';
                    end if;
                    -- req read bin 2                    
                    hist_bin <= bin;
                    hist_we  <= '0'; 
                    hist_out <= (others => '0');
                end if;                
            end if;
        end if;
    end process;
end Behavioral;
