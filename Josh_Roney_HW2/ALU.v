`include "adder.v"

module ALU(
	input [15:0] A,B,
	input [4:0] alu_code,
	output [15:0] C,
	output overflow
);
reg [15:0] a, b;
wire [15:0] c;
wire of;
reg [3:0] code;
reg cout,cin,coe;
integer shift;

adder b (a, b, code, cin, coe, c, of, cout);

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
		
		C = c;
		overflow = of;
		
	end
	5'b00001://unsigned addition
	begin
		code = 3'b001;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		C = c;
		overflow = of;
	end
	5'b00010://signed subtraction
	begin
		code = 3'b010;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		C = c;
		overflow = of;
	end
	5'b00011://unsigned subtraction
	begin
		code = 3'b011;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		C = c;
		overflow = of;
	end
	5'b00100://signed increment
	begin
		code = 3'b100;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		C = c;
		overflow = of;
	end
	5'b00101://signed decrement
	begin
		code = 3'b101;
		a = A;
		b = B;
		cin = 0;
		coe = 0;
		
		C = c;
		overflow = of;
	end
	
	//Logic Operations
	5'b01000://A AND B
	begin
		C[0] = A[0] & B[0];
		C[1] = A[1] & B[1];
		C[2] = A[2] & B[2];
		C[3] = A[3] & B[3];
		C[4] = A[4] & B[4];
		C[5] = A[5] & B[5];
		C[6] = A[6] & B[6];
		C[7] = A[7] & B[7];
		C[8] = A[8] & B[8];
		C[9] = A[9] & B[9];
		C[10] = A[10] & B[10];
		C[11] = A[11] & B[11];
		C[12] = A[12] & B[12];
		C[13] = A[13] & B[13];
		C[14] = A[14] & B[14];
		C[15] = A[15] & B[15];
		
		overflow = 0;
	end
	5'b01001://A OR B
	begin
		C[0] = A[0] | B[0];
		C[1] = A[1] | B[1];
		C[2] = A[2] | B[2];
		C[3] = A[3] | B[3];
		C[4] = A[4] | B[4];
		C[5] = A[5] | B[5];
		C[6] = A[6] | B[6];
		C[7] = A[7] | B[7];
		C[8] = A[8] | B[8];
		C[9] = A[9] | B[9];
		C[10] = A[10] | B[10];
		C[11] = A[11] | B[11];
		C[12] = A[12] | B[12];
		C[13] = A[13] | B[13];
		C[14] = A[14] | B[14];
		C[15] = A[15] | B[15];
		
		overflow = 0;
	end
	5'b01010://A XOR B
	begin
		C[0] = A[0] ^ B[0];
		C[1] = A[1] ^ B[1];
		C[2] = A[2] ^ B[2];
		C[3] = A[3] ^ B[3];
		C[4] = A[4] ^ B[4];
		C[5] = A[5] ^ B[5];
		C[6] = A[6] ^ B[6];
		C[7] = A[7] ^ B[7];
		C[8] = A[8] ^ B[8];
		C[9] = A[9] ^ B[9];
		C[10] = A[10] ^ B[10];
		C[11] = A[11] ^ B[11];
		C[12] = A[12] ^ B[12];
		C[13] = A[13] ^ B[13];
		C[14] = A[14] ^ B[14];
		C[15] = A[15] ^ B[15];
		
		overflow = 0;
	end
	5'b01100://NOT A
	begin
		C = ~A;
		
		overflow = 0;
	end
	
	//Shift Operations
	5'b10000://logic shift left A by the amount B
	begin
		shift = 2*B[0] + 2*B[1] + 2*B[2] + 2*B[3];
		
		C = A << shift;
	end
	5'b10001://logic shift right A by the amount B
	begin
		shift = 2*B[0] + 2*B[1] + 2*B[2] + 2*B[3];
		
		C = A >> shift;
	end
	5'b10010://arithmetic left shift A by the amount B
	begin
		shift = 2*B[0] + 2*B[1] + 2*B[2] + 2*B[3];
		
		C = A <<< shift;
	end
	5'b10011://arithmetic shift right A by the amount B
	begin
		shift = 2*B[0] + 2*B[1] + 2*B[2] + 2*B[3];
		
		C = A >>> shift;
	end
	
	//Set condition operations
	5'b11000://A <= B
	begin
		if(A-B <= 0)
			C = 1;
		else
			C = 0;
	end
	5'b11001://A < B
	begin
		if(A-B < 0)
			C = 1;
		else
			C = 0;
	end
	5'b11010://A >= B
	begin
		if(A-B >= 0)
			C = 1;
		else
			C = 0;
	end
	5'b11011://A > B
	begin
		if(A-B > 0)
			C = 1;
		else
			C = 0;
	end
	5'b11100://A = B
	begin
		if(A-B == 0)
			C = 1;
		else
			C = 0;
	end
	5'b11101://A != B
	begin
		if(A-B == 0)
			C = 0;
		else
			C = 1;
	end
	
	default: c = 0;
endcase

endmodule
