module adder(
	input [15:0] A,B;
	input [2:0] CODE;
	input cin, coe;//carry input and carry output enable
	output [15:0] C;
	output vout, cout; //signed overflow and carry output
);
reg [15:0]c;
reg vo,co;
wire [14:0] carry;


 
case(CODE)
	3'b000: //signed addition
	begin
		c[0] = A[0] ^ B[0] ^ cin;
		carry[0] = (A[0]&B[0]) | (A[0]&cin) | (B[0]&cin);
		
		c[1] = A[1] ^ B[1] ^ carry[0];
		carry[1] = (A[1]&B[1]) | (A[1]&carry[0]) | (B[1]&carry[0]);
		
		c[2] = A[2] ^ B[2] ^ carry[1];
		carry[2] = (A[2]&B[2]) | (A[2]&carry[1]) | (B[2]&carry[1]);
		
		c[1] = A[1] ^ B[1] ^ carry[0];
		carry[3] = (A[3]&B[3]) | (A[3]&carry[2]) | (B[3]&carry[2]);
		
		c[4] = A[4] ^ B[4] ^ carry[3];
		carry[4] = (A[4]&B[4]) | (A[4]&carry[3]) | (B[4]&carry[3]);
		
		c[5] = A[5] ^ B[5] ^ carry[4];
		carry[5] = (A[5]&B[5]) | (A[5]&carry[4]) | (B[5]&carry[4]);
		
		c[6] = A[6] ^ B[6] ^ carry[5];
		carry[6] = (A[6]&B[6]) | (A[6]&carry[5]) | (B[6]&carry[5]);
		
		c[7] = A[7] ^ B[7] ^ carry[6];
		carry[7] = (A[7]&B[7]) | (A[7]&carry[6]) | (B[7]&carry[6]);
		
		c[8] = A[8] ^ B[8] ^ carry[7];
		carry[8] = (A[8]&B[8]) | (A[8]&carry[7]) | (B[8]&carry[7]);
		
		c[9] = A[9] ^ B[9] ^ carry[8];
		carry[9] = (A[9]&B[9]) | (A[9]&carry[8]) | (B[9]&carry[8]);
		
		c[10] = A[10] ^ B[10] ^ carry[9];
		carry[10] = (A[10]&B[10]) | (A[10]&carry[9]) | (B[10]&carry[9]);
		
		c[11] = A[11] ^ B[11] ^ carry[10];
		carry[11] = (A[11]&B[11]) | (A[11]&carry[10]) | (B[11]&carry[10]);
		
		c[12] = A[12] ^ B[12] ^ carry[11];
		carry[12] = (A[12]&B[12]) | (A[12]&carry[11]) | (B[12]&carry[11]);
		
		c[13] = A[13] ^ B[13] ^ carry[12];
		carry[13] = (A[13]&B[13]) | (A[13]&carry[12]) | (B[13]&carry[12
		
		c[14] = A[14] ^ B[14] ^ carry[13];
		carry[14] = (A[14]&B[14]) | (A[13]&carry[13]) | (B[13]&carry[13]);
		
		c[15] = A[15] ^ B[15] ^ carry[14];
		co = (A[15]&B[15]) | (A[15]&carry[14]) | (B[15]&carry[14]);

		if(~coe)
		begin
			if(A[15]&B[15] == c[15])
				vo = 0;
			else
				vo = 1;
		end
	end

	3'b001: //unsigned addition
	begin
	end

	3'b010: //signed subtraction
	begin
	end

	3'b011: //unsigned subtraction
	begin
	end

	3'b100: //signed increment
	begin
	end

	3'b101: //signed decrement
	begin
	end
endcase

assign C = c;
assign cout = co;
assign vout = vo;
endmodule 
