module MEM_Stage_Reg (
  input clk, rst, ld ,WB_en_in, Mem_R_en_in,
  input [31:0] ALU_result_in, Mem_read_value_in,
  input [3:0] Dest_in,
  output reg WB_en, Mem_R_en, 
  output reg [31:0] ALU_result, Mem_read_value,
  output reg [3:0] Dest
  );
    always @(posedge clk, posedge rst) begin
        if (rst == 1'b1) begin
            Mem_R_en <= 1'b0;
            Mem_read_value <= 32'd0;
            Dest <= 32'd0;
            ALU_result <= 32'd0;
            WB_en <= 1'b0;
        end
        else if (ld == 1'b1) begin
            Mem_R_en <= Mem_R_en_in;
            ALU_result <= ALU_result_in;
            Mem_read_value <= Mem_read_value_in;
            Dest <= Dest_in;
            WB_en <= WB_en_in;
        end
    end
endmodule
