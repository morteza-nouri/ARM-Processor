module ConditionCheck (
    input [3:0] cond,
    input [3:0] sr,
    output reg out
    );

    wire z, c, n, v;
    assign {z, c, n, v} = sr;

    always @(cond, z, c, n, v) begin
        out = 1'b0;
        case(cond)
            4'b0000 : begin // EQ
                out <= z;
            end
            4'b0001 : begin // NE
                out <= ~z;
            end
            4'b0010 : begin // CS/HS
                out <= c;
            end
            4'b0011 : begin // CC/LO
                out <= ~c;
            end
            4'b0100 : begin // MI
                out <= n;
            end
            4'b0101 : begin // PL
                out <= ~n;
            end
            4'b0110 : begin //VS
                out <= v;
            end
            4'b0111 : begin // VC
                out <= ~v;
            end
            4'b1000 : begin // HI
                out <= c & ~z;
            end
            4'b1001 : begin // LS
                out <= ~c | z;
            end
            4'b1010 : begin // GE
                out <= (n & v) | (~n & ~v);
            end
            4'b1011 : begin // LT
                out <= (n & ~v) | (~n & v);
            end
            4'b1100 : begin // GT
                out <= ~z & ((n & v) | (~n & ~v));
            end
            4'b1101 : begin // LE
                out <= z | (n & ~v) | (~n & ~v);
            end
            4'b1110 : begin // AL
                out <= 1'b1;
            end
            default: out <= 1'b0;
        endcase
    end
endmodule
