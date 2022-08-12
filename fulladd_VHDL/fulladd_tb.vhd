--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:57:39 03/04/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/fulladd_VHDL/fulladd_tb.vhd
-- Project Name:  fulladd_VHDL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fulladd
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
 
ENTITY fulladd_tb IS
END fulladd_tb;
 
ARCHITECTURE behavior OF fulladd_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fulladd
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         Cin : IN  std_logic;
         SUM : OUT  std_logic;
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal Cin : std_logic := '0';

 	--Outputs
   signal SUM : std_logic;
   signal Cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fulladd PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          SUM => SUM,
          Cout => Cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
		Cin <= '0'; A <= '0'; B <= '0';
		WAIT for 1ms;
		Cin <= '0'; A <= '0'; B <= '1';
		WAIT for 1ms;
		Cin <= '0'; A <= '1'; B <= '0';
		WAIT for 1ms;
		Cin <= '0'; A <= '1'; B <= '1';
		WAIT for 1ms;
		Cin <= '1'; A <= '0'; B <= '0';
		WAIT for 1ms;
		Cin <= '1'; A <= '0'; B <= '1';
		WAIT for 1ms;
		Cin <= '1'; A <= '1'; B <= '0';
		WAIT for 1ms;
		Cin <= '1'; A <= '1'; B <= '1';
      WAIT; -- will wait forever
      wait;
   end process;

END;
