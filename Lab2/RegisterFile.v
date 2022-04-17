module RegisterFile #(parameter MEM_SIZE=15, parameter DATA_LEN=32)(
    input clk, rst,
    input [3:0] src1, src2, Dest_wb,
    input [DATA_LEN-1:0] Result_WB,
    input writeBackEn,
    output [DATA_LEN-1:0] reg1, reg2
);

    reg [DATA_LEN-1:0] data [MEM_SIZE-1:0];

    integer i;
    always@(negedge clk, posedge rst) begin
        if(rst) begin
            for(i = 0; i < MEM_SIZE; i = i + 1) begin
                data[i] <= i;
            end
        end
        else if (writeBackEn) begin
            data[Dest_wb] <= Result_WB;
        end
    end
    assign reg1 = data[src1];
    assign reg2 = data[src2];

endmodule