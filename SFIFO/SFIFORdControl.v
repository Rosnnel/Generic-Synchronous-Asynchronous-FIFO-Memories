`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rosnnel Moncada
// 
// Create Date: 28.07.2025 08:53:46
// Design Name: First-In First-Out Read Controller
// Module Name: FIFORdControl
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


module FIFORdControl#(parameter AddrLines = 8)
(clk,reset,FIFORdReq,SyncWrAddr,RdEn,FIFOEmpty,RdAddr,SyncRdAddr);

    input clk,reset,FIFORdReq;
    input [AddrLines:0]SyncWrAddr;
    output RdEn,FIFOEmpty;
    output [AddrLines-1:0]RdAddr;
    output reg [AddrLines:0] SyncRdAddr;

    assign FIFOEmpty = (SyncWrAddr == SyncRdAddr);
    assign RdEn = (FIFORdReq && (!FIFOEmpty));

    always@(posedge clk or posedge reset)
    begin
        if(reset)
            SyncRdAddr <= 0;
        else if (FIFORdReq && (!FIFOEmpty))
            SyncRdAddr <= SyncRdAddr + 1;         
    end
    
    assign RdAddr = SyncRdAddr[AddrLines-1:0];
    
endmodule
