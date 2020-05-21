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


module DataMemory(wdata, address, rdata, we, re, clk, debug_we, debug_datain, debug_address, rst);
input [15:0] wdata, debug_datain;
input [15:0] address, debug_address;
output [15:0] rdata;
input we, re, clk, debug_we, rst;
reg [15:0] memory[15:0];
reg[15:0] tempread;
assign rdata = tempread;

always @(posedge clk or posedge rst) 
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
         memory[0] = 16'h2BCD;
         memory[1] = 16'h0000;
         memory[2] = 16'h0000;
         memory[3] = 16'h0000;
         memory[4] = 16'h0000;
         memory[5] = 16'h0000;
         memory[6] = 16'h0000;
         memory[7] = 16'h0000;
         memory[8] = 16'h0000;
         memory[9] = 16'h0000;
         memory[10] = 16'h0000;
         memory[11] = 16'h0000;
         memory[12] = 16'h0000;
         memory[13] = 16'h0000;
         memory[14] = 16'h0000;
         memory[15] = 16'h0000;
                  
    end   
end

endmodule
