-- 
-- Engineers: R. Cavanaugh, R. Rivera, L. Uplegger, B. Kreis							  
--
library ieee;
use ieee.std_logic_1164.all;

use std.textio.all;
use work.txt_util.all;
 
 
entity FILE_READ is
  generic (
  	stim_file:      string  := "sim_energy_table.dat"; 
  	BIT_WIDTH:		integer := 5
          );
  port(
       CLK              : in  std_logic;
       RST              : in  std_logic;
       Y                : out std_logic_vector(BIT_WIDTH-1 downto 0);
       EOG              : out std_logic
      );
end FILE_READ;

 
-- I/O Dictionary
--
-- Inputs:
--
-- CLK:              new cell needed
-- RST:              reset signal, wait with reading till reset seq complete
--   
-- Outputs:
--
-- Y:                Output vector
-- EOG:              End Of Generation, all lines have been read from the file
--
   
   
architecture read_from_file of FILE_READ is
  
  
    file stimulus: TEXT open read_mode is stim_file; 
	
	signal Y_sig : std_logic_vector(BIT_WIDTH-1 downto 0) := (others => '0');
	

begin
	
	Y <= Y_sig;
									   
	-- read data and control information from a file
	
	receive_data: process
									  
		--variable s: string(y'range);
	    --variable s: string(1 to 8);
	    variable s: string(1 to BIT_WIDTH);
	   
	begin                                       
	
		EOG <= '0';
		
		-- wait for Reset to complete
		wait until RST='1';
		wait until RST='0';				  
		while not endfile(stimulus) loop
		
			-- read digital data from input file  	 
			str_read(stimulus,s);		
			Y_sig <= hex_to_std_logic_vector(s);	
			wait until CLK = '1';
		
		end loop;
															   
		EOG <= '1';				  
		wait;
	
	 end process receive_data;			

end read_from_file;
 
