----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:08 11/27/2016 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

package constant_pkg is	
	constant OPC_ADD_SUB_AND_OR_NOR   : std_logic_vector(1 downto 0):= x"00";
	constant OPC_ADDI   	: std_logic_vector(1 downto 0):= x"01";
	constant OPC_SUB   	: std_logic_vector(1 downto 0):= x"00";
	constant OPC_SUBI   	: std_logic_vector(1 downto 0):= x"02";
	constant OPC_AND   	: std_logic_vector(1 downto 0):= x"00";
	constant OPC_ANDI   	: std_logic_vector(1 downto 0):= x"03";
	constant OPC_OR   	: std_logic_vector(1 downto 0):= x"00";
	constant OPC_NOR   	: std_logic_vector(1 downto 0):= x"00";
	constant OPC_ORI   	: std_logic_vector(1 downto 0):= x"04";
	constant OPC_SHL   	: std_logic_vector(1 downto 0):= x"05";
	constant OPC_SHR   	: std_logic_vector(1 downto 0):= x"06";
	
	constant OPC_LW   	: std_logic_vector(1 downto 0):= x"07";
	constant OPC_SW   	: std_logic_vector(1 downto 0):= x"08";
	constant OPC_BLT   	: std_logic_vector(1 downto 0):= x"09";
	constant OPC_BEQ   	: std_logic_vector(1 downto 0):= x"0A";
	constant OPC_BNE   	: std_logic_vector(1 downto 0):= x"0B";
	constant OPC_JMP   	: std_logic_vector(1 downto 0):= x"0C";
	constant OPC_HAL   	: std_logic_vector(1 downto 0):= x"3F";
	
	constant FUNC_ADD   	: std_logic_vector(1 downto 0):= x"10";
	constant FUNC_SUB   	: std_logic_vector(1 downto 0):= x"11";
	constant FUNC_AND   	: std_logic_vector(1 downto 0):= x"12";
	constant FUNC_OR  	: std_logic_vector(1 downto 0):= x"13";
	constant FUNC_NOR  	: std_logic_vector(1 downto 0):= x"14";
		
	constant ENABLE   	: std_logic := '1';
	constant DISABLE   	: std_logic := '0';
	
	constant ALU_ADD		: std_logic_vector(3 downto 0):= x"0000";
	constant ALU_SUB		: std_logic_vector(3 downto 0):= x"0001";
	constant ALU_AND		: std_logic_vector(3 downto 0):= x"0010";
	constant ALU_OR		: std_logic_vector(3 downto 0):= x"0011";
	constant ALU_NOR		: std_logic_vector(3 downto 0):= x"0100";
	constant ALU_SHL		: std_logic_vector(3 downto 0):= x"0101";
	constant ALU_SHR		: std_logic_vector(3 downto 0):= x"0110";
	constant ALU_BLT		: std_logic_vector(3 downto 0):= x"0111";
	constant ALU_BE		: std_logic_vector(3 downto 0):= x"1000";
	constant ALU_BNE		: std_logic_vector(3 downto 0):= x"1001";
		
end constant_pkg;

 -- reusable counter design counter.vhd library pkgs;
use pkgs.constant_pkg.all;

entity control_unit is
	PORT 
	(
		clr, clk			: IN STD_LOGIC;
		opcode			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
		func				: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
		c_jump			: OUT STD_LOGIC;
		c_regdst			: OUT STD_LOGIC;
		c_branch			: OUT STD_LOGIC;
		c_memtoreg		: OUT STD_LOGIC;
		c_memread		: OUT STD_LOGIC;
		c_aluop			: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		c_memwrite		: OUT STD_LOGIC;
		c_alusrc			: OUT STD_LOGIC;
		c_regwrite		: OUT STD_LOGIC			
	 );
	 
end control_unit;

architecture Behavioral of control_unit is

begin
	
	--state processing : button logic
	PROCESS(opcode, clr)
	BEGIN
		IF(clr='1') THEN
			-- TODO Find a way to init all the outputs of the control unit
			NULL;
			
		ELSE			
			c_jump			<= DISABLE;
			c_branch			<= DISABLE;
			c_memtoreg		<= DISABLE;
			c_memread		<= DISABLE;
			c_aluop			<= DISABLE;
			c_memwrite		<= DISABLE;
			c_alusrc			<= DISABLE;
			c_regwrite		<= DISABLE;
			CASE opcode IS
				WHEN OPC_ADD_SUB_AND_OR_NOR =>  
					c_regwrite	<= ENABLE;
					c_regdst		<= ENABLE;
					
					if (func = FUNC_ADD) THEN
						c_alu_op	<= ALU_ADD;
					ELSIF (func = FUNC_SUB) THEN
						c_alu_op	<= ALU_SUB;
					ELSIF (func = FUNC_AND) THEN
						c_alu_op	<= ALU_AND;
					ELSIF (func = FUNC_OR) THEN
						c_alu_op	<= ALU_OR;
					ELSIF (func = FUNC_NOR) THEN
						c_alu_op	<= ALU_NOR;
					END IF;
				WHEN OPC_ADDI =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ADD;
					
				WHEN OPC_SUBI =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_SUB;
					
				WHEN OPC_ANDI =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ANDI;
					
					
				WHEN OPC_ORI =>
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ORI;
					
					
				WHEN OPC_SHL =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_SHL;
					
				WHEN OPC_SHR =>
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_SHR;
					
				WHEN OPC_LW =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ADD;
					c_memread	<= ENABLE;
					c_memtoreg	<= ENABLE;
				WHEN OPC_SW =>					
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ADD;
					c_memwrite	<= ENABLE;
					
				WHEN OPC_BLT =>	
					c_alu_op		<= ALU_BLT;
					
				WHEN OPC_BEQ =>
					c_alu_op		<= ALU_BEQ;
				WHEN OPC_BNE =>
					c_alu_op		<= ALU_BNE;
				WHEN OPC_JMP =>
					c_jump		<= ENABLE;
--				WHEN OPC_HAL =>	
					
			END CASE;
		END IF;
		
	END PROCESS;
			

end Behavioral;

