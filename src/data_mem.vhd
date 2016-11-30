----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:24:30 11/27/2016 
-- Design Name: 
-- Module Name:    data_mem - Behavioral 
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

entity data_mem is
    Port ( 
			  mem_write  			: IN  STD_LOGIC;  
			  mem_read 				: IN  STD_LOGIC;
           address 				: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
           write_data 			: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
           read_data 			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
			 );
end data_mem;

architecture Behavioral of data_mem is

	CONSTANT DATA_BITS : Integer := 8;			-- no of bits per word
	CONSTANT DEPTH     : Integer := 2056;	
	
	SIGNAL read_data_8a	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL read_data_8b	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL read_data_8c	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL read_data_8d	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SUBTYPE word_t  IS STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);
	TYPE    ram_t   IS ARRAY(0 TO DEPTH - 1) OF word_t;
	
	-- all valus in the array are initialized to 0
	SIGNAL data_ram : ram_t := ((others=> (others=>'0')));
	
begin

	PROCESS(mem_write, mem_read)
	BEGIN
		-- writes data to memory (store)
		IF(mem_write = '1' and mem_read='0') THEN
			data_ram(CONV_INTEGER(address)) <=  write_data(31 DOWNTO 24);
			data_ram(CONV_INTEGER(address)+1) <= write_data(23 DOWNTO 16);
			data_ram(CONV_INTEGER(address)+2) <= write_data(15 DOWNTO 8);
			data_ram(CONV_INTEGER(address)+3) <= write_data(7 DOWNTO 0);
			
		-- reads data from memory (load)	
		ELSIF(mem_write = '0' and mem_read='1') THEN
			read_data_8a <= data_ram(CONV_INTEGER(address));
			read_data_8b <= data_ram(CONV_INTEGER(address)+1);
			read_data_8c <= data_ram(CONV_INTEGER(address)+2);
			read_data_8d <= data_ram(CONV_INTEGER(address)+3);
		ELSE
			-- do nothing
		END IF;
	END PROCESS;
	
end Behavioral;

