`timescale 1ns/1ns

module arm_pipeline_test();
    reg clk = 0, rst = 0, forward_en = 0;

    ARM uut(clk, rst, forward_en);

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

ARM uut(clk, rst, forward_en);

initial begin
  repeat (2000) #5 clk = ~clk;
end

initial begin
  #10 rst = 1;
  #20 rst = 0;
end

endmodule
