--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:14:10 03/25/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/clock_divider/clock_divider_tb.vhd
-- Project Name:  clock_divider
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clock_divider
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY clock_divider_tb IS
END clock_divider_tb;
 
ARCHITECTURE behavior OF clock_divider_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_divider
	 GENERIC (T_FAKTOR: integer
	 );
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         enable : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal enable : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns; --50MHz Masterclock
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_divider 
			GENERIC MAP ( T_FAKTOR => 5) -- Teilungsfaktor 5 für Simulation
			PORT MAP (
          clk => clk,
          reset => reset,
          enable => enable
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
		wait for clk_period*2;
		reset <= '0';
      wait;
   end process;

END;
