library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pftm_constants is
    constant N_LINK : natural := 4;
    constant N_OBJ : natural := 20;
    constant N_SECTORS : natural := 12;
    constant N_ETA : natural := 3;
    constant N_PHI : natural := 6;
    constant N_REGIONS : natural := N_ETA*N_PHI;
    constant N_OBJ_SECTOR : natural := 15;
    constant N_OBJ_SECTOR_ETA : natural := 8;
    constant N_IN_CLOCK : natural := 18;
    constant N_CLOCK : natural := 36;
    constant PHI_SHIFT_SECTOR : natural := 120;
end;

