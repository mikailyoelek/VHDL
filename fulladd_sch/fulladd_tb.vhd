-- Vhdl test bench created from schematic C:\Users\mikai\Qsync\HTL Rankweil Elektronik\4BHEL\DIC1_WALCHER\VHDL\fulladd_sch\fulladd.sch - Tue Feb 22 09:26:00 2022
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY fulladd_fulladd_sch_tb IS
END fulladd_fulladd_sch_tb;
ARCHITECTURE behavioral OF fulladd_fulladd_sch_tb IS 

   COMPONENT fulladd
   PORT( Cin	:	IN	STD_LOGIC; 
          SUM	:	OUT	STD_LOGIC; 
          Cout	:	OUT	STD_LOGIC; 
          B	:	IN	STD_LOGIC; 
          A	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL Cin	:	STD_LOGIC;
   SIGNAL SUM	:	STD_LOGIC;
   SIGNAL Cout	:	STD_LOGIC;
   SIGNAL B	:	STD_LOGIC;
   SIGNAL A	:	STD_LOGIC;

BEGIN

   UUT: fulladd PORT MAP(
		Cin => Cin, 
		SUM => SUM, 
		Cout => Cout, 
		B => B, 
		A => A
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
		Cin <= '0'; A <= '0'; B <= '0';
		WAIT for 1ms;
		Cin <= '0'; A <= '0'; B <= '1';
		WAIT for 1ms;
		Cin <= '0'; A <= '1'; B <= '0';
		WAIT for 1ms;
		Cin <= '0'; A <= '1'; B <= '1';
		WAIT for 1ms;
		Cin <= '1'; A <= '0'; B <= '0';
		WAIT for 1ms;
		Cin <= '1'; A <= '0'; B <= '1';
		WAIT for 1ms;
		Cin <= '1'; A <= '1'; B <= '0';
		WAIT for 1ms;
		Cin <= '1'; A <= '1'; B <= '1';
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
