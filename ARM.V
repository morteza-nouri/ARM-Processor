
module ARM(input clk, rst, forward_en);

// --- IF Stage wires ---
wire [31:0] if_pc, if_instruction;

// --- ID Stage wires ---
wire id_wb_en, id_mem_r_en, id_mem_w_en, id_b, id_s, id_imm, id_two_src;
wire id_reg_wb_en, id_reg_mem_r_en, id_reg_mem_w_en, id_reg_s, id_reg_imm; 
wire [3:0] dest_wb, id_exe_cmd, id_dest, id_src1, id_src2, id_reg_exe_cmd, id_reg_dest, id_reg_sr, id_rn, id_reg_src1, id_reg_src2;
wire [11:0] id_shift_operand, id_reg_shift_operand;
wire [23:0] id_signed_imm_24, id_reg_signed_imm_24;
wire [31:0] id_pc, id_instruction, id_val_rn, id_val_rm, id_reg_pc, id_reg_val_rn, id_reg_val_rm;

// --- EXE Stage wires ---
wire flush, exe_reg_wb_en, exe_reg_mem_r_en,exe_reg_mem_w_en; 
wire [1:0] sel_src1, sel_src2;
wire [3:0] exe_sr, exe_reg_dest;
wire [31:0] branch_address, exe_alu_result, exe_reg_alu_result, exe_reg_val_rm, exe_val_rm, wb_value;

// --- MEM Stage wires --- 
wire mem_mem_r_en, mem_wb_en, mem_reg_wb_en, mem_reg_mem_r_en;
wire [3:0] mem_dest, mem_reg_dest;
wire [31:0] mem_alu_result, mem_mem_data, mem_data, mem_reg_alu_result, mem_reg_mem_data;


// --- WB Stage wires ---
wire wb_wb_en;

// --- Status Register
wire [3:0] status_register_out;

// --- Hazaed Detection Unit ---
wire freeze;


//----------------------------------------------------------------------------
IF_Stage if_stage(
  .clk(clk), 
  .rst(rst), 
  .freeze(freeze), 
  .branch_taken(flush),
  .branch_address(branch_address),
  .pc(if_pc), 
  .instruction(if_instruction)
);

IF_Stage_Reg  if_stage_reg(
  .clk(clk), 
  .rst(rst), 
  .freeze(freeze), 
  .flush(flush),
  .pc_in(if_pc), 
  .instruction_in(if_instruction),
  .pc(id_pc), 
  .instruction(id_instruction)
);

//----------------------------------------------------------------------------
ID_Stage id_stage(
  .clk(clk), 
  .rst(rst), 
  .wb_wb_en(wb_wb_en), 
  .freeze(freeze),
  .dest_wb(dest_wb), 
  .sr(status_register_out),
  .instruction(id_instruction), 
  .result_wb(wb_value),
  .wb_en(id_wb_en), 
  .mem_r_en(id_mem_r_en), 
  .mem_w_en(id_mem_w_en), 
  .b(id_b), 
  .s(id_s), 
  .imm(id_imm), 
  .two_src(id_two_src),
  .exe_cmd(id_exe_cmd), 
  .dest(id_dest), 
  .first_src(id_src1), 
  .second_src(id_src2),
  .shift_operand(id_shift_operand),
  .signed_imm_24(id_signed_imm_24),
  .val_rn(id_val_rn), 
  .val_rm(id_val_rm)
  );

ID_Stage_Reg id_stage_reg(
  .clk(clk), 
  .rst(rst), 
  .flush(flush),
  .wb_en_in(id_wb_en), 
  .mem_r_en_in(id_mem_r_en), 
  .mem_w_en_in(id_mem_w_en), 
  .b_in(id_b), 
  .s_in(id_s),
  .exe_cmd_in(id_exe_cmd),
  .pc_in(id_pc), 
  .val_rn_in(id_val_rn), 
  .val_rm_in(id_val_rm),
  .imm_in(id_imm),
  .shift_operand_in(id_shift_operand),
  .signed_imm_24_in(id_signed_imm_24),
  .dest_in(id_dest), 
  .sr_in(id_dest), 
  .src1_in(id_src1), 
  .src2_in(id_src2),
  .wb_en(id_reg_wb_en), 
  .mem_r_en(id_reg_mem_r_en), 
  .mem_w_en(id_reg_mem_w_en), 
  .b(flush), .s(id_reg_s),
  .exe_cmd(id_reg_exe_cmd),
  .pc(id_reg_pc), 
  .val_rn(id_reg_val_rn), 
  .val_rm(id_reg_val_rm),
  .imm(id_reg_imm),
  .shift_operand(id_reg_shift_operand),
  .signed_imm_24(id_reg_signed_imm_24),
  .dest(id_reg_dest), 
  .sr(id_reg_sr), 
  .src1(id_reg_src1), 
  .src2(id_reg_src2)
  );

