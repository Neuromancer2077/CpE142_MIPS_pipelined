`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 12:40:07 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(wdata, address, rdata, we, re, clk, debug_we, debug_datain, debug_address, rst);
input [15:0] wdata, debug_datain;
input [15:0] address, debug_address;
output [15:0] rdata;
input we, re, clk, debug_we, rst;
reg [15:0] memory[256:0];
reg[15:0] tempread;
assign rdata = tempread;
always @(clk or address) 
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
       //memory[16'h0004] = 4'h8000;//lw 0, 0
       //memory[16'h0008] = 4'h8110;//lw 1, 1
       //memory[16'h000C] = 4'h010F;//
      
       memory[0] = 16'h012f;//add r1, r2
       memory[2] = 16'h012e;//sub r1, r2
       memory[4] = 16'h034C;//or r3, r4
       memory[6] = 16'h032d;//and r3, r2
       memory[8] = 16'h0561;//mul r5, r6
	   memory[10] = 16'h0152;//div r1, r5
	   memory[12] = 16'h000e;//sub r0, r0
	   memory[14] = 16'h043a;//sll r4, 3
	   memory[16] = 16'h042b;//slr r4, 2
       memory[18] = 16'h0639;//ror r6, 3
       memory[20] = 16'h0628;// rol r6, 2
       memory[22] = 16'h6704;//beq r7, 4 
       memory[24] = 16'h0b1f;//add r11, r1 
       memory[26] = 16'h4705;//blt r7, 5
       memory[28] = 16'h0b2f;//add r11, r2
       memory[30] = 16'h5702;//BGT r7, 2                       
       memory[32] = 16'h011f;//add r1, r1  
       memory[34] = 16'h011f;//add r1, r1 
       memory[36] = 16'h8890;//lw r8 0(r9)
       memory[38] = 16'h088f;//add r8, r8
       memory[40] = 16'hb892;//sw r8, 2(r9)
       memory[42] = 16'h8a92;//lw r10, 2(r9)
       memory[44] = 16'h0ccf;//add r12, r12
       memory[46] = 16'h0dde;//sub r13, r13
       memory[48] = 16'h0cdf;//add r12, r13
       memory[50] = 16'hF000;//eff
  
  
           
                
                
               
                  
                   
    end
    
end
endmodule
