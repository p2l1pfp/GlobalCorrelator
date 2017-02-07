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
        clk2 : in STD_LOGIC
    );
end top;

architecture Behavioral of top is

    -- components
    -- functinos
    -- constants
    -- signals
    signal sig_test : STD_LOGIC;

begin
    -- not clocked
    -- instantiate components

    -- clocked
    process(clk1)
    begin
        if rising_edge(clk1) then
            sig_test <= clk1 and clk2; 
        end if; -- clk1 rising edge
    end process;

end Behavioral;
