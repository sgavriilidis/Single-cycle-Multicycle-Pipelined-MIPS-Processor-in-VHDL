
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity STALL_UNIT is
port (

	Instr_IF_STAGE:  in std_logic_vector(31 downto 0);
	Intr_DEC_STAGE : in std_logic_vector(31 downto 0);
	Reset  :in std_logic ;
	Clk: in std_logic ;
	
	IF_DEC_WR_EN : out std_logic ;
	PC_LD_EN:  out std_logic ;
	KILL_WR_EN_SIGNALS : out std_logic 

);
end STALL_UNIT;

architecture Behavioral of STALL_UNIT is

TYPE state is (normalState, stallState);
signal st : state;
begin
process 
begin
wait until Clk 'event and Clk ='1';

if (Reset = '1') then
		st <= normalState;	
else
		case st is 
			when normalState =>
				if (   (Intr_DEC_STAGE(31 downto 26) = "001111" or Intr_DEC_STAGE(31 downto 26) = "000011") and --  lw/lb 
				
							 (Intr_DEC_STAGE(20 downto 16)= Instr_IF_STAGE(25 downto 21)  or 
							 Intr_DEC_STAGE(20 downto 16) = Instr_IF_STAGE(15 downto 11)) 
							 ) then 
							st <= stallState;	
				end if;
			when stallState =>
					st <= normalState;	
					
	
end case;
end if;
end process;




   		PC_LD_EN <= '0' when ((Intr_DEC_STAGE(31 downto 26) = "001111" or Intr_DEC_STAGE(31 downto 26) = "000011") and --  lw/lb 
													 (Intr_DEC_STAGE(20 downto 16)= Instr_IF_STAGE(25 downto 21)  or 
													 Intr_DEC_STAGE(20 downto 16) = Instr_IF_STAGE(15 downto 11))) and st = normalState
							else '1' ;
						
							
			IF_DEC_WR_EN <= '0' when ((Intr_DEC_STAGE(31 downto 26) = "001111" or Intr_DEC_STAGE(31 downto 26) = "000011") and --  lw/lb 
									 (Intr_DEC_STAGE(20 downto 16)= Instr_IF_STAGE(25 downto 21)  or 
									 Intr_DEC_STAGE(20 downto 16) = Instr_IF_STAGE(15 downto 11))) and st = normalState
			else '1' ;
			
			
			KILL_WR_EN_SIGNALS <= '0' when ((Intr_DEC_STAGE(31 downto 26) = "001111" or Intr_DEC_STAGE(31 downto 26) = "000011") and --  lw/lb 
									 (Intr_DEC_STAGE(20 downto 16)= Instr_IF_STAGE(25 downto 21)  or 
									 Intr_DEC_STAGE(20 downto 16) = Instr_IF_STAGE(15 downto 11))) and st = normalState
			else '1' ;


end Behavioral;

