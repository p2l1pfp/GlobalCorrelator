library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity egg_timer is
    generic(
        N_COUNT : natural
    );
    port(
        clk   : in  std_logic;
        start : in  std_logic; -- set to 1 when the timer is to start (together with go)
        go    : in  std_logic; -- set to 1 to have this tick
        done  : out std_logic  -- will become 1 after N_COUNT clocks in which go = 1
    );
end egg_timer;

architecture Behavioral of egg_timer is
    signal bits: std_logic_vector(N_COUNT-1 downto 0) := (others => '0');
begin
    timer: process(clk)
    begin
        if rising_edge(clk) and go = '1' then
            bits(0) <= start;
            bits(N_COUNT-1 downto 1) <= bits(N_COUNT-2 downto 0);
        end if;
    end process;

    done <= bits(N_COUNT-1);
end Behavioral;
