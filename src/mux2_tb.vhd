--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:04:21 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/mux2_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2
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
 
ENTITY mux2_tb IS
END mux2_tb;
 
ARCHITECTURE behavior OF mux2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2
    PORT(
         rt : IN  std_logic_vector(31 downto 0);
         imm : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rt : std_logic_vector(31 downto 0) := (others => '0');
   signal imm : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2 PORT MAP (
          rt => rt,
          imm => imm,
          sel => sel,
          output => output
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
		
		sel <= '0';
		rt <= x"00000000";
		imm <= x"FFFFFFFF";
		wait for 10ns;
		sel <= '1';
		rt <= x"00000000";
		imm <= x"FFFFFFFF";	
      wait;
      wait;
   end process;

END;
