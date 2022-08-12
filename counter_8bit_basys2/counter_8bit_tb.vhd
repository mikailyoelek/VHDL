--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:29:28 03/29/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/counter_8bit_basys2/counter_8bit_tb.vhd
-- Project Name:  counter_8bit_basys2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter_8bit
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
 
ENTITY counter_8bit_tb IS
END counter_8bit_tb;
 
ARCHITECTURE behavior OF counter_8bit_tb IS 
 
	constant DATA_WIDTH : integer := 4; --Konstante, um Datenbreite 
													--auf Generic und interne Signale anzuwenden
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter_8bit
	 GENERIC (T_FAKTOR: integer;
				 DATA_WIDTH: integer
	 );
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         count : OUT  std_logic_vector(DATA_WIDTH-1 downto 0)
    );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(DATA_WIDTH-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns; -- Taktfrequenz = 50 MHz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter_8bit 
		GENERIC MAP (
			 T_FAKTOR => 3, --Teilungsfaktor für Simulation
			 DATA_WIDTH => DATA_WIDTH --Datenbreite = 4 Bit
		) 
		PORT MAP (
          reset => reset,
          clk => clk,
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
		reset <= '1'; -- asynchroner Reset		
      wait for clk_period*3;
		reset <= '0';
		wait for 240ns;
		reset <= '1';
		wait for clk_period*3;
		reset <= '0';
      wait;
   end process;

END;
