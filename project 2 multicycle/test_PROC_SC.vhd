
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_PROC_SC IS
END test_PROC_SC;
 
ARCHITECTURE behavior OF test_PROC_SC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_SC
    PORT(
         Clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal rst : std_logic := '0';

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_SC PORT MAP (
          Clk => Clk,
          rst => rst
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		rst<='1';
		wait for 300 ns;	
      
		rst<='0';
		wait for 1000 ns;	

      wait;
   end process;

END;
