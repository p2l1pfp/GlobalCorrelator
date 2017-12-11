library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bhv_data_types.all;

entity histo_bram is
    generic(
        BANK_BITS : natural := 3;
        SECTOR : natural := 999
    );
    port(
        clk : in std_logic;
        adder_bank : in unsigned(BANK_BITS-1 downto 0);
        adder_bin : in zbin_t;
        adder_in : in ptsum_t;
        adder_out : out ptsum_t;
        adder_we  : in std_logic;
        reader_bank: in unsigned(BANK_BITS-1 downto 0);
        reader_bin : in zbin_t;
        reader_inl  : in  ptsum_t;
        reader_inh  : in  ptsum_t;
        reader_outl : out ptsum_t;
        reader_outh : out ptsum_t;
        reader_we   : in std_logic
    );
end histo_bram;

architecture Behavioral of histo_bram is
    constant BIN_BITS : natural := zbin_t'length;

    subtype addr is std_logic_vector(BANK_BITS+BIN_BITS-2 downto 0);

    type ram_array is array((2**addr'length-1) downto 0) of std_logic_vector(17 downto 0);
    shared variable ram  : ram_array := (others => (others => '0'));

    signal adder_addr, reader_addr : addr;
    signal adder_bit : std_logic;

    signal adder_sel, reader_sel : integer range 0 to 2**addr'length-1;
begin

    adder_addr(addr'length-1 downto BIN_BITS-1) <= std_logic_vector(adder_bank);
    adder_addr(BIN_BITS-2 downto 0) <= std_logic_vector(adder_bin(zbin_t'length-1 downto 1));
    adder_bit <= adder_bin(0);

    reader_addr(addr'length-1 downto BIN_BITS-1) <= std_logic_vector(reader_bank);
    reader_addr(BIN_BITS-2 downto 0) <= std_logic_vector(reader_bin(zbin_t'length-1 downto 1));

    adder_sel  <= to_integer(unsigned(adder_addr));
    reader_sel <= to_integer(unsigned(reader_addr));

    port_a: process(clk)
    begin
        if rising_edge(clk) then
            if adder_bit = '1' then
                adder_out <= ptsum_t(ram(adder_sel)(17 downto 9));
                if adder_we /= '1' then
                    report "Read " & integer'image(to_integer(unsigned(ram(adder_sel)(17 downto 9)))) & 
                          " from addr " & integer'image(adder_sel) & " bit " & std_logic'image(adder_bit) & 
                          "  (bank " & integer'image(to_integer(adder_bank)) & " bin " & integer'image(to_integer(adder_bin)) & "  sector " & integer'image(SECTOR) & ")";
                end if;
            else
                adder_out <= ptsum_t(ram(adder_sel)( 8 downto 0));
                if adder_we /= '1' then
                    report "Read " & integer'image(to_integer(unsigned(ram(adder_sel)( 8 downto 0)))) & 
                          " from addr " & integer'image(adder_sel) & " bit " & std_logic'image(adder_bit) & 
                          "  (bank " & integer'image(to_integer(adder_bank)) & " bin " & integer'image(to_integer(adder_bin)) & "  sector " & integer'image(SECTOR) & ")";
                end if;
            end if;
            if adder_we = '1' then
                if adder_bit = '1' then
                    ram(adder_sel)(17 downto 9) := std_logic_vector(adder_in);
                    report "Wrote " & integer'image(to_integer(unsigned(ram(adder_sel)(17 downto 9)))) & 
                              " from addr " & integer'image(adder_sel) & " bit " & std_logic'image(adder_bit) & 
                              "  (bank " & integer'image(to_integer(adder_bank)) & " bin " & integer'image(to_integer(adder_bin)) & "  sector " & integer'image(SECTOR) & ")";
                else
                    ram(adder_sel)( 8 downto 0) := std_logic_vector(adder_in);
                    report "Wrote " & integer'image(to_integer(unsigned(ram(adder_sel)( 8 downto 0)))) & 
                              " from addr " & integer'image(adder_sel) & " bit " & std_logic'image(adder_bit) & 
                              "  (bank " & integer'image(to_integer(adder_bank)) & " bin " & integer'image(to_integer(adder_bin)) & "  sector " & integer'image(SECTOR) & ")";
                end if;
            else
            end if;
        end if;
    end process;

    
    port_r: process(clk)
    begin
        if rising_edge(clk) then
            reader_outh <= ptsum_t(ram(reader_sel)(17 downto 9));
            reader_outl <= ptsum_t(ram(reader_sel)( 8 downto 0));
            if reader_we = '1' then
                report "Read " & integer'image(to_integer(unsigned(ram(reader_sel)(8 downto 0)))) & 
                          " and " & integer'image(to_integer(unsigned(ram(reader_sel)(17 downto 9)))) &
                          " from addr " & integer'image(reader_sel) & 
                          "  (bank " & integer'image(to_integer(reader_bank)) & " bin " & integer'image(to_integer(reader_bin)) & "  sector " & integer'image(SECTOR) & ") and clearing the value.";
                ram(reader_sel)(17 downto 9) := std_logic_vector(reader_inh);
                ram(reader_sel)( 8 downto 0) := std_logic_vector(reader_inl);
            else
            end if;
        end if;
    end process;
end Behavioral;

