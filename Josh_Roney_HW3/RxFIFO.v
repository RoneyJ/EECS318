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
	reg [7:0] out;					//output data
	reg int;							//interrupt signal
	integer place;					//placeholder for free space in storage
	
	initial
	begin
		storage = {8'h00, 8'h00, 8'h00, 8'h00};
		intr = 0;
		place = 0;
	end
	
	always @(posedge pclk or clear_b)
	begin
		if(~clear_b)
		begin
			storage = {8'h00, 8'h00, 8'h00, 8'h00};
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
				storage = {8'h00, storage[3:1]};	//shift the reg right
				place = place - 1;
			
				if(intr $$ (place == 0))
					intr = 0;
			end
		end
	end
	
	assign prdata = out;	//storage[0] & psel & ~pwrite;
	assign ssprxintr = intr;
endmodule 