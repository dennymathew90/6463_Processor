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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gpr is
	PORT 
	(
--		clr, clk		: IN STD_LOGIC;
		rs 			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		rt 			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		r_des			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_wb		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		reg_write_h	: IN STD_LOGIC;		
		data_r1		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_r2		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)			
	 );
	 
end gpr;

architecture behavioral of gpr is

--	-- GPR state machine has two states 
--   TYPE state_type IS (
--								ST_READ, --
--								ST_WRITE -- in this state its register is written with data 									
--                       );
--   -- RC5 state machine has four states: idle, pre_round, round and ready
--   SIGNAL  state:   state_type := ST_READ;
	
	type register_set is array (0 to 31) of unsigned(31 downto 0);
	SIGNAL  gpr_mem:   register_set;
	
--	SIGNAL data_r1_tmp		: STD_LOGIC(31 DOWNTO 0) := x"00000000";
--	SIGNAL data_r2_tmp		: STD_LOGIC(31 DOWNTO 0) := x"00000000";
	
begin

----------------------------------------------------------
------           Out  Registers                    -------
----------------------------------------------------------

---- r1 register
--PROCESS(clr, clk)  BEGIN
--	IF(clr='1') THEN
--		data_r1 <= (OTHERS => '0');
--	ELSIF(clk'EVENT AND clk = '1') THEN  
--		data_r1 <= data_r1_tmp;
--	END IF;
--END PROCESS;
--	 
---- r2 register
--PROCESS(clr, clk)  BEGIN
--	IF(clr='1') THEN
--		data_r2 <= (OTHERS => '0');
--	ELSIF(clk'EVENT AND clk = '1') THEN  
--		data_r2 <= data_r2_tmp;
--	END IF;
--END PROCESS; 

------------------------------------------------------------
--------           State Machine Operation           -------
------------------------------------------------------------
--PROCESS(clr, clk)	
--  BEGIN
--	 IF(clr = '1') THEN
--		  state <= ST_READ;		  
--	 ELSIF(clk'EVENT AND clk = '1') THEN
--		  CASE state IS
--			  WHEN ST_READ  =>
--					IF(reg_write_h = '1') THEN  
--						state <= ST_WRITE;
--					ELSE
--						state <= ST_READ;
--					END IF;
--					
--			  WHEN ST_WRITE =>					
--					state <= ST_READ;
--					gpr_mem(CONV_INTEGER(r_des)) <= data_wb;
----					IF(reg_write_h = '1') THEN
----						state <= ST_KEY_EXP;
----					ELSE
----						state <= ST_READ;
----					END IF;
--		 END CASE;
--	  END IF;
--END PROCESS;

----------------------------------------------------------
------           RT and RS selection               -------
----------------------------------------------------------
	WITH rs(4 DOWNTO 0) SELECT
		data_r1 <= 
			gpr_mem(1) WHEN "00001",
			gpr_mem(2) WHEN "00010",
			gpr_mem(3) WHEN "00011",
			gpr_mem(4) WHEN "00100",
			gpr_mem(5) WHEN "00101",
			gpr_mem(6) WHEN "00110",
			gpr_mem(7) WHEN "00111",
			gpr_mem(8) WHEN "01000",
			gpr_mem(9) WHEN "01001",
			gpr_mem(10) WHEN "01010",
			gpr_mem(11) WHEN "01011",
			gpr_mem(12) WHEN "01100",
			gpr_mem(13) WHEN "01101",
			gpr_mem(14) WHEN "01110",
			gpr_mem(15) WHEN "01111",
			gpr_mem(16) WHEN "10000",
			gpr_mem(17) WHEN "10001",
			gpr_mem(18) WHEN "10010",
			gpr_mem(19) WHEN "10011",
			gpr_mem(20) WHEN "10100",
			gpr_mem(21) WHEN "10101",
			gpr_mem(22) WHEN "10110",
			gpr_mem(23) WHEN "10111",
			gpr_mem(24) WHEN "11000",
			gpr_mem(25) WHEN "11001",
			gpr_mem(26) WHEN "11010",
			gpr_mem(27) WHEN "11011",
			gpr_mem(28) WHEN "11100",
			gpr_mem(29) WHEN "11101",
			gpr_mem(30) WHEN "11110",
			gpr_mem(31) WHEN "11111",
			gpr_mem(0) WHEN  OTHERS;
			
	WITH rt(4 DOWNTO 0) SELECT
		data_r1 <= 
			gpr_mem(1) WHEN "00001",
			gpr_mem(2) WHEN "00010",
			gpr_mem(3) WHEN "00011",
			gpr_mem(4) WHEN "00100",
			gpr_mem(5) WHEN "00101",
			gpr_mem(6) WHEN "00110",
			gpr_mem(7) WHEN "00111",
			gpr_mem(8) WHEN "01000",
			gpr_mem(9) WHEN "01001",
			gpr_mem(10) WHEN "01010",
			gpr_mem(11) WHEN "01011",
			gpr_mem(12) WHEN "01100",
			gpr_mem(13) WHEN "01101",
			gpr_mem(14) WHEN "01110",
			gpr_mem(15) WHEN "01111",
			gpr_mem(16) WHEN "10000",
			gpr_mem(17) WHEN "10001",
			gpr_mem(18) WHEN "10010",
			gpr_mem(19) WHEN "10011",
			gpr_mem(20) WHEN "10100",
			gpr_mem(21) WHEN "10101",
			gpr_mem(22) WHEN "10110",
			gpr_mem(23) WHEN "10111",
			gpr_mem(24) WHEN "11000",
			gpr_mem(25) WHEN "11001",
			gpr_mem(26) WHEN "11010",
			gpr_mem(27) WHEN "11011",
			gpr_mem(28) WHEN "11100",
			gpr_mem(29) WHEN "11101",
			gpr_mem(30) WHEN "11110",
			gpr_mem(31) WHEN "11111",
			gpr_mem(0) WHEN  OTHERS;
	
	-- write back data
	gpr_mem(CONV_INTEGER(r_des)) <= data_wb;
	
end behavioral;