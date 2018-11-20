//ALU module for Homework Assignment 2
//
//Takes 2 16-bit inputs and one 5-bit ALU code input.
//
//Outputs a 16-bit value, C, and a 1-bit signed overflow value.
//
//Josh Roney (jpr87)

//`include "adder.v"

module ALU(A,B,alu_code,C,overflow);
input [15:0] A,B;
input [4:0] alu_code;
output [15:0] C;
output overflow;
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
		c[0] = A[0] & B[0];
		c[1] = A[1] & B[1];
		c[2] = A[2] & B[2];
		c[3] = A[3] & B[3];
		c[4] = A[4] & B[4];
		c[5] = A[5] & B[5];
		c[6] = A[6] & B[6];
		c[7] = A[7] & B[7];
		c[8] = A[8] & B[8];
		c[9] = A[9] & B[9];
		c[10] = A[10] & B[10];
		c[11] = A[11] & B[11];
		c[12] = A[12] & B[12];
		c[13] = A[13] & B[13];
		c[14] = A[14] & B[14];
		c[15] = A[15] & B[15];
		
		over = 0;
	end
	5'b01001://A OR B
	begin
		c[0] = A[0] | B[0];
		c[1] = A[1] | B[1];
		c[2] = A[2] | B[2];
		c[3] = A[3] | B[3];
		c[4] = A[4] | B[4];
		c[5] = A[5] | B[5];
		c[6] = A[6] | B[6];
		c[7] = A[7] | B[7];
		c[8] = A[8] | B[8];
		c[9] = A[9] | B[9];
		c[10] = A[10] | B[10];
		c[11] = A[11] | B[11];
		c[12] = A[12] | B[12];
		c[13] = A[13] | B[13];
		c[14] = A[14] | B[14];
		c[15] = A[15] | B[15];
		
		over = 0;
	end
	5'b01010://A XOR B
	begin
		c[0] = A[0] ^ B[0];
		c[1] = A[1] ^ B[1];
		c[2] = A[2] ^ B[2];
		c[3] = A[3] ^ B[3];
		c[4] = A[4] ^ B[4];
		c[5] = A[5] ^ B[5];
		c[6] = A[6] ^ B[6];
		c[7] = A[7] ^ B[7];
		c[8] = A[8] ^ B[8];
		c[9] = A[9] ^ B[9];
		c[10] = A[10] ^ B[10];
		c[11] = A[11] ^ B[11];
		c[12] = A[12] ^ B[12];
		c[13] = A[13] ^ B[13];
		c[14] = A[14] ^ B[14];
		c[15] = A[15] ^ B[15];
		
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
	/*5'b10010://arithmetic left shift A by the amount B
	begin
		c = $signed(A) <<< B[3:0];
		over = 0;
	end
	5'b10011://arithmetic shift right A by the amount B
	begin
		c = $signed(A) >>> B[3:0];
		over = 0;
	end*/
	
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
/*
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
endmodule*/

//16-bit adder module for use with ALU.v
//Josh Roney (jpr87)

module adder(A,B,CODE,cin,coe,C,vout,cout);
input [15:0] A,B;
input [2:0] CODE;
input cin, coe;//carry input and carry output enable (active low)
output [15:0] C;
output vout, cout; //signed overflow and carry output
reg [15:0] a, b, c, carry;
reg cn,en,vo,co;

initial
begin
	a = A;
	b = B;
	c = 0;
	co = 0;
	carry = 0;
end

always @(A or B or cin or coe or CODE)
begin
cn = cin;
en = coe;

