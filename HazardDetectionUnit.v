module HazardDetectionUnit(
  input [3:0] src1, src2,
  input [3:0] Exe_Dest,Mem_Dest,
  input two_src, forward_en,
  input Exe_WB_En, Exe_MEM_R_En, Mem_WB_En,
  output reg hazard_Detected
  );

  always @(*) begin
    hazard_Detected = 1'b0;
    if (~forward_en) begin
        if ((src1 == Exe_Dest) && (Exe_WB_En == 1'b1))
            hazard_Detected = 1'b1;
        else
        if ((src1 == Mem_Dest) && (Mem_WB_En == 1'b1))
            hazard_Detected = 1'b1;
        else
        if ((src2 == Exe_Dest) && (Exe_WB_En == 1'b1) && (two_src == 1'b1))
            hazard_Detected = 1'b1;            
        else
        if ((src2 == Mem_Dest) && (Mem_WB_En == 1'b1) && (two_src == 1'b1))
            hazard_Detected = 1'b1;    
        else
            hazard_Detected = 1'b0;
    end
    
    if (forward_en) begin
        if ((src1 == Exe_Dest) && Exe_MEM_R_En)
            hazard_Detected = 1'b1;
        else
        if ((src2 == Exe_Dest) && (two_src == 1'b1) && Exe_MEM_R_En)
            hazard_Detected = 1'b1;
        else
            hazard_Detected = 1'b0;
    end
  end

	//  assign hazard_not_forwarding = ( (src1 == Exe_Dest) && Exe_WB_En) ? 1'b1:
	//  						  ( (src1 == Mem_Dest) && Mem_WB_En ) ? 1'b1:
	//  						  ( (src2 == Exe_Dest) && Exe_WB_En && two_src) ? 1'b1:
	//  						  ( (src2 == Mem_Dest) && Mem_WB_En && two_src) ? 1'b1:1'b0;

  // assign hazard_forwarding = ( (src1 == Exe_Dest) && Exe_WB_En) ? 1'b1:
  //           ( (src2 == Exe_Dest) && Exe_WB_En && two_src) ? 1'b1:1'b0;
  // assign hazard_Detected = (forward_en) ? hazard_forwarding : hazard_not_forwarding;

endmodule
