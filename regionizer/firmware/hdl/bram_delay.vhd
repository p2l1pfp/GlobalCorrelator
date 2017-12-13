-- inspired from from cactus/components/mp7_links/firmware/hdl/common/buf_18kb.vhd
-- (original author Dave Newbold, July 2013)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity bram_delay is
    generic(
        N_BITS : natural := 36;
        DELAY : natural
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        d: in std_logic_vector(N_BITS-1 downto 0);
        q: out std_logic_vector(N_BITS-1 downto 0)
    );
end bram_delay;

architecture rtl of bram_delay is
    constant MY_DELAY : natural := DELAY-3; -- 3 clock cycles of delay are already there because of registers & logic
    signal dfull: std_logic_vector(35 downto 0);
    signal qfull: std_logic_vector(35 downto 0);
    signal raddr: std_logic_vector(13 downto 0);
    signal waddr: std_logic_vector(13 downto 0);
    signal rindex: natural range 0 to 2*MY_DELAY-1;
    signal windex: natural range 0 to 2*MY_DELAY-1;
    constant half_index : natural := MY_DELAY-1;  
    constant max_index : natural := 2*MY_DELAY-1; 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                rindex <= half_index;
                windex <= 0;
            else 
                if rindex = max_index then
                    rindex <= 0;
                else
                    rindex <= rindex + 1;
                end if;
                if windex = max_index then
                    windex <= 0;
                else
                    windex <= windex + 1;
               end if;
            end if;
        end if;
    end process;
    raddr(13 downto 5) <= std_logic_vector(to_unsigned(rindex,9));
    waddr(13 downto 5) <= std_logic_vector(to_unsigned(windex,9));
    raddr(4 downto 0) <= (others => '0'); 
    waddr(4 downto 0) <= (others => '0'); 
    dfull(N_BITS-1 downto 0) <= d;
    q <= qfull(N_BITS-1 downto 0);

    zeropad: if N_BITS < 36 generate
        dfull(35 downto N_BITS) <= (others => '0');
    end generate;

    ram: RAMB18E1
        generic map(
            DOA_REG => 1,
            DOB_REG => 1,
            RAM_MODE => "SDP",
            READ_WIDTH_A => 36,
            WRITE_WIDTH_B => 36,
            WRITE_MODE_A => "READ_FIRST",
            WRITE_MODE_B => "READ_FIRST"
        )
        port map(
            ADDRARDADDR => raddr,
            ADDRBWRADDR => waddr,
            CLKARDCLK => clk,
            CLKBWRCLK => clk,
            DIADI => dfull(15 downto 0),
            DIBDI => dfull(31 downto 16),
            DIPADIP => dfull(33 downto 32),
            DIPBDIP => dfull(35 downto 34),
            DOADO => qfull(15 downto 0),
            DOBDO => qfull(31 downto 16),
            DOPADOP => qfull(33 downto 32),
            DOPBDOP => qfull(35 downto 34),
            ENARDEN => '1',
            ENBWREN => '1',
            REGCEAREGCE => '1',
            REGCEB => '0',
            RSTRAMARSTRAM => '0',
            RSTRAMB => '0',
            RSTREGARSTREG => '0',
            RSTREGB => '0',
            WEA => "00",
            WEBWE => "1111"
        );
end rtl;


