module ForwardingUnit (
  input [3:0] src1, src2, wb_dest, mem_dest,
  input wb_wb_en, mem_wb_en,
  output reg [1:0] sel_src1, sel_src2
  );

	always@(*) begin
		sel_src1 = 2'b00;
		sel_src2 = 2'b00;
    if (mem_wb_en) begin
        if (mem_dest == src1) begin
            sel_src1 = 2'b01;
        end
        
        if (mem_dest == src2) begin
            sel_src2 = 2'b01;
        end
    end
    if (wb_wb_en) begin
        if (wb_dest == src1) begin
            sel_src1 = 2'b10;
        end
        
        if (wb_dest == src2) begin
            sel_src2 = 2'b10;
        end
    end
	end

//   assign sel_src1 = (mem_wb_en && mem_dest == src1) ? 2'b01 :
//                     (wb_wb_en && wb_dest == src1) ? 2'b10 : 2'b00;


//   assign sel_src2 = (mem_wb_en && mem_dest == src2) ? 2'b01 :
//                     (wb_wb_en && wb_dest == src2) ? 2'b10 : 2'b00;



endmodule