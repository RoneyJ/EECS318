//ALU module for Homework Assignment 2
//
//Takes 2 16-bit inputs and one 5-bit ALU code input.
//
//Outputs a 16-bit value, C, and a 1-bit signed overflow value.
//
//Josh Roney (jpr87)

//`include "adder.v"

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
		
	#1	c = d;
		over = of;
		
	end
	5'b00001://unsigned addition
	begin
		code = 3'b001;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
	#1	c = d;
		over = 0;
	end
	5'b00010://signed subtraction
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 1;
		coe = 0;
		
	#1	c = d;
		over = of;
	end
	5'b00011://unsigned subtraction
	begin
		code = 3'b011;
		a = A;
		b = B;
		cin = 1;
		coe = 0;
		
	#1	c = d;
		over = 0;
	end
	5'b00100://signed increment
	begin
		code = 3'b100;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
	#1	c = d;
		over = of;
	end
	5'b00101://signed decrement
	begin
		code = 3'b101;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
	#1	c = d;
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
		code = 3'b010;
		a = A;
		b = B;
		cin = 1;
		coe = 0;
		
	#1	if(d == 16'h0000 || d[15])
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
		cin = 1;
		coe = 0;
		
	#1	if(d[15])
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
		cin = 1;
		coe = 0;
		
	#1	if(~d[15])
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
		cin = 1;
		coe = 0;
		
	#1	if(~d[15])
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
		cin = 1;
		coe = 0;
		
	#1	if(d == 16'h0000)
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
		cin = 1;
		coe = 0;
		
	#1	if(d == 16'h0000)
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
	A = 0;	B = 0;	CODE = 5'b00000;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", A, B, CODE, C, overflow);

	#3 //add signed
	A = 16'h8534;	B = 16'h7546;
	CODE = 5'b00000;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, $signed(C), overflow);

	#3 //add unsigned
	CODE = 5'b00001;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", A, B, CODE, C, overflow);

	#3 //subtract signed
	CODE = 5'b00010;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, $signed(C), overflow);

	#3 //subtract unsigned
	CODE = 5'b00011;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", A, B, CODE, C, overflow);

	#3 //signed increment
	CODE = 5'b00100;	A = 16'h7fff;

	#2 $display("A=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), CODE, $signed(C), overflow);

	#3 //signed decrement
	CODE = 5'b00101;	A = 16'h8000;

	#2 $display("A=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), CODE, $signed(C), overflow);

	#3 //A AND B
	A = 16'h5555;	B = 16'h6666;
	CODE = 5'b01000;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //A OR B
	CODE = 5'b01001;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //A XOR B
	CODE = 5'b01010;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //NOT A
	CODE = 5'b01100;

	#2 $display("A=%h \t CODE=%b \t C=%h \t overflow=%b", A, CODE, C, overflow);

	#3 //logic shift left A
	A = 16'haaaa;
	B = 16'h2a74;	CODE = 5'b10000;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //logic shift right A
	B = 16'h2a73;	CODE = 5'b10001;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //arithmetic shift left A
	B = 16'h2a78;	CODE = 5'b10010;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //arithmetic shift right A
	B = 16'h2a7b;	CODE = 5'b10011;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //A <= B
	A = 16'h0705;	B = 16'h0705;
	CODE = 5'b11000;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, C, overflow);

	#3 //A < B
	A = 16'h0621;	CODE = 5'b11001;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, C, overflow);

	#3 //A >= B
	A = 16'h7301;	CODE = 5'b11010;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, C, overflow);

	#3 //A > B
	A = 16'h01bc;	CODE = 5'b11011;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, C, overflow);

	#3 //A = B
	CODE = 5'b11100;	A = 16'h0705;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, C, overflow);
	
	#3 //A != B
	CODE = 5'b11101;

	#2 $display("A=%d \t B=%d \t CODE=%b \t C=%d \t overflow=%b", $signed(A), $signed(B), CODE, C, overflow);

	#5
	$finish;
	end

	ALU alu(A,B,CODE,C,overflow);
endmodule
