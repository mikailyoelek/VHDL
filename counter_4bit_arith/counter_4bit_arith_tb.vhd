LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY counter_4bit_arith_tb IS
END counter_4bit_arith_tb;
 
ARCHITECTURE behavioral OF counter_4bit_arith_tb IS 
 
    --Komponentendeklaration f�r UUT
	 -- Top-Level einbinden
    COMPONENT counter_4bit_arith
    PORT(
         clk:   IN  STD_LOGIC;
         reset: IN  STD_LOGIC;
         count: OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    

   --Eingangssignale f�r Z�hler
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL reset : STD_LOGIC := '0';

 	--Ausgangssignale f�r Z�hler (Datenbus)
   SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);

   -- Taktperiode f�r Simulation
   CONSTANT clk_period : TIME := 20 ns; --50MHz Takt
 
BEGIN
 
	-- Instanziierung des UUT
   uut: counter_4bit_arith 
	     PORT MAP (
          clk => clk,
          reset => reset,
          count => count
        );

   -- Prozess f�r Takterzeugung
   Takt: PROCESS --Zeitsteuerung �ber wait-Statements
   BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2; --Prozess startet anschlie�end von vorne
   END PROCESS Takt;
 

   -- Prozess f�r Z�hlerstimuli:
	Stimuli: PROCESS
   	BEGIN		
     		WAIT FOR clk_period;
			reset <='1'; --reset nach 1.Taktperiode aktivieren
			WAIT FOR clk_period*2; --reset f�r 2 Taktperioden aktiv
			reset <='0';
			WAIT; --Prozess bleibt hier stehen
	END PROCESS Stimuli;

END behavioral;
