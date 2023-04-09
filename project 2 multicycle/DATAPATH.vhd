
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity DATAPATH is
    Port ( PC_SEL : in  STD_LOGIC;
           PC_LDEN : in  STD_LOGIC;
			  PC_RESET : in  STD_LOGIC;
			  CLOCK : in  STD_LOGIC;
			  RF_WR_EN : in STD_LOGIC;
			  RF_B_SEL : in  STD_LOGIC;
			  RF_WDATA_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
			  ALU_BIN_SEL : in  STD_LOGIC;
			  ALU_FUNC : in  STD_LOGIC_VECTOR(3 downto 0);
			  MEM_WE_EN : in  STD_LOGIC;
			  BYTEOP : in  STD_LOGIC;
			  MEM_RdData : in   STD_LOGIC_VECTOR (31 downto 0);
			  Instr : in   STD_LOGIC_VECTOR (31 downto 0);
			  MEM_Addr  : out   STD_LOGIC_VECTOR (31 downto 0);
			  MEM_WrData : out   STD_LOGIC_VECTOR (31 downto 0);
			  ZERO : out  STD_LOGIC;
			  ALU_OVF : out  STD_LOGIC;
			  PC  : out STD_LOGIC_VECTOR(31 downto 0));
end DATAPATH;

architecture Behavioral of Datapath is

Component EXSTAGE is
   Port (  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_ovf : out  STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;


Component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_En : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_Data_sel : STD_LOGIC_VECTOR (1 downto 0) ;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component MEMSTAGE is
port (

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

end component;

Component REG is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;



signal immed_sig,rf_a_out,rf_b_out,alu_out_sig,rf_to_ALU_a_out,rf_to_ALU_b_out,
mem_output_sig: std_logic_vector (31 downto 0);


begin



IFSTAGE_mod : IFSTAGE
              Port Map(PC_Immed => immed_sig,
                       PC_sel => PC_SEL,
                       PC_LdEn => PC_LDEN,
                       Reset => PC_RESET,
                       Clk => CLOCK,
                       PC => PC );

DECSTAGE_mod : DECSTAGE
               Port Map(Instr => Instr,
                        RF_Wr_En => RF_WR_EN,
                        ALU_out => alu_out_sig,
                        MEM_out => mem_output_sig,
                        RF_Wr_Data_sel => RF_WDATA_SEL,
                        RF_B_sel => RF_B_SEL,
                        Clk => CLOCK,
                        Immed => immed_sig,
                        RF_A => rf_a_out,
                        RF_B => rf_b_out);
								
ALUSTAGE_mod : EXSTAGE
               Port Map(RF_A => rf_to_ALU_a_out,
                        RF_B => rf_to_ALU_b_out,
                        Immed => immed_sig,
                        ALU_Bin_sel => ALU_BIN_SEL, 
                        ALU_func => ALU_FUNC,
								ALU_zero =>   ZERO,
								ALU_ovf => ALU_OVF, 
                        ALU_out => alu_out_sig);
		

		
MEM_mod : MEMSTAGE
          Port Map(
			 		
						ByteOp  =>  BYTEOP  , 
						Mem_WrEn  =>  MEM_WE_EN  ,
						ALU_MEM_Addr =>  alu_out_sig   , 
						MEM_DataIn =>  rf_b_out  ,
						MEM_DataOut =>   mem_output_sig , 
						MM_WrEn  =>   open ,
						MM_Addr =>   MEM_Addr  ,    
						MM_WrData =>  MEM_WrData   ,
						MM_RdData =>   MEM_RdData 
						);
						
RF_to_ALU_reg1 : REG
					  Port Map(
								  Din => rf_a_out,
								  WE => '1',
                          CLOCK =>CLOCK ,
                          Dout =>  rf_to_ALU_a_out
								  );	
RF_to_ALU_reg2 : REG
					  Port Map(
								  Din => rf_b_out,
								  WE => '1',
                          CLOCK => CLOCK,
                          Dout =>rf_to_ALU_b_out 
								  );								  
								  
								  
								  
end Behavioral;