case(CODE)
    0 : //signed addition
    begin
	a = A;
	b = B;

	c[0] = a[0] ^ b[0] ^ cn;
	carry[0] = (a[0]&b[0]) | (a[0]&cn) | (b[0]&cn);
		
	c[1] = a[1] ^ b[1] ^ carry[0];
	carry[1] = (a[1]&b[1]) | (a[1]&carry[0]) | (b[1]&carry[0]);
		
	c[2] = a[2] ^ b[2] ^ carry[1];
	carry[2] = (a[2]&b[2]) | (a[2]&carry[1]) | (b[2]&carry[1]);
		
	c[3] = a[3] ^ b[3] ^ carry[2];
	carry[3] = (a[3]&b[3]) | (a[3]&carry[2]) | (b[3]&carry[2]);
		
	c[4] = a[4] ^ b[4] ^ carry[3];
	carry[4] = (a[4]&b[4]) | (a[4]&carry[3]) | (b[4]&carry[3]);
		
	c[5] = a[5] ^ b[5] ^ carry[4];
	carry[5] = (a[5]&b[5]) | (a[5]&carry[4]) | (b[5]&carry[4]);
		
	c[6] = a[6] ^ b[6] ^ carry[5];
	carry[6] = (a[6]&b[6]) | (a[6]&carry[5]) | (b[6]&carry[5]);
		
	c[7] = a[7] ^ b[7] ^ carry[6];
	carry[7] = (a[7]&b[7]) | (a[7]&carry[6]) | (b[7]&carry[6]);
		
	c[8] = a[8] ^ b[8] ^ carry[7];
	carry[8] = (a[8]&b[8]) | (a[8]&carry[7]) | (b[8]&carry[7]);
		
	c[9] = a[9] ^ b[9] ^ carry[8];
	carry[9] = (a[9]&b[9]) | (a[9]&carry[8]) | (b[9]&carry[8]);
		
	c[10] = a[10] ^ b[10] ^ carry[9];
	carry[10] = (a[10]&b[10]) | (a[10]&carry[9]) | (b[10]&carry[9]);
		
	c[11] = a[11] ^ b[11] ^ carry[10];
	carry[11] = (a[11]&b[11]) | (a[11]&carry[10]) | (b[11]&carry[10]);
		
	c[12] = a[12] ^ b[12] ^ carry[11];
	carry[12] = (a[12]&b[12]) | (a[12]&carry[11]) | (b[12]&carry[11]);
		
	c[13] = a[13] ^ b[13] ^ carry[12];
	carry[13] = (a[13]&b[13]) | (a[13]&carry[12]) | (b[13]&carry[12]);
		
	c[14] = a[14] ^ b[14] ^ carry[13];
	carry[14] = (a[14]&b[14]) | (a[13]&carry[13]) | (b[13]&carry[13]);
		
	c[15] = a[15] ^ b[15] ^ carry[14];
	carry[15] = (a[15]&b[15]) | (a[15]&carry[14]) | (b[15]&carry[14]);
	
	if(a[15] ^ c[15] && b[15] ^ c[15])
	    vo = 1;
	else
	    vo = 0;

	if(~coe)
	    co = carry[15];
	else 
	    co = 1'bx;
    end

    1 : //unsigned addition
    begin
	a = A;
	b = B;

	c[0] = a[0] ^ b[0] ^ cn;
	carry[0] = (a[0]&b[0]) | (a[0]&cn) | (b[0]&cn);
		
	c[1] = a[1] ^ b[1] ^ carry[0];
	carry[1] = (a[1]&b[1]) | (a[1]&carry[0]) | (b[1]&carry[0]);
		
	c[2] = a[2] ^ b[2] ^ carry[1];
	carry[2] = (a[2]&b[2]) | (a[2]&carry[1]) | (b[2]&carry[1]);
		
	c[3] = a[3] ^ b[3] ^ carry[2];
	carry[3] = (a[3]&b[3]) | (a[3]&carry[2]) | (b[3]&carry[2]);
		
	c[4] = a[4] ^ b[4] ^ carry[3];
	carry[4] = (a[4]&b[4]) | (a[4]&carry[3]) | (b[4]&carry[3]);
		
	c[5] = a[5] ^ b[5] ^ carry[4];
	carry[5] = (a[5]&b[5]) | (a[5]&carry[4]) | (b[5]&carry[4]);
		
	c[6] = a[6] ^ b[6] ^ carry[5];
	carry[6] = (a[6]&b[6]) | (a[6]&carry[5]) | (b[6]&carry[5]);
		
	c[7] = a[7] ^ b[7] ^ carry[6];
	carry[7] = (a[7]&b[7]) | (a[7]&carry[6]) | (b[7]&carry[6]);
		
	c[8] = a[8] ^ b[8] ^ carry[7];
	carry[8] = (a[8]&b[8]) | (a[8]&carry[7]) | (b[8]&carry[7]);
		
	c[9] = a[9] ^ b[9] ^ carry[8];
	carry[9] = (a[9]&b[9]) | (a[9]&carry[8]) | (b[9]&carry[8]);
		
	c[10] = a[10] ^ b[10] ^ carry[9];
	carry[10] = (a[10]&b[10]) | (a[10]&carry[9]) | (b[10]&carry[9]);
		
	c[11] = a[11] ^ b[11] ^ carry[10];
	carry[11] = (a[11]&b[11]) | (a[11]&carry[10]) | (b[11]&carry[10]);
		
	c[12] = a[12] ^ b[12] ^ carry[11];
	carry[12] = (a[12]&b[12]) | (a[12]&carry[11]) | (b[12]&carry[11]);
		
	c[13] = a[13] ^ b[13] ^ carry[12];
	carry[13] = (a[13]&b[13]) | (a[13]&carry[12]) | (b[13]&carry[12]);
		
	c[14] = a[14] ^ b[14] ^ carry[13];
	carry[14] = (a[14]&b[14]) | (a[13]&carry[13]) | (b[13]&carry[13]);
		
	c[15] = a[15] ^ b[15] ^ carry[14];
	carry[15] = (a[15]&b[15]) | (a[15]&carry[14]) | (b[15]&carry[14]);

	vo = 1'b0; //unsigned operation

	if(~coe)
	    co = carry[15];
	else
	    co = 1'bx;
    end

    2 : //signed subtraction
    begin
	a = A;
	b = ~B;

	c[0] = a[0] ^ b[0] ^ cn;
	carry[0] = (a[0]&b[0]) | (a[0]&cn) | (b[0]&cn);
		
	c[1] = a[1] ^ b[1] ^ carry[0];
	carry[1] = (a[1]&b[1]) | (a[1]&carry[0]) | (b[1]&carry[0]);
		
	c[2] = a[2] ^ b[2] ^ carry[1];
	carry[2] = (a[2]&b[2]) | (a[2]&carry[1]) | (b[2]&carry[1]);
		
	c[3] = a[3] ^ b[3] ^ carry[2];
	carry[3] = (a[3]&b[3]) | (a[3]&carry[2]) | (b[3]&carry[2]);
		
	c[4] = a[4] ^ b[4] ^ carry[3];
	carry[4] = (a[4]&b[4]) | (a[4]&carry[3]) | (b[4]&carry[3]);
		
	c[5] = a[5] ^ b[5] ^ carry[4];
	carry[5] = (a[5]&b[5]) | (a[5]&carry[4]) | (b[5]&carry[4]);
		
	c[6] = a[6] ^ b[6] ^ carry[5];
	carry[6] = (a[6]&b[6]) | (a[6]&carry[5]) | (b[6]&carry[5]);
		
	c[7] = a[7] ^ b[7] ^ carry[6];
	carry[7] = (a[7]&b[7]) | (a[7]&carry[6]) | (b[7]&carry[6]);
		
	c[8] = a[8] ^ b[8] ^ carry[7];
	carry[8] = (a[8]&b[8]) | (a[8]&carry[7]) | (b[8]&carry[7]);
		
	c[9] = a[9] ^ b[9] ^ carry[8];
	carry[9] = (a[9]&b[9]) | (a[9]&carry[8]) | (b[9]&carry[8]);
		
	c[10] = a[10] ^ b[10] ^ carry[9];
	carry[10] = (a[10]&b[10]) | (a[10]&carry[9]) | (b[10]&carry[9]);
		
	c[11] = a[11] ^ b[11] ^ carry[10];
	carry[11] = (a[11]&b[11]) | (a[11]&carry[10]) | (b[11]&carry[10]);
		
	c[12] = a[12] ^ b[12] ^ carry[11];
	carry[12] = (a[12]&b[12]) | (a[12]&carry[11]) | (b[12]&carry[11]);
		
	c[13] = a[13] ^ b[13] ^ carry[12];
	carry[13] = (a[13]&b[13]) | (a[13]&carry[12]) | (b[13]&carry[12]);
		
	c[14] = a[14] ^ b[14] ^ carry[13];
	carry[14] = (a[14]&b[14]) | (a[13]&carry[13]) | (b[13]&carry[13]);
		
	c[15] = a[15] ^ b[15] ^ carry[14];
	carry[15] = (a[15]&b[15]) | (a[15]&carry[14]) | (b[15]&carry[14]);

	if(a[15] ^ c[15] && b[15] ^ c[15])
	    vo = 1;
	else
	    vo = 0;

	if(~coe)
	    co = carry[15];
	else
	    co = 1'bx;
    end

    3 : //unsigned subtraction
    begin
	a = A;
	b = ~B;

	c[0] = a[0] ^ b[0] ^ cn;
	carry[0] = (a[0]&b[0]) | (a[0]&cn) | (b[0]&cn);
		
	c[1] = a[1] ^ b[1] ^ carry[0];
	carry[1] = (a[1]&b[1]) | (a[1]&carry[0]) | (b[1]&carry[0]);
		
	c[2] = a[2] ^ b[2] ^ carry[1];
	carry[2] = (a[2]&b[2]) | (a[2]&carry[1]) | (b[2]&carry[1]);
		
	c[3] = a[3] ^ b[3] ^ carry[2];
	carry[3] = (a[3]&b[3]) | (a[3]&carry[2]) | (b[3]&carry[2]);
		
	c[4] = a[4] ^ b[4] ^ carry[3];
	carry[4] = (a[4]&b[4]) | (a[4]&carry[3]) | (b[4]&carry[3]);
		
	c[5] = a[5] ^ b[5] ^ carry[4];
	carry[5] = (a[5]&b[5]) | (a[5]&carry[4]) | (b[5]&carry[4]);
		
	c[6] = a[6] ^ b[6] ^ carry[5];
	carry[6] = (a[6]&b[6]) | (a[6]&carry[5]) | (b[6]&carry[5]);
		
	c[7] = a[7] ^ b[7] ^ carry[6];
	carry[7] = (a[7]&b[7]) | (a[7]&carry[6]) | (b[7]&carry[6]);
		
	c[8] = a[8] ^ b[8] ^ carry[7];
	carry[8] = (a[8]&b[8]) | (a[8]&carry[7]) | (b[8]&carry[7]);
		
	c[9] = a[9] ^ b[9] ^ carry[8];
	carry[9] = (a[9]&b[9]) | (a[9]&carry[8]) | (b[9]&carry[8]);
		
	c[10] = a[10] ^ b[10] ^ carry[9];
	carry[10] = (a[10]&b[10]) | (a[10]&carry[9]) | (b[10]&carry[9]);
		
	c[11] = a[11] ^ b[11] ^ carry[10];
	carry[11] = (a[11]&b[11]) | (a[11]&carry[10]) | (b[11]&carry[10]);
		
	c[12] = a[12] ^ b[12] ^ carry[11];
	carry[12] = (a[12]&b[12]) | (a[12]&carry[11]) | (b[12]&carry[11]);
		
	c[13] = a[13] ^ b[13] ^ carry[12];
	carry[13] = (a[13]&b[13]) | (a[13]&carry[12]) | (b[13]&carry[12]);
		
	c[14] = a[14] ^ b[14] ^ carry[13];
	carry[14] = (a[14]&b[14]) | (a[13]&carry[13]) | (b[13]&carry[13]);
		
	c[15] = a[15] ^ b[15] ^ carry[14];
	carry[15] = (a[15]&b[15]) | (a[15]&carry[14]) | (b[15]&carry[14]);

	vo = 1'b0; //unsigned operation

	if(~coe)
	    co = carry[15];
	else
	    co = 1'bx;
    end

    4 : //signed increment
    begin
	c = A + 1'b1;

	if(~A[15] && c[15])
	    vo = 1;
	else
	    vo = 0;

	if(~coe)
	    co = 0;
	else
	    co = 1'bx;
    end

    5 : //signed decrement
    begin
	c = A - 1'b1;

	if(A[15] && ~c[15])
	    vo = 1;
	else
	    vo = 0;

	if(~coe)
	    co = 0;
	else
	    co = 1'bx;
    end
