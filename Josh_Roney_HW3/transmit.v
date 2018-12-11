//transmit logic module for the SSP of HW 3
//Josh Roney (jpr87)
module transmit(
	input [7:0] txdata,
	input clear_b, pclk,
	input tmit,			//signal from Tx_FIFO to accept a new input
	output sspoe_b, ssptxd, sspfssout, sspclkout,
	output remove		//signal to TxFIFO to shift its reg and output new data
	);
	
	reg rmv, rem;				//reg to hold value of remove
	reg clk;				//reg to hold value of sspclkout
	reg fss;				//reg to hold value of sspfssout
	reg bit;				//reg to hold value of ssptxd
	reg oe, en;			//reg to hold value of sspoe_b
	reg [3:0] state;	//state machine reg
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
		rmv = 0;
		rem = 0;
		clk = 0;
		fss = 0;
		bit = 0;
		oe = 1;
		state = S0;
	end
	
	always @(posedge pclk)
	begin
		clk = ~clk;
		if(rmv && ~rem)
			rem = 1;
		else if(rmv && rem)
			rem = 0;
	end
	
	always @(posedge clk or clear_b)
	begin
		if(~clear_b)
		begin
			rmv = 0;
			fss = 0;
			bit = 0;
			oe = 1;
			state = S0;
		end
		
		else
		case(state)
			S0:
			begin
				rmv = 0;
				if(tmit)
				begin
					fss = 1;
					en = 0;
					state = S1;
				end
				else
					en = 1;
			end
			
			S1:
			begin
				fss = 0;
				bit = txdata[7];
				state = S2;
			end
			
			S2:
			begin
				bit = txdata[6];
				state = S3;
			end
			
			S3:
			begin
				bit = txdata[5];
				state = S4;
			end
			
			S4:
			begin
				bit = txdata[4];
				state = S5;
			end
			
			S5:
			begin
				bit = txdata[3];
				state = S6;
			end
			
			S6:
			begin
				bit = txdata[2];
				state = S7;
			end
			
			S7:
			begin
				bit = txdata[1];
				state = S8;
			end
			
			S8:
			begin
				en = 1;
				bit = txdata[0];
				state = S0;
				rmv = 1;
			end
			
		endcase
	end
	
	always @(negedge clk)
	begin
		oe = en;
	end
	
	assign sspoe_b = oe;
	assign ssptxd = bit;
	assign sspfssout = fss;
	assign sspclkout = clk;
	assign remove = rem;
endmodule
