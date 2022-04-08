--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:50:31 03/23/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/count_prim_RT/count_prim_RT_tb.vhd
-- Project Name:  count_prim_RT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: count_prim_RT
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
 
ENTITY count_prim_RT_tb IS
END count_prim_RT_tb;
 
ARCHITECTURE behavior OF count_prim_RT_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT count_prim_RT
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         count : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    
	 
	--Eingangssignale für Zähler
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
	
 	--Ausgangssignale für Zähler (Datenbus)
   signal count : std_logic_vector(2 downto 0);

   -- Taktperiode für Simulation
   constant clk_period : time := 20 ns;
 
BEGIN
  
	-- Instanziierung des UUT
   uut: count_prim_RT PORT MAP (
          clk => clk,
          reset => reset,
          count => count
        );
		  
   -- Prozess für Takterzeugung
   Takt :process --Zeitsteuerung über wait-Statements
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
   -- Prozess für Zählerstimuli:
   stim_proc: process
   begin		
		wait for clk_period;--reset erst nach 1. Taktperiode
		reset <= '1';
      wait for clk_period*2;--reset für 2 Taktperioden aktiv
		reset <= '0';
		wait for clk_period*13;-- nach 13 Taktperioden noch ein Reset auslösen
		reset <= '1';
		wait for clk_period*2;--reset für 2 Taktperioden aktiv
		reset <= '0';
		wait; --Prozess bleibt hier stehen
   end process;

END behavior;
