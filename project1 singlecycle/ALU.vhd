
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ALU is
 Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
        B : in  STD_LOGIC_VECTOR (31 downto 0);
        Op : in  STD_LOGIC_VECTOR (3 downto 0);
        Outt : out  STD_LOGIC_VECTOR (31 downto 0);
        Zero : out  STD_LOGIC;
        Cout : out  STD_LOGIC;
		  Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal op_add,op_sub,log_nand,log_or,log_not,op_sra,op_srl,op_sll,rotateR,rotateL : std_logic_vector(31 downto 0);
signal add_ovf,add_z,add_cout,sub_ovf,sub_z,sub_cout : std_logic;
Component ADD is     
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
       B : in  STD_LOGIC_VECTOR (31 downto 0);
       Ot : out  STD_LOGIC_VECTOR (31 downto 0);
       OVF : out  STD_LOGIC;
		 Z : out  STD_LOGIC;
       COUT : out  STD_LOGIC); 
end component;

Component SUB is     
Port ( C : in  STD_LOGIC_VECTOR (31 downto 0);
       D : in  STD_LOGIC_VECTOR (31 downto 0);
       Output : out  STD_LOGIC_VECTOR (31 downto 0);
       ovf : out  STD_LOGIC;
		 zer : out  STD_LOGIC;
       cot : out  STD_LOGIC); 
end component;

begin
ADDER : ADD
        Port map(A=>A,
		           B=>B,
					  Ot=>op_add,
					  OVF=>add_ovf,
					  Z=>add_z,
					  COUT=>add_cout);
SUBER : SUB
        Port map(C=>A,
		           D=>B,
					  Output=>op_sub,
					  ovf=>sub_ovf,
					  zer=>sub_z,
					  cot=>sub_cout);

ALU_FSM : process(Op,add_ovf,add_z,add_cout,sub_ovf,sub_z,sub_cout,op_add,op_sub)
begin
case Op is

when "0000" =>  Outt<=op_add   after 10 ns;--ADD
                Zero<=add_z	 after 10 ns;
                Ovf<=add_ovf	 after 10 ns;
                Cout<=add_cout after 10 ns;
when "0001" =>  Outt<=op_sub   after 10 ns;   --SUB
                Zero<=sub_z    after 10 ns;
                Ovf<=sub_ovf   after 10 ns;
                Cout<=sub_cout after 10 ns;
when "0010" => Outt<=A AND B   after 10 ns;  --AND
               Zero<='0'       after 10 ns;
               Ovf<='0'        after 10 ns;
               Cout<='0'       after 10 ns;
when "0011" => Outt<=A OR B  after 10 ns;   --OR
               Zero<='0'     after 10 ns;
               Ovf<='0'      after 10 ns;
               Cout<='0'     after 10 ns;
when "0100" => Outt<=NOT A  after 10 ns;   --NOT A
               Zero<='0'    after 10 ns;
               Ovf<='0'     after 10 ns;
               Cout<='0'    after 10 ns;
when "0101" => Outt<=A NAND B  after 10 ns;   --NAND
               Zero<='0'       after 10 ns;
               Ovf<='0'        after 10 ns;
               Cout<='0'       after 10 ns;
when "0110" => Outt<=A NOR B  after 10 ns;   --NOR
               Zero<='0'      after 10 ns;
               Ovf<='0'       after 10 ns;
               Cout<='0'      after 10 ns;
when "1000" => Outt(31)<=A(31) 					after 10 ns;   --SRA
               Outt(30 downto 1)<=A(31 downto 2) after 10 ns;
					Outt(0)<=A(1)                 after 10 ns;
					Zero<='0'            		 after 10 ns;
               Ovf<='0'                    after 10 ns;
               Cout<='0'                   after 10 ns;
when "1001" => Outt(31)<='0'					 	after 10 ns;    --SLR
               Outt(30 downto 1)<=A(31 downto 2) after 10 ns;
					Outt(0)<=A(1)                     after 10 ns;
					Zero<='0'                         after 10 ns;
               Ovf<='0'                          after 10 ns;
               Cout<='0'                         after 10 ns;
when "1010" => Outt(31)<=A(30) 					after 10 ns;   --SLL
               Outt(30 downto 1)<=A(29 downto 0)   after 10 ns;
					Outt(0)<='0'                       after 10 ns ;
					Zero<='0'                           after 10 ns;
               Ovf<='0'                           after 10 ns;
               Cout<='0'                            after 10 ns;
when "1100" => Outt(31)<=A(30) 					 after 10 ns;   --ROTATE LEFT
               Outt(30 downto 1)<=A(29 downto 0) after 10 ns;
					Outt(0)<=A(31)                    after 10 ns;
					Zero<='0'                          after 10 ns;
               Ovf<='0'                          after 10 ns;
               Cout<='0'                          after 10 ns;
when "1101" => Outt(31)<=A(0) 					after 10 ns;   --ROTATE RIGHT
               Outt(30 downto 1)<=A(31 downto 2) after 10 ns;
					Outt(0)<=A(1)                     after 10 ns;
               Zero<='0'                         after 10 ns;
               Ovf<='0'                          after 10 ns;
               Cout<='0'                         after 10 ns;					
when others => Outt<="00000000000000000000000000000000"  after 10 ns;
               Zero<='0'                                 after 10 ns;
               Ovf<='0'                                  after 10 ns;
               Cout<='0'                                 after 10 ns;
					
end case;



end process;

end Behavioral;