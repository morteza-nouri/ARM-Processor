module Register #(parameter WORD_LEN = 32) (
    input clk, rst, ld,
    input [WORD_LEN - 1:0] d_in,
    output reg [WORD_LEN - 1:0] d_out
);

    always @(posedge clk, posedge rst) begin
        if(rst)
            d_out <= 0;
        else if(ld)
            d_out <= d_in;
    end

endmodule 
