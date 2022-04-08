LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY counter_4bit  IS

  PORT ( reset: IN STD_LOGIC;
         clk:   IN STD_LOGIC;
         count: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Datenbus, mehrere Signale, hier: 4 verschiedene Signale
        );
END counter_4bit;

ARCHITECTURE structural OF counter_4bit IS --Beschreibung der Zählerfunktion

  COMPONENT jk_ff --Komponentendekalaration (hier: JK-FF)
  PORT ( reset: IN STD_LOGIC;
         clk:   IN STD_LOGIC;
         J, K:  IN STD_LOGIC;
         Q:     OUT STD_LOGIC
		  );
  END COMPONENT;

  SIGNAL T0,T1,T2,T3,Q0,Q1,Q2,Q3: std_logic; --Signaldeklarationen

BEGIN 

	--kombinatorische Zählerteil:
	
	T0 <= '1'; 
	T1 <= Q0;
	T2 <= T1 AND Q1;
	T3 <= T2 AND Q2;

  --Instanziierung der JK-FFs:

	FF0 : jk_ff port map ( clk=>clk, J=>T0, K=>T0, Q=>Q0, reset=>reset ); --LSB
	FF1 : jk_ff port map ( clk=>clk, J=>T1, K=>T1, Q=>Q1, reset=>reset );
	FF2 : jk_ff port map ( clk=>clk, J=>T2, K=>T2, Q=>Q2, reset=>reset );
	FF3 : jk_ff port map ( clk=>clk, J=>T3, K=>T3, Q=>Q3, reset=>reset ); --MSB
	
	-- mit & werden die tatsächlichen Signale zusammengefasst
	count <= Q3 & Q2 & Q1 & Q0; --Erzeugung eines Datenbusses (MSB->LSB)
										 -- ... und Verbindung mit Zählerausgang

END structural;

