--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:16:01 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/mux5_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux5
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
 
ENTITY mux5_tb IS
END mux5_tb;
 
ARCHITECTURE behavior OF mux5_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux5
    PORT(
         mux4_out : IN  std_logic_vector(31 downto 0);
         jmp_addr : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mux4_out : std_logic_vector(31 downto 0) := (others => '0');
   signal jmp_addr : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux5 PORT MAP (
          mux4_out => mux4_out,
          jmp_addr => jmp_addr,
          sel => sel,
          output => output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		sel <= '0';
		mux4_out <= x"00000000";
		jmp_addr <= x"FFFFFFFF";
		wait for 10ns;
		sel <= '1';
		mux4_out <= x"00000000";
		jmp_addr <= x"FFFFFFFF";	
      wait; 

      wait;
   end process;

END;
