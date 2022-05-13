module Register #(parameter  WIDTH = 32)
  (input [WIDTH-1:0] in, input freeze, clk, rst, output reg [WIDTH-1:0] out);
  always @ (posedge clk, posedge rst) begin
    if (rst)
      out <= 0;
    else if (freeze == 0) begin
      out <= in;
    end
  end
endmodule
