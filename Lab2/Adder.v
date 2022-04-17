
module Adder #(parameter DATA_LENGH=32) (
    input [DATA_LENGH - 1:0] a, b,
    output [DATA_LENGH - 1:0] sum
);

    assign sum = a + b;

endmodule
