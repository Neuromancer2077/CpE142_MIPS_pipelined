`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 12:47:49 PM
// Design Name: 
// Module Name: Registers
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


module Registers(reg1, reg2, data1, data2, wreg, wdata, we, clk, rst);
input [3:0] reg1, reg2, wreg;
input [15:0] wdata;
output [15:0] data1, data2;
input we, clk, rst;

reg [15:0] register[15:0];
reg [3:0] i;
reg[15:0] tempdata1, tempdata2;
assign data1 = tempdata1;
assign data2 = tempdata2;

always@(posedge clk)
begin
    if(rst)
    begin
        i <= 0;
        repeat(16)
        begin
         register[i] <= {{12{1'b0}}, (i+1)};
         i = i + 4'b0001;
       end    
    end
    if(!we)
    begin
        tempdata1 = register[reg2];
        tempdata2 = register[reg1];    
    
    end
    else 
    begin
        register[wreg] = wdata;    
    end

end;



endmodule
