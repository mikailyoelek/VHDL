----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:03:51 05/10/2022 
-- Design Name: 
-- Module Name:    Taster - Behavioral 
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

entity Taster is
	port (
		reset : in std_logic; -- asynch. Reset von Taster BTN3
		clk	: in std_logic; -- 50MHz Systemtakt
		sw_asyn: in	std_logic; -- asynch. Tastersignal von BTN0
		
		count	: out std_logic_vector(7 downto 0) -- 8-Bit Zählerstand (Dualcode)			 
	);
end Taster;

architecture Behavioral of Taster is
	-- interne Signale 
	signal sw : std_logic; -- 2. synchron. Tastersignal
	signal rising: std_logic; -- Freigabesignal für Zähler
	
	signal sw_syn1: std_logic; -- 1. synchron. Tastersignal
	signal sw_del: std_logic; -- Zählerstand um 1 inkrementieren, falls steigende Flanke
	
	signal count_temp: unsigned(7 downto 0); -- interner Bus, Datentyp unsigned
begin
	Synchronisation: process(clk, reset)
		begin
			if reset='1' then --asynchroner Reset?
			  -- ASYNCHRONER FUNKTIONSTEIL
			  sw <= '0';
			  sw_syn1 <= '0';
			elsif rising_edge(clk) then -- steigende Taktflanke?
			-- SYNCHRONER FUNKTIONSTEIL
			  sw<=sw_syn1;
			  sw_syn1 <= sw_asyn;
			end if;
		end process Synchronisation;
	
	Flankendetektion: process(reset, clk, sw)
		begin
			if reset='1' then
				sw_del <= '0';
			elsif rising_edge(clk)then
				if sw='1' then
					sw_del <= '1';
				elsif sw='0' then
					sw_del <= '0';
				end if;
			end if;
		end process Flankendetektion;
		
	FlankendetektionKombinatorik: process(sw_del, sw)
		begin
			if sw='1' and sw_del='0' then
				rising <= '1'; -- synch. Zählertakt auf log. 1
			else
				rising <= '0'; -- falls sw zurückgesetzt --> synch. Zählertakt auf log. 0
			end if;
		end process FlankendetektionKombinatorik;
		
	Zaehlen: process(clk, rising, reset)
		begin
			if reset='1' then -- asynchroner reset
				count_temp <= (others => '0');
--			elsif falling_edge(rising) then -- fallende Flanke von Zählertakt
--				count_temp <= count_temp+1; -- Zähler inkrementieren
			elsif rising_edge(clk) then
				if rising='1' then 
					count_temp <= count_temp+1; -- Zähler inkrementieren
				end if;
			end if;
		end process Zaehlen;
	
	count <= std_logic_vector(count_temp); --Ausgangszuweisung mit Typcasting
	
end Behavioral;

