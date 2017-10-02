library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity top is
    port(
        sys_clk_n : in STD_LOGIC;
        sys_clk_p : in STD_LOGIC
        --data_in   : in STD_LOGIC_VECTOR(31 downto 0);
        --data_out  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end top;

architecture Behavioral of top is

    -- components
    component test_algo_mt
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
    signal sys_clk_tmp, sys_clk_bufg : STD_LOGIC;

begin
   
    -- instantiate components
    my_test_algo : test_algo_mt
        port map(
            clk1 => sys_clk_bufg,
            clk2 => sys_clk_bufg, -- just same clk for now
            data_in => x"00000000",
            data_out => open
        );


--    -- clocked
--    process(clk1)
--    begin
--        if rising_edge(clk1) then
            
--            --sig_test <= clk1 and clk2; 
  
--        end if; -- clk1 rising edge
--    end process;


IBUFGDS_sys : IBUFGDS
  port map (
    I  => sys_clk_p,
    IB => sys_clk_n,
    O  => sys_clk_tmp);

BUFG_syspre : BUFG
  port map (
    I => sys_clk_tmp,
    O => sys_clk_bufg);

end Behavioral;
