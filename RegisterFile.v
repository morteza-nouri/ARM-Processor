module RegisterFile #(parameter WIDTH=32)(
    input clk, rst,
    input [3:0] src1, src2, Dest_wb,
    input [WIDTH-1:0] Result_WB,
    input writeBackEn,
    output [WIDTH-1:0] reg1, reg2
);

    reg [WIDTH-1:0] registers [0:14];

    integer i;
    always@(negedge clk, posedge rst) begin
        if(rst) begin
            for(i = 0; i < 15; i = i + 1) begin
                registers[i] <= i;
            end
        end
        else if (writeBackEn) begin
            registers[Dest_wb] <= Result_WB;
        end
    end
    assign reg1 = registers[src1];
    assign reg2 = registers[src2];

endmodule