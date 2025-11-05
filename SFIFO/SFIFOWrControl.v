// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

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
