//Test module for ALU.v
//Josh Roney(jpr87)

`include "ALU.v"

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
	B = 16'h2a75;	CODE = 5'b10011;

	#2 $display("A=%h \t B=%h \t CODE=%b \t C=%h \t overflow=%b", A, B, CODE, C, overflow);

	#3 //arithmetic shift right A
	A = 16'h2a75;

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
