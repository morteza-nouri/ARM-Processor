module MEM_Stage_Reg (
  input clk, rst, WB_en_in, Mem_R_en_in,
  input [31:0] ALU_result_in, Mem_read_value_in,
  input [3:0] Dest_in,
  output WB_en, Mem_R_en, 
  output [31:0] ALU_result, Mem_read_value,
  output [3:0] Dest
  );
  Register #(.WIDTH(1)) wb_en_reg (.in(WB_en_in), .rst(rst), .clk(clk),
                                      	.freeze(1'b0), .out(WB_en));
  Register #(.WIDTH(1)) Mem_R_en_reg (.in(Mem_R_en_in), .rst(rst), .clk(clk),
                                          	.freeze(1'b0), .out(Mem_R_en));
  Register #(.WIDTH(32)) ALU_result_reg (.in(ALU_result_in), .rst(rst), .clk(clk),
                                       					.freeze(1'b0), .out(ALU_result));
  Register #(.WIDTH(32)) Mem_read_value_reg (.in(Mem_read_value_in), .rst(rst), .clk(clk),
                                                   		.freeze(1'b0), .out(Mem_read_value));
  Register #(.WIDTH(4)) dest_reg (.in(Dest_in), .rst(rst), .clk(clk),
                   							.freeze(1'b0), .out(Dest));
endmodule
