
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity SUB is
    Port ( C : in  STD_LOGIC_VECTOR (31 downto 0);
           D : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           ovf : out  STD_LOGIC;
           zer : out  STD_LOGIC;
           cot : out  STD_LOGIC);
end SUB;

	architecture Behavioral of SUB is
signal oput,x,y : std_logic_vector (32 downto 0);
signal f,g : std_logic_vector (31 downto 0);

begin
f<=not D;
g<=f+"00000000000000000000000000000001";
x(31 downto 0)<=C;
x(32)<='0';
y(31 downto 0)<=g;
y(32)<='1';
oput<=x+y;
Output<=oput(31 downto 0);

cout_pr : process(oput)
begin
if(oput(32)='0') then cot<='1';
else cot<='0';
end if;
end process cout_pr;

ovf_pr : process(x,y,oput)
begin
if(x(31)=y(31) and y(31)/=oput(31)) then ovf<='1';
else ovf<='0';
end if;
end process ovf_pr;

z_pr : process(oput)
begin
if(oput="00000000000000000000000000000000") then zer<='1';
else zer<='0';
end if;
end process z_pr;

end Behavioral;
