`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 04:40:32 PM
// Design Name: 
// Module Name: IFID
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


module IFID(clk, rst, pc, instruction, pcout, instructionout);
input clk, rst;
input[15:0] pc;
input [15:0] instruction;
output [15:0] pcout;
output [15:0] instructionout;
reg[15:0] instructionhold;
reg[15:0] pchold;
reg[15:0] instructionoutTemp;
reg[15:0] pcoutTemp;

assign instructionout = instructionoutTemp;
assign pcout = pcoutTemp;

always@(posedge clk)
begin
    if(!rst)
    begin
        instructionoutTemp <= instructionhold;
        pcoutTemp <= pchold;
        pchold <= pc;
        instructionhold <= instruction; 
    end
    else 
    begin
        pchold = {16{1'b0}};
        instructionhold = {16{1'b0}};
        instructionoutTemp = {16{1'b0}};
        pcoutTemp = {16{1'b0}};
    
    end

end
endmodule
