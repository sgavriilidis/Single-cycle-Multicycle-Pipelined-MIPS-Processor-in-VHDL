----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:28:46 03/25/2022 
-- Design Name: 
-- Module Name:    MUX32 - Behavioral 
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

use IEEE.NUMERIC_STD.ALL;
library work;
use work.myDataTypes.ALL;



entity MUX32 is
    Port ( X : in  array32;
           Y : out  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (4 downto 0));
end MUX32;

architecture Behavioral of MUX32 is

begin

Y <= X (to_integer(unsigned(C))) ;

end Behavioral;

