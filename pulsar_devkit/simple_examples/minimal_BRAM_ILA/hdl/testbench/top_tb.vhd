library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

  -- Component for unit under test
  component test_algo
    port(
      clk1 : in STD_LOGIC;
      clk2 : in STD_LOGIC;
      data_in : in STD_LOGIC_VECTOR(31 downto 0);
      data_out : out STD_LOGIC_VECTOR(31 downto 0)
      );
  end component;

  -- Constants
  constant clk1_period : time := 5 ns;
  constant clk2_period : time := 10 ns;
  
  -- Stimulus signals
  signal clk1 : STD_LOGIC := '0';
  signal clk2 : STD_LOGIC := '0';
  signal data_in : STD_LOGIC_VECTOR(31 downto 0);
  signal data_reader_reset : STD_LOGIC := '0';
  
  -- Dummy signals
  signal dummy_data : STD_LOGIC_VECTOR(2 downto 0);
  signal dummy_data_valid : STD_LOGIC; 
  signal dummy_EOF : STD_LOGIC;
  
begin

  -- Instantiate unit under test 
  uut : test_algo port map (
    clk1 => clk1,
    clk2 => clk2,
    data_in => data_in,
    data_out => open
    );

  clk1 <= not clk1 after clk1_period;
  clk2 <= not clk2 after clk2_period;
  data_reader_reset <= '1', '0' after 5 ns;
  
  -----------------------------------------------
  -- Processes, entities, generates, etc go here
  -----------------------------------------------
  
  -- Data in from text file
  sim_data_reader: entity work.FILE_READ
    generic map(
      --stim_file => "/home/kreis/git_test/GlobalCorrelator/hdl/testbench/data1.dat",
      stim_file => "data1.dat",
      BIT_WIDTH => 36
      )
    port map(
      CLK  => clk1,
      RST => data_reader_reset,
      Y(31 downto 0)  => data_in(31 downto 0),
      Y(32) => dummy_data_valid,
      Y(35 downto 33) => dummy_data,
      EOG => dummy_EOF
      );
  -- This looks easier: http://digitalmonstrosity.com/quick-link-reading-and-writing-text-files/

  
end Behavioral;
