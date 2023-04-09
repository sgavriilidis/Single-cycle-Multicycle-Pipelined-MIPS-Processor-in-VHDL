library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EX_MEM_REGISTER is
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
end EX_MEM_REGISTER;

architecture Behavioral of EX_MEM_REGISTER is
begin
process
	begin
	wait until Clk 'event and Clk ='1';
		RF_WR_EN_OUT     <=   			  RF_WR_EN; 
		RF_WDATA_SEL_OUT <=     	 RF_WDATA_SEL; 
		MEM_WE_EN_OUT    <=            MEM_WE_EN; 
		BYTEOP_OUT       <=               BYTEOP; 
		INSTR_OUT        <=                INSTR; 
		RS_OUT 			  <=                   RS; 
		RT_OUT           <=                   RT; 
		RD_OUT           <=                   RD;  
		IMMED_OUT        <=                IMMED; 
		ALU_OUT          <=                  ALU;
	   RFB_OUT 			  <=						 RFB;


end process;

end Behavioral;

