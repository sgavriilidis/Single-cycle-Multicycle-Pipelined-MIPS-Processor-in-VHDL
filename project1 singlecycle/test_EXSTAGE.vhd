
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

--USE ieee.numeric_std.ALL;
 
ENTITY test_EXSTAGE IS
END test_EXSTAGE;
 
ARCHITECTURE behavior OF test_EXSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
       Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_ovf : out  STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_zero : std_logic;
	signal ALU_ovf : std_logic;
   signal ALU_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
			 ALU_ovf => ALU_ovf,
          ALU_out => ALU_out
        );

   -- Clock process definitions

 

   -- Stimulus process
    stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RF_A<="00000000000000000000000000000001";
		RF_B<= "00000000000000000000000000000001";
		Immed<="00000000000000000000000000000000";
		ALU_func<="0000";--add
		ALU_Bin_sel<='0';
      wait for 10 ns;	
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000100001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="0000";--addi
		ALU_Bin_sel<='1';
      wait for 10 ns;
		RF_A<="00000000000000000000000000001001";
		RF_B<= "00000000000000000000000000000011";
		Immed<="00000000000000000000000000000000";
		ALU_func<="0001";--sub
		ALU_Bin_sel<='0';
      wait for 10 ns;	
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="0010";--and
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<= "00000000000000000000000000000001";
		Immed<="00000000000000000000000000000000";
		ALU_func<="0011";--or
		ALU_Bin_sel<='0';
      wait for 10 ns;	
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="0100";--not a
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<= "00000000000000000000000000000001";
		Immed<="00000000000000000000000000000000";
		ALU_func<="0101";--nand
		ALU_Bin_sel<='0';
      wait for 10 ns;	
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="0110";--nor
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="1000";--sra
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="1001";--srl
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="1010";--sll
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="1100";--rotate left a 
		ALU_Bin_sel<='0';
      wait for 10 ns;
		RF_A<="00000000000000000000000000000001";
		RF_B<="00000000000000000000000000000001";
		Immed<="00000000000000000000000000000101";
		ALU_func<="1101";--rotate right a 
		ALU_Bin_sel<='0';
   
      wait;
   end process;

END;
