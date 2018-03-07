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
use work.bhv_data_types.all;

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
    constant N_IN : natural := BHV_NSECTORS;
    constant N_OUT : natural := 3 + 2*BHV_NSECTORS;
    signal sav_in_good : std_logic_vector(N_IN - 1 downto 0);
    signal sav_in  : words32(N_IN - 1 downto 0);
    signal vtx_in_good : std_logic_vector(N_IN - 1 downto 0);
    signal vtx_in  : words32(N_IN - 1 downto 0);
    signal vtx_out : words32(N_OUT - 1 downto 0);
    signal vtx_out_good : std_logic_vector(N_OUT-1 downto 0);
begin
    ipb_out <= IPB_RBUS_NULL;

    bhv : entity work.bhv_mp7
        port map(clk => clk_p, rst => rst, mp7_in => vtx_in, mp7_out => vtx_out, mp7_valid => vtx_in_good, mp7_outv => vtx_out_good);
 
    -- yet another register buffer
    get_input: process(clk_p)
    begin
        if clk_p'event and clk_p = '1' then
            for i in N_IN-1 downto 0 loop
                sav_in_good(i) <= d(0).valid;
                sav_in(i) <= d(i).data;
                vtx_in_good(i) <= sav_in_good(i);
                vtx_in(i) <= sav_in(i);
            end loop;
        end if;
    end process get_input;

    -- yet another register buffer
    get_output: process(clk_p)
    begin
        if clk_p'event and clk_p = '1' then
            for i in N_OUT-1 downto 0 loop
                q(i).data <= vtx_out(i);
                q(i).valid <= vtx_out_good(i);
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
