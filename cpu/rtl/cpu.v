`timescale 1ns / 1ps

module cpu(
    input clk, rst
    );
    
wire RegWrite, MemWrite, MemRead, ALUSrc, Branch, Jump, Zero;
wire [1:0] MemToReg;
wire [3:0] alu_op;
wire [4:0] rs1_addr, rs2_addr, rd_addr;
wire [31:0] pc, instr, imm, pc_next, rs1_data, rs2_data, rd_data, alu_A, alu_B, alu_O,dmem_read_data ;

pc pc_x (clk,rst,pc_next,pc);
imem imem_x (pc, instr);
immgen immgen_x (instr, imm);
cu cu_x (instr[6:0], RegWrite, MemWrite, MemRead, ALUSrc, Branch, Jump,MemToReg);
regfile regfile_x (clk, rst, rs1_addr, rs2_addr, rd_addr, rd_data, RegWrite, rs1_data, rs2_data);
aluctlr aluctrl_x (instr, alu_op);
dmem dmem_x (rs2_data, alu_O[11:0],dmem_read_data, MemWrite, MemRead, clk);
alu alu_x (alu_A,alu_B,alu_op,alu_O,Zero);

assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
assign rd_addr  = instr[11:7];
assign alu_A = rs1_data; 
assign alu_B = ALUSrc ? imm : rs2_data;

assign rd_data =
    (MemToReg == 2'b00) ? alu_O :
    (MemToReg == 2'b01) ? dmem_read_data :
    (MemToReg == 2'b10) ? pc + 4 :
    0;
    
wire pc_src = Jump | (Branch & Zero);
assign pc_next = pc_src ? pc + imm : pc + 4;

endmodule
