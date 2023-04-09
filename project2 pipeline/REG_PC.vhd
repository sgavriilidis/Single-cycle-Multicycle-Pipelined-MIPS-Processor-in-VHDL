
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity REG_PC is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           We : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end REG_PC;

architecture Behavioral of REG_PC is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";

begin

Process
Begin 
 
Wait until( CLOCK'EVENT and CLOCK = '1' );     
 
if (Rst='1') then temp<="00000000000000000000000000000000";
elsIf (WE = '1') then  temp<=Din;    
else temp<=temp;     
End if;   

End process ;
Dout<=temp; 

end Behavioral;


