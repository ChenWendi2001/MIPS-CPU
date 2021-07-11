`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 09:55:24
// Design Name: 
// Module Name: MUX5
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


module MUX5(
        input [4:0] input0,
        input [4:0] input1,
        input sel,
        output [4:0] out
    );
    assign out = (sel ? input1 : input0);
endmodule
