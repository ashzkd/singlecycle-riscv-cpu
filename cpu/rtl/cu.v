`timescale 1ns / 1ps

module cu(
    input [6:0] opcode,
    output reg RegWrite, MemWrite, MemRead, ALUSrc, Branch, Jump,
    output reg [1:0] MemToReg
    );
    
    always @ (*) begin
    
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    MemToReg = 0;
    ALUSrc   = 0;
    Branch   = 0;
    Jump     = 0;
    
        case(opcode) 
            7'b0110011 : begin //R type
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALUSrc = 0;
                Branch = 0;
                Jump = 0;
                end
           
           7'b0010011 :  begin // I type arithemetic 
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALUSrc = 1;
                Branch = 0;
                Jump = 0;
                end   
            
           7'b0000011 :  begin // I type load
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                MemToReg = 1;
                ALUSrc = 1;
                Branch = 0;
                Jump = 0;
                end
                
            7'b0100011 : begin // S type    
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                MemToReg = 0;
                ALUSrc = 1;
                Branch = 0;
                Jump = 0;
                end
                
            7'b1100011 : begin // B type    
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALUSrc = 0;
                Branch = 1;
                Jump = 0;
                end
                
            7'b1101111 : begin // J type    
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 2'b10;
                ALUSrc = 0;
                Branch = 0;
                Jump = 1;
                end   
                
           default :  begin
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemToReg = 0;
                ALUSrc = 0;
                Branch = 0;
                Jump = 0;
                end
           endcase    
    
    end
    
endmodule
