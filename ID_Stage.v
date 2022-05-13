
module  ID_Stage (
  input clk, rst, wb_wb_en, hazard,
  input[3:0] dest_wb, sr,
  input[31:0] instruction, result_wb,
  output wb_en, mem_r_en, mem_w_en, b, s, imm, two_src,
  output[3:0] exe_cmd, dest, first_src, second_src,
  output[11:0] shift_operand,
  output[23:0] signed_imm_24,
  output[31:0] val_rn, val_rm
  );
  wire [3:0] op_code, rn, rd, cond, rm, mux_reg_out;
  wire [1:0] mode;
  wire s_in, cond_haz_out, cond_out;
  wire [8:0] ctrl_out, mux_ctrl_out;

  assign mode = instruction[27:26];
  assign imm = instruction[25];
  assign s_in = instruction[20];
  assign op_code = instruction[24:21];
  assign cond = instruction[31:28];
  assign rn = instruction[19:16];
  assign rm = instruction[3:0];
  assign rd = instruction[15:12];


  assign dest = rd;
  assign signed_imm_24 = instruction[23:0];
  assign shift_operand = instruction[11:0];


  RegisterFile # (.WIDTH(32)) registerfile (
    .clk(clk), 
    .rst(rst),
    .src1(rn), 
    .src2(mux_reg_out), 
    .Dest_wb(dest_wb),
    .Result_WB(result_wb),
    .writeBackEn(wb_wb_en),
    .reg1(val_rn), 
    .reg2(val_rm)
    );


  MUX2to1 # (.WIDTH(4)) mux_rm_rd
    (.first(rm), .second(rd), .sel(mem_w_en), .out(mux_reg_out));

  MUX2to1 # (.WIDTH(9)) mux_ctrl
    (.first(ctrl_out), .second(9'b0), .sel(cond_haz_out), .out(mux_ctrl_out));

  // Condition Check
  ConditionCheck cond_check (
    .cond(cond), .sr(sr), .out(cond_out)
    );

  assign cond_haz_out = ~cond_out | hazard;

  assign two_src = ~imm | mem_w_en;
  assign first_src = rn;
  assign  second_src = mux_reg_out;

  ControlUnit ctrl_unit (
    .opcode(op_code),
    .mode(mode),
    .s(s_in),
    .status_we(ctrl_out[0]),
    .B(ctrl_out[1]), 
    .Execute_command(ctrl_out[5:2]), 
    .mem_write(ctrl_out[6]),
    .mem_read(ctrl_out[7]), 
    .WB_enable(ctrl_out[8])
    );

    assign s = mux_ctrl_out[0];
    assign b = mux_ctrl_out[1];
    assign exe_cmd = mux_ctrl_out[5:2];
    assign mem_w_en = mux_ctrl_out[6];
    assign mem_r_en = mux_ctrl_out[7];
    assign wb_en = mux_ctrl_out[8];

endmodule
