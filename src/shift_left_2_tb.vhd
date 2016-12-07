--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:18:50 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/shift_left_2_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shift_left_2
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
 
ENTITY shift_left_2_tb IS
END shift_left_2_tb;
 
ARCHITECTURE behavior OF shift_left_2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shift_left_2
    PORT(
         instr : IN  std_logic_vector(25 downto 0);
         output : OUT  std_logic_vector(27 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal instr : std_logic_vector(25 downto 0) := (others => '0');
   signal output : std_logic_vector(27 downto 0) := (others => '0');

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shift_left_2 PORT MAP (
          instr => instr,
          output => output
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		instr <= x"FFFFFF" & "11";
      wait;
   end process;

END;
