
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX4_1 is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : in  STD_LOGIC_VECTOR (31 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           Control : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX4_1;

architecture Behavioral of MUX4_1 is

begin
  		with Control select
		  output <=  a when "00", 
					   b when "01", 
					   c  when "10", 
						d  when "11",
						d when others ;

end Behavioral;

