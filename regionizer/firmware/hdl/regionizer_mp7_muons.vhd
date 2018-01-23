library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_muons is
    generic(
        N_OBJ_SECTOR : natural;
        N_OBJ_SECTOR_ETA : natural;
        N_OBJ : natural;
        N_FIBERS_OBJ : natural range 1 to 2 := 1;
        MP7_INPUT_DELAY : natural := 0
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        mp7_valid : in std_logic_vector(MU_SECTORS-1 downto 0); -- 1 if words are valid
        mp7_in    : in  words32(MU_SECTORS-1 downto 0); -- input particles 
        mp7_out   : out words32(N_FIBERS_OBJ*N_OBJ-1 downto 0);        -- output particles
        mp7_outv  : out std_logic_vector(N_FIBERS_OBJ*N_OBJ-1 downto 0) -- true if mp7_out contains valid data
    );
end regionizer_mp7_muons;

architecture Behavioral of regionizer_mp7_muons is
    signal mp7_valid_del : std_logic_vector(MU_SECTORS-1 downto 0); -- 1 if words are valid
    signal mp7_in_del    : words32(MU_SECTORS-1 downto 0); -- input particles 
    ----- stuff to go from our initial state to the regionizer input
    signal mu_read_in  : std_logic_vector(MU_SECTORS-1 downto 0); -- whether we're sending data to the regionizer to be read 
    signal mu_links_in : particles(MU_SECTORS-1 downto 0); -- input particles for the regionizer
    signal mu_first_in: std_logic_vector(MU_SECTORS-1 downto 0);   -- counter in sync with input particles for the regionizer
    signal mu_last_in: std_logic_vector(MU_SECTORS-1 downto 0);   -- counter in sync with input particles for the regionizer
    ---
    signal read_in  : std_logic_vector(N_SECTORS-1 downto 0); -- whether we're sending data to the regionizer to be read 
    signal links_in : particles(N_SECTORS-1 downto 0); -- input particles for the regionizer
    signal first_in: std_logic_vector(N_SECTORS-1 downto 0);   -- counter in sync with input particles for the regionizer
    signal last_in: std_logic_vector(N_SECTORS-1 downto 0);   -- counter in sync with input particles for the regionizer
    ----- stuff to go from sector processor to muxer 
    signal region_eta_load : std_logic_vector(3*N_SECTORS-1 downto 0);
    signal region_eta_in   : particles(3*N_OBJ_SECTOR_ETA*N_SECTORS-1 downto 0);
    ----- stuff to go from muxer to sorter
    signal mux_valid:   std_logic; 
    signal mux_go:      std_logic; -- use to send outputs at half frequency
    signal mux_sector1 : particles(N_OBJ_SECTOR_ETA -1 downto 0);
    signal mux_sector2 : particles(N_OBJ_SECTOR_ETA -1 downto 0);
    signal mux_sector3 : particles(N_OBJ_SECTOR_ETA -1 downto 0);
    ----- stuff to go from out process input to our output ports
    signal links_out   : particles(N_OBJ-1 downto 0); -- input particles for the regionizer
    signal links_out_valid : std_logic; -- valid output from the regionizer
begin
    generate_splitters: for i in MU_SECTORS-1 downto 0 generate
        maybe_input_nodelay: if MP7_INPUT_DELAY = 0 generate
            mp7_in_del(i) <= mp7_in(i);
            mp7_valid_del(i) <= mp7_valid(i);
        end generate;

        maybe_input_shortdelay: if MP7_INPUT_DELAY > 0 and MP7_INPUT_DELAY <= 5 generate
            short_input_delay: entity work.delay_line
                generic map(DELAY => MP7_INPUT_DELAY, N_BITS => 33)
                port map(clk => clk, rst => rst, 
                                d(31 downto 0) => mp7_in(i)(31 downto 0), d(32) => mp7_valid(i), 
                                q(31 downto 0) => mp7_in_del(i)(31 downto 0), q(32) => mp7_valid_del(i));
        end generate;

        maybe_input_longdelay: if MP7_INPUT_DELAY > 5 generate
            long_input_delay: entity work.bram_delay
                generic map(DELAY => MP7_INPUT_DELAY, N_BITS => 33)
                port map(clk => clk, rst => rst, 
                         d(31 downto 0) => mp7_in    (i)(31 downto 0), d(32) => mp7_valid    (i),
                         q(31 downto 0) => mp7_in_del(i)(31 downto 0), q(32) => mp7_valid_del(i)); 
        end generate;
            
        input_decoder: entity work.regionizer_mp7_decoder
            generic map(N_OBJ_SECTOR => N_OBJ_SECTOR)
            port map(clk => clk, rst => rst, mp7_valid => mp7_valid_del(i), mp7_in => mp7_in_del(i), 
                     read_out => mu_read_in(i), links_out => mu_links_in(i), first_out => mu_first_in(i), last_out => mu_last_in(i));

        threeway_splitter: entity work.phi_splitter
            port map(clk => clk,  
                     read_in => mu_read_in(i), data_in => mu_links_in(i), first_in => mu_first_in(i), last_in => mu_last_in(i),
                     read_out => read_in(3*(i+1)-1 downto 3*i), data_out => links_in(3*(i+1)-1 downto 3*i), first_out => first_in(3*(i+1)-1 downto 3*i), last_out => last_in(3*(i+1)-1 downto 3*i));
            
    end generate;

    regionizer_pipelined: entity work.regionizer_mp7_pipelined
            generic map(
                N_OBJ_SECTOR => N_OBJ_SECTOR,
                N_OBJ_SECTOR_ETA => N_OBJ_SECTOR_ETA,
                N_OBJ => N_OBJ,
                N_FIBERS_SECTOR => 1,
                SECTOR_VALID_BIT_DELAY => 0)
            port map(
                clk => clk, rst => rst,
                links_in => links_in, read_in => read_in, first_in => first_in, last_in => last_in,
                links_out => links_out, valid_out => links_out_valid);

    encoder_output_2f : if N_FIBERS_OBJ = 2 generate
      encode_output: entity work.regionizer_mp7_encoder
          generic map(N_OBJ => N_OBJ)
          port map(clk => clk, rst => rst, particles_in => links_out, particles_valid => links_out_valid, mp7_out => mp7_out, mp7_outv => mp7_outv);
    end generate encoder_output_2f;

    encoder_output_1f : if N_FIBERS_OBJ = 1 generate
      encode_output: entity work.regionizer_mp7_encoder_twoframes
          generic map(N_OBJ => N_OBJ)
          port map(clk => clk, rst => rst, particles_in => links_out, particles_valid => links_out_valid, mp7_out => mp7_out, mp7_outv => mp7_outv);
    end generate encoder_output_1f;

end Behavioral;
        

