`timescale 1ns / 1ps

module aluctlr(
    input [31:0] instr,
    output reg [3:0] alu_op
    );
    
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    
    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];
    
    always @ (*) begin
        
        case(opcode)
            7'b0110011 : //R type
                case(funct3) 
                    3'b000 : alu_op = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; //ADD SUB
                    3'b100 : alu_op = 4'b0111; //XOR
                    3'b110 : alu_op = 4'b0010; //OR
                    3'b111 : alu_op = 4'b0011; //AND
                    3'b001 : alu_op = 4'b0101; //SLL
                    3'b101 : alu_op = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0110; //SRA SRL
                    3'b010 : alu_op = 4'b1000; //SLT
                    3'b011 : alu_op = 4'b1001; //SLTU
                    default : alu_op = 4'b0000;
                endcase
                
            7'b0000011 : //I type
                case(funct3)
                    3'b010 : alu_op = 4'b0000; //lw
                endcase
            
            7'b0010011 : 
                case(funct3)
                    3'b000 : alu_op = 4'b0000; //ADDI
                    3'b100 : alu_op = 4'b0111; //XORI
                    3'b110 : alu_op = 4'b0010; //ORI
                    3'b111 : alu_op = 4'b0011; //ANDI
                    3'b001 : alu_op = 4'b0101; //SLL
                    3'b101 : alu_op = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0110; //SRAI SRLI
                    3'b010 : alu_op = 4'b1000; //SLT
                    3'b011 : alu_op = 4'b1001; //SLTU
                    default : alu_op = 4'b0000;
                endcase
            
            7'b0100011 : //S type
                case(funct3)
                    3'b010 : alu_op = 4'b0000; //sw
                endcase
            
            7'b1100011 : //B type
                case(funct3)
                    3'b000 : alu_op = 4'b0001; //beq
                endcase
            
            7'b1101111 : alu_op = 4'b0000; //J type jal
            
        endcase
    end
    
endmodule


