
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Immed_calculator is
    Port ( Immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Immed_calculator;

architecture Behavioral of Immed_calculator is
signal tempout : STD_LOGIC_VECTOR (31 downto 0);

begin

process(Immed_in,OpCode)
begin

--zero fill 
	if(OpCode="110010"    OR	--nandi
		OpCode = "110011"        --ori
		) then 
		tempout(31 downto 16) <= (others => '0');
		tempout(15 downto 0) <= Immed_in; 
		
--shift left 16 and zero fill		
	elsif(OpCode="111001") then    --lui
		tempout(31 downto 16) <= Immed_in;
		tempout(15 downto 0) <= (others => '0'); 
		
--sign extend
	elsif(OpCode="110000" OR --addi 
			OpCode="000011" OR --lb
			OpCode="000111" OR --sb
			OpCode="001111" OR --lw
			OpCode="011111" --sw
			) then 
			
		tempout(31 downto 16) <= (others => Immed_in(15));
		tempout(15 downto 0) <= Immed_in; 
		
		
-- shift left 2 	
	elsif(OpCode ="111111" OR --b 
		OpCode="000000" OR  --beq
		OpCode="000001") --bne
	then 
		tempout(31 downto 18) <= (others => Immed_in(15));
		tempout(17 downto 2) <= Immed_in; 
		tempout(1 downto 0) <= "00"; 
	end if;
end process;
	
Immed_out <= tempout; -- Immed 32 bits

end Behavioral;

