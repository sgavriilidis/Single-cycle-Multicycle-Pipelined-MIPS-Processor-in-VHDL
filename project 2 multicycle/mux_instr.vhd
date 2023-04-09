
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity mux_instr is
    Port ( X : in  STD_LOGIC_VECTOR (4 downto 0);
           Y : in  STD_LOGIC_VECTOR (4 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (4 downto 0));
end mux_instr;

architecture Behavioral of mux_instr is

begin

Z <= X when C='0' else Y;

end Behavioral;

