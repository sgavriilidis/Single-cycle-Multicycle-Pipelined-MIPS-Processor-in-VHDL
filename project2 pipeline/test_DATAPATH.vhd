
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

--USE ieee.numeric_std.ALL;
 
ENTITY test_DATAPATH IS
END test_DATAPATH;
 
ARCHITECTURE behavior OF test_DATAPATH IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_SEL : IN  std_logic;
         PC_LDEN : IN  std_logic;
         PC_RESET : IN  std_logic;
         CLOCK : IN  std_logic;
         RF_WR_EN : IN  std_logic;
         RF_B_SEL : IN  std_logic;
         RF_WDATA_SEL : IN  std_logic;
         ALU_BIN_SEL : IN  std_logic;
         ALU_FUNC : IN  std_logic_vector(3 downto 0);
         MEM_WE_EN : IN  std_logic;
         BYTEOP : IN  std_logic;
         MEM_RdData : IN  std_logic_vector(31 downto 0);
         Instr : IN  std_logic_vector(31 downto 0);
         MEM_Addr : OUT  std_logic_vector(31 downto 0);
         MEM_WrData : OUT  std_logic_vector(31 downto 0);
         ZERO : OUT  std_logic;
         ALU_OVF : OUT  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_SEL : std_logic := '0';
   signal PC_LDEN : std_logic := '0';
   signal PC_RESET : std_logic := '0';
   signal CLOCK : std_logic := '0';
   signal RF_WR_EN : std_logic := '0';
   signal RF_B_SEL : std_logic := '0';
   signal RF_WDATA_SEL : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_BIN_SEL : std_logic := '0';
   signal ALU_FUNC : std_logic_vector(3 downto 0) := (others => '0');
   signal MEM_WE_EN : std_logic := '0';
   signal BYTEOP : std_logic := '0';
   signal MEM_RdData : std_logic_vector(31 downto 0) := (others => '0');
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_Addr : std_logic_vector(31 downto 0);
   signal MEM_WrData : std_logic_vector(31 downto 0);
   signal ZERO : std_logic;
   signal ALU_OVF : std_logic;
   signal PC : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_SEL => PC_SEL,
          PC_LDEN => PC_LDEN,
          PC_RESET => PC_RESET,
          CLOCK => CLOCK,
          RF_WR_EN => RF_WR_EN,
          RF_B_SEL => RF_B_SEL,
          RF_WDATA_SEL => RF_WDATA_SEL,
          ALU_BIN_SEL => ALU_BIN_SEL,
          ALU_FUNC => ALU_FUNC,
          MEM_WE_EN => MEM_WE_EN,
          BYTEOP => BYTEOP,
          MEM_RdData => MEM_RdData,
          Instr => Instr,
          MEM_Addr => MEM_Addr,
          MEM_WrData => MEM_WrData,
          ZERO => ZERO,
          ALU_OVF => ALU_OVF,
          PC => PC
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
    -- Stimulus process
 stim_proc: process
   begin		
    
		
		wait for CLOCK_period*1;
		
		PC_SEL <='0'; 
		
		PC_LDEN <='1'; 
		wait for CLOCK_period*1;
	



		  -- addi r5,r0,8

		PC_SEL <='0'; 
		PC_LDEN<='1'; 
		RF_WR_EN <='1';
		RF_WDATA_SEL <="01"; --Alu out 
		RF_B_SEL  <='0';
		ALU_BIN_SEL <='1';  --Immed
		ALU_FUNC <="0000"; --add			
		MEM_WE_EN  <='0';

		wait for CLOCK_period*1;
		
		-- ori r3,r0,ABCD]
		
		PC_SEL <='0'; 			
		PC_LDEN <='1'; 
		RF_WR_EN <='1';
		RF_WDATA_SEL <="01"; --Alu out 
		RF_B_SEL  <='0';
		ALU_BIN_SEL <='1';  --Immed
		ALU_FUNC <="0011"; --OR			
		MEM_WE_EN  <='0';
		wait for CLOCK_period*1;
		
		-- sw r3 4(r0)
		
		PC_SEL <='0'; 
		PC_LDEN <='1'; 
		RF_WR_EN <='0';
		RF_WDATA_SEL <="10"; --Mem out dont care
		RF_B_SEL  <='1';
		ALU_BIN_SEL <='1';  --Immed
		ALU_FUNC  <="0000";	--add	
		MEM_WE_EN  <='1'; 
		wait for CLOCK_period*1;

		-- lw r10,-4(r5)
		 
		PC_SEL <='0'; 
		PC_LDEN <='1'; 
		RF_WR_EN <='1';
		RF_WDATA_SEL <="10"; --Mem out 
		RF_B_SEL  <='0';
		ALU_BIN_SEL <='1';  --Immed
		ALU_FUNC  <="0000";--add		
		MEM_WE_EN  <='0';  
		wait for CLOCK_period*1;
		
		-- lb r16 4(r0)
		
		PC_SEL <='0'; 
		PC_LDEN <='1'; 
		RF_WR_EN <='1';
		RF_WDATA_SEL <="10"; --Mem out 
		RF_B_SEL  <='0';
		ALU_BIN_SEL <='1';  --Immed
		ALU_FUNC  <="0000"; --add		
		MEM_WE_EN  <='0';  

		wait for CLOCK_period*1;
		
		-- nand r4,r0,r16
		PC_SEL <='0'; 
		PC_LDEN <='1'; 
		RF_WR_EN <='1';
		RF_WDATA_SEL <="10"; --Mem out 
		RF_B_SEL  <='1'; --rt
		ALU_BIN_SEL <='0';  --RF_B
		ALU_FUNC  <="0000"; --nand		
		MEM_WE_EN  <='0';  

    
      wait;
   end process;


END;
