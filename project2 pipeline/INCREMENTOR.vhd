
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity INCREMENTOR is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : out  STD_LOGIC_VECTOR (31 downto 0));
end INCREMENTOR;

architecture Behavioral of INCREMENTOR is

begin

B<=A+"00000000000000000000000000000100";

end Behavioral;


