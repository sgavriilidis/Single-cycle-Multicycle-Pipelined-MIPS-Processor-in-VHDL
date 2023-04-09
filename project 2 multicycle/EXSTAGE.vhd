
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_ovf : out  STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end EXSTAGE;

architecture Behavioral of EXSTAGE is

Component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Outt : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC);
end component;

Component MUX2_1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           E : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal mux_out : std_logic_vector (31 downto 0); 
signal zco : std_logic_vector (2 downto 0); 
begin

ALU_mod : ALU 
          Port map(A=>RF_A,
                   B=>mux_out,
                   Op=>ALU_func,
                   Outt=>ALU_out,
                   Zero=>ALU_zero,
                   Cout=>open,
			          Ovf=>ALU_ovf);
ALU_mux : MUX2_1
      Port map(X=>RF_B,
               Y=>Immed,
               C=>ALU_Bin_sel,
               E=>mux_out);
end Behavioral;
