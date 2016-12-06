----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:59 11/26/2016 
-- Design Name: 
-- Module Name:    GPR - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gpr is
	PORT 
	(
	   clk			: IN STD_LOGIC;
		rs 			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rt 			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		r_des			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_wb		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		reg_write_h	: IN STD_LOGIC;		
		data_r1		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		temp 			: OUT STD_LOGIC;
		data_r2		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );
	 
end gpr;

architecture behavioral of gpr is

	type register_set is array (0 to 31) of std_logic_vector(31 downto 0);
	SIGNAL  gpr_mem:   register_set := ((others=> (others=>'0')));
	SIGNAL reg_write_temp	: STD_LOGIC := '0';

begin	 

	data_r1 <= gpr_mem(CONV_INTEGER(rs));
	data_r2 <= gpr_mem(CONV_INTEGER(rt));

	reg_write_temp <= reg_write_h;
	-- write back data
	PROCESS(clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF(reg_write_temp = '1') THEN
				temp <= '1';
				gpr_mem(CONV_INTEGER(r_des)) <= data_wb;
			END IF;
		END IF;
	END PROCESS;
	

--	
end behavioral;
