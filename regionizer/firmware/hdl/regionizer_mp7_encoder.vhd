library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_encoder is
    generic(
        N_OBJ : natural
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        particles_in    : in particles(N_OBJ-1 downto 0);    -- particles for the regionizer
        particles_valid : in std_logic;                      -- valid bit from the regionizer
        mp7_out   : out words32(2*N_OBJ-1 downto 0);         -- output particles as words
        mp7_outv  : out std_logic_vector(2*N_OBJ-1 downto 0) -- true if words contain valid data
    );
end regionizer_mp7_encoder;

architecture Behavioral of regionizer_mp7_encoder is
begin
    process_output: process(clk,rst)
    begin
        if rst = '1' then
            mp7_outv <= (others => '0');
        elsif rising_edge(clk) then
            for i in N_OBJ-1 downto 0 loop
                mp7_out(2*i+0) <= to_32b_lo(particles_in(i));
                mp7_out(2*i+1) <= to_32b_hi(particles_in(i));
                mp7_outv(2*i+0) <= particles_valid;
                mp7_outv(2*i+1) <= particles_valid;
            end loop;
        end if;
    end process;
end Behavioral;
        