//----------------------------------------------------------------------------
EXE_Stage exe_stage (
  .mem_r_en(id_reg_mem_r_en), 
  .mem_w_en(id_reg_mem_w_en),
  .imm(id_reg_imm),
  .sel_src1(sel_src1), 
  .sel_src2(sel_src2),
  .exe_cmd(id_reg_exe_cmd),
  .sr(id_reg_sr), 
  .shift_operand(id_reg_shift_operand),
  .signed_imm_24(id_reg_signed_imm_24),
  .pc(id_reg_pc), 
  .val_rn(id_reg_val_rn), 
  .val_rm(id_reg_val_rm),
	.val_wb_stage(wb_value),
  .val_mem_stage(exe_reg_alu_result),
  .status(exe_sr), 
  .alu_result(exe_alu_result), 
  .br_addr(branch_address),
  .val_rm_out(exe_val_rm)
  );

EXE_Stage_Reg  exe_stage_reg (
  .clk(clk), 
  .rst(rst),
  .wb_en_in(id_reg_wb_en), 
  .mem_r_en_in(id_reg_mem_r_en), 
  .mem_w_en_in(id_reg_mem_w_en),
  .alu_result_in(exe_alu_result), 
  .val_rm_in(exe_val_rm),
  .dest_in(id_reg_dest),
  .wb_en(exe_reg_wb_en), 
  .mem_r_en(exe_reg_mem_r_en), 
  .mem_w_en(exe_reg_mem_w_en),
  .alu_result(exe_reg_alu_result), 
  .val_rm(exe_reg_val_rm),
  .dest(exe_reg_dest)
  );

//----------------------------------------------------------------------------
MEM_Stage  mem_stage (
  .clk(clk), 
  .rst(rst),
  .wb_en_in(exe_reg_wb_en), 
  .mem_r_en_in(exe_reg_mem_r_en), 
  .mem_w_en(exe_reg_mem_w_en),
  .alu_result_in(exe_reg_alu_result), 
  .val_rm(exe_reg_val_rm),
  .dest_in(exe_reg_dest),
  .mem_r_en_out(mem_mem_r_en), 
  .wb_en_out(mem_wb_en),
  .alu_result_out(mem_alu_result), 
  .mem_data(mem_mem_data),
  .dest_out(mem_dest)
  );

MEM_Stage_Reg  mem_stage_reg(
  .clk(clk), 
  .rst(rst), 
  .WB_en_in(mem_wb_en), 
  .Mem_R_en_in(mem_mem_r_en),
  .ALU_result_in(mem_alu_result), 
  .Mem_read_value_in(mem_mem_data),
  .Dest_in(mem_dest),
  .WB_en(mem_reg_wb_en), 
  .Mem_R_en(mem_reg_mem_r_en),
  .ALU_result(mem_reg_alu_result), 
  .Mem_read_value(mem_reg_mem_data),
  .Dest(mem_reg_dest)
  );

//----------------------------------------------------------------------------
WB_Stage wb_stage(
  .ALU_result(mem_reg_alu_result), 
  .Mem_result(mem_reg_mem_data),
  .Mem_R_en(mem_reg_mem_r_en), 
  .WB_en_in(mem_reg_wb_en),
  .Dest_in(mem_reg_dest),
  .out(wb_value),
  .WB_en(wb_wb_en),
  .Dest(dest_wb)
  );

//----------------------------------------------------------------------------
StatusRegister status_register(
  .clk(clk), 
  .rst(rst), 
  .in(exe_sr), 
  .S(id_reg_s),
  .out(status_register_out)
  );

//----------------------------------------------------------------------------
HazardDetectionUnit hazard_detector(
  .src1(id_src1), 
  .src2(id_src2), 
  .Exe_Dest(id_reg_dest), 
  .Mem_Dest(exe_reg_dest),
	.two_src(id_two_src),
  .Exe_WB_En(id_reg_wb_en), 
  .Mem_WB_En(exe_reg_wb_en), 
  .hazard_Detected(freeze),
	.forward_en(forward_en)
  );

//----------------------------------------------------------------------------
ForwardingUnit forward_unit(
	.src1(id_reg_src1), 
  .src2(id_reg_src2), 
  .wb_dest(dest_wb), 
  .mem_dest(exe_reg_dest),
	.wb_wb_en(wb_wb_en), 
  .mem_wb_en(mem_wb_en), 
	.sel_src1(sel_src1), 
  .sel_src2(sel_src2)
  );


endmodule