`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rosnnel Moncada
// 
// Create Date: 25.07.2025 11:05:09
// Design Name: Static Random Access Memory
// Module Name: SRAM
// Project Name: ConsoleAccessProject
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


module SSRAM #(parameter Depth = 512, Width = 8)
(clk,WrData,WrEn,WrAddr,RdData,RdEn,RdAddr);
    
    localparam AddrLines = $clog2(Depth);
    
    input clk,WrEn,RdEn;
    input [Width-1:0]WrData;
    input [AddrLines-1:0] WrAddr,RdAddr;
    output reg [Width-1:0]RdData;

    reg [Width-1:0]MEM[0:Depth-1];
    
    always@(posedge clk)
    begin
        if(WrEn)
            MEM[WrAddr] <= WrData;
    end
    
    always@(posedge clk)
    begin
        if(RdEn)
            RdData <= MEM[RdAddr];
    end

endmodule
