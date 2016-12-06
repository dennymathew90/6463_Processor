----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:28:27 12/05/2016 
-- Design Name: 
-- Module Name:    jump_address - Behavioral 
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

entity jump_address is
    Port ( 
			  instrn : in  STD_LOGIC_VECTOR (25 downto 0);
           next_pc : in  STD_LOGIC_VECTOR (31 downto 0);
           jmp_addr : out  STD_LOGIC_VECTOR (31 downto 0)
			 );
end jump_address;

architecture Behavioral of jump_address is

begin

jmp_addr <= next_pc(31 downto 28) & instrn & "00";

end Behavioral;

