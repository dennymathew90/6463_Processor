----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:03 11/26/2016 
-- Design Name: 
-- Module Name:    mux2 - Behavioral 
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

entity mux2 is

	PORT 
	(
		rt 				: IN STD_LOGIC(4 DOWNTO 0);
		rd 				: IN STD_LOGIC(4 DOWNTO 0);
		r_select 		: IN STD_LOGIC;
		out_reg 			: OUT STD_LOGIC(4 DOWNTO 0)		
	 );
	 
end mux2;

architecture Behavioral of mux2 is

begin

WITH r_select SELECT
	out_reg <= rt WHEN 0,
				  rd WHEN 1;

end Behavioral;

