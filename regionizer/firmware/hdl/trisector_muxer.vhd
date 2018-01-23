library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity trisector_muxer is
    generic(
        N_OBJ_SECTOR_ETA : natural
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        region_eta_load : in std_logic_vector(3*N_SECTORS-1 downto 0);
        region_eta_in   : in particles(3*N_OBJ_SECTOR_ETA*N_SECTORS-1 downto 0);
        out_valid: out std_logic; 
        out_go:    out std_logic; 
        out_sector1 : out particles(N_OBJ_SECTOR_ETA -1 downto 0);
        out_sector2 : out particles(N_OBJ_SECTOR_ETA -1 downto 0);
        out_sector3 : out particles(N_OBJ_SECTOR_ETA -1 downto 0)
    );
end trisector_muxer;

architecture Behavioral of trisector_muxer is
    type region_eta_buffer is array(natural range <>) of particles(N_OBJ_SECTOR_ETA-1 downto 0);
    signal region_eta_work : region_eta_buffer(3*N_SECTORS-1 downto 0);
    signal region_eta_valid:  std_logic_vector(3*N_SECTORS-1 downto 0); 
    ----- time mux for the output
    signal mux_valid:   std_logic; 
    signal mux_started: std_logic;
    signal mux_wait:    std_logic; -- use to send outputs at half frequency
    signal timer_start: std_logic;
    signal timer_ring:  std_logic;

begin
    timer_phi : entity work.egg_timer
        generic map(N_COUNT => 2*N_PHI-1)
        port map( clk => clk, start => timer_start, go => '1', done => timer_ring );

    load_in: process(clk, rst)
    begin
        if rst = '1' then
            mux_valid <= '0';
            mux_started <= '0';
            timer_start <= '0';
        elsif rising_edge(clk) then
            if region_eta_load(0) = '1' then
                mux_valid   <= (region_eta_load(0) and region_eta_load(1) and region_eta_load(2));
                mux_wait    <= '1';
                mux_started <= '1';
                timer_start <= '1';
                for i in 3*N_SECTORS-1 downto 0 loop
                    region_eta_work(i)  <= region_eta_in((i+1)*N_OBJ_SECTOR_ETA-1 downto (i)*N_OBJ_SECTOR_ETA);   
                    region_eta_valid(i) <= region_eta_load(i);
                end loop;
            elsif mux_wait = '0' then
                timer_start <= timer_ring;
                if timer_ring = '0' then
                    for i in 0 to N_SECTORS-3 loop
                        region_eta_work(i) <= region_eta_work(i+2);
                        region_eta_valid(i) <= region_eta_valid(i+2);
                    end loop; 
                    region_eta_work(N_SECTORS-2) <= region_eta_work(0);
                    region_eta_work(N_SECTORS-1) <= region_eta_work(1); -- this is in fact never needed
                    region_eta_valid(N_SECTORS-2) <= region_eta_valid(0);
                    region_eta_valid(N_SECTORS-1) <= region_eta_valid(1); -- this is in fact never needed
                    mux_valid <= mux_started and (region_eta_valid(2) and region_eta_valid(3) and region_eta_valid(4));
                else  -- big shift
                    for i in 2*N_SECTORS-1 downto 0 loop
                        region_eta_work(i)  <= region_eta_work(i+N_SECTORS);
                        region_eta_valid(i) <= region_eta_valid(i+N_SECTORS);
                    end loop;
                    mux_valid <= mux_started and (region_eta_valid(0+N_SECTORS) and region_eta_valid(1+N_SECTORS) and region_eta_valid(2+N_SECTORS));
                end if;
                mux_wait <= '1';
            else
                timer_start <= timer_ring;
                mux_wait <= '0'; 
            end if;
        end if;
    end process load_in;

    out_valid <= mux_valid;
    out_go    <= mux_wait;
    out_sector1 <= region_eta_work(0);
    out_sector2 <= region_eta_work(1);
    out_sector3 <= region_eta_work(2);
end Behavioral;
        

