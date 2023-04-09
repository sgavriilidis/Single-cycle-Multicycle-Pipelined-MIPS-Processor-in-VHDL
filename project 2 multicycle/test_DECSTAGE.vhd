
LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

ENTITY test_DECSTAGE IS
END test_DECSTAGE;
 
ARCHITECTURE behavior OF test_DECSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_Wr_En : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_Wr_Data_sel :  IN STD_LOGIC_VECTOR (1 downto 0);
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_Wr_En : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_Wr_Data_sel : std_logic_vector(1 downto 0) := (others => '0');
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_Wr_En => RF_Wr_En,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_Wr_Data_sel => RF_Wr_Data_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
      -- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="100000" & "00000" & "00001" & "00000" & "00000" & "000000";
		RF_Wr_En<='1';
		ALU_out<="00000000000000000000000000000001";
		MEM_out<="00000000000000000000000000000000";
		RF_Wr_Data_Sel<="01";--ALU
		RF_B_Sel<='0';
		
      wait for 10 ns;
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="100000" & "00001" & "10000" & "00000" & "00000" & "000000";
		RF_Wr_En<='1';
		ALU_out<="00000000000000000000000000000011";
		MEM_out<="00000000000000000000000000000000";
		RF_Wr_Data_Sel<="01";--ALU
		RF_B_Sel<='0';
		
      wait for 10 ns;
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="110010" & "00001" & "00000" & "10000" & "00100" & "000110";
		RF_Wr_En<='0';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000110000000000000000000011";
		RF_Wr_Data_Sel<="10";--MEM
		RF_B_Sel<='0';--(15downto11)
		-- zero fill(Immed)
      wait for 10 ns;
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="111001" & "00001" & "10000" & "10000" & "00011" & "000011";
		RF_Wr_En<='0';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000000000000000000000000000";
		RF_Wr_Data_Sel<="01";--ALU
		RF_B_Sel<='1'; --(20downto16)
		-- shift left 16 and zero fill (Immed)
      wait for 10 ns;
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="111000" & "00000" & "00011" & "10000" & "11111" & "000000";
		RF_Wr_En<='1';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="00000000000000000000000000000011";
		RF_Wr_Data_Sel<="10";--MEM
		RF_B_Sel<='0';--(15downto11)
		-- sign extend (Immed)
      wait for 10 ns;
		-- (31downto26)(25downto21)(20downto16)(15downto11)
		Instr<="000000" & "00000" & "00011" & "00011" & "00000" & "000000";
		RF_Wr_En<='0';
		ALU_out<="00000000000000000000000000000000";
		MEM_out<="11000000000000000000000000000000";
		RF_Wr_Data_Sel<="10";--MEM
		RF_B_Sel<='0';--(15downto11)
		-- sign extend and shift left 2 (Immed)
      wait for 10 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

