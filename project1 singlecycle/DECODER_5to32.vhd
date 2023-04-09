----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:26:02 03/25/2022 
-- Design Name: 
-- Module Name:    DECODER_5to32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity DECODER_5to32 is
    Port ( Input : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end DECODER_5to32;

architecture Behavioral of DECODER_5to32 is

begin

decode:
for i in 0 to 31 generate 
Output(i) <='1' when Input=i else '0';
end generate;

end Behavioral;

