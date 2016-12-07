--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:11:51 12/05/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/adder1_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder1
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
 
ENTITY adder1_tb IS
END adder1_tb;
 
ARCHITECTURE behavior OF adder1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder1
    PORT(
         in_addr : IN  std_logic_vector(31 downto 0);
         out_addr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_addr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_addr : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder1 PORT MAP (
          in_addr => in_addr,
          out_addr => out_addr
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
		in_addr <= "01010101010101010101010101010101";
		wait;
   end process;

END;
