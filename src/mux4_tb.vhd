--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:12:30 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/mux4_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux4
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mux4_tb IS
END mux4_tb;
 
ARCHITECTURE behavior OF mux4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux4
    PORT(
         sel : IN  std_logic;
         adder2_result : IN  std_logic_vector(31 downto 0);
         added_pc : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal adder2_result : std_logic_vector(31 downto 0) := (others => '0');
   signal added_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux4 PORT MAP (
          sel => sel,
          adder2_result => adder2_result,
          added_pc => added_pc,
          output => output
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		sel <= '0';
		adder2_result <= x"00000000";
		added_pc <= x"FFFFFFFF";
		wait for 10ns;
		sel <= '1';
		adder2_result <= x"00000000";
		added_pc <= x"FFFFFFFF";		
      wait;
   end process;

END;
