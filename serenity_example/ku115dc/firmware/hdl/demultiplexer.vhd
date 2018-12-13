library ieee;
use ieee.std_logic_1164.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity demultiplexer is
  port (
    clk240 : in std_logic;
    clk40  : in std_logic;
    rst    : in std_logic_vector(N_REGION - 1 downto 0);
    valid  : in std_logic;
    d_pf   : in pf_data(6 * N_PF_OUT_CHANS - 1 downto 0);
    q      : out ldata(N_PF_OUT_CHANS - 1 downto 0)
  );

end demultiplexer;

architecture rtl of demultiplexer is

  signal rst_reg    : std_logic_vector(N_REGION - 1 downto 0);
  signal sValid_reg : std_logic;

begin

  reg_rst : process (clk40)
  begin  -- process reg_rst
    if clk40'event and clk40 = '1' then  -- rising clock edge
      rst_reg    <= rst;
      sValid_reg <= valid; -- For now just to give it time for propagation..
    end if;
  end process reg_rst;

  -- d_pf(67 downto 0) comes from IP core 0 and needs to go into first frame; d_pf(2*68 - 1 downto 68 ) comes from IPc2 and should go into second frame.
  -- => Need to supply the following to the first quad: d_pf(0 * 68 + 3 downto 0 * 68) and d_pf(1 * 68 + 3 downto 1 * 68) (and so on for all 6 theoretical IP cores)
  -- => Need to supply the following to the second quad: d_pf(0 * 68 + 4 + 3 downto 0 * 68 + 4) and d_pf(1 * 68 + 4 + 3 downto 1 * 68 + 4)
  -- ...
  -- Then inside the quads we select 0 to 3 for first frame, 4 to 7 for second etc.
  generate_demultiplexers : for i in OUTPUT_QUAD_ASSIGNMENT'range generate
    demux_quad : entity work.demux_quad
      port map (
        clk240             => clk240,
        rst240             => rst_reg(INPUT_QUAD_ASSIGNMENT(i)),
        valid              => sValid_reg,
        d_pf(3 downto 0)   => d_pf(0 * 68 + N_QUAD_LINKS * i + N_QUAD_LINKS - 1 downto 0 * 68 + N_QUAD_LINKS * i),
        d_pf(7 downto 4)   => d_pf(1 * 68 + N_QUAD_LINKS * i + N_QUAD_LINKS - 1 downto 1 * 68 + N_QUAD_LINKS * i),
        d_pf(11 downto 8)  => d_pf(2 * 68 + N_QUAD_LINKS * i + N_QUAD_LINKS - 1 downto 2 * 68 + N_QUAD_LINKS * i),
        d_pf(15 downto 12) => d_pf(3 * 68 + N_QUAD_LINKS * i + N_QUAD_LINKS - 1 downto 3 * 68 + N_QUAD_LINKS * i),
        d_pf(19 downto 16) => d_pf(4 * 68 + N_QUAD_LINKS * i + N_QUAD_LINKS - 1 downto 4 * 68 + N_QUAD_LINKS * i),
        d_pf(23 downto 20) => d_pf(5 * 68 + N_QUAD_LINKS * i + N_QUAD_LINKS - 1 downto 5 * 68 + N_QUAD_LINKS * i),
        q                  => q(N_QUAD_LINKS * INPUT_QUAD_ASSIGNMENT(i) + N_QUAD_LINKS - 1 downto N_QUAD_LINKS * INPUT_QUAD_ASSIGNMENT(i))
        );
  end generate generate_demultiplexers;

end rtl;
