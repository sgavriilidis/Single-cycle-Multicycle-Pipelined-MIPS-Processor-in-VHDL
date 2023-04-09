
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FORWARD_UNIT is
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


end FORWARD_UNIT;

architecture Behavioral of FORWARD_UNIT is

begin
	process ( registerToWriteOneCycleAhead, registerToWriteTwoCycleAhead,  Instr, InstrOneCycleAhead, 
											InstrTwoCycleAhead, RF_WR_EN_OneCycleAhead, RF_WR_EN_TwoCycleAhead)
	begin	

	if ( RF_WR_EN_TwoCycleAhead = '1'  and  registerToWriteTwoCycleAhead = Instr (25 downto 21)  and  InstrTwoCycleAhead(31 downto 26)="001111"
	and    InstrTwoCycleAhead(31 downto 26)= "000011" ) then -- lw/lb -- stall + 2 cycle forwarding 
		ControlMux1OfALU <= "11" ;
	elsif ( RF_WR_EN_OneCycleAhead = '1'  and  registerToWriteOneCycleAhead = Instr (25 downto 21) ) then
		ControlMux1OfALU <= "00" ; 
	elsif ( RF_WR_EN_TwoCycleAhead = '1'  and  registerToWriteTwoCycleAhead = Instr (25 downto 21) ) then
		ControlMux1OfALU <= "01" ; 
	else 
		ControlMux1OfALU <= "10" ; 
	end if ; 

	if ( RF_WR_EN_TwoCycleAhead = '1'  and  registerToWriteTwoCycleAhead = Instr (15 downto 11)  and  InstrTwoCycleAhead(31 downto 26)="001111"
	and    InstrTwoCycleAhead(31 downto 26)= "000011" ) then
	ControlMux2OfALU <= "11" ;-- lw/lb -- stall + 2 cycle forwarding  
	elsif ( RF_WR_EN_OneCycleAhead = '1'  and  registerToWriteOneCycleAhead = Instr (15 downto 11) ) then
	ControlMux2OfALU <= "00" ; 
	elsif ( RF_WR_EN_TwoCycleAhead = '1'  and  registerToWriteTwoCycleAhead = Instr (15 downto 11) ) then
	ControlMux2OfALU <= "01" ; 
	else 
	ControlMux2OfALU <= "10" ; 
	end if ; 
	
	
	
	end process;	


end Behavioral;

