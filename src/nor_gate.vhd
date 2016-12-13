----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:25 12/11/2016 
-- Design Name: 
-- Module Name:    nor_gate - Behavioral 
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

entity nor_gate is
	 Port ( 
			  control_i 		: in  	STD_LOGIC;
           inputif_i 		: in  	STD_LOGIC;
           output 			: out  	STD_LOGIC
			 );
end nor_gate;

architecture Behavioral of nor_gate is

begin

	output <= control_i and inputif_i;
	
end Behavioral;

