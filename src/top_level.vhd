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

entity Top_level is

PORT 
	(
		clr, clk		: IN STD_LOGIC
	 );
	 
end Top_level;

architecture Behavioral of Top_level is
component alu
    port(
         a 				: IN STD_LOGIC(31 DOWNTO 0);
			b 				: IN STD_LOGIC(31 DOWNTO 0);
			op_select 	: IN STD_LOGIC(3 DOWNTO 0);
			output 		: OUT STD_LOGIC(31 DOWNTO 0)		
        );
end component;

component control_unit
    port(
         clr, clk			: IN STD_LOGIC;
			opcode			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
			func				: IN STD_LOGIC_VECTOR(5 DOWNTO 0);	
			c_jump			: OUT STD_LOGIC;
			c_regdst			: OUT STD_LOGIC;
			c_branch			: OUT STD_LOGIC;
			c_memtoreg		: OUT STD_LOGIC;
			c_memread		: OUT STD_LOGIC;
			c_aluop			: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			c_memwrite		: OUT STD_LOGIC;
			c_alusrc			: OUT STD_LOGIC;
			c_regwrite		: OUT STD_LOGIC			
        );
end component;

component gpr
    port(
         rs 			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			rt 			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			r_des			: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			data_wb		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			reg_write_h	: IN STD_LOGIC;		
			data_r1		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_r2		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)		
        );
end component;

component instr_mem
    port(
         read_addr	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			instr_32		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	
        );
end component;

component mux2
    port(
         rt 				: IN STD_LOGIC(4 DOWNTO 0);
			rd 				: IN STD_LOGIC(4 DOWNTO 0);
			r_select 		: IN STD_LOGIC;
			out_reg 			: OUT STD_LOGIC(4 DOWNTO 0)		
        );
end component;

component pc
    port(
         clr, clk		: IN STD_LOGIC;
			nextaddr		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)		
        );
end component;


component add
	port(
		add_a 				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		add_b 				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		output		 		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)		
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
ALU : alu port map (
			 a => data_r1_t,
			 b => data_r2_t,
			 op_select => c_aluop_t,
			 output => data_wb_t
        );

--instantiate and do port map for the Control Unit.
CU : control_unit port map (
			 clr				=> clr,
			 clk				=> clk,
          opcode 			=> instr_32_t(31 downto 26),
			 func 			=> instr_32_t(5 downto 0),				
			 --c_jump 			=> 				
			 c_regdst 		=> c_regdst_t,				
			 --c_branch 		=> 				
			 --c_memtoreg 	=> 			
			 --c_memread 		=> 			
			 c_aluop	 		=> c_aluop_t,			
			 --c_memwrite 	=> 			
			 --c_alusrc	 	=> 			
			 c_regwrite 	=> c_regwrite_t				 
        );
		  
--instantiate and do port map for the gpr.
GPR : gpr port map (
			rs 			=>	instr_32_t(25 downto 21),	
			rt 			=>	instr_32_t(20 downto 16),	
			r_des			=>	out_reg_t,
			data_wb		=>	data_wb_t,	
			reg_write_h	=> c_regwrite_t,
			data_r1		=>	data_r1_t,
			data_r2		=>	data_r2_t			
        );

--instantiate and do port map for the instr_mem.
INSTR_MEM : instr_mem port map (			
			read_addr	=>	pc_addr_t,
			instr_32		=>	instr_32_t			
        );
	
MUX2 : mux2 port map (			
			rt 			=>	instr_32_t(20 downto 16),
			rd				=>	instr_32_t(15 downto 11),
			r_select		=>	c_regdst_t,
			out_reg		=>	out_reg_t
        );
		  
PC : pc port map (			
			clr			=>	clr, 
			clk			=>	clk,
			nextaddr		=>	nextaddr_t,
			pc_addr		=>	pc_addr_t
        );
		  
ADD : add port map (			
			add_a 		=>	pc_addr_t,
			add_b 		=>	add_4_t,
			output		=>	nextaddr_t		
        );
		  
end Behavioral;

