----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:17:38 03/29/2022 
-- Design Name: 
-- Module Name:    counter_8bit - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity counter is
	 generic ( T_FAKTOR: integer := 50*10**6/5; -- Default Teilungsfaktor f�r BASYS2: 50MHZ/2Hz, hier: 50MHz/5Hz
				 DATA_WIDTH: integer := 4; -- Default Datenbreite 8 Bit, hier: 4 Bit (zum Testen auf Basys2)
				 Q_MAX: integer := 15 -- maximaler Z�hlwert
	 );

    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end counter;

architecture Behavioral of counter is
component clock_divider
	generic (T_FAKTOR: integer 
	);
	port( clk, reset: IN std_logic;
			enable:		OUt std_logic 
	);
end component;

signal q_int: unsigned(DATA_WIDTH-1 downto 0); -- interner Bus, Datentyp unsigned
signal enable_int: std_logic;

begin
-- Instanzierung der Frequenzteiler-Komponente
	DIV: clock_divider -- Instanziierung des Frequenzteilers
	generic map (T_FAKTOR => T_FAKTOR) -- Teilungsfaktor �bergeben
	port map (
		clk => clk,
		reset => reset,
		enable => enable_int);
	
	counter: process (clk, reset)-- Verhaltensbeschreibung DATA_WIDTH Bit Z�hler
		begin
			if (reset='1') then -- asynchroner reset aktiv?
				q_int <= (others => '0'); -- r�cksetzen aller Z�hlerbits auf 0
			elsif (clk'event and clk='1') then -- steigende Taktflanke
				if (enable_int='1') then
					if (q_int < Q_MAX) then
						q_int <= q_int + 1; -- Z�hlerstand inkrementieren
					else
						q_int <= (others => '0'); -- Z�hlerstand r�cksetzen
					end if;
				end if;
			end if;
	end process counter;
	
	count <= std_logic_vector(q_int); --Ausgangszuweisung mit Typcasting
	
end Behavioral;

