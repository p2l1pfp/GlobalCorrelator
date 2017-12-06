-- top_decl
--
-- Defines constants for the whole device
--
-- Dave Newbold, June 2014

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.mp7_top_decl.all;

package top_decl is

  constant ALGO_REV: std_logic_vector(31 downto 0) := X"00" & X"00" & X"00" & X"00" ; -- Mayor, minor, "very minor" and patch level;
  constant LHC_BUNCH_COUNT: integer := 3564;
  constant LB_ADDR_WIDTH: integer := 10;
  constant DR_ADDR_WIDTH: integer := 9;
  constant RO_CHUNKS: integer := 1;
  constant CLOCK_RATIO: integer := 6;
  constant CLOCK_AUX_RATIO: clock_ratio_array_t := (1, 2, 6); -- Producing 40 MHz, 80 MHz, and 240 MHz clocks.
  constant PAYLOAD_LATENCY: integer := 2;
  constant DAQ_N_BANKS: integer := 4;
  constant DAQ_TRIGGER_MODES: integer := 1;
  constant DAQ_N_CAP_CTRLS: integer := 1; -- Number of capture controls per trigger mode
  constant ZS_ENABLED: boolean := FALSE;

  constant REGION_CONF: region_conf_array_t := (
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 3, 10), -- 0 / 118
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 3, 10), -- 1 / 117*
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 3, 10), -- 2 / 116
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 4, 11), -- 3 / 115
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 4, 11), -- 4 / 114*
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 4, 11), -- 5 / 113
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 5, 12), -- 6 / 112
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 5, 12), -- 7 / 111*
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 5, 12), -- 8 / 110
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 0, 7), -- 9 / 210
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 0, 7), -- 10 / 211*
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 0, 7), -- 11 / 212
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 1, 8), -- 12 / 213
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 1, 8), -- 13 / 214*
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 1, 8), -- 14 / 215
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 2, 9), -- 15 / 216
    (no_mgt, u_crc32, buf, no_fmt, buf, u_crc32, no_mgt, 2, 9), -- 16 / 217*
    (gth_10g, u_crc32, buf, no_fmt, buf, u_crc32, gth_10g, 2, 9) -- 17 / 218
  );

end top_decl;
