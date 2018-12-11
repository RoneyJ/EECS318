//RxFIFO module for the SSP of HW 3
//Josh Roney (jpr87)
module RxFIFO(
	input psel, pwrite, clear_b, pclk,
	input rcv,
	input [7:0] rxdata,
	output ssprxintr,
	output [7:0] prdata
	);
	
	reg [7:0] storage [0:3];	//4 8-bit registers for storage
	reg [7:0] out;			//output data
	reg intr;			//interrupt signal
	integer place;			//placeholder for free space in storage
	
	initial
	begin
		storage[0] = 8'h00;
		storage[1] = 8'h00;
		storage[2] = 8'h00;
		storage[3] = 8'h00;
		intr = 0;
		place = 0;
	end
	
	always @(posedge pclk or clear_b)
	begin
		if(~clear_b)
		begin
			storage[0] = 8'h00;
			storage[1] = 8'h00;
			storage[2] = 8'h00;
			storage[3] = 8'h00;
			intr = 0;
			place = 0;
		end
		
		else
		begin
			if(~intr && rcv)	//accept an input
			begin
				storage[place] = rxdata;
				place = place + 1;
				if(place >= 4)
					intr = 1;
			end
			
			if(psel && ~pwrite)	//if psel is high and pwrite is low, output data
			begin
				out = storage[0];
				storage[0] = storage[1];
				storage[1] = storage[2];
				storage[2] = storage[3];
				storage[3] = 8'h00;	
				place = place - 1;
			
				if(intr && (place < 4))
					intr = 0;
			end
		end
	end
	
	assign prdata = out;	//storage[0] & psel & ~pwrite;
	assign ssprxintr = intr;
endmodule
