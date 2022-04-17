module Mux2to1 #(parameter WORD_LEN=32) (
    input sel,
    input [WORD_LEN - 1: 0] a, b,
    output [WORD_LEN - 1:0] out
);

    assign out = sel ? a : b;

endmodule 
