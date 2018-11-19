//Handshake checker module for Request/Acknowledge signals
//EECS 318 HW2
//Josh Roney (jpr87)

module Handshake(
	input R,A,RESET,clk,	//Request, Acknowledge, asynchronous RESET
	output E		//Error
);

	reg r,a,e;
	reg [2:0] State;
	localparam [2:0]
		S0 = 3'b000,
		S1 = 3'b001,
		S2 = 3'b010,
		S3 = 3'b011,
		S4 = 3'b100;	//Error State

	initial
	begin
		e = 0;
		State = S0;
	end

	always @(posedge clk or RESET)
	begin

		if(RESET)
		begin
			State = S0;
			e= 0;
		end
		else
		case(State)
			S0:
			begin
			if(R && ~A)
				State = S1;
			else if(a)
				State = S4;
			end

			S1:
			begin
			if(R && A)
				State = S2;
			else if(~R && ~A)
				State = S4;
			end

			S2:
			begin
			if(~R && A)
				State = S3;
			if(R && ~A)
				State = S4;
			end

			S3:
			begin
			if(~R && ~A)
				State = S0;
			else if(R && A)
				State = S4;
			end

			S4:
			begin
			//remain here until RESET
			e = 1;
			end
		endcase
	end

	assign E = e;
endmodule

//Test module for handshake
module testHandshake();
	reg R,A,clk,RESET;
	wire E;

	initial
	begin
	R = 0;	A = 0;	RESET = 0;
	clk = 0;

	#3 R = 1;

	#10 A = 1;

	#10 R = 0;
	
	#10 A = 0;

	#20 A = 1;

	#10 R = 1;

	#3 RESET = 1;

	#5 $finish();
	end

	always
		#5 clk = ~clk;

	Handshake h (R,A,RESET,clk,E);
endmodule
