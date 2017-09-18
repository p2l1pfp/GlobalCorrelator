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

    signal bram_to_hls : STD_LOGIC_VECTOR(63 downto 0);
--    attribute mark_debug : string;
--    attribute mark_debug of bram_to_hls : signal is "true"; 

    component blk_mem_gen_0
    port(clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
    end component;


begin

    --data_out <= x"00000000";

    process(clk1)
    begin
        if rising_edge(clk1) then
            
            --actually, nothing to do here at the moment
            data_out <= bram_to_hls(31 downto 0);

        end if; -- clk1 rising edge
    end process;

    
    componentlabel : blk_mem_gen_0
        PORT MAP(
                clka  => clk1, 
                ena   => '1',
                wea   => "0", 
                addra => "0",
                dina  => x"0000000000000000", 
                douta => bram_to_hls);
    
end Behavioral;
