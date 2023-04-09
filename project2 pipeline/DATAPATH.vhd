
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
			  RF_WDATA_SEL : in  STD_LOGIC ;
			  ALU_BIN_SEL : in  STD_LOGIC;
			  ALU_FUNC : in  STD_LOGIC_VECTOR(3 downto 0);
			  MEM_WE_EN : in  STD_LOGIC;
			  BYTEOP : in  STD_LOGIC;
			  MEM_RdData : in   STD_LOGIC_VECTOR (31 downto 0);
			  Instr : in   STD_LOGIC_VECTOR (31 downto 0);
			  MEM_Addr  : out   STD_LOGIC_VECTOR (31 downto 0);
			  MM_Wr_EN : out STD_LOGIC;
			  MEM_WrData : out   STD_LOGIC_VECTOR (31 downto 0);
			  ZERO : out  STD_LOGIC;
			  ALU_OVF : out  STD_LOGIC;
			  PC  : out STD_LOGIC_VECTOR(31 downto 0);
			  InstrToControl  : out STD_LOGIC_VECTOR(31 downto 0)
			  
			  );
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
	 	     Awr : in  STD_LOGIC_VECTOR (4 downto 0);

           RF_Wr_En : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_Data_sel : STD_LOGIC ;
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


Component IF_DEC_REGISTER is
port (
	Instr : in std_logic_vector(31 downto 0);
	Clk   : in std_logic;
	wr_en : in std_logic;
	Instr_out: out std_logic_vector(31 downto 0)
);
end component;


Component DEX_EX_REGISTER is
port (
RF_WR_EN : in STD_LOGIC;
RF_WDATA_SEL : in  STD_LOGIC;
ALU_BIN_SEL : in  STD_LOGIC;
ALU_FUNC : in  STD_LOGIC_VECTOR(3 downto 0);
MEM_WE_EN : in  STD_LOGIC;
BYTEOP : in  STD_LOGIC;
INSTR : in STD_LOGIC_VECTOR(31 downto 0);
RS: in std_logic_vector( 4 downto 0);
RT: in std_logic_vector( 4 downto 0);
RD: in std_logic_vector( 4 downto 0);
IMMED: in std_logic_vector( 31 downto 0);
Clk : in STD_LOGIC;
RFA : in std_logic_vector( 31 downto 0);
RFB : in std_logic_vector( 31 downto 0);

RF_WR_EN_OUT : out STD_LOGIC;
RF_WDATA_SEL_OUT : out  STD_LOGIC;
ALU_BIN_SEL_OUT : out  STD_LOGIC;
ALU_FUNC_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
MEM_WE_EN_OUT : out  STD_LOGIC;
BYTEOP_OUT : out  STD_LOGIC;
INSTR_OUT : out STD_LOGIC_VECTOR(31 downto 0);
RS_OUT : out std_logic_vector( 4 downto 0);
RT_OUT: out std_logic_vector( 4 downto 0);
RD_OUT: out std_logic_vector( 4 downto 0);
IMMED_OUT : out std_logic_vector( 31 downto 0);
RFA_OUT : out std_logic_vector( 31 downto 0);
RFB_OUT : out std_logic_vector( 31 downto 0)

);
end component;



Component EX_MEM_REGISTER is
port (
	RF_WR_EN : in STD_LOGIC;
	RF_WDATA_SEL : in  STD_LOGIC;
	MEM_WE_EN : in  STD_LOGIC;
	BYTEOP : in  STD_LOGIC;
	INSTR : in STD_LOGIC_VECTOR(31 downto 0);
	RS: in std_logic_vector( 4 downto 0);
	RT: in std_logic_vector( 4 downto 0);
	RD: in std_logic_vector( 4 downto 0);
	IMMED: in std_logic_vector( 31 downto 0);
	ALU : in std_logic_vector( 31 downto 0);
	Clk : in STD_LOGIC;
	RFB : in std_logic_vector( 31 downto 0);



	RF_WR_EN_OUT : out STD_LOGIC;
	RF_WDATA_SEL_OUT : out  STD_LOGIC;
	MEM_WE_EN_OUT : out  STD_LOGIC;
	BYTEOP_OUT : out  STD_LOGIC;
	INSTR_OUT : out STD_LOGIC_VECTOR(31 downto 0);
	RS_OUT : out std_logic_vector( 4 downto 0);
	RT_OUT: out std_logic_vector( 4 downto 0);
	RD_OUT: out std_logic_vector( 4 downto 0);
	IMMED_OUT : out std_logic_vector( 31 downto 0);
	ALU_OUT : out std_logic_vector( 31 downto 0);
	RFB_OUT : out std_logic_vector( 31 downto 0)


);
end component;



