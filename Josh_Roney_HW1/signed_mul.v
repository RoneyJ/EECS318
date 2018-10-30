//module for a signed multiplier of 5-bit inputs
//Josh Roney (jpr87)
module signed_mult(
	input [4:0] Mcand,
	input [4:0] Mplier,
	output [8:0] out
);
	reg [8:0] result;
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

		assign sign = Mcand[4] ^ Mplier[4];

		assign product = a * b;
		assign compProduct = ~product + 1'b1;

		if(sign)
			result <= {1'b1, compProduct};
		else
			result <= {1'b0, product};
	end

	assign out = result;

endmodule

//Test bench module for signed multiplier
module Test_signed();
	reg [4:0] A,B;
	wire [8:0] P;

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
	end
	signed_mult m1(A, B, P);
endmodule
		
