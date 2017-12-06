library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity sector_processor is
    generic(
        N_OBJ_SECTOR : natural;
        N_OBJ_SECTOR_ETA : natural;
        MAX_COUNT : natural := N_IN_CLOCK;
        SECTOR_NUMBER : natural := 999;
        etaMax: etaphi_t;
        etaMin: etaphi_t;
        etaShift : etaphi_t
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        --counter_in : in natural range 0 to MAX_COUNT-1;        -- tells the number of the object presented in data_in
        first_in   : in std_logic;                              -- true if this is the first particle in input
        last_in    : in std_logic;                              -- true if this is the first particle in input
        read_in    : in std_logic;                              -- set to true when the data_in should be read (every two clocks)
        data_in   : in  particle;                               -- next particle to read
        data_out  : out particles(N_OBJ_SECTOR_ETA-1 downto 0); -- pt-sorted and trimmed list of particles in the output
        valid_out : out std_logic                               -- set to 1 for one clock cycle when data_out is complete
    );
end sector_processor;

architecture Behavioral of sector_processor is
    signal data : particles(N_OBJ_SECTOR_ETA-1 downto 0); -- internal storage of the sorted list, also sent out on data_out
    signal signal_done : std_logic;                       -- this is set to 1 when we set valid_out to 1, so that we can reset it the next clock
    --signal counter_buf : natural range 0 to MAX_COUNT-1;        -- tells the number of the object presented in data_in
    signal first_buf   : std_logic;                              -- set to true when the data_in should be first (every two clocks)
    signal last_buf    : std_logic;                              -- set to true when the data_in should be last (every two clocks)
    signal read_buf    : std_logic;                              -- set to true when the data_in should be read (every two clocks)
    signal data_buf   : particle;                               -- next particle to read
begin

    buf: process(clk,rst)
    begin
        if rst = '1' then
            read_buf <= '0';
        elsif rising_edge(clk) then
            --counter_buf <= counter_in;
            read_buf <= read_in;
            first_buf <= first_in;
            last_buf <= last_in;
            data_buf <= data_in;
        end if;
    end process buf;

    process(clk,rst)
    begin
        if rst = '1' then
            data <= (others => null_particle);
            signal_done <= '0';
        elsif rising_edge(clk) then
            --if read_buf = '1' and counter_buf = 0 then
            --    assert first_buf = '1' report "At counter zero, first_buf should be 1 and is " & std_logic'image(first_buf);
            if read_buf = '1' and first_buf = '1' then
                if data_buf.pt > 0 and (etaMin <= data_buf.eta and data_buf.eta <= etaMax) then
                    data <= (0 => data_buf, others => null_particle);
                    data(0).eta <= data_buf.eta + etaShift;
                else
                    data <= (others => null_particle);
                end if;
            elsif read_buf = '1' and (etaMin <= data_buf.eta and data_buf.eta <= etaMax) then
                --assert first_buf = '0' report "At counter " & integer'image(counter_buf) & ", first_buf should be 0 and is " & std_logic'image(first_buf);
                for i in N_OBJ_SECTOR_ETA-1 downto 0 loop
                    if data(i).pt < data_buf.pt then
                        if i = 0 or data(i-1).pt >= data_buf.pt then
                            data(i) <= data_buf;
                            if data_buf.pt > 0 then data(i).eta <= data_buf.eta + etaShift; end if;
                        else
                            data(i) <= data(i-1);
                        end if;
                    else
                        data(i) <= data(i); -- unclear if this is useful
                    end if;
                end loop;
            --elsif read_buf = '1' then
            --    assert first_buf = '0' report "At counter " & integer'image(counter_buf) & ", first_buf should be 0 and is " & std_logic'image(first_buf);
            end if;
            
            --if counter_buf = N_OBJ_SECTOR and read_buf = '1'  then 
            --    assert last_buf = '1' report "At counter " & integer'image(counter_buf) & ", last_buf should be 1 and is " & std_logic'image(last_buf);
            --elsif read_buf = '1' then
            --    assert last_buf = '0' report "At counter " & integer'image(counter_buf) & ", last_buf should be 0 and is " & std_logic'image(last_buf);
            --end if;
            --if counter_buf = N_OBJ_SECTOR and signal_done = '0' and read_buf = '1'  then 
            if last_buf = '1' and signal_done = '0' and read_buf = '1'  then 
                signal_done <= '1';
                valid_out <= '1';
            else
                signal_done <= '0';
                valid_out <= '0';
            end if;
        end if;
    end process;

    data_out <= data;
end Behavioral;
