module adder(
	input [15:0] A,B;
	input [2:0] CODE;
	input cin, coe;//carry input and carry output enable
	output [15:0] C;
	output vout, cout; //signed overflow and carry output
);
reg [15:0]a,b,c;
reg i,oe,vo,co;
wire [14:0] carry;


 
case(CODE)
	3'b000: //signed addition
	begin
		c[0] = a[0] ^ b[0] ^ cin;
		carry[0] = (a[0]&b[0]) | (a[0]&cin) | (b[0]&cin);
		
		c[1] = a[1] ^ b[1] ^ carry[0];
		carry[1] = (a[1]&b[1]) | (a[1]&carry[0]) | (b[1]&carry[0]);
		
		c[2] = a[2] ^ b[2] ^ carry[1];
		carry[2] = (a[2]&b[2]) | (a[2]&carry[1]) | (b[2]&carry[1]);
		
		c[1] = a[1] ^ b[1] ^ carry[0];
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
		carry[13] = (a[13]&b[13]) | (a[13]&carry[12]) | (b[13]&carry[12
		
		c[14] = a[14] ^ b[14] ^ carry[13];
		carry[14] = (a[14]&b[14]) | (a[13]&carry[13]) | (b[13]&carry[13]);
		
		c[15] = a[15] ^ b[15] ^ carry[14];
		co = (a[15]&b[15]) | (a[15]&carry[14]) | (b[15]&carry[14]);

		if(a[15]&b[15] == c[15])
			vo = 0;
		else
			vo = 1;
	
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
assign vo = cout;
endmodule 
