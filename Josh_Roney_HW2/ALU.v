module ALU(
	input [15:0] A,B;
	input [4:0] alu_code;
	output [15:0] C;
	output overflow;
);
reg [15:0] c;
reg of;

case(alu_code)
	//Arithmetic operations
	5'b00000://signed addition
	begin
	end
	5'b00001://unsigned addition
	begin
	end
	5'b00010://signed subtraction
	begin
	end
	5'b00011://unsigned subtraction
	begin
	end
	5'b00100://signed increment
	begin
	end
	5'b00101://signed decrement
	begin
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
