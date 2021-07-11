`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 09:08:46
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    input [3 : 0] aluOp,
    input [5 : 0] func,
    output reg [3 : 0] aluCtr,
    output reg shamt,
    output reg jr
    );

    always @ (aluOp or func)
    begin
        casex ({aluOp, func})
            //------------------I-type-----------------------//
            10'b1000xxxxxx: 
                aluCtr = 4'b0010;// addi -> add
            10'b1100xxxxxx: 
                aluCtr = 4'b0000;// andi -> and
            10'b1101xxxxxx: 
                aluCtr = 4'b0001;// ori -> or
            10'b0011xxxxxx: 
                aluCtr = 4'b0010;// lw -> add
            10'b1011xxxxxx: 
                aluCtr = 4'b0010;// sw -> add
            10'b0100xxxxxx: 
                aluCtr = 4'b0110;// beq -> sub
            //------------------new---------------------//
            10'b1001xxxxxx: 
                aluCtr = 4'b1010;// addiu -> addu
            10'b1110xxxxxx: 
                aluCtr = 4'b1001;// xori -> xor
            10'b1010xxxxxx: 
                aluCtr = 4'b0111;// slti ->slt
            10'b0001xxxxxx: 
                aluCtr = 4'b1111;// sltiu ->sltu
            10'b1111xxxxxx:
                aluCtr = 4'b1100;// lui
            
            //------------------R-type-----------------------//
            10'b0010100000:
                aluCtr = 4'b0010;// add
            10'b0010100010:
                aluCtr = 4'b0110;// sub
            10'b0010100100:
                aluCtr = 4'b0000;// and
            10'b0010100101:
                aluCtr = 4'b0001;// or
            10'b0010101010:
                aluCtr = 4'b0111;// slt -> set on less than
            10'b0010000000:
                aluCtr = 4'b0011;// sll -> shift left
            10'b0010000010:
                aluCtr = 4'b0100;// srl -> logical shift right
            //-----------------R-new-inst---------------------//
            10'b0010100110:
                aluCtr = 4'b1001;//xor
            10'b0010100111:
                aluCtr = 4'b0101;//nor
            10'b0010100001:
                aluCtr = 4'b1010;//addu -> need overflow
            10'b0010100011:
                aluCtr = 4'b1110;//subu -> need overflow
            10'b0010101011:
                aluCtr = 4'b1111;//sltu
            10'b0010000011:
                aluCtr = 4'b1000;//sra
            10'b0010000100:
                aluCtr = 4'b0011;//sllv -> sll
            10'b0010000110:
                aluCtr = 4'b0100;//srlv -> srl
            10'b0010000111:
                aluCtr = 4'b1000;//srav -> sra
            //------------------J-type-----------------------//
            default:
                aluCtr  = 4'b0000;//jump
        endcase
        if ({aluOp, func} == 10'b0010000000||{aluOp, func} == 10'b0010000010 ||{aluOp, func} == 10'b0010000011)
            shamt = 1;
        else
            shamt = 0;
        if ({aluOp,func} == 10'b0010001000)
            jr = 1;
        else
            jr = 0;
    end
endmodule
