----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:35:41 12/02/2016 
-- Design Name: 
-- Module Name:    mux4 - Behavioral 
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

entity mux4 is
    Port ( 
			  sel 				: in 		STD_LOGIC;	
			  adder2_result 	: in  	STD_LOGIC_VECTOR (31 downto 0);
           added_pc 			: in  	STD_LOGIC_VECTOR (31 downto 0);
           output 			: out  	STD_LOGIC_VECTOR (31 downto 0)
			 );
end mux4;

architecture Behavioral of mux4 is

begin

WITH sel SELECT
	output <= adder2_result WHEN '1',
				 added_pc WHEN '0';

end Behavioral;

