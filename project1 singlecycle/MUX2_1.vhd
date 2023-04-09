
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX2_1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           E : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX2_1;

architecture Behavioral of MUX2_1 is

begin
E <= X when C='0' else Y;

end Behavioral;

