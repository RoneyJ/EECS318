//TxFIFO module for the SSP of HW 3
//Josh Roney (jpr87)
module TxFIFo(
	input psel, pwrite, clear_b, pclk,
	input remove,					//signal from transmit logic to indicate when to output next data in storage
	input [7:0] pwdata,
	output ssptxintr, tmit,
	output [7:0] txdata
	);
	
	reg [7:0] storage [0:3];	//4 8-bit registers for storage in the FIFO
	reg	intr, tmit;						//interrupt signal and transmit signal for transmit logic
	integer place;					//placeholder integer to mark location of free space (if place = 4, FIFO is full)
	
	
	initial
	begin
		storage = {8'h00,8'h00,8'h00,8'h00};
		intr = 0;
		place  = 0;
	end
	
	always @(posedge pclk or clear_b)
	begin
		if(~clear_b)
		begin
			storage = {8'h00,8'h00,8'h00,8'h00};
			intr = 0;
			place  = 0;
		end
		
		else
		begin
			if(psel && pwrite && ~intr)	//accept an input
			begin
				storage[place] = pwdata;
				place = place + 1;
				if(place >= 4)
					intr = 1;
			end
			
			if(remove)	//shift reg for new output, check if empty if intr was high
			begin
				storage = {8'h00, storage[3:1]};
				place = place - 1;
				if(intr && (place == 0))
					intr = 0;
			end
		end
	end
	
	assign tmit = ~(storage[0] == 8'h00);
	assign ssptxintr = intr;
	assign txdata = storage[0];
endmodule 