`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 06:05:09 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(clk, instruction, ALUop, ALUsignal);
input [3:0] instruction, ALUop;
input clk;
output [3:0] ALUsignal;

reg [3:0] ALUsignalTemp;
assign ALUsignal = ALUsignalTemp;
always@(posedge clk)
begin
    case(ALUop)
      4'b0000:
                  begin
                    ALUsignalTemp = instruction;                              
                  end
          4'b1000:
                  begin
                     ALUsignalTemp = 4'b1111;
                  end
          4'b1011:
                  begin
                    
                  end
          4'b0100:
                  begin
                  
                  end
          4'b0101:
                  begin
                  end
          4'b0110:
                  begin
                  end
          4'b1100:
                  begin
                  end
          4'b1111:
                  begin
                  end
          default:ALUsignalTemp = 4'b0000;
            
      endcase;
    
end
endmodule
