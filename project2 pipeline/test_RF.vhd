--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:15:03 03/26/2022 
-- Design Name:   
-- Module Name:   C:/Users/Sophocles/Desktop/HRY302/project1/test_RF.vhd
-- Project Name:  project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------

 LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 --USE ieee.numeric_std.ALL;
 
ENTITY test_RF IS
END test_RF;
 
ARCHITECTURE behavior OF test_RF IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.

      wait for Clk_period*10;
		Din <= "00000000000000000000000000000011";
		Awr <= "00011";
		WrEn <= '1';
	  wait for Clk_period;
	  	Din <= "00000000000000000000000000000001";
		Ard1 <= "00011";
		Ard2 <= "00011";
		WrEn <= '0';
		wait for Clk_period * 10;
		Din <= "00000000000000000000000000000010";
		Awr <= "00010";
		WrEn <= '1';
		  wait for Clk_period;
		  	  	Din <= "00000000000000000000000000000001";
		Ard1 <= "00010";
		Ard2 <= "00011";
		WrEn <= '0';
      -- insert stimulus here 
		
		
		Ard1 <= "00001";	
		WrEn <= '0';
      wait for 100 ns;
		Awr <= "00001";
		WrEn <='1';
		Din <="00000000000000000000000000000001";
		wait for 10 ns;
		Ard1 <= "00001";
      Ard2 <= "00001";		
		WrEn <= '0';
		Awr <="00000";
      wait for 100 ns;
		Ard1 <= "00010";
		Awr <= "00010";
		WrEn <='1';
		Din <="00000000000000000000000000000011";
		wait for 10 ns;
		Ard1 <= "00001";
		Ard2 <= "00010";
		WrEn<='0';
		
		wait for 100 ns;
		Awr<="00000";
		WrEn<='1';
		Din <="00000000000000000000000000000111";
		wait for 100 ns;
		Ard1<="00000";
      WrEn<='0';		
		
		
		
      wait;
   end process;

END;
