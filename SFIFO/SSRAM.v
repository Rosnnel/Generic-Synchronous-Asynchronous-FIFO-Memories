// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

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
