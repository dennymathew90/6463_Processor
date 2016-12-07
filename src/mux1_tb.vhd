--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:02:01 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/mux1_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux1
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
 
ENTITY mux1_tb IS
END mux1_tb;
 
ARCHITECTURE behavior OF mux1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux1
    PORT(
         rt : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         sel : IN  std_logic;
         out_reg : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rt : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal out_reg : std_logic_vector(4 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux1 PORT MAP (
          rt => rt,
          rd => rd,
          sel => sel,
          out_reg => out_reg
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
		rt <= "00001";
		rd <= "00010";
		sel <= '0';
		wait for 10ns;
		rt <= "00001";
		rd <= "00010";
		sel <= '1';
      wait;
   end process;

END;
