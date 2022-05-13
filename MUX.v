
module MUX2to1 #(parameter  WIDTH = 32)(input [WIDTH-1:0] first, second, input sel, output [WIDTH-1:0] out);
  assign out = (~sel)?first:second;
endmodule


module MUX3to1 #(parameter  WIDTH = 32) (
  input [WIDTH-1:0] first, second, third, input [1:0] sel, output [WIDTH-1:0] out);

  assign out = (sel == 1) ? second : (sel == 2) ? third : first;
endmodule
