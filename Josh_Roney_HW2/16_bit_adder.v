module adder(
	input [15:0] A,B,
	input [2:0] CODE,
	input cin, coe,//carry input and carry output enable
	output [15:0] C,
	output vout, cout //signed overflow and carry output
);
reg [15:0]a,b,c;
reg i,oe,vo,co;
wire [15:0] carry;


 
case(CODE)
	3'b000: //signed addition
	begin

	genvar i;
	generate for(i=0; i<16; i=i+1)
	begin
		if(i==0)
		begin
			c[i] = a[i] ^ b[i] ^ cin;
			carry[i] = (a[i]&b[i]) | (a[i]&cin) | (b[i]&cin);
		end

		else if(i==15)
		begin
			c[i] = a[i] ^ b[i] ^ carry[i-1];
			co = (a[i]&b[i]) | (a[i]&carry[i-1]) | (b[i]&carry[i-1]);
		end

		else
		begin
			c[i] = a[i] ^ b[i] ^ carry[i-1];
			carry[i] = (a[i]&b[i]) | (a[i]&carry[i-1]) | (b[i]&carry[i-1]);
		end
	end
	endgenerate

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
-138
-86
-52
endcase

assign cout = co;
assign vo = cout;
endmodule 
