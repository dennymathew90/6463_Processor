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


library work;
 -- reusable counter design counter.vhd library pkgs;
use work.constants_pkg.all;

entity control_unit is
	PORT 
	(
		clr				: IN STD_LOGIC;
		opcode			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
		func				: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
		c_jump			: OUT STD_LOGIC;
		c_regdst			: OUT STD_LOGIC;
		c_branch			: OUT STD_LOGIC;
		c_memtoreg		: OUT STD_LOGIC;
		c_memread		: OUT STD_LOGIC;
		c_alu_op			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		c_memwrite		: OUT STD_LOGIC;
		c_alusrc			: OUT STD_LOGIC;
		c_halt			: OUT STD_LOGIC;
		c_regwrite		: OUT STD_LOGIC			
	 );
	 
end control_unit;

architecture Behavioral of control_unit is

begin
	
	--state processing : button logic
	PROCESS(opcode, func, clr)
	BEGIN
		IF(clr='1') THEN
			-- TODO Find a way to init all the outputs of the control unit
			c_regdst			<= DISABLE;	
			c_jump			<= DISABLE;
			c_branch			<= DISABLE;
			c_memtoreg		<= DISABLE;
			c_memread		<= DISABLE;
			c_alu_op			<= ALU_NDEF;
			c_memwrite		<= DISABLE;
			c_alusrc			<= DISABLE;
			c_regwrite		<= DISABLE;
			c_halt			<= ENABLE;
			
		ELSE			
			c_regdst			<= DISABLE;	
			c_jump			<= DISABLE;
			c_branch			<= DISABLE;
			c_memtoreg		<= DISABLE;
			c_memread		<= DISABLE;
			c_alu_op			<= ALU_NDEF;
			c_memwrite		<= DISABLE;
			c_alusrc			<= DISABLE;
			c_regwrite		<= DISABLE;
			c_halt			<= ENABLE;	
			CASE opcode IS
				WHEN OPC_ADD_SUB_AND_OR_NOR(5 downto 0) =>  
					c_regwrite	<= ENABLE;
					c_regdst		<= ENABLE;
					
					IF (func = FUNC_ADD(5 downto 0)) THEN
						c_alu_op	<= ALU_ADD;
					ELSIF (func = FUNC_SUB(5 downto 0)) THEN
						c_alu_op	<= ALU_SUB;
					ELSIF (func = FUNC_AND(5 downto 0)) THEN
						c_alu_op	<= ALU_AND;
					ELSIF (func = FUNC_OR(5 downto 0)) THEN
						c_alu_op	<= ALU_OR;
					ELSIF (func = FUNC_NOR(5 downto 0)) THEN
						c_alu_op	<= ALU_NOR;
					END IF;
				WHEN OPC_ADDI(5 downto 0) =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
--					c_regdst		<= DISABLE;
					c_alu_op		<= ALU_ADD;
					
				WHEN OPC_SUBI(5 downto 0) =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
--					c_regdst		<= DISABLE;
					c_alu_op		<= ALU_SUB;
					
				WHEN OPC_ANDI(5 downto 0) =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_AND;
--					c_regdst		<= DISABLE;					
					
				WHEN OPC_ORI(5 downto 0) =>
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_OR;
--					c_regdst		<= DISABLE;					
					
				WHEN OPC_SHL(5 downto 0) =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_SHL;
--					c_regdst		<= DISABLE;	
					
				WHEN OPC_SHR(5 downto 0) =>
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_SHR;
--					c_regdst		<= DISABLE;	
					
				WHEN OPC_LW(5 downto 0) =>	
					c_regwrite	<= ENABLE;
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ADD;
					c_memread	<= ENABLE;
					c_memtoreg	<= ENABLE;
--					c_regdst		<= DISABLE;	
					
				WHEN OPC_SW(5 downto 0) =>					
					c_alusrc		<= ENABLE;
					c_alu_op		<= ALU_ADD;
					c_memwrite	<= ENABLE;
--					c_regdst		<= DISABLE;	
					
				WHEN OPC_BLT(5 downto 0) =>	
					c_alu_op		<= ALU_BLT;
					c_branch		<= ENABLE;
				WHEN OPC_BE(5 downto 0) =>
					c_alu_op		<= ALU_BE;
					c_branch		<= ENABLE;
				WHEN OPC_BNE(5 downto 0) =>
					c_alu_op		<= ALU_BNE;
					c_branch		<= ENABLE;
				WHEN OPC_JMP(5 downto 0) =>
					c_jump		<= ENABLE;
					c_branch		<= ENABLE;
					c_alu_op 	<= ALU_NDEF;
				WHEN OPC_HAL(5 downto 0) =>	
					c_halt		<= DISABLE;	
					c_memread	<= ENABLE;
				WHEN OTHERS =>
					c_alu_op <= ALU_NDEF; -- TODO
			END CASE;
		END IF;
		
	END PROCESS;
			

end Behavioral;

