`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rosnnel Moncada
// 
// Create Date: 28.07.2025 09:17:05
// Design Name: Synchronous Firs-In First-Out Memory
// Module Name: SFIFO
// Project Name: 
// Target Devices: XC7S50CSGA324-1
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


module SFIFO #(parameter Depth = 512, Width = 8)
(clk,reset,WRData,FIFORdReq,FIFOWrReq,RDData,FIFOFull,FIFOEmpty);

    localparam AddrLines = $clog2(Depth);

    input clk,reset,FIFORdReq,FIFOWrReq;
    input [Width-1:0]WRData;
    output [Width-1:0]RDData;
    output FIFOFull,FIFOEmpty;
    
    wire RdEn_W,WrEn_W;
    wire[AddrLines-1:0]RdAddr_W,WrAddr_W;
    wire[AddrLines:0]SyncWrAddr_W,SyncRdAddr_W;    
    
    FIFORdControl #(.AddrLines(AddrLines))RdControl
    (.clk(clk),.reset(reset),.FIFORdReq(FIFORdReq),.SyncWrAddr(SyncWrAddr_W),.RdEn(RdEn_W),
    .FIFOEmpty(FIFOEmpty),.RdAddr(RdAddr_W),.SyncRdAddr(SyncRdAddr_W));

    FIFOWrControl #(.AddrLines(AddrLines))WrControl
    (.clk(clk),.reset(reset),.FIFOWrReq(FIFOWrReq),.SyncRdAddr(SyncRdAddr_W),.WrEn(WrEn_W),
    .WrAddr(WrAddr_W),.SyncWrAddr(SyncWrAddr_W),.FIFOFull(FIFOFull));
    
    SSRAM #(.Depth(Depth),.Width(Width))SSRAM
    (.clk(clk),.WrData(WRData),.WrEn(WrEn_W),.WrAddr(WrAddr_W),.RdData(RDData),
    .RdEn(RdEn_W),.RdAddr(RdAddr_W));

endmodule
