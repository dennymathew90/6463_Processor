----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:16:20 12/02/2016 
-- Design Name: 
-- Module Name:    adder2 - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder2 is
    Port ( 
			  imm_val 	: IN  	STD_LOGIC_VECTOR (31 DOWNTO 0);
           added_pc 	: IN  	STD_LOGIC_VECTOR (31 DOWNTO 0);
           output 	: OUT  	STD_LOGIC_VECTOR (31 DOWNTO 0)
			 );
end adder2;

architecture Behavioral of adder2 is

begin

output <= imm_val + added_pc;

end Behavioral;

