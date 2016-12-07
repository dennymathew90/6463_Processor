----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:53:39 11/30/2016 
-- Design Name: 
-- Module Name:    mux3 - Behavioral 
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
------        alu_result(0) or read_data(1)        -------
----------------------------------------------------------


entity mux3 is
    Port ( 
				sel 			:	IN		STD_LOGIC;
				alu_result  :	IN		STD_LOGIC_VECTOR (31 DOWNTO 0);
            read_data   :  IN		STD_LOGIC_VECTOR (31 DOWNTO 0);
            out_data  	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0));
end mux3;

architecture Behavioral of mux3 is

begin

WITH sel SELECT

	out_data <= alu_result WHEN '0',
					read_data  WHEN '1';

end Behavioral;

