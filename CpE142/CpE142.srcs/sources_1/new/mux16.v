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
reg [15:0] ytemp;
assign y = ytemp;
//assign y = (sel)?in1:in2;
always@(sel or in1 or in2)
begin
    case(sel)
        1'b1 : ytemp = in1;
        1'b0 : ytemp = in2;    
    endcase

end

endmodule
