module AFIFORDControl #(parameter AddrLines = 3)(RDclk,reset,RDreq,GrayWRaddr,RDen,RDaddr,GrayRDaddr,FIFOempty);

	input RDclk,reset,RDreq;
	input[AddrLines:0]GrayWRaddr;
	output RDen,FIFOempty;
	output[AddrLines-1:0]RDaddr;
	output reg[AddrLines:0]GrayRDaddr;
	
	reg [AddrLines:0]GrayWRsync1,GrayWRsync2;
	reg [AddrLines:0]BinRDaddr;
	wire [AddrLines:0]BinRDaddr_next,GrayRDaddr_next;
	
	always@(posedge RDclk or posedge reset)		//2-step synchronizer
	begin
		if(reset)
		begin
			GrayWRsync1<=0;
			GrayWRsync2<=0;
		end
		else
		begin
			GrayWRsync1<=GrayWRaddr;
			GrayWRsync2<=GrayWRsync1;
		end
	end

	assign FIFOempty = (GrayWRsync2==GrayRDaddr);
	assign RDen = (RDreq&(!FIFOempty));
	assign BinRDaddr_next = (RDreq&(!FIFOempty)) ? BinRDaddr+1 : BinRDaddr; 
	assign GrayRDaddr_next = BinRDaddr_next ^ (BinRDaddr_next>>1);
	assign RDaddr = BinRDaddr[AddrLines-1:0];
	
	always@(posedge RDclk or posedge reset)
	begin
		if(reset)
		begin
			BinRDaddr<=0;
			GrayRDaddr<=0;
		end
		else
		begin
			BinRDaddr<=BinRDaddr_next;
			GrayRDaddr<=GrayRDaddr_next;
		end
	end
	
endmodule
