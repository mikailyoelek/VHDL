--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:25:10 03/23/2022
-- Design Name:   
-- Module Name:   C:/Users/mikai/Qsync/HTL Rankweil Elektronik/4BHEL/DIC1_WALCHER/VHDL/count_prim/count_prim_tb.vhd
-- Project Name:  count_prim
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: count_prim
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
 
ENTITY count_prim_tb IS
END count_prim_tb;
 
ARCHITECTURE behavior OF count_prim_tb IS 
 
    --Komponentendeklaration für UUT
	 -- Top-Level einbinden
    COMPONENT count_prim
    PORT(
			clk:		IN STD_LOGIC;
			reset:	IN STD_LOGIC;
			count:	OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;
	 
	--Eingangssignale für Zähler
   SIGNAL clock : STD_LOGIC;
   SIGNAL reset : STD_LOGIC;
	
 	--Ausgangssignale für Zähler (Datenbus)
   SIGNAL counter : STD_LOGIC_VECTOR(2 DOWNTO 0);

   -- Taktperiode für Simulation
   CONSTANT clk_period : TIME := 20 ns; --50MHz Takt
BEGIN
 
	-- Instanziierung des UUT
   uut: count_prim 
			PORT MAP (
				clk=>clock,
				reset=>reset,
				count=>counter
        );
		  
   -- Prozess für Takterzeugung
   Takt: PROCESS --Zeitsteuerung über wait-Statements
   BEGIN
		clock <= '0';
		WAIT FOR clk_period/2;
		clock <= '1';
		WAIT FOR clk_period/2; --Prozess startet anschließend von vorne
   END PROCESS Takt;

   -- Prozess für Zählerstimuli:
   stim_proc: process
   begin		
		wait for clk_period;--reset erst nach 1. Taktperiode
		reset <= '1';
      wait for clk_period*2;--reset für 2 Taktperioden aktiv
		reset <= '0';
		wait; --Prozess bleibt hier stehen
   end process;

END behavior;
