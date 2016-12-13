----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:50 12/11/2016 
-- Design Name: 
-- Module Name:    mux6 - Behavioral 
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

entity mux6 is
	 Port ( 
				sel 				:	IN		STD_LOGIC;
				alu_result  	:	IN		STD_LOGIC_VECTOR (31 DOWNTO 0);
            display_result :  IN		STD_LOGIC_VECTOR (31 DOWNTO 0);
            out_address		:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0)
			);
end mux6;



----------------------------------------------------------
------        alu_result(0) or display_result(1)   -------
----------------------------------------------------------


architecture Behavioral of mux6 is

begin
	WITH sel SELECT

	out_address <= display_result WHEN '1',
					  alu_result WHEN OTHERS;

end Behavioral;


