----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:17:30 03/23/2022 
-- Design Name: 
-- Module Name:    mux4 - Behavioral 
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

entity mux4 is
	port( a,b,c,d: IN STD_LOGIC;
			sel:		IN STD_LOGIC_VECTOR (1 downto 0);
			p_out: 	OUT STD_LOGIC
			);
end mux4;

architecture Behavioral of mux4 is

begin
	process(a,b,c,d,sel)
	begin
		case sel is
			when "00" => p_out <=a;
			when "01" => p_out <=b;
			when "10" => p_out <=c;
			when others => p_out <=d;
		end case;
	end process;
end Behavioral;


