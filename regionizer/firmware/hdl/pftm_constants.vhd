library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pftm_constants is
    constant N_LINK : natural := 4;
    constant N_CALO : natural := 20;
    constant N_EMCALO : natural := 15;
    constant N_TRACK : natural := 25;
    constant N_MU : natural := 2;
    constant N_SECTORS : natural := 12;
    constant MU_SECTORS : natural := 4;
    constant N_ETA : natural := 3;
    constant N_PHI : natural := 6;
    constant N_REGIONS : natural := N_ETA*N_PHI;
    constant N_CALO_SECTOR : natural := 15;
    constant N_CALO_SECTOR_ETA : natural := 7;
    constant N_EMCALO_SECTOR : natural := 12;
    constant N_EMCALO_SECTOR_ETA : natural := 7;
    constant N_TRACK_SECTOR : natural := 20;
    constant N_TRACK_SECTOR_ETA : natural := 9;
    constant N_IN_CLOCK : natural := 18;
    constant N_CLOCK : natural := 36;
    constant PHI_SHIFT_SECTOR : natural := 120;
end;

