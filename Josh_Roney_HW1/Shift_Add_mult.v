//module for an n-bit shift-add multiplier
//Josh Roney(jpr87)
module Shift_add_mult(clk, A, B, R, start, done);
	parameter M = 4;
	input clk,start;
	input [M-1:0] A, B;
	output [M*2-1:0] R;
	output done;
	
	reg [M-1:0] X, P;
	reg c; // carry out flip-flop
	reg fin;
	wire [M-1:0] w1, w2;
	wire w3;
	wire [M*2-1:0] w4;
	integer i;

	initial
	begin
		c = 1'b0;
		P = 0;
		X = 0;
		fin = 0;
		i = 0;
	end

	always @(posedge clk)
	begin
		if(start)
		begin
		X = B;
		P = 0;
		i = 0; 
		fin = 0;
		end
	end

	NA #(M) n(clk, A, X[0], w1); // AND every bit of A with the LSB of X
	N_bit_adder #(M) ad(clk, w1[M-1:0], P[M-1:0], c, w2[M-1:0], w3); // Add result to P
	N_shift #(M*2) sh1(clk, {w2,X}, w3, w4); // Shift P and X registers

	genvar j;
	always @(negedge clk)
	begin
	if(!fin)
	begin
		X = w4[M-1:0];
		P = w4[M*2-1:M];

		i = i + 1;
	end

	if(i == M)
	fin = 1;
		
	end

	

	assign R = {P[M-1:0],  X[M-1:0]}; // assign output as P register
	assign done = fin;
endmodule

//Test bench module
module Test_shift_add;
	reg [3:0] A, B;
	reg clk,start; 
	wire [7:0] P1;
	wire done;

	initial
	begin
	clk = 1'b0;	start = 1;
	A = 4'b0010;    B = 4'b0100;
	#6 start = 0;

	#38 start = 1;
	A = 4'b1111;    B = 4'b0011;
	#3 start = 0;
	
	#40 $finish();
	end

	always
	begin
		#5 clk = !clk;
	end

	Shift_add_mult #4 m1(clk, A, B, P1, start, done);

endmodule

//n-bit adder module
module N_bit_adder(enable, a, b, cin, out, cout);
	parameter N=16;
	input [N-1:0] a,b;
	input enable, cin;
   	output [N-1:0] out;
   	output  cout;
	reg [N-1:0] z, carry;

  	genvar i;
   	generate for(i=0;i<N;i=i+1)
        begin
	always @*
	begin
		if(enable)
		begin
   	   		if(i==0)
			begin
				z[i] = a[i]^b[i]^cin;
				carry[i] = (a[i]&b[i])|(a[i]&cin)|(b[i]&cin);
			end
  	   		else
			begin
				z[i] = a[i]^b[i]^carry[i-1];
				carry[i] = (a[i]&b[i])|(a[i]&carry[i-1])|(b[i]&carry[i-1]);
			end
     		end
	end
	end

	assign out = z;
  	assign cout = carry[N-1];
   	endgenerate
endmodule 

// n-bit and module
// Ands every bit of an n-bit input with a one-bit input
// Assigns the outcome to the output
module NA(enable, a, b, out);
	parameter M = 8;
	input [M-1:0] a;
	input enable, b;
	output [M-1:0] out;
	reg [M-1:0] z;

	genvar i;
	generate for(i=0;i<M;i=i+1)
	begin
	always @*
	begin
		if(enable)
		z[i] <= a[i] & b;
	end
	end
	endgenerate

	assign out = z;
endmodule

//n-bit shift register
//shifts an n-bit register left by one bit
module N_shift(enable, d, carry, q);
	parameter M = 4;
	input [M-1:0] d;
	input enable, carry;
	output [M-1:0] q;
	reg [M-1:0] z;

	genvar i;
	generate for(i=0;i<M;i=i+1)
	begin
	always @*
	begin
		if(enable)
		begin
			if(i==M-1)
			z[i] = carry;
		
			else
			z[i] = d[i+1];
		end
	end
	end
	endgenerate

	assign q = z;
endmodule
