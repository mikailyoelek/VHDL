--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:37:51 05/12/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/Taster/Taster_tb.vhd
-- Project Name:  Taster
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Taster
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
USE IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Taster_tb IS
END Taster_tb;
 
ARCHITECTURE behavior OF Taster_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Taster
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         sw_asyn : IN  std_logic;
         count : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic;
   signal clk : std_logic;
   signal sw_asyn : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns; --50MHz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Taster PORT MAP (
          reset => reset,
          clk => clk,
          sw_asyn => sw_asyn,
          count => count
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
      wait for clk_period;	
			reset <= '1';
      wait for clk_period*2;
			reset <= '0';			
      wait;
   end process;
	
	taster_proc: process
	begin
		wait for 155 ns;
			sw_asyn <='1';
		wait for clk_period;
			sw_asyn <='0';
		wait for 100 ns;
			sw_asyn <='1';
		wait for clk_period*2;
			sw_asyn <= '0';
		wait for 45 ns;
			sw_asyn <= '1';
		wait for clk_period*3;
			sw_asyn <= '0';		
	end process;

END;
