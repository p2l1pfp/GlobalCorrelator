library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

  -- Component for unit under test
  component top
    port(
      clk1 : in STD_LOGIC;
      clk2 : in STD_LOGIC
      );
  end component;

  -- Constants
  constant clk1_period : time := 5 ns;
  constant clk2_period : time := 10 ns;
  
  -- Stimulus signals
  signal clk1 : STD_LOGIC := '0';
  signal clk2 : STD_LOGIC := '0';
  
begin

  -- Instantiate unit under test 
  uut : top port map (
    clk1 => clk1,
    clk2 => clk2
    );

  clk1 <= not clk1 after clk1_period;
  clk2 <= not clk2 after clk2_period;
  
  -- Processes, entities, generates, etc go here
  
end Behavioral;
