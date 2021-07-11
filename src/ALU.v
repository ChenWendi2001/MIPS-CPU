`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 09:07:03
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero,
    output reg [31:0] aluRes,
    output reg overflow
    );

    reg [31:0] temp;

    always @(input1 or input2 or aluCtr) 
    begin
        overflow = 0;
        case (aluCtr)
            4'b0000:    //and
                aluRes = input1 & input2;
            4'b0001:    //or
                aluRes = input1 | input2;
            4'b0010:    //add
                begin
                    aluRes = input1 + input2;
                    if ((input1[31]) == (input2[31]) && (input1[31]) != (aluRes[31]))
                        overflow = 1;
                    else
                        overflow = 0;
                end
            4'b0110:    //sub
                begin
                    aluRes = input1 - input2;
                    temp = (~input2)+1;
                    if ((input1[31]) == (temp[31]) && (input1[31]) != (aluRes[31]))
                        overflow = 1;
                    else
                        overflow = 0;
                end
            4'b0111:    //set on less than
                begin
                    if ($signed(input1) < $signed(input2))
                        aluRes = 1;
                    else 
                        aluRes = 0;
                end
            
            4'b0011:    //shift left
                aluRes = (input2 << input1);

            4'b0100:    //logical shift right
                aluRes = (input2 >> input1);

            //---------------new-aluctr-----------//    
            4'b1001:    //xor
                aluRes = (input1 ^ input2);
            4'b0101:    //nor
                aluRes = ~(input1 | input2);
            4'b1010:    //addu
                aluRes = input1 + input2;
            4'b1110:    //subu
                aluRes = input1 - input2;
            4'b1111:    //sltu
                begin
                    if (input1 < input2)
                        aluRes = 1;
                    else 
                        aluRes = 0;
                end
            4'b1000:    //sra
                aluRes = ($signed(input2) >>> input1);
            4'b1100:    //lui
                aluRes = (input2<<16);
            default:
                aluRes = 0;
        endcase
        if(aluRes == 0)
            zero = 1;
        else
            zero = 0;
    end
endmodule  
