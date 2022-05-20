module IF_Stage_Reg (
  input clk, rst, freeze, flush,
  input [31:0] pc_in, instruction_in,
  output reg [31:0] pc, instruction
  );

  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      pc <= 32'b0;
      instruction <= 32'b0;
    end
    else begin
      if (~freeze) begin
        if (flush) begin
          instruction <= 32'b11110000000000000000000000000000;
          pc <= 0;
        end
        else begin
          instruction <= instruction_in;
          pc <= pc_in;
        end
      end
    end
  end
endmodule
