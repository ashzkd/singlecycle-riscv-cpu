`timescale 1ns / 1ps

module dmem

    # (
    parameter XLEN = 32,
    parameter DEPTH = 1024 //1024 words = 4kB 
    )
    
    (
    input [XLEN-1:0] write_data,
    input [11:0] addr,
    output [XLEN-1:0] read_data,
    input write_en, read_en, clk
    );
    
    reg [XLEN-1:0] memory [DEPTH-1:0];
    
    always @ (posedge clk) begin
        if(write_en) begin
            memory[addr[11:2]] <= write_data;
        end
    end
    
    assign read_data = read_en ? memory[addr[11:2]] : 32'b0;
    
endmodule
