--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:39:36 12/06/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/adder2_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder2
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
 
ENTITY adder2_tb IS
END adder2_tb;
 
ARCHITECTURE behavior OF adder2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder2
    PORT(
         imm_val : IN  std_logic_vector(31 downto 0);
         added_pc : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm_val : std_logic_vector(31 downto 0) := (others => '0');
   signal added_pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder2 PORT MAP (
          imm_val => imm_val,
          added_pc => added_pc,
          output => output
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		imm_val 	<= "10101010101010101010101010101010";
		added_pc <= "11111111111111111111111111111111";
      wait;
   end process;

END;
