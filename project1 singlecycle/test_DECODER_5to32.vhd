
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_DECODER_5to32 IS
END test_DECODER_5to32;
 
ARCHITECTURE behavior OF test_DECODER_5to32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECODER_5to32
    PORT(
         Input : IN  std_logic_vector(4 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECODER_5to32 PORT MAP (
          Input => Input,
          Output => Output
        );

   -- Clock process definitions
 

   -- Stimulus process
    stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Input<="00010"; wait for 100ns;
		
		Input<="00011"; wait for 100ns;
		Input<="00111"; wait for 100ns;
		Input<="00101"; wait for 100ns;

      -- insert stimulus here 

      wait;
   end process;

END;
