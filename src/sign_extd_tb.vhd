--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:23:36 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/sign_extd_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sign_extd
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
 
ENTITY sign_extd_tb IS
END sign_extd_tb;
 
ARCHITECTURE behavior OF sign_extd_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sign_extd
    PORT(
         imm_val : IN  std_logic_vector(15 downto 0);
         sign_extd_val : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm_val : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal sign_extd_val : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sign_extd PORT MAP (
          imm_val => imm_val,
          sign_extd_val => sign_extd_val
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		imm_val <= x"FFFF";
		wait for 10ns;
		imm_val <= x"0FFF";
      wait;
   end process;

END;
