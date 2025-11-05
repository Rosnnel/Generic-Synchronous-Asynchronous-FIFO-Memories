module AFIFO_TB();

	parameter Width = 8;
	parameter Depth = 512;

	reg reset,WRclk,RDclk,WRreq,RDreq;
	reg[Width-1:0]WRdata;
	wire FIFOfull,FIFOempty;
	wire[Width-1:0]RDdata;
	
	AFIFO #(.Width(Width), .Depth(Depth)) DUT
	(reset,WRclk,RDclk,WRreq,RDreq,WRdata,RDdata,FIFOfull,FIFOempty);
	
	initial
	begin
		$monitor
		(
			"Time=%0t, FIFOfull=%b, FIFOempty=%b, RDdata=%b",
			$time, FIFOfull, FIFOempty, RDdata
		);
	end

	initial
	begin
		WRclk=0;
		forever #10 WRclk = ~WRclk;
	end
	
	initial
	begin
		RDclk=0;
		forever #20 RDclk = ~RDclk;
	end
	
	
	initial
	begin
		#0; reset=1;
		#40; reset=0;
	end
	
	initial
	begin
		#0;WRreq=0; WRdata=8'h00; 
		#40; WRreq=1; WRdata=8'h01;
		#20; WRreq=1; WRdata=8'h02;
		#20; WRreq=1; WRdata=8'h03;
		#20; WRreq=1; WRdata=8'h04;
		#20; WRreq=1; WRdata=8'h05;
		#20; WRreq=1; WRdata=8'h06;
		#20; WRreq=1; WRdata=8'h07;
		#20; WRreq=1; WRdata=8'h08;
		#20; WRreq=1; WRdata=8'h09;
		#20; WRreq=1; WRdata=8'h0A;
		#20; WRreq=0;
		#250;
		#20; WRreq=1; WRdata=8'h0B;
		#20; WRreq=1; WRdata=8'h0C;
		#20; WRreq=1; WRdata=8'h0D;
		#20; WRreq=1; WRdata=8'h0E;
		#20; WRreq=1; WRdata=8'h0F;
		#20; WRreq=1; WRdata=8'h10;
		#20; WRreq=1; WRdata=8'h11;
		#20; WRreq=1; WRdata=8'h12;
		#20; WRreq=1; WRdata=8'h13;
		#20; WRreq=1; WRdata=8'h14;
		#40; WRreq=0;
	end
	
	initial
	begin
		#0; RDreq=0;
		#40; RDreq=1;
	end
	
endmodule
