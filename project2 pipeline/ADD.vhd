
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ADD is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Ot : out  STD_LOGIC_VECTOR (31 downto 0);
           OVF : out  STD_LOGIC;
			  Z : out  STD_LOGIC;
           COUT : out  STD_LOGIC);
end ADD;

architecture Behavioral of ADD is
signal output,x,y : std_logic_vector (32 downto 0);

begin
Ot<=A+B;

x(31 downto 0)<=A;
x(32)<='0';
y(31 downto 0)<=B;
y(32)<='0';
output<=x+y;

cout_pr : process(output)
begin
if(output(32)='1') then COUT<='1';
else COUT<='0';
end if;
end process cout_pr;

ovf_pr : process(x,y,output)
begin
if(x(31)=y(31) and y(31)/=output(31)) then OVF<='1';
else OVF<='0';
end if;
end process ovf_pr; 

z_pr : process(output)
begin
if(output(31 downto 0)="00000000000000000000000000000000") then Z<='1';
else Z<='0';
end if;
end process z_pr;

end Behavioral;

