`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 10:46:13
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output reg [31:0] readData
    );

    reg [31:0] memFile [0:1023];
    reg [31:0] cache [0:15];
    reg [31:0] addr [0:15];
    reg dirty[0:15];
    reg valid[0:15];
    reg [31:0] temp;
    reg cache_hit;

    always @(memRead or address)
    begin
        if (memRead)
        begin
            if(address<1024)
                begin
                    temp = address & 4'hf;
                    if(valid[temp] && addr[temp] ==address)
                        begin
                            readData = cache[temp];
                            cache_hit = 1;
                        end
                        
                    else if (valid[temp] && addr[temp]!=address)
                        begin
                            if(dirty[temp])
                                begin
                                    memFile[addr[temp]] = cache[temp];
                                end
                            cache[temp] = memFile[address];
                            addr[temp] = address;
                            dirty[temp] = 0;
                            cache_hit = 0;
                        end
                    else
                        begin
                            valid[temp] = 1;
                            cache[temp] = memFile[address];
                            addr[temp] = address;
                            dirty[temp] = 0;
                            cache_hit = 0;
                        end
                    readData = cache[temp];
                end
            else
                readData = 0;
        end
    end

    always @(negedge clk)
    begin
        if(memWrite && address<1024)
            begin
                temp = address & 4'hf;
                if(valid[temp] && addr[temp] ==address)
                    begin
                        dirty [temp] = 1;
                        cache[temp] = writeData;
                        cache_hit = 1;
                    end
                else if (valid[temp] && addr[temp]!=address)
                    begin
                        if(dirty[temp])
                            begin
                                memFile[addr[temp]] = cache[temp];
                            end
                        cache[temp] = writeData;
                        addr[temp] = address;
                        dirty[temp] = 1;
                        cache_hit = 0;
                    end
                else
                    begin
                        valid[temp] = 1;
                        cache[temp] = writeData;
                        addr[temp] = address;
                        dirty[temp] = 1;
                        cache_hit = 0;
                    end
            end
    end

    initial begin:DataInit
        integer i;
        for(i = 0;i<1024;i=i+1)
            memFile[i]=0;
        for(i = 0;i<32;i=i+1)
        begin
            cache[i] = 0;
            addr[i] =0;
            valid[i] = 0;
            dirty[i] = 0;
        end
        readData = 0;
        cache_hit = 0;
    end
endmodule
