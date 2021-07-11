`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/04 11:12:24
// Design Name: 
// Module Name: hazardDetect
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


module hazardDetect(
        input memRead,
        input [4:0] regWriteAddr,
        input [4:0] rsAddr,
        input [4:0] rtAddr,
        output stall
    );

    assign stall = (memRead?(((regWriteAddr==rsAddr)||(regWriteAddr==rtAddr))?1:0):0);
endmodule
