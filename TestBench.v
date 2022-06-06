`timescale 1ns/1ns

module arm_pipeline_test();
    reg clk = 0, rst = 0, forward_en = 0;

    Arm uut(clk, rst, forward_en);

    initial begin
    	repeat (2000) #5 clk = ~clk;
    end

    initial begin
    	#10 rst = 1;
      #20 rst = 0;
    end

endmodule


module arm_forwarding_test ();
reg clk = 0, rst = 0, forward_en = 1;

Arm uut(clk, rst, forward_en);

initial begin
  repeat (2000) #5 clk = ~clk;
end

initial begin
  #10 rst = 1;
  #20 rst = 0;
end

endmodule

module arm_sram_test();

reg clk = 0, rst = 0, forward_en = 1;
wire [17:0] SRAM_ADDR;
wire SRAM_WE_N;
wire [15:0] SRAM_DQ;

Arm uut(clk, rst, forward_en, SRAM_DQ, SRAM_ADDR, SRAM_WE_N);
SRAM sram(clk, rst, SRAM_WE_N, SRAM_ADDR, SRAM_DQ);

initial begin
  repeat (2000) #5 clk = ~clk;
end

initial begin
  #10 rst = 1;
  #20 rst = 0;
end

endmodule