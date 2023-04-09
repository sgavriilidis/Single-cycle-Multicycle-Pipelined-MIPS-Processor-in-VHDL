
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
Component REG_PC is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           We : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component INCREMENTOR is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component ADDER_IF is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           Z : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component MUX2_1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           E : out  STD_LOGIC_VECTOR (31 downto 0));
end component;



signal pc_4,add_out,mux_out,pc_out : std_logic_vector (31 downto 0);
begin

ADDER : ADDER_IF
        Port map( X=>PC_Immed,
                  Y=>pc_4,
                  Z=>add_out);

MUX : MUX2_1
      Port map( X=>pc_4,
                Y=>add_out,
                C=>PC_Sel,
                E=>mux_out);	

PC_REG : REG_PC
     Port map( Din=>mux_out,
            We=>PC_LdEn,
            Rst=>Reset,
            Clock=>Clk,
            Dout=>pc_out );
				
Increment : INCREMENTOR
             Port map( A=>pc_out,
                    B=>pc_4);
						  
PC <= pc_out ;
						  
						  


			 
end Behavioral;

