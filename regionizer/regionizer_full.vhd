library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_full is
    port(
        clk : in std_logic;
        rst : in std_logic;
        counter_in : natural range 0 to N_IN_CLOCK-1;    -- index of the particle provided on data_in for each sector
        read_in    : in std_logic;                       -- 1 if data should be read from counter_in (divides input clock frequency by 2)
        data_in   : in  particles(N_SECTORS-1 downto 0); -- input particles: one per sector region per (clock that has read_in = 1)
        data_out  : out region;                          -- output particles (pt-sorted list of particle in one region)
        --debug_out : out particles(N_OBJ_SECTOR_ETA-1 downto 0); 
        counter_out : out natural range 0 to N_CLOCK-1;  -- number of the region in counter_out
        valid_out : out std_logic                        -- true if data_out and counter_out contain valid data
    );
end regionizer_full;


architecture Behavioral of regionizer_full is
    signal region_data : regions(N_REGIONS-1 downto 0);
    signal merge_valid: std_logic_vector(N_REGIONS-1 downto 0);
    signal was_valid : std_logic;
    signal mux_counter: natural range 0 to N_PHI-1;
begin
    -- could become a single generate loop once I learn how to read constants
    eta0: entity work.regionizer_eta
            generic map( etaMin => to_etaphi(-342), etaMax => to_etaphi(-57), etaShift => to_etaphi(171) )
            port map( clk => clk, rst => rst, counter_in => counter_in, read_in => read_in, data_in => data_in, 
                      data_out(N_PHI-1 downto 0) => region_data(N_PHI-1 downto 0), valid_out => merge_valid(N_PHI-1 downto 0));
    eta1: entity work.regionizer_eta
            generic map( etaMin => to_etaphi(-171), etaMax => to_etaphi(+171), etaShift => to_etaphi(0) )
            port map( clk => clk, rst => rst, counter_in => counter_in, read_in => read_in, data_in => data_in, --debug_out => debug_out,
                      data_out(N_PHI-1 downto 0) => region_data(2*N_PHI-1 downto N_PHI), valid_out => merge_valid(2*N_PHI-1 downto N_PHI));
    eta2: entity work.regionizer_eta
            generic map( etaMin => to_etaphi(+57), etaMax => to_etaphi(+342), etaShift => to_etaphi(-171) )
            port map( clk => clk, rst => rst, counter_in => counter_in, read_in => read_in, data_in => data_in, 
                      data_out(N_PHI-1 downto 0) => region_data(3*N_PHI-1 downto 2*N_PHI), valid_out => merge_valid(3*N_PHI-1 downto 2*N_PHI));

    process(clk,rst)
    begin
        if rst = '1' then
            mux_counter <= 0; 
            valid_out <= '0';
            was_valid <= '0';
        elsif rising_edge(clk) then
            if was_valid = '0' and merge_valid(0) = '1' then
                mux_counter <= 1;
                counter_out <= 0;
                data_out    <= region_data(0);
                valid_out   <= merge_valid(0);
                was_valid   <= '1';
            elsif mux_counter < N_REGIONS then
                if mux_counter < N_CLOCK-1 then
                    mux_counter <= mux_counter + 1;
                else
                    mux_counter <= 0;
                end if;
                mux_counter <= mux_counter + 1;
                counter_out <= mux_counter;
                data_out    <= region_data(mux_counter);
                valid_out   <= merge_valid(mux_counter);
                was_valid   <= merge_valid(mux_counter);
            else
                if mux_counter < N_CLOCK-1 then
                    mux_counter <= mux_counter + 1;
                else
                    mux_counter <= 0;
                end if;
                counter_out <= mux_counter;
                data_out    <= (others => null_particle);
                valid_out   <= '0';
                was_valid   <= '0';
            end if;
        end if;
    end process;

end Behavioral;
