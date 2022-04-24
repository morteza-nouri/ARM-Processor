module ID_Stage_Reg (
	input clk,
	input rst,
	input flush,
	input WB_EN_IN,
	input MEM_R_EN_IN,
	input MEM_W_EN_IN,
	input B_IN, 
	input S_IN, 
	input [3:0] EXE_CMD_IN,
	input [31:0] PC_IN,
	input [31:0] Val_Rn_IN,
	input [31:0] Val_Rm_IN,
	input imm_IN,
	input [11:0] Shift_operand_IN,
	input [23:0] Signed_imm_24_IN,
	input [3:0] Dest_IN,
	input [3:0] src1_IN,
	input [3:0] src2_IN,
	output WB_EN,
	output MEM_R_EN,
	output MEM_W_EN,
	output B,
	output S,
	output [3:0] EXE_CMD,
	output [31:0] PC,
	output [31:0] Val_Rn,
	output [31:0] Val_Rm,
	output imm,
	output [11:0] Shift_operand,
	output [23:0] Signed_imm_24,
	output [3:0] Dest,
	output [3:0] src1,
	output [3:0] src2
);
	Register #(.WORD_LEN(1)) WB_EN_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(WB_EN_IN & {1{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(WB_EN)
		);

	Register #(.WORD_LEN(1)) MEM_R_EN_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(MEM_R_EN_IN & {1{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(MEM_R_EN)
		);

	Register #(.WORD_LEN(1)) MEM_W_EN_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(MEM_W_EN_IN & {1{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(MEM_W_EN)
		);

	Register #(.WORD_LEN(1)) B_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(B_IN & {1{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(B)
		);

	Register #(.WORD_LEN(1)) S_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(S_IN & {1{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(S)
		);

	Register #(.WORD_LEN(4)) EXEC_CMD_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(EXE_CMD_IN & {4{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(EXE_CMD)
		);

	Register #(.WORD_LEN(32)) PC_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(PC_IN & {32{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(PC)
		);

	Register #(.WORD_LEN(32)) Val_Rn_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(Val_Rn_IN & {32{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(Val_Rn)
		);

	Register #(.WORD_LEN(32)) Val_Rm_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(Val_Rm_IN & {32{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(Val_Rm)
		);

	Register #(.WORD_LEN(1)) imm_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(imm_IN & {1{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(imm)
		);

	Register #(.WORD_LEN(12)) Shift_operand_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(Shift_operand_IN & {12{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(Shift_operand)
		);

	Register #(.WORD_LEN(24)) Signed_imm_24_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(Signed_imm_24_IN & {24{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(Signed_imm_24)
		);

	Register #(.WORD_LEN(4)) Dest_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(Dest_IN & {4{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(Dest)
		);

	Register #(.WORD_LEN(4)) src1_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(src1_IN & {4{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(src1)
		);

	Register #(.WORD_LEN(4)) src2_reg (
		.clk(clk),
		.rst(rst),
		.ld(1'b1),
		.d_in(src2_IN & {4{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.d_out(src2)
		);

endmodule 