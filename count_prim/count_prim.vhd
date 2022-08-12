----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:51 03/23/2022 
-- Design Name: 
-- Module Name:    count_prim - Behavioral 
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

entity count_prim is
	port(	clk: 		IN STD_LOGIC;
			reset:	IN	STD_LOGIC;
			count:	OUT STD_LOGIC_VECTOR(2 downto 0)
	);
end count_prim;

architecture structural of count_prim is
	
	component d_ff
		port (Clr:	IN STD_LOGIC;
				Pre:	IN STD_LOGIC;
				clk:		IN STD_LOGIC;
				D:			IN STD_LOGIC;
				Q:			OUT STD_LOGIC
				);
	end component;
	
	signal D0,D1,D2,Q0,Q1,Q2: STD_LOGIC;--Signaldeklaration
	
begin
	--kombinatorische Zählerteil:
	D0 <= Q1 OR Q2;
	D1 <= NOT (Q1 AND Q0);
	D2 <= (Q2 AND NOT Q1) OR (NOT Q2 AND Q1 AND Q0);
	
	--Instanziierung der D-FFs:
	DFF0 : d_ff port map (Clr=>'0', Pre=>reset, clk=>clk, D=>D0, Q=>Q0);--LSB
	DFF1 : d_ff port map (Clr=>reset, Pre=>'0', clk=>clk, D=>D1, Q=>Q1);
	DFF2 : d_ff port map (Clr=>reset, Pre=>'0', clk=>clk, D=>D2, Q=>Q2);--MSB
	
	-- mit & werden die tatsächlichen Signale zusammengefasst
	count <= Q2 & Q1 & Q0; -- Erzeugung eines Datenbusses (MSB->LSB)
end structural;

