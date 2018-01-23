-- null_algo
--
-- Do-nothing top level algo for testing
--
-- Dave Newbold, July 2013

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.mp7_data_types.all;
use work.top_decl.all;
use work.mp7_brd_decl.all;
use work.mp7_ttc_decl.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity mp7_payload is
  port(
    clk: in std_logic; -- ipbus signals
    rst: in std_logic;
    ipb_in: in ipb_wbus;
    ipb_out: out ipb_rbus;
    clk_payload: in std_logic_vector(2 downto 0);
    rst_payload: in std_logic_vector(2 downto 0);
    clk_p: in std_logic; -- data clock
    rst_loc: in std_logic_vector(N_REGION - 1 downto 0);
    clken_loc: in std_logic_vector(N_REGION - 1 downto 0);
    ctrs: in ttc_stuff_array;
    bc0: out std_logic;
    d: in ldata(4 * N_REGION - 1 downto 0); -- data in
    q: out ldata(4 * N_REGION - 1 downto 0); -- data out
    gpio: out std_logic_vector(29 downto 0); -- IO to mezzanine connector
    gpio_en: out std_logic_vector(29 downto 0) -- IO to mezzanine connector (three-state enables)
  );

end mp7_payload;

architecture rtl of mp7_payload is
    constant N_IN  : natural := 4*N_SECTORS+MU_SECTORS;
    constant N_OUT : natural := (N_CALO+N_EMCALO+N_TRACK+N_MU);
    signal sav_in_good : std_logic_vector(N_IN - 1 downto 0);
    signal sav_in  : words32(N_IN - 1 downto 0);
    signal reg_in_good : std_logic_vector(N_IN - 1 downto 0);
    signal reg_in  : words32(N_IN - 1 downto 0);
    signal reg_out : words32(N_OUT - 1 downto 0);
    signal reg_out_good : std_logic_vector(N_OUT-1 downto 0);
begin
    ipb_out <= IPB_RBUS_NULL;

    calo : entity work.regionizer_mp7_others
        generic map(N_OBJ_SECTOR => N_CALO_SECTOR, N_OBJ_SECTOR_ETA => N_CALO_SECTOR_ETA, N_OBJ => N_CALO, N_FIBERS_SECTOR => 1, N_FIBERS_OBJ => 1, 
                   SECTOR_VALID_BIT_DELAY => 1 )
        port map(clk => clk_p, rst => rst, 
                 mp7_valid => reg_in_good(1*N_SECTORS-1 downto 0*N_SECTORS), 
                 mp7_in => reg_in(1*N_SECTORS-1 downto 0*N_SECTORS), 
                 mp7_out  => reg_out(N_CALO-1 downto 0), 
                 mp7_outv => reg_out_good(N_CALO-1 downto 0));

    emcalo : entity work.regionizer_mp7_others
        generic map(N_OBJ_SECTOR => N_EMCALO_SECTOR, N_OBJ_SECTOR_ETA => N_EMCALO_SECTOR_ETA, N_OBJ => N_EMCALO, N_FIBERS_SECTOR => 1, N_FIBERS_OBJ => 1, 
                   SECTOR_VALID_BIT_DELAY => 7)
        port map(clk => clk_p, rst => rst, 
                 mp7_valid => reg_in_good(2*N_SECTORS-1 downto 1*N_SECTORS), 
                 mp7_in => reg_in(2*N_SECTORS-1 downto 1*N_SECTORS), 
                 mp7_out  => reg_out(N_CALO+N_EMCALO-1 downto N_CALO), 
                 mp7_outv => reg_out_good(N_CALO+N_EMCALO-1 downto N_CALO));

    track : entity work.regionizer_mp7_others
        generic map(N_OBJ_SECTOR => N_TRACK_SECTOR, N_OBJ_SECTOR_ETA => N_TRACK_SECTOR_ETA, N_OBJ => N_TRACK, N_FIBERS_SECTOR => 2, N_FIBERS_OBJ => 1, 
                   SECTOR_VALID_BIT_DELAY => 7 )
        port map(clk => clk_p, rst => rst, 
                 mp7_valid => reg_in_good(4*N_SECTORS-1 downto 2*N_SECTORS),  
                 mp7_in => reg_in(4*N_SECTORS-1 downto 2*N_SECTORS), 
                 mp7_out  => reg_out(N_CALO+N_EMCALO+N_TRACK-1 downto N_CALO+N_EMCALO), 
                 mp7_outv => reg_out_good(N_CALO+N_EMCALO+N_TRACK-1 downto N_CALO+N_EMCALO));

    muon: entity work.regionizer_mp7_muons
        generic map(N_OBJ_SECTOR => N_MU, N_OBJ_SECTOR_ETA => N_MU, N_OBJ => N_MU, N_FIBERS_OBJ => 1, 
                   MP7_INPUT_DELAY => 35 )
        port map(clk => clk_p, rst => rst, 
                 mp7_valid => reg_in_good(N_IN-1 downto 4*N_SECTORS), 
                 mp7_in    => reg_in(N_IN-1 downto 4*N_SECTORS), 
                 mp7_out  => reg_out(N_CALO+N_EMCALO+N_TRACK+N_MU-1 downto N_CALO+N_EMCALO+N_TRACK), 
                 mp7_outv => reg_out_good(N_CALO+N_EMCALO+N_TRACK+N_MU-1 downto N_CALO+N_EMCALO+N_TRACK));

    -- yet another register buffer
    get_input: process(clk_p)
    begin
        if clk_p'event and clk_p = '1' then
            for i in N_IN-1 downto 0 loop
                sav_in_good(i) <= d(0).valid;
                sav_in(i) <= d(i).data;
                reg_in_good(i) <= sav_in_good(i);
                reg_in(i) <= sav_in(i);
            end loop;
        end if;
    end process get_input;

    -- yet another register buffer
    get_output: process(clk_p)
    begin
        if clk_p'event and clk_p = '1' then
            for i in N_OUT-1 downto 0 loop
                q(i).data <= reg_out(i);
                q(i).valid <= reg_out_good(i);
                q(i).strobe <= '1';
            end loop;
        end if;
    end process get_output;

    dummy_output: process(clk_p)
    begin
        if clk_p'event and clk_p = '1' then
            for i in  4 * N_REGION - 1 downto N_OUT loop
                q(i).data <= (others => '1');
                q(i).valid <= '1';
                q(i).strobe <= '1';
            end loop;
        end if;
    end process dummy_output;

    bc0 <= '0';
    gpio    <= (others => '0');
    gpio_en <= (others => '0');

end rtl;
