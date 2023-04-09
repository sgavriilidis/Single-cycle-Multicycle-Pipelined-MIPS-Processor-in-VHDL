----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:06:42 03/25/2022 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

library work;
use work.myDataTypes.ALL;


entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is



Component DECODER_5to32 is
    Port ( Input : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;
Component REG is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;
Component MUX32 is
    Port ( X : in array32;
           Y : out  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (4 downto 0));
end component;




signal out_dec : std_logic_vector (31 downto 0);
signal sig_we,reg_out : std_logic_vector (31 downto 0);
signal we : std_logic_vector (31 downto 0);
signal mux_out,mux_out2 : std_logic_vector (31 downto 0);
signal sig_in_mux32 : array32;
signal zeros : std_logic_vector (31 downto 0);
begin

DEC:  DECODER_5to32
       Port map( Input=>Awr, 
                 Output=>out_dec);
				  
REG0: REG
        Port map(Din=>zeros, 
                 WE=>'1', 
                 CLOCK=>Clk, 
					  Dout=>sig_in_mux32(0));
GEN_REGS :
        for i in 1 to 31 generate
		  we(i) <= WrEn AND out_dec(i);
		  Regs : REG 
		          Port Map (CLOCK=>Clk,
								  Din=>Din,
								  WE=>we(i),
								  Dout=>sig_in_mux32(i));
	    end generate;


  
	
MUX32_1 : MUX32
           Port map(X=>sig_in_mux32,
                    Y =>Dout1 , 
                    C=>Ard1); 
MUX32_2 : MUX32
           Port map(X=>sig_in_mux32,
                    Y=>Dout2, 
                    C=>Ard2); 	
						  
zeros<="00000000000000000000000000000000";				  


end Behavioral;

