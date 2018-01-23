library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_encoder_twoframes is
    generic(
        N_OBJ : natural
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        particles_in    : in particles(N_OBJ-1 downto 0);  -- particles for the regionizer
        particles_valid : in std_logic;                    -- valid bit from the regionizer
        mp7_out   : out words32(N_OBJ-1 downto 0);         -- output particles as words
        mp7_outv  : out std_logic_vector(N_OBJ-1 downto 0);-- true if words contain valid data
        mp7_first : out std_logic                          -- 1 for first word, 0 for second word
    );
end regionizer_mp7_encoder_twoframes;

architecture Behavioral of regionizer_mp7_encoder_twoframes is
    signal first : std_logic;
    signal buff  : words32(N_OBJ-1 downto 0);
    signal buffv : std_logic_vector(N_OBJ-1 downto 0);
    signal obuff : words32(N_OBJ-1 downto 0);
    signal obuffv: std_logic_vector(N_OBJ-1 downto 0);
begin
    process_output: process(clk,rst)
    begin
        if rst = '1' then
            first <= '0';
            obuffv <= (others => '0');
        elsif rising_edge(clk) then
            if first = '1' then
                obuff <= buff;
                obuffv <= buffv;
                first <= '0';
            elsif particles_valid = '1' then
                for i in N_OBJ-1 downto 0 loop
                    obuff(i)  <= to_32b_lo(particles_in(i));
                    buff(i)   <= to_32b_hi(particles_in(i));
                    obuffv(i) <= particles_valid;
                    buffv(i)  <= particles_valid;
                end loop;
                first <= '1';
            else
                first <= '0';
                obuffv <= (others => '0');
            end if;
        end if;
    end process;

    mp7_out <= obuff;
    mp7_outv <= obuffv;
    mp7_first <= first;
end Behavioral;
        


