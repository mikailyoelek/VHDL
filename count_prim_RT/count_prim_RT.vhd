----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:18:52 03/23/2022 
-- Design Name: 
-- Module Name:    count_prim_RT - Behavioral 
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


entity count_prim_RT is
	port(
		clk:		IN STD_LOGIC;
		reset:	IN	STD_LOGIC;
		count:	OUT STD_LOGIC_VECTOR (2 downto 0)
	);
end count_prim_RT;


architecture rtl of count_prim_RT is

--Signaldeklarationen:
signal cnt_int: unsigned(2 downto 0);

begin
	CNT: 	process (clk, reset)	--Prozess wird bei Änderung des Zustandes der
										-- Signale "clk" bzw. "reset" neu gestartet
			begin
				if(reset = '1') then
					cnt_int <= "001"; --Initialwert = 1
				elsif (clk'event and clk='1') then
					case cnt_int is
						when "001" => cnt_int<="010"; --1 -> 2
						when "010" => cnt_int<="011"; --2 -> 3
						when "011" => cnt_int<="101"; --3 -> 5
						when "101" => cnt_int<="111"; --5 -> 7			
						when others => cnt_int <= "001"; --7 -> 1
					end case;	
				end if;
			end process;
			
			count <= STD_LOGIC_VECTOR(cnt_int);--Ausgangszuweisung mit Typcasting
end rtl;

