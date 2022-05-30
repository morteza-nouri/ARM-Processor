`timescale 1ns/1ns

module SRAM (
  input clk,
  input [17:0] addr,
  input SRAM_UB_N,
  input SRAM_LB_N,
  input SRAM_WE_N, 
  input SRAM_CE_N, 
  input SRAM_DE_N,
  inout [15:0] SRAM_DQ,
  );
  
  reg [15:0] memory [0:2048];
  reg [15:0] mem_out;
  
  always @(posedge clk) begin
    if (SRAM_WE_N == 1'b0)
      memory[addr] <= SRAM_DQ;
    else
      mem_out <= memory[addr];
  end

  assign SRAM_DQ = SRAM_WE_N ? mem_out : 16'hz;

endmodule