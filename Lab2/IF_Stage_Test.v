module IF_Stage_Test();
    
    reg clk = 1'b0, rst = 1'b0, freeze = 1'b0, Branch_taken = 1'b0, flush = 1'b0 ;
    reg [31:0] BranchAddr = 32'b0;
    wire [31:0] IF_PC, IF_Instruction, IF_Reg_PC, IF_Reg_Instruction;
    wire [31:0] ID_PC, ID_Reg_PC, EXE_PC, EXE_Reg_PC, MEM_PC, MEM_Reg_PC, WB_PC, WB_Reg_PC;
    wire hazard = 1'b0 , freeze_MEM = 1'b0;

    IF_Stage if_stage (.clk(clk), .rst(rst), .freeze(freeze | freeze_MEM), .Branch_taken(Branch_taken),
	.BranchAddr(BranchAddr), .PC(IF_PC), .Instruction(IF_Instruction));

    IF_Stage_Reg if_state_reg (.clk(clk), .rst(rst), .freeze(freeze | freeze_MEM), .flush(flush), 
	.PC_in(IF_PC), .Instruction_in(IF_Instruction), .PC(IF_Reg_PC), .Instruction(IF_Reg_Instruction));

    wire [3:0] actual_status_register_out;
    wire mem_read_ID, mem_read_ID_Reg;
    wire mem_write_ID, mem_write_ID_Reg;
    wire wb_enable_ID, wb_enable_ID_Reg;
    wire [3:0] execute_command_ID, execute_command_ID_Reg;
    wire branch_taken_ID; 
    wire status_write_enable_ID, status_write_enable_ID_Reg;
    wire [31:0] reg_file_1_ID, reg_file_1_ID_Reg;
    wire [31:0] reg_file_2_ID, reg_file_2_ID_Reg;
    wire immediate_ID, immediate_ID_Reg;
    wire [23:0] signed_immediate_ID, signed_immediate_ID_Reg;
    wire [11:0] shift_operand_ID, shift_operand_ID_Reg;
    wire [3:0] dest_reg_ID, dest_reg_ID_Reg;
    wire [3:0] status_register_ID_Reg, status_register_ID;
    wire two_src_ID;
    wire [3:0] src1_ID, src2_ID;
    wire [3:0] dest_reg_EXE_Reg;
    wire wb_enable_MEM_Reg;
    wire [31:0] wb_value_WB;
    wire [3:0] dest_reg_MEM_Reg;

    assign status_register_ID = actual_status_register_out;
    wire [3:0] src1_ID_Reg, src2_ID_Reg;



    ID_Stage id_stage(.clk(clk), .rst(rst), .PC_in(IF_Reg_PC), .PC(ID_PC) , .hazard(hazard), .instruction_in(IF_Reg_Instruction),
	.status_register_in(actual_status_register_out),.wb_dest(dest_reg_MEM_Reg),.wb_value(wb_value_WB),
	.WB_EN(wb_enable_MEM_Reg),.mem_read_out(mem_read_ID), .mem_write_out(mem_write_ID), 
	.wb_enable_out(wb_enable_ID),.execute_command_out(execute_command_ID),.branch_taken_out(branch_taken_ID),
	.status_write_enable_out(status_write_enable_ID),.reg_file_out1(reg_file_1_ID), .reg_file_out2(reg_file_2_ID), 
	.two_src(two_src_ID),.src1_out(src1_ID),.src2_out(src2_ID),.immediate_out(immediate_ID),
	.signed_immediate(signed_immediate_ID), .shift_operand(shift_operand_ID),.dest_reg_out(dest_reg_ID) );

    ID_Stage_Reg id_stage_reg (.clk(clk), .rst(rst), .pc_in(ID_PC), .pc_out(ID_Reg_PC) , .flush(flush),
	.mem_read_in(mem_read_ID),.mem_write_in(mem_write_ID), .wb_enable_in(wb_enable_ID),
	.branch_taken_in(branch_taken_ID), .status_write_enable_in(status_write_enable_ID), 
	.execute_command_in(execute_command_ID), .val_rn_in(reg_file_1_ID), .val_rm_in(reg_file_2_ID),
	.immediate_in(immediate_ID), .signed_immediate_in(signed_immediate_ID),.shift_operand_in(shift_operand_ID), 
	.dest_reg_in(dest_reg_ID),.status_register_in(status_register_ID),.mem_read_out(mem_read_ID_Reg),
	.mem_write_out(mem_write_ID_Reg), .wb_enable_out(wb_enable_ID_Reg),.branch_taken_out(branch_taken_ID_Reg), 
	.status_write_enable_out(status_write_enable_ID_Reg), .execute_command_out(execute_command_ID_Reg), 
	.val_rn_out(reg_file_1_ID_Reg), .val_rm_out(reg_file_2_ID_Reg),.immediate_out(immediate_ID_Reg), 
	.signed_immediate_out(signed_immediate_ID_Reg),.shift_operand_out(shift_operand_ID_Reg), 
	.dest_reg_out(dest_reg_ID_Reg),.status_register_out(status_register_ID_Reg),.freeze(freeze_MEM),
	.src1_in(src1_ID),.src2_in(src2_ID),.src1_out(src1_ID_Reg),.src2_out(src2_ID_Reg));

    EXE_Stage exe_stage(.clk(clk), .rst(rst), .PC_in(ID_Reg_PC), .PC(EXE_PC));
    EXE_Stage_Reg exe_stage_reg (.clk(clk), .rst(rst), .PC_in(EXE_PC), .PC(EXE_Reg_PC));

    MEM_Stage mem_stage(.clk(clk), .rst(rst), .PC_in(EXE_Reg_PC), .PC(MEM_PC));
    MEM_Stage_Reg mem_stage_reg (.clk(clk), .rst(rst), .PC_in(MEM_PC), .PC(MEM_Reg_PC));

    WB_Stage wb_stage (.clk(clk), .rst(rst), .PC_in(MEM_Reg_PC), .PC(WB_PC));
    WB_Stage_Reg wb_stage_reg (.clk(clk), .rst(rst), .PC_in(WB_PC), .PC(WB_Reg_PC));

    always #5 clk = ~clk;
    initial begin
        #15 rst = 1'b1;
        #10 rst = 1'b0;
        #2000 $stop;
    end

endmodule 