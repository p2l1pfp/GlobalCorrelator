library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity delay_line is
    generic(
        N_BITS : natural;
        DELAY  : natural
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        d : in  std_logic_vector(N_BITS-1 downto 0);
        q : out std_logic_vector(N_BITS-1 downto 0)
    );
end delay_line;

architecture Behavioral of delay_line is
    type  delay_line is array(DELAY-1 downto 0) of std_logic_vector(N_BITS-1 downto 0);
    signal data : delay_line;
begin
    tick: process(clk,rst)
    begin
        if rst = '1' then
            data <= (others => (others => '0'));
        elsif rising_edge(clk) then
            data(0) <= d;
            if DELAY > 1 then
                for i in DELAY-1 downto 1 loop
                    data(i) <= data(i-1);
                end loop;
            end if;
        end if;
    end process;

    q <= data(DELAY-1);
end Behavioral;
        


