
module MUX2to1 #(parameter  WIDTH = 32)(input [WIDTH-1:0] first, second, input sel, output [WIDTH-1:0] out);
  assign out = (~sel)?first:second;
endmodule


module MUX4to1 #(parameter WIDTH = 32)(inp1, inp2, inp3, inp4, s, out);
    input [31:0] inp1, inp2, inp3, inp4;
    input[1:0] s; 
    output reg [31:0] out;

    always@(s, inp1, inp2, inp3, inp4) begin
        out = 32'b0;
        case(s)
            2'b00: out = inp1;
            2'b01: out = inp2;
            2'b10: out = inp3;
            2'b11: out = inp4;
        endcase
    end

endmodule