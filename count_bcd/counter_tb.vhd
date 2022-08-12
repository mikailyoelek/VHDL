-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY counter_tb IS
  END counter_tb;

  ARCHITECTURE behavior OF counter_tb IS 

  -- Component Declaration
          COMPONENT counter
				 GENERIC (
					 T_FAKTOR: integer;
					 DATA_WIDTH: integer;
					 Q_MAX: integer
				 );
				 PORT(
						reset,clk : IN std_logic;
						count : OUT std_logic_vector(0 downto 0)       
				  );
          END COMPONENT;

          SIGNAL clk, reset :  std_logic;
          SIGNAL count :  std_logic_vector(0 downto 0);
			 
			 -- Taktperiode f�r Simulation
			 CONSTANT clk_period: TIME := 20ns; -- 50MHz Takt
          
  BEGIN

  -- Component Instantiation
          UUT: counter 
			 GENERIC MAP(
					T_FAKTOR => 3, 	-- clock = 25MHz
					DATA_WIDTH => 1, 	-- 1 Bit
					Q_MAX => 1 			-- maximal bis 1 z�hlen
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
        WAIT FOR clk_period; -- 1 Taktperiode warten
		  reset <= '1';
		  WAIT FOR clk_period*2; -- reset f�r 2 Taktperioden
		  reset <= '0';			 -- reset abschlie�en
		  
		  WAIT FOR clk_period*15; -- 15 Taktperioden warten
		  reset <= '1';
		  WAIT FOR clk_period; -- 1 Taktperiode lang reset
		  reset <= '0';		  -- reset abschlie�en
		  
        wait; -- will wait forever
     END PROCESS tb;
	  
	  --  End Test Bench 
  END;
