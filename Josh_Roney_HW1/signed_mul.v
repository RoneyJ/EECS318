//module for a signed multiplier of 5-bit inputs
//Josh Roney (jpr87)
module signed_mult(
	input [4:0] Mcand,
	input [4:0] Mplier,
	output [9:0] out
);
	reg [9:0] result;
	reg [7:0] product, compProduct;
	reg [3:0] a,b;
	reg sign;

	always@*
	begin
		if(Mcand[4] == 1'b1)
			a <= {~Mcand[3:0] + 1'b1};
		else
			a <= {Mcand[3:0]};

		if(Mplier[4] == 1'b1)
			b <= {~Mplier[3:0] + 1'b1};
		else
			b <= {Mplier[3:0]};

		sign = Mcand[4] ^ Mplier[4];

		product = a * b;
		compProduct = ~product + 1'b1;

		if(sign)
			result <= {2'b11, compProduct};
		else
			result <= {2'b00, product};
	end

	assign out = result;

endmodule

//Test bench module for signed multiplier
module Test_signed();
	reg [4:0] A,B;
	wire [9:0] P;

	initial
	begin
	//-10 * 4
	A = 5'b10110;	B = 5'b00100;

	#20
	// 11 * -3
	A = 5'b01011;	B = 5'b11101;

	#20
	// -10 * -11
	A = 5'b10110;	B = 5'b10101;
	
	#20 $finish();
	end
	signed_mult m1(A, B, P);
endmodule
		
