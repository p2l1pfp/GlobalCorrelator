library ieee;
use ieee.std_logic_1164.all;

use work.emp_data_types.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity demux_quad is
  port (
    clk240 : in std_logic;
    rst240 : in std_logic;
    valid  : in std_logic;
    d_pf   : in pf_data(6 * N_QUAD_LINKS - 1 downto 0);
    q      : out ldata(N_QUAD_LINKS - 1 downto 0)
  );

end demux_quad;

architecture rtl of demux_quad is

  signal sSel : integer range 0 to 5;

  -- ATTRIBUTE max_fanout         : integer;
  -- ATTRIBUTE max_fanout of sSel : signal is 20;

begin

  selector_gen : process (clk240)
  begin  -- process selector_gen
    if clk240'event and clk240 = '1' then  -- rising clock edge
      if rst240 = '1' then
        sSel <= PF_ALGO_LATENCY mod 6;  -- Selecting the IP core depending on algo latency.
      elsif sSel < 5 then
        sSel <= sSel+1;
      else
        sSel <= 0;
      end if;
    end if;
  end process selector_gen;

  serialization : process (clk240)
  begin  -- process serialization
    if clk240'event and clk240 = '1' then  -- rising clock edge
      for i in N_QUAD_LINKS - 1 downto 0 loop -- Number of channels
        q(i).strobe <= '1';
        q(i).valid  <= valid;
        q(i).data(31 downto 0)   <= d_pf(sSel * N_QUAD_LINKS + i);
      end loop;  -- i
    end if;
  end process serialization;

end rtl;
