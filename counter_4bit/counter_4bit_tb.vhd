LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY counter_4bit_tb IS
END counter_4bit_tb;
 
ARCHITECTURE behavioral OF counter_4bit_tb IS 
 
    --Komponentendeklaration für UUT
	 -- Top-Level einbinden
    COMPONENT counter_4bit
    PORT(
         clk:   IN  STD_LOGIC;
         reset: IN  STD_LOGIC;
         count: OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    

   --Eingangssignale für Zähler
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL reset : STD_LOGIC := '0';

 	--Ausgangssignale für Zähler (Datenbus)
   SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);

   -- Taktperiode für Simulation
   CONSTANT clk_period : TIME := 20 ns; --50MHz Takt
 
BEGIN
 
	-- Instanziierung des UUT
   uut: counter_4bit 
	     PORT MAP (
          clk => clk,
          reset => reset,
          count => count
        );

   -- Prozess für Takterzeugung
   Takt: PROCESS --Zeitsteuerung über wait-Statements
   BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2; --Prozess startet anschließend von vorne
   END PROCESS Takt;
 

   -- Prozess für Zählerstimuli:
	Stimuli: PROCESS
   	BEGIN		
     		WAIT FOR clk_period;
			reset <='1'; --reset nach 1.Taktperiode aktivieren
			WAIT FOR clk_period*2; --reset für 2 Taktperioden aktiv
			reset <='0';
			WAIT; --Prozess bleibt hier stehen
	END PROCESS Stimuli;

END behavioral;
