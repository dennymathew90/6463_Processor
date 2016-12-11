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
		clr, top_clk		: IN STD_LOGIC;		
		single_step	: IN	STD_LOGIC;  -- run instruction one by one
		run_whole	: IN	STD_LOGIC;  -- input is valid
		show_out		: IN	STD_LOGIC;  -- input is valid			
		do_rdy		: OUT	STD_LOGIC;   -- output is ready
		TOP_SSEG_CA 		: out  STD_LOGIC_VECTOR (7 downto 0);
		TOP_SSEG_AN 		: out  STD_LOGIC_VECTOR (7 downto 0)
	 );
	 
end top_level;

architecture Behavioral of top_level is

COMPONENT instr_mem
	PORT(
		clr			: IN STD_LOGIC;
		read_addr 	: IN std_logic_vector(31 downto 0);          
		instr 		: OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
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
		data_r2 : OUT std_logic_vector(31 downto 0)
--		data_r3 : OUT std_logic_vector(31 downto 0)
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
		d_clk, clr		: IN	STD_LOGIC;
		mem_write : IN std_logic;
		mem_read : IN std_logic;
		address : IN std_logic_vector(31 downto 0);
		write_data : IN std_logic_vector(31 downto 0);          
		read_data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT concatenator
	PORT(
		addr_28 : IN std_logic_vector(25 downto 0);
		pc_msb : IN std_logic_vector(5 downto 0);          
		jmp_addr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
--COMPONENT shift_left_2
--	PORT(
--		instr : IN std_logic_vector(25 downto 0);          
--		output : OUT std_logic_vector(27 downto 0)
--		);
--	END COMPONENT;
	
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
	
COMPONENT out_interface
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;
		alu_result : IN std_logic_vector(31 downto 0);          
		SSEG_CA : OUT std_logic_vector(7 downto 0);
		SSEG_AN : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	
component pc
    port(
         clr, pc_clk		: IN STD_LOGIC;
			nextaddr		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)		
        );
end component;

--All the signals are declared here,which are not a part of the top module.
--These are temporary signals.

-- INSTR MEM
--signal	read_addr 		:  std_logic_vector(31 downto 0);          
signal	instr32_t		:  std_logic_vector(31 downto 0);
		
--ALU 
--signal	a_t				:   std_logic_vector(31 downto 0);
--signal	b_t				:  std_logic_vector(31 downto 0);
--signal	op_select_t		:  std_logic_vector(3 downto 0);          
signal	alu_out_t			:  std_logic_vector(31 downto 0);
--signal	zero_out_t		:  std_logic;

--Control Unit
--signal	clr_t		 	:  std_logic;
--signal	clk_t		 	:  std_logic;
--signal	opcode_t		:  std_logic_vector(5 downto 0);
--signal	func_t		:  std_logic_vector(5 downto 0);          
signal	cu_jump_to_mux5_sel_t		:  std_logic;
signal	cu_regdst_to_mux1_sel_t	:  std_logic;
signal	cu_branch_to_and_t	:  std_logic;
signal	cu_memtoreg_to_mux3_sel_t:  std_logic;
signal	cu_memread_datamem_readsel_t	:  std_logic;
signal	cu_opcode_to_alu_t	:  std_logic_vector(3 downto 0);
signal	cu_memwrite_datamem_writesel_t:  std_logic;
signal	cu_alusrc_to_mux2_sel_t	:  std_logic;
signal	cu_regwrite_to_gpr_t:  std_logic;

--gpr
--signal	rs_t				:  std_logic_vector(4 downto 0);
--signal	rt_t				:  std_logic_vector(4 downto 0);
--signal	r_des_t			:  std_logic_vector(4 downto 0);
--signal	data_wb_t		:  std_logic_vector(31 downto 0);
--signal	reg_write_h_t	:  std_logic;          
signal	gpr_data1_out		:  std_logic_vector(31 downto 0);
signal	gpr_data2_out		:  std_logic_vector(31 downto 0);
--signal	data_r3_t		:  std_logic_vector(31 downto 0);

--mux2
--signal	rt_t		:  std_logic_vector(31 downto 0);
--signal	imm_t		:  std_logic_vector(31 downto 0);
--signal	sel_t		:  std_logic;          
signal	mux2_to_alu_t	:  std_logic_vector(31 downto 0);

--mux1
--signal	rt_t			:  std_logic_vector(4 downto 0);
--signal	rd_t			:  std_logic_vector(4 downto 0);
--signal	sel_t			:  std_logic;          
signal	mux1_to_gpr_t	:  std_logic_vector(4 downto 0);
	
--mux3		
--signal	sel_t				:  std_logic;
signal	alu_result_t	:  std_logic_vector(31 downto 0);
signal	read_data_t		:  std_logic_vector(31 downto 0);          
signal	mux3_to_gpr_t		:  std_logic_vector(31 downto 0);	

--mux4
--signal	sel_t					:  std_logic;
signal	adder2_result_t	:  std_logic_vector(31 downto 0);
signal	added_pc_t			:  std_logic_vector(31 downto 0);          
signal	mux4_to_mux5				:  std_logic_vector(31 downto 0);

--mux5		
--signal	mux4_out_t		:  std_logic_vector(31 downto 0);
--signal	jmp_addr_t		:  std_logic_vector(31 downto 0);
--signal	sel_t				:  std_logic;          
signal	jumpaddr_to_mux5_t			:  std_logic_vector(31 downto 0);
		
--adder 1			
--signal	in_addr_t		:  std_logic_vector(31 downto 0);          
signal	adder1_pc_plus_4out_t		:  std_logic_vector(31 downto 0);		

--adder 2
--signal	imm_val 	: 	std_logic_vector(31 downto 0);
--signal	added_pc : 	std_logic_vector(31 downto 0);          
signal	adder2_to_mux4_t 	:  std_logic_vector(31 downto 0);

--data mem		
--signal	mem_write_t		:  std_logic;
--signal	mem_read_t		:  std_logic;
signal	alu_to_datamem_address_t		:  std_logic_vector(31 downto 0);
--signal	write_data_t	:  std_logic_vector(31 downto 0);          
signal	data_mem_to_mux3_t		:  std_logic_vector(31 downto 0);
	

-- shift left2	
--signal	instr_t			:  std_logic_vector(25 downto 0);          
--signal	slt2_out_t			:  std_logic_vector(27 downto 0);
	
--and
--signal	branch_t		:  std_logic;
signal	alu_zero_to_and_t		:  std_logic;          
signal	and_to_mux4_sel_t		:  std_logic;
		
-- sign extend
--signal	imm_val_t			:  std_logic_vector(15 downto 0);          
signal	sign_extd_val_t	:  std_logic_vector(31 downto 0);
		
--pc
signal	mux5_to_pc_in		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal	pc_addr_t		:  STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

--instantiate and do port map for the ALU.
Inst_alu: alu PORT MAP(
		a => gpr_data1_out,
		b => mux2_to_alu_t,
		op_select => cu_opcode_to_alu_t,
		output => alu_out_t,
		zero_out => alu_zero_to_and_t
	);

	
--instantiate and do port map for the Control Unit.
Inst_control_unit: control_unit PORT MAP(
		clr => clr,
		opcode => instr32_t(31 DOWNTO 26) ,
		func => instr32_t(5 DOWNTO 0),
		c_jump => cu_jump_to_mux5_sel_t,
		c_regdst => cu_regdst_to_mux1_sel_t,
		c_branch => cu_branch_to_and_t,
		c_memtoreg => cu_memtoreg_to_mux3_sel_t,
		c_memread => cu_memread_datamem_readsel_t,
		c_alu_op => cu_opcode_to_alu_t,
		c_memwrite => cu_memwrite_datamem_writesel_t,
		c_alusrc => cu_alusrc_to_mux2_sel_t,
		c_regwrite => cu_regwrite_to_gpr_t
	);
	

Inst_instr_mem: instr_mem PORT MAP(
		clr => clr,
		read_addr => pc_addr_t,
		instr => instr32_t
	);
	
--instantiate and do port map for the gpr.
Inst_gpr: gpr PORT MAP(
		clk => top_clk,
		clr => clr,
		rs => instr32_t(25 DOWNTO 21),
		rt => instr32_t(20 DOWNTO 16),
		r_des => mux1_to_gpr_t,
		data_wb => mux3_to_gpr_t,
		reg_write_h => cu_regwrite_to_gpr_t,
		data_r1 => gpr_data1_out,
		data_r2 => gpr_data2_out 
	);


--instantiate and do port map for MUX2		
Inst_mux2: mux2 PORT MAP(
		rt => gpr_data2_out,
		imm => sign_extd_val_t,
		sel => cu_alusrc_to_mux2_sel_t,
		output => mux2_to_alu_t
	);
		 
--instantiate and do port map for MUX1
Inst_mux1: mux1 PORT MAP(
		rt => instr32_t(20 DOWNTO 16),
		rd => instr32_t(15 DOWNTO 11),
		sel => cu_regdst_to_mux1_sel_t,
		out_reg => mux1_to_gpr_t
	);		

--instantiate and do port map for MUX3
Inst_mux3: mux3 PORT MAP(
		sel => cu_memtoreg_to_mux3_sel_t,
		alu_result => alu_out_t,
		read_data => data_mem_to_mux3_t,
		out_data => mux3_to_gpr_t
	);
--instantiate and do port map for MUX4
Inst_mux4: mux4 PORT MAP(
		sel => and_to_mux4_sel_t,
		adder2_result => adder2_to_mux4_t,
		added_pc => adder1_pc_plus_4out_t,
		output => mux4_to_mux5
	);
	
--instantiate and do port map for MUX5
Inst_mux5: mux5 PORT MAP(
		mux4_out => mux4_to_mux5,
		jmp_addr => jumpaddr_to_mux5_t,
		sel => cu_jump_to_mux5_sel_t,
		output => mux5_to_pc_in
	);
	
--instantiate and do port map for data memory
Inst_data_mem: data_mem PORT MAP(
		d_clk		=> top_clk,
		clr 		=> clr,
		mem_write => cu_memwrite_datamem_writesel_t,
		mem_read => cu_memread_datamem_readsel_t,
		address => alu_out_t,
		write_data => gpr_data2_out,
		read_data => data_mem_to_mux3_t
	);

Inst_concatenator: concatenator PORT MAP(
		addr_28 => instr32_t(25 DOWNTO 0),
		pc_msb => adder1_pc_plus_4out_t(31 DOWNTO 26),
		jmp_addr => jumpaddr_to_mux5_t
	);
	
----instantiate and do port map for shift left
--Inst_shift_left_2: shift_left_2 PORT MAP(
--		instr => instr32_t(25 DOWNTO 0),
--		output => slt2_out_t
--	);
	
--instantiate and do port map for adder1
Inst_adder1: adder1 PORT MAP(
		in_addr => pc_addr_t,
		out_addr => adder1_pc_plus_4out_t
	);

--instantiate and do port map for adder2	
Inst_adder2: adder2 PORT MAP(
		imm_val => sign_extd_val_t,
		added_pc => adder1_pc_plus_4out_t,
		output => adder2_to_mux4_t
	);
--instantiate and do port map for and gate	
Inst_and_gate: and_gate PORT MAP(
		branch => cu_branch_to_and_t,
		zero => alu_zero_to_and_t,
		output => and_to_mux4_sel_t
	);
	
--instantiate and do port map for sign extender	
Inst_sign_extd: sign_extd PORT MAP(
		imm_val => instr32_t(15 DOWNTO 0),
		sign_extd_val => sign_extd_val_t
	);

--instantiate and do port map for Program Counter		
Inst_pc: pc PORT MAP (			
			clr			=>	clr, 
			pc_clk			=>	top_clk,
			nextaddr		=>	mux5_to_pc_in,
			pc_addr		=>	pc_addr_t
   );
	
Inst_out_interface: out_interface PORT MAP(
		clk => top_clk,
		clr => clr,
		alu_result => alu_out_t,
		SSEG_CA => TOP_SSEG_CA,
		SSEG_AN => TOP_SSEG_AN 
	);
	
end Behavioral;

