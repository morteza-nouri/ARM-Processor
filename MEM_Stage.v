`timescale 1ns/1ns

module MEM_Stage (
  input clk, rst,
  input wb_en_in, mem_r_en_in, mem_w_en,
  input [31:0] alu_result_in, val_rm,
  input [3:0] dest_in,
  output mem_r_en_out, wb_en_out,
  output [31:0] alu_result_out, mem_data,
  output [3:0] dest_out,
  output sram_ready,
  inout [15:0] SRAM_DQ,
  output [17:0] SRAM_ADDR,
  output SRAM_UB_N,
  output SRAM_LB_N,
  output SRAM_WE_N,
  output SRAM_CE_N,
  output SRAM_OE_N
  );

  assign alu_result_out = alu_result_in;
  assign mem_r_en_out = ~sram_ready ? 'd0 : mem_r_en_in;
  assign wb_en_out = wb_en_in;
  assign dest_out = dest_in;

  SRAMController sramCtrl(.clk(clk), .rst(rst), .write_en(mem_w_en),
  .read_en(mem_r_en_in), .addr(alu_result_in), .st_val(val_rm),
  .read_data(mem_data), .ready(sram_ready), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR),
  .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), .SRAM_WE_N(SRAM_WE_N),
  .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N));

  // DataMemory memory (
  //   .clk(clk),
  //   .rst(rst),
  //   .data(val_rm),
  //   .address(alu_result_in),
  //   .MEMwrite(mem_w_en), 
  //   .MEMread(mem_r_en_in),
  //   .MEM_Result(mem_data)
  //   );


endmodule
