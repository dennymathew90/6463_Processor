----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:42 11/26/2016 
-- Design Name: 
-- Module Name:    Top_level - Behavioral 
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

entity top_level is

PORT 
	(
		clr, clk		: IN STD_LOGIC
	 );
	 
end top_level;

architecture Behavioral of top_level is
COMPONENT alu
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		op_select : IN std_logic_vector(3 downto 0);          
		output : OUT std_logic_vector(31 downto 0);
		zero_out : OUT std_logic
		);
	END COMPONENT;

COMPONENT control_unit
PORT(
		clr : IN std_logic;
		clk : IN std_logic;
		opcode : IN std_logic_vector(5 downto 0);
		func : IN std_logic_vector(5 downto 0);          
		c_jump : OUT std_logic;
		c_regdst : OUT std_logic;
		c_branch : OUT std_logic;
		c_memtoreg : OUT std_logic;
		c_memread : OUT std_logic;
		c_alu_op : OUT std_logic_vector(3 downto 0);
		c_memwrite : OUT std_logic;
		c_alusrc : OUT std_logic;
		c_regwrite : OUT std_logic
		);
	END COMPONENT;

COMPONENT gpr
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		rs : IN std_logic_vector(4 downto 0);
		rt : IN std_logic_vector(4 downto 0);
		r_des : IN std_logic_vector(4 downto 0);
		data_wb : IN std_logic_vector(31 downto 0);
		reg_write_h : IN std_logic;          
		data_r1 : OUT std_logic_vector(31 downto 0);
		data_r2 : OUT std_logic_vector(31 downto 0);
		data_r3 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT mux2
	PORT(
		rt : IN std_logic_vector(31 downto 0);
		imm : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT mux1
	PORT(
		rt : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		sel : IN std_logic;          
		out_reg : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

COMPONENT mux3
	PORT(
		sel : IN std_logic;
		alu_result : IN std_logic_vector(31 downto 0);
		read_data : IN std_logic_vector(31 downto 0);          
		out_data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT mux4
	PORT(
		sel : IN std_logic;
		adder2_result : IN std_logic_vector(31 downto 0);
		added_pc : IN std_logic_vector(31 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT mux5
	PORT(
		mux4_out : IN std_logic_vector(31 downto 0);
		jmp_addr : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT data_mem
	PORT(
		mem_write : IN std_logic;
		mem_read : IN std_logic;
		address : IN std_logic_vector(31 downto 0);
		write_data : IN std_logic_vector(31 downto 0);          
		read_data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT shift_left_2
	PORT(
		instr : IN std_logic_vector(25 downto 0);          
		output : OUT std_logic_vector(27 downto 0)
		);
	END COMPONENT;
	
COMPONENT adder1
	PORT(
		in_addr : IN std_logic_vector(31 downto 0);          
		out_addr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT adder2
	PORT(
		imm_val : IN std_logic_vector(31 downto 0);
		added_pc : IN std_logic_vector(31 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT and_gate
	PORT(
		branch : IN std_logic;
		zero : IN std_logic;          
		output : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT sign_extd
	PORT(
		imm_val : IN std_logic_vector(15 downto 0);          
		sign_extd_val : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
component pc
    port(
         clr, clk		: IN STD_LOGIC;
			nextaddr		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)		
        );
end component;

--All the signals are declared here,which are not a part of the top module.
--These are temporary signals.


--ALU 
signal 	a_t 				:  STD_LOGIC(31 DOWNTO 0);
signal 	b_t 				:  STD_LOGIC(31 DOWNTO 0);
signal	op_select_t 	:  STD_LOGIC(3 DOWNTO 0);
signal	output_t 		:  STD_LOGIC(31 DOWNTO 0);

--Control Unit
signal	opcode_t			:  STD_LOGIC_VECTOR(5 DOWNTO 0);	
signal	func_t				:  STD_LOGIC_VECTOR(5 DOWNTO 0);	
signal	c_jump_t			:  STD_LOGIC;
signal	c_regdst_t			:  STD_LOGIC;
signal	c_branch_t			:  STD_LOGIC;
signal	c_memtoreg_t		:  STD_LOGIC;
signal	c_memread_t		:  STD_LOGIC;
signal	c_aluop_t			:  STD_LOGIC_VECTOR(2 DOWNTO 0);
signal	c_memwrite_t		:  STD_LOGIC;
signal	c_alusrc_t		:  STD_LOGIC;
signal	c_regwrite_t		:  STD_LOGIC;

--gpr
signal	rs_t 			:  STD_LOGIC_VECTOR(4 DOWNTO 0);
signal	rt_t 			:  STD_LOGIC_VECTOR(4 DOWNTO 0);
signal	r_des_t			:  STD_LOGIC_VECTOR(4 DOWNTO 0);
signal	data_wb_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal	reg_write_h_t	:  STD_LOGIC;		
signal	data_r1_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal	data_r2_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);

--inst mem
signal	read_addr_t	:  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal	instr_32_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);

--mux
signal	rt_t 				:  STD_LOGIC(4 DOWNTO 0);
signal	rd_t 				:  STD_LOGIC(4 DOWNTO 0);
signal	r_select_t 		:  STD_LOGIC;
signal	out_reg_t 			:  STD_LOGIC(4 DOWNTO 0);

--pc
signal	nextaddr_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal	pc_addr_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);

--add			
signal 	add_a_t			: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal	add_4_t			: STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000004";
signal	output_t	 		: STD_LOGIC_VECTOR(31 DOWNTO 0);			
		
begin

--instantiate and do port map for the ALU.
Inst_alu: alu PORT MAP(
		a => ,
		b => ,
		op_select => ,
		output => ,
		zero_out => 
	);

--instantiate and do port map for the Control Unit.
Inst_control_unit: control_unit PORT MAP(
		clr => ,
		clk => ,
		opcode => ,
		func => ,
		c_jump => ,
		c_regdst => ,
		c_branch => ,
		c_memtoreg => ,
		c_memread => ,
		c_alu_op => ,
		c_memwrite => ,
		c_alusrc => ,
		c_regwrite => 
	);
		  
--instantiate and do port map for the gpr.
Inst_gpr: gpr PORT MAP(
		clk => ,
		clr => ,
		rs => ,
		rt => ,
		r_des => ,
		data_wb => ,
		reg_write_h => ,
		data_r1 => ,
		data_r2 => ,
		data_r3 => 
	);




--instantiate and do port map for the instr_mem.
INSTR_MEM : instr_mem port map (			
			read_addr	=>	pc_addr_t,
			instr_32		=>	instr_32_t			
        );

--instantiate and do port map for MUX2		
Inst_mux2: mux2 PORT MAP(
		rt => ,
		imm => ,
		sel => ,
		output => 
	);
		 
--instantiate and do port map for MUX1
Inst_mux1: mux1 PORT MAP(
		rt => ,
		rd => ,
		sel => ,
		out_reg => 
	);		

--instantiate and do port map for MUX3
Inst_mux3: mux3 PORT MAP(
		sel => ,
		alu_result => ,
		read_data => ,
		out_data => 
	);
--instantiate and do port map for MUX4
Inst_mux4: mux4 PORT MAP(
		sel => ,
		adder2_result => ,
		added_pc => ,
		output => 
	);
	
--instantiate and do port map for MUX5
Inst_mux5: mux5 PORT MAP(
		mux4_out => ,
		jmp_addr => ,
		sel => ,
		output => 
	);
	
--instantiate and do port map for data memory
Inst_data_mem: data_mem PORT MAP(
		mem_write => ,
		mem_read => ,
		address => ,
		write_data => ,
		read_data => 
	);

--instantiate and do port map for shift left
Inst_shift_left_2: shift_left_2 PORT MAP(
		instr => ,
		output => 
	);
	
--instantiate and do port map for adder1
Inst_adder1: adder1 PORT MAP(
		in_addr => ,
		out_addr => 
	);

--instantiate and do port map for adder2	
Inst_adder2: adder2 PORT MAP(
		imm_val => ,
		added_pc => ,
		output => 
	);
--instantiate and do port map for and gate	
Inst_and_gate: and_gate PORT MAP(
		branch => ,
		zero => ,
		output => 
	);
	
--instantiate and do port map for sign extender	
Inst_sign_extd: sign_extd PORT MAP(
		imm_val => ,
		sign_extd_val => 
	);

--instantiate and do port map for Program Counter		
PC : pc port map (			
			clr			=>	clr, 
			clk			=>	clk,
			nextaddr		=>	nextaddr_t,
			pc_addr		=>	pc_addr_t
        );
		  
		  
end Behavioral;

