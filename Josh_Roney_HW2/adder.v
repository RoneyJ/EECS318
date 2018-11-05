module adder(
	input [15:0] A,B,
	input [2:0] CODE,
	input cin, coe,//carry input and carry output enable (active low)
	output [15:0] C,
	output vout, cout //signed overflow and carry output
);
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

module Test_adder;
reg [15:0] A, B;
reg [2:0] CODE;
reg cin, coe;
wire vout, cout;
wire [15:0]C;

adder a(A, B, CODE, cin, coe, C, vout, cout);

initial
begin
CODE = 3'b100;
cin = 1;	coe = 0;
A = 16'h0000;	B = 16'h0001;

#5 $display("%b %b %b", C, vout, cout);

#10
cin = 1;	coe = 0;
A = 16'h0F00;	B = 16'h0F00;

#5 $display("%b %b %b", C, vout, cout);

#10
cin = 1;	coe = 0;
A = 16'h7FFF;	B = 16'h0300;

#5 $display("%b %b %b", C, vout, cout);

#10
cin = 1;	coe = 0;
A = 16'hFF00;	B = 16'h0100;

#5 $display("%b %b %b", C, vout, cout);

#10
cin = 1;	coe = 1;
A = 16'h8100;	B = 16'h8000;

#5 $display("%b %b %b", C, vout, cout);

#5 $finish;
end
endmodule 
