entity signedmult is
	port(mcand,mplier : in bit_vector (4 downto 0);
		  product : out bit_vector (9 downto 0)
	);
end signedmult;
architecture mult of signedmult is
	component add9bit is
		port(x,y : bit_vector (8 downto 0);
		  z : bit_vector (8 downto 0)
		);
	end component;

	signal a,b : bit_vector (4 downto 0);
	signal p1,p2,p3,p4,p5 : bit_vector (8 downto 0);
	signal c1,c2,c3,c4 : bit_vector (8 downto 0);
	
	begin
	process (mcand, mplier)
	begin
	a(0) <= (mcand(0) and ~mplier(4)) or (~mcand(0) and mplier(4));
	a(1) <= (mcand(1) and ~mplier(4)) or (~mcand(1) and mplier(4));
	a(2) <= (mcand(2) and ~mplier(4)) or (~mcand(2) and mplier(4));
	a(3) <= (mcand(3) and ~mplier(4)) or (~mcand(3) and mplier(4));
	a(4) <= (mcand(4) and ~mplier(4)) or (~mcand(4) and mplier(4));
	
	b(0) <= (mplier(0) and ~mplier(4)) or (~mplier(0) and mplier(4));
	b(1) <= (mplier(1) and ~mplier(4)) or (~mplier(1) and mplier(4));
	b(2) <= (mplier(2) and ~mplier(4)) or (~mplier(2) and mplier(4));
	b(3) <= (mplier(3) and ~mplier(4)) or (~mplier(3) and mplier(4));
	b(4) <= (mplier(4) and ~mplier(4)) or (~mplier(4) and mplier(4));
	
	a <= a + (1'b1 and Mplier[4]);
	b <= b + (1'b1 and Mplier[4]);
	
	p1 <= (a[4] and b[0]) & (a[4] and b[0]) & (a[4] and b[0]) & (a[4] and b[0]) & (a[4] and b[0]) & (a[3] and b[0]) & (a[2] and b[0]) & (a[1] and b[0]) & (a[0] and b[0]);
	p2 <= (a[4] and b[1]) & (a[4] and b[1]) & (a[4] and b[1]) & (a[4] and b[1]) & (a[3] and b[0]) & (a[2] and b[0]) & (a[1] and b[0]) & (a[0] and b[0]) & '0';
	p3 <= (a[4] and b[1]) & (a[4] and b[1]) & (a[4] and b[1]) & (a[3] and b[1]) & (a[2] and b[0]) & (a[1] and b[0]) & (a[0] and b[0]) & "00";
	p4 <= (a[4] and b[1]) & (a[4] and b[1]) & (a[3] and b[1]) & (a[2] and b[1]) & (a[1] and b[0]) & (a[0] and b[0]) & "000";
	p5 <= (a[4] and b[1]) & (a[3] and b[1]) & (a[2] and b[1]) & (a[1] and b[1]) & (a[0] and b[0]) & "0000";
	
	add1 : add9bit port map(x => p1, y => p2, z => c1);
	add2 : add9bit port map(x => c1, y => p3, z => c2);
	add3 : add9bit port map(x => c2, y => p4, z => c3);
	add4 : add9bit port map(x => c3, y => p5, z => c4);
	
	product => (Mcand[4] xor Mplier[4]) & c4;
	end process;
	
end mult;

entity add9bit is
	port(x,y : bit_vector (8 downto 0);
		  z : bit_vector (8 downto 0)
	);
end add9bit;
architecture add of add9bit is
	signal c : bit_vector (7 downto 0);
	
	begin
	z(0) = x(0) xor y(0) xor '0';
	c(0) = (x(0) and y(0) or(x(0) and '0') or (y(0) and '0');
	
	z(1) = x(1) xor y(1) xor c(0);
	c(0) = (x(1) and y(1) or(x(1)) and c(0)) or (y(1) and c(0));
	
	z(2) = x(2) xor y(2) xor c(1);
	c(0) = (x(2) and y(2)) or(x(2) and c(1)) or (y(2) and c(1));
	
	z(3) = x(3) xor y(3) xor c(2);
	c(0) = (x(3) and y(3) or(x(3)) and c(2)) or (y(3) and c(2));
	
	z(4) = x(4) xor y(4) xor c(3);
	c(0) = (x(4) and y(4) or(x(4)) and c(3)) or (y(4) and c(3));
	
	z(5) = x(5) xor y(5) xor c(4);
	c(0) = (x(5) and y(5) or(x(5)) and c(4)) or (y(5) and c(4));
	
	z(6) = x(6) xor y(6) xor c(5);
	c(0) = (x(6) and y(6) or(x(6)) and c(5)) or (y(6) and c(5));
	
	z(7) = x(7) xor y(7) xor c(6);
	c(0) = (x(7) and y(7) or(x(7)) and c(6)) or (y(7) and c(6));
	
	z(8) = x(8) xor y(8) xor c(7);
	c(0) = (x(8) and y(8) or(x(8)) and c(7)) or (y(8) and c(7));
end add;

// 2-input, 9-bit adder		
module Add_9(in1, in2, out);
	input [8:0] in1, in2;
	output [8:0] out;
	reg [8:0] z; 
	reg [9:0] carry;
	
	initial
	begin
		z = 0;
		carry = 0;
	end
	
	genvar i;
	generate for(i=0;i<9;i=i+1)
	begin
	always @*
	begin
		z[i] <= in1[i]^in2[i]^carry[i];
		carry[i+1] <= (in1[i]&in2[i]) | (in1[i]&carry[i]) | (in2[i]&carry[i]);
	end
	end
	endgenerate
	
	assign out = z;
endmodule