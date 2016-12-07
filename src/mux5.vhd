----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:00:10 12/05/2016 
-- Design Name: 
-- Module Name:    mux5 - Behavioral 
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

entity mux5 is
    Port ( 
			  mux4_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  jmp_addr : in  STD_LOGIC_VECTOR (31 downto 0);  
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0)
			 );
end mux5;

architecture Behavioral of mux5 is

begin

WITH sel SELECT

	output <= mux4_out WHEN '1',
				 jmp_addr WHEN '0';

end Behavioral;

