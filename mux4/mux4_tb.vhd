--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:18:19 03/23/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/mux4/mux4_tb.vhd
-- Project Name:  mux4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux4
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
 
ENTITY mux4_tb IS
END mux4_tb;
 
ARCHITECTURE behavior OF mux4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT mux4
    PORT(
         a,b,c,d: IN  std_logic;
         sel : 	IN  std_logic_vector(1 downto 0);
         p_out : 	OUT  std_logic
        );
    END COMPONENT mux4;
    

   --Inputs
   signal a,b,c,d : std_logic := '0';
   signal sel : std_logic_vector(1 downto 0);

 	--Outputs
   signal p_out : std_logic; 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux4 PORT MAP (
          a => a,
          b => b,
          c => c,
          d => d,
          sel => sel,
          p_out => p_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
	wait for 10ns;
	a<='1';
	sel <= "00";
	wait for 10ns;
	a<='0';
	b <='1';
	wait for 10ns;
	sel <= "01";
	c <= '1';
	wait for 10ns;
	sel <= "10";
	b <= '0';
	d <= '1';
	wait for 10ns;
	sel <= "11";
	c <= '0';
	a <= '1';
	wait for 10ns;
	sel <= "00";
	wait for 10ns;
	wait;	
   end process;

END;
