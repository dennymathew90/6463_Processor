--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:15:30 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/pc_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pc
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
 
ENTITY pc_tb IS
END pc_tb;
 
ARCHITECTURE behavior OF pc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pc
    PORT(
         clr : IN  std_logic;
         clk : IN  std_logic;
         nextaddr : IN  std_logic_vector(31 downto 0);
         pc_addr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';
   signal nextaddr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal pc_addr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pc PORT MAP (
          clr => clr,
          clk => clk,
          nextaddr => nextaddr,
          pc_addr => pc_addr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ns;
		clr <= '0';
		nextaddr <= x"00000001";
      wait;
   end process;

END;
