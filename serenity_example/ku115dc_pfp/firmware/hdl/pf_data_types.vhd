library ieee;
use ieee.std_logic_1164.all;

package pf_data_types is

  type pf_data is array (natural range <>) of std_logic_vector(31 downto 0);

  type pf_data_array is array (natural range <>) of pf_data;
  
end;
      
