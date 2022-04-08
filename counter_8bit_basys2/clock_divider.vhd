----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:38:44 03/22/2022 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
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

entity clock_divider is
	generic (T_FAKTOR: integer := 50*10**6/2
				-- Default Teilungsfaktor für BASYS2: 50MHz/2Hz
	);

	PORT (clk	: in STD_LOGIC; -- Takt
			reset	: in STD_LOGIC; -- asynchroner Reset
			enable: out STD_LOGIC -- Freigabesignal für externe
										  -- synchrone Logik
	);
end clock_divider;

-- Verhaltensbeschreibung des Frequenzteilers

architecture Behavioral of clock_divider is
	SIGNAL cnt: integer; -- Wertebereich -2^31 ... 2^31-1
begin
	ClockDiv: process (reset,clk)
	begin
		if reset='1' then -- asynch. reset?
		cnt <= T_FAKTOR-1;
		enable <= '0';
		elsif clk='1' and clk'event then -- steigende Flanke?
			if cnt=0 then
				enable <= '1';
				cnt <= T_FAKTOR -1;
			else
				enable <= '0';
				cnt <= cnt-1;
			end if;
		end if;
	end process ClockDiv;
end Behavioral;

