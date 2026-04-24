`timescale 1ns / 1ps

module alu(
    input [31:0] A,B,
    input [3:0] opcode,
    output reg [31:0] result,
    output reg Z
    );
    
    always @ (*) begin
        case(opcode) 
            4'b0000 : result = A + B;
            4'b0001 : result = A - B;
            4'b0010 : result = A | B;
            4'b0011 : result = A & B;
            4'b0100 : result = A ^ B;
            4'b0101 : result = A << B[4:0];
            4'b0110 : result = A >> B[4:0];
            4'b0111 : result = $signed(A) >>> B[4:0];
            4'b1000 : result = A < B; 
            4'b1001 : result =  $signed(A) < $signed(B);
            
            default : result = 32'b0;
        endcase
      
    end
    
    assign Z = (result == 32'b0) ? 1'b1 : 1'b0;    
    
endmodule