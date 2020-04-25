`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 12:40:07 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(wdata, address, rdata, we, re, clk, debug_we, debug_datain, debug_address, rst);
input [15:0] wdata, debug_datain;
input [15:0] address, debug_address;
output [15:0] rdata;
input we, re, clk, debug_we, rst;
reg [15:0] memory[15:0];
reg[15:0] tempread;
assign rdata = tempread;
always @(posedge clk) 
begin
    if(debug_we)
    begin
        memory[debug_address] = debug_datain;
    end
    else if(we)
    begin
        memory[address] = wdata;
    end
    else if(re)
    begin
        tempread <= memory[address];
    end
    if(rst)
    begin
       //memory[16'h0004] = 4'h8000;//lw 0, 0
       //memory[16'h0008] = 4'h8110;//lw 1, 1
       //memory[16'h000C] = 4'h010F;//
       memory[4] = 16'h010f;
	   memory[0] = 16'h0000;
	   memory[8] = 16'h0000;
                   
    end
    
end
endmodule
