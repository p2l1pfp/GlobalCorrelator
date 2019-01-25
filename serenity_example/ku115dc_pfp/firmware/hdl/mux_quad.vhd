library ieee;

use ieee.std_logic_1164.all;

use work.emp_data_types.all;
use work.top_decl.all;
use work.emp_device_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity mux_quad is
    port (
        clk240: in std_logic;
        rst240: in std_logic;
        d: in ldata(N_QUAD_LINKS - 1 downto 0);
        start_pf: out std_logic_vector(6 - 1 downto 0);
        q_pf: out pf_data(6 * N_QUAD_LINKS - 1 downto 0)
    );

end mux_quad;

architecture rtl of mux_quad is

  signal sSel : integer range 0 to 5;

  -- ATTRIBUTE max_fanout         : integer;
  -- ATTRIBUTE max_fanout of sSel : signal is 20;

begin

  selector_gen : process (clk240)
  begin  -- process selector_gen
    if clk240'event and clk240 = '1' then  -- rising clock edge
      if rst240 = '1' then
        sSel <= 0;
      elsif sSel < 5 then
        sSel <= sSel+1;
      else
        sSel <= 0;
      end if;
    end if;
  end process selector_gen;

  multiplexing : process (clk240)
  begin  -- process multiplexing
    if clk240'event and clk240 = '1' then  -- rising clock edge
      if rst240 = '1' then
        start_pf <= (others => '0');
      else
        start_pf <= (others => '0'); -- By default start is set to '0'.
        start_pf(sSel) <= '1';
        for i in N_QUAD_LINKS - 1 downto 0 loop -- Number of input channels
          q_pf(sSel * N_QUAD_LINKS + i) <= d(i).data(31 downto 0);  -- TODO: Latches!
        end loop;  -- i
      end if;
    end if;
  end process multiplexing;

end rtl;
