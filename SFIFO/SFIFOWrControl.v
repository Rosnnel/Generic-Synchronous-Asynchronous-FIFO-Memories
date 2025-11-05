`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rosnnel Moncada
// 
// Create Date: 25.07.2025 11:31:27
// Design Name: FIFO Write Controller
// Module Name: FIFOWrControl
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


module FIFOWrControl #(parameter AddrLines = 8)
(clk,reset,FIFOWrReq,SyncRdAddr,WrEn,WrAddr,SyncWrAddr,FIFOFull);

    input clk,reset,FIFOWrReq;
    input[AddrLines:0]SyncRdAddr;
    output WrEn;
    output [AddrLines-1:0]WrAddr;
    output reg [AddrLines:0]SyncWrAddr;
    output FIFOFull;    
    
    assign FIFOFull = (SyncWrAddr == {~SyncRdAddr[AddrLines],SyncRdAddr[AddrLines-1:0]});
    assign WrEn = (FIFOWrReq&&(!FIFOFull));
   
    always@(posedge clk or posedge reset)
    begin
        if(reset)
            SyncWrAddr<=0;
        else if(FIFOWrReq&&(!FIFOFull))
            SyncWrAddr <= SyncWrAddr+1; 
    end
    
   assign WrAddr = SyncWrAddr[AddrLines-1:0];
    
endmodule
