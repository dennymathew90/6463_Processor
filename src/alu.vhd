----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:29 11/26/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

----------------------------------------------------------
------        		a --> Rs			         			-------
------            b --> Rt, Imm			         	-------
----------------------------------------------------------

--					  OPCODE ASSIGNMENT                     ---
----------------------------------------------------------
------        		0000	- add	         				-------
------            0001	- sub		         			-------
------            0010	- and		         			-------
------            0011	- or		         			-------
------            0100	- nor		         			-------
------            0101	- shl		         			-------
------            0110	- shr		         			-------
----------------------------------------------------------

entity alu is

	PORT 
	(
		a 				: IN STD_LOGIC(31 DOWNTO 0);
		b 				: IN STD_LOGIC(31 DOWNTO 0);
		op_select 	: IN STD_LOGIC(3 DOWNTO 0);
		output 		: OUT STD_LOGIC(31 DOWNTO 0);
		zero_out 	: OUT STD_LOGIC
	 );

end alu;

architecture behavioral of alu is

--TODO: if the op_select is invalid, output a high res. For now it is just 0's
SIGNAL temp : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS=> '0');

begin
				 
	PROCESS(op_select)
	BEGIN 
		IF (op_select = "0000") THEN
			output <= a + b;
		ELSIF (op_select = "0001") THEN
			output <= a - b;
		ELSIF (op_select = "0010") THEN
			output <= a and b;	
		ELSIF (op_select = "0011") THEN
			output <= a or b;
		ELSIF (op_select = "0100") THEN
			output <= a nor b;
		-- shift left
		ELSIF (op_select = "0101") THEN
			CASE b(4 DOWNTO 0) IS
				WHEN "00000" =>
				  output <= a;
				WHEN "00001" =>
				  output <= a(30 DOWNTO 0) & a(31); 
				WHEN "00010" =>
				  output <= a(29 DOWNTO 0) & a(31 DOWNTO 30); 
				WHEN "00011" =>
				  output <= a(28 DOWNTO 0) & a(31 DOWNTO 29); 
				WHEN "00100" =>
				  output <= a(27 DOWNTO 0) & a(31 DOWNTO 28); 
				WHEN "00101" =>
				  output <= a(26 DOWNTO 0) & a(31 DOWNTO 27); 
				WHEN "00110" =>
				  output <= a(25 DOWNTO 0) & a(31 DOWNTO 26); 
				WHEN "00111" =>
				  output <= a(24 DOWNTO 0) & a(31 DOWNTO 25); 
				WHEN "01000" =>
				  output <= a(23 DOWNTO 0) & a(31 DOWNTO 24); 
				WHEN "01001" =>
				  output <= a(22 DOWNTO 0) & a(31 DOWNTO 23); 
				WHEN "01010" =>
				  output <= a(21 DOWNTO 0) & a(31 DOWNTO 22); 
				WHEN "01011" =>
				  output <= a(20 DOWNTO 0) & a(31 DOWNTO 21);
				WHEN "01100" =>
				  output <= a(19 DOWNTO 0) & a(31 DOWNTO 20); 
				WHEN "01101" =>
				  output <= a(18 DOWNTO 0) & a(31 DOWNTO 19); 
				WHEN "01110" =>
				  output <= a(17 DOWNTO 0) & a(31 DOWNTO 18); 
				WHEN "01111" =>
				  output <= a(16 DOWNTO 0) & a(31 DOWNTO 17); 
				WHEN "10000" =>
				  output <= a(15 DOWNTO 0) & a(31 DOWNTO 16); 
				WHEN "10001" =>
				  output <= a(14 DOWNTO 0) & a(31 DOWNTO 15); 
				WHEN "10010" =>
				  output <= a(13 DOWNTO 0) & a(31 DOWNTO 14); 
				WHEN "10011" =>
				  output <= a(12 DOWNTO 0) & a(31 DOWNTO 13); 
				WHEN "10100" =>
				  output <= a(11 DOWNTO 0) & a(31 DOWNTO 12); 
				WHEN "10101" =>
				  output <= a(10 DOWNTO 0) & a(31 DOWNTO 11); 
				WHEN "10110" =>
				  output <= a(9 DOWNTO 0) & a(31 DOWNTO 10); 
				WHEN "10111" =>
				  output <= a(8 DOWNTO 0) & a(31 DOWNTO 9); 
				WHEN "11000" =>
				  output <= a(7 DOWNTO 0) & a(31 DOWNTO 8);
				WHEN "11001" =>
				  output <= a(6 DOWNTO 0) & a(31 DOWNTO 7);
				WHEN "11010" =>
				  output <= a(5 DOWNTO 0) & a(31 DOWNTO 6);
				WHEN "11011" =>
				  output <= a(4 DOWNTO 0) & a(31 DOWNTO 5); 
				WHEN "11100" =>
				  output <= a(3 DOWNTO 0) & a(31 DOWNTO 4);
				WHEN "11101" =>
				  output <= a(2 DOWNTO 0) & a(31 DOWNTO 3);
				WHEN "11110" =>
				  output <= a(1 DOWNTO 0) & a(31 DOWNTO 2); 
				WHEN "11111" =>
				  output <= a(0) & a(31 DOWNTO 1); 
			END CASE;
			
		-- shift right
		ELSIF (op_select = "0110") THEN
			CASE b(4 DOWNTO 0) IS
				WHEN "00000" =>
				  output <= a;
				WHEN "00001" =>
				  output <= a(0) & a(31 downto 1); 
				WHEN "00010" =>
				  output <= a(1 downto 0) & a(31 downto 2); 
				WHEN "00011" =>
				  output <= a(2 downto 0) & a(31 downto 3); 
				WHEN "00100" =>
				  output <= a(3 downto 0) & a(31 downto 4); 
				WHEN "00101" =>
				  output <= a(4 downto 0) & a(31 downto 5); 
				WHEN "00110" =>
				  output <= a(5 downto 0) & a(31 downto 6); 
				WHEN "00111" =>
				  output <= a(6 downto 0) & a(31 downto 7); 
				WHEN "01000" =>
				  output <= a(7 downto 0) & a(31 downto 8); 
				WHEN "01001" =>
				  output <= a(8 downto 0) & a(31 downto 9); 
				WHEN "01010" =>
				  output <= a(9 downto 0) & a(31 downto 10); 
				WHEN "01011" =>
				  output <= a(10 downto 0) & a(31 downto 11);
				WHEN "01100" =>
				  output <= a(11 downto 0) & a(31 downto 12); 
				WHEN "01101" =>
				  output <= a(12 downto 0) & a(31 downto 13); 
				WHEN "01110" =>
				  output <= a(13 downto 0) & a(31 downto 14); 
				WHEN "01111" =>
				  output <= a(14 downto 0) & a(31 downto 15); 
				WHEN "10000" =>
				  output <= a(15 DOWNTO 0) & a(31 DOWNTO 16); 
				WHEN "10001" =>
				  output <= a(16 downto 0) & a(31 downto 17); 
				WHEN "10010" =>
				  output <= a(17 downto 0) & a(31 downto 18); 
				WHEN "10011" =>
				  output <= a(18 downto 0) & a(31 downto 19); 
				WHEN "10100" =>
				  output <= a(19 downto 0) & a(31 downto 20); 
				WHEN "10101" =>
				  output <= a(20 downto 0) & a(31 downto 21); 
				WHEN "10110" =>
				  output <= a(21 downto 0) & a(31 downto 22); 
				WHEN "10111" =>
				  output <= a(22 downto 0) & a(31 downto 23); 
				WHEN "11000" =>
				  output <= a(23 downto 0) & a(31 downto 24);
				WHEN "11001" =>
				  output <= a(24 downto 0) & a(31 downto 25);
				WHEN "11010" =>
				  output <= a(25 downto 0) & a(31 downto 26);
				WHEN "11011" =>
				  output <= a(26 downto 0) & a(31 downto 27); 
				WHEN "11100" =>
				  output <= a(27 downto 0) & a(31 downto 28);
				WHEN "11101" =>
				  output <= a(28 downto 0) & a(31 downto 29);
				WHEN "11110" =>
				  output <= a(29 downto 0) & a(31 downto 30); 
				WHEN "11111" =>
				  output <= a(30 downto 0) & a(31); 
			END CASE;
		-- branch if less than
		ELSIF (op_select = "1000") THEN
			IF(a < b) THEN
				zero_out <= '1';
			ELSE
				zero_out <= '0';
			END IF;
		-- branch if equal
		ELSIF (op_select = "1001") THEN
			IF(a = b) THEN
				zero_out <= '1';
			ELSE
				zero_out <= '0';
			END IF;
	   -- branch if not equal
		ELSIF (op_select = "1010") THEN
			IF(a = b) THEN
				zero_out <= '0';
			ELSE
				zero_out <= '1';
			END IF;	
		END IF;
		
	END PROCESS;
	

end behavioral;

