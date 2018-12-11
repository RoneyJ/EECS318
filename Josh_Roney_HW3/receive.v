//receive logic module for the SSP of HW 3
//Josh Roney (jpr87)
module receive(
	input clear_b, pclk, sspclkin, sspfssin, ssprxd,
	output [7:0] rxdata,
	output rcv			//signal to RxFIFO on when to accept the input
	);
	
	reg [7:0] data;	//storage for output data
	reg done, rec;			//reg to hold value of rcv
	reg [3:0] state;	//state variable
	localparam [3:0]
		S0 = 4'b0000,
		S1 = 4'b0001,
		S2 = 4'b0010,
		S3 = 4'b0011,
		S4 = 4'b0100,
		S5 = 4'b0101,
		S6 = 4'b0110,
		S7 = 4'b0111,
		S8 = 4'b1000;
	
	initial
	begin
		data = 8'h00;
		rec = 0;
		done = 0;
		state = S0;
	end

	always @(posedge pclk)
	begin
		if(done && ~rec)
			rec = 1;
		else if(done && rec)
			rec = 0;
		else if(~done)
			rec = 0;
	end
	
	always @(posedge sspclkin or clear_b)
	begin
		if(~clear_b)
		begin
			data = 8'h00;
			done = 0;
			state = S0;
		end
		
		else
		case(state)
			S0:
			begin
				done = 0;
				if(sspfssin)
					state = S1;
			end
			
			S1:
			begin
				data[7] = ssprxd;
				state = S2;
			end
			
			S2:
			begin
				data[6] = ssprxd;
				state = S3;
			end
			
			S3:
			begin
				data[5] = ssprxd;
				state = S4;
			end
			
			S4:
			begin
				data[4] = ssprxd;
				state = S5;
			end
			
			S5:
			begin
				data[3] = ssprxd;
				state = S6;
			end
			
			S6:
			begin	
				data[2] = ssprxd;
				state = S7;
			end
			
			S7:
			begin
				data[1] = ssprxd;
				state = S8;
			end
			
			S8:
			begin
				data[0] = ssprxd;
				done = 1;
				state = S0;
			end
		endcase
	end
	
	assign rcv = rec;
	assign rxdata = data;
	
endmodule
