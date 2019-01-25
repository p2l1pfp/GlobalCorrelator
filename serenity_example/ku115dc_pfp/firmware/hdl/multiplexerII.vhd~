library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.emp_data_types.all;
use work.top_decl.all;
use work.emp_device_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity multiplexer is
  port(
    --clk240 : in std_logic;
    --clk40 : in std_logic;
    clk : in std_logic;
    --rst : in std_logic;
    d : in ldata(N_IN_CHANS - 1 downto 0);
    start_pf : out std_logic_vector(PF_RESHAPE_FACTOR - 1 downto 0);
    q_pf : out pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_IN_CHANS - 1 downto 0)
  );
end multiplexer;

architecture rtl of multiplexer is
  --type tSel is range 0 to PF_RESHAPE_FACTOR - 1;
  type tSelArray is array (natural range <>) of integer range 0 to PF_RESHAPE_FACTOR - 1;
  signal sel : tSelArray(N_PF_IP_CORES - 1 downto 0);
  signal start_pf_int : std_logic_vector(PF_RESHAPE_FACTOR - 1 downto 0) := (others => '0'); --(0 => '1', others => '0');

begin

  gSel : for i in 0 to N_PF_IP_CORES - 1 generate
    set_select : process(clk)
    begin
      start_pf_int <= (others => '0');
      if rising_edge(clk) then
        if sel(i) = PF_RESHAPE_FACTOR - 1 then
          sel(i) <= 0;
          start_pf_int(i) <= '1';
        else
          sel(i) <= sel(i) + 1;
        end if;
      end if;
    end process set_select;
  end generate gSel;

--g0 : for i in 71 downto 0 generate
--  proc : process(clk, d)
--  begin
--    q_pf(0)(i) <= d(i).data(31 downto 0);
--  end process proc;
--end generate;

  g0 : for i in N_PF_IP_CORES - 1 downto 0 generate
    g1 : for j in N_PF_IP_CORE_IN_CHANS - 1 downto 0 generate
      mux_process : process(clk, d)
      begin
        if rising_edge(clk) then
          if j / N_CHANS_PER_CORE = sel(i) then
            q_pf(i)(j) <= d(i * N_CHANS_PER_CORE + j mod N_CHANS_PER_CORE).data(31 downto 0);
          end if;
        end if;
      end process;
    end generate g1;
  end generate g0;
  
  --g0 : for i in N_PF_IP_CORES - 1 downto 0 generate
  --g1 : for j in N_CHANS_PER_CORE - 1 downto 0 generate
  --  mux_process : process(clk, d)
  --  begin
  --    if rising_edge(clk) then
        --for j in N_CHANS_PER_CORE - 1 downto 0 loop
          --q_pf(i)(j * PF_RESHAPE_FACTOR + sel(i)) <= d(i * N_CHANS_PER_CORE + j).data(31 downto 0);
  --        q_pf(i)(sel(i) * PF_RESHAPE_FACTOR + j) <= d(i * N_CHANS_PER_CORE + j).data(31 downto 0);
        --end loop;
  --    end if;
  --  end process mux_process;
  --end generate g1;
  --end generate g0;

  --start_process : process(clk, start_pf_int)
  --begin
  --  start_pf_int <= std_logic_vector(rotate_left(unsigned(start_pf_int), 1));
  --end process start_process;
  
  start_pf <= start_pf_int;  

end rtl;
