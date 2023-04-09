library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL is
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
ALU_OVF: in  STD_LOGIC;
INSTR : in STD_LOGIC_VECTOR(31 downto 0));
end CONTROL;
architecture Behavioral of CONTROL is



type state_type is (state_reset, Instr_reading,rtype,rtype2,load_Immed,immed_op,immed_op2,branches,branches2,to_load,to_load2,to_load3,to_store,to_store2,to_store3, write_state );
signal current_state :state_type;



begin

process 
	begin
			WAIT UNTIL CLOCK'EVENT AND CLOCK='1';
			if RESET='1' then
				PC_LDEN <= '0';
				MEM_WE_EN <=    '0';
				RF_WR_EN 	<= '0';
				current_state <= state_reset;
			else 
				case current_state is 
					 when state_reset =>  
						 current_state <=Instr_reading;
					 
					 when Instr_reading =>

						 MEM_WE_EN  <= '0';
						 PC_LDEN <= '0';
						 PC_SEL <= '0';
						 RF_WR_EN <= '0';

						 ----------- rtype
						 if INSTR (31 downto 26) =  "100000"  then 
							RF_B_SEL <= '0';
							current_state	<= rtype;
			
						 ----------- li-lui 
						 elsif  INSTR (31 downto 26) = "111000" or INSTR (31 downto 26) ="111001" then
							RF_B_SEL <= '1';
							current_state	<= load_Immed;
							
						 ----------- addi-andi-ori
						 elsif INSTR (31 downto 26) = "110000" or INSTR (31 downto 26) = "110010" or INSTR (31 downto 26) = "110011" then
							RF_B_SEL <= '1';
							current_state	<= immed_op;
					
						 ----------- branches
						 elsif INSTR (31 downto 26) = "111111" or INSTR (31 downto 26) = "000000" or INSTR (31 downto 26) = "000001" then
							RF_WR_EN 	<= '0';
							RF_B_SEL <= '0';
							PC_SEL <= '1' ;
							ALU_FUNC <= 	 "0001";
							current_state	<= branches;
							
						 ----------- lb-lw
						 elsif INSTR (31 downto 26) = "000011" or INSTR (31 downto 26) = "001111" then
						 	RF_B_SEL <= '1';
							current_state	<= to_load;
						  
						 ----------- sb-sw 
						 elsif INSTR (31 downto 26) = "000111" or INSTR (31 downto 26) = "011111" then
						 RF_B_SEL <= '1';
						 current_state	<= to_store;
					 
						end if;
					
					----------- rtype
					when rtype =>
							ALU_BIN_SEL <= '0';
							ALU_FUNC <= INSTR(3 downto 0);
							current_state	<= rtype2;
					when rtype2 =>
							PC_LDEN <= '1';
							RF_WR_EN 	<= '1';
							RF_WDATA_SEL <= "01" ;
							current_state	<= write_state;

					----------- li-lui 
					when load_Immed =>
						PC_LDEN <= '1';
						RF_WR_EN 	<= '1';
						RF_WDATA_SEL <= "00" ;
						current_state	<= write_state;
		
					----------- addi-andi-ori
					when immed_op =>
							if INSTR (31 downto 26) = "110000" then--addi
								ALU_FUNC <=   "0000";
							elsif INSTR (31 downto 26) = "110010" then --nandi
								ALU_FUNC <= 	 "0101";
							elsif INSTR (31 downto 26) = "110011" then --ori
								ALU_FUNC <= 	"0011" ;
							end if;
							ALU_BIN_SEL <= '1' ;
							current_state	<= immed_op2;
							
					when immed_op2 =>
						RF_WR_EN 	<= '1';
						RF_WDATA_SEL <= "01" ;
						PC_LDEN <= '1';
						current_state	<= write_state;
					----------- branches	
					when branches =>
						current_state	<= branches2;
					when branches2 =>	
						current_state	<= write_state;
					----------- lb-lw	
					when to_load =>
						ALU_FUNC <=   "0000";
						ALU_BIN_SEL <= '1' ;
						current_state	<=to_load2;
						
					when to_load2 =>
						MEM_WE_EN  <= '0';
						if  INSTR (31 downto 26) = "000011" then--lb
							BYTEOP <=  '1';
						elsif INSTR (31 downto 26) = "001111" then--lw
							BYTEOP <=  '0';
						end if;	

						current_state	<=to_load3;
					when to_load3 =>
						RF_WR_EN 	<= '1';
						RF_WDATA_SEL <= "10" ;
						PC_LDEN <= '1';
						current_state	<= write_state;
					----------- sb-sw 
					when to_store =>
						ALU_FUNC <=   "0000";
						current_state	<=to_store2;
					when to_store2 =>
							MEM_WE_EN <=    '1';
						if  INSTR (31 downto 26) = "000111" then--sb
							BYTEOP <=  '1';
						elsif INSTR (31 downto 26) = "011111" then--sw
							BYTEOP <=  '0';
						end if;
						PC_LDEN <= '1';
						current_state	<= write_state;
					when write_state =>
					   MEM_WE_EN  <= '0';
						 PC_LDEN <= '0';
						 PC_SEL <= '0';
						 RF_WR_EN <= '0';
						current_state	<= Instr_reading;
					when others =>
						current_state	<= Instr_reading;

				end case;
		end if;			
	end process;

end Behavioral;

