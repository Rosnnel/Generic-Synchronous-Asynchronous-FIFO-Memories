module AFIFOWRControl #(parameter AddrLines = 3)(WRclk,reset,WRreq,GrayRDaddr,WRaddr,WRen,GrayWRaddr,FIFOfull);

	input WRclk,reset,WRreq;
	input[AddrLines:0]GrayRDaddr;
	output WRen,FIFOfull;
	output[AddrLines-1:0]WRaddr;
	output reg[AddrLines:0]GrayWRaddr;
	
	reg[AddrLines:0] GrayRDsync1,GrayRDsync2;			//Synchronizers for the GrayRDaddr
	reg[AddrLines:0]	BinWRaddr;								//Binary version of the WRaddr, used to store the BinWRaddr_Next in each clk cycle 
	wire[AddrLines:0] BinWRaddr_Next,GrayWRaddr_Next;	//wires used to calculate the next WRaddr in their binary and gray versions
	
	always@(posedge WRclk or posedge reset)		//2-step synchronizer for incoming read addr
	begin
		if(reset)
		begin
			GrayRDsync1 <= 0;
			GrayRDsync2 <= 0;
		end
		else
		begin
			GrayRDsync1 <= GrayRDaddr;
			GrayRDsync2 <= GrayRDsync1;
		end
	end
	
	assign FIFOfull = (GrayWRaddr == ({~GrayRDsync2[AddrLines],~GrayRDsync2[AddrLines-1],GrayRDsync2[AddrLines-2:0]}));	//IF write addr wrapped around read addr then FIFO is full}	
	assign WRen = WRreq&(!FIFOfull);			//The WR control will write only if there is a request and the FIFO is not full}	
	assign BinWRaddr_Next = (WRreq&(!FIFOfull)) ? BinWRaddr+1 : BinWRaddr;		//The next Binary WRaddr will be added to the one bit WRen 
	assign GrayWRaddr_Next = BinWRaddr_Next ^ (BinWRaddr_Next>>1); // the next addr in gray format
	assign WRaddr = BinWRaddr[AddrLines-1:0];		//The memory addr will be updated with the LSB of the next addr in bin forma
	
	always@(posedge WRclk or posedge reset)
	begin
		if(reset)
		begin
			GrayWRaddr <= 0;
			BinWRaddr <= 0;
		end
		else
		begin
			GrayWRaddr <= GrayWRaddr_Next;
			BinWRaddr <= BinWRaddr_Next;
		end
	end
	

endmodule