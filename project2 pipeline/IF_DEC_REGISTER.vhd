
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity IF_DEC_REGISTER is
port (
	Instr : in std_logic_vector(31 downto 0);
	Clk   : in std_logic;
	wr_en : in std_logic;
	Instr_out: out std_logic_vector(31 downto 0)
	
	
);

end IF_DEC_REGISTER;

architecture Behavioral of IF_DEC_REGISTER is
signal temp : std_logic_vector (31 downto 0) := (others=>'0');
 begin
        process
        begin
            wait until Clk 'event and Clk ='1';
				If (wr_en = '1') then  temp<=Instr;     
				else temp<=temp;     
				End if;   

End process ;
Instr_out<=temp ;
end Behavioral;

