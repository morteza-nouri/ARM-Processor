
module IF_Stage (
  input clk, rst, freeze, branch_taken,
  input [31:0] branch_address,
  output [31:0] pc, instruction
  );

  wire [31:0] pc_in, pc_out;

  InstructionMemory instruction_memory(.rst(rst), .in(pc_out), .out(instruction));
  Adder #(.WIDTH(32)) pc_adder(.first(32'd4), .second(pc_out), .out(pc));
  Register #(.WIDTH(32)) pc_reg(.in(pc_in), .freeze(freeze), .clk(clk), .rst(rst), .out(pc_out));
  MUX2to1 #(.WIDTH(32)) pc_mux (.first(pc), .second(branch_address), .sel(branch_taken), .out(pc_in));
endmodule
