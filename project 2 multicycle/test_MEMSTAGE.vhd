
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_MEMSTAGE IS
END test_MEMSTAGE;
 
ARCHITECTURE behavior OF test_MEMSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
		PORT (

		ByteOp : in STD_LOGIC ;
		Mem_WrEn : in STD_LOGIC ;
		ALU_MEM_Addr : in   STD_LOGIC_VECTOR (31 downto 0);
		MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
		MEM_DataOut  :out  STD_LOGIC_VECTOR (31 downto 0);
		MM_WrEn  : out STD_LOGIC ;
		MM_Addr : out   STD_LOGIC_VECTOR (31 downto 0);
		MM_WrData : out   STD_LOGIC_VECTOR (31 downto 0);
		MM_RdData : in   STD_LOGIC_VECTOR (31 downto 0)
		);
    END COMPONENT;
    

   --Inputs
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
	signal MM_RdData :  std_logic_vector (31 downto 0):= (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
	signal MM_WrEn  :  std_logic ;
	signal MM_Addr :   std_logic_vector (31 downto 0);
	signal MM_WrData : std_logic_vector (31 downto 0);
   -- Clock period definitions
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
			 MM_WrEn  =>MM_WrEn,
			 MM_Addr =>MM_Addr,
			 MM_WrData =>MM_WrData,
			 MM_RdData =>MM_RdData
        );

   -- Clock process definitions

 

   stim_proc: process
   begin		
      wait for 100 ns ;	
		   ByteOp <=  '0';
         Mem_WrEn <=  '1'  ;
         ALU_MEM_Addr <= "00000000000000000000000000000100"  ;
         MEM_DataIn <=  "10101010100000000000000001111111"  ;
		wait for 100 ns ;	
			ByteOp <=  '0';
         Mem_WrEn <=  '1'  ;
         ALU_MEM_Addr <= "00000000000000000000000000001000"  ;
         MEM_DataIn <=  "10101010100000000000000001111011"  ;
		wait for 100 ns ;	
		
		   ByteOp <=  '0';
         Mem_WrEn <=  '0'  ;
         ALU_MEM_Addr <="00000000000000000000000000000100"  ;
		wait for 100 ns ;	
		
			ByteOp <=  '0';
         Mem_WrEn <=  '0'  ;
         ALU_MEM_Addr <= "00000000000000000000000000001000"  ;
		wait for 100 ns ;	
			ByteOp <=  '1';
         Mem_WrEn <=  '0'  ;
         ALU_MEM_Addr <= "00000000000000000000000000000100"  ;
		wait for 100 ns ;	
		
			ByteOp <=  '1';
         Mem_WrEn <=  '0'  ;
         ALU_MEM_Addr <="00000000000000000000000000001000"  ;
		wait for 100 ns ;	
    
    
		

   end process;

END;
