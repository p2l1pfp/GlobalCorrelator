library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pftm_data_types.all;
use work.pftm_constants.all;

entity regionizer_mp7_decoder_twofibers is
    generic(
        N_OBJ_SECTOR : natural
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        mp7_valid : in std_logic_vector(1 downto 0); -- 1 if words are valid (we assume it's the same for all of them)
        mp7_in    : in  words32(1 downto 0); -- input words 
        read_out   : out std_logic;                       -- whether we're sending data to the regionizer to be read 
        links_out  : out particle; -- input particles for the regionizer
        first_out  : out std_logic; -- true if this is the first particle in output
        last_out   : out std_logic  -- true if this is the last particle in output
    );
end regionizer_mp7_decoder_twofibers;

architecture Behavioral of regionizer_mp7_decoder_twofibers is
    --- stuff for our decoding of the inputs from the ports
    signal valid_in  : std_logic;                         -- whether I had an input valid frame before this
    signal read_in   : std_logic;                         -- whether I had an input valid frame before this
    signal in_odd    : std_logic;                         -- on-off switch do define which particle to give to the sorters
    signal in_buffer   : words32(1 downto 0); -- buffers of input data (we need two words to make one particle)
    signal link_buffer : particle; -- particles to delay by one clock
    ----- stuff to go from our initial state to the regionizer input
    signal is_first   : std_logic;
    signal is_new_train : std_logic;
begin
    timer_nclock : entity work.egg_timer
        generic map (N_COUNT => N_CLOCK-1) -- one clock delay is in the logic of this module (is_first is asserted one tick later than the real start) 
        port map (clk => clk, start => is_first, go => '1', done => is_new_train);
    timer_nobj : entity work.egg_timer
        generic map (N_COUNT => N_OBJ_SECTOR)
        port map (clk => clk, start => is_first, go => '1', done => last_out);

    process_input: process(clk,rst)
    begin
        if rst = '1' then
            valid_in <= '0';
            read_in <= '0';
            in_odd <= '0';
            is_first <= '0';
        elsif rising_edge(clk) then
            if valid_in = '0' and mp7_valid(0) = '1' then
                in_buffer <= mp7_in;
                valid_in <= '1';
                read_in <= '0';
                in_odd <= '0';
                is_first <= '0';
            elsif mp7_valid(0) = '1' then
                if in_odd = '0' then -- second frame of any wagon
                    if read_in = '0' then -- second frame of the first wagon
                        is_first   <= '1';
                    else
                        is_first <= is_new_train;
                    end if;
                    links_out   <= to_particle(mp7_in(0), in_buffer(0));
                    link_buffer <= to_particle(mp7_in(1), in_buffer(1));
                    in_odd <= '1';
                    read_in <= '1';
                elsif in_odd = '1' then -- first frame of the N+1 wagon
                    in_buffer <= mp7_in;
                    links_out <= link_buffer;
                    is_first <= is_new_train;
                    in_odd <= '0';
                    read_in <= '1';
                end if;
            else 
                if in_odd = '1' then 
                    links_out <= link_buffer;
                    read_in <= '1';
                else
                    read_in <= '0';
                end if;
                is_first <= '0';
                in_odd <= '0';
                valid_in <= '0';
            end if;
        end if;
    end process;

    read_out    <= read_in;
    first_out <= is_first;
end Behavioral;
        

