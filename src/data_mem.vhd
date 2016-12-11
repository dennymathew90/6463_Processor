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
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_mem is
    Port ( 
			  d_clk, clr			: IN	STD_LOGIC;
			  mem_write  			: IN  STD_LOGIC;  
			  mem_read 				: IN  STD_LOGIC;
           address 				: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
           write_data 			: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
           read_data 			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
			 );
end data_mem;

architecture Behavioral of data_mem is

	CONSTANT DATA_BITS : Integer := 32;			-- no of bits per word
	CONSTANT DEPTH     : Integer := 2056;		
	
	TYPE    ram_t   IS ARRAY(0 TO DEPTH - 1) OF STD_LOGIC_VECTOR(DATA_BITS - 1 DOWNTO 0);	
	
	-- all valus in the array are initialized to 0
	SIGNAL data_ram : ram_t := ((others=> (others=>'0')));
	
	SIGNAL mem_write_t 	:  STD_LOGIC;  
	SIGNAL write_data_t 	:  STD_LOGIC_VECTOR(31 DOWNTO 0);  
	
begin
	
process (d_clk, clr)
  begin
		if (clr='1') then
			data_ram(3) <= x"00000007";
		
      elsif (rising_edge(d_clk)) then
			
         if (mem_write_t='1') then
			   data_ram(to_integer (unsigned(address(31 downto 0)))) <= write_data_t;
          end if ;    			
       end if ;
end process ;
	WITH mem_read SELECT
	
		read_data <= data_ram(to_integer(unsigned(address(31 downto 0)))) when '1',
							x"00000000" WHEN OTHERS;
	mem_write_t <= mem_write;
	write_data_t <= write_data;

end Behavioral;