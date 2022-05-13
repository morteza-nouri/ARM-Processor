module ALU (
  input [31:0] val1, val2,
  input [3:0] exe_cmd, sr,
  output reg [31:0] alu_result,
  output reg [3:0] status
  );

  wire cin;
  reg z, cout, n, v;

  assign cin = sr[2];

  always @ ( * ) begin
    {v, cout} = 2'b0;
    case(exe_cmd)
      4'b0001: begin
        alu_result = val2;
      end

      4'b1001: begin
        alu_result = ~val2;
      end

      4'b0010: begin
        {cout, alu_result} = val1 + val2;
        v = ((val1[31] == val2[31]) & (alu_result[31] != val1[31]));
      end

      4'b0011: begin
        {cout, alu_result} = val1 + val2 + cin;
        v = ((val1[31] == val2[31]) & (alu_result[31] != val1[31]));
      end

      4'b0100: begin
        {cout ,alu_result} = val1 - val2;
        v = ((val1[31] == ~val2[31]) & (alu_result[31] != val1[31]));
      end

      4'b0101: begin
        {cout ,alu_result} = val1 - val2 - 1 + cin;
        v = ((val1[31] == ~val2[31]) & (alu_result[31] != val1[31]));
      end

      4'b0110: begin
        alu_result = val1 & val2;
      end

      4'b0111: begin
        alu_result = val1 | val2;
      end

      4'b1000: begin
        alu_result = val1 ^ val2;
      end

      default: begin
        alu_result = 32'bz;
      end
    endcase

    z = (alu_result == 32'b0) ? 1 : 0;
    n = alu_result[31];
    status = {z, cout, n, v};
  end
endmodule
