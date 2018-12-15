--signed multipler entity for HW 4
--Josh Roney (jpr87)
entity signedmult is
	port(mcand,mplier : in bit_vector (4 downto 0);
	     product : out bit_vector (9 downto 0)
	);
end signedmult;
architecture mult of signedmult is
	component add9bit is
		port(x,y : in bit_vector (8 downto 0);
		     z : out bit_vector (8 downto 0)
		);
	end component;

	signal a,b : bit_vector (4 downto 0);
	signal p1,p2,p3,p4,p5 : bit_vector (8 downto 0);
	signal c1,c2,c3,c4 : bit_vector (8 downto 0);
	signal c5,c6 : bit_vector (3 downto 0);
	
	begin
	add1 : add9bit port map(x => p1, y => p2, z => c1);
	add2 : add9bit port map(x => c1, y => p3, z => c2);
	add3 : add9bit port map(x => c2, y => p4, z => c3);
	add4 : add9bit port map(x => c3, y => p5, z => c4);

	a(0) <= ((mcand(0) and (not mplier(4))) or ((not mcand(0)) and mplier(4))) xor mplier(4);
	c5(0) <= ((mcand(0) and (not mplier(4))) or ((not mcand(0)) and mplier(4))) and mplier(4);

	a(1) <= ((mcand(1) and (not mplier(4))) or ((not mcand(1)) and mplier(4))) xor c5(0);
	c5(1) <= ((mcand(1) and (not mplier(4))) or ((not mcand(1)) and mplier(4))) and c5(0);

	a(2) <= ((mcand(2) and (not mplier(4))) or ((not mcand(2)) and mplier(4))) xor c5(1);
	c5(2) <= ((mcand(2) and (not mplier(4))) or ((not mcand(2)) and mplier(4))) and c5(1);

	a(3) <= ((mcand(3) and (not mplier(4))) or ((not mcand(3)) and mplier(4))) xor c5(2);
	c5(3) <= ((mcand(3) and (not mplier(4))) or ((not mcand(3)) and mplier(4))) and c5(2);

	a(4) <= ((mcand(4) and (not mplier(4))) or ((not mcand(4)) and mplier(4))) xor c5(3);

	
	b(0) <= ((mplier(0) and (not mplier(4))) or ((not mplier(0)) and mplier(4))) xor mplier(4);
	c6(0) <= ((mplier(0) and (not mplier(4))) or ((not mplier(0)) and mplier(4))) and mplier(4);

	b(1) <= ((mplier(1) and (not mplier(4))) or ((not mplier(1)) and mplier(4))) xor c6(0);
	c6(1) <= ((mplier(1) and (not mplier(4))) or ((not mplier(1)) and mplier(4))) and c6(0);

	b(2) <= ((mplier(2) and (not mplier(4))) or ((not mplier(2)) and mplier(4))) xor c6(1);
	c6(2) <= ((mplier(2) and (not mplier(4))) or ((not mplier(2)) and mplier(4))) and c6(1);

	b(3) <= ((mplier(3) and (not mplier(4))) or ((not mplier(3)) and mplier(4))) xor c6(2);
	c6(3) <= ((mplier(3) and (not mplier(4))) or ((not mplier(3)) and mplier(4))) and c6(2);

	b(4) <= ((mplier(4) and (not mplier(4))) or ((not mplier(4)) and mplier(4))) xor c6(3);

	p1 <= (a(4) and b(0)) & (a(4) and b(0)) & (a(4) and b(0)) & (a(4) and b(0)) & (a(4) and b(0)) & (a(3) and b(0)) & (a(2) and b(0)) & (a(1) and b(0)) & (a(0) and b(0));
	p2 <= (a(4) and b(1)) & (a(4) and b(1)) & (a(4) and b(1)) & (a(4) and b(1)) & (a(3) and b(1)) & (a(2) and b(1)) & (a(1) and b(1)) & (a(0) and b(1)) & '0';
	p3 <= (a(4) and b(2)) & (a(4) and b(2)) & (a(4) and b(2)) & (a(3) and b(2)) & (a(2) and b(2)) & (a(1) and b(2)) & (a(0) and b(2)) & "00";
	p4 <= (a(4) and b(3)) & (a(4) and b(3)) & (a(3) and b(3)) & (a(2) and b(3)) & (a(1) and b(3)) & (a(0) and b(3)) & "000";
	p5 <= (a(4) and b(4)) & (a(3) and b(4)) & (a(2) and b(4)) & (a(1) and b(4)) & (a(0) and b(4)) & "0000";

	product <= (mcand(4) xor mplier(4)) & c4;
	
end mult;

--test bench
entity testp3 is
end testp3;
architecture test of testp3 is
	signal a,b : bit_vector (4 downto 0);
	signal p : bit_vector (9 downto 0);
	
	component signedmult is
	port(mcand,mplier : in bit_vector (4 downto 0);
	     product : out bit_vector (9 downto 0)
	);
	end component;
	
	begin
	mult : signedmult port map(mcand => a, mplier => b, product => p);

	process is
	begin
	a <= "10110"; --negative 10
	b <= "00100"; --4

	wait for 10 fs;
	a <= "01011"; --11
	b <= "11101"; --negative 3

	wait for 10 fs;
	a <= "10110"; --negative 10
	b <= "10101"; --negative 11

	wait for 10 fs;
	report "simulation finished successfully"
	severity FAILURE;
	end process;

end test;

--9-bit adder
entity add9bit is
	port(x,y : in bit_vector (8 downto 0);
	     z : out bit_vector (8 downto 0)
	);
end add9bit;
architecture add of add9bit is
	signal c : bit_vector (8 downto 0);
	
	begin
	z(0) <= x(0) xor y(0) xor '0';
	c(0) <= (x(0) and y(0)) or (x(0) and '0') or (y(0) and '0');
	
	z(1) <= x(1) xor y(1) xor c(0);
	c(1) <= (x(1) and y(1)) or (x(1) and c(0)) or (y(1) and c(0));
	
	z(2) <= x(2) xor y(2) xor c(1);
	c(2) <= (x(2) and y(2)) or (x(2) and c(1)) or (y(2) and c(1));
	
	z(3) <= x(3) xor y(3) xor c(2);
	c(3) <= (x(3) and y(3)) or (x(3) and c(2)) or (y(3) and c(2));
	
	z(4) <= x(4) xor y(4) xor c(3);
	c(4) <= (x(4) and y(4)) or (x(4) and c(3)) or (y(4) and c(3));
	
	z(5) <= x(5) xor y(5) xor c(4);
	c(5) <= (x(5) and y(5)) or (x(5) and c(4)) or (y(5) and c(4));
	
	z(6) <= x(6) xor y(6) xor c(5);
	c(6) <= (x(6) and y(6)) or (x(6) and c(5)) or (y(6) and c(5));
	
	z(7) <= x(7) xor y(7) xor c(6);
	c(7) <= (x(7) and y(7)) or (x(7) and c(6)) or (y(7) and c(6));
	
	z(8) <= x(8) xor y(8) xor c(7);
	c(8) <= (x(8) and y(8)) or (x(8) and c(7)) or (y(8) and c(7));
end add;
