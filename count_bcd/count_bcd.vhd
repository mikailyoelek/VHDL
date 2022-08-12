----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:21:50 04/08/2022 
-- Design Name: 
-- Module Name:    count_7seg_basys2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Datentypen signed und unsigned
								  -- arithemtische Operationen

entity count_bcd is
    Port ( clk : in  STD_LOGIC; -- Systemtakt
           reset : in  STD_LOGIC; -- asynchroner Reset
           count : out  STD_LOGIC_VECTOR (7 downto 0); -- Zählerstatus, 8Bit Datenbreite
           seg : out  STD_LOGIC_VECTOR (6 downto 0); -- Zeichencode für 7-Seg. Anzeige
           dp : out  STD_LOGIC;	-- Status Dezimalpunkt
           an : out  STD_LOGIC_VECTOR (3 downto 0)-- Aktivierungssignal 7-Seg. Elemente
	); 
end count_bcd;

architecture Behavioral of count_bcd is

	constant DATA_WIDTH: integer:=8;
	
	
	-- Zähler --
	component counter -- Counter Komponenten-Deklaration
		generic (
			T_FAKTOR: integer;
			DATA_WIDTH: integer;
			Q_MAX: integer
		);
		port( clk, reset: IN std_logic;
				count:		OUT std_logic_vector (DATA_WIDTH-1 downto 0) 
		);
	end component;
	
	-- 7-Seg-Anzeige--
	component hex7seg -- 7-Seg.-Anzeige Komponenten-Deklaration
    port ( symb : in  STD_LOGIC_VECTOR (3 downto 0);
           a_to_g : out  STD_LOGIC_VECTOR (6 downto 0)
		);
	end component;
	
	-- interne Signale
	signal count_int : std_logic_vector(DATA_WIDTH-1 downto 0);	--internes Signal für Multiplexer-Eingang (8Bit Daten)
	--signal cntr_7seg : std_logic_vector(0 downto 0); 				--internes Signal für Multiplexer-Eingang (Selektieren von Anzeige) bis III
	signal digit	  : std_logic_vector(3 downto 0);				--internes Signal zum Dekodieren der 8Bit Daten (jeweils 4Bit "Pakete")
																					-- --> Ausgabe auf 7-Seg.Anzeige
																					
	signal an_temp	  : std_logic_vector(3 downto 0);				--internes Signal zum Steuern der Tranistoren von 7-Seg.Anzeige
	
	
	-- Schaltungsanpassung III
	--signal Einer,Zehner: std_logic_vector(3 downto 0); -- interne Signale für Ausgabe 
	--signal BCD3: std_logic_vector(11 downto 0); -- internes Signal um Binär in BCD-Code umzuwandeln
	
	-- Schaltungsanpassung IV
	signal Einer,Zehner, Hunderter: std_logic_vector(3 downto 0); -- interne Signale für Ausgabe 
	signal BCD3: std_logic_vector(11 downto 0); -- internes Signal um Binär in BCD-Code umzuwandeln
	signal cntr_7seg : std_logic_vector(1 downto 0); 				--internes Signal für Multiplexer-Eingang (Selektieren von Anzeige) bis III
	

	-- Funktion to_bcd (Copy & Paste)
	----------------------------------------------------------------------------------
	--"DOUBLE DABBLE" - Algorithmus
	--Funktion: Umwandlung einer 8-Bit Dualzahl in 12-stelligen BCD-Code
	--Eingabeparameter: bin...8Bit Binärcode
	--Rückgabeparameter: bcd...12bit BCD-Code (3 BCD-Digits)
	----------------------------------------------------------------------------------
	function to_bcd ( bin : std_logic_vector(7 downto 0) ) return std_logic_vector is
	variable i : integer:=0;
	variable bcd : unsigned(11 downto 0) := (others => '0');
	variable bint : unsigned(7 downto 0) := unsigned(bin);
	
	begin
		for i in 0 to 7 loop --wiederhole 8 mal
			bcd(11 downto 1) := bcd(10 downto 0); --linksschieben um 1 Stelle
			bcd(0) := bint(7);
			bint(7 downto 1) := bint(6 downto 0);
			bint(0) :='0';
			
		if(i < 7 and bcd(3 downto 0) > "0100") then --addiere 3, wenn BCD-Digit0 größer als 4
			bcd(3 downto 0) := bcd(3 downto 0) + "0011";
		end if;
		
		if(i < 7 and bcd(7 downto 4) > "0100") then --addiere 3, wenn BCD-Digit1 größer als 4
			bcd(7 downto 4) := bcd(7 downto 4) + "0011";
		end if;
		
		if(i < 7 and bcd(11 downto 8) > "0100") then --addiere 3, wenn BCD-Digit2 größer als 4
			bcd(11 downto 8) := bcd(11 downto 8) + "0011";
		end if;
	end loop;
  return std_logic_vector(bcd); --Rückgabe des BCD-Codes (3 Digits)
	end to_bcd;
	
	begin

	-- Zähler 8Bit--		
	CNT: counter
		generic map(
			T_FAKTOR => 50*10**6/2, 	-- Takt = 2Hz
			--T_FAKTOR => 50*10**6/4, 	-- Takt = 4Hz
			DATA_WIDTH => DATA_WIDTH, 	-- Datenbreite: 8Bit
			Q_MAX => 255 					-- Maximaler Zählerwert = 255
			--Q_MAX => 99 					-- Maximaler Zählerwert = 99
		)
		port map (
			clk => clk,
			reset => reset,
			count => count_int
		);
	
