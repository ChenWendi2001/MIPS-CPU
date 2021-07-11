`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 08:20:50
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    output reg regDst,
    output reg aluSrc,
    output reg memToReg,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg Branch,
    output reg BranchNot,
    output reg [3:0] ALUOp,
    output reg Jump,
    output reg Sign,
    output reg Jal
    );
    


    always @(opCode)
    begin
        case (opCode)
        6'b000000: //R type
        begin
            regDst = 1;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b0010;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b100011: //lw
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b0011;
            Jump = 0;
            Sign = 1;
            Jal = 0;
        end

        6'b101011: //sw
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1011;
            Jump = 0;
            Sign = 1;
            Jal = 0;
        end

        6'b000100: //beq
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            Branch = 1;
            BranchNot = 0;
            ALUOp = 4'b0100;
            Jump = 0;
            Sign = 1;
            Jal = 0;
        end

        6'b000101: //bne
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            Branch = 1;
            BranchNot = 1;
            ALUOp = 4'b0100;
            Jump = 0;
            Sign = 1;
            Jal = 0;
        end

        6'b001000: //addi
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1000;
            Jump = 0;
            Sign = 1;
            Jal = 0;
        end

        6'b001001: //addiu
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1001;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b001100: //andi
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1100;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b001101: //ori
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1101;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b001110: //xori
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1110;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b001010: //slti
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1010;
            Jump = 0;
            Sign = 1;
            Jal = 0;
        end

        6'b001011: //sltiu
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b0001;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b001111: //lui
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b1111;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end

        6'b000010: //jump
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b0010;
            Jump = 1;
            Sign = 0;
            Jal = 0;
        end

        6'b000011: //jal
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b0010;
            Jump = 1;
            Sign = 0;
            Jal = 1;
        end

        default:
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            Branch = 0;
            BranchNot = 0;
            ALUOp = 4'b0000;
            Jump = 0;
            Sign = 0;
            Jal = 0;
        end
        
        endcase
    end
endmodule  
