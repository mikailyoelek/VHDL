-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT counter
				 GENERIC (
					 T_FAKTOR: integer;
					 DATA_WIDTH: integer;
					 Q_MAX: integer
				 );
				 PORT(
						reset,clk : IN std_logic;
						count : OUT std_logic_vector(3 downto 0)       
				  );
          END COMPONENT;

          SIGNAL clk, reset :  std_logic;
          SIGNAL count :  std_logic_vector(3 downto 0);
			 
			 -- Taktperiode für Simulation
			 CONSTANT clk_period: TIME := 20ns; -- 50MHz Takt
          
  BEGIN

  -- Component Instantiation
          uut: counter 
			 GENERIC MAP(
					T_FAKTOR => 2, -- clock = 25MHz
					DATA_WIDTH => 4, -- 4 Bit
					Q_MAX => 9 -- maximal bis 9 zählen
			 )
			 PORT MAP(
					reset => reset,
					clk => clk,
					count => count
          );

  --  Test Bench Statements
  
	  -- Takt Prozess--
	  Takt : PROCESS
	  BEGIN
			clk <= '0';
			WAIT FOR clk_period/2;
			clk <= '1';
			WAIT FOR clk_period/2;
		END PROCESS takt;
		
	  -- asynchroner Reset --
     tb : PROCESS
     BEGIN
        WAIT FOR clk_period; -- wait until global set/reset completes
		  reset <= '1';
		  WAIT FOR clk_period*2; -- wait until global set/reset completes
		  reset <= '0';
		  
		  WAIT FOR clk_period*10; -- wait until global set/reset completes
		  reset <= '1';
		  WAIT FOR clk_period; -- wait until global set/reset completes
		  reset <= '0';
		  
        wait; -- will wait forever
     END PROCESS tb;
	  
	  --  End Test Bench 
  END;
