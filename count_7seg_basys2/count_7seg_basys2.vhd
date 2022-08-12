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

entity count_7seg_basys2 is
    Port ( clk : in  STD_LOGIC; -- Systemtakt
           reset : in  STD_LOGIC; -- asynchroner Reset
           count : out  STD_LOGIC_VECTOR (3 downto 0); -- Z�hlerstatus
           seg : out  STD_LOGIC_VECTOR (6 downto 0); -- Zeichencode f�r 7-Seg. Anzeige
           dp : out  STD_LOGIC;	-- Status Dezimalpunkt
           an : out  STD_LOGIC_VECTOR (3 downto 0)-- Aktivierungssignal 7-Seg. Elemente
	); 
end count_7seg_basys2;

architecture Behavioral of count_7seg_basys2 is

	constant DATA_WIDTH: integer:=4;
	
	
	-- Z�hler --
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
	
	signal count_int : std_logic_vector(DATA_WIDTH-1 downto 0);

begin

	-- Z�hler --		
	CNT: counter
		generic map(
			T_FAKTOR => 50*10**6/2,
			DATA_WIDTH => DATA_WIDTH,
			Q_MAX => 9
		)
		port map (
			clk => clk,
			reset => reset,
			count => count_int
		);
		
	-- 7-Seg-Anzeige--	
	DEC: hex7seg
		port map ( 
			symb => count_int,
			a_to_g => seg
		);
		
	an <= "1110"; 	-- Digit AN0 aktiv
	dp <= '1';		-- Dezimalpunkt aus
	
	count <= count_int;	-- Top-Level Zuweisung des Z�hlerstatus
	
end Behavioral;

