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


----------------------------------------------------------
------           		  Rt(0) or Rd(1)              -------
----------------------------------------------------------

entity mux1 is

	PORT 
	(
		rt 				: IN	STD_LOGIC_VECTOR(4 DOWNTO 0);
		rd 				: IN	STD_LOGIC_VECTOR(4 DOWNTO 0);
		sel		 		: IN	STD_LOGIC;
		out_reg 			: OUT	STD_LOGIC_VECTOR(4 DOWNTO 0)		
	 );
	 
end mux1;

architecture Behavioral of mux1 is

begin

WITH sel SELECT
	out_reg <= rt WHEN 0,
				  rd WHEN 1;

end Behavioral;

