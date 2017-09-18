library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port(
        clk1 : in STD_LOGIC;
        clk2 : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(31 downto 0);
        data_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end top;

architecture Behavioral of top is

    -- components
    component test_algo
        port(
            clk1 : in STD_LOGIC;
            clk2 : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(31 downto 0);
            data_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    -- functinos
    -- constants
    
    -- signals
    signal sig_test : STD_LOGIC;

begin
   
    -- instantiate components
    my_test_algo : test_algo
        port map(
            clk1 => clk1,
            clk2 => clk2,
            data_in => data_in,
            data_out => data_out
        );

    -- clocked
    process(clk1)
    begin
        if rising_edge(clk1) then
            
            --sig_test <= clk1 and clk2; 
  
        end if; -- clk1 rising edge
    end process;

end Behavioral;
