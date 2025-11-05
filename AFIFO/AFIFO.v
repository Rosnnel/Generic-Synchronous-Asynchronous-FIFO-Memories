module AFIFO #(parameter Width = 8, Depth = 512)(reset,WRclk,RDclk,WRreq,RDreq,WRdata,RDdata,FIFOfull,FIFOempty);
	
	localparam AddrLines = $clog2(Depth);

	input reset,WRclk,RDclk,WRreq,RDreq;
	input[Width-1:0]WRdata;
	output FIFOfull,FIFOempty;
	output[Width-1:0]RDdata;
	
	wire WRen_W,RDen_W;
	wire[AddrLines-1:0]WRaddr_W,RDaddr_W;
	wire[AddrLines:0]GrayRDaddr_W,GrayWRaddr_W;
	
	SSRAM #(.Width(Width), .AddrLines(AddrLines)) SSRAM
	(.WRclk(WRclk),.RDclk(RDclk),.WRen(WRen_W),.RDen(RDen_W),.WRaddr(WRaddr_W),.RDaddr(RDaddr_W),.WRdata(WRdata),.RDdata(RDdata));

	AFIFOWRControl #(.AddrLines(AddrLines)) AFIFOWRControl
	(.WRclk(WRclk),.reset(reset),.WRreq(WRreq),.GrayRDaddr(GrayRDaddr_W),.WRaddr(WRaddr_W),.WRen(WRen_W),.GrayWRaddr(GrayWRaddr_W),
	.FIFOfull(FIFOfull));
	
	AFIFORDControl #(.AddrLines(AddrLines)) AFIFORDControl
	(.RDclk(RDclk),.reset(reset),.RDreq(RDreq),.GrayWRaddr(GrayWRaddr_W),.RDen(RDen_W),.RDaddr(RDaddr_W),.GrayRDaddr(GrayRDaddr_W),
	.FIFOempty(FIFOempty));

endmodule
