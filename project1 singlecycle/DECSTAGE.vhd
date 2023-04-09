
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_En : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_Wr_Data_sel : in STD_LOGIC_VECTOR (1 downto 0);
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is
component RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end component;

component MUX4_1 is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : in  STD_LOGIC_VECTOR (31 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           Control : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component mux_instr is
    Port ( X : in  STD_LOGIC_VECTOR (4 downto 0);
           Y : in  STD_LOGIC_VECTOR (4 downto 0);
           C : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (4 downto 0));
end component;
component Immed_calculator is
    Port ( Immed_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal mux_out : STD_LOGIC_VECTOR (4 downto 0);
signal mux_out2 : STD_LOGIC_VECTOR (31 downto 0);
signal immed_calculator_output : STD_LOGIC_VECTOR (31 downto 0);
signal op : STD_LOGIC_VECTOR (5 downto 0);

begin
RF_DEC : RF
		Port map( Ard1 => Instr(25 downto 21) ,
                Ard2 => mux_out,
                Awr => Instr(20 downto 16),
                Dout1 => RF_A ,
                Dout2 => RF_B,
                Din => mux_out2,
                WrEn => RF_Wr_En,
                Clk => Clk);

MUX1 : mux_instr
      Port map(X=>Instr(15 downto 11),
               Y=>Instr(20 downto 16),
               C=>RF_B_sel,
               Z=>mux_out);
MUX2 : MUX4_1
      Port map(a => immed_calculator_output,
					b=>ALU_out,
               c=>MEM_out,
					d=>(others=>'0'),
					Control=>RF_Wr_Data_sel,
					output => mux_out2 );	
Immed_mod : Immed_calculator
        	Port map(Immed_in=>Instr(15 downto 0),
                  Opcode=>Instr(31 downto 26),
                  Immed_out=>immed_calculator_output);	

Immed <= immed_calculator_output		;				
end Behavioral;

