//module for a signed multiplier of 5-bit inputs
//Josh Roney (jpr87)
module signed_mult(
	input [4:0] Mcand,
	input [4:0] Mplier,
	input start;
	output [9:0] out
);
	reg [8:0] result;
	reg [4:0] a, b;
	reg [3:0] c;
	reg [8:0] p1, p2, p3, p4, p5;
	reg sign;
	wire [8:0] w1;
	
	initial
	begin
		result = 0;
		a = 0;
		b = 0;
		p1 = 0;
		p2 = 0;
		p3 = 0;
		p4 = 0;
		p5 = 0;
	end
	
	always @(posedge start)
	begin
		if(Mplier[4])
		begin
			a = ~Mcand + 1'b1;
			b = ~Mplier + 1'b1;
		end
		else
		begin
			a = Mcand;
			b = Mplier;
		end
	end
	
	Add_9 a1(p1, p2, w1);
	Add_9 a2(w1, p3, w2);
	Add_9 a3(w2, p4, w3);
	Add_9 a4(w3, p5, result);

	always @*
	begin
		p1 = {a[4], a[4], a[4], a[4], a[4]&b[0], a[3]&b[0], a[2]&b[0], a[1]&b[0], a[0]&b[0]};
		
		p2 = {a[4], a[4], a[4], a[4]&b[1], a[3]&b[1], a[2]&b[1], a[1]&b[1], a[0]&b[1], 1'b0};
		
		p3 = {a[4], a[4], a[4]&b[2], a[3]&b[2], a[2]&b[2], a[1]&b[2], a[0]&b[2], 2'b00};
		
		p4 = {a[4], a[4]&b[3], a[3]&b[3], a[2]&b[3], a[1]&b[3], a[0]&b[3], 3'b000};
		
		p5 = {a[4]&b[4], a[3]&b[4], a[2]&b[4], a[1]&b[4], a[0]&b[4], 4'b0000};
	end
	

	assign out = {Mcand[4]^Mplier[4], result};

endmodule

//Test bench module for signed multiplier
module Test_signed();
	reg [4:0] A,B;
	reg start;
	wire [9:0] P;

	initial
	begin
	//-10 * 4		
	start = 1;
	A = 5'b10110;	B = 5'b00100;
	
	#5 start = 0;

	#5
	// 11 * -3
	A = 5'b01011;	B = 5'b11101;
	start = 1;
	
	#5 start = 0;' 

	#5
	// -10 * -11
	A = 5'b10110;	B = 5'b10101;
	start = 1;
	
	#5 start = 0;
	
	#10 $finish();
	end
	
	signed_mult m1(A, B, start, P);
endmodule

// 2-input, 9-bit adder		
module Add_9(in1, in2, out)
	input [8:0] in1, in2;
	output [8:0] out;
	reg [8:0] z; 
	reg [9:0] carry;
	
	initial
	begin
		z = 0;
		carry = 0;
	end
	
	genvar i;
	generate for(i=0;i<9;i=i+1)
	begin
		z[i] = in1[i] ^ in2[i] ^ carry[i];
		carry[i+1] = (in1[i]&in2[i]) | (in1[i]&carry[i]) | (in2[i]&carry[i]);
	end
	endgenerate
	
	assign out = z;
endmodule
