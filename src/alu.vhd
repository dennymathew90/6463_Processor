----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:29 11/26/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity alu is

	PORT 
	(
		a 				: IN STD_LOGIC(31 DOWNTO 0);
		b 				: IN STD_LOGIC(31 DOWNTO 0);
		op_select 	: IN STD_LOGIC(3 DOWNTO 0);
		output 		: OUT STD_LOGIC(31 DOWNTO 0)		
	 );

end alu;

architecture behavioral of alu is

--TODO: if the op_select is invalid, output a high res. For now it is just 0's
SIGNAL temp : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS=> '0');

begin

WITH op_select SELECT

	output <= (a + b) WHEN 0000,
				 (a - b) WHEN 0001,
				 (a and b) WHEN 0010,
				 (a or b) WHEN 0011,
				 (a nor b) WHEN 0100,
				 temp WHEN OTHERS;
	

end behavioral;