endcase
end

assign C = c;
assign cout = co;
assign vout = vo;
endmodule

/*module Test_adder;
reg signed [15:0] A, B;
reg [2:0] CODE;
reg cin, coe;
wire vout, cout;
wire [15:0]C;

adder a(A, B, CODE, cin, coe, C, vout, cout);

initial
begin
CODE = 3'b000;
cin = 0;	coe = 0;
A = 16'h0000;	B = 16'h0001;

#1 $display("A=%d B=%d Ci=%d = Sum %d %d %d", A, B, cin, C, vout, cout);

#10
cin = 1;	coe = 0;
A = 16'h000F;	B = 16'h000F;

#1 $display("A=%d B=%d Ci=%d = Sum %d %d %d", A, B, cin, C, vout, cout);

#10
cin = 0;	coe = 0;
A = 16'h7F00;	B = 16'h0300;

#1 $display("A=%d B=%d Ci=%d = Sum %d %d %d", A, B, cin, C, vout, cout);

#10
cin = 1;	coe = 0;
A = 16'hFF00;	B = 16'h0100;

#1 $display("A=%d B=%d Ci=%d = Sum %d %d %d", A, B, cin, C, vout, cout);

#10
cin = 1;	coe = 1;
A = 16'h8100;	B = 16'h8000;

#1 $display("A=%d B=%d Ci=%d = Sum %d %d %d", A, B, cin, C, vout, cout);

#5 $finish;
end
endmodule*/ 
