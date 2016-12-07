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

-- Following little-endian byte order:
-- Byte #
-- 3	2	1	0

	
	instr <= ram(CONV_INTEGER(read_addr));	

	
end Behavioral;

