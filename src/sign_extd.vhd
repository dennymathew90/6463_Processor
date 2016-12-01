----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:57 12/01/2016 
-- Design Name: 
-- Module Name:    sign_extd - Behavioral 
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

entity sign_extd is
    Port ( 
			  imm_val 				: IN  	STD_LOGIC_VECTOR (15 DOWNTO 0);
           sign_extd_val 		: OUT  	STD_LOGIC_VECTOR (31 DOWNTO 0) 
			 );
end sign_extd;

architecture Behavioral of sign_extd is

begin

WITH imm_val(15) SELECT
	sign_extd_val <= x"0000" & imm_val WHEN '0',
						  x"FFFF" & imm_val WHEN '1';

end Behavioral;

