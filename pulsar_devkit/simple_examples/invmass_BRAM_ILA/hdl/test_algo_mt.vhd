library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_algo_mt is
    port(
        clk1 : in STD_LOGIC;
        clk2 : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(31 downto 0);
        data_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end test_algo_mt;

architecture Behavioral of test_algo_mt is

    signal bram_to_hls : STD_LOGIC_VECTOR(63 downto 0);
    signal hls_to_ila : STD_LOGIC_VECTOR(31 downto 0);
    signal bram_address : STD_LOGIC_VECTOR(0 downto 0) := "0";
    
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

    component simple_algo_mt_hw_0
    port( outA_V_ap_vld : OUT STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        inA1_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        inA2_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        inA3_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        inA4_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);                       
        inB1_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        inB2_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        inB3_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        inB4_V : IN STD_LOGIC_VECTOR(7 DOWNTO 0);               
        outA_V : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;

    component ila_0
    port(clk : IN STD_LOGIC;
        probe0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        probe1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        probe2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;

begin

    --data_out <= x"00000000";

    process(clk1)
    begin
        if rising_edge(clk1) then
           
            --generate an address, just toggling between 1 and 0 
            -- (the current bram only has two addresses)
            if( bram_address = "1") then 
                bram_address <= "0"; 
            else
                bram_address <= "1";
            end if;
           
            data_out <= bram_to_hls(31 downto 0);

        end if; -- clk1 rising edge
    end process;

    
    my_bram_label : blk_mem_gen_0
        PORT MAP(
                clka  => clk1, 
                ena   => '1',
                wea   => "0", 
                addra => bram_address,
                dina  => x"0000000000000000", 
                douta => bram_to_hls);

    my_hls_label : simple_algo_mt_hw_0
        PORT MAP(
                outA_V_ap_vld => open,
                ap_start => '1',
                ap_done => open,
                ap_idle => open,
                ap_ready => open,
                inA1_V => bram_to_hls(63 downto 56),
                inA2_V => bram_to_hls(55 downto 48),
                inA3_V => bram_to_hls(47 downto 40),
                inA4_V => bram_to_hls(39 downto 32),
                inB1_V => bram_to_hls(31 downto 24),
                inB2_V => bram_to_hls(23 downto 16),
                inB3_V => bram_to_hls(15 downto 8),
                inB4_V => bram_to_hls(7 downto 0),                    
                outA_V => hls_to_ila);
    
    my_ila_label : ila_0
        PORT MAP(
                clk => clk1,
                probe0 => bram_to_hls(63 downto 32),
                probe1 => bram_to_hls(31 downto 0),
                probe2 => hls_to_ila);
                    
    
end Behavioral;
