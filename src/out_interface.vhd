----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:02:09 12/08/2016 
-- Design Name: 
-- Module Name:    out_interface - Behavioral 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity out_interface is
PORT 
	(		
		clk,clr		: IN STD_LOGIC;
		alu_result	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		datamem_val	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		is_halt		: IN STD_LOGIC;
		toggle_op	: IN STD_LOGIC;
		indicator	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);	--led out
		to_read_addr	: OUT STD_LOGIC_VECTOR (31 downto 0);	--addr to mux
		mux_read_sel: OUT  STD_LOGIC;								-- sel to mux
		SSEG_CA 		: OUT  STD_LOGIC_VECTOR (7 downto 0);
		SSEG_AN 		: OUT  STD_LOGIC_VECTOR (7 downto 0)
	 );
	 
end out_interface;

architecture Behavioral of out_interface is

----------------------------------------------------------
------        7-Seg SIGNALS/ CONSTANTS             -------
----------------------------------------------------------
component Hex2LED 
port (CLK: in STD_LOGIC; X: in STD_LOGIC_VECTOR (3 downto 0); Y: out STD_LOGIC_VECTOR (7 downto 0)); 
end component; 

type arr is array(0 to 22) of std_logic_vector(7 downto 0);
signal NAME: arr;

constant CNTR_MAX : std_logic_vector(23 downto 0) := x"030D40"; --100,000,000 = clk cycles per second
constant VAL_MAX : std_logic_vector(3 downto 0) := "1001"; --9
constant RESET_CNTR_MAX : std_logic_vector(17 downto 0) := "110000110101000000";-- 100,000,000 * 0.002 = 200,000 = clk cycles per 2 ms


--This is used to determine when the 7-segment display should be
--incremented
signal Cntr : std_logic_vector(26 downto 0) := (others => '0');

--This counter keeps track of which number is currently being displayed
--on the 7-segment.
signal Val : std_logic_vector(3 downto 0) := (others => '0');

--This is the signal that holds the hex value to be diplayed
signal hexval: std_logic_vector(31 downto 0):=x"00000000";

signal clk_cntr_reg : std_logic_vector (4 downto 0) := (others=>'0'); 


-- Out TOGGLE has 4 states 
   TYPE  StateType IS (ST_NONE,
									ST_ENC_LSB,
									ST_ENC_MSB, 
									ST_DEC_LSB, 
									ST_DEC_MSB 
                       );
	SIGNAL  showing_state :   StateType := ST_NONE;
						  
	signal no_halt_occured: std_logic :='1';
	signal toggle_op_prev : std_logic :='0';

begin


display_config_process : process (clr, is_halt)
begin
	IF (clr = '1') THEN
		null;
		--no_halt_occured <= '1';
		--mux_read_sel <= '1';
	ELSIF(is_halt = '0') THEN 
		mux_read_sel <= '1';
		no_halt_occured <= '0';
	ELSE
		no_halt_occured <= '1';
	END IF;
end process;

