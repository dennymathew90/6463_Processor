----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:46:35 12/10/2016 
-- Design Name: 
-- Module Name:    input_interface - Behavioral 
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

entity input_interface is

PORT 
	(
		clr, clk		: IN STD_LOGIC;		
		mode_toggle	: IN	STD_LOGIC;  -- run instruction one by one or batch
		in_valid		: IN	STD_LOGIC;  -- input is valid
		stepper		: IN	STD_LOGIC;  -- step by step exec
		led_in_indicator		: OUT	STD_LOGIC_VECTOR (3 downto 0);  -- debug
		pc_incr_val	: OUT	STD_LOGIC   -- add 0 or 1 to PC	
	 );
end input_interface;

architecture Behavioral of input_interface is

	-- Input state machine has five states 
   TYPE  StateType IS (ST_IDLE, --
									ST_S_WAIT, -- wait in single cycle mode 
									ST_S_EXEC, -- execute in .
									ST_B_EXEC -- output is flagged ready
                       );
   -- RC5 state machine has four states: idle, pre_round, round and ready
   SIGNAL  input_state		:   StateType := ST_IDLE;
	SIGNAL  input_state_prev:   StateType := ST_IDLE;
	
	constant E_SINGLE : std_logic := '0'; 
	constant E_BATCH : std_logic := '1'; 
	
	SIGNAL e_mode		: STD_LOGIC := E_SINGLE; -- by default single mode
	
	SIGNAL in_valid_prev	: STD_LOGIC := '0'; -- round counter	 
	SIGNAL stepper_prev	: STD_LOGIC := '0'; -- round counter	 
	SIGNAL mode_toggle_prev	: STD_LOGIC := '0'; -- round counter	 



begin
	--state processing : input logic
	PROCESS(clr, clk)
	
	BEGIN
		IF(clr='1') THEN
			input_state <= ST_IDLE;
			e_mode <= E_SINGLE;
			in_valid_prev <= '0';
			stepper_prev <= '0';
			mode_toggle_prev <= '0';
			input_state_prev <= ST_IDLE;
		ELSIF(clk'EVENT AND clk='1') THEN
		
			CASE input_state IS
				WHEN ST_IDLE =>  
					IF(in_valid = '1' AND in_valid_prev = '0') THEN 
						IF(e_mode = E_SINGLE) THEN 
							input_state <= ST_S_WAIT;
						ELSE
							input_state <= ST_B_EXEC;
						END IF;
					ELSIF (mode_toggle = '1'  AND mode_toggle_prev = '0') THEN
						e_mode <= not e_mode;
					ELSE
						input_state <= ST_IDLE;
					END IF;
					
				WHEN ST_S_WAIT =>    
					IF(stepper = '1'  AND stepper_prev = '0') THEN 
						input_state <= ST_S_EXEC;
					ELSIF (mode_toggle = '1'  AND mode_toggle_prev = '0') THEN
						e_mode <= not e_mode;
						input_state <= ST_B_EXEC;
					ELSE
						input_state <= ST_S_WAIT;
					END IF;
					
				WHEN ST_S_EXEC =>  
					--IF (input_state_prev = ST_S_EXEC) THEN
						input_state <= ST_S_WAIT;	-- back to wait after one clock cycle
					--ELSE
						--input_state <= ST_S_EXEC;	
					--END IF;
				WHEN ST_B_EXEC =>   
					IF (mode_toggle = '1'  AND mode_toggle_prev = '0') THEN
						e_mode <= not e_mode;
						input_state <= ST_S_WAIT;
					ELSE
						input_state <= ST_B_EXEC;
					END IF;			
			END CASE;
			in_valid_prev <= in_valid;
			stepper_prev <= stepper;
			mode_toggle_prev <= mode_toggle;
			input_state_prev <= input_state;
			
		END IF;
	END PROCESS;


	--logic processing : state changes
PROCESS(clr, clk)
	BEGIN
	IF(clr='1') THEN
			pc_incr_val <= '0';
	ELSIF(clk'EVENT AND clk='1') THEN
		CASE input_state IS
			WHEN ST_IDLE =>  
				pc_incr_val <= '0';
				led_in_indicator <= "0001";
			WHEN ST_S_WAIT =>  
				pc_incr_val <= '0';
				led_in_indicator <= "0011";
			WHEN ST_S_EXEC =>  
				pc_incr_val <= '1';
				led_in_indicator <= "0111";
			WHEN ST_B_EXEC =>  
				pc_incr_val <= '1';
				led_in_indicator <= "1111";
		END CASE;
	END IF;
END PROCESS;

end Behavioral;

