library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

use work.bhv_data_types.all;

-- hard version, instantiating the RAMB18E1 primitive
entity histo_bram is
    generic(
        SECTOR : natural := 999
    );
    port(
        clk : in std_logic;
        adder_bank : in std_logic;
        adder_bin : in zbin_t;
        adder_in : in ptsum_t;
        adder_out : out ptsum_t;
        adder_we  : in std_logic;
        reader_bank: in std_logic;
        reader_bin : in zbin_t;
        reader_inl  : in  ptsum_t;
        reader_inh  : in  ptsum_t;
        reader_outl : out ptsum_t;
        reader_outh : out ptsum_t;
        reader_we   : in std_logic
    );
end histo_bram;

architecture Behavioral of histo_bram is
    subtype phys_addr is std_logic_vector(13 downto 0);
    subtype phys_data is std_logic_vector(15 downto 0);
    subtype phys_parity is std_logic_vector(1 downto 0);

    signal a_addr, b_addr : phys_addr := (others => '0');
    signal a_we : std_logic_vector(1 downto 0) := (others => '0');
    signal b_we : std_logic_vector(3 downto 0) := (others => '0');
    signal a_data_in, b_data_in, a_data_out, b_data_out : phys_data;
    signal a_parity_in, b_parity_in, a_parity_out, b_parity_out : phys_parity;
    
begin

    ram: RAMB18E1
            generic map(
                    DOA_REG => 0,
                    DOB_REG => 0,
                    RAM_MODE => "TDP",
                    READ_WIDTH_A => 9,
                    WRITE_WIDTH_A => 9,
                    READ_WIDTH_B => 18,
                    WRITE_WIDTH_B => 18,
                    WRITE_MODE_A => "READ_FIRST",
                    WRITE_MODE_B => "READ_FIRST",
                    RDADDR_COLLISION_HWCONFIG => "PERFORMANCE"
            )
            port map(
                    ADDRARDADDR => a_addr,
                    ADDRBWRADDR => b_addr,
                    CLKARDCLK => clk,
                    CLKBWRCLK => clk,
                    DIADI => a_data_in,
                    DIBDI => b_data_in,
                    DIPADIP => a_parity_in,
                    DIPBDIP => b_parity_in,
                    DOADO => a_data_out,
                    DOBDO => b_data_out,
                    DOPADOP => a_parity_out,
                    DOPBDOP => b_parity_out,
                    ENARDEN => '1',
                    ENBWREN => '1',
                    REGCEAREGCE => '1',
                    REGCEB => '1',
                    RSTRAMARSTRAM => '0',
                    RSTRAMB => '0',
                    RSTREGARSTREG => '0',
                    RSTREGB => '0',
                    WEA => a_we,
                    WEBWE => b_we
            );

    assert reader_bank /= adder_bank report "Bank collision" severity failure;

    a_addr(10) <= adder_bank; 
    a_addr( 9 downto 3) <= std_logic_vector(adder_bin); 

    b_addr(10) <= reader_bank; 
    b_addr( 9 downto 4) <= std_logic_vector(reader_bin(zbin_t'length-1 downto 1)); 
    
    a_we <= (others => adder_we);
    b_we <= (others => reader_we);

    a_parity_in(0) <= adder_in(8);
    a_data_in(7 downto 0) <= std_logic_vector(adder_in(7 downto 0));

    adder_out(7 downto 0) <= unsigned(a_data_out(7 downto 0));
    adder_out(8) <= a_parity_out(0);

    b_data_in( 7 downto 0) <= std_logic_vector(reader_inl(7 downto 0));
    b_data_in(15 downto 8) <= std_logic_vector(reader_inh(7 downto 0));
    b_parity_in(0) <= reader_inl(8);
    b_parity_in(1) <= reader_inh(8);

    reader_outl(7 downto 0) <= unsigned(b_data_out( 7 downto 0));
    reader_outh(7 downto 0) <= unsigned(b_data_out(15 downto 8));
    reader_outl(8) <= b_parity_out(0);
    reader_outh(8) <= b_parity_out(1);

    -- user guide says tie unusued data to low, unused addresses to high
    a_addr(13) <= '1'; 
    b_addr(13) <= '1'; 
    a_addr(2 downto 0) <= (others => '1'); 
    b_addr(3 downto 0) <= (others => '1'); 
    a_data_in(15 downto  8) <= (others => '0');
end Behavioral;
