library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_algo_array is
    port(
        clk1 : in STD_LOGIC;
        clk2 : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(63 downto 0);
        data_out : out STD_LOGIC_VECTOR(63 downto 0)
    );
end test_algo_array;

architecture Behavioral of test_algo_array is

    signal bram_to_hls : STD_LOGIC_VECTOR(63 downto 0);
    signal hls_to_bram : STD_LOGIC_VECTOR(63 downto 0);
    signal bram_to_ila : STD_LOGIC_VECTOR(63 downto 0);
    signal bram_address : STD_LOGIC_VECTOR(0 downto 0) := "0";
    signal bram2_address : std_logic_vector(0 downto 0):="0"; 
    signal bram2_wen : std_logic_vector(0 downto 0);
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

    component simple_algo_array_hw_0
    port(
      ap_clk : in STD_LOGIC;
      ap_rst : in STD_LOGIC;
      ap_start : in STD_LOGIC;
      ap_done : out STD_LOGIC;
      ap_idle : out STD_LOGIC;
      ap_ready : out STD_LOGIC;
      inA_V_address0 : out STD_LOGIC_VECTOR (0 downto 0);
      inA_V_ce0 : out STD_LOGIC;
      inA_V_q0 : in STD_LOGIC_VECTOR (31 downto 0);
      inB_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
      inB_V_ce0 : OUT STD_LOGIC;
      inB_V_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
      outA_V_address0 : out STD_LOGIC_VECTOR (0 downto 0);
      outA_V_ce0 : out STD_LOGIC;
      outA_V_we0 : out STD_LOGIC;
      outA_V_d0 : out STD_LOGIC_VECTOR (31 downto 0) );
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
          --  if( bram_address = "1") then 
           --     bram_address <= "0"; 
          --  else
           --     bram_address <= "1";
           -- end if;
           
            data_out <= bram_to_hls;

        end if; -- clk1 rising edge
    end process;

    
    my_bram_label : blk_mem_gen_0
        PORT MAP(
                clka  => clk1, 
                ena   => '1',
                wea   => "0", 
                addra => bram_address,
                dina  => x"0000000011111111", 
                douta => bram_to_hls);

    my_bram_label2 : blk_mem_gen_0
       PORT MAP(
                clka  => clk1, 
                ena   => '1',
                wea   => bram2_wen,
                addra => bram2_address,
                dina  => hls_to_bram,--x"0000000000000000", 
                douta => bram_to_ila);
    
    my_hls_label : simple_algo_array_hw_0
        PORT MAP(
                --outA_V_ap_vld => open,
          ap_clk => clk1,
          ap_rst => '1',
          ap_start => '1',
          ap_done => open,
          ap_idle => open,
          ap_ready => open,
          inA_V_ce0 => open,
          inB_V_ce0 => open,
          outA_V_ce0 => open,
          outA_V_we0 => bram2_wen(0),
          inA_V_address0 => bram_address,
          inB_V_address0 => bram_address,
          outA_V_address0 => bram2_address,
          inA_V_q0 => bram_to_hls(63 downto 32),
          inB_V_q0 => bram_to_hls(31 downto 0),
          outA_V_d0 => hls_to_bram(31 downto 0));
    
    
    my_ila_label : ila_0
        PORT MAP(
                clk => clk1,
                probe0 => bram_to_hls(63 downto 32),
                probe1 => bram_to_hls(31 downto 0),
                probe2 => bram_to_ila(31 downto 0));
                    
    
end Behavioral;
