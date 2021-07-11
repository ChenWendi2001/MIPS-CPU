`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 09:05:20
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
        //--------------------input----------------------//
        input clk,
        input reset,
        //D0:RegWrite_id D1:MemToReg_id
        input [1:0] EX_WB,
        //D0: MemWrite_ex D1: MemRead_ex
        input [1:0] EX_M,
        input [31:0] EX_ALUout,
        input [31:0] EX_MemWriteData,
        input [4:0] EX_rd_or_rt,
        //--------------------output----------------------//
        output reg [1:0] MEM_WB,
        output reg [1:0] MEM_M,
        output reg [31:0] MEM_ALUout,
        output reg [31:0] MEM_MemWriteData,
        output reg [4:0] MEM_rd_or_rt
    );
    always @(posedge clk)
    if(reset)
    begin
        MEM_WB<=0;
        MEM_M<=0;
        MEM_ALUout<=0;
        MEM_MemWriteData<=0;
        MEM_rd_or_rt<=0;
    end
    else
    begin
        MEM_WB<=EX_WB;
        MEM_M<=EX_M;
        MEM_ALUout<=EX_ALUout;
        MEM_MemWriteData<=EX_MemWriteData;
        MEM_rd_or_rt<=EX_rd_or_rt;
    end
endmodule
