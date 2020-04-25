`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 12:42:08 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(next, current, clk, rst);
input [15:0] next;
output [15:0] current;
input clk, rst;
reg[15:0] tempcurrent;
assign current = tempcurrent;

always@(posedge clk or posedge rst)
begin
    if(!rst)
    begin
        tempcurrent <= next;
    end
    else 
    begin
        tempcurrent = {16{1'b0}};
    end
end



endmodule
