----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:06:40 11/27/2016 
-- Design Name: 
-- Module Name:    pc - Behavioral 
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

entity pc is
	PORT 
	(
		clr, pc_clk		: IN STD_LOGIC;
		nextaddr		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		pc_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );
end pc;

architecture Behavioral of pc is	
		
	SIGNAL pc_addr_tmp : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
	
	begin

	----------------------------------------------------------
	------           Out  Registers                    -------
	----------------------------------------------------------

	-- pc_addr register
	PROCESS(clr, pc_clk)  BEGIN
		IF(clr='1') THEN
			pc_addr <= (OTHERS => '0');
		ELSIF(pc_clk'EVENT AND pc_clk = '1') THEN  
			pc_addr <= pc_addr_tmp;
		END IF;
	END PROCESS;

	pc_addr_tmp <= nextaddr;

end Behavioral;

