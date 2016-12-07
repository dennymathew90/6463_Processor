--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:22:06 12/07/2016
-- Design Name:   
-- Module Name:   /home/abmuthu/Fall2016/AHD/FinalProject/data_mem_tb.vhd
-- Project Name:  FinalProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: data_mem
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
 
ENTITY data_mem_tb IS
END data_mem_tb;
 
ARCHITECTURE behavior OF data_mem_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT data_mem
    PORT(
         mem_write : IN  std_logic;
         mem_read : IN  std_logic;
         address : IN  std_logic_vector(31 downto 0);
         write_data : IN  std_logic_vector(31 downto 0);
         read_data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mem_write : std_logic := '0';
   signal mem_read : std_logic := '0';
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal write_data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal read_data : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data_mem PORT MAP (
          mem_write => mem_write,
          mem_read => mem_read,
          address => address,
          write_data => write_data,
          read_data => read_data
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
		mem_write <= '1';
		mem_read <= '0';
		address <= x"00000000";
		write_data <= x"FFFFFFFF";
      wait for 10ns;
		mem_write <= '0';
		mem_read <= '1';
		address <= x"00000000";
		write_data <= x"00000000";
		wait;
   end process;

END;
