
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MEMSTAGE is
port (

ByteOp : in STD_LOGIC ;
Mem_WrEn : in STD_LOGIC ;
ALU_MEM_Addr : in   STD_LOGIC_VECTOR (31 downto 0);
MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
MEM_DataOut  :out  STD_LOGIC_VECTOR (31 downto 0);
MM_WrEn  : out STD_LOGIC ;
MM_Addr : out   STD_LOGIC_VECTOR (31 downto 0);
MM_WrData : out   STD_LOGIC_VECTOR (31 downto 0);
MM_RdData : in   STD_LOGIC_VECTOR (31 downto 0)
);
end MEMSTAGE;




architecture Behavioral of MEMSTAGE is



Component MUX2_1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC;
           E : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal MEMSTAGE_ADDRESS_TO_RAM :  STD_LOGIC_VECTOR (10 downto 0);
signal MEMOUTPUT_TO_SELECT_BYTES :  STD_LOGIC_VECTOR (31 downto 0);
signal EXTRACT_ONLY_LAST_8_BITS_LOAD :  STD_LOGIC_VECTOR (31 downto 0);
signal EXTRACT_ONLY_LAST_8_BITS_STORE :  STD_LOGIC_VECTOR (31 downto 0);


begin

-- get the last 1024 ram cells 
MM_Addr  <= ALU_MEM_Addr;
EXTRACT_ONLY_LAST_8_BITS_STORE <= "000000000000000000000000"& MEM_DataIn(7 downto 0);
EXTRACT_ONLY_LAST_8_BITS_LOAD <= "000000000000000000000000"& MM_RdData(7 downto 0);

select_bytes_mux_store : MUX2_1 
    port map (
			  X =>  MEM_DataIn  , 
           Y =>  EXTRACT_ONLY_LAST_8_BITS_STORE, 
           C =>  ByteOp  ,   
           E =>  MM_WrData  
			  );


select_bytes_mux_load : MUX2_1 
    port map (
			  X =>  MM_RdData  , 
           Y =>  EXTRACT_ONLY_LAST_8_BITS_LOAD, 
           C =>  ByteOp  ,   
           E =>  MEM_DataOut  
			  );


MM_WrEn  <= Mem_WrEn ;


end Behavioral;

