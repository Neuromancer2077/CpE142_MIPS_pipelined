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

input clk, rst, wb;
input [15:0] aluresult, rdata;
input [3:0] wreg;

output wbout;
output[15:0] aluresultout, rdataout;
output [3:0] wregout;


reg wbhold,  zerohold;
reg[15:0] aluresulthold, rdatahold;
reg [15:0] branchaddhold;
reg [3:0] wreghold;

reg wbouttemp;
reg[15:0] aluresultouttemp, rdataouttemp;

reg[3:0] wregouttemp;

assign wbout = wbouttemp;
assign aluresultout = aluresultouttemp;
assign wregout = wregouttemp;
assign rdataout = rdataouttemp;

always @(posedge clk)
begin
    if(!rst)
    begin
        wbouttemp = wbhold;
       // wbouttemp = wb;
        wregouttemp = wreghold;
        aluresultouttemp = aluresulthold;
        rdataouttemp = rdatahold;
        
        
        wbhold = wb;       
        wreghold = wreg;
        aluresulthold = aluresult;
        rdatahold = rdata;

    end
    else
    begin
         wbouttemp = {1{1'b0}};
         wregouttemp = {4{1'b0}};
         aluresultouttemp = {16{1'b0}};
         rdataouttemp = {16{1'b0}};
         
         wbhold = {1{1'b0}};        
         zerohold = {1{1'b0}};
         wreghold = {4{1'b0}};
         aluresulthold = {16{1'b0}};
        rdatahold = {16{1'b0}};
    end

end





endmodule
