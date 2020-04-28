`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 05:01:40 PM
// Design Name: 
// Module Name: IDEX
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


module IDEX(clk, rst, wb, m, ex, pc, rdata1, rdata2, signex, wreg, funcode, wbout, mout, exout, pcout, rdata1out, rdata2out, signexout, wregout, funcodeout);
input clk, rst;
input wb;
input [4:0] ex;
input [2:0] m;
input [15:0] pc;
input [15:0] rdata1, rdata2, signex;
input [3:0] wreg, funcode;

output wbout;
output [4:0] exout;
output [15:0] pcout;
output [15:0] rdata1out, rdata2out, signexout;
output [3:0] wregout, funcodeout;
output [2:0] mout;

reg [15:0] rdata1hold, rdata2hold, signexhold, rdata1outtemp, rdata2outtemp, signexouttemp;
reg  wbhold, wbouttemp;
reg  [3:0]  wreghold, wregouttemp, funcodetemp, funcodehold;
reg [15:0] pcouttemp;
reg [15:0] pchold;
reg [2:0] mhold, mouttemp;
reg[4:0] exhold, exouttemp;

assign wbout = wbouttemp;
assign mout = mouttemp;
assign exout = exouttemp;
assign pcout = pcouttemp;
assign rdata1out = rdata1outtemp;
assign rdata2out = rdata2outtemp;
assign signexout = signexouttemp;
assign wregout = wregouttemp;
assign funcodeout = funcodetemp;

always@(posedge clk)
begin
    if(!rst)
    begin
       wbouttemp = wbhold;
       mouttemp = mhold;
       exouttemp = exhold;
      // exouttemp = ex;
       pcouttemp = pchold;
       rdata1outtemp = rdata1hold;
       rdata2outtemp = rdata2hold;
       signexouttemp = signexhold;
       wregouttemp = wreghold;
       funcodetemp = funcodehold;
       
       wbhold = wb;
       mhold = m;
       exhold =ex;
       pchold = pc;
       rdata1hold = rdata1;
       rdata2hold = rdata2;
       signexhold = signex;
       wreghold = wreg;
       funcodehold = funcode;
    end
    else begin
           wbhold = {1{1'b0}};
           mhold = {3{1'b0}};
           exhold ={5{1'b0}};
           pchold = {16{1'b0}};
           rdata1hold = {16{1'b0}};
           rdata2hold = {16{1'b0}};
           signexhold = {16{1'b0}};
           wreghold = {4{1'b0}};
           
            wbouttemp = {1{1'b0}};
            mouttemp = {3{1'b0}};
            exouttemp = {5{1'b0}};
            pcouttemp = {16{1'b0}};
            rdata1outtemp = {16{1'b0}};
            rdata2outtemp = {16{1'b0}};
            signexouttemp = {16{1'b0}};
            wregouttemp = {4{1'b0}};
    end
end
endmodule
