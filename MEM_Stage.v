module MEM_Stage (
  input clk, rst,
  input wb_en_in, mem_r_en_in, mem_w_en,
  input [31:0] alu_result_in, val_rm,
  input [3:0] dest_in,
  output mem_r_en_out, wb_en_out,
  output [31:0] alu_result_out, mem_data,
  output [3:0] dest_out
  );

  assign alu_result_out = alu_result_in;
  assign mem_r_en_out = mem_r_en_in;
  assign wb_en_out = wb_en_in;
  assign dest_out = dest_in;

  DataMemory memory (
    .clk(clk),
    .rst(rst),
    .data(val_rm),
    .address(alu_result_in),
    .MEMwrite(mem_w_en), 
    .MEMread(mem_r_en_in),
    .MEM_Result(mem_data)
    );
endmodule
