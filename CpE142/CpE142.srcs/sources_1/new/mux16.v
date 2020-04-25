`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 05:29:00 PM
// Design Name: 
// Module Name: mux16
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


module mux16(in1, in2, sel, y);
input [15:0] in1, in2;
input sel;
output [15:0] y;
assign y = (sel)?in1:in2;
endmodule
