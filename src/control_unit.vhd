----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:08 11/27/2016 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is
	PORT 
	(
		clr, clk		: IN STD_LOGIC;
		opcode			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
		c_jump			: OUT STD_LOGIC;
		c_branch			: OUT STD_LOGIC;
		c_memtoreg		: OUT STD_LOGIC;
		c_memread		: OUT STD_LOGIC;
		c_aluop			: OUT STD_LOGIC;
		c_memwrite		: OUT STD_LOGIC;
		c_alusrc			: OUT STD_LOGIC;
		c_regwrite		: OUT STD_LOGIC			
	 );
	 
end control_unit;

architecture Behavioral of control_unit is

begin


end Behavioral;

