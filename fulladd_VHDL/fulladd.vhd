----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:46 02/25/2022 
-- Design Name: 
-- Module Name:    fulladd - Behavioral 
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
library IEEE; --Standardbibliothek
use IEEE.STD_LOGIC_1164.ALL; -- alle Komponenten verwendbar

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fulladd is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end fulladd;

architecture Behavioral of fulladd is

begin

	SUM <= (A xor B) xor Cin; --Summenbit
	Cout <= (A nand B) nand ((A xor B) nand Cin); --Übertrag

end Behavioral;

