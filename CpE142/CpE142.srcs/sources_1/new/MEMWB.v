`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 08:13:12 PM
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(clk, rst, wb, rdata, aluresult, wreg, wbout, rdataout, aluresultout, wregout);

input clk, rst, wb, rdata, wreg;
input [15:0] aluresult;
output wbout, wregout;
output[15:0] aluresultout, rdataout;



reg wbhold,  zerohold;
reg[15:0] aluresulthold, rdatahold, wreghold;
reg [15:0] branchaddhold;

reg wbouttemp;
reg[15:0] aluresultouttemp, rdataouttemp;
reg [15:0] branchaddouttemp;
reg[3:0] wregouttemp;
assign wbout = wbouttemp;
assign aluresultout = aluresultouttemp;

always @(posedge clk)
begin
    if(!rst)
    begin
        wbouttemp = wbhold;
        wregouttemp = wreghold;
        aluresultouttemp = aluresulthold;
        branchaddouttemp = branchaddhold;
        
        wbhold = wb;       
        wreghold = wreg;
        aluresulthold = aluresult;

    end
    else
    begin
         wbouttemp = {1{1'b0}};
         wregouttemp = {4{1'b0}};
         aluresultouttemp = {16{1'b0}};
         branchaddouttemp = {16{1'b0}};
         
         wbhold = {1{1'b0}};
        
         zerohold = {1{1'b0}};
         wreghold = {4{1'b0}};
         aluresulthold = {16{1'b0}};
         branchaddhold = {16{1'b0}};
    
    end

end





endmodule
