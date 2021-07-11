`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 11:12:56
// Design Name: 
// Module Name: zerotest
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


module zerotest(
        input Branch,
        input BranchNot,
        input [31:0] readData1,
        input [31:0] readData2,
        input [31:0] aluOut,
        input [4:0] rsAddr,
        input [4:0] rtAddr,
        input [4:0] forAddr,
        output zero
    );
    assign zero = (Branch?
    ((forAddr==rsAddr)?((aluOut==readData2) ? (BranchNot?0:1) : (BranchNot?1:0)):((forAddr==rtAddr)?((readData1==aluOut) ? (BranchNot?0:1) : (BranchNot?1:0)):((readData1==readData2) ? (BranchNot?0:1) : (BranchNot?1:0))))
    :0);
endmodule
