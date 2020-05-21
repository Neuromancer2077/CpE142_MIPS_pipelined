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


module top(clk, rst,   
 debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, 
debug_regout1, debug_regout2, debug_datamux, debug_alucontrolout, debug_mem_wb_out, debug_mem_wreg_out,
debug_branchand, debug_ex_branchadd_out, debug_signshiftout
);
input clk, rst;

output [15:0] debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_regout1, 
debug_regout2, debug_datamux, debug_ex_branchadd_out, debug_signshiftout;
output debug_mem_wb_out, debug_branchand;
output [3:0] debug_mem_wreg_out;
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
wire clken_div;
wire pipeline_flush;
wire flushctl;
wire clken;
wire clkcontrol;
//debug stuff


//
//assign pipeline_flush = rst | flushctl;
assign pipeline_flush = rst;


assign debug_alu_result_out = ALUResult;
assign debug_pc_out = pccurrent;
assign debug_instruction_out = if_instruction_out;
assign debug_alu_op2_out = id_rdata1_out;
assign debug_alu_op1_out = aluop2muxout;
assign debug_regout1 = rdata1;
assign debug_regout2 = rdata2;
assign debug_datamux = datamemmuxout;
assign debug_mem_wb_out = mem_wb_out;
assign debug_alucontrolout = alucontrolout;
assign debug_mem_wreg_out = mem_wreg_out;
assign debug_ex_branchadd_out = ex_branchadd_out;
assign debug_branchand =  branchand;
 
assign debug_signshiftout = signshiftout;



//end debug stuff
//stage connections
wire[3:0] id_wreg_in, id_wreg_out, ex_wreg_out, mem_wreg_out, id_funcode_out;
wire[2:0] id_m_in, id_m_out, ex_m_out;
wire[15:0] if_instruction_out, id_rdata1_out, id_rdata2_out, 
id_signex_in, id_signex_out, ex_aluresult_in, ex_aluresult_out, ex_rdata2_out, mem_rdatain, mem_rdata_out, mem_aluresult_out, if_pc_out, id_pc_out, ex_branchadd_out;
wire [4:0] id_ex_in, id_ex_out;
wire id_wb_out, ex_wb_out, ex_branchadd_in, 
 ex_zero_in, ex_zero_out, mem_wb_out;
wire[4:0] rreg2;
wire[12:0] signexin;

assign clken = (clkcontrol) ? 0 : clk;
assign rreg2  = ((if_instruction_out[15:12] ^ {4'b0100}) == 0) ? 4'b0000 : ((if_instruction_out[15:12] ^ {4'b0101}) == 0) ? 4'b0000 : ((if_instruction_out[15:12] ^ {4'b0110}) == 0) ? 4'b0000 :if_instruction_out[7:4];//if_instruction_out[7:4]

assign signexin  = 
((if_instruction_out[15:12] ^ {4'b1000}) == 0) ? {{12{1'bz}}, {if_instruction_out[3:0]}} :     //type b
((if_instruction_out[15:12] ^ {4'b1011}) == 0) ? {{12{1'bz}}, {if_instruction_out[3:0]}} :      //type b
((if_instruction_out[15:12] ^ {4'b0100}) == 0) ? {{8{1'bz}}, {if_instruction_out[7:0]}} :      //type c
((if_instruction_out[15:12] ^ {4'b0101}) == 0) ? {{8{1'bz}}, {if_instruction_out[7:0]}} :      //type c
((if_instruction_out[15:12] ^ {4'b0110}) == 0) ? {{8{1'bz}}, {if_instruction_out[7:0]}} :      //type c
((if_instruction_out[15:12] ^ {4'b1100}) == 0) ? if_instruction_out[11:0] :      //type d
((if_instruction_out[15:12] ^ {4'b1111}) == 0) ? if_instruction_out[11:0] :{{12{1'bz}}, {if_instruction_out[7:4]}};//if_instruction_out[7:4]


//clkendiv feqdiv(clken, rst, clken_div);
ProgramCounter pc(pcnext, pccurrent, clken, rst);
PCAdder pcadder(pccurrent, 16'b0000000000000010, pcadderout);
InstructionMemory im({16{'b0}}, pccurrent, instruction, 0, !rst, clken, 
0, {16{'b0}}, {16{'b0}}, rst);
//IFID
IFID s1(clken, pipeline_flush, pcadderout, instruction, if_pc_out, if_instruction_out);
//END IFID
Control c(clken, rst, if_instruction_out[15:12], if_instruction_out[3:0], id_ex_in, wb, id_m_in, clkcontrol);
Registers r(if_instruction_out[11:8], rreg2, rdata1, rdata2, mem_wreg_out, datamemmuxout, mem_wb_out, clken, rst);
SignExtender se(clken, signexin, signex);
//IDEX
IDEX s2(clken, pipeline_flush, wb, id_m_in, id_ex_in, if_pc_out, rdata1, rdata2, signex,
 if_instruction_out[11:8], if_instruction_out[3:0], id_wb_out, id_m_out, id_ex_out, id_pc_out, id_rdata1_out, id_rdata2_out, id_signex_out, id_wreg_out, id_funcode_out);
//end IDEX
ALU alu(id_rdata1_out, aluop2muxout, alucontrolout, ALUResult, aluoverflow, zero, clken, rst);
mux16 alumux(id_rdata2_out, id_signex_out, id_ex_out[4], aluop2muxout);
ALUControl aluc(clken, id_funcode_out, id_ex_out[3:0], alucontrolout);
SignShift ss(id_signex_out, signshiftout);
BranchAdder ba(id_pc_out, signshiftout, branchadderout);
//exmem
exmem s3(clken, pipeline_flush,  id_wb_out, id_m_out, branchadderout, zero, ALUResult, id_rdata2_out, id_wreg_out, ex_wb_out, ex_m_out, 
ex_branchadd_out, ex_zero_out, ex_aluresult_out, ex_rdata2_out, ex_wreg_out);
//end EXMEM
assign branchand = !(ex_m_out[0] & ex_zero_out);
mux16 bmux(pcadderout, ex_branchadd_out, branchand, pcnext);
DataMemory dm(ex_rdata2_out, ex_aluresult_out, dmRdata, ex_m_out[2], ex_m_out[1], clken,  0, {16{'b0}}, {16{'b0}});
//memwb
MEMWB s4(clken, pipeline_flush, ex_wb_out, dmRdata, ex_aluresult_out, ex_wreg_out, mem_wb_out, mem_rdata_out, mem_aluresult_out, mem_wreg_out);
//END MEMWB
mux16 datamux(mem_aluresult_out, mem_rdata_out, mem_wb_out, datamemmuxout);


endmodule