Component MEM_WB_REGISTER is
port (
	RF_WR_EN : in STD_LOGIC;
	RF_WDATA_SEL : in  STD_LOGIC;
	INSTR : in STD_LOGIC_VECTOR(31 downto 0);
	RS: in std_logic_vector( 4 downto 0);
	RT: in std_logic_vector( 4 downto 0);
	RD: in std_logic_vector( 4 downto 0);
	IMMED: in std_logic_vector( 31 downto 0);
	ALU : in std_logic_vector( 31 downto 0);
	MEM : in std_logic_vector (31 downto 0);
	Clk : in STD_LOGIC;


	RF_WR_EN_OUT : out STD_LOGIC;
	RF_WDATA_SEL_OUT : out  STD_LOGIC;
	BYTEOP_OUT : out  STD_LOGIC;
	INSTR_OUT : out STD_LOGIC_VECTOR(31 downto 0);
	RS_OUT : out std_logic_vector( 4 downto 0);
	RT_OUT: out std_logic_vector( 4 downto 0);
	RD_OUT: out std_logic_vector( 4 downto 0);
	IMMED_OUT : out std_logic_vector( 31 downto 0);
	ALU_OUT : out std_logic_vector( 31 downto 0);
	MEM_OUT : out std_logic_vector (31 downto 0)


);
end component;


Component FORWARD_UNIT is
port (
	registerToWriteOneCycleAhead : in std_logic_vector(4 downto 0);
	registerToWriteTwoCycleAhead : in std_logic_vector(4 downto 0);
	Instr: in std_logic_vector(31 downto 0);
	InstrOneCycleAhead :in std_logic_vector(31 downto 0);
	InstrTwoCycleAhead :  in std_logic_vector(31 downto 0);
	RF_WR_EN_OneCycleAhead :in std_logic;
	RF_WR_EN_TwoCycleAhead :in std_logic;
	ControlMux1OfALU :  out std_logic_vector(1 downto 0);
	ControlMux2OfALU :  out std_logic_vector(1 downto 0);
	Clk : in std_logic 
);
end component;


Component STALL_UNIT is
port (


	Instr_IF_STAGE:  in std_logic_vector(31 downto 0);
	Intr_DEC_STAGE : in std_logic_vector(31 downto 0);
	Reset  :in std_logic ;
	Clk: in std_logic ;
	
	IF_DEC_WR_EN : out std_logic ;
	PC_LD_EN:  out std_logic ;
	KILL_WR_EN_SIGNALS : out std_logic 

);
end component;


