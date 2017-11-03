library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity sector_merger is
    generic(
        phiShift1: etaphi_t := to_etaphi(-PHI_SHIFT_SECTOR);
        phiShift2: etaphi_t := to_etaphi(0);
        phiShift3: etaphi_t := to_etaphi(PHI_SHIFT_SECTOR)
    );
    port(
        clk : in std_logic;    
        -- no reset for the moment: load_in with some valid data anyway resets the state
        load_in : in std_logic;                                -- set to 1 when new data should be copied from list_in to input buffers
        list1_in : in particles(N_OBJ_SECTOR_ETA-1 downto 0);  -- \
        list2_in : in particles(N_OBJ_SECTOR_ETA-1 downto 0);  -- |- pt-sorted list of input objects in each phi sector
        list3_in : in particles(N_OBJ_SECTOR_ETA-1 downto 0);  -- /
        list_out: out particles(N_OBJ-1 downto 0);             -- pt-sorted list of output objects
        --counter_out : out natural range 0 to N_OBJ-1;
        --debug_out  : out particles(2 downto 0);
        out_valid : out std_logic                              -- whether list_out is valid
    );   
end sector_merger;

architecture Behavioral of sector_merger is
    signal data1 : particles(N_OBJ_SECTOR_ETA-1 downto 0);
    signal data2 : particles(N_OBJ_SECTOR_ETA-1 downto 0);
    signal data3 : particles(N_OBJ_SECTOR_ETA-1 downto 0);
    signal work : particles(N_OBJ-1 downto 0);
    signal counter : natural range 0 to N_OBJ-1; -- index of next particle to be computed
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load_in = '1' then
                counter <= 0;
                data1 <= list1_in;
                data2 <= list2_in;
                data3 <= list3_in;  
                --report "Reloading data into sector mergers. top 3 pt values are " & integer'image(to_integer(list1_in(0).pt)) & ",  " & integer'image(to_integer(list2_in(0).pt)) & ",  " & integer'image(to_integer(list3_in(0).pt)) & ", current out head " & integer'image(to_integer(work(0).pt));
            else
                bound_check: assert counter < N_OBJ report "counter too large " & integer'image(counter);
                if counter < N_OBJ-1 then
                    counter <= counter + 1;
                end if;
            end if;

            if (data1(0).pt >= data2(0).pt) and (data1(0).pt >= data3(0).pt) then
                work(counter) <= data1(0);
                if data1(0).pt > 0 then work(counter).phi <= data1(0).phi + phiShift1; end if;
                if load_in = '0' then
                    for i in 1 to N_OBJ_SECTOR_ETA-1 loop
                        data1(i-1) <= data1(i);
                    end loop;
                    data1(N_OBJ_SECTOR_ETA-1) <= null_particle;
                end if;
            elsif (data2(0).pt > data1(0).pt) and (data2(0).pt >= data3(0).pt) then
                work(counter) <= data2(0);
                if data2(0).pt > 0 then work(counter).phi <= data2(0).phi + phiShift2; end if;
                if load_in = '0' then
                    for i in 1 to N_OBJ_SECTOR_ETA-1 loop
                        data2(i-1) <= data2(i);
                    end loop;
                    data2(N_OBJ_SECTOR_ETA-1) <= null_particle;
                end if;
            else
                work(counter) <= data3(0);
                if data3(0).pt > 0 then work(counter).phi <= data3(0).phi + phiShift3; end if;
                if load_in = '0' then
                    for i in 1 to N_OBJ_SECTOR_ETA-1 loop
                        data3(i-1) <= data3(i);
                    end loop;
                    data3(N_OBJ_SECTOR_ETA-1) <= null_particle;
                end if;
            end if;

            if counter = N_OBJ-1 then
                out_valid <= '1';
            else
                out_valid <= '0';
            end if;

        end if;
    end process;

    list_out <= work;
    --counter_out <= counter;
    --debug_out <= (0 => data1(0), 1 => data2(0), 2 => data3(0));
    --debug_out <= (0 => data3(0), 1 => data3(1), 2 => list3_in(0));
end Behavioral;


