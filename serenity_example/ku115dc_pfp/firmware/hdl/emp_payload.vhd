-- null_algo
--
-- Do-nothing top level algo for testing
--
-- Dave Newbold, July 2013

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.emp_data_types.all;
use work.top_decl.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.mp7_ttc_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity emp_payload is
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
		
end emp_payload;

architecture rtl of emp_payload is

  signal rst_loc_reg : std_logic_vector(N_REGION - 1 downto 0);       
  constant N_FRAMES_USED : natural := 1;
  signal start_pf : std_logic_vector(5 downto 0);
  signal d_pf : pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_IN_CHANS - 1 downto 0);
  signal q_pf : pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_OUT_CHANS - 1 downto 0);

begin

	ipb_out <= IPB_RBUS_NULL;
	
	-- TODO this is temporary, while isolating segfault
	--gDummy : for i in N_PF_IP_CORE_IN_CHANS - 1 downto 0 generate
	--  d_pf(0)(i) <= d(i).data(31 downto 0);
	--end generate;
	
	--gDummy2 : for i in N_PF_IP_CORE_OUT_CHANS - 1 downto 0 generate
	--   q(i).data(31 downto 0) <= q_pf(0)(i);
	--end generate;

    multiplex : entity work.multiplexer
      port map(
        clk => clk_p,
        d => d,
        start_pf => start_pf,
        q_pf => d_pf
      );

--    multiplex : entity work.multiplexer
--      PORT MAP (
--        clk240                                               => clk_p,
--        clk40                                                => clk_payload(2),
--        rst                                                  => rst_loc,
--        d                                                    => d,
--        start_pf                                             => start_pf,
--        q_pf(N_PF_IN_CHANS - 1 downto 0)                     => d_pf(0),
--        q_pf(2 * N_PF_IN_CHANS - 1 downto N_PF_IN_CHANS)     => d_pf(1),
--        q_pf(3 * N_PF_IN_CHANS - 1 downto 2 * N_PF_IN_CHANS) => d_pf(2),
--        q_pf(4 * N_PF_IN_CHANS - 1 downto 3 * N_PF_IN_CHANS) => d_pf(3),
--        q_pf(5 * N_PF_IN_CHANS - 1 downto 4 * N_PF_IN_CHANS) => d_pf(4),
--        q_pf(6 * N_PF_IN_CHANS - 1 downto 5 * N_PF_IN_CHANS) => d_pf(5)
--    );

   selector_gen : process (clk_p)
   begin  -- process selector_gen
     if clk_p'event and clk_p = '1' then  -- rising clock edge
       rst_loc_reg <= rst_loc;
      end if;
    end process selector_gen;

    generate_pf_cores : for i in N_PF_IP_CORES - 1 downto 0 generate
      pf_algo : entity work.pf_ip_wrapper
        PORT MAP (
          clk    => clk_p,
          rst    => rst_loc(i),
          start  => start_pf(i),
          -- start  => start_pf(i),
          input  => d_pf(i),
          done   => open,
          idle   => open,
          ready  => open,
          output => q_pf(i)
        );
    end generate generate_pf_cores;

    demux : entity work.demultiplexer
      port map (
        clk => clk_p,
        d_pf => q_pf,
        q => q(N_OUT_CHANS - 1 downto 0)
      );

--    demux : entity work.demultiplexer
--      port map (
--        clk240                                                 => clk_p,
--        clk40                                                  => clk_payload(2),
--        rst                                                    => rst_loc,
--        valid                                                  => '1',  -- d(0).valid, -- TODO: Delay.
--        d_pf(1 * N_PF_OUT_CHANS - 1 downto 0)                  => q_pf(0),
--        d_pf(2 * N_PF_OUT_CHANS - 1 downto 1 * N_PF_OUT_CHANS) => q_pf(1),
--        d_pf(3 * N_PF_OUT_CHANS - 1 downto 2 * N_PF_OUT_CHANS) => q_pf(2),
--        d_pf(4 * N_PF_OUT_CHANS - 1 downto 3 * N_PF_OUT_CHANS) => q_pf(3),
--        d_pf(5 * N_PF_OUT_CHANS - 1 downto 4 * N_PF_OUT_CHANS) => q_pf(4),
--        d_pf(6 * N_PF_OUT_CHANS - 1 downto 5 * N_PF_OUT_CHANS) => q_pf(5),
--        q                                                      => q(N_PF_OUT_CHANS - 1 downto 0)
--      );

     bc0 <= '0';
     gpio <= (others => '0');
     gpio_en <= (others => '0');

end rtl;
