`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 03:03:02 PM
// Design Name: 
// Module Name: SignExtender
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

module SignExtender( clk, extend, extended );
input[3:0] extend;
input clk;
output[15:0] extended;

reg[15:0] extended;
wire[3:0] extend;
always @( posedge clk )
begin
    extended[15:0] <= { {12{extend[3]}}, extend[3:0] };
end

endmodule
