`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 06:02:55 PM
// Design Name: 
// Module Name: exmem
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


module exmem(clk, rst, wb, m, branchadd, zero, aluresult, rdata2, wreg, wbout, mout, branchaddout, zeroout, aluresultout, rdata2out, wregout);

input clk, rst, wb, zero;
input [2:0] m;
input [15:0] aluresult;
input [15:0] branchadd, rdata2;
input [3:0] wreg;

output wbout, mout, zeroout;
output[15:0] aluresultout, rdata2out;
output [15:0] branchaddout, wregout;

reg wbhold, zerohold;
reg [15:0] aluresulthold, rdata2hold;
reg [15:0] branchaddhold;
reg [2:0] mhold;
reg [3:0] wreghold;

reg wbouttemp, zeroouttemp;
reg [15:0] aluresultouttemp, rdata2outtemp;
reg [15:0] branchaddouttemp;
reg[2:0] mouttemp;
reg[3:0]wregouttemp;

assign wbout = wbouttemp;
assign mout = mouttemp;
assign zeroout = zeroouttemp;
assign rdata2out = rdata2outtemp;
assign aluresultout = aluresultouttemp;
assign branchaddout = branchaddouttemp;
assign wregout = wregouttemp;

always @(posedge clk)
begin
    if(!rst)
    begin
        wbouttemp = wbhold;
        mouttemp = mhold;
        zeroouttemp = zerohold;
        wregouttemp = wreghold;
        aluresultouttemp = aluresulthold;
        branchaddouttemp = branchaddhold;
        
        wbhold = wb;
        mhold = m;
        zerohold = zero;
        wreghold = wreg;
        aluresulthold = aluresult;
        branchaddhold = branchadd;
    end
    else
    begin
         wbouttemp = {1{1'b0}};
         mouttemp = {3{1'b0}};
         zeroouttemp = {1{1'b0}};
         wregouttemp = {4{1'b0}};
         aluresultouttemp = {16{1'b0}};
         branchaddouttemp = {16{1'b0}};
         
         wbhold = {1{1'b0}};
         mhold = {3{1'b0}};
         zerohold = {1{1'b0}};
         wreghold = {4{1'b0}};
         aluresulthold = {16{1'b0}};
         branchaddhold = {16{1'b0}};
    
    end

end
endmodule
