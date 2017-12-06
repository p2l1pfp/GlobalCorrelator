library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity phi_splitter is
    generic(
        N_SPLIT : natural := 3 -- fixme for the moment only 3 will work
    );
    port(
        clk : in std_logic;
        read_in  : in std_logic;                              
        data_in  : in  particle;                              
        first_in : in std_logic;                              
        last_in  : in std_logic;                              
        read_out : out std_logic_vector(N_SPLIT-1 downto 0);  
        data_out : out particles(N_SPLIT-1 downto 0);         
        first_out: out std_logic_vector(N_SPLIT-1 downto 0);  
        last_out : out std_logic_vector(N_SPLIT-1 downto 0)  
    );
end phi_splitter;

architecture Behavioral of phi_splitter is
    signal shifted : particle; 
    signal read, first, last : std_logic;
    signal sel : std_logic_vector(N_SPLIT-1 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            read <= read_in;
            first <= first_in;
            last <= last_in;

            if (data_in.phi > to_etaphi(PHI_SHIFT_SECTOR/2)) then
                sel <= ('1', '0', '0');
                shifted <= shift_phi(data_in, to_etaphi(-PHI_SHIFT_SECTOR));
            elsif (data_in.phi <= to_etaphi(-PHI_SHIFT_SECTOR/2)) then
                sel <= ('0', '0', '1');
                shifted <= shift_phi(data_in, to_etaphi(+PHI_SHIFT_SECTOR));
            else
                sel <= ('0', '1', '0');
                shifted <= data_in;
            end if;

            read_out <= (others => read);
            first_out <= (others => first);
            last_out <= (others => last);
            
            for i in N_SPLIT-1 downto 0 loop
                if sel(i) = '1' then 
                    data_out(i) <= shifted;
                else
                    data_out(i) <= null_particle;
                end if;
            end loop;
        end if;
    end process;

end Behavioral;
