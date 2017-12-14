library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bhv_data_types.all;

entity bhv_core is
    generic(
        BANK_BITS : natural := 3;
        N_BANKS   : natural := 2;
        SECTOR    : natural := 999
    );
    port(
        clk : in std_logic;
        go  : in std_logic; -- toggles between 1 and 0
        bin : in zbin_t;
        val : in ptsum_t;
        new_event : in std_logic;
        out_new  : out std_logic;
        out_bank : out unsigned(BANK_BITS-1 downto 0);
        out_bin  : out zbin_t;
        out_l    : out ptsum_t;
        out_h    : out ptsum_t
    );
end bhv_core;

architecture Behavioral of bhv_core is
    subtype bank is unsigned(BANK_BITS-1 downto 0);
    type    banks is array(natural range <>) of bank;
    constant ZERO_BANK : bank := to_unsigned(    0,     bank'length);
    constant  ONE_BANK : bank := to_unsigned(    1,     bank'length);
    constant LAST_BANK : bank := to_unsigned(N_BANKS-1, bank'length);
    signal go_nodup  : std_logic := '0';
    signal bin_nodup : zbin_t := (others => '0');
    signal val_nodup : ptsum_t := (others => '0');
    signal adder_bank  : bank := ZERO_BANK;
    signal reader_bank : bank := ONE_BANK;
    signal adder_bin : zbin_t := (others => '0');
    signal adder_in : ptsum_t := (others => '0');
    signal adder_out : ptsum_t := (others => '0');
    signal adder_we  : std_logic := '0';
    signal new_event_del : std_logic := '0';

    constant NP : natural := 1; 
    signal reader_bins  : zbin_arr_t(NP downto 0) := (others => (others => '0'));
    signal reader_banks : banks(NP downto 0)      := (others => ONE_BANK);
    signal reader_new   : std_logic_vector(NP downto 0) := (others => '0');
    
begin
    dupmerge : entity work.duplicate_merger
        port map(clk => clk,
                  in_go => go,        in_bin => bin,        in_val => val,       in_first  => new_event,
                 out_go => go_nodup, out_bin => bin_nodup, out_val => val_nodup);

    adder : entity work.histo_double_add
        port map(clk => clk, 
                 go => go_nodup, bin => bin_nodup, val => val_nodup,
                 hist_bin => adder_bin, hist_in => adder_out, hist_out => adder_in, hist_we => adder_we);

    delay_in : entity work.delay_line
        generic map(N_BITS => 1, DELAY => 5)
        port map(clk => clk, rst => '0', d(0) => new_event, q(0) => new_event_del); 

    histo : entity work.histo_bram
        generic map(SECTOR => SECTOR)
        port map(clk => clk, 
                 adder_bank => adder_bank,
                 adder_bin => adder_bin,
                 adder_in => adder_in,
                 adder_out => adder_out,
                 adder_we => adder_we,
                 reader_bank => reader_banks(NP),
                 reader_bin  => reader_bins(NP),
                 reader_inl => (others => '0'),
                 reader_inh => (others => '0'),
                 reader_outl => out_l,
                 reader_outh => out_h,
                 reader_we => '1');

    bank_logic: process(clk)
    begin
        if rising_edge(clk) then
            if new_event_del = '1' and reader_new(NP) = '0' then
                --report "This is a new event. old adder bank " & integer'image(to_integer(adder_bank)) & " reader bank " & integer'image(to_integer(reader_banks(NP)));
                -- go to a new bank
                if adder_bank /= LAST_BANK then
                    adder_bank <= adder_bank + ONE_BANK;
                else
                    adder_bank <= ZERO_BANK;
                end if;
                if reader_banks(NP) /= LAST_BANK then
                    reader_banks(NP) <= reader_banks(NP) + ONE_BANK;
                else
                    reader_banks(NP) <= ZERO_BANK;
                end if;
                reader_bins(NP) <= to_zbin(0);
            else
                reader_bins(NP) <= reader_bins(NP) + to_zbin(2);
            end if; 
            reader_bins(NP-1 downto 0)  <= reader_bins(NP downto 1);
            reader_banks(NP-1 downto 0) <= reader_banks(NP downto 1);

            reader_new(NP) <= new_event_del and not reader_new(NP);
            reader_banks(NP-1 downto 0) <= reader_banks(NP downto 1);
            reader_new(NP-1 downto 0) <= reader_new(NP downto 1);
        end if;
    end process bank_logic;

    out_new  <= reader_new(0);
    out_bin  <= reader_bins(0);
    out_bank <= reader_banks(0);
end Behavioral;

