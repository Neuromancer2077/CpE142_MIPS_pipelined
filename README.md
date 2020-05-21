Introduction: 

This project is to implement a MIPS instruction set processor. MIPS which stands for (Microprocessor without Interlocked Pipelined Stages) is a reduced instruction set architecture. 
MIPS is assembly language which is the lowest level programming language before machine code. Machine code actually tells the hardware of a computer what operations to do. 
In normal MIPS instruction or machine code length is 32 bits. For this project our instruction length will be 16 bits. This reduction in length changes our instruction formats to:
 
![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/1.png)


Design:

For my design I turned to our class book for guidance. I started by building the components for a non-pipelined processor as seen below.
 
 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/2.png)
 
Image Source: (Patterson et al., 2019)
Once I had all of these components connected and working with a single operation I saw the need for a pipeline. Some of the issues I saw with a non-pipelined processor were propagation issues. 
For example with the add instruction (“010f” below) from the point the instruction was read off memory and fed into the registers and control unit it took 2 clock cycles for the registers to output the content of the registers and 3 clock cycles for the ALU to have the result.

![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/3.png) 

 These propagation delays cause inefficiencies in how our professor works. We can eliminate these inefficiencies by adding registers between the stages of our processor. The resulting design below: 

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/4.png)
                   Image Source: (Patterson et al., 2019)
				   
 This design allows us to fill in those propagation delays with operations. To facilitate this each state needs to have all of the information of it’s current operation. The above image is a 32 bit instruction length MIPS processor so there are some differences in the bit lengths of this project’s design vs the design in the book but the fundamentals are the same. 
In order to run my simulation I have my instruction memory, registers and data memory preload during the reset active state in accordance with the project instructions.




Instruction Memory: 
 
![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/5.png)

Registers:

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/6.png)
 
Others are zero

Data Memory:

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/7.png)

Considerations:

For the components between the pipeline registers I had to add signals they depend on as event drivers in order to get all of the operations between blocks to sync properly with the pipeline. 
For example the Instruction memory event block has the drivers:

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/8.png)
 
But the IFID register is driven only by the positive edge clock. 

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/9.png)
 
So this allows the Instruction Memory to seek the next data between positive edge clock cycles so that the data is ready for the IFID register when it is time to read in the next operation. 
Another thing I had to consider is when different instruction types cause different lengths of the instruction to be used by the sign extension so for type B, C and D they all have different bit lengths to be fed into the sign extender, 
I accomplished this on my top module with a ternary operator which translates roughly into a multiplexer in hardware design.

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/10.png)
 
Another thing I had to consider was how to implement the halt instruction, what I decided on as a internal clock selector that allows the control unit to disable the clock brining the system to a halt. This can instruction can be reset with the reset signal. If I was able to implement a co-processor for exception handling I would probably implement some kind of exception code that would send the program counter to the next executable program and reset the control module to flush the pipeline then to re-enable the clock. 







Testing:

I went through many rounds of testing, in a way I was following a SCRUM development framework by first designing a proof of concept non pipelined processor, then adding the pipelining. My first few tests after adding the pipelining was checking the function I already knew was working only to discover the timing was off and having to change the signal event drivers for different components. After that I went function by function of the processor to test if they were working and fixing them if they were not. By developing my processor this way (focusing on the operations it needed to perform) I was able to catch other issues that may have not been apparent while looking at the block diagram. 







 
My final Test bench:

 ![blockdiagram_cpu](https://github.com/TheProgrammingWizzard/CpE142_MIPS_pipelined/blob/master/imgs/12.png)
 
Debug signals 

Debug_pc_out --- the output of the program counter
Debug_alu_result_out – the output of the ALU
Debug_instruction_out – the output of the instruction after the IF/ID register
Debug_alu_op2_out – this is the input op2 of the ALU
Debug_alu_op1_out – this is the input op2 of the ALU
Debug_regout1 – this is the output of reg1 from the register file
Debug_regout2 – this is the output of reg2 from the register file
Debug_datamux –this is the output of the multiplexer after the MEM/WB register
Debug_ex_branchadd_out – this is the output of the branch adder
Debug_signshiftout – this is the output of the sign shift that is the input to the branch adder 
Mem_wb_out_wb – this is the output of WB at the MEM/WB register
Debug_branchand – this is the output of the branch and circuit or weather or no the branch is taken (Active low)
Debug_alucontrolout –this is the output of the ALU Control that controls the operation of the ALU
Mem_wreg_out – this is the write back register output from MEM/WB

Bibliography
D. A. Patterson and J. L. Hennessy, “Chapter 4,” in Computer organization and design: the hardware/software interface, Brantford, Ontario: W. Ross MacDonald School Resource Services Library, 2019.

