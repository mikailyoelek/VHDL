----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:27:11 03/23/2022 
-- Design Name: 
-- Module Name:    d_ff - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity d_ff is
	port(	D: 					IN STD_LOGIC;
			Pre, Clr:			IN STD_LOGIC;
			clk:					IN STD_LOGIC;
			Q:						OUT STD_LOGIC
		);
end d_ff;

architecture Behavioral of d_ff is
begin
	process(clk, Clr, Pre)
		begin
			if(Clr = '1') then 
				Q <= '0';
			elsif(Pre = '1') then
				Q <= '1';
			elsif(clk'event and clk='1') then 
				Q <= D;
			end if;
		end process;
end Behavioral;

