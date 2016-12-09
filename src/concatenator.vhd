----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:11:08 12/08/2016 
-- Design Name: 
-- Module Name:    concatenator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity concatenator is
 Port ( 
		  addr_28 	: in  STD_LOGIC_VECTOR (25 downto 0);
		  pc_msb 	: in  STD_LOGIC_VECTOR (5 downto 0);
		  jmp_addr 	: out STD_LOGIC_VECTOR (31 downto 0)
		);
end concatenator;

architecture Behavioral of concatenator is	
begin

	jmp_addr <= pc_msb & addr_28;
	
end Behavioral;

