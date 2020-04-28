`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 06:04:51 PM
// Design Name: 
// Module Name: Control
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


module Control(clk, rst, instruction, ex, wb, m);
input [3:0] instruction;
input clk, rst;
output [4:0] ex;
output [2:0] m;
output wb;
reg[4:0] exTemp;
reg[2:0] mTemp;
reg  wbTemp;

assign m = mTemp;

assign ex = exTemp;
assign wb = wbTemp;

always @(instruction)
begin
    if(!rst) begin
    case(instruction)
        4'b0000:
                begin
                    mTemp[0] = 0;
                    mTemp[1] = 0;
                    mTemp[2] = 0;
                   exTemp[3:0] <= instruction;                  
                   exTemp[4] <= 1;
                   wbTemp = 1;                                            
                end
        4'b1000:
                begin
                   mTemp[0] = 0;
                   mTemp[1] = 1;
                   mTemp[2] = 0;                    
                 
                   
                    exTemp[3:0] = instruction;                   
                   exTemp[4] = 0;
                   wbTemp = 1;
                end
        4'b1011:
                begin
                  mTemp[0] = 0;
                  mTemp[1] = 0;
                  mTemp[2] = 1;   
                  
                  
                 exTemp[3:0] = instruction;
                 exTemp[4] = 0;
                 wbTemp = 0;
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
        default:
                begin
                                mTemp[0] = 0;
                                 mTemp[1] = 0;
                                 mTemp[2] = 0;   
                                 
                                 
                                  exTemp[3:0] = instruction;
                                  exTemp[4] = 0;
                                 wbTemp = 0;              
                end
                    
     endcase;            
     end 
     else 
     begin
          mTemp[0] = 0;
          mTemp[1] = 0;
          mTemp[2] = 1;   
          
          
          
          
          wbTemp = 0;        
         exTemp[3:0] = 4'b0000;        
         exTemp[4] = 1;
     end           
                
                        
                

end
endmodule
