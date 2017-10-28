----------------------------------------------------------------------------------
--
-- Project:   Avnet Speedway - Accelerators
-- Company:   Xilinx
-- Engineer:  WK
-- 
-- Create Date:    12/26/2013 12:16:14 PM
-- Design Name:    Zynq_accelerator_design
-- Module Name:    timer_subsystem - Behavioral
-- Target Devices: Zed, microZed
-- Tool Versions:  2013.3
-- Description:    The timer_subsystem module is designed to capture a free running clock in order to measure timing related
--                 to software events.
--                 This module implements a free-running counter which increments once per clock. This timer value is
--                 simultaneously sent to a "before" and "after" register. The signal "capture_before" causes the current
--                 timer value to be captured by the "before" register on a low-to-high transition. The signal "capture_after" behaves
--                 identically, save that the current timer value is captured to the "after" register.
--                 These register's values can be read by the EMIO-GPIO by asserting the appropriate output enable signal. 
--
-- Interface:      clk               - clock to timer
--                 reset             - resets timer to 0
--                 sw_capture_trig   - on rising edge the current timer value is captured into "before" register
--                                     on falling edige the current timer value is captured into the "after" register
--                                     tied to EMIO - GPIO pin on PS
--                 hw_capture_trig   - on rising edge, the current timer value is captured into "before" register. 
--                                     on falling edge, the current timer value is captured into "after" register
--                                     tied to hardware signal from accelerator
--                 oe_high_or_low    - places either the lower 32 bits of the timer register to the data_out port ('0') or the 
--                                     upper 32 bits of the timer register ('1') on the data_out
--                 data_out          - viewport to the timer register, active when only one of the oe signals is asserted
--                 timer_value       - 64 bit output of the after register, always available
-- 
-- Dependencies: 
-- 
-- Known Issues:
--
-- Revision 0.01 - File Created
--          0.02 - implemented more efficient design simplifing register and control signal usage 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity timer_subsystem is
    port ( clk                : in  std_logic;
           reset              : in  std_logic;
           data_out           : out std_logic_vector (31 downto 0);
           -- hw_sw_trig_sel : in std_logic;                            -- choose hardware or software trigger
           sw_capture_trig    : in  std_logic;
           --hw_capture_trig    : in  std_logic;
           oe_high_or_low     : in  std_logic;
           timer_value        : out std_logic_vector (63 downto 0)           
          );
end entity timer_subsystem;

architecture Behavioral of timer_subsystem is
   begin

      -- 
      -- timer process
      do_timer: process(clk)
            variable last_sw_capture : std_logic := '0';
            variable last_hw_capture : std_logic := '0';
            variable timer_value_register : unsigned(63 downto 0) := (others=>'0');            
         begin
            sync_events: if rising_edge(clk) then
               if (reset = '1') then
                  report "reset asserted!";
               end if;
               reset_check: if ((reset = '1') or
                                ((sw_capture_trig = '1') and (last_sw_capture = '0'))) then
                                --((hw_capture_trig = '1') and (last_hw_capture = '0'))) then
                  report "handling reset";
                  timer_value_register(63 downto 1) := (others=>'0');
                  timer_value_register(0)           := '1';
               --elsif ((sw_capture_trig = '1') or (hw_capture_trig = '1')) then
               elsif (sw_capture_trig = '1') then
                  timer_value_register := timer_value_register + 1;
               else
                  -- hold the timer_value_register static (no increment or reset)
               end if reset_check;
               last_sw_capture := sw_capture_trig;
               --last_hw_capture := hw_capture_trig;
               
               -- manage output
               pick_upper_or_lower: if (oe_high_or_low = '1') then
                  data_out <= std_logic_vector(timer_value_register(63 downto 32));
               else
                  data_out <= std_logic_vector(timer_value_register(31 downto 0));
               end if pick_upper_or_lower;
                              
               -- the always enabled outputs
               timer_value  <= std_logic_vector(timer_value_register);               
               
            end if sync_events;
         end process do_timer;
         
--      --
--      -- manage outputs
--      do_outputs: process(clk)
--            variable output_status : std_logic_vector(3 downto 0) := (others=>'X');
--         begin
--            sync_events: if rising_edge(clk) then
--               pick_upper_or_lower: if (oe_high_or_low = '1') then
--                  data_out <= std_logic_vector(timer_value_register(63 downto 32));
--               else
--                  data_out <= std_logic_vector(timer_value_register(31 downto 0));
--               end if pick_upper_or_lower;
               
--               -- the always enabled outputs
--               timer_value  <= std_logic_vector(timer_value_register);
               
--            end if sync_events;
--         end process do_outputs;     

   end architecture Behavioral;
