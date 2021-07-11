`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/04 11:11:53
// Design Name: 
// Module Name: FORMUX
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


module FORMUX(
        input [31:0] input0,
        input [31:0] input1, //from memory
        input [31:0] input2, // from ALU
        input [1:0] sel, // sel[0]: memory sel[1]: ALU
        output [31:0] out
    );
    assign out = (sel[0]?input1:(sel[1]?input2:input0));
endmodule
