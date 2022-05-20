module ID_Stage_Reg (
  input clk, rst, flush,
  input wb_en_in, mem_r_en_in, mem_w_en_in, b_in, s_in, imm_in,
  input [3:0] exe_cmd_in, dest_in, sr_in, src1_in, src2_in,
  input [11:0] shift_operand_in,
  input [23:0] signed_imm_24_in,
  input [31:0] pc_in, val_rn_in, val_rm_in,
  
  output reg wb_en, mem_r_en, mem_w_en, b, s, imm,
  output reg [3:0] exe_cmd, dest, sr, src1, src2,
  output reg [11:0] shift_operand,
  output reg [23:0] signed_imm_24,
  output reg [31:0] pc, val_rn, val_rm
  );

  always @ ( posedge clk, posedge rst ) begin
    if (rst) begin
      {wb_en, mem_r_en, mem_w_en, b, s,exe_cmd,
        pc, val_rn, val_rm,
        imm,
        shift_operand,
        signed_imm_24,
        dest, src1, src2} = 152'b0;
    end
	 else if (flush) begin
		  {wb_en, mem_r_en, mem_w_en, b, s,exe_cmd,
        pc, val_rn, val_rm,
        imm,
        shift_operand,
        signed_imm_24,
        dest, src1, src2} = 152'b0;
	 end
    else begin
    {wb_en, mem_r_en, mem_w_en, b, s,exe_cmd,
      pc, val_rn, val_rm,
      imm,
      shift_operand,
      signed_imm_24,
      dest, sr, src1, src2} = {wb_en_in, mem_r_en_in, mem_w_en_in, b_in, s_in,exe_cmd_in,
              pc_in, val_rn_in, val_rm_in,
              imm_in,
              shift_operand_in,
              signed_imm_24_in,
              dest_in, sr_in, src1_in, src2_in};
    end
  end
endmodule
