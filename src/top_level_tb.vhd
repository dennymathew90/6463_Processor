--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:56:12 12/09/2016
-- Design Name:   
-- Module Name:   D:/denny docs/nyu/AHD/Project/new_workspace/mips_processor/top_level_tb.vhd
-- Project Name:  mips_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
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
 
ENTITY top_level_tb IS
END top_level_tb;
 
ARCHITECTURE behavior OF top_level_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         clr : IN  std_logic;
         top_clk : IN  std_logic;
         single_step : IN  std_logic;
         run_whole : IN  std_logic;
         show_out : IN  std_logic;
         do_rdy : OUT  std_logic;
         TOP_SSEG_CA : OUT  std_logic_vector(7 downto 0);
         TOP_SSEG_AN : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal top_clk : std_logic := '0';
   signal single_step : std_logic := '0';
   signal run_whole : std_logic := '0';
   signal show_out : std_logic := '0';

 	--Outputs
   signal do_rdy : std_logic;
   signal TOP_SSEG_CA : std_logic_vector(7 downto 0);
   signal TOP_SSEG_AN : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant top_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          clr => clr,
          top_clk => top_clk,
          single_step => single_step,
          run_whole => run_whole,
          show_out => show_out,
          do_rdy => do_rdy,
          TOP_SSEG_CA => TOP_SSEG_CA,
          TOP_SSEG_AN => TOP_SSEG_AN
        );

   -- Clock process definitions
   top_clk_process :process
   begin
		top_clk <= '0';
		wait for top_clk_period/2;
		top_clk <= '1';
		wait for top_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		wait for top_clk_period/2;	
		clr <= '1';
		single_step <= '1';
		run_whole <= '1';
		show_out <= '1';		
				
		wait for top_clk_period;
		
		clr <= '0';
		single_step <= '1';
		run_whole <= '1';
		show_out <= '1';
      wait;
   end process;

END;
