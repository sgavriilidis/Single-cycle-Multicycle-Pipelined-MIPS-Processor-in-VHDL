-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

ENTITY test_ALU IS
END test_ALU;

ARCHITECTURE behavior OF test_ALU IS 

  -- Component Declaration
 COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Outt : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Outt : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Outt => Outt,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Clock process definitions
  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     A  <= "11111111111111111111111111111111";
		B  <=	"00000000000000000000000000000001";
		Op <= "0000";
      wait for 50 ns;
		A  <= "11111111111111111111111111111110";
		B  <=	"10000000000000000000000000000001";
		Op <= "0000";
		wait for 50 ns;
		A  <= "00000000000000000000000000000001";
		B  <=	"00000000000000000000000000000010";
		Op <= "0000";
      wait for 50 ns;
		A  <= "11111111111111111111111111111111";
		B  <=	"11111111111111111111111111111111";
      Op <= "0000";
		wait for 50 ns;--ADD
		
		A  <= "00000000000000000000000000000011";
		B  <=	"00000000000000000000000000000001";
		Op <= "0001";
      wait for 50 ns;
		A  <= "00000000000000000000000000000001";
		B  <=	"00000000000000000000000000000011";
		Op <= "0001";
		wait for 50 ns;--SUB  
		
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0010";--and
		wait for 50 ns;
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0011";-- or
		wait for 50 ns;
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0100";-- not a
		wait for 50 ns;
		
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0101";--nand
		wait for 50 ns;
		
		A  <= "11000000000000010000000000000000";
		B  <=	"01000000000000010000000000000000";
		Op <= "0110";--nor
		
		wait for 50 ns;
		A  <= "11000000000000010000001111100000";
		B  <=	"00000000000000000000000000000000";
		Op <= "1000";--sra
		wait for 50 ns;
		A  <= "11000000000000010000000001000001";
		B  <=	"00000000000000000000000000000000";
      Op <= "1001";--slr
		wait for 50 ns;
		A  <= "11000000000000010000000000100000";
		B  <=	"00000000000000000000000000000000";
		Op <= "1010";--sll
		wait for 50 ns;
		A  <= "11000011000000010000000000000001";
		B  <=	"00000000000000000000000000000000";
		Op <= "1100";--rotate left
		wait for 50 ns;
		A  <= "11000000000000010011000000000000";
		B  <=	"00000000000000000000000000000000";
		Op <= "1101";--rotate right
		wait for 50 ns;
		


     -- wait for <clock>_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;