Component MUX4_1 is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : in  STD_LOGIC_VECTOR (31 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           Control : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal immed_sig,rf_a_out,rf_b_out,alu_out_sig,
mem_output_sig, instr_out_if_dex_reg_sig : std_logic_vector (31 downto 0);

signal  CONTROL_UPPER_ALU_MUX_SIG, CONTROL_DOWN_ALU_MUX_SIG : std_logic_vector (1 downto 0);
-- DEX/EX signals
signal RF_WR_EN_OUT_DEC_EX_SIG :  STD_LOGIC;
signal RF_WDATA_SEL_OUT_DEC_EX_SIG :   STD_LOGIC;
signal ALU_BIN_SEL_OUT_DEC_EX_SIG :   STD_LOGIC;
signal ALU_FUNC_OUT_DEC_EX_SIG :   STD_LOGIC_VECTOR(3 downto 0);
signal MEM_WE_EN_OUT_DEC_EX_SIG :   STD_LOGIC;
signal BYTEOP_OUT_DEC_EX_SIG :   STD_LOGIC;
signal INSTR_OUT_DEC_EX_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal RS_OUT_DEC_EX_SIG :  std_logic_vector( 4 downto 0);
signal RT_OUT_DEC_EX_SIG:  std_logic_vector( 4 downto 0);
signal RD_OUT_DEC_EX_SIG:  std_logic_vector( 4 downto 0);
signal IMMED_OUT_DEC_EX_SIG :  std_logic_vector( 31 downto 0);
signal RFA_OUT_DEC_EX_SIG :  std_logic_vector( 31 downto 0);
signal RFB_OUT_DEC_EX_SIG:  std_logic_vector( 31 downto 0);

-- EX/MEM signals

signal RF_WR_EN_OUT_EX_MEM_SIG :  STD_LOGIC;
signal RF_WDATA_SEL_OUT_EX_MEM_SIG :   STD_LOGIC;
signal MEM_WE_EN_OUT_EX_MEM_SIG :   STD_LOGIC;
signal BYTEOP_OUT_EX_MEM_SIG :   STD_LOGIC;
signal INSTR_OUT_EX_MEM_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal RS_OUT_EX_MEM_SIG :  std_logic_vector( 4 downto 0);
signal RT_OUT_EX_MEM_SIG:  std_logic_vector( 4 downto 0);
signal RD_OUT_EX_MEM_SIG:  std_logic_vector( 4 downto 0);
signal IMMED_OUT_EX_MEM_SIG :  std_logic_vector( 31 downto 0);
signal ALU_OUT_EX_MEM_SIG :  std_logic_vector( 31 downto 0);
signal RFB_OUT_MEM_SIG : std_logic_vector( 31 downto 0);

-- MEM/WB signals

signal RF_WR_EN_OUT_MEM_WB_SIG :  STD_LOGIC;
signal RF_WDATA_SEL_OUT_MEM_WB_SIG :   STD_LOGIC;
signal BYTEOP_OUT_MEM_WB_SIG :  STD_LOGIC;
signal INSTR_OUT_MEM_WB_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal RS_OUT_MEM_WB_SIG :  std_logic_vector( 4 downto 0);
signal RT_OUT_MEM_WB_SIG:  std_logic_vector( 4 downto 0);
signal RD_OUT_MEM_WB_SIG:  std_logic_vector( 4 downto 0);
signal IMMED_OUT_MEM_WB_SIG :  std_logic_vector( 31 downto 0);
signal ALU_OUT_MEM_WB_SIG :  std_logic_vector( 31 downto 0);
signal MEM_OUT_MEM_WB_SIG :  std_logic_vector (31 downto 0);


-- FORWARD UNIT SIGNALS
signal ControlMux1OfALU_FORWANT_UNIT_SIG :   std_logic_vector(1 downto 0);
signal ControlMux2OfALU_FORWANT_UNIT_SIG :   std_logic_vector(1 downto 0);

signal OutputMux1OfALU_SIG :   std_logic_vector(31 downto 0);
signal OutputMux2OfALU_SIG :   std_logic_vector(31 downto 0);

-- STALL UNIT SIGNALS

signal IF_DEC_WR_EN_STALL_SIG:  std_logic ;
signal PC_LD_EN_STALL_SIG:   std_logic ;
signal KILL_WR_EN_SIGNALS_STALL_SIG :  std_logic ;


signal IS_RF_WR_EN_DISABLED_SIG :  std_logic ;
signal IS_MEM_WR_EN_DISABLED_SIG :  std_logic ;





begin



IFSTAGE_mod : IFSTAGE
              Port Map(PC_Immed => (others => '0'),
                       PC_sel => '0',
                       PC_LdEn => PC_LD_EN_STALL_SIG,
                       Reset => PC_RESET,
                       Clk => CLOCK,
                       PC => PC );

							  
STALL_UNIT_mod : STALL_UNIT 
port map  (

	Instr_IF_STAGE  => Instr,
	Intr_DEC_STAGE  =>  instr_out_if_dex_reg_sig,
	Reset  => PC_RESET,  
	Clk => CLOCK,
	
	IF_DEC_WR_EN =>  IF_DEC_WR_EN_STALL_SIG,
	PC_LD_EN =>  PC_LD_EN_STALL_SIG  ,
	KILL_WR_EN_SIGNALS =>  KILL_WR_EN_SIGNALS_STALL_SIG

);

							  
IF_DEC_REGISTER_mod :  IF_DEC_REGISTER
port  map (
	Instr =>  Instr  , 
	Clk   =>   CLOCK , 
	wr_en =>   IF_DEC_WR_EN_STALL_SIG,
	Instr_out =>   instr_out_if_dex_reg_sig 
);

InstrToControl <= instr_out_if_dex_reg_sig;

DECSTAGE_mod : DECSTAGE
               Port Map(Instr => instr_out_if_dex_reg_sig,
						      Awr => RD_OUT_MEM_WB_SIG ,
                        RF_Wr_En => RF_WR_EN_OUT_MEM_WB_SIG,     -- from wb
                        ALU_out => ALU_OUT_MEM_WB_SIG,  --from wb
                        MEM_out => MEM_OUT_MEM_WB_SIG,   --from wb
                        RF_Wr_Data_sel => RF_WDATA_SEL_OUT_MEM_WB_SIG, --from wb
                        RF_B_sel => RF_B_SEL, --from wb
                        Clk => CLOCK,
                        Immed => immed_sig,
                        RF_A => rf_a_out,
                        RF_B => rf_b_out);
								
IS_RF_WR_EN_DISABLED_SIG <= RF_WR_EN AND KILL_WR_EN_SIGNALS_STALL_SIG ;
IS_MEM_WR_EN_DISABLED_SIG <=  MEM_WE_EN AND KILL_WR_EN_SIGNALS_STALL_SIG ; 
				
DEX_EX_REGISTER_mod :  DEX_EX_REGISTER 
							port map (
							RF_WR_EN =>    IS_RF_WR_EN_DISABLED_SIG, 
							RF_WDATA_SEL =>  RF_WDATA_SEL, 
							ALU_BIN_SEL =>  ALU_BIN_SEL  , 
							ALU_FUNC =>    ALU_FUNC, 
							MEM_WE_EN =>   IS_MEM_WR_EN_DISABLED_SIG, 
							BYTEOP =>  BYTEOP , 
							INSTR =>   instr_out_if_dex_reg_sig , 
							RS=>   instr_out_if_dex_reg_sig(25 downto 21), 
							RT=>   instr_out_if_dex_reg_sig(15 downto 11), 
							RD=>   instr_out_if_dex_reg_sig(20 downto 16), 
							IMMED=>  immed_sig , 
							Clk =>   CLOCK,
							RFA =>   rf_a_out , 
							RFB =>   rf_b_out ,

							RF_WR_EN_OUT =>  RF_WR_EN_OUT_DEC_EX_SIG , 
							RF_WDATA_SEL_OUT =>  RF_WDATA_SEL_OUT_DEC_EX_SIG , 
							ALU_BIN_SEL_OUT =>    ALU_BIN_SEL_OUT_DEC_EX_SIG, 
							ALU_FUNC_OUT =>   ALU_FUNC_OUT_DEC_EX_SIG, 
							MEM_WE_EN_OUT =>  MEM_WE_EN_OUT_DEC_EX_SIG , 
							BYTEOP_OUT =>  BYTEOP_OUT_DEC_EX_SIG , 
							INSTR_OUT =>  INSTR_OUT_DEC_EX_SIG , 
							RS_OUT =>   RS_OUT_DEC_EX_SIG, 
							RT_OUT =>  RT_OUT_DEC_EX_SIG , 
							RD_OUT =>   RD_OUT_DEC_EX_SIG, 
							IMMED_OUT =>  IMMED_OUT_DEC_EX_SIG , 
							RFA_OUT =>    RFA_OUT_DEC_EX_SIG  , 
							RFB_OUT =>   RFB_OUT_DEC_EX_SIG  

							);
	
ALU_TOP_MUX_mod : MUX4_1
    Port map ( a => ALU_OUT_EX_MEM_SIG,             
           b =>  ALU_OUT_MEM_WB_SIG ,
           c =>  RFA_OUT_DEC_EX_SIG,
           d =>  MEM_OUT_MEM_WB_SIG,
           Control =>  ControlMux1OfALU_FORWANT_UNIT_SIG , 
           output =>  OutputMux1OfALU_SIG   
			  );

ALU_DOWN_MUX_mod : MUX4_1
    Port map ( a =>  ALU_OUT_EX_MEM_SIG,
           b =>  ALU_OUT_MEM_WB_SIG,
           c => RFB_OUT_DEC_EX_SIG,
           d => MEM_OUT_MEM_WB_SIG,
           Control => ControlMux2OfALU_FORWANT_UNIT_SIG,
           output =>  OutputMux2OfALU_SIG 
			  );
							
								
ALUSTAGE_mod : EXSTAGE
               Port Map(RF_A => OutputMux1OfALU_SIG,
                        RF_B => OutputMux2OfALU_SIG,
                        Immed => IMMED_OUT_DEC_EX_SIG,
                        ALU_Bin_sel => ALU_BIN_SEL_OUT_DEC_EX_SIG, 
                        ALU_func => ALU_FUNC_OUT_DEC_EX_SIG,
								ALU_zero =>   ZERO,
								ALU_ovf => ALU_OVF, 
                        ALU_out => alu_out_sig);
								
								
EX_MEM_REGISTER_mod :  EX_MEM_REGISTER 
port map (
	RF_WR_EN =>    RF_WR_EN_OUT_DEC_EX_SIG, 
	RF_WDATA_SEL =>   RF_WDATA_SEL_OUT_DEC_EX_SIG, 
	MEM_WE_EN =>   MEM_WE_EN_OUT_DEC_EX_SIG, 
	BYTEOP =>  BYTEOP_OUT_DEC_EX_SIG , 
	INSTR =>  INSTR_OUT_DEC_EX_SIG , 
	RS=> RS_OUT_DEC_EX_SIG  , 
	RT=>  RT_OUT_DEC_EX_SIG , 
	RD=>   RD_OUT_DEC_EX_SIG, 
	IMMED=>  IMMED_OUT_DEC_EX_SIG , 
	ALU =>   alu_out_sig, 
	Clk =>   CLOCK, 
	RFB =>  RFB_OUT_DEC_EX_SIG,


	RF_WR_EN_OUT =>   RF_WR_EN_OUT_EX_MEM_SIG, 
	RF_WDATA_SEL_OUT =>  RF_WDATA_SEL_OUT_EX_MEM_SIG , 
	MEM_WE_EN_OUT =>  MEM_WE_EN_OUT_EX_MEM_SIG , 
	BYTEOP_OUT =>  BYTEOP_OUT_EX_MEM_SIG , 
	INSTR_OUT =>   INSTR_OUT_EX_MEM_SIG , 
	RS_OUT =>  RS_OUT_EX_MEM_SIG , 
	RT_OUT => RT_OUT_EX_MEM_SIG  , 
	RD_OUT => RD_OUT_EX_MEM_SIG , 
	IMMED_OUT => IMMED_OUT_EX_MEM_SIG  , 
	ALU_OUT =>  ALU_OUT_EX_MEM_SIG  , 
	RFB_OUT => RFB_OUT_MEM_SIG

);


		
MEM_mod : MEMSTAGE
          Port Map(
			 		
						ByteOp  =>  BYTEOP_OUT_EX_MEM_SIG  , 
						Mem_WrEn  =>  MEM_WE_EN_OUT_EX_MEM_SIG  ,
						ALU_MEM_Addr =>  ALU_OUT_EX_MEM_SIG   , 
						MEM_DataIn =>  RFB_OUT_MEM_SIG  ,
						MEM_DataOut =>   mem_output_sig , 
						MM_WrEn  =>   MM_Wr_EN ,
						MM_Addr =>   MEM_Addr  ,    
						MM_WrData =>  MEM_WrData   ,
						MM_RdData =>   MEM_RdData 
						);
						
						

MEM_WB_REGISTER_mod : MEM_WB_REGISTER 
port map (
	RF_WR_EN =>   RF_WR_EN_OUT_EX_MEM_SIG, 
	RF_WDATA_SEL =>    RF_WDATA_SEL_OUT_EX_MEM_SIG, 
	INSTR =>   INSTR_OUT_EX_MEM_SIG , 
	RS=>  RS_OUT_EX_MEM_SIG , 
	RT=>  RT_OUT_EX_MEM_SIG , 
	RD=>   RD_OUT_EX_MEM_SIG, 
	IMMED=>  IMMED_OUT_EX_MEM_SIG , 
	ALU =>   ALU_OUT_EX_MEM_SIG, 
	MEM =>   mem_output_sig, 
	Clk =>   CLOCK, 


	RF_WR_EN_OUT =>  RF_WR_EN_OUT_MEM_WB_SIG  , 
	RF_WDATA_SEL_OUT =>  RF_WDATA_SEL_OUT_MEM_WB_SIG , 
	BYTEOP_OUT =>  BYTEOP_OUT_MEM_WB_SIG , 
	INSTR_OUT =>  INSTR_OUT_MEM_WB_SIG  , 
	RS_OUT =>  RS_OUT_MEM_WB_SIG , 
	RT_OUT =>  RT_OUT_MEM_WB_SIG , 
	RD_OUT =>   RD_OUT_MEM_WB_SIG, 
	IMMED_OUT =>  IMMED_OUT_MEM_WB_SIG , 
	ALU_OUT =>  ALU_OUT_MEM_WB_SIG  , 
	MEM_OUT =>  MEM_OUT_MEM_WB_SIG  


);			

FORWARD_UNIT_mod : FORWARD_UNIT
port map (
	registerToWriteOneCycleAhead =>  RD_OUT_EX_MEM_SIG,  
	registerToWriteTwoCycleAhead =>  RD_OUT_MEM_WB_SIG, 
	Instr => INSTR_OUT_DEC_EX_SIG , 
	InstrOneCycleAhead => INSTR_OUT_EX_MEM_SIG,
	InstrTwoCycleAhead => INSTR_OUT_MEM_WB_SIG,
	RF_WR_EN_OneCycleAhead => RF_WR_EN_OUT_EX_MEM_SIG , 
	RF_WR_EN_TwoCycleAhead => RF_WR_EN_OUT_MEM_WB_SIG, 
	ControlMux1OfALU => ControlMux1OfALU_FORWANT_UNIT_SIG,  
	ControlMux2OfALU => ControlMux2OfALU_FORWANT_UNIT_SIG, 
	Clk => CLOCK 
);

						 

end Behavioral;

