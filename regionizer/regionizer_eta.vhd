library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_eta is
    generic(
        etaMax: etaphi_t;
        etaMin: etaphi_t;
        etaShift : etaphi_t
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        counter_in : natural range 0 to N_IN_CLOCK-1;      -- index of the particle provided on data_in for each sector
        read_in    : in std_logic;                         -- 1 if data should be read from counter_in (divides input clock frequency by 2)
        data_in   : in  particles(N_SECTORS-1 downto 0);   -- input particles: one per sector region per (clock that has read_in = 1)
        data_out  : out regions(N_PHI-1 downto 0);         -- output particles (pt-sorted list of particle in N regions
        --debug_out : out particles(N_OBJ_SECTOR_ETA-1 downto 0); 
        valid_out : out std_logic_vector(N_PHI-1 downto 0)
    );
end regionizer_eta;


architecture Behavioral of regionizer_eta is
    type sectors is array(N_SECTORS-1 downto 0) of particles(N_OBJ_SECTOR_ETA-1 downto 0);
    signal sector_data : sectors;
    signal sort_valid: std_logic_vector(N_SECTORS-1 downto 0);
    signal out_buffer  : regions(N_PHI-1 downto 0);
    signal outv_buffer : std_logic_vector(N_PHI-1 downto 0);
    signal out_lifetime : natural range 0 to N_CLOCK-1; -- clock cycles to keep the output steady
begin
    generate_sorters: for i in N_SECTORS-1 downto 0 generate
        sort : entity work.sector_processor
            generic map( etaMin => etaMin, etaMax => etaMax, etaShift => etaShift )
            port map(clk => clk, rst => rst, counter_in => counter_in, read_in => read_in, data_in => data_in(i), 
                      data_out => sector_data(i), valid_out => sort_valid(i));
    end generate;
    --debug_out <= sector_data(0);
 
    generate_mergers: for i in N_PHI-2 downto 0 generate
        merge: entity work.sector_merger
            port map(clk => clk, load_in => sort_valid(2*i+1), 
                     list1_in => sector_data(2*i+0), list2_in => sector_data(2*i+1), list3_in => sector_data(2*i+2),
                     list_out => out_buffer(i), out_valid => outv_buffer(i)); 
    end generate;
    -- do this one separately due to wrapping of phi
    merge_last: entity work.sector_merger
            port map(clk => clk, load_in => sort_valid(2*(N_PHI-1)+1), 
                     list1_in => sector_data(2*(N_PHI-1)), list2_in => sector_data(2*(N_PHI-1)+1), list3_in => sector_data(0),
                     list_out => out_buffer((N_PHI-1)), out_valid => outv_buffer(N_PHI-1)); 

    process(clk,rst)
    begin
        if rst = '1' then
            out_lifetime <= 0;
        elsif rising_edge(clk) then
            if out_lifetime > 0 then
                out_lifetime <= out_lifetime - 1;
            elsif outv_buffer(0) = '1' then
                data_out <= out_buffer;
                valid_out <= outv_buffer;
                out_lifetime <= N_REGIONS;
            else
                data_out <= (others => (others => null_particle));
                valid_out <= (others => '0');
                out_lifetime <= 0;
            end if;
        end if;
    end process;

end Behavioral;
