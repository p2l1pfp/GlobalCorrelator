library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bhv_data_types.all;

entity bhv_add_reducer is
    generic(
        FACTOR : natural;
        LINES : natural := 1
    );
    port(
        clk : in std_logic;
        in_b : in zbin_arr_t(FACTOR*LINES-1 downto 0);
        in_h : in ptsum_wide_arr_t(FACTOR*LINES-1 downto 0);
        in_l : in ptsum_wide_arr_t(FACTOR*LINES-1 downto 0);
        out_b : out zbin_arr_t(LINES-1 downto 0);
        out_h : out ptsum_wide_arr_t(LINES-1 downto 0);
        out_l : out ptsum_wide_arr_t(LINES-1 downto 0)
    );
end bhv_add_reducer;

architecture Behavioral of bhv_add_reducer is
begin
    process(clk)
        variable bin : zbin_t;
        variable sum_l, sum_h : ptsum_wide_t;
    begin
        if rising_edge(clk) then
            for L in 0 to LINES-1 loop
                bin := in_b(L*FACTOR);
                sum_l := in_l(L*FACTOR);
                sum_h := in_h(L*FACTOR);
                for I in 1 to FACTOR-1 loop
                    --assert bin = in_b(L*FACTOR+I) report "Misaligned bins " & 
                    --        integer'image(L*FACTOR) & " = " & integer'image(to_integer(in_b(L*FACTOR))) & " vs " & 
                    --        integer'image(L*FACTOR+I) & " = " & integer'image(to_integer(in_b(L*FACTOR+I)))  
                    --        severity warning;
                    sum_l := sum_l + in_l(L*FACTOR+I);
                    sum_h := sum_h + in_h(L*FACTOR+I);
                end loop;
                out_b(L) <= bin;
                out_l(L) <= sum_l;
                out_h(L) <= sum_h;
            end loop;
        end if;
    end process;
end Behavioral;


