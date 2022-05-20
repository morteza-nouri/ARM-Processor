
module EXE_Stage (
  input mem_r_en, mem_w_en, imm,
  input [1:0] sel_src1, sel_src2,
  input [3:0] exe_cmd, sr,
  input [11:0] shift_operand,
  input [23:0] signed_imm_24,
  input [31:0] pc, val_rn, val_rm, val_mem_stage, val_wb_stage,

  output [3:0] status,
  output [31:0] alu_result, br_addr, val_rm_out
  );

  wire mem_en_out;
  wire [31:0] sign_extend_imm;
  wire [31:0] alu_input_1, val2, val2Gen_rm_input;

  // //Branch Address Calculator
  assign sign_extend_imm = $signed(signed_imm_24) << 2;

  Adder #(.WIDTH(32)) br_addr_adder (.first(pc), .second(sign_extend_imm), .out(br_addr));

  assign mem_en_out = mem_r_en | mem_w_en;

  MUX4to1 #(.WIDTH(32)) mux_before_alu1(val_rn, val_mem_stage, val_wb_stage, val_rn, sel_src1, alu_input_1);
  MUX4to1 #(.WIDTH(32)) mux_before_alu2(val_rm, val_mem_stage, val_wb_stage, val_rm, sel_src2, val2Gen_rm_input);

  Val2Generator val2_generator (
    .Val_Rm(val2Gen_rm_input),
    .imm(imm),
    .Shift_operand(shift_operand),
    .is_ldr_or_str(mem_en_out),
    .Val2out(val2)
    );

    ALU alu (
      .val1(alu_input_1), 
      .val2(val2),
      .exe_cmd(exe_cmd), 
      .sr(sr),
      .alu_result(alu_result),
      .status(status)
    );

  assign val_rm_out = val2Gen_rm_input;

endmodule
