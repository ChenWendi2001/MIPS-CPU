`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 11:44:02
// Design Name: 
// Module Name: zeroext
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


module zeroext(
        input [31:0] shamt,
        output [31:0] data
    );
    assign data = {27'b000000000000000000000000000,shamt[10:6]};
endmodule
