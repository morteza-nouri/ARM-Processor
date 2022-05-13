module ControlUnit (
    input [1:0] mode , input [3:0] opcode , input s ,
    output reg [3:0]Execute_command, 
    output reg mem_read , mem_write, WB_enable , B , status_we
);
    always @(mode, opcode, s) begin
        Execute_command = 0; mem_read = 0;
        mem_write = 0; WB_enable = 0;
        B = 0;
        status_we = 0;

        case (mode)
            2'b00 : begin // Arithmetic Instructions
                case (opcode) 
                    4'b0000 : begin // AND
                    WB_enable = 1'b1;
                    status_we = s;
                    Execute_command = 4'b0110;
                    end
                    4'b0001 : begin // EOR
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b1000;
                    end
                    4'b0010 : begin // SUB
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b0100;
                    end
                    4'b0100 : begin  // ADD
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b0010;
                    end	
                    4'b0101 : begin // ADC
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b0011;
                    end	
                    4'b0110 : begin  // SBC
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b0101;
                    end
                    4'b1000: begin  // TST
                        WB_enable = 1'b0;
                        status_we = 1'b1;
                        Execute_command = 4'b0110;
                    end
                    4'b1100 : begin // ORR
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b0111;
                    end
                    4'b1010 : begin  // CMP
                        WB_enable = 1'b0;
                        status_we = 1'b1;
                        Execute_command = 4'b0100;
                    end
                    4'b1101 : begin // MOV
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b0001;
                    end
                    4'b1111 : begin // MVN
                        WB_enable = 1'b1;
                        status_we = s;
                        Execute_command = 4'b1001;
                    end
                endcase
            end
            2'b01 : begin // Memory Instructions 
                case (s) 
                    1'b1: begin
                        WB_enable = 1'b1;
                        status_we = 1'b1;
                        Execute_command =  4'b0010;
                        mem_read = 1'b1;
                    end

                    1'b0: begin
                        WB_enable = 1'b0;
                        status_we = 1'b0;
                        Execute_command =  4'b0010;
                        mem_write = 1'b1;
                    end
                endcase
            end
            2'b10 : begin // Branch Instruction
                B = 1'b1;
            end
        endcase

    end

endmodule

