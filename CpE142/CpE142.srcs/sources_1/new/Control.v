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


module Control(clk, rst, instruction, func, ex, wb, m, clkctl);
input [3:0] instruction;
input [3:0] func;
input clk, rst, clkctl;
output [4:0] ex;
output [2:0] m;
output wb;
reg[4:0] exTemp;
reg[2:0] mTemp;
reg  wbTemp;
reg clkctltemp;
assign m = mTemp;

assign ex = exTemp;
assign wb = wbTemp;
assign clkctl = clkctltemp;

always @(instruction)
begin
    if(!rst) begin
    case(instruction)
        4'b0000:
                begin
                    if( (func == 4'b1010) || (func == 4'b1011) || (func == 4'b1000) || (func == 4'b1001))
                    begin
                         mTemp[0] = 0;
                         mTemp[1] = 0;
                         mTemp[2] = 0;
                          exTemp[3:0] <= instruction;                  
                          exTemp[4] <= 0;
                          wbTemp = 1;
                    
                    
                    end
                    else
                    begin
                        mTemp[0] = 0;
                        mTemp[1] = 0;
                        mTemp[2] = 0;
                       exTemp[3:0] <= instruction;                  
                       exTemp[4] <= 1;
                       wbTemp = 1;
                   end                                            
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
                           mTemp[0] = 1;
                            mTemp[1] = 0;
                            mTemp[2] = 0;   
                            
                            
                           exTemp[3:0] = instruction;
                           exTemp[4] = 0;
                           wbTemp = 0;           
                      end
        4'b0101:
                 begin
                           mTemp[0] = 1;
                            mTemp[1] = 0;
                            mTemp[2] = 0;   
                            
                            
                           exTemp[3:0] = instruction;
                           exTemp[4] = 0;
                           wbTemp = 0;           
                      end
        4'b0110:
                begin
                     mTemp[0] = 1;
                      mTemp[1] = 0;
                      mTemp[2] = 0;   
                      
                      
                     exTemp[3:0] = instruction;
                     exTemp[4] = 1;
                     wbTemp = 0;           
                end
        4'b1100:
                begin
                  mTemp[0] = 1;
                    mTemp[1] = 0;
                    mTemp[2] = 0;   
                    
                    
                   exTemp[3:0] = instruction;
                   exTemp[4] = 1;
                   wbTemp = 0;      
                end
        4'b1111:
                begin
                    clkctltemp = 1;
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
          clkctltemp = 0;
          
          
          
          wbTemp = 0;        
         exTemp[3:0] = 4'b0000;        
         exTemp[4] = 1;
     end           
                
                        
                

end
endmodule
