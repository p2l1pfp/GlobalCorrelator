library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_pipelined is
    generic(
        N_OBJ_SECTOR : natural;
        N_OBJ_SECTOR_ETA : natural;
        N_OBJ : natural;
        N_FIBERS_SECTOR : natural range 1 to 2 := 1;
        SECTOR_VALID_BIT_DELAY : natural := 0
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        read_in : in std_logic_vector(N_SECTORS-1 downto 0); -- whether we're sending data to the regionizer to be read 
        links_in: in particles(N_SECTORS-1 downto 0); -- input particles for the regionizer
        first_in: in std_logic_vector(N_SECTORS-1 downto 0);   -- counter in sync with input particles for the regionizer
        last_in:  in std_logic_vector(N_SECTORS-1 downto 0);   -- counter in sync with input particles for the regionizer
        links_out : out particles(N_OBJ-1 downto 0); -- input particles for the regionizer
        valid_out : out std_logic  -- valid output from the regionizer
    );
end regionizer_mp7_pipelined;

architecture Behavioral of regionizer_mp7_pipelined is
    ----- stuff to go from sector processor to muxer 
    signal region_eta_load : std_logic_vector(3*N_SECTORS-1 downto 0);
    signal region_eta_in   : particles(3*N_OBJ_SECTOR_ETA*N_SECTORS-1 downto 0);
    signal region_eta_load_delayed : std_logic_vector(3*N_SECTORS-1 downto 0);
    ----- stuff to go from muxer to sorter
    signal mux_valid:   std_logic; 
    signal mux_go:      std_logic; -- use to send outputs at half frequency
    signal mux_sector1 : particles(N_OBJ_SECTOR_ETA -1 downto 0);
    signal mux_sector2 : particles(N_OBJ_SECTOR_ETA -1 downto 0);
    signal mux_sector3 : particles(N_OBJ_SECTOR_ETA -1 downto 0);
begin

    generate_sorters: for i in N_SECTORS-1 downto 0 generate
    
        sort1 : entity work.sector_processor
            generic map(N_OBJ_SECTOR => N_OBJ_SECTOR, N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA, 
	            MAX_COUNT => N_FIBERS_SECTOR*N_IN_CLOCK, 
	            etaMin => to_etaphi(-342), 
	            etaMax => to_etaphi(-57), 
	            etaShift => to_etaphi(171), 
	            SECTOR_NUMBER => i )
            port map(clk => clk, rst => rst, 
            
				first_in => first_in(i), 
				last_in => last_in(i), 
				read_in => read_in(i),
				data_in => links_in(i), 
             
                      
                     data_out => region_eta_in((i+1)*N_OBJ_SECTOR_ETA-1 downto 
                     	(i)*N_OBJ_SECTOR_ETA), 
                     valid_out => region_eta_load(i));
                                          
        sort2 : entity work.sector_processor
            generic map(N_OBJ_SECTOR => N_OBJ_SECTOR, N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA,
	             MAX_COUNT => N_FIBERS_SECTOR*N_IN_CLOCK, 
	             etaMin => to_etaphi(-171), 
	             etaMax => to_etaphi(+171), 
	             etaShift => to_etaphi(0), 
	             SECTOR_NUMBER => i )
            port map(clk => clk, rst => rst, 
            
            	first_in => first_in(i), 
            	last_in => last_in(i), 
            	read_in => read_in(i), 
            	data_in => links_in(i), 
            	
                      data_out => region_eta_in((i+N_SECTORS+1)*N_OBJ_SECTOR_ETA-1 downto 
                      	(i+N_SECTORS)*N_OBJ_SECTOR_ETA), 
                      valid_out => region_eta_load(i+N_SECTORS));
                      
                      
        sort3 : entity work.sector_processor
            generic map(N_OBJ_SECTOR => N_OBJ_SECTOR, N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA, 
	            MAX_COUNT => N_FIBERS_SECTOR*N_IN_CLOCK, 
	            etaMin => to_etaphi(+57), 
	            etaMax => to_etaphi(+342), 
	            etaShift => to_etaphi(-171), 
	            SECTOR_NUMBER => i )
            port map(clk => clk, rst => rst, 
            
	            first_in => first_in(i), 
	            last_in => last_in(i), 
	            read_in => read_in(i), 
	            data_in => links_in(i), 
	            
                      data_out => region_eta_in((i+2*N_SECTORS+1)*N_OBJ_SECTOR_ETA-1 downto 
                      	(i+2*N_SECTORS)*N_OBJ_SECTOR_ETA), 
                      valid_out => region_eta_load(i+2*N_SECTORS));
                      
    end generate generate_sorters;







    gen_sector_valid_bit_delay: if SECTOR_VALID_BIT_DELAY > 0 generate
        sector_valid_bit_delayer : entity work.delay_line
            generic map(N_BITS => 3*N_SECTORS, DELAY => SECTOR_VALID_BIT_DELAY)
            port map(clk => clk, rst => rst, d => region_eta_load, q => region_eta_load_delayed);
        assert SECTOR_VALID_BIT_DELAY + N_OBJ_SECTOR*2/N_FIBERS_SECTOR + (N_FIBERS_SECTOR-1) < N_CLOCK 
            report "Too long delay on the sector valid bit, data will be corrupted by incoming frames"
            severity failure;
    end generate;
    
    gen_sector_valid_bit_nodelay: if SECTOR_VALID_BIT_DELAY = 0 generate
        region_eta_load_delayed <= region_eta_load;
    end generate;
    
    
    

    mux: entity work.trisector_muxer
            generic map(N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA)
            port map(clk => clk, rst => rst, 
            
            	region_eta_load => region_eta_load_delayed, 
            	region_eta_in => region_eta_in,
            	
                     out_valid => mux_valid, 
                     out_go => mux_go,
                     out_sector1 => mux_sector1, 
                     out_sector2 => mux_sector2, 
                     out_sector3 => mux_sector3); 
                     

    merger : entity work.pipelined_merger
            generic map(N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA, N_OBJ => N_OBJ)
            port map(clk => clk, rst => rst, 
            
            	valid_in => mux_valid, 
            	go => mux_go,             	
                     list1_in => mux_sector1, 
                     list2_in => mux_sector2, 
                     list3_in => mux_sector3,
                     
                     list_out => links_out, 
                     valid_out => valid_out);

end Behavioral;
        

