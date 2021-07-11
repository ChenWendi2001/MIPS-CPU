`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/04 11:12:47
// Design Name: 
// Module Name: Forwarding
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


module Forwarding(
        input regWriteMEM,
        input regWriteWB,
        input [4:0] regWriteAddrMEM,
        input [4:0] regWriteAddrWB,
        input [4:0] rsAddr,
        input [4:0] rtAddr,
        output [1:0] FORMUXA,
        output [1:0] FORMUXB
    );

    assign FORMUXA[0] = (
        regWriteMEM?0:(regWriteWB?(rsAddr == regWriteAddrWB?1:0):0)
    );

    assign FORMUXA[1] = (
        //regWriteWB?0:(regWriteMEM?(rsAddr == regWriteAddrMEM?1:0):0)
        regWriteMEM?(rsAddr == regWriteAddrMEM?1:0):0
    );

    assign FORMUXB[0] = (
        regWriteMEM?0:(regWriteWB?(rtAddr == regWriteAddrWB?1:0):0)
    );

    assign FORMUXB[1] = (
        //regWriteWB?0:(regWriteMEM?(rtAddr == regWriteAddrMEM?1:0):0)
        regWriteMEM?(rtAddr == regWriteAddrMEM?1:0):0
    );


endmodule
