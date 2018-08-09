library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_others is
    generic(
        N_OBJ_SECTOR : natural;
        N_OBJ_SECTOR_ETA : natural;
        N_OBJ : natural;
        N_FIBERS_SECTOR : natural range 1 to 2 := 1;
        N_FIBERS_OBJ : natural range 1 to 2 := 2;
        SECTOR_VALID_BIT_DELAY : natural := 0
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        mp7_valid : in std_logic_vector(N_FIBERS_SECTOR*N_SECTORS-1 downto 0); -- 1 if words are valid
        mp7_in    : in  words32(N_FIBERS_SECTOR*N_SECTORS-1 downto 0); -- input particles 
        mp7_out   : out words32(N_FIBERS_OBJ*N_OBJ-1 downto 0);        -- output particles
        mp7_outv  : out std_logic_vector(N_FIBERS_OBJ*N_OBJ-1 downto 0) -- true if mp7_out contains valid data
    );
end regionizer_mp7_others;

architecture Behavioral of regionizer_mp7_others is
    ----- stuff to go from our initial state to the regionizer input
    signal read_in  : std_logic_vector(N_SECTORS-1 downto 0); -- whether we're sending data to the regionizer to be read 
    signal links_in : particles(N_SECTORS-1 downto 0); -- input particles for the regionizer
    signal first_in: std_logic_vector(N_SECTORS-1 downto 0);  -- true if this is the first particle in output
    signal last_in: std_logic_vector(N_SECTORS-1 downto 0);   -- true if this is the last particle in output
    ----- stuff to go from out process input to our output ports
    signal links_out   : particles(N_OBJ-1 downto 0); -- input particles for the regionizer
    signal links_out_valid : std_logic; -- valid output from the regionizer
begin

	
    generate_decoders: for i in N_SECTORS-1 downto 0 generate
        
        --if 1 fiber input 
        input_decoder_1f: if N_FIBERS_SECTOR = 1 generate
            input_decoder: entity work.regionizer_mp7_decoder
                generic map(N_OBJ_SECTOR => N_OBJ_SECTOR)
                port map(clk => clk, rst => rst, 
                
		                mp7_valid => mp7_valid(i), 
		                mp7_in => mp7_in(i), 
		                
                         read_out => read_in(i), 
                         links_out => links_in(i), 
                         first_out => first_in(i), 
                         last_out => last_in(i));
        end generate input_decoder_1f;

		--if 2 fiber input 
        input_decoder_2f: if N_FIBERS_SECTOR = 2 generate
            input_decoder: entity work.regionizer_mp7_decoder_twofibers
                generic map(N_OBJ_SECTOR => N_OBJ_SECTOR)
                port map(clk => clk, rst => rst, 
                
                		mp7_valid => mp7_valid(2*i+1 downto 2*i), 
                		mp7_in => mp7_in(2*i+1 downto 2*i), 
                		
                         read_out => read_in(i), 
                         links_out => links_in(i), 
                         first_out => first_in(i), 
                         last_out => last_in(i));
        end generate input_decoder_2f;
    end generate generate_decoders;
    
    

    regionizer_pipelined: entity work.regionizer_mp7_pipelined
            generic map(
                N_OBJ_SECTOR => N_OBJ_SECTOR,
                N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA,
                N_OBJ => N_OBJ,
                N_FIBERS_SECTOR => N_FIBERS_SECTOR,
                SECTOR_VALID_BIT_DELAY => SECTOR_VALID_BIT_DELAY)
            port map(
                clk => clk, rst => rst,
                links_in => links_in, read_in => read_in, first_in => first_in, last_in => last_in,
                links_out => links_out, valid_out => links_out_valid);





	--if 1 fiber per output object 
    encoder_output_1f : if N_FIBERS_OBJ = 1 generate
      encode_output: entity work.regionizer_mp7_encoder_twoframes
          generic map(N_OBJ => N_OBJ)
          port map(clk => clk, rst => rst, 
          particles_in => links_out, particles_valid => links_out_valid, 
          mp7_out => mp7_out, mp7_outv => mp7_outv);
    end generate encoder_output_1f;
    
    --if 2 fiber per output object 
    encoder_output_2f : if N_FIBERS_OBJ = 2 generate
      encode_output: entity work.regionizer_mp7_encoder
          generic map(N_OBJ => N_OBJ)
          port map(clk => clk, rst => rst, 
          particles_in => links_out, particles_valid => links_out_valid, 
          mp7_out => mp7_out, mp7_outv => mp7_outv);
    end generate encoder_output_2f;


end Behavioral;
        

