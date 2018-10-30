module 16_bit_adder(
	input [15:0] A,B;
	input [2:0] CODE;
	input cin, coe;//carry input and carry output enable
	output [15:0] C;
	output vout, cout; //signed overflow and carry output
);
 reg [15:0]a,b,c;
 reg i,oe,vo,co;
 
 case(CODE)
	3'b000:
	3'b001:
	3'b010:
	3'b011:
	3'b100:
	3'b101:
	3'b110:
	3'b111:
 endcase 