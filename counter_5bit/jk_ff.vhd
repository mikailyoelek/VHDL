LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY jk_ff IS

PORT ( reset: IN STD_LOGIC;
       clk:   IN STD_LOGIC;
       J, K:  IN STD_LOGIC;
       Q:     OUT STD_LOGIC
	   );

END jk_ff;

--architecture of entity

ARCHITECTURE Behavioral OF jk_ff IS

--signal declaration.

SIGNAL qtemp : std_logic; --internes FF-Signal
                          --Zustand zu Beginn uninitialisiert

BEGIN
	-- synchrones System
	PROCESS(clk,reset)
	BEGIN
		IF(reset = '1') THEN           --asynchroner Reset aktiv 1
   		qtemp <= '0';
			
	   -- rising edge ist Funktion in STD_LOGIC...
		ELSIF( rising_edge(clk) ) THEN  --Triggerung mit steigender Taktflanke
		  
		  IF(J='0' AND K='0') THEN     --keine Änderung
          NULL;
		  ELSIF(J='0' AND K='1') THEN  --Ausgang löschen
          qtemp <= '0';
        ELSIF(J='1' AND K='0') THEN  --Ausgang setzen
          qtemp <= '1';
        ELSE                         --Ausgang toggeln
          qtemp <= NOT qtemp;
        END IF;
		
		END IF;
	
	END PROCESS;

	Q <= qtemp; --internes Zählersignal auf Ausgang schalten

END Behavioral;