--state processing : input logic
	PROCESS(clr, clk)
	
	BEGIN
		IF(clr='1') THEN
			toggle_op_prev <= '0';
			showing_state <= ST_NONE; 
		ELSIF(clk'EVENT AND clk='1') THEN
		
			CASE showing_state IS
				WHEN ST_NONE =>  
					IF(is_halt = '1') THEN 
						showing_state <= ST_NONE; 					
					ELSE
						showing_state <= ST_ENC_LSB;
					END IF;
					
				WHEN ST_ENC_LSB =>  
					IF(toggle_op = '1' AND toggle_op_prev = '0') THEN 
						showing_state <= ST_ENC_MSB; 					
					ELSE
						showing_state <= ST_ENC_LSB;
					END IF;
					
				WHEN ST_ENC_MSB =>  
					IF(toggle_op = '1' AND toggle_op_prev = '0') THEN 
						showing_state <= ST_DEC_LSB; 					
					ELSE
						showing_state <= ST_ENC_MSB;
					END IF;
				WHEN ST_DEC_LSB =>  
					IF(toggle_op = '1' AND toggle_op_prev = '0') THEN 
						showing_state <= ST_DEC_MSB; 					
					ELSE
						showing_state <= ST_DEC_LSB;
					END IF;
				WHEN ST_DEC_MSB =>  
					IF(toggle_op = '1' AND toggle_op_prev = '0') THEN 
						showing_state <= ST_ENC_LSB; 					
					ELSE
						showing_state <= ST_DEC_MSB;
					END IF;
				
			END CASE;
			toggle_op_prev <= toggle_op;			
			
		END IF;
	END PROCESS;


	--logic processing : outputs defineing
PROCESS(showing_state)
	BEGIN
		CASE showing_state IS
			WHEN ST_NONE =>  
				to_read_addr <= x"00000000";
				indicator <= "0000";
				
			WHEN ST_ENC_LSB =>  
				to_read_addr <= x"000000A0";
				indicator <= "0001";
			WHEN ST_ENC_MSB =>  
				to_read_addr <= x"000000A1";
				indicator <= "0011";
			WHEN ST_DEC_LSB =>  
				to_read_addr <= x"000000A2";
				indicator <= "0111";
			WHEN ST_DEC_MSB =>  
				to_read_addr <= x"000000A3";	
				indicator <= "1111";				
	END CASE;
END PROCESS;

----------------------------------------------------------
------                LED Control                  -------
----------------------------------------------------------

---- This updates what value needs to sent to 7seg display 

display_process : process (clk)
begin
	
	if (rising_edge(clk)) then
		if (no_halt_occured = '0') THEN
			hexval <= datamem_val;
		else
			hexval <= alu_result;
		end if;
	end if;
end process;			


----------------------------------------------------------
------           7-Seg Display Control             -------
----------------------------------------------------------
--Digits are incremented every second, and are blanked in
--response to button presses.

--This process controls the counter that triggers the 7-segment
--to be incremented. It counts 100,000,000 and then resets.		  
timer_counter_process : process (clk)
begin
	if (rising_edge(clk)) then
		if ((Cntr = CNTR_MAX)) then
			Cntr <= (others => '0');
		else
			Cntr <= Cntr + 1;
		end if;
	end if;
end process;

--This process increments the digit being displayed on the 
--7-segment display every second.
timer_inc_process : process (clr, clk)
begin
	IF(clr = '1') THEN 
		Val <= (others => '0');
	elsif (rising_edge(clk)) then
		if (Cntr = CNTR_MAX) then
			if (Val = VAL_MAX) then
				Val <= (others => '0');
			else
				Val <= Val + 1;
			end if;
		end if;
	end if;
end process;

--This select statement selects the 7-segment diplay anode. 
with Val select
	SSEG_AN <= "01111111" when "0001",
				  "10111111" when "0010",
				  "11011111" when "0011",
				  "11101111" when "0100",
				  "11110111" when "0101",
				  "11111011" when "0110",
				  "11111101" when "0111",
				  "11111110" when "1000",
				  "11111111" when others;

--This select statement selects the value of HexVal to the necessary
--cathode signals to display it on the 7-segment
with Val select
	SSEG_CA <= NAME(0) when "0001",
				  NAME(1) when "0010",
				  NAME(2)when "0011",
				  NAME(3) when "0100",
				  NAME(4) when "0101",
				  NAME(5) when "0110",
				  NAME(6) when "0111",
				  NAME(7) when "1000",
				  NAME(0) when others;


CONV1: Hex2LED port map (CLK => clk, X => HexVal(31 downto 28), Y => NAME(0));
CONV2: Hex2LED port map (CLK => clk, X => HexVal(27 downto 24), Y => NAME(1));
CONV3: Hex2LED port map (CLK => clk, X => HexVal(23 downto 20), Y => NAME(2));
CONV4: Hex2LED port map (CLK => clk, X => HexVal(19 downto 16), Y => NAME(3));		
CONV5: Hex2LED port map (CLK => clk, X => HexVal(15 downto 12), Y => NAME(4));
CONV6: Hex2LED port map (CLK => clk, X => HexVal(11 downto 8), Y => NAME(5));
CONV7: Hex2LED port map (CLK => clk, X => HexVal(7 downto 4), Y => NAME(6));
CONV8: Hex2LED port map (CLK => clk, X => HexVal(3 downto 0), Y => NAME(7));


end Behavioral;

