
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

--USE ieee.numeric_std.ALL;
 
ENTITY test_ADD IS
END test_ADD;
 
ARCHITECTURE behavior OF test_ADD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADD
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Ot : OUT  std_logic_vector(31 downto 0);
         OVF : OUT  std_logic;
         Z : OUT  std_logic;
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Ot : std_logic_vector(31 downto 0);
   signal OVF : std_logic;
   signal Z : std_logic;
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADD PORT MAP (
          A => A,
          B => B,
          Ot => Ot,
          OVF => OVF,
          Z => Z,
          COUT => COUT
        );

   -- Clock process definitions

 

   -- Stimulus process
   stim_proc: process
   begin		
       -- hold reset state for 100 ns.
		A  <= "11111111111111111111111111111111";
		B  <=	"00000000000000000000000000000001";
      wait for 50 ns;
		A  <= "11111111111111111111111111111110";
		B  <=	"10000000000000000000000000000001";
		wait for 50 ns;
		A  <= "00000000000000000000000000000001";
		B  <=	"00000000000000000000000000000010";
      wait for 50 ns;
		A  <= "11111111111111111111111111111111";
		B  <=	"11111111111111111111111111111111";

      wait;
   end process;

END;
