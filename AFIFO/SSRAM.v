module SSRAM #(parameter Width = 8, Depth = 512)
(WRclk,RDclk,WRen,RDen,WRaddr,RDaddr,WRdata,RDdata);

	localparam AddrLines = $clog2(Depth);

	input WRclk,RDclk,WRen,RDen;
	input [AddrLines-1:0]WRaddr,RDaddr;
	input [Width-1:0]WRdata;
	output reg[Width-1:0]RDdata;
	
	reg [Width-1:0]FIFOdepth[((1<<AddrLines)-1):0];
	
	always@(posedge WRclk)
	begin
		if(WRen)
			FIFOdepth[WRaddr] <= WRdata;
	end

	always@(posedge RDclk)
	begin
		if(RDen)
			RDdata <= FIFOdepth[RDaddr];
	end
	
endmodule
