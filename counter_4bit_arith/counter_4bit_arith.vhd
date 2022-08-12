LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL; -- Datentypen signed und unsigned
								  -- arithemtische Operationen

ENTITY counter_4bit_arith  IS

  PORT ( reset: IN STD_LOGIC;
         clk:   IN STD_LOGIC;
         count: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Datenbus, mehrere Signale, hier: 4 verschiedene Signale
        );
END counter_4bit_arith;

ARCHITECTURE rtl OF counter_4bit_arith IS --Beschreibung der Z�hlerfunktion

--Signaldeklarationen:
SIGNAL q_int: unsigned(3 DOWNTO 0); -- interner Bus, Datentyp unsigned
												 -- (wegen arithmetischer Operation "+" bzw. "-"
								--ACHTUNG: Signalzustand von "q_int" zu Beginn nicht definiert
BEGIN 

	CNT: PROCESS (clk, reset)	--Prozess wird bei �nderung des Zustandes der
										-- Signale "clk" bzw. "reset" neu gestartet
		BEGIN
			IF reset='1' THEN	--asynchroner reset?
				--q_int <= (others=>'0');	--r�cksetzen des Z�hlerstandes
				q_int <= (others=>'1');	--r�cksetzen des Z�hlerstandes f�r "-"
			ELSIF clk='1' AND clk'event THEN	--steigende Taktflanke?
				--q_int <= q_int + 1;	--Z�hlerstand inkrementieren (Addition mit �berlauf)
				q_int <= q_int - 1;	--Z�hlerstand inkrementieren (Subtraktion mit �berlauf)
			END IF;
		END PROCESS CNT;
		
		count <= STD_LOGIC_VECTOR(q_int);	--Ausgangszuweisung mit Typcasting
		
END rtl;

