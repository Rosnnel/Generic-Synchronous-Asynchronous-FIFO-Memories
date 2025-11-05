// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module DualClockSRAM #(parameter Width = 8, Depth = 512)
(WRclk,RDclk,WRen,RDen,WRaddr,RDaddr,WRdata,RDdata);

	localparam AddrLines = $clog2(Depth);

	input WRclk,RDclk,WRen,RDen;
	input [AddrLines-1:0]WRaddr,RDaddr;
	input [Width-1:0]WRdata;
	output reg[Width-1:0]RDdata;
	
	reg [Width-1:0]MEM[(0:Depth-1];
	
	always@(posedge WRclk)
	begin
		if(WRen)
			MEM[WRaddr] <= WRdata;
	end

	always@(posedge RDclk)
	begin
		if(RDen)
			RDdata <= MEM[RDaddr];
	end
	
endmodule
