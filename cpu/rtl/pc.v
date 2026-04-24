`timescale 1ns / 1ps

module pc

    # (
    parameter XLEN = 32
    )
    
    (
    input clk, rst,
    input [XLEN-1:0] pc_next_addr,
    output reg [XLEN-1:0] pc_addr
    );
    
    always@(posedge clk) begin
    
        if(rst) pc_addr <= 32'b0;
        else begin
        pc_addr <= pc_next_addr;
        end
    end
endmodule

//andi ori xori slt slti sll srl sra jalr lui
