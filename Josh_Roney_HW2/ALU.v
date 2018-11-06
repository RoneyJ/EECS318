module ALU(
	input [15:0] A,B;
	input [4:0] alu_code;
	output [15:0] C;
	output overflow;
);
reg [15:0] a, b;
wire [15:0] c;
wire of;
reg [3:0] code;
reg cout,cin,coe;

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
	end
	5'b01001://A OR B
	begin
	end
	5'b01010://A XOR B
	begin
	end
	5'b01100://NOT A
	begin
	end
	//Shift Operations
	5'b10000://logic shift left A by the amount B
	begin
	end
	5'b10001://logic shift right A by the amount B
	begin
	end
	5'b10010://arithmetic left shift A by the amount B
	begin
	end
	5'b10011://arithmetic shift right A by the amount B
	begin
	end
	//Set condition operations
	5'b11000://A <= B
	begin
	end
	5'b11001://A < B
	begin
	end
	5'b11010://A >= B
	begin
	end
	5'b11011://A > B
	begin
	end
	5'b11100://A = B
	begin
	end
	5'b11101://A != B
	begin
	end
	
	default: c = 0;
endcase

assign C = c;
assign overflow = of;

endmodule
