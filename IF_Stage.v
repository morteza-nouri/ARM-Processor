module IF_Stage (
    input clk, rst, freeze, Branch_taken,
    input [31:0] BranchAddr,
    output [31:0] PC, Instruction
);

    wire[31:0] pc_in, pc_reg_out;

    Mux2to1 #(.WORD_LEN(32)) mux2to1(.sel(Branch_taken), .a(BranchAddr), .b(PC), .out(pc_in));

    Register #(.WORD_LEN(32)) pcReg(.clk(clk), .rst(rst), .ld(~freeze), .d_in(pc_in), .d_out(pc_reg_out));

    Adder #(.DATA_LENGH(32)) incrementer(.a(pc_reg_out), .b(4), .sum(PC));

    InstructionMemory #(.WORD_LEN(32)) instMemory(.addr(pc_reg_out), .inst(Instruction));


endmodule