`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 10:12:53
// Design Name: 
// Module Name: Registers
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


module Registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input reset,
    input regWrite,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    input clk,
    input jr,
    input jal,
    input [31:0] pcPlus4
    );

    reg [31:0] regFile [31:0];

    always @(readReg1 or readReg2 or writeReg or jr)
    begin
        if (jr)
            readData1 = regFile[31];
        else
            readData1 = regFile[readReg1];
        readData2 = regFile[readReg2];
    end
    
    integer k;
    always @(negedge clk or reset )
    begin
        if (reset)
            for(k=0;k<32;k=k+1)
                regFile[k] = 0;
        else
            if(jal)
                begin
                regFile[31] = pcPlus4;
                regFile[writeReg] = writeData;
                readData1 = regFile[readReg1];
                readData2 = regFile[readReg2];
                end
            else if (regWrite)
                begin
                regFile[writeReg] = writeData;
                readData1 = regFile[readReg1];
                readData2 = regFile[readReg2];
                end
    end
    

    integer i;
    initial begin:DataInit
        for(i = 0;i<32;i=i+1)
            regFile[i]=0;
        readData1 = 0;
        readData2 = 0;
    end
endmodule
