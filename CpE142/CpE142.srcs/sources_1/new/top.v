`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Sacramento State University
// Engineer: Travis Anderson
// 
// Create Date: 04/19/2020 02:50:37 PM
// Design Name: MIPs limited instruction set CPU for CPE142
// Module Name: top
// Project Name: CPE142 term project
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(clk, rst, debug_override,   
 debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, 
debug_regout1, debug_regout2, debug_datamux, debug_id_ex, debug_id_m, debug_id_wb, debug_alucontrolout);
input clk, rst;

input debug_override;
output [15:0] debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_regout1, debug_regout2, debug_datamux;
output debug_id_wb;
output [4:0] debug_id_ex;
output [2:0] debug_id_m;
output [3:0] debug_alucontrolout;
wire [15:0] instruction, signex;//instruction mem out
wire  ALUsrc, wb, zero;//control
wire [3:0] ALUop;
wire [15:0] rdata1, rdata2, aluop2;//registers out
wire [15:0] ALUResult;//ALU OUT
wire [15:0] readdata;//data mem out;
wire [15:0] pccurrent, pcnext;//pc
wire [15:0] pcadderout;//pcadderout
wire [15:0] datamemmuxout;//reg write data in
wire[15:0] aluop2muxout;
wire[3:0] alucontrolout;
wire aluoverflow;
wire [15:0] signshiftout;
wire[15:0] branchadderout;
wire branchand;
wire[15:0] dmRdata;
wire clk_div;
wire pipeline_flush;
wire flushctl;
//debug stuff


//
//assign pipeline_flush = rst | flushctl;
assign pipeline_flush = rst;


assign debug_alu_result_out = ALUResult;
assign debug_pc_out = pccurrent;
assign debug_instruction_out = if_instruction_out;
assign debug_alu_op2_out = rdata1;
assign debug_alu_op1_out = aluop2muxout;
assign debug_regout1 = rdata1;
assign debug_regout2 = rdata2;
assign debug_datamux = datamemmuxout;
assign debug_id_wb = id_wb_out;
assign debug_id_m = id_m_out;
assign debug_id_ex = id_ex_out;
assign debug_alucontrolout = alucontrolout;




always @(posedge clk)
begin
    if(debug_override)
    begin 
        //just in case I need it    
        
    end
end
//end debug stuff
//stage connections
wire[3:0] if_pc_out, id_pc_out, id_wreg_in, id_wreg_out, ex_wreg_out, mem_wreg_out, id_funcode_out;
wire[2:0] id_m_in, id_m_out, ex_m_out;
wire[15:0] if_instruction_out, id_rdata1_out, id_rdata2_out, 
id_signex_in, id_signex_out, ex_aluresult_in, ex_aluresult_out, ex_rdata2_out, mem_rdatain, mem_rdata_out, mem_aluresult_out;
wire [4:0] id_ex_in, id_ex_out;
wire id_wb_out, ex_wb_out, ex_branchadd_in, ex_branchadd_out,
 ex_zero_in, ex_zero_out, mem_wb_out;

//

clkdiv feqdiv(clk, rst, clk_div);
ProgramCounter pc(pcnext, pccurrent, clk, rst);
PCAdder pcadder(pccurrent, 16'b0000000000000100, pcadderout);
InstructionMemory im({16{'b0}}, pccurrent, instruction, 0, !rst, clk, 
0, {16{'b0}}, {16{'b0}}, rst);
//IFID
IFID s1(clk, pipeline_flush, pcadderout, instruction, if_pc_out, if_instruction_out);
//END IFID
Control c(clk, rst, if_instruction_out[15:12], id_ex_in, wb, id_m_in);
Registers r(if_instruction_out[11:8], if_instruction_out[7:4], rdata1, rdata2, mem_wreg_out, datamemmuxout, mem_wb_out, clk, rst);
SignExtender se(clk, if_instruction_out[7:4], signex);
//IDEX
IDEX s2(clk, pipeline_flush, wb, id_m_in, id_ex_in, if_pc_out, rdata1, rdata2, signex,
 if_instruction_out[11:8], if_instruction_out[3:0], id_wb_out, id_m_out, id_ex_out, id_pc_out, id_rdata1_out, id_rdata2_out, id_signex_out, id_wreg_out, id_funcode_out);
//end IDEX
ALU alu(id_rdata1_out, aluop2muxout, alucontrolout, ALUResult, aluoverflow, zero, clk, rst);
mux16 alumux(id_rdata2_out, id_signex_out, id_ex_out[4], aluop2muxout);
ALUControl aluc(clk, id_funcode_out, id_ex_out[3:0], alucontrolout);
SignShift ss(id_signex_out, signshiftout);
BranchAdder ba(pcadderout, signshiftout, branchadderout);
//exmem
exmem s3(clk, pipeline_flush,  id_wb_out, id_m_out, branchadderout, zero, ALUResult, id_rdata2_out, id_wreg_out, ex_wb_out, ex_m_out, 
ex_branchadd_out, ex_zero_out, ex_aluresult_out, ex_rdata2_out, ex_wreg_out);
//end EXMEM
assign branchand = !(ex_m_out[0] & ex_zero_out);
mux16 bmux(pcadderout, ex_branchadd_out, branchand, pcnext);
DataMemory dm(ex_rdata2_out, ex_aluresult_out, dmRdata, ex_m_out[2], ex_m_out[1], clk,  0, {16{'b0}}, {16{'b0}});
//memwb
MEMWB s4(clk, pipeline_flush, ex_wb_out, dmRdata, ex_aluresult_out, ex_wreg_out, mem_wb_out, mem_rdata_out, mem_aluresult_out, mem_wreg_out);
//END MEMWB
mux16 datamux(mem_aluresult_out, mem_rdata_out, mem_wb_out, datamemmuxout);


endmodule
