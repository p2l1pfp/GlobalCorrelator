library ieee;

use ieee.std_logic_1164.all;

use work.emp_data_types.all;
use work.top_decl.all;
use work.emp_device_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity multiplexer is
    port (
        clk240: in std_logic;
        clk40: in std_logic;
        rst: in std_logic_vector(N_REGION - 1 downto 0);
        d: in ldata(N_PF_IN_CHANS - 1 downto 0);
        start_pf: out std_logic_vector(6 - 1 downto 0);
        q_pf: out pf_data(6 * N_PF_IN_CHANS - 1 downto 0)
    );

end multiplexer;

architecture rtl of multiplexer is

  signal start_pf_vec : std_logic_vector(N_REGION * 6 - 1 downto 0);
  signal rst_reg : std_logic_vector(N_REGION - 1 downto 0);
  signal q_pf_int : pf_data(6 * N_PF_IN_CHANS - 1 downto 0);

begin

  reg_rst : process (clk40)
  begin  -- process reg_rst
    if clk40'event and clk40 = '1' then  -- rising clock edge
      rst_reg <= rst;
    end if;
  end process reg_rst;

  generate_multiplexers : for i in INPUT_QUAD_ASSIGNMENT'range generate
    mux_quad : entity work.mux_quad
      port map (
        clk240   => clk240,
        rst240   => rst_reg(INPUT_QUAD_ASSIGNMENT(i)),
        d        => d(N_QUAD_LINKS * INPUT_QUAD_ASSIGNMENT(i) + N_QUAD_LINKS - 1 downto N_QUAD_LINKS * INPUT_QUAD_ASSIGNMENT(i)),
        start_pf => start_pf_vec(6 * i + 5 downto 6 * i),
        q_pf     => q_pf_int(6 * N_QUAD_LINKS * i + 6 * N_QUAD_LINKS - 1 downto 6 * N_QUAD_LINKS * i)
        );
  end generate generate_multiplexers;

  -- Disentangle assignments.
  signal_assignment : for i in INPUT_QUAD_ASSIGNMENT'range generate
    mux_loop : for j in 5 downto 0 generate  -- For each frame
      q_pf(N_QUAD_LINKS * i + N_PF_IN_CHANS * j + (N_QUAD_LINKS - 1 ) downto N_QUAD_LINKS * i + N_PF_IN_CHANS * j) <= q_pf_int(6 * N_QUAD_LINKS * i + N_QUAD_LINKS * j + (N_QUAD_LINKS - 1) downto 6 * N_QUAD_LINKS * i + N_QUAD_LINKS * j);
    end generate mux_loop;
  end generate signal_assignment;

  gen_start_pf : for i in start_pf'range generate
    start_pf(i) <= start_pf_vec(i);
  end generate gen_start_pf;

end rtl;
