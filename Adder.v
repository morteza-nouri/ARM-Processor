
module Adder #(parameter  WIDTH = 32) (input [WIDTH-1:0] first, second, output [WIDTH-1:0] out);
  assign out = first + second;
endmodule
