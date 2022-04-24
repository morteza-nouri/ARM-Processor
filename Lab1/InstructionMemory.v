
module InstructionMemory #(parameter WORD_LEN = 32, parameter ADDR_LEN = 32) (
    input clk,
    input rst,
    input [ADDR_LEN - 1:0] addr,
    output [WORD_LEN - 1:0] inst
);
    reg [7:0] memory [0:255]; // 1 kbyte 

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            {memory[0], memory[1], memory[2], memory[3]} <= 32'b1110_00_1_1101_0_0000_0000_000000010100;      //  MOV R0 = 20           R0 = 20
            {memory[4], memory[5], memory[6], memory[7]} <= 32'b1110_00_1_1101_0_0000_0001_101000000001;      //  MOV R1 ,#4096         R1 = 4096
            {memory[8], memory[9], memory[10], memory[11]} <= 32'b1110_00_1_1101_0_0000_0010_000100000011;    //   MOV R2 ,#0xC0000000    R2 = -1073741824
            {memory[12], memory[13], memory[14], memory[15]} <= 32'b1110_00_0_0100_1_0010_0011_000000000010; //   ADDS R3 ,R2,R2         R3 = -2147483648 
            {memory[16], memory[17], memory[18], memory[19]} <=  32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC R4 ,R0,R0 //R4 = 41
            {memory[20], memory[21], memory[22], memory[23]} <= 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB R5 ,R4,R4,LSL #2     //R5 = -123 
            {memory[24], memory[25], memory[26], memory[27]} <= 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC R6 ,R0,R0,LSR #1     //R6 = 10
            {memory[28], memory[29], memory[30], memory[31]} <= 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR    R7 ,R5,R2,ASR #2  //R7 = -123
            {memory[32], memory[33], memory[34], memory[35]} <= 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND R8 ,R7,R3   R8 = -2147483648
            {memory[36], memory[37], memory[38], memory[39]} <= 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN R9 ,R6//R9 = -11
            {memory[40], memory[41], memory[42], memory[43]} <= 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR R10,R4,R5//R10 = -84
            {memory[44], memory[45], memory[46], memory[47]} <= 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP R8 ,R6
            {memory[48], memory[49], memory[50], memory[51]} <= 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE R1 ,R1,R1//R1 = 8192
            {memory[52], memory[53], memory[54], memory[55]} <= 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST R9 ,R8
            {memory[56], memory[57], memory[58], memory[59]} <= 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADD EQ R2 ,R2,R2   //R2 = -1073741824
            {memory[60], memory[61], memory[62], memory[63]} <= 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV R0 ,#1024      //R0 = 1024
            {memory[64], memory[65], memory[66], memory[67]} <= 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR R1 ,[R0],#0    //MEM[1024] = 8192
            {memory[68], memory[69], memory[70], memory[71]} <= 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR R11,[R0],#0    //R11 = 8192
        end
    end

    assign inst = {memory[addr], memory[addr + 1], memory[addr + 2], memory[addr + 3]};

endmodule
