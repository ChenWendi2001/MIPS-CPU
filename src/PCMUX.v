`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/03 18:58:53
// Design Name: 
// Module Name: PCMUX
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


module PCMUX(
        input [31:0] input0,
        input [31:0] input1, //jump
        input [31:0] input2, // beq
        input [31:0] input3, // jr address
        input [2:0] sel,
        output [31:0] out
    );

    assign out = (sel[0]? input1:(sel[1]?input2:(sel[2]?input3:input0)));

endmodule
