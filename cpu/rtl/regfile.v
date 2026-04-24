`timescale 1ns / 1ps

//READ SIDE MUST BE FULLY COMBINATIONAL
//two 5 bit source register addesses are provided and two 32 bit data values are combinationally returned from the register file. 
//on read side , if trying to read x0 address, return 0 itself.

//WRITE SIDE MUST BE EDGE TRIGGERED
//on clock edge if rst is initiated, all registers are reset to 0.
//rd_data is transfered to rd_addr only if write_en is high and rd_addr is not x0 address.

module regfile

    # (
    parameter XLEN = 32,
    parameter REGFILE_DEPTH = 32
    )
    (
    input clk, rst,
    input [4:0] rs1_addr, rs2_addr, rd_addr,
    input [XLEN-1:0] rd_data,
    input write_en,
    output [XLEN-1:0] rs1_data,rs2_data
    );
    
    reg [XLEN-1:0] registers [REGFILE_DEPTH-1: 0];
    integer i;
    
    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end
        else if (write_en && rd_addr != 0) begin
            registers[rd_addr] <= rd_data;
        end
    end
    
    assign rs1_data = (rs1_addr == 0) ? 32'b0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == 0) ? 32'b0 : registers[rs2_addr];  
    
endmodule
