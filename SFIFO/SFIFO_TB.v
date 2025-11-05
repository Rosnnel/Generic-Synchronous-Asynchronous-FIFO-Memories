// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module SFIFO_TB();

    parameter Depth = 8, Width = 8;
    
    reg clk,reset,FIFORdReq,FIFOWrReq;
    reg [Width-1:0]WRData;
    wire [Width-1:0]RDData;
    wire FIFOFull,FIFOEmpty;
    
    SFIFO #(Depth,Width) UUT
    (clk,reset,WRData,FIFORdReq,FIFOWrReq,RDData,FIFOFull,FIFOEmpty);
    
    initial
    begin
        clk=0;
        forever #5 clk = ~clk;
    end
    
    integer i,j;
    
    initial
    begin
        #0; reset=1; FIFOWrReq=0;
        #10; reset=0;
        
        if(~FIFOFull)
        begin
            for(i=0; i<15; i=i+1)
            begin
                #990
                FIFOWrReq = 1;
                WRData = $random;
                #10;
                FIFOWrReq = 0;
            end
        end
    end
    
    initial
    begin
        #0; FIFORdReq = 0;
        
        #1015;
        while(~FIFOEmpty)
        begin
            for(j=0; j<Depth; j=j+1)
            begin
                #1990
                FIFORdReq = 1;
                #10; FIFORdReq = 0;
            end
        end
    end
    
    
endmodule
