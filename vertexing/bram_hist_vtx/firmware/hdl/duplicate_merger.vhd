library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bhv_data_types.all;

entity duplicate_merger is
    port(
        clk : in std_logic;
        in_go  : in std_logic;
        in_bin : in zbin_t;
        in_val : in ptsum_t;
        out_bin : out zbin_t;
        out_val : out ptsum_t;
        out_go  : out std_logic
    );
end duplicate_merger;

architecture Behavioral of duplicate_merger is
    signal last_go,  this_go,  next_go  : std_logic := '0'; -- toggles between 1 and 0
    signal last_bin, this_bin, next_bin : zbin_t  := to_zbin(0);
    signal last_val, this_val, next_val : ptsum_t := to_ptsum(0);
    signal this_wait : std_logic := '0';
begin
    reg_in : process(clk)
    begin
        if rising_edge(clk) then
            last_go  <= in_go;
            last_bin <= in_bin;
            last_val <= in_val;
        end if;
    end process reg_in;


    shifter: process(clk)
    begin
        if rising_edge(clk) then
            -- there's 4 possible states depending on:
            -- this_wait = '1': the data in the pipeline is new, must wait for one clock
            --             '0': the data in the pipeline has aged enough, can go out
            -- last_go   = '1': new data coming
            --             '0': new data not coming
            -- however, this_wait  = 1 & last_go = 1 is an error (means two valid data in consecutive clocks)
            if this_wait = '1' then
                assert last_go = '0' report "Pushing into a full pipeline" severity failure;
                this_wait <= '0';
                next_go   <= '0';
                this_go   <= this_go;
                next_val <= next_val;
                next_bin <= next_bin;
                this_val <= this_val;
                this_bin <= this_bin;
                --report "I wait";
            elsif last_go = '1' then
                if (last_bin = this_bin) and (this_val /= to_ptsum(0)) then
                    --report "I add " & integer'image(to_integer(last_val)) & " to " & integer'image(to_integer(this_val)) & " in bin " & integer'image(to_integer(this_bin)) & " and push it out";
                    next_val <= trunc_add(this_val, last_val);
                    next_bin <= this_bin;
                    this_val <= to_ptsum(0); 
                    this_bin <= last_bin;
                else
                    --report "I read " & integer'image(to_integer(last_val)) & " in bin " & integer'image(to_integer(last_bin)) & " and push " & integer'image(to_integer(this_val)) & " in bin " & integer'image(to_integer(this_bin));
                    next_val <= this_val;
                    next_bin <= this_bin;
                    this_val <= last_val;
                    this_bin <= last_bin;
                end if;
                this_wait <= '1';
                this_go   <= '1';
                next_go   <= this_go; -- may be '0' if I had nothing valid in the pipeline
            elsif this_go = '1' then -- flush out last good values
                --report "Flushing out old values (shouldn't happen except at the end)";
                next_val <= this_val;
                next_bin <= this_bin;
                this_val <= to_ptsum(0); 
                this_bin <= to_zbin(0);
                this_wait <= '0';
                this_go  <= '0';
                next_go  <= '1';
            else -- nothing good
                --report "Nothing to do (shouldn't happen except at the beginning)";
                next_val <= to_ptsum(0);
                next_bin <= to_zbin(0);
                this_val <= to_ptsum(0); 
                this_bin <= to_zbin(0);
                this_wait <= '0';
                this_go  <= '0';
                next_go  <= '0';
            end if;
        end if;
    end process;

    out_go <= next_go;
    out_bin <= next_bin;
    out_val <= next_val;
end Behavioral;
