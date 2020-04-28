`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2020 03:29:13 PM
// Design Name: 
// Module Name: top_tb
// Project Name: 
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


module top_tb();
reg clk, rst, debug_override;

wire [15:0] debug_pc_out, debug_alu_result_out,  debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out, debug_regout1, debug_regout2, debug_datamux;

wire mem_wb_out_wb;
wire [3:0] debug_alucontrolout, mem_wreg_out;
initial 
begin
clk = 0;
repeat(5000) #50 clk = !clk;
end
top uut(clk, rst, debug_override,
debug_alu_result_out, debug_pc_out, debug_instruction_out, debug_alu_op2_out, debug_alu_op1_out,  
debug_regout1, debug_regout2, debug_datamux, debug_alucontrolout, mem_wb_out_wb, mem_wreg_out);

initial
begin
   rst = 1;
   debug_override = 0;

 #400;
 /*
 debug_instruction_we = 1;
 debug_data_we = 1;
 debug_instruction_address = {{13{1'b0}}, {3'b100}};
 debug_instruction_data_in = 16'b1000000000000000;
 debug_data_address = {16{1'b0}};
 debug_data_wdata = {{15{1'b0}}, {1'b1}};
 #20;
  debug_instruction_we = 1;
  debug_data_we = 1;
  debug_instruction_address = {{12{1'b0}}, {4'b1000}};
  debug_instruction_data_in = 16'b1000000100010000;
  debug_data_address = {{15{1'b0}}, {1'b1}};
  debug_data_wdata = {{14{1'b0}}, {2'b10}};
  #20;
  debug_data_we = 0;
  debug_instruction_address = {{10{1'b0}}, {6'b001100}};
  
  debug_instruction_data_in = 16'b0000000100001111;

  #20;
  debug_instruction_we = 0;
  debug_instruction_address = {16{1'b0}};
  debug_instruction_data_in = {16{1'b0}};
  debug_data_address = {16{1'b0}};
  debug_data_wdata = {16{1'b0}};
  #20;
  */
  rst = 0;
  #400;
end

endmodule
