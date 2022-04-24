module ARM();
    
    reg clk = 1'b0, rst = 1'b0, freeze = 1'b0, Branch_taken = 1'b0, flush = 1'b0;
    reg [31:0] BranchAddr = 32'b0;
    wire [31:0] IF_PC, IF_Instruction, IF_Reg_PC, IF_Reg_Instruction;
    wire [31:0] ID_PC, ID_Reg_PC, EXE_PC, EXE_Reg_PC, MEM_PC, MEM_Reg_PC, WB_PC, WB_Reg_PC;

    IF_Stage if_stage (.clk(clk), .rst(rst), .freeze(freeze), .Branch_taken(Branch_taken), .BranchAddr(BranchAddr), .PC(IF_PC), .Instruction(IF_Instruction));
    IF_Stage_Reg if_state_reg (.clk(clk), .rst(rst), .freeze(freeze), .flush(flush), .PC_in(IF_PC), .Instruction_in(IF_Instruction), .PC(IF_Reg_PC), .Instruction(IF_Reg_Instruction));

    ID_Stage id_stage(.clk(clk), .rst(rst), .PC_in(IF_Reg_PC), .PC(ID_PC));
    ID_Stage_Reg id_stage_reg (.clk(clk), .rst(rst), .PC_in(ID_PC), .PC(ID_Reg_PC));

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
