`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 09:05:45
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
        //--------------------input----------------------//
        input clk,
        input reset,
        //D0:RegWrite_id D1:MemToReg_id
        input [1:0] MEM_WB,
        input [31:0] MEM_ALUout,
        input [31:0] MEM_MEMout,
        input [4:0] MEM_rd_or_rt,
        //--------------------output----------------------//
        output reg [1:0] WB_WB,
        output reg [31:0] WB_ALUout,
        output reg [31:0] WB_MEMout,
        output reg [4:0] WB_rd_or_rt
    );
    always @(posedge clk)
    if(reset)
    begin
        WB_WB<=0;
        WB_ALUout<=0;
        WB_MEMout<=0;
        WB_rd_or_rt<=0;
    end
    else
    begin
        WB_WB<=MEM_WB;
        WB_ALUout<=MEM_ALUout;
        WB_MEMout<=MEM_MEMout;
        WB_rd_or_rt<=MEM_rd_or_rt;
    end
endmodule
