library ieee;
use ieee.std_logic_1164.all;

use work.pftm_data_types.all;
use work.bhv_data_types.all;

entity bhv_track_to_bin is
    port(
        clk : in std_logic;
        go : in std_logic;
        track : in particle; 
        bin   : out zbin_t;
        val   : out ptsum_t;
        done  : out std_logic
    );
end bhv_track_to_bin;

architecture Behavioral of bhv_track_to_bin is
    signal in_z0 : z0_t := (others => '0');
    signal in_pt : pt_t := (others => '0');
    signal in_good, out_good : std_logic := '0';
    signal out_bin : zbin_vt := (valid => '0', bin => (others => '0'));
    signal out_val : ptsum_t := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if go = '1' then
                in_good <= '1';
                in_z0 <= z0(track);
                in_pt <= track.pt;
            else
                in_good <= '0';
            end if;

            if in_good = '1' then
                out_good <= '1';
                out_bin  <= find_zbin(in_z0);
                out_val  <= to_ptsum(in_pt);
            else
                out_good <= '0';
            end if;
        end if;
    end process;

    done <= out_good;
    bin  <= out_bin.bin;
    val  <= out_val when out_bin.valid = '1' else (others => '0');
end Behavioral;
