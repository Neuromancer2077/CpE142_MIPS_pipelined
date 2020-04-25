`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 03:56:32 PM
// Design Name: 
// Module Name: BranchAdder
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


module BranchAdder(pc, signextend, ALUResult);    
    input [15:0] pc, signextend;
    output [15:0] ALUResult;
    wire [16:0] tempresult;
    
    assign tempresult = pc + signextend;
    assign ALUResult = tempresult[15:0];

endmodule
