`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 08:35:18
// Design Name: 
// Module Name: instMemory
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


module instMemory(
        input [31:0] readAddr,
        output reg [31:0] inst
    );

    reg [31:0] memFile [0:1023];
    
    always @ (readAddr)
    begin
//        $display("entering");
        inst = ((readAddr>>2) < 1024 ? memFile[readAddr>>2]:0);
    end

endmodule
