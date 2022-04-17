
module InstructionMemory #(parameter WORD_LEN = 32, parameter ADDR_LEN = 32) (
    input [ADDR_LEN - 1:0] addr,
    output [WORD_LEN - 1:0] inst
);
    reg [WORD_LEN - 1:0] memory [0:255]; // 1 kbyte 
    initial begin
        $readmemb("instructions.mem", memory);
    end
    assign inst = memory[addr[31:2]];

endmodule
