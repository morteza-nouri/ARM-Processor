module WB_Stage (
  input [31:0] ALU_result, Mem_result,
  input Mem_R_en, WB_en_in,
  input [3:0] Dest_in,
  output [31:0] out,
  output WB_en,
  output [3:0] Dest
  );
	MUX2to1 #(.WIDTH(32)) wb_mux (.first(ALU_result), .second(Mem_result), .sel(Mem_R_en), .out(out));
	assign WB_en = WB_en_in;
	assign Dest = Dest_in;
endmodule
