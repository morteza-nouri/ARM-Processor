module EXE_Stage_Reg (
  input clk, rst,
  input wb_en_in, mem_r_en_in, mem_w_en_in,
  input [31:0] alu_result_in, val_rm_in,
  input [3:0] dest_in,
  output reg wb_en, mem_r_en, mem_w_en,
  output reg [31:0] alu_result, val_rm,
  output reg [3:0] dest
  );
  always @ ( posedge clk, posedge rst ) begin
    if (rst) begin
      {wb_en, mem_r_en, mem_w_en,alu_result, val_rm, dest} = 71'b0;
    end
    else begin
      {wb_en, mem_r_en, mem_w_en, alu_result, val_rm, dest} = 
      {wb_en_in, mem_r_en_in, mem_w_en_in, alu_result_in, val_rm_in, dest_in};
    end
  end
endmodule
