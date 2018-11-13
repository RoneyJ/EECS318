//ALU module for Homework Assignment 2
//
//Takes 2 16-bit inputs and one 5-bit ALU code input.
//
//Outputs a 16-bit value, C, and a 1-bit signed overflow value.
//
//Josh Roney (jpr87)

`include "adder.v"

module ALU(
	input [15:0] A,B,
	input [4:0] alu_code,
	output [15:0] C,
	output overflow
);
reg [15:0] a, b, c;
wire [15:0] d;
wire of,cout;
reg [2:0] code;
reg cin,coe,over;
integer shift;

adder ad (a, b, code, cin, coe, d, of, cout);

always @(A or B or alu_code)
case(alu_code)
	//Arithmetic operations
	5'b00000://signed addition
	begin
		code = 3'b000;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		c = d;
		over = of;
		
	end
	5'b00001://unsigned addition
	begin
		code = 3'b001;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		c = d;
		over = 0;
	end
	5'b00010://signed subtraction
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		c = d;
		over = of;
	end
	5'b00011://unsigned subtraction
	begin
		code = 3'b011;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		c = d;
		over = 0;
	end
	5'b00100://signed increment
	begin
		code = 3'b100;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		c = d;
		over = of;
	end
	5'b00101://signed decrement
	begin
		code = 3'b101;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		c = d;
		over = of;
	end
	
	//Logic Operations
	5'b01000://A AND B
	begin
		c[0] <= A[0] & B[0];
		c[1] <= A[1] & B[1];
		c[2] <= A[2] & B[2];
		c[3] <= A[3] & B[3];
		c[4] <= A[4] & B[4];
		c[5] <= A[5] & B[5];
		c[6] <= A[6] & B[6];
		c[7] <= A[7] & B[7];
		c[8] <= A[8] & B[8];
		c[9] <= A[9] & B[9];
		c[10] <= A[10] & B[10];
		c[11] <= A[11] & B[11];
		c[12] <= A[12] & B[12];
		c[13] <= A[13] & B[13];
		c[14] <= A[14] & B[14];
		c[15] <= A[15] & B[15];
		
		over = 0;
	end
	5'b01001://A OR B
	begin
		c[0] <= A[0] | B[0];
		c[1] <= A[1] | B[1];
		c[2] <= A[2] | B[2];
		c[3] <= A[3] | B[3];
		c[4] <= A[4] | B[4];
		c[5] <= A[5] | B[5];
		c[6] <= A[6] | B[6];
		c[7] <= A[7] | B[7];
		c[8] <= A[8] | B[8];
		c[9] <= A[9] | B[9];
		c[10] <= A[10] | B[10];
		c[11] <= A[11] | B[11];
		c[12] <= A[12] | B[12];
		c[13] <= A[13] | B[13];
		c[14] <= A[14] | B[14];
		c[15] <= A[15] | B[15];
		
		over = 0;
	end
	5'b01010://A XOR B
	begin
		c[0] <= A[0] ^ B[0];
		c[1] <= A[1] ^ B[1];
		c[2] <= A[2] ^ B[2];
		c[3] <= A[3] ^ B[3];
		c[4] <= A[4] ^ B[4];
		c[5] <= A[5] ^ B[5];
		c[6] <= A[6] ^ B[6];
		c[7] <= A[7] ^ B[7];
		c[8] <= A[8] ^ B[8];
		c[9] <= A[9] ^ B[9];
		c[10] <= A[10] ^ B[10];
		c[11] <= A[11] ^ B[11];
		c[12] <= A[12] ^ B[12];
		c[13] <= A[13] ^ B[13];
		c[14] <= A[14] ^ B[14];
		c[15] <= A[15] ^ B[15];
		
		over = 0;
	end
	5'b01100://NOT A
	begin
		c = ~A;
		
		over = 0;
	end
	
	//Shift Operations
	5'b10000://logic shift left A by the amount B
	begin
		c = A << B[3:0];
		over = 0;
	end
	5'b10001://logic shift right A by the amount B
	begin
		c = A >> B[3:0];
		over = 0;
	end
	5'b10010://arithmetic left shift A by the amount B
	begin
		c = $signed(A) <<< B[3:0];
		over = 0;
	end
	5'b10011://arithmetic shift right A by the amount B
	begin
		c = $signed(A) >>> B[3:0];
		over = 0;
	end
	
	//Set condition operations
	5'b11000://A <= B
	begin
		code = 3'b011;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		if(d == 16'h0000; || d[15])
			c = 16'h0001;
		else
			c = 16'h0000;

		over = 0;
	end
	5'b11001://A < B
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		if(d[15])
			c = 16'h0001;
		else
			c = 16'h0000;

		over = 0;
	end
	5'b11010://A >= B
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		if(~d[15])
			c = 16'h0001;
		else
			c = 16'h0000;

		over = 0;
	end
	5'b11011://A > B
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		if(~d[15])
			c = 16'h0001;
		else
			c = 16'h0000;

		over = 0;
	end
	5'b11100://A = B
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		if(d == 16'h0000)
			c = 16'h0001;
		else
			c = 16'h0000;

		over = 0;
	end
	5'b11101://A != B
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		if(d == 16'h0000)
			c = 16'h0000;
		else
			c = 16'h0001;

		over = 0;
	end
	
	default:
	begin 
	c = 0;
	over = 0;
	end
endcase

assign C = c;
assign overflow = over;

endmodule

module Test_ALU;
	reg [15:0] A,B;
	reg [4:0] CODE;
	wire [15:0] C;
	wire overflow;

	initial
	begin
	//A = 0;	B = 0;	CODE = 5'b00000;

	#5 //add signed
	A = 16'h7F00;	B = 16'h0300;
	CODE = 5'b00000;

	#5 //add unsigned
	A = 16'h0001;	B = 16'h0001;
	CODE = 5'b00001;

	#5 //subtract unsigned

	#5 //subtract signed

	#5 //signed increment

	#5 //signed decrement

	#5 //A AND B

	#5 //A OR B

	#5 //A XOR B

	#5 //NOT A

	#5 //logic shift left A

	#5 //logic shift right B

	#5 //arithmetic shift left A

	#5 //arithmetic shift right A

	#5 //A <= B

	#5 //A < B

	#5 //A <= B

	#5 //A >= B

	#5 //A > B

	#5 //A = B
	CODE = 5'b11100;
	A = 16'h0705;	B = 16'h0705;
	
	#5 //A != B
	CODE = 5'b11101;
	A = 16'h0804;

	#5
	$finish;
	end

	ALU alu(A,B,CODE,C,overflow);
endmodule
