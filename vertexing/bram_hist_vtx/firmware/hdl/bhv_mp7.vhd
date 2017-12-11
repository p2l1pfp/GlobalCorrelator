library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_constants.all; 
use work.pftm_data_types.all;
use work.bhv_data_types.all;

entity bhv_mp7 is
    port(
        clk : in std_logic;
        rst : in std_logic;
        mp7_valid : in std_logic_vector(BHV_NSECTORS-1 downto 0); 
        mp7_in    : in  words32(BHV_NSECTORS-1 downto 0); 
        mp7_out   : out words32(2*BHV_NSECTORS+2 downto 0);    
        mp7_outv  : out std_logic_vector(2*BHV_NSECTORS+2 downto 0)
    );
end bhv_mp7;

architecture Behavioral of bhv_mp7 is
    type   banks is array(natural range <>) of unsigned(2 downto 0);
    signal read_in  : std_logic_vector(BHV_NSECTORS-1 downto 0);  -- whether we're sending data to the algo 
    signal tracks_in : particles(BHV_NSECTORS-1 downto 0);        -- input tracks 
    signal first_in: std_logic_vector(BHV_NSECTORS-1 downto 0);   -- whether this is the first track of an event 
    signal last_in: std_logic_vector(BHV_NSECTORS-1 downto 0);    
    --
    signal go_in,  first_in_del, hist_new : std_logic_vector(BHV_NSECTORS-1 downto 0);
    signal val_in, hist_h, hist_l : ptsum_arr_t(BHV_NSECTORS-1 downto 0);
    signal bin_in, hist_bin : zbin_arr_t(BHV_NSECTORS-1 downto 0);
    signal hist_bank : banks(BHV_NSECTORS-1 downto 0);
    --
    signal red1_b : zbin_arr_t(5 downto 0);
    signal red2_b : zbin_arr_t(1 downto 0);
    signal red1_l, red1_h : ptsum_wide_arr_t(5 downto 0);
    signal red2_l, red2_h : ptsum_wide_arr_t(1 downto 0);
    signal sum_l, sum_h, out_sum : ptsum_wide_t;
    signal sum_bin, out_bin: zbin_t;
    signal pf_first, out_done : std_logic;
begin
    generate_histos: for i in BHV_NSECTORS-1 downto 0 generate
        input_decoder: entity work.regionizer_mp7_decoder
            generic map(N_OBJ_SECTOR => BHV_NTRACKS)
            port map(clk => clk, rst => rst, mp7_valid => mp7_valid(i), mp7_in => mp7_in(i), 
                     read_out => read_in(i), links_out => tracks_in(i), first_out => first_in(i), last_out => last_in(i));

        track_to_bin: entity work.bhv_track_to_bin
            port map(clk => clk, go => read_in(i), track => tracks_in(i), bin => bin_in(i), val => val_in(i), done => go_in(i));

        delay_first : entity work.delay_line
            generic map(N_BITS => 1, DELAY => 3)
            port map(clk => clk, rst => '0', d(0) => first_in(i), q(0) => first_in_del(i)); 

        core : entity work.bhv_core
            generic map(SECTOR => i)
            port map(clk => clk,
                     go => go_in(i), bin => bin_in(i), val => val_in(i), new_event => first_in_del(i),
                     out_new  => hist_new(i),
                     out_bank => hist_bank(i),
                     out_bin  => hist_bin(i),
                     out_l => hist_l(i),
                     out_h => hist_h(i));
    end generate;

    -- dump out all the debug
    gen_debug: for i in BHV_NSECTORS-1 downto 0 generate
        mp7_outv(2*i+0+3) <= '1';
        mp7_outv(2*i+1+3) <= '1';
        mp7_out(2*i+0+3)(31 downto 27) <= (others => '0');
        mp7_out(2*i+0+3)(26 downto 24) <= std_logic_vector(hist_bank(i));
        mp7_out(2*i+0+3)(23 downto 16) <= (16 => hist_new(i), others => '0');
        mp7_out(2*i+0+3)(15 downto zbin_t'length)  <= (others => '0');
        mp7_out(2*i+0+3)(zbin_t'length-1 downto 0) <= std_logic_vector(hist_bin(i));
        mp7_out(2*i+1+3)(31 downto 25) <= (others => '0');
        mp7_out(2*i+1+3)(24 downto 16) <= std_logic_vector(hist_h(i));
        mp7_out(2*i+1+3)(15 downto  9) <= (others => '0');
        mp7_out(2*i+1+3)( 8 downto  0) <= std_logic_vector(hist_l(i));
    end generate;

    delay_first : entity work.delay_line
            generic map(N_BITS => 1, DELAY => 3)
            port map(clk => clk, rst => '0', d(0) => hist_new(0), q(0) => pf_first); 

    reduce1_24to6 : entity work.bhv_add_reducer
                        generic map(FACTOR => 4, LINES => 6)
                        port map(clk => clk,
                                 in_l => to_wide(hist_l), in_h => to_wide(hist_h), in_b => hist_bin,
                                 out_l => red1_l, out_h => red1_h, out_b => red1_b);

    reduce2_6to2 : entity work.bhv_add_reducer
                        generic map(FACTOR => 3, LINES => 2)
                        port map(clk => clk,
                                 in_l => red1_l, in_h => red1_h, in_b => red1_b,
                                 out_l => red2_l, out_h => red2_h, out_b => red2_b);

    reduce3 : entity work.bhv_add_reducer
                        generic map(FACTOR => 2)
                        port map(clk => clk,
                                 in_l => red2_l, in_h => red2_h, in_b => red2_b,
                                 out_l(0) => sum_l, out_h(0) => sum_h, out_b(0) => sum_bin);

    peak_find: entity work.bhv_peak_finder
                        port map(clk => clk,
                                 in_l => sum_l, in_h => sum_h, in_bin => sum_bin,
                                 new_event => pf_first,
                                 out_done => out_done,
                                 out_bin => out_bin,
                                 out_sum => out_sum);

    mp7_outv <= (others => '1');                                 
    mp7_out(0) <= (0 => out_done, others => '0');
    mp7_out(1)(31 downto 14) <= (others => '0');
    mp7_out(1)(13 downto  0) <= std_logic_vector(out_sum);
    mp7_out(2)(31 downto  7) <= (others => '0');
    mp7_out(2)( 6 downto  0) <= std_logic_vector(out_bin);

end Behavioral;
