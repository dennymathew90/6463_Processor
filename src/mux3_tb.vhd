--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:06:07 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/mux3_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux3
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
 
ENTITY mux3_tb IS
END mux3_tb;
 
ARCHITECTURE behavior OF mux3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux3
    PORT(
         sel : IN  std_logic;
         alu_result : IN  std_logic_vector(31 downto 0);
         read_data : IN  std_logic_vector(31 downto 0);
         out_data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal alu_result : std_logic_vector(31 downto 0) := (others => '0');
   signal read_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out_data : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux3 PORT MAP (
          sel => sel,
          alu_result => alu_result,
          read_data => read_data,
          out_data => out_data
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		sel <= '0';
		alu_result <= x"FFFFFFFF";
		read_data <= x"00000000";
		wait for 10ns;
		sel <= '1';
		alu_result <= x"FFFFFFFF";
		read_data <= x"00000000";
      wait;
   end process;

END;
