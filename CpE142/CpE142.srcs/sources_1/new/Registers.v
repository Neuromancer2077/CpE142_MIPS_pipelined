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

always@(clk or reg1 or reg2)
begin
    if(rst)
    begin
    
        i <= 0;
        repeat(16)
        begin
         register[i] <= {{12{1'b0}}, (i+1)};
         i = i + 4'b0001;
       end 
    register[1] = 16'h0f00; 
    register[2] = 16'h0050;
    register[3] = 16'hff0f;
    register[4] = 16'hf0ff;
    register[5] = 16'h0040;
    register[6] = 16'h0024;
    register[7] = 16'h00ff;
    register[8] = 16'haaaa;
    register[12] = 16'hFFFF;
    register[13] = 16'h0002;
       
    end
    tempdata1 = register[reg2];
    tempdata2 = register[reg1];    
    
    
    if(we)
    begin
        register[wreg] = wdata;    
    end

end;



endmodule
