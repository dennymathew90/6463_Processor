----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:23:23 11/27/2016 
-- Design Name: 
-- Module Name:    instr_mem - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instr_mem is
	PORT 
	(		
		clr			: IN STD_LOGIC;
		read_addr	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		instr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );
end instr_mem;


architecture Behavioral of instr_mem is
	
	constant DATA_BITS : Integer := 32;			-- no of bits per word
	constant DEPTH     : Integer := 2056;		-- no of lines TODO change depth to 2 power 32
--	constant FILENAME  : String(1 to 19) := "inputfilename.hex";
	
	subtype word_t  is std_logic_vector(DATA_BITS - 1 downto 0);
	type    ram_t   is array(0 to DEPTH - 1) of word_t;

--	signal ram    : ram_t    := ReadAssemblyFile(FILENAME);
	signal ram    : ram_t := (others => (others => '0'));

	
	-- Read a *.hex file
	-- TODO hard code the values into instruction memory
--	impure function ReadBinaryFile(FileName : STRING) return ram_t is
--		file FileHandle       : TEXT open READ_MODE is FileName;
--		variable CurrentLine  : LINE;
--		variable TempWord     : STD_LOGIC_VECTOR((div_ceil(word_t'length, 4) * 4) - 1 downto 0);
--		variable Result       : ram_t    := (others => (others => '0'));
--
--		begin
--		for i in 0 to DEPTH - 1 loop
--		 exit when endfile(FileHandle);
--
--		 readline(FileHandle, CurrentLine);
--		 hread(CurrentLine, TempWord);
--		 Result(i)    := resize(TempWord, word_t'length);
--		end loop;
--
--		return Result;
--	end function;
	
	
begin


	PROCESS(clr)
	BEGIN
		IF (clr = '1') THEN
--			ram(0) <= "00000100000000010000000000000111";
--			ram(1) <= "00000100000000100000000000001000";
--			ram(2) <= "00000000010000010001100000010000";
--			ram(0) <= "00100100000000010000000000000100"; -- beq
--			ram(0) <= "00101000000000010000000000000010"; -- load
--			ram(1) <= "00000100001001000000000000000000"; -- addi
			ram(1) <= "00000100000000010000000000000010";
			ram(2) <= "00000100000000110000000000001010";
			ram(3) <= "00000100000001000000000000001110";
			ram(4) <= "00000100000001010000000000000010";
			ram(5) <= "00100000011001000000000000000010";
			ram(6) <= "00100000011000110000000000000001";
			ram(7) <= "00000000011001000010000000010001";
			ram(8) <= "00001000000001000000000000000001";
			ram(9) <= "00000000011000100010000000010010";
			ram(10) <= "00001100010001000000000000001010";
			ram(11) <= "00000000011000100010000000010011";
			ram(12) <= "00011100011000100000000000000001";
			ram(13) <= "00010000010001000000000000001010";
			ram(14) <= "00000000011000100010000000010100";
			ram(15) <= "00010100010001000000000000001010";
			ram(16) <= "00011000010001000000000000001010";
			ram(17) <= "00101000000001011111111111111110";
			ram(18) <= "00100100100001010000000000000000";
			ram(19) <= "00101100100001010000000000000000";
			ram(20) <= "00110000000000000000000000010100";
			ram(21) <= "11111100000000000000000000000000";

 		END IF;
	END PROCESS;
	
	instr <= ram(CONV_INTEGER(read_addr));	

	
end Behavioral;

