
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity REG is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end REG;

architecture Behavioral of REG is
signal temp : std_logic_vector (31 downto 0) :="00000000000000000000000000000000";
begin

Process
Begin 
 
Wait until( CLOCK'EVENT and CLOCK = '1' );     
If (WE = '1') then  temp<=Din;     
else temp<=temp;     
End if;   

End process ;
Dout<=temp ;
end Behavioral;


