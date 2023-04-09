
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
--USE ieee.numeric_std.ALL;
 
ENTITY test_SUB IS
END test_SUB;
 
ARCHITECTURE behavior OF test_SUB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SUB
    PORT(
         C : IN  std_logic_vector(31 downto 0);
         D : IN  std_logic_vector(31 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         ovf : OUT  std_logic;
         zer : OUT  std_logic;
         cot : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal C : std_logic_vector(31 downto 0) := (others => '0');
   signal D : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal ovf : std_logic;
   signal zer : std_logic;
   signal cot : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SUB PORT MAP (
          C => C,
          D => D,
          Output => Output,
          ovf => ovf,
          zer => zer,
          cot => cot
        );

   -- Clock process definitions


   -- Stimulus process
    stim_proc: process
   begin		
    -- hold reset state for 100 ns.
		C  <= "00000000000000000000000000000011";
		D  <=	"00000000000000000000000000000001";
      wait for 50 ns;
		C  <= "00000000000000000000000000000001";
		D  <=	"00000000000000000000000000000011";
		
		C  <= "11111111111111111111111111111111";
		D  <=	"00000000000000000000000000000001";
      wait for 50 ns;
		C  <= "11111111111111111111111111111110";
		D  <=	"10000000000000000000000000000001";
		wait for 50 ns;
		C  <= "00000000000000000000000000000001";
		D  <=	"00000000000000000000000000000010";
      wait for 50 ns;
		C  <= "11111111111111111111111111111111";
		D  <=	"11111111111111111111111111111111";
      --wait for <clock>_period*10;

      wait;
   end process;

END;
