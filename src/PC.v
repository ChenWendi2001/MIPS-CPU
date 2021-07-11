`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/26 09:29:14
// Design Name: 
// Module Name: PC
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


module PC(
        input [31:0] addrIn,
        output reg [31:0] addrOut,
        input reset,
        input stall,
        input clk
    );
    
    always @(posedge clk or reset)
    begin
        if(reset)
            addrOut = 0;
        else
            if(~stall)
            begin
                addrOut = addrIn;
            end
    end
    
    
    initial begin:PcInit
        addrOut = 0;
    end
    
endmodule
