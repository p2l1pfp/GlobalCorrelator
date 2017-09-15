library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_algo is
    port(
        clk1 : in STD_LOGIC;
        clk2 : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(31 downto 0);
        data_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end test_algo;

architecture Behavioral of test_algo is

    signal sig_test : STD_LOGIC;
    signal sig_data : STD_LOGIC_VECTOR(31 downto 0);

begin

    data_out <= sig_data;

    process(clk1)
    begin
        if rising_edge(clk1) then
            
            sig_test <= clk1 and clk2; 
            
            sig_data(31 downto 16) <= data_in(15 downto 0);
            sig_data(15 downto 0)  <= data_in(31 downto 16);             
            
        end if; -- clk1 rising edge
    end process;

end Behavioral;
