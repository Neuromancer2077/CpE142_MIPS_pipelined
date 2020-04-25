`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2020 05:59:46 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv ( clk ,rst,out_clk );
output out_clk;
input clk ;
input rst;
reg tempout;
assign out_clk = tempout;
reg[7:0] count;
always @(posedge clk)
begin
if (rst)
begin
     tempout <= 1'b0;
     count = {7{1'b0}};
end
else
    if(count == 1)
    begin
     tempout <= ~tempout;
     count = {7{1'b0}};
    end	
    else count = count +{{6{1'b0}}, 1'b1}; 
end
endmodule
 
