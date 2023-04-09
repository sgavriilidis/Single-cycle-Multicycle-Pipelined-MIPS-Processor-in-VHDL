library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PROC_SC is
   Port ( Clk : in STD_LOGIC;
			 rst : in STD_LOGIC
			);
end PROC_SC;

architecture Behavioral of PROC_SC is

component DATAPATH is
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
			  PC  : out STD_LOGIC_VECTOR(31 downto 0)
			  
			  );
end component;


component CONTROL is
    Port ( PC_SEL : out  STD_LOGIC;
           PC_LDEN : out  STD_LOGIC;
			  RESET : in  STD_LOGIC;
			  CLOCK : in  STD_LOGIC;
			  RF_WR_EN : out STD_LOGIC;
			  RF_B_SEL : out  STD_LOGIC;
			  RF_WDATA_SEL : out  STD_LOGIC_VECTOR(1 downto 0);
			  ALU_BIN_SEL : out  STD_LOGIC;
			  ALU_FUNC : out  STD_LOGIC_VECTOR(3 downto 0);
			  MEM_WE_EN : out  STD_LOGIC;
			  BYTEOP : out  STD_LOGIC;
			  ZERO : in  STD_LOGIC;
			  ALU_OVF : in  STD_LOGIC;
			  INSTR : in STD_LOGIC_VECTOR(31 downto 0));
end component;

component RAM is
port (
clk : in std_logic;
inst_addr : in std_logic_vector(10 downto 0);
inst_dout : out std_logic_vector(31 downto 0);
data_we : in std_logic;
data_addr : in std_logic_vector(10 downto 0);
data_din : in std_logic_vector(31 downto 0);
data_dout : out std_logic_vector(31 downto 0));
end component;


signal PC_SEL_SIG : STD_LOGIC;
signal PC_LDEN_SIG :  STD_LOGIC;
signal PC_RESET_SIG : STD_LOGIC;
signal RF_WR_EN_SIG : STD_LOGIC;
signal RF_B_SEL_SIG : STD_LOGIC;
signal RF_WDATA_SEL_SIG : STD_LOGIC_VECTOR(1 downto 0);
signal ALU_BIN_SEL_SIG  : STD_LOGIC;
signal ALU_FUNC_SIG : STD_LOGIC_VECTOR(3 downto 0);
signal MEM_WE_EN_SIG :STD_LOGIC;
signal BYTEOP_SIG :STD_LOGIC;
signal ZERO_SIG :STD_LOGIC;
signal ALU_OVF_SIG :STD_LOGIC;
signal INSTR_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal MEM_DATA_OUT_TO_DATAPATH_SIG:  STD_LOGIC_VECTOR(31 downto 0);
signal MEM_INSTR_OUT_TO_DATAPATH_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal PC_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal MEM_ADDRESS_SIG:   STD_LOGIC_VECTOR(31 downto 0);
signal MEM_WRDATA_SIG :  STD_LOGIC_VECTOR(31 downto 0);
signal MEM_WRDATA_SIG_12BITS :  STD_LOGIC_VECTOR(10 downto 0);

begin




TheControl: CONTROL 
    Port map( 
			  PC_SEL =>       PC_SEL_SIG  , 
           PC_LDEN => 	   PC_LDEN_SIG   , 
			  RESET =>        rst  , 
			  CLOCK =>        Clk , 
			  RF_WR_EN =>     RF_WR_EN_SIG  , 
			  RF_B_SEL =>     RF_B_SEL_SIG , 
			  RF_WDATA_SEL => RF_WDATA_SEL_SIG , 
			  ALU_BIN_SEL =>  ALU_BIN_SEL_SIG , 
			  ALU_FUNC =>     ALU_FUNC_SIG  , 
			  MEM_WE_EN =>    MEM_WE_EN_SIG , 
			  BYTEOP =>       BYTEOP_SIG , 
			  ZERO =>         ZERO_SIG , 
			  ALU_OVF =>          ALU_OVF_SIG,
			  INSTR =>        MEM_INSTR_OUT_TO_DATAPATH_SIG  
			  );
			  
MEM_WRDATA_SIG_12BITS <= MEM_ADDRESS_SIG(12 downto 2) + "10000000000";


TheCommon_RAM: RAM 
		port map(
		clk =>   Clk  , 
		inst_addr =>  PC_SIG(12 downto 2) , 
		inst_dout =>  MEM_INSTR_OUT_TO_DATAPATH_SIG   , 
		data_we =>    MEM_WE_EN_SIG, 
		data_addr =>  MEM_WRDATA_SIG_12BITS , 
		data_din =>   MEM_WRDATA_SIG , 
		data_dout =>  MEM_DATA_OUT_TO_DATAPATH_SIG  

		);


			  
TheDatapath :  DATAPATH 
    port map ( 
			  PC_SEL =>           PC_SEL_SIG  , 
           PC_LDEN =>   		 PC_LDEN_SIG , 
			  PC_RESET =>  		 rst , 
			  CLOCK =>   			 Clk , 
			  RF_WR_EN =>  		 RF_WR_EN_SIG, 
			  RF_B_SEL =>  		 RF_B_SEL_SIG, 
			  RF_WDATA_SEL => 	 RF_WDATA_SEL_SIG  , 
			  ALU_BIN_SEL => 		 ALU_BIN_SEL_SIG  , 
			  ALU_FUNC =>  		 ALU_FUNC_SIG , 
			  MEM_WE_EN =>  		 MEM_WE_EN_SIG, 
			  BYTEOP =>  			 BYTEOP_SIG , 
			  MEM_RdData =>   	 MEM_DATA_OUT_TO_DATAPATH_SIG,
			  Instr =>      		 MEM_INSTR_OUT_TO_DATAPATH_SIG,
			  MEM_Addr => 			 MEM_ADDRESS_SIG,
			  MEM_WrData =>       MEM_WRDATA_SIG, 
			  ZERO =>             ZERO_SIG ,
			  ALU_OVF =>          ALU_OVF_SIG,
			  PC  =>              PC_SIG
);

end Behavioral;

