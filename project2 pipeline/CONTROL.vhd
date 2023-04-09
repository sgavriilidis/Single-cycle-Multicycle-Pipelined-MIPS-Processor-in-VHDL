library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
Port ( PC_SEL : out  STD_LOGIC;
PC_LDEN : out  STD_LOGIC;
RESET : in  STD_LOGIC;
CLOCK : in  STD_LOGIC;
RF_WR_EN : out STD_LOGIC;
RF_B_SEL : out  STD_LOGIC;
RF_WDATA_SEL : out  STD_LOGIC;
ALU_BIN_SEL : out  STD_LOGIC;
ALU_FUNC : out  STD_LOGIC_VECTOR(3 downto 0);
MEM_WE_EN : out  STD_LOGIC;
BYTEOP : out  STD_LOGIC;
ZERO : in  STD_LOGIC;
ALU_OVF: in  STD_LOGIC;
INSTR : in STD_LOGIC_VECTOR(31 downto 0));
end CONTROL;
architecture Behavioral of CONTROL is

signal MyOpCode : STD_LOGIC_VECTOR(5 downto 0);
begin


MyOpCode <= INSTR (31 downto 26) ; 


ALU_BIN_SEL <= '1' when  MyOpCode /= "100000"    else 															 -- On rtype enable second input of ALU 
'0';																						


																																												 
ALU_FUNC <= 	 "0000" when  MyOpCode = "110000"  else 															 -- Change ALU_OP when I have 1: addi 
"0101"	when   MyOpCode = "110010"  else                                                          --  nandi
"0011"	when   MyOpCode = "110011"   else 														       			 -- ori
"0001"	when   MyOpCode = "110000"  else 															   			 -- branches		
INSTR(3 downto 0) when  MyOpCode = "100000"  else 																	 -- rtype 
"1111"            when MyOpCode = "111000" or  MyOpCode ="111001" else 
"0000";

BYTEOP <=  '1' when    (MyOpCode = "000111" or MyOpCode = "000011")  else 								 -- memory signal = 1 for sb/lb
'0';																																											 -- =0 for sw/lw


MEM_WE_EN <=    '1' when   (MyOpCode = "000111" or MyOpCode= "011111" ) AND RESET/='1'  else            --enable write memory to store byte/word 
'0';


RF_B_SEL <= '0' when  (MyOpCode = "100000" or MyOpCode = "000000")    else                          -- on rtype/branch equal  select rd
'1' ;												                                                                                              --else select rd

RF_WR_EN <= '1' when  MyOpCode /= "000000" and MyOpCode /="000001" and                                                               -- enable writing to registers when I have branches
							  MyOpCode /= "000111" and MyOpCode /="011111"	AND RESET/='1' else                          -- enable writing to registers when I have  sw/sb
'0' ;


PC_LDEN <= '1' when RESET/='1' else        																								 -- enable load to memory when not reset 
'0' ;


PC_SEL <= '1' when   (MyOpCode = "000000" or MyOpCode ="000001")  else 										 --pc_select for ifstage when I have branches
'0' ;


RF_WDATA_SEL <=  '1' when  (MyOpCode = "000011" or MyOpCode = "001111" )    else                 
'0';	-- alu elsewhere



end Behavioral;

