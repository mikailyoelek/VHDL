----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:10:17 04/08/2022 
-- Design Name: 
-- Module Name:    hex7seg - Behavioral 
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

entity hex7seg is
    Port ( symb : in  STD_LOGIC_VECTOR (3 downto 0);
           a_to_g : out  STD_LOGIC_VECTOR (6 downto 0));
end hex7seg;

architecture Behavioral of hex7seg is

begin
	decoder: process(symb)
		begin
			case symb is
					when X"0" => a_to_g <= "0000001"; --0
					when X"1" => a_to_g <= "1001111"; --1
					when X"2" => a_to_g <= "0010010"; --2
					when X"3" => a_to_g <= "0000110"; --3
					when X"4" => a_to_g <= "1001100"; --4
					when X"5" => a_to_g <= "0100100"; --5
					when X"6" => a_to_g <= "0100000"; --6
					when X"7" => a_to_g <= "0001111"; --7
					when X"8" => a_to_g <= "0000000"; --8
					when X"9" => a_to_g <= "0000100"; --9
					when X"A" => a_to_g <= "0001000"; --A
					when X"B" => a_to_g <= "1100000"; --b
					when X"C" => a_to_g <= "0110001"; --C
					when X"D" => a_to_g <= "1000010"; --d
					when X"E" => a_to_g <= "0110000"; --E
					when others => a_to_g <= "0111000"; --F
			end case;
	end process decoder;
end Behavioral;

