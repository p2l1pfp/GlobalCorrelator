library ieee;

use ieee.std_logic_1164.all;

use work.emp_data_types.all;
use work.top_decl.all;
use work.emp_device_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity demultiplexer is
  port(
    --clk240 : in std_logic;
    --clk40 : in std_logic;
    clk : in std_logic;
    --rst : in std_logic;
    d_pf : in pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_OUT_CHANS - 1 downto 0);
    q : out ldata(N_OUT_CHANS - 1 downto 0)
  );
end demultiplexer;

architecture rtl of demultiplexer is
  type tSelArray is array (natural range <>) of integer range 0 to PF_RESHAPE_FACTOR - 1;
  signal sel : tSelArray(N_PF_IP_CORE_OUT_CHANS - 1 downto 0); 
begin

  -- Make loads of counters
  gSel : for i in 0 to N_PF_IP_CORE_OUT_CHANS - 1 generate
    set_select : process(clk)
    begin
      if rising_edge(clk) then
        if sel(i) = PF_RESHAPE_FACTOR - 1 then
          sel(i) <= 0;
        else
          sel(i) <= sel(i) + 1;
        end if;
      end if;
    end process set_select;
  end generate gSel;
  
  gMux : for i in N_PF_IP_CORE_OUT_CHANS - 1 downto 0 generate
    mux_process : process(clk)
    begin
      if rising_edge(clk) then
        -- + PF_ALGO_LATENCY mod 6 to align with the PF core output
        q(i).data(31 downto 0) <= d_pf(sel(i) + PF_ALGO_LATENCY mod 6)(i);
        q(i).strobe <= '1';
      end if;
    end process mux_process;
  end generate gMux;

end rtl;
