library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity sector_processor is
    generic(
        etaMax: etaphi_t;
        etaMin: etaphi_t;
        etaShift : etaphi_t
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        counter_in : in natural range 0 to N_IN_CLOCK-1;        -- tells the number of the object presented in data_in
        read_in    : in std_logic;                              -- set to true when the data_in should be read (every two clocks)
        data_in   : in  particle;                               -- next particle to read
        data_out  : out particles(N_OBJ_SECTOR_ETA-1 downto 0); -- pt-sorted and trimmed list of particles in the output
        valid_out : out std_logic                               -- set to 1 for one clock cycle when data_out is complete
    );
end sector_processor;

architecture Behavioral of sector_processor is
    signal data : particles(N_OBJ_SECTOR_ETA-1 downto 0); -- internal storage of the sorted list, also sent out on data_out
    signal signal_done : std_logic;                       -- this is set to 1 when we set valid_out to 1, so that we can reset it the next clock
begin
    process(clk,rst)
    begin
        if rst = '1' then
            data <= (others => null_particle);
            signal_done <= '0';
        elsif rising_edge(clk) then
            if read_in = '1' and counter_in = 0 then
                if data_in.pt > 0 and (etaMin <= data_in.eta and data_in.eta <= etaMax) then
                    data <= (0 => data_in, others => null_particle);
                    data(0).eta <= data_in.eta + etaShift;
                else
                    data <= (others => null_particle);
                end if;
            elsif read_in = '1' and (etaMin <= data_in.eta and data_in.eta <= etaMax) then
                for i in N_OBJ_SECTOR_ETA-1 downto 0 loop
                    if data(i).pt < data_in.pt then
                        if i = 0 or data(i-1).pt >= data_in.pt then
                            data(i) <= data_in;
                            if data_in.pt > 0 then data(i).eta <= data_in.eta + etaShift; end if;
                        else
                            data(i) <= data(i-1);
                        end if;
                    else
                        data(i) <= data(i); -- unclear if this is useful
                    end if;
                end loop;
            end if;
            if counter_in = N_OBJ_SECTOR and signal_done = '0' then
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
