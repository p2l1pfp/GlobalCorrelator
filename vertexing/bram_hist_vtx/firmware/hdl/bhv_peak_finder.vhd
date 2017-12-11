library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bhv_data_types.all;

entity bhv_peak_finder is
    port(
        clk : in std_logic;
        in_bin : in zbin_t;
        in_h : in ptsum_wide_t;
        in_l : in ptsum_wide_t;
        new_event : in std_logic;
        out_done : out std_logic;
        out_bin : out zbin_t;
        out_sum : out ptsum_wide_t
    );
end bhv_peak_finder;

architecture Behavioral of bhv_peak_finder is
    signal curr_max, out_max   : ptsum_wide_t := (others => '0');
    signal curr_bmax, out_bmax : zbin_t := (others => '0');
    signal out_done_i          : std_logic := '0';
begin
    process(clk)
        variable max : ptsum_wide_t;
        variable bmax : zbin_t;
    begin
        if rising_edge(clk) then
            report "Peak finder sees bin " & integer'image(to_integer(in_bin)) & 
                        ", in_l = " & integer'image(to_integer(in_l)) & ", in_h = " & integer'image(to_integer(in_h)) & 
                        ", curr_max " & integer'image(to_integer(curr_max)) & " @ " & integer'image(to_integer(curr_bmax));
            if new_event = '1' then
                report "New event, zeroing max and bmax. curr max was " & integer'image(to_integer(curr_max)) & " @ " & integer'image(to_integer(curr_bmax));
                max  := (others => '0');
                bmax := to_zbin(0);
            else
                max  := curr_max;
                bmax := curr_bmax;
            end if;

            if in_l >= in_h then
                if in_l >= max then
                    max  := in_l;
                    bmax := in_bin;
                end if;
            else
                if in_h >= max then
                    max  := in_h;
                    bmax := in_bin + to_zbin(1);
                end if;
            end if;
            
            curr_max <= max;
            curr_bmax <= bmax;
        
            if new_event = '1' then
                out_max  <= curr_max;
                out_bmax <= curr_bmax;
                out_done_i <= '1';
            else
                out_max  <= (others => '0');
                out_bmax <= (others => '0');
                out_done_i <= '0';
            end if;
        end if;
    end process;

    out_sum  <= out_max;
    out_bin  <= out_bmax;
    out_done <= out_done_i; 
end Behavioral;


