`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 09:04:44
// Design Name: 
// Module Name: IFID
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


module IFID(
        //--------------------input----------------------//
        input clk,
        input reset,
        input stall,
        input flush,
        input [31:0] IF_inst,
        input [31:0] IF_PC_plus_4,
        //--------------------output----------------------//
        output reg [31:0] ID_inst,
        output reg [31:0] ID_PC_plus_4
    );
    always @ (posedge clk or reset)
        if(reset)
        begin
            ID_inst <= 0;
            ID_PC_plus_4<=0;
        end
        else
        begin
            if (flush)
            begin
                ID_inst<=0;
                ID_PC_plus_4<=0;                  
            end
            else if (~stall)
            begin
                ID_inst<=IF_inst;
                ID_PC_plus_4<=IF_PC_plus_4;  
            end
        end
    
endmodule
