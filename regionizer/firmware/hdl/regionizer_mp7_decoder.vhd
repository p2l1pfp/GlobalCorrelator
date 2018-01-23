library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_decoder is
    generic(
        N_OBJ_SECTOR : natural
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        mp7_valid : in std_logic; -- 1 if words are valid (we assume it's the same for all of them)
        mp7_in    : in  word32; -- input words 
        read_out   : out std_logic;                       -- whether we're sending data to the regionizer to be read 
        links_out  : out particle; -- input particles for the regionizer
        first_out  : out std_logic; -- true if this is the first particle in output
        last_out   : out std_logic  -- true if this is the last particle in output
    );
end regionizer_mp7_decoder;

architecture Behavioral of regionizer_mp7_decoder is
    --- stuff for our decoding of the inputs from the ports
    signal valid_in  : std_logic;                     -- whether I had an input valid frame before this
    signal read_in   : std_logic;                     -- whether I had an input valid frame before this
    signal in_buffer : word32; -- buffers of input data (we need two words to make one particle)
    ----- stuff to go from our initial state to the regionizer input
    signal is_first   : std_logic;
    signal is_last   : std_logic;
    signal timer_tick : std_logic;
    signal is_new_train : std_logic;
    signal is_last_obj : std_logic;
begin
    timer_nclock : entity work.egg_timer
        generic map (N_COUNT => N_IN_CLOCK)
        port map (clk => clk, start => is_first, go => timer_tick, done => is_new_train);
    timer_nobj : entity work.egg_timer
        generic map (N_COUNT => N_OBJ_SECTOR)
        port map (clk => clk, start => is_first, go => timer_tick, done => is_last_obj);


    process_input: process(clk,rst)
    begin
        if rst = '1' then
            valid_in <= '0';
            read_in <= '0';
            is_first <= '0';
            is_last  <= '0';
            timer_tick <= '1';
        elsif rising_edge(clk) then
            if valid_in = '0' and mp7_valid = '1' then
                in_buffer <= mp7_in;
                valid_in <= '1';
                read_in <= '0';
                is_first   <= '1';
                timer_tick <= '1';
            elsif mp7_valid = '1' then
                if read_in = '1' then -- first frame of the N+1'th wagon: just refill buffer and increase counter
                    read_in <= '0';
                    in_buffer <= mp7_in;
                    is_first <= is_new_train;
                    timer_tick <= '1';
                else
                    read_in <= '1';
                    links_out <= to_particle(mp7_in, in_buffer);
                    is_first   <= is_first;
                    timer_tick <= '0';
                end if;
            else 
                read_in <= '0';
                valid_in <= '0';
                is_first   <= '0';
                timer_tick <= '1';
            end if;
            is_last <= is_last_obj;
        end if;
    end process;

    read_out    <= read_in;
    first_out <= is_first;
    last_out <= is_last;
end Behavioral;
        

