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
	signal cntr_7seg : std_logic_vector(0 downto 0); 				--internes Signal für Multiplexer-Eingang (Selektieren von Anzeige)
	signal digit	  : std_logic_vector(3 downto 0);				--internes Signal zum Decodieren der 8Bit Daten (jeweils 4Bit "Packete")
																					-- --> Ausgabe auf 7-Seg.Anzeige
	signal an_temp	  : std_logic_vector(3 downto 0);				--internes Signal zum Steuern der Tranistoren von 7-Seg.Anzeige

begin

	-- Zähler 8Bit--		
	CNT: counter
		generic map(
			T_FAKTOR => 50*10**6/2, 	-- Takt = 2Hz
			DATA_WIDTH => DATA_WIDTH, 	-- Datenbreite: 8Bit
			Q_MAX => 255 					-- Maximaler Zählerwert = 255
		)
		port map (
			clk => clk,
			reset => reset,
			count => count_int
		);
	
	-- Zähler/"Selektierer" für 7-Seg-Anzeige
	CNT_7SEG: counter
		generic map(
			T_FAKTOR => 50*10**6/200, 	-- Takt = 200Hz
			DATA_WIDTH => 1, 				-- Datenbreite: 1Bit
			Q_MAX => 1 						-- Maximaler Zählerwert = 255
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
	count <= count_int;	-- Top-Level Zuweisung des Zählerstatus
	an <= an_temp;			-- internes Signal mit an zusammenschalten
	
	-- Prozess Multiplexer
	Multiplexer: process (cntr_7seg, count_int, reset)
		BEGIN
		if reset = '1' then 
			digit <= count_int(3 downto 0); an_temp <= "1100";
		else
			case cntr_7seg is
				when "0" => digit <= count_int(3 downto 0); 		an_temp <= "1110"; -- Dekodieren der LSBits, 
																								  -- Ausgabe auf der ersten 7-Seg.-Anzeige
				when others => digit <= count_int(7 downto 4); 	an_temp <= "1101"; -- Dekodieren der MSBits, 
																								  -- Ausgabe auf der zweiten 7-Seg.-Anzeige
			end case;
		end if;
		END PROCESS Multiplexer;
		
end Behavioral;

