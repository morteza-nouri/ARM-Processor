
module ConditionCheck (
    input [3:0] cond,
    input [3:0] SR,
    output reg condition_status
);

    wire z, c, n, v;
    assign {z, c, n, v} = SR;

    always @(cond, z, c, n, v) begin
        condition_status = 1'b0;
        case(cond)
            4'b0000 : begin // EQ
                condition_status <= z;
            end
            4'b0001 : begin // NE
                condition_status <= ~z;
            end
            4'b0010 : begin // CS/HS
                condition_status <= c;
            end
            4'b0011 : begin // CC/LO
                condition_status <= ~c;
            end
            4'b0100 : begin // MI
                condition_status <= n;
            end
            4'b0101 : begin // PL
                condition_status <= ~n;
            end
            4'b0110 : begin //VS
                condition_status <= v;
            end
            4'b0111 : begin // VC
                condition_status <= ~v;
            end
            4'b1000 : begin // HI
                condition_status <= c & ~z;
            end
            4'b1001 : begin // LS
                condition_status <= ~c | z;
            end
            4'b1010 : begin // GE
                condition_status <= (n & v) | (~n & ~v);
            end
            4'b1011 : begin // LT
                condition_status <= (n & ~v) | (~n & v);
            end
            4'b1100 : begin // GT
                condition_status <= ~z & ((n & v) | (~n & ~v));
            end
            4'b1101 : begin // LE
                condition_status <= z | (n & ~v) | (~n & ~v);
            end
            4'b1110 : begin // AL
                condition_status <= 1'b1;
            end
            default: condition_status <= 1'b0;
        endcase
    end

endmodule