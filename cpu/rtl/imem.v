`timescale 1ns / 1ps

//MODULE SUMMARY
//parameter XLEN is used for architecture width and IMEM_DEPTH is used to define depth of imem
//imem has IMEM_DEPTH entries each of XLEN bits resulting in a total size of 1024x32 = 4096 KB of imem

//OPTIMIZATION 
//assign instr = memory[pc_addr[11:2]]; use first 12 bits, ignoring the last 2 bits
//pc_addr[11:2] increments every 4 bytes only.


module imem
    
    # (
    parameter XLEN = 32,
    parameter IMEM_DEPTH = 1024
    )
    
    (
    input [XLEN - 1:0] pc_addr ,
    output [XLEN - 1:0] instr 
    );
    
    reg [XLEN-1:0] memory [IMEM_DEPTH - 1: 0];
    
    assign instr = memory[pc_addr >> 2];
    
    //part of TESTBENCH 
integer i;
initial begin
    for (i = 0; i < IMEM_DEPTH; i = i + 1)
        memory[i] = 0;

    memory[0]  = 32'h00500093;
    memory[1]  = 32'h00A00113;
    memory[2]  = 32'h002081B3;
    memory[3]  = 32'h40118233;
    memory[4]  = 32'h0020E2B3;
    memory[5]  = 32'h00302023;
    memory[6]  = 32'h00002303;
    memory[7]  = 32'h00330463;
    memory[8]  = 32'h06F00393;
    memory[9]  = 32'h02A00393;
end
    
endmodule

