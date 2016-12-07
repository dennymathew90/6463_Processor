--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:56:24 12/06/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/and_gate_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: and_gate
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
 
ENTITY and_gate_tb IS
END and_gate_tb;
 
ARCHITECTURE behavior OF and_gate_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT and_gate
    PORT(
         branch : IN  std_logic;
         zero : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal branch : std_logic := '0';
   signal zero : std_logic := '0';

 	--Outputs
   signal output : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: and_gate PORT MAP (
          branch => branch,
          zero => zero,
          output => output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		branch <= '0';
		zero <= '1';
		wait for 10ns;
		branch <= '1';
		zero <= '1';		
      wait;
   end process;

END;
