-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_IFSTAGE IS
END test_IFSTAGE;
 
ARCHITECTURE behavior OF test_IFSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
   
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          PC => PC
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '1';
		wait for Clk_period/2;
		Clk <= '0';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      PC_Immed<="00000000000000000000000000000000"; -- thesh mhden
		PC_Sel<='0'; --PC+4
		PC_LdEn<='0';
		Reset<='1';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000000011";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000000000";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000010000";
		PC_Sel<='1';--PC+4+Immediate
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000000000";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000010000"; -- Immed=(+4)
		PC_Sel<='0'; -- PC +4
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000000011";-- Immed=(+3)
		PC_Sel<='1'; --PC+4+Immed
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;

		PC_Immed<="00000000000000000000000000000000";
		PC_Sel<='0';
		PC_LdEn<='1';
		Reset<='0';
		
      wait for 10 ns;		

      wait for Clk_period*10;

		
      

      -- insert stimulus here 

      wait;
   end process;

END;
