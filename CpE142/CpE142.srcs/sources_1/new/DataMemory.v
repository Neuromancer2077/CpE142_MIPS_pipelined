`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 12:14:59 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(wdata, address, rdata, we, re, clk, debug_we, debug_datain, debug_address);
input [15:0] wdata, debug_datain;
input [15:0] address, debug_address;
output [15:0] rdata;
input we, re, clk, debug_we;
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
   
end

endmodule
