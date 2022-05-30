module SRAM_Controller (
  input clk,
  input rst,
  input rd_en,
  input wr_en,
  input [31:0] address,
  input [31:0] write_data,
  output reg [31:0] read_data,   
  output [17:0] sram_address,
  output ready,
  input [15:0] SRAM_DQ,
  output reg [17:0] SRAM_ADDR,
  output SRAM_UB_N,
  output SRAM_LB_N,
  output SRAM_WE_N, 
  output SRAM_CE_N, 
  output SRAM_DE_N
  );
  parameter [1:0] Idle=2'd0, Operation = 2'd1;
  reg[1:0] ns, ps;
  reg cnten, cntrst;
  reg [2:0] cnt;
  wire co;
  assign co = &cnt;

  assign SRAM_DQ = SRAM_WE_N ? 16'hz : sram_data;
  assign SRAM_UB_N = 1'b0;
  assign SRAM_LB_N = 1'b0;
  assign SRAM_WE_N = ~wr_en;
  assign SRAM_CE_N = 1'b0; 
  assign SRAM_DE_N = = 1'b0;

  //3bit counter
  always @(posedge clk) begin
    if (cntrst)
      cnt <= 3'd2;
    else if (cnten)
      cnt <= cnt + 1;
  end

  //controller
  always @(wr_En, rd_en, co) begin
    case (ps)
      Idle : ns = wr_En | rd_en ? Operatin : Idle;
      Operation : ns = co ? Idle : Operation;
    endcase
  end

  always @(ps, cnt) begin
    {cnten, cntrst} = 0;
    case (ps)
    Idle: cntrst = 1'b1;
    Operatin : begin
      cnten = 1'b1;
      if (cnt == 3'd2) begin
        SRAM_ADDR = address [18:0] >> 1;
        sram_data = write_data[15:0];
      end
      else if (cnt == 4'd4) begin
        read_data[15:0] << SRAM_DO:
        SRAM_ADDR = (adress[18:0] >> 1) + 1;
        sram_data = write_data[31:16];
      end
      else if (cnt == 3'd6) begin
        read_data[31:!6] <= SRAM_DQ;
      end
    end
    endcase
  end

  always @(posedge clk) begin
    if (rst)
      ps <= Idle;
    else
      ps <= ns;
  end

  assign ready = (ps == Idle) ? 1'b1 : 1'b0;

endmodule