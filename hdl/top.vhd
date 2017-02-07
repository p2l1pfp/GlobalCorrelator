----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2017 11:17:30 AM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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
    -- functinos
    -- constants
    -- signals
    signal sig_test : STD_LOGIC;
    signal sig_data : STD_LOGIC_VECTOR(31 downto 0);

begin
    -- not clocked
    data_out <= sig_data;
    -- instantiate components

    -- clocked
    process(clk1)
    begin
        if rising_edge(clk1) then
            
            sig_test <= clk1 and clk2; 
            
            sig_data(31 downto 16) <= data_in(15 downto 0);
            sig_data(15 downto 0)  <= data_in(31 downto 16);             
            
        end if; -- clk1 rising edge
    end process;

end Behavioral;
