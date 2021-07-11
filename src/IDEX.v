`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 09:05:00
// Design Name: 
// Module Name: IDEX
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


module IDEX(
        //--------------------input----------------------//
        input clk,
        input reset,
        input stall,
        //D0:RegWrite_id D1:MemToReg_id
        input [1:0] ID_WB,
        //D0:MemWrite_id D1:MemRead_id
        input [1:0] ID_M,
        //D0-D3:aluCtr D4:ALUSrcA_id D5:ALUSrcB_id D6:RegDst_id
        input [6:0] ID_EX,
        input [31:0] ID_PC_plus_4,
        input [31:0] ID_signext,
        input [31:0] ID_zeroext,
        input [4:0] ID_rd,
        input [4:0] ID_rs,
        input [4:0] ID_rt,
        input [31:0] ID_rs_data,
        input [31:0] ID_rt_data,

        //--------------------output----------------------//
        output reg [1:0] EX_WB,
        output reg [1:0] EX_M,
        output reg [6:0] EX_EX,
        output reg [31:0] EX_PC_plus_4,
        output reg [31:0] EX_signext,
        output reg [31:0] EX_zeroext,
        output reg [4:0] EX_rd,
        output reg [4:0] EX_rs,
        output reg [4:0] EX_rt,
        output reg [31:0] EX_rs_data,
        output reg [31:0] EX_rt_data
    );
    always @(posedge clk)
        if(reset)
        begin
            EX_WB<=0;
            EX_M<=0;
            EX_EX<=0;
            EX_PC_plus_4<=0;
            EX_signext<=0;
            EX_zeroext<=0;
            EX_rd<=0;
            EX_rs<=0;
            EX_rt<=0;
            EX_rs_data<=0;
            EX_rt_data<=0;
        end
        else
        begin
            if (stall)
            begin
                EX_WB<=0;
                EX_M<=0;
                EX_EX<=0;
                EX_PC_plus_4<=0;
                EX_signext<=0;
                EX_zeroext<=0;
                EX_rd<=0;
                EX_rs<=0;
                EX_rt<=0;
                EX_rs_data<=0;
                EX_rt_data<=0;
            end
            else
            begin
                EX_WB<=ID_WB;
                EX_M<=ID_M;
                EX_EX<=ID_EX;
                EX_PC_plus_4<=ID_PC_plus_4;
                EX_signext<=ID_signext;
                EX_zeroext<=ID_zeroext;
                EX_rd<=ID_rd;
                EX_rs<=ID_rs;
                EX_rt<=ID_rt;
                EX_rs_data<=ID_rs_data;
                EX_rt_data<=ID_rt_data;
            end
        end
        
    
endmodule
