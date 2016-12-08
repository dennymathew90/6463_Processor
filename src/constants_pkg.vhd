----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:27 12/08/2016 
-- Design Name: 
-- Module Name:    constants_pkg - Behavioral 
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


package constants_pkg is	
	constant OPC_ADD_SUB_AND_OR_NOR   : std_logic_vector(7 downto 0):= x"00";
	constant OPC_ADDI   	: std_logic_vector(7 downto 0):= x"01";
--	constant OPC_SUB   	: std_logic_vector(7 downto 0):= x"00";
	constant OPC_SUBI   	: std_logic_vector(7 downto 0):= x"02";
--	constant OPC_AND   	: std_logic_vector(7 downto 0):= x"00";
	constant OPC_ANDI   	: std_logic_vector(7 downto 0):= x"03";
--	constant OPC_OR   	: std_logic_vector(7 downto 0):= x"00";
--	constant OPC_NOR   	: std_logic_vector(7 downto 0):= x"00";
	constant OPC_ORI   	: std_logic_vector(7 downto 0):= x"04";
	constant OPC_SHL   	: std_logic_vector(7 downto 0):= x"05";
	constant OPC_SHR   	: std_logic_vector(7 downto 0):= x"06";
	
	constant OPC_LW   	: std_logic_vector(7 downto 0):= x"07";
	constant OPC_SW   	: std_logic_vector(7 downto 0):= x"08";
	constant OPC_BLT   	: std_logic_vector(7 downto 0):= x"09";
	constant OPC_BE   	: std_logic_vector(7 downto 0):= x"0A";
	constant OPC_BNE   	: std_logic_vector(7 downto 0):= x"0B";
	constant OPC_JMP   	: std_logic_vector(7 downto 0):= x"0C";
	constant OPC_HAL   	: std_logic_vector(7 downto 0):= x"3F";
	
	constant FUNC_ADD   	: std_logic_vector(7 downto 0):= x"10";
	constant FUNC_SUB   	: std_logic_vector(7 downto 0):= x"11";
	constant FUNC_AND   	: std_logic_vector(7 downto 0):= x"12";
	constant FUNC_OR  	: std_logic_vector(7 downto 0):= x"13";
	constant FUNC_NOR  	: std_logic_vector(7 downto 0):= x"14";
		
	constant ENABLE   	: std_logic := '1';
	constant DISABLE   	: std_logic := '0';
	
	constant ALU_ADD		: std_logic_vector(3 downto 0):= "0000";
	constant ALU_SUB		: std_logic_vector(3 downto 0):= "0001";
	constant ALU_AND		: std_logic_vector(3 downto 0):= "0010";
	constant ALU_OR		: std_logic_vector(3 downto 0):= "0011";
	constant ALU_NOR		: std_logic_vector(3 downto 0):= "0100";
	constant ALU_SHL		: std_logic_vector(3 downto 0):= "0101";
	constant ALU_SHR		: std_logic_vector(3 downto 0):= "0110";
	constant ALU_BLT		: std_logic_vector(3 downto 0):= "0111";
	constant ALU_BE		: std_logic_vector(3 downto 0):= "1000";
	constant ALU_BNE		: std_logic_vector(3 downto 0):= "1001";
	constant ALU_NDEF		: std_logic_vector(3 downto 0):= "1111";
	
		
end constants_pkg;



