--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:13:23 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/gpr_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: gpr
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
 
ENTITY gpr_tb IS
END gpr_tb;
 
ARCHITECTURE behavior OF gpr_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gpr
    PORT(
         clk : IN  std_logic;
         clr : IN  std_logic;
         rs : IN  std_logic_vector(4 downto 0);
         rt : IN  std_logic_vector(4 downto 0);
         r_des : IN  std_logic_vector(4 downto 0);
         data_wb : IN  std_logic_vector(31 downto 0);
         reg_write_h : IN  std_logic;
         data_r1 : OUT  std_logic_vector(31 downto 0);
         data_r2 : OUT  std_logic_vector(31 downto 0);
         data_r3 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal rs : std_logic_vector(4 downto 0) := (others => '0');
   signal rt : std_logic_vector(4 downto 0) := (others => '0');
   signal r_des : std_logic_vector(4 downto 0) := (others => '0');
   signal data_wb : std_logic_vector(31 downto 0) := (others => '0');
   signal reg_write_h : std_logic := '0';

 	--Outputs
   signal data_r1 : std_logic_vector(31 downto 0);
   signal data_r2 : std_logic_vector(31 downto 0);
   signal data_r3 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gpr PORT MAP (
          clk => clk,
          clr => clr,
          rs => rs,
          rt => rt,
          r_des => r_des,
          data_wb => data_wb,
          reg_write_h => reg_write_h,
          data_r1 => data_r1,
          data_r2 => data_r2,
          data_r3 => data_r3
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
		rs <= "00001";
		rt <= "00010";
		r_des <= "00100";
		data_wb <= x"FFFFFFFF";
		reg_write_h <= '1';
		wait for clk_period;
		rs <= "00100";
		rt <= "00001";
		r_des <= "00100";
		data_wb <= x"FFFFFFFF";
		reg_write_h <= '0';
      wait;    
   end process;

END;