--	-- Zähler/"Selektierer" für 7-Seg-Anzeige bis III
--	CNT_7SEG: counter
--		generic map(
--			T_FAKTOR => 50*10**6/200, 	-- Takt = 200Hz
--			--T_FAKTOR => 50*10**6/400, 	-- Takt = 400Hz
--			DATA_WIDTH => 1, 				-- Datenbreite: 1Bit
--			Q_MAX => 1 						-- Maximaler Zählerwert = 1
--		)
--		port map (
--			clk => clk,
--			reset => reset,
--			count => cntr_7seg
--		);

	-- Zähler/"Selektierer" für 7-Seg-Anzeige IV
	CNT_7SEG: counter
		generic map(
			T_FAKTOR => 50*10**6/200, 	-- Takt = 200Hz
			DATA_WIDTH => 2, 				-- Datenbreite: 2Bit
			Q_MAX => 3 						-- Maximaler Zählerwert = 3
		)
		port map (
			clk => clk,
			reset => reset,
			count => cntr_7seg
		);
		
	-- 7-Seg-Anzeige--	
	DEC: hex7seg
		port map ( 
			symb => digit,
			a_to_g => seg
		);
		
	dp <= '1';				-- Dezimalpunkt aus
	an <= an_temp;			-- internes Signal mit an zusammenschalten
	count <= count_int;	-- Top-Level Zuweisung des Zählerstatus
	
	-- Schaltungsanpassung III
	--BCD3 <= to_bcd(count_int);		-- Umwandlung binär --> BCD
	--Einer <= BCD3(3 downto 0); 	-- die Einerstelle des BCDs auf das interne Signal schalten
	--Zehner <= BCD3(7 downto 4); 	-- die Zehnerstelle des BCDs auf das interne Signal schalten
	
--	-- Prozess Multiplexer (bis III)
--	Multiplexer: process (cntr_7seg, count_int)
--	--Multiplexer: process (cntr_7seg, Einer, Zehner)
--		BEGIN
--		case cntr_7seg is
--			when "0" => digit <= count_int(3 downto 0); 		an_temp <= "1110"; -- Dekodieren der LSBits, 
--																									 -- Ausgabe auf der ersten 7-Seg.-Anzeige
--			when others => digit <= count_int(7 downto 4); 	an_temp <= "1101"; -- Dekodieren der MSBits, 
--																									 -- Ausgabe auf der zweiten 7-Seg.-Anzeige
--			--when "0" => digit <= Einer; 		an_temp <= "1110"; -- Dekodierte Einerstelle des Zählers auf die 1. 7-Seg.-Anzeige ausgeben																								  
--			--when others => digit <= Zehner; 	an_temp <= "1101"; -- Dekodierte Zehnerstelle des Zählers auf die 2. 7-Seg.-Anzeige ausgeben 				
--		end case;
--	END PROCESS Multiplexer;

	-- Schaltungsanpassung IV
	BCD3 <= to_bcd(count_int);			-- Umwandlung binär --> BCD
	Einer <= BCD3(3 downto 0); 		-- die Einerstelle des BCDs auf das interne Signal schalten
	Zehner <= BCD3(7 downto 4); 		-- die Zehnerstelle des BCDs auf das interne Signal schalten
	Hunderter <= BCD3 (11 downto 8); -- die Hunderterstelle des BCDs auf das interne Signal schalten


-- Prozess Multiplexer (IV)
   Multiplexer: process (cntr_7seg, Einer, Zehner, Hunderter)
		BEGIN
		case cntr_7seg is
			when "00" => digit 	<= Einer; 		an_temp <= "1110"; -- Dekodierte Einerstelle des Zählers auf die 1. 7-Seg.-Anzeige ausgeben	
			when "01" => digit	<= Zehner; 		an_temp <= "1101"; -- Dekodierte Zehnerstelle des Zählers auf die 2. 7-Seg.-Anzeige ausgeben 
			when others => digit <= Hunderter; 	an_temp <= "1011"; -- Dekodierte Hunderterstelle des Zählers auf die 3. 7-Seg.-Anzeige ausgeben 			
		end case;
	END PROCESS Multiplexer;

		
end Behavioral;